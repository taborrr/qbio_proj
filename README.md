# Figure Recreation of *Escherichia coli*-infecting Phage Genome Alignments
#### Authors: Izabella and Tabor

![Genome Alignments Figure](https://media.springernature.com/full/springer-static/image/art%3A10.1038%2Fs41598-023-48788-w/MediaObjects/41598_2023_48788_Fig5_HTML.png?as=webp)

## Project Overview
This project aims to reanalyze genome alignment data from figure 5 of the 2023 paper, ["Comparative genomics and proteomics analysis of phages infecting multi-drug resistant *Escherichia coli* O177 isolated from cattle faeces"](https://doi.org/10.1038/s41598-023-48788-w). Our objective is to recreate and modernize phage genome alignments using **MiniMap2** and **ggplot2**, gaining practical experience with genome alignment, visualization techniques, and specialized plotting packages, in order to redetermine which genera these 7 new phages belong.  

## Why?
Bacteria are the most abundant living organisms on Earth, with an estimated **10^30** cells, but viruses outnumber them, being the most abundant biological entities at **10^31**. Viruses have the smallest genomes in the biological world with bottoming out at 2,500 bp, about half a percent (0.4%) the size of the smallest bacterial genome (*Mycoplasma genitalum* 580,000 bp), yet they can lethally infect every organism on Earth, including latops. Studying newly emerged phage genomes through alignments reveals their rapid evolution and helps pinpoint relatedness, guiding more effective interventions against bacterial infections.

```bash
 Viruses
└── Duplodnaviria
    └── Heunggongvirae
        └── Uroviricota
            └── Caudoviricetes
                └── Caudovirales
                |    └── Myoviridae
                |        ├── Stephanstirmvirinae
                |        │   └── Phapecoctavirus
                |        │       ├── Escherichia phage vB_EcoM Hdk5 (MK373780.1)
                |        │       └── [Potential Species Placement]
                |        ├── Tevenvirinae
                |        │   └── Tequatrovirus
                |        │       ├── Escherichia phage vB_EcoM_Schickermooser (NC_048196.1)
                |        │       └── [Potential Species Placement]
                |        └── Vequintavirinae
                |            └── Vequintavirus
                |                ├── Escherichia phage vB_EcoM UFV10 (OP555981.1)
               Class             └── [Potential Species Placement]
                                 |
                                Genera
```
--- 
## Reference Phage Genomes
We will use three phage reference genomes as 3 different genera represenatives for alignment:

1. [**Escherichia phage vB_EcoM Hdk5** (Accession no: MK373780.1)](https://www.ncbi.nlm.nih.gov/nuccore/MK373780.1?report=fasta)

2. [**Escherichia phage vB_EcoM_Schickermooser** (Accession no: NC_048196.1)](https://www.ncbi.nlm.nih.gov/nuccore/NC_048196.1?report=fasta)  

3. [**Escherichia phage vB_EcoM_UFV10** (Accession no: OP555981.1)](https://www.ncbi.nlm.nih.gov/nuccore/OP555981.1?report=fasta)  

## 7 New Phage Genomes for Alignment
We will align seven new phage genomes to each representative genera reference genome:

1. [**Escherichia phage vB_EcoM_3A1_SA_NWU** (Accession no: OR062524.1)](https://www.ncbi.nlm.nih.gov/nuccore/OR062524.1?report=fasta)  

2. [**Escherichia phage vB_EcoM_10C2_SA_NWU** (Accession no: OR062525.1)](https://www.ncbi.nlm.nih.gov/nuccore/OR062525.1?report=fasta)  

3. [**Escherichia phage vB_EcoM_10C3_SA_NWU** (Accession no: OR062526.1)](https://www.ncbi.nlm.nih.gov/nuccore/OR062526.1?report=fasta)  

4. [**Escherichia phage vB_EcoM_11B_SA_NWU** (Accession no: OR062527.1)](https://www.ncbi.nlm.nih.gov/nuccore/OR062527.1?report=fasta)  

5. [**Escherichia phage vB_EcoM_12A_SA_NWU** (Accession no: OR062528.1)](https://www.ncbi.nlm.nih.gov/nuccore/OR062528.1?report=fasta)  

6. [**Escherichia phage vB_EcoM_118_SA_NWU** (Accession no: OR062529.1)](https://www.ncbi.nlm.nih.gov/nuccore/OR062529.1?report=fasta)  

7. [**Escherichia phage vB_EcoM_366V_SA_NWU** (Accession no: OR062530.1)](https://www.ncbi.nlm.nih.gov/nuccore/OR062530.1?report=fasta)  
--- 
## Tools and Software
We will use the following tools for genome alignments and visualizations:
- **[MiniMap2](https://github.com/lh3/minimap2)**: A fast genome alignment tool.
- **[ggplot2](https://ggplot2.tidyverse.org)**: R package for creating graphics.
- **[CIRCOS](http://circos.ca/)** (for potential visualization in circular genome plots).

## Primary Goal
- **Modernize the genome alignment plot** of seven phage genomes to the three genera reference genomes (*vB_EcoM Hdk5*, *vB_EcoM Schickermooser*, and *vB_EcoM UFV10*). Aligning with **MiniMap2** in `bash` and plotting with **ggplot2** in `R`. Align the seven phages to each reference individually to assess how well each new phage genome aligns across genera.  
- **Create a fourth alignment plot** Recapitualting the genera divergence by aligning the three reference genomes to each other.  

## Secondary Goals
- **Develop an interactive dashboard**: Create an online dashboard similar to [this Dash alignment chart](https://dash.gallery/dash-alignment-chart/), where users can hover over genome alignments to view detailed information such as genome positions and mapping quality.
- **Explore visualization using CIRCOS plots**: Represent the genome alignments in a circular plot to determine alignment relationships between the genomes with a different perspective.

## DIY:

1. **Clone the repo virus-wgs-comparison**:
   ```bash
   git clone https://github.com/taborrr/virus-wgs-comparison.git
   cd virus-wgs-comparison
   ```

2. **Download MiniMap2**:
   ```bash
      curl -L https://github.com/lh3/minimap2/releases/download/v2.28/minimap2-2.28_x64-linux.tar.bz2 | tar -jxvf -
   ```
[This is the manual for MiniMap2](https://lh3.github.io/minimap2/minimap2.html)

3. **Perform genome alignments for one reference to the seven new phages**:
   ```bash
   cd scripts
   chmod +x aligner.sh
   ./aligner.sh
   ```

4. **Visualize the alignments in RStudio**
- Open `plot_mk.R` in RStudio
- Run each line

## Next Steps
5. Consider potential to use Plotly-Dash, seglogos, heatmap