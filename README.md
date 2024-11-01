# Recreation of *Escherichia coli* O177-infecting Phage Genome Alignments Figure
#### Authors: Izabella and Tabor

![Genome Alignments Figure](https://media.springernature.com/full/springer-static/image/art%3A10.1038%2Fs41598-023-48788-w/MediaObjects/41598_2023_48788_Fig5_HTML.png?as=webp)

## Project Overview
This project aims to reanalyze genome alignment data from figure 5 of the 2023 paper, ["Comparative genomics and proteomics analysis of phages infecting multi-drug resistant *Escherichia coli* O177 isolated from cattle faeces"](https://doi.org/10.1038/s41598-023-48788-w). Our objective is to recreate and modernize the phage genome alignments using **MiniMap2** and **ggplot2**, gaining practical experience with genome alignment, visualization techniques, and specialized plotting packages.

## Reference Phage Genomes
We will use these three reference phage genomes for alignment:

1. **Escherichia phage vB_EcoM Hdk5** (Accession no: MK373780.1)  
   [FASTA Link](https://www.ncbi.nlm.nih.gov/nuccore/MK373780.1?report=fasta)
   
2. **Escherichia phage vB_EcoM_Schickermooser** (Accession no: NC_048196.1)  
   [FASTA Link](https://www.ncbi.nlm.nih.gov/nuccore/NC_048196.1?report=fasta)

3. **Escherichia phage vB_EcoM UFV10** (Accession no: OP555981.1)  
   [FASTA Link](https://www.ncbi.nlm.nih.gov/nuccore/OP555981.1?report=fasta)

## Phage Genomes for Alignment
We will align the following seven phage genomes from three genera to their respective reference genome:

1. **Escherichia phage vB_EcoM_3A1_SA_NWU**, complete genome  
   [FASTA Link](https://www.ncbi.nlm.nih.gov/nuccore/OR062524.1?report=fasta)
   
2. **Escherichia phage vB_EcoM_10C2_SA_NWU**, complete genome  
   [FASTA Link](https://www.ncbi.nlm.nih.gov/nuccore/OR062525.1?report=fasta)

3. **Escherichia phage vB_EcoM_10C3_SA_NWU**, complete genome  
   [FASTA Link](https://www.ncbi.nlm.nih.gov/nuccore/OR062526.1?report=fasta)

4. **Escherichia phage vB_EcoM_11B_SA_NWU**, complete genome  
   [FASTA Link](https://www.ncbi.nlm.nih.gov/nuccore/OR062527.1?report=fasta)

5. **Escherichia phage vB_EcoM_12A_SA_NWU**, complete genome  
   [FASTA Link](https://www.ncbi.nlm.nih.gov/nuccore/OR062528.1?report=fasta)

6. **Escherichia phage vB_EcoM_118_SA_NWU**, complete genome  
   [FASTA Link](https://www.ncbi.nlm.nih.gov/nuccore/OR062529.1?report=fasta)

7. **Escherichia phage vB_EcoM_366V_SA_NWU**, complete genome  
   [FASTA Link](https://www.ncbi.nlm.nih.gov/nuccore/OR062530.1?report=fasta)

## Tools and Software
We will use the following tools for genome alignments and visualizations:
- **[MiniMap2](https://github.com/lh3/minimap2)**: A fast genome alignment tool.
- **[ggplot2](https://ggplot2.tidyverse.org)**: R package for creating graphics.
- **[CIRCOS](http://circos.ca/)** (for potential visualization in circular genome plots).

## Primary Goal
- **Modernize the genome alignment** of seven phage genomes to the three reference genomes (*vB_EcoM Hdk5*, *vB_EcoM Schickermooser*, and *vB_EcoM UFV10*) from different genera. Align the seven phages to each reference individually to assess how well each phage genome aligns across genera.  
- **Create a fourth alignment plot** comparing how the three reference genomes align to each other.  
- **Visualize the results** by creating alignment plots.

## Secondary Goals
- **Develop an interactive dashboard**: Create an online dashboard similar to [this Dash alignment chart](https://dash.gallery/dash-alignment-chart/), where users can hover over genome alignments to view detailed information such as genome positions and mapping quality.
- **Explore visualization using CIRCOS plots**: Represent the genome alignments in a circular plot to determine alignment relationships between the genomes with a different perspective.

## Project Setup
To set up the environment for the project:

1. **Create a working directory with a subfolder**:
   ```bash
   mkdir ~/virus
   cd ~/virus
   mkdir genomes
   mkdir comparisons
   mkdir scripts
   ```

2. **Create a conda environment for MiniMap2**:
   ```bash
      conda create -n wgs_align -y && \
      conda activate wgs_align && \
      conda config --env --add channels bioconda && \
      conda install -y python=3.8 bioconda::minimap2
   ```

   For more MiniMap2 info, go to the manual:
   ```bash
   https://lh3.github.io/minimap2/minimap2.html
   ```

## Next Steps
1. Download the reference and query phage genomes to the subfolder.
2. Perform genome alignments using Minimap2.
3. Visualize the alignments within R using ggplot.
4. Consider potential to use Plotly-Dash

