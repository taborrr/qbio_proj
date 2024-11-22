# Phage Genome Alignment Visualization
# for the virus-wgs-comparison project

# library
#install.packages("pafr")     # For parsing PAF files
#install.packages("gggenomes") # For genome visualization
library(pafr)
library(gggenomes)
library(ggplot2)
library(dplyr)

setwd("~/virus-wgs-comparison")
getwd()
dir()


# Read all PAF files
paf_files <- list.files(path = "comparisons", pattern = "*.paf", full.names = TRUE)
readLines(paf_files[1], n = 5)
# Read all PAF files
paf_data <- lapply(paf_files, function(file) pafr::read_paf(file))


# Combine into a single data frame
all_paf <- do.call(rbind, paf_data)
head(all_paf)
# Calculate sequence identity
all_paf$identity <- (all_paf$nmatch / all_paf$alen) * 100
alignment_blocks <- all_paf[, c("qname", "qstart", "qend", 
                                "tname", "tstart", "tend", 
                                "identity")]


# visualize
# Create genome objects from PAF data
query_genomes <- unique(all_paf$qname)
target_genome <- unique(all_paf$tname)

# Create a gggenomes object
synteny_plot <- gggenomes(
  sequences = list(query = query_genomes, target = target_genome),
  links = alignment_blocks
)

# Customize colors by conservation
synteny_plot + 
  geom_link(aes(fill = block_identity), color = "gray", alpha = 0.8) +
  theme_minimal() +
  labs(title = "Synteny Visualization of Phage Genomes", 
       x = "Genomic Coordinates", y = "Sequences")


# alternate viz
# Plot synteny using pafr
plot_synteny(paf_data)









########################################
########################################
########################################


# read in PAF files (assuming one header per alignment block)
alignment <- read.table("paf_output/OR062524_1.paf", header = FALSE)
alignment <- read.table("comparisons/OR062524_1_vs_MK.paf", header = FALSE)

## Error in scan(file = file, what = what, sep = sep, quote = quote, dec = dec,  : 
## line 1 did not have 22 elements


# Inspect the alignment data
head(alignment)


# Plot alignment blocks between reference and query genomes
ggplot(alignment, aes(x = V8, xend = V9, y = V3, yend = V4)) +
# geom_rect was intially recommended
  geom_segment(color = "blue", linewidth = 1) +
  labs(title = "Genome Alignment between OR062524.1 and NC_048196.1",
       x = "Reference Genome Position (NC_048196.1)",
       y = "Query Genome Position (OR062524.1)") +
  theme_minimal()
