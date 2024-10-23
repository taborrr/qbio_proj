#!/bin/bash

# Path to the folder with genome FASTA files
genome_dir="/virus-wgs-comparison/genomes/"
output_dir="/virus-wgs-comparison/comparisons/"

# Perform pairwise alignments with nucmer
for ref in $genome_dir/*.fasta; do
  for query in $genome_dir/*.fasta; do
    if [[ "$ref" < "$query" ]]; then
      ref_base=$(basename "$ref" .fasta)
      query_base=$(basename "$query" .fasta)

      # Run nucmer only for unique pairs (A vs B, but not also for B vs A)
      nucmer --prefix="$output_dir/${ref_base}_vs_${query_base}" "$ref" "$query"
    fi
  done
done
