#!/bin/bash

# Set variables
REFERENCE_GENOME="genomes/MK373780_1.fasta"
REFERENCE_INDEX="reference_genome.mmi"
GENOMES=("genomes/OR062524_1.fasta" "genomes/OR062525_1.fasta" "genomes/OR062526_1.fasta" "genomes/OR062527_1.fasta" "genomes/OR062528_1.fasta" "genomes/OR062529_1.fasta" "genomes/OR062530_1.fasta")

# Index reference
minimap2 -d "$REFERENCE_INDEX" "$REFERENCE_GENOME"

# Align genomes to reference
for PHAGE_GENOME in "${GENOMES[@]}"; do
    BASENAME=$(basename "$PHAGE_GENOME" .fasta)
    OUTPUT_FILE="comparisons/${BASENAME}_vs_reference.paf"
    minimap2 "$REFERENCE_INDEX" "$PHAGE_GENOME" > "$OUTPUT_FILE"
done
