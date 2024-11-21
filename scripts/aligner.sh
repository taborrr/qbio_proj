#!/bin/bash

cd ..

# define reference genome and initialize index file
REFERENCE_GENOME_MK="genomes/MK373780_1.fasta"
REFERENCE_INDEX_MK="genomes/reference_genome_MK.mmi"

# index reference
minimap2 -d "$REFERENCE_INDEX_MK" "$REFERENCE_GENOME_MK"

# define new phage genomes
GENOMES=("genomes/OR062524_1.fasta" "genomes/OR062525_1.fasta" "genomes/OR062526_1.fasta" "genomes/OR062527_1.fasta" "genomes/OR062528_1.fasta" "genomes/OR062529_1.fasta" "genomes/OR062530_1.fasta")

# loop to align each new phage genome to reference
for PHAGE_GENOME in "${GENOMES[@]}"; do
    # extract name from new phage genome file 
    BASENAME=$(basename "$PHAGE_GENOME" .fasta)
    OUTPUT_FILE="comparisons/${BASENAME}_vs_MK.paf"
    # align to reference then output
    minimap2 "$REFERENCE_INDEX_MK" "$PHAGE_GENOME" > "$OUTPUT_FILE"

    echo "Alignment of $PHAGE_GENOME complete. Output: $OUTPUT_FILE"
done


