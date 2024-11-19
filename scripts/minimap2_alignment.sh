#!/bin/bash

# need to be in a conda environment with minimap2 installed for this to work, made wgs_align for this

# set variable for reference genome and index of it (so can be changed later)
REFERENCE_GENOME_MK="genomes/MK373780_1.fasta"
REFERENCE_INDEX_MK="reference_genome_mk.mmi"

# index the reference genome 
minimap2 -d $REFERENCE_INDEX_MK $REFERENCE_GENOME_MK

# define genomes, including path to folder they are in 
GENOMES=("genomes/OR062524_1.fasta" "genomes/OR062525_1.fasta" "genomes/OR062526_1.fasta" "genomes/OR062527_1.fasta" "genomes/OR062528_1.fasta" "genomes/OR062529_1.fasta" "genomes/OR062530_1.fasta")

# define output directory for PAF files
OUTPUT_DIR="paf_output"
mkdir -p $OUTPUT_DIR


# use for loop to run minimap2 on each genome to align to reference
for PHAGE_GENOME in "${GENOMES[@]}"; do
    # get the base name of the phage genome file 
    BASENAME=$(basename "$PHAGE_GENOME" .fasta)

    # run minimap2 for each phage genome against the reference genome
    minimap2 -a $REFERENCE_INDEX_MK $PHAGE_GENOME > "$OUTPUT_DIR/$BASENAME.paf"

    echo "Alignment of $PHAGE_GENOME complete. Output: $OUTPUT_DIR/$BASENAME.paf"
done


