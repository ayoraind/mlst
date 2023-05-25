params.assemblies = 'assemblies/*.fasta'
params.output_dir = 'output_dir'
params.sequencing_date = 'GYYMMDDx'

process MLST {
    tag "$meta"
  //  publishDir "${params.output_dir}", mode:'copy'
    
    conda "bioconda::mlst=2.19.0"
    
    input:
    tuple val(meta), path(fasta)

    output:
    path("*.tsv"),                 emit: tsv_ch
    path "versions.yml",           emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta}"
    """
    mlst \\
        $args \\
        --threads $task.cpus \\
        $fasta \\
        > ${prefix}.tsv
    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        mlst: \$( echo \$(mlst --version 2>&1) | sed 's/mlst //' )
    END_VERSIONS
    """

}

process COMBINE_MLST_FILES {
    publishDir "${params.output_dir}", mode:'copy'
    tag "combine mlst"


    input:
    path(mlst_report_files)
    val(date)


    output:
    path("combined_mlst_${date}.txt"), emit: mlst_comb_ch


    script:
    """
    
    MLST_REPORT_FILES=(${mlst_report_files})
    for index in \${!MLST_REPORT_FILES[@]}; do
    MLST_REPORT_FILE=\${MLST_REPORT_FILES[\$index]}
    awk -v OFS='\\t' 'FNR>=1 { print \$0 }' \${MLST_REPORT_FILE} | sed 's/\\.fasta//g' >> combined_mlst_${date}.txt
    
    done
    
    """
}

workflow  {
          
          assemblies_ch = channel
                                .fromPath( params.assemblies, checkIfExists: true )
                                .map { file -> tuple(file.simpleName, file) }
				.ifEmpty { error "Cannot find any assemblies matching: ${params.assemblies}" }

         MLST(assemblies_ch)
	 
	collected_mlst_ch = MLST.out.tsv_ch.collect( sort: {a, b -> a[0].getBaseName() <=> b[0].getBaseName()} )
	
	COMBINE_MLST_FILES(collected_mlst_ch, params.sequencing_date)
         

}
