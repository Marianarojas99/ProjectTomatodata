# Load necessary libraries
library(readxl)
library(dplyr)

# Load the dataset (replace the file path if needed)
Data_3_FruitWeight <- read_excel("DATA/Data (1).xlsx", sheet = "Agronomic")

# Clean up the data (similar to what you've done before)
Dfprov3 <- Data_3_FruitWeight[-1, -c(1:20, 25:30)]
colnames(Dfprov3) <- c("Treatment", "Fruits", "Average Weight", "Average Weight of Fruits")

# Group rows into blocks and repetitions (as previously)
n_blocks <- 5  # Total number of blocks per treatment
n_reps <- 3    # Total number of repetitions per block

Dfprov3 <- Dfprov3 %>%
  group_by(Treatment) %>%  # Group by Treatment
  mutate(
    Block = rep(1:n_blocks, each = n_reps, length.out = n()),  # Assign blocks (5 blocks per treatment)
    Repetition = rep(1:n_reps, times = n_blocks, length.out = n())  # Assign repetitions (1, 2, 3 in each block)
  ) %>%
  ungroup()  # Remove grouping

# Reorder columns to place Block and Repetition after Treatment
Dfprov3 <- Dfprov3 %>%
  select(Treatment, Block, Repetition, everything())

# Conduct ANOVA for Average Weight
Yield_aov <- aov(`Average Weight` ~ Treatment + Block, data = Dfprov3)
summary(Yield_aov)

# Conduct ANOVA for Number of Fruits (if applicable, using the appropriate column)
Number_of_Fruits_aov <- aov(Fruits ~ Treatment + Block, data = Dfprov3)
summary(Number_of_Fruits_aov)
