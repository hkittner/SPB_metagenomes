

Directory Structure

.
|-- FASTQ                       # raw data
|-- SBB_metagenomes             # Santa Barbara Basin data
|   |-- chloroflexota_bins
|   `-- scripts
|-- adapters                    # Adapter database
|-- all_bins_analyses           # At the moment, this is where I'll copy bins over to, but this will change
|   |-- A02_01
|   `-- S4_04
|-- assembly_A_analysis         # DNA from each sample was extracted twice. This is analysis of the metagenome of replicate A only
|   |-- assemblies
|   `-- bins
|-- assembly_B_analysis         # This is the analysis of the metagenome of replicate B only
|   |-- assemblies
|   `-- bins
|-- coassembly_analysis         # Analysis of the coassembly of replicates A and B
|   |-- assemblies
|   `-- bins
|-- databases                   # Databases used in bioinformatic analyses
|   |-- MY_CHECKM_FOLDER
|   |-- NCBI_nt
|   |-- NCBI_tax
|   |-- gtdbtk
|   |-- kofam_database
|   |-- pfam_database
|   |-- silva
|   |-- tigrfam_database
|   `-- univec
|-- fastqc_output               # Quality checks on raw reads 
|-- metagenome_culture          # Trichodesmium culture metagenome
|-- particle_trap_16S           # SBB particle trap 16S data
|   `-- FASTQ
|-- raw_metagenomes             # untouched file from Davis sequencing center including FASTQ files
|-- rdhA                        # rdhA specific analyses
|   |-- A02_01_hmmer_results
|   |-- S4_04_hmmer_results
|   `-- rdhA_sequences
|-- scripts                     # All the scripts   
|   |-- old_slurms
|   `-- trimmomatic_scripts
|-- subsample_analysis          # Analyses done on one lane of both replicates (1/4 of the total data) in order to get cleaner high abundance MAGs     
|   |-- assemblies      
|   `-- bins
`-- trimmomatic_output          # Trimmed reads output   
