# Phage Genome Alignment Visualization
# for the virus-wgs-comparison project

# library
library(ggplot2)
library(dplyr)
library(pafr)


setwd("~/virus-wgs-comparison")
getwd()
dir()

# Task 1: Read in 7 PAF files
paf1 <- read_paf("comparisons/OR062524_1_vs_MK.paf")
paf2 <- read_paf("comparisons/OR062525_1_vs_MK.paf")
paf3 <- read_paf("comparisons/OR062526_1_vs_MK.paf")
# Read PAF4 manually since it has only one entry
paf4_raw <- read.table("comparisons/OR062527_1_vs_MK.paf", sep = "\t", header = FALSE, stringsAsFactors = FALSE)
# Adjust columns 13-18 to retain only characters after the final colon
paf4_raw[, 13:18] <- lapply(paf4_raw[, 13:18], function(x) {sub(".*:", "", x)})
# Rename columns to expected names
colnames(paf4_raw) <- c(
  "seq_id", "length", "start", "end", "strand", "seq_id2",
  "length2", "start2", "end2", "map_match", "map_length",
  "map_quality", "tp", "cm", "s1", "s2", "dv", "rl")
paf4 <- paf4_raw
paf5 <- read_paf("comparisons/OR062528_1_vs_MK.paf")
paf6 <- read_paf("comparisons/OR062529_1_vs_MK.paf")
paf7 <- read_paf("comparisons/OR062530_1_vs_MK.paf")

# Store all PAFs in a list for easier processing
paf_list <- list(paf1, paf2, paf3, paf4, paf5, paf6, paf7)

# Task 2: Extract lengths and genome names
query_lengths <- sapply(paf_list, function(paf) paf$length[1])  # Query genome lengths
query_names <- sapply(paf_list, function(paf) paf$seq_id[1])   # Query genome names
reference_length <- paf1$length2[1]                           # Reference genome length
reference_name <- paf1$seq_id2[1]                             # Reference genome name

# Task 3: Prepare alignment data
alignments <- lapply(paf_list, function(paf) {
  data.frame(
    query_name = paf$seq_id,
    query_start = paf$start,
    query_end = paf$end,
    ref_start = paf$start2,
    ref_end = paf$end2
  )
})

# Assign y-axis positions (1 to 15, odd values for phage genomes, 15 for reference genome)
y_positions <- seq(1, by = 2, length.out = 8)

# Task 4: Create plotting data for rectangles
# Query genome rectangles
query_rectangles <- data.frame(
  name = c(query_names, reference_name),
  start = 0,
  end = c(query_lengths, reference_length),
  y = y_positions
)

# Alignment rectangles for each PAF
alignment_rectangles <- do.call(rbind, lapply(seq_along(alignments), function(i) {
  data.frame(
    query_name = alignments[[i]]$query_name,
    start = alignments[[i]]$query_start,
    end = alignments[[i]]$query_end,
    y = y_positions[i]
  )
}))

# Plotting
ggplot() +
  # Plot genome rectangles
  geom_rect(
    data = query_rectangles,
    aes(xmin = start, xmax = end, ymin = y - 0.4, ymax = y + 0.4, fill = name),
    color = "black",
    alpha = 0.5
  ) +
  # Overlay alignment rectangles
  geom_rect(
    data = alignment_rectangles,
    aes(xmin = start, xmax = end, ymin = y - 0.3, ymax = y + 0.3, fill = query_name),
    color = "black"
  ) +
  # Adjust labels and formatting
  scale_y_continuous(breaks = y_positions, labels = c(query_names, reference_name)) +
  labs(
    title = "Genome Alignments with Reference",
    x = "Genomic Position",
    y = "Genomes"
  ) +
  theme_minimal()

