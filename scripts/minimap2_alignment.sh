#!/bin/bash

conda activate wgs_align

# define reference genome and initialize index file
REFERENCE_GENOME_MK="genomes/MK373780_1.fasta"
REFERENCE_INDEX_MK="genomes/reference_genome_mk.mmi"

# index the reference genome 
minimap2 -d "$REFERENCE_INDEX_MK" "$REFERENCE_GENOME_MK"

# define new phage genomes 
GENOMES=("genomes/OR062524_1.fasta" "genomes/OR062525_1.fasta" "genomes/OR062526_1.fasta" "genomes/OR062527_1.fasta" "genomes/OR062528_1.fasta" "genomes/OR062529_1.fasta" "genomes/OR062530_1.fasta")

# define output directory for PAF files
OUTPUT_DIR="paf_output"

# loop aligning to reference
for PHAGE_GENOME in "${GENOMES[@]}"; do
    # extract name from new phage genome file  
    BASENAME=$(basename "$PHAGE_GENOME" .fasta)

    # align to reference then output
    minimap2 -a "$REFERENCE_INDEX_MK" "$PHAGE_GENOME" > "$OUTPUT_DIR/$BASENAME.paf"

    echo "Alignment of $PHAGE_GENOME complete. Output: $OUTPUT_DIR/$BASENAME.paf"
done


