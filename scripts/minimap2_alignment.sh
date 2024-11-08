#!/bin/bash

# download and install minimap2
curl -L https://github.com/lh3/minimap2/releases/download/v2.28/minimap2-2.28_x64-linux.tar.bz2 | tar -jxvf -
./minimap2-2.28_x64-linux/minimap2

# download genome files to align


# index the reference genome 
minimap2 -d reference_genome.mmi reference_genome.fasta

# define indexed reference genome variable
reference_index = ".mmi"

# define genomes
genomes = (".fasta", ".fasta" )

# define output directory for PAF files
OUTPUT_DIR = "paf_output"
mkdir -p $OUTPUT_DIR


# use for loop to run minimap2 on each genome to align to reference
for phage_genome in "${genomes[@]}"; do
