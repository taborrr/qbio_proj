# Phage Genome Alignment Visualization
# for the virus-wgs-comparison project

# library
install.packages("pafr")
library(ggplot2)
library(dplyr)
library(pafr)
library(paletteer)

setwd("~/virus-wgs-comparison")
getwd()
dir()



##################################################################
##################################################################
##################################################################


# For tequatrovirus

# Read in 6 PAF files into labeled data frames
paf1 <- read.table("comparisons/OR062524_1_vs_NC.paf")
paf2 <- read.table("comparisons/OR062525_1_vs_NC.paf")
paf3 <- read.table("comparisons/OR062526_1_vs_NC.paf") # no paf4 data alignments
paf5 <- read.table("comparisons/OR062528_1_vs_NC.paf")
paf6 <- read.table("comparisons/OR062529_1_vs_NC.paf")
paf7 <- read.table("comparisons/OR062530_1_vs_NC.paf")
paf_list <- list(paf1, paf2, paf3, paf5, paf6, paf7)
for (i in seq_along(paf_list)) {
  colnames(paf_list[[i]]) <- c(
    "seq_id", "length", "start", "end", "strand", "seq_id2",
    "length2", "start2", "end2", "map_match", "map_length",
    "map_quality", "tp", "cm", "s1", "s2", "dv", "rl")
}
# for reference 
colnames(paf1) <- c(
  "seq_id", "length", "start", "end", "strand", "seq_id2",
  "length2", "start2", "end2", "map_match", "map_length",
  "map_quality", "tp", "cm", "s1", "s2", "dv", "rl")

# Extract lengths and genome names
query_lengths <- sapply(paf_list, function(paf) paf$length[1])  # Query genome lengths
query_names <- sapply(paf_list, function(paf) paf$seq_id[1])   # Query genome names
reference_length <- paf1$length2[1]                           # Reference genome length
reference_name <- paf1$seq_id2[1]                             # Reference genome name

# Make more streamlined df
alignments <- lapply(paf_list, function(paf) {
  data.frame(
    query_name = paf$seq_id,
    query_start = paf$start,
    query_end = paf$end,
    ref_start = paf$start2,
    ref_end = paf$end2
  )
})

# Assign y-axis positions (1 to 13, odd values for phage genomes, 15 for reference genome)
y_positions <- seq(1, by = 2, length.out = 6)

# Create plotting data for rectangles
# Full length rectangles of the query genomes
query_rectangles <- data.frame(
  name = query_names,
  start = 0,
  end = query_lengths,
  y = y_positions
)

# Alignment-block rectangle lengths for each alignment in each paf
align_rects <- do.call(rbind, lapply(seq_along(alignments), function(i) {
  data.frame(
    query_name = alignments[[i]]$query_name,
    start = alignments[[i]]$query_start,
    end = alignments[[i]]$query_end,
    y = y_positions[i],
    r_start = alignments[[i]]$ref_start,
    r_end = alignments[[i]]$ref_end
  )
}))

# Assign Inferno colors for 10kb intervals on the reference genome
interval_size <- 10000  # 10 kb intervals
num_intervals <- ceiling(reference_length / interval_size)
color_palette <- paletteer_c("grDevices::Inferno", num_intervals)

# Create reference intervals and assign colors, and manually add position and length
ref_intervals <- data.frame(
  start = seq(0, reference_length, by = interval_size),
  end = seq(interval_size, reference_length + interval_size, by = interval_size),
  color = rep(color_palette, length.out = num_intervals)
)
ref_intervals$y <- 13
ref_intervals$end[nrow(ref_intervals)] <- reference_length

#############################################################
#############################################################
# Function to split a row into multiple rows based on the 10000 boundary in the reference frame
split_intervals <- function(query_name, start, end, y_val, r_start, r_end) {
  intervals <- data.frame()
  print(paste("Processing:", query_name, start, end, y_val, r_start, r_end))
  while (r_start < r_end) {
    # Find the next 10000 multiple boundary
    next_boundary <- ceiling(r_start / 10000) * 10000
    print(paste("Current r_start:", r_start, "Next boundary:", next_boundary, "r_End:", r_end))
    if (next_boundary == r_start) {
      next_boundary <- ceiling((r_start+0.0001) / 10000) * 10000
    }
    if (next_boundary >= r_end) {
      next_boundary <- r_end
    }
    # Append the interval, modifying query range accordingly
    new_row <- data.frame(
      query_names = query_name,
      start = start,
      end = (start + (next_boundary - r_start)),
      y = y_val,
      r_start = r_start,
      r_end = next_boundary
    )
    intervals <- rbind(intervals, new_row)
    # Update starts for the next interval
    r_start <- next_boundary + 0.0001
    start <- new_row$end + 0.0001
  }
  return(intervals)
}
#############################################################
#############################################################
# Now running the real data frame
new_align_rects <- data.frame()
for (i in 1:nrow(align_rects)) {
  print(paste("Processing row", i))
  row <- align_rects[i, ]
  split_rows <- split_intervals(row$query_name, row$start, row$end, row$y, row$r_start, row$r_end)
  new_align_rects <- rbind(new_align_rects, split_rows)
}
##################################################################
##################################################################
# add color to query segments based on reference interval overlap
new_align_rects$color <- 0
for (i in 1:nrow(new_align_rects)) {
  arow <- new_align_rects[i, ]
  what_color_is_this_number <- arow$r_start
  print(what_color_is_this_number)
  for (t in 1:nrow(ref_intervals)) {
    rrow <- ref_intervals[t, ]
    print(paste(rrow$start, rrow$end, rrow$color))
    if (what_color_is_this_number > rrow$start && what_color_is_this_number <= rrow$end) {
      #arow$color <- rrow$color
      new_align_rects[i,"color"] <- rrow$color
      break
    }
  }
}
##################################################################
##################################################################
# PLOTTING

# include reference and genera label into a df
ref_genera <- data.frame(
  name = "Genus: Tequatrovirus", # Phapecoctavirus Tequatrovirus Vequintavirus
  start = 0,
  end = 0,
  y = 13)
query_rectangles <- rbind(query_rectangles, ref_genera)

# Plotting the alignments 
plotme <- ggplot() +
  # Plot genome rectangles
  geom_rect(
    data = query_rectangles,
    aes(xmin = start, xmax = end, ymin = y - 0.4, ymax = y + 0.4),
    fill = "lightgray",
    color = NA
  ) +
  # Overlay alignment rectangles with colors based on reference range
  geom_rect(
    data = new_align_rects,
    aes(xmin = start, xmax = end, ymin = y - 0.3, ymax = y + 0.3, fill = color),
    color = NA
  ) +
  # Plot 10kb intervals on the reference genome
  geom_rect(
    data = ref_intervals,
    aes(xmin = start, xmax = end, ymin = y - 0.4, ymax = y + 0.4, fill = color),
    color = NA
  ) +
  scale_fill_identity() +  # Use colors directly
  # Add genome labels
  geom_text(
    data = query_rectangles,
    aes(x = start, y = y, label = name),
    hjust = -0.1,
    vjust = -1.5,
    size = 3.5
  ) +
  #scale_x_continuous(breaks = c(0, 50000, 100000, 150000), labels = c("0", "50,000", "100,000", "150,000")) + #wdyThink?
  scale_y_continuous(breaks = NULL) +
  labs(
    x = "genomic position (bp)",
    y = NULL
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank()
  )

plotme

# Saving plots
ggsave("plots/tequatrovirus.jpg", plot = plotme, device = "jpeg", width = 7, height = 4.5, dpi = 300)

