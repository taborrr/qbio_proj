#!/bin/bash

# Path to the folder with genome FASTA files
genome_dir="/virus-wgs-comparison/genomes/"
output_dir="/virus-wgs-comparison/comparisons/"

# Perform pairwise alignments with minimap2
for ref in $genome_dir/*.fasta; do
  for query in $genome_dir/*.fasta; do
    if [[ "$ref" < "$query" ]]; then
      ref_base=$(basename "$ref" .fasta)
      query_base=$(basename "$query" .fasta)

      # Run minimap2 only for unique pairs (A vs B, not B vs A)
      minimap2 -x asm20 -a "$ref" "$query" > "$output_dir/${ref_base}_vs_${query_base}.paf"
    fi
  done
done
