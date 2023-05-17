process MLST {
    tag "$meta"
  //  publishDir "${params.output_dir}", mode:'copy'

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

process MLST_FORCE {
    tag "$meta"
  //  publishDir "${params.output_dir}", mode:'copy'

    input:
    tuple val(meta), path(fasta)
    val(scheme)

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
	--scheme $scheme \\
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

process COMBINE_MLST_FILES_SPECIES_SPECIFIED {
    publishDir "${params.output_dir}", mode:'copy'
    tag "combine mlst"


    input:
    path(mlst_report_files)
    val(date)
    val(scheme)


    output:
    path("combined_mlst_${scheme}_${date}.txt"), emit: mlst_comb_ch


    script:
    """

    MLST_REPORT_FILES=(${mlst_report_files})
    for index in \${!MLST_REPORT_FILES[@]}; do
    MLST_REPORT_FILE=\${MLST_REPORT_FILES[\$index]}
    awk -v OFS='\\t' 'FNR>=1 { print \$0 }' \${MLST_REPORT_FILE} | sed 's/\\.fasta//g' >> combined_mlst_${scheme}_${date}.txt

    done

    """
}
