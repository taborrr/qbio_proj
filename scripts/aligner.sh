#!/bin/bash

cd ..

# define reference genome and initialize its index
REFERENCE_GENOME="genomes/MK373780_1.fasta"
REFERENCE_INDEX="genomes/reference_genome_MK.mmi"
# REFERENCE_GENOME="genomes/NC_048196_1.fasta"
# REFERENCE_INDEX="genomes/reference_genome_nc.mmi"
# REFERENCE_GENOME="genomes/OP555981_1.fasta"
# REFERENCE_INDEX="genomes/reference_genome_op.mmi"


# index reference
minimap2 -d "$REFERENCE_INDEX" "$REFERENCE_GENOME"

# define new phage genomes
GENOMES=("genomes/OR062524_1.fasta" "genomes/OR062525_1.fasta" "genomes/OR062526_1.fasta" "genomes/OR062527_1.fasta" "genomes/OR062528_1.fasta" "genomes/OR062529_1.fasta" "genomes/OR062530_1.fasta")

# loop to align each new phage genome to reference
for PHAGE_GENOME in "${GENOMES[@]}"; do
    # extract name from new phage genome file 
    BASENAME=$(basename "$PHAGE_GENOME" .fasta)
    OUTPUT_FILE="comparisons/${BASENAME}_vs_MK.paf"   # change vs_<ref_abbreviation: MK NC OP>!!!!
    # align to reference then output
    minimap2 "$REFERENCE_INDEX" "$PHAGE_GENOME" > "$OUTPUT_FILE"

    echo "Alignment of $PHAGE_GENOME complete. Output: $OUTPUT_FILE"
done


