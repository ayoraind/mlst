include { check_mandatory_parameter; check_parameter_value } from './params_utilities.nf'

def default_params(){
    /***************** Setup inputs and channels ************************/
    def params = [:] as nextflow.script.ScriptBinding$ParamsMap
    // Defaults for configurable variables
    params.help = false
    params.version = false
    params.assemblies = false
    params.sequencing_date = false
    params.mlst_species = false
    params.scheme = false
    params.output_dir = false
    return params
}

def check_params(Map params) { 
    final_params = params
    
    // set up reads files
    final_params.assemblies = check_mandatory_parameter(params, 'assemblies')
     
    // set up output directory
    final_params.output_dir = check_mandatory_parameter(params, 'output_dir') - ~/\/$/
     
    // set up sequencing date
    final_params.sequencing_date = check_mandatory_parameter(params, 'sequencing_date')
    
    // set up scheme
    final_params.scheme = params.scheme
    
    // set up species
    final_params.mlst_species = params.mlst_species
    
    // check species is valid
    final_params.mlst_species = check_parameter_value('species', final_params.mlst_species, ['ranatipestifer', 'mcatarrhalis', 'aphagocytophilum', 'afumigatus', 'slugdunensis', 'mmassiliense', 'cbotulinum', 'bordetella', 'efaecium', 'mhyopneumoniae', 'otsutsugamushi', 'mhaemolytica', 'senterica', 'bbacilliformis', 'plarvae', 'koxytoca', 'chlamydiales', 'streptomyces', 'msynoviae', 'cglabrata', 'sepidermidis', 'pmultocida_rirdc', 'bcereus', 'soralis', 'sgallolyticus', 'kkingae', 'efaecalis', 'hparasuis', 'csepticum', 'mabscessus', 'tvaginalis', 'shominis', 'orhinotracheale', 'yruckeri', 'bhampsonii', 'shaemolyticus', 'sinorhizobium', 'saureus', 'bpilosicoli', 'sthermophilus', 'leptospira_2', 'kseptempunctata', 'xfastidiosa', 'sbsec', 'ctropicalis', 'kaerogenes', 'lmonocytogenes', 'vibrio', 'clari', 'ssuis', 'miowae', 'csinensis', 'ecoli', 'leptospira_3', 'ecoli_2', 'bhenselae', 'cfetus', 'cfreundii', 'spneumoniae', 'mhyorhinis', 'legionella_sbt', 'leptospira', 'hinfluenzae', 'chyointestinalis', 'magalactiae', 'calbicans', 'bintermedia', 'cdiphtheriae', 'smaltophilia', 'szooepidemicus', 'bcc', 'campylobacter', 'cupsaliensis', 'bhyodysenteriae', 'hpylori', 'cconcisus', 'sagalactiae', 'pgingivalis', 'bpseudomallei', 'chelveticus', 'tenacibaculum', 'scanis', 'csputorum', 'mplutonius', 'pacnes', 'hsuis', 'kpneumoniae', 'pdamselae', 'brachyspira', 'yersinia', 'wolbachia', 'cinsulaenigrae', 'mpneumoniae', 'arcobacter', 'vtapetis', 'taylorella', 'vvulnificus', 'sdysgalactiae', 'abaumannii_2', 'blicheniformis', 'sthermophilus_2', 'edwardsiella', 'mcaseolyticus', 'fpsychrophilum', 'dnodosus', 'mcanis', 'cdifficile', 'mbovis', 'pmultocida_multihost', 'brucella', 'spyogenes', 'paeruginosa', 'spseudintermedius', 'cmaltaromaticum', 'vparahaemolyticus', 'ppentosaceus', 'lsalivarius', 'vcholerae', 'cronobacter', 'pfluorescens', 'aeromonas', 'ecloacae', 'ckrusei', 'neisseria', 'achromobacter', 'borrelia', 'abaumannii', 'ypseudotuberculosis', 'bsubtilis', 'hcinaedi', 'suberis', 'clanienae', ''])
    
    return final_params
}

