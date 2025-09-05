# Project overview
This repo contains scripts and workflows for analyzing San Pedro Basin metagenomes.

# Repo organization
Scripts for all workflows are in the Scripts directory. Up to 4 different assemblies are done for each sample, and the assemblies and bins for each type of assembly (coassembly (all data for both replicates), individual replicates (A or B), or subsampled coassembly (1/4 of data)) have their own directories. 

## Directory Structure
```text
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

```
## Dependencies / Environment
* fastqc
* trimmomatic
* megahit
* CheckM
* GTDB-Tk
* phyloFlash

# Progress / To-Do
- [x] Week 1 (Aug 25-29): Repo setup, README, .gitignore
- [ ] Week 2 (Sept 1-5): CheckM QC + MAG stats
- [ ] Week 3 (Sept 8-12): Annotations
