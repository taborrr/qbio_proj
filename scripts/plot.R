# Phage Genome Alignment Visualization
# for the virus-wgs-comparison project

# library
library(ggplot2)
library(dplyr)

setwd("~/virus-wgs-comparison")
getwd()
dir()

# pafs

f <- c("OR062524_1.paf,	OR062525_1.paf,	
        OR062526_1.paf,	OR062527_1.paf,	
        OR062528_1.paf,	OR062529_1.paf,	
        OR062530_1.paf")

#####################################################
########## testing with first aligned paf ###########
#####################################################

# read in PAF files (assuming one header per alignment block)
alignment <- read.table("paf_output/OR062524_1.paf", header = FALSE)
## Error in scan(file = file, what = what, sep = sep, quote = quote, dec = dec,  : 
## line 1 did not have 22 elements


# Inspect the alignment data
head(alignment)


# Plot alignment blocks between reference and query genomes
ggplot(alignment, aes(x = V8, xend = V9, y = V3, yend = V4)) +
# geom_rect was intially recommended
  geom_segment(color = "blue", size = 1) +
  labs(title = "Genome Alignment between OR062524.1 and NC_048196.1",
       x = "Reference Genome Position (NC_048196.1)",
       y = "Query Genome Position (OR062524.1)") +
  theme_minimal()
