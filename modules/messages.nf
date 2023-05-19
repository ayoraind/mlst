def help_message() {
  log.info """
        Usage:
        The typical command for running the pipeline is as follows:
        nextflow run main.nf --assemblies "PathToassemblyFile(s)" --output_dir "PathToOutputDir" --sequencing_date "GYYMMDD" 

        Mandatory arguments:
         --assemblies                   Assembly file(s) you wish to supply as input (e.g., "/MIGE/01_DATA/03_ASSEMBLY/T055-8-G230101_FLYE/*.fasta")
         --output_dir                   Output directory to place final combined MLST output (e.g., "/MIGE/01_DATA/03_ASSEMBLY")
         --sequencing_date              Sequencing Date (for TAPIR, must start with G e.g., "G230223")
	
	Optional arguments:
	 --scheme			For forcing a specific mlst scheme (Default: False). If true, simply supply --scheme as part of the arguments
	 --mlst_species                 Used only if the optional argument --scheme is used to force a particular mlst scheme. This must be one of
                                                abaumannii
                                                ranatipestifer 
						mcatarrhalis 
						aphagocytophilum 
						afumigatus 
						slugdunensis 
						mmassiliense 
						cbotulinum 
						bordetella 
						efaecium 
						mhyopneumoniae 
						otsutsugamushi 
						mhaemolytica 
						senterica 
						bbacilliformis 
						plarvae 
						koxytoca 
						chlamydiales 
						streptomyces 
						msynoviae 
						cglabrata 
						sepidermidis 
						pmultocida_rirdc 
						bcereus 
						soralis 
						sgallolyticus 
						kkingae 
						efaecalis 
						hparasuis 
						csepticum 
						mabscessus 
						tvaginalis 
						shominis 
						orhinotracheale 
						yruckeri 
						bhampsonii 
						shaemolyticus 
						sinorhizobium 
						saureus 
						bpilosicoli 
						sthermophilus 
						leptospira_2 
						kseptempunctata 
						xfastidiosa 
						sbsec 
						ctropicalis 
						kaerogenes 
						lmonocytogenes 
						vibrio 
						clari 
						ssuis 
						miowae 
						csinensis 
						ecoli 
						leptospira_3 
						ecoli_2 
						bhenselae 
						cfetus 
						cfreundii 
						spneumoniae 
						mhyorhinis 
						legionella_sbt 
						leptospira 
						hinfluenzae 
						chyointestinalis 
						magalactiae 
						calbicans 
						bintermedia 
						cdiphtheriae 
						smaltophilia 
						szooepidemicus 
						bcc 
						campylobacter 
						cupsaliensis 
						bhyodysenteriae 
						hpylori 
						cconcisus 
						sagalactiae 
						pgingivalis 
						bpseudomallei 
						chelveticus 
						tenacibaculum 
						scanis 
						csputorum 
						mplutonius 
						pacnes 
						hsuis 
						kpneumoniae 
						pdamselae 
						brachyspira 
						yersinia 
						wolbachia 
						cinsulaenigrae 
						mpneumoniae 
						arcobacter 
						vtapetis 
						taylorella 
						vvulnificus 
						sdysgalactiae 
						abaumannii_2 
						blicheniformis 
						sthermophilus_2 
						edwardsiella 
						mcaseolyticus 
						fpsychrophilum 
						dnodosus 
						mcanis 
						cdifficile 
						mbovis 
						pmultocida_multihost 
						brucella 
						spyogenes 
						paeruginosa 
						spseudintermedius 
						cmaltaromaticum 
						vparahaemolyticus 
						ppentosaceus 
						lsalivarius 
						vcholerae 
						cronobacter 
						pfluorescens 
						aeromonas 
						ecloacae 
						ckrusei 
						neisseria 
						achromobacter 
						borrelia 
						abaumannii 
						ypseudotuberculosis 
						bsubtilis 
						hcinaedi 
						suberis 
						clanienae
						
	

         --help                         This usage statement.
         --version                      Version statement
        """
}


def version_message(String version) {
      println(
            """
            ========================================
             TAPIR MLST Pipeline version ${version}
            ========================================
            """.stripIndent()
        )

}


def pipeline_start_message(String version, Map params){
    log.info "======================================================================"
    log.info "                  TAPIR MLST Pipeline version ${version}"
    log.info "======================================================================"
    log.info "Running version   : ${version}"
    log.info ""
    log.info "-------------------------- Other parameters --------------------------"
    params.sort{ it.key }.each{ k, v ->
        if (v){
            log.info "${k}: ${v}"
        }
    }
    log.info "======================================================================"
    log.info "Outputs written to path '${params.output_dir}'"
    log.info "======================================================================"
    
    log.info ""
}


def complete_message(Map params, nextflow.script.WorkflowMetadata workflow, String version){
    // Display complete message
    log.info ""
    log.info "Ran the workflow: ${workflow.scriptName} ${version}"
    log.info "Command line    : ${workflow.commandLine}"
    log.info "Completed at    : ${workflow.complete}"
    log.info "Duration        : ${workflow.duration}"
    log.info "Success         : ${workflow.success}"
    log.info "Work directory  : ${workflow.workDir}"
    log.info "Exit status     : ${workflow.exitStatus}"
    log.info ""
}

def error_message(nextflow.script.WorkflowMetadata workflow){
    // Display error message
    log.info ""
    log.info "Workflow execution stopped with the following message:"
    log.info "  " + workflow.errorMessage
}
