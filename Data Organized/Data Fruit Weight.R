#Fruit Weight

# Load and Import the Data from Excel
library(readxl)
library(dplyr)

# Load the dataset
Data_3_FruitWeight <- read_excel("DATA/Data (1).xlsx", sheet = "Agronomic")

# Remove unwanted data (keep only relevant columns)
Dfprov3 <- Data_3_FruitWeight[-1, -c(1:20, 25:30)]

# Rename the columns
colnames(Dfprov3) <- c("Treatment", "Fruits", "Average Weight", "Average Weight of Fruits")

# Group rows into blocks and repetitions
n_blocks <- 5     # Total number of blocks per treatment
n_reps <- 3       # Total number of repetitions per block

# Add Block and Repetition columns
Dfprov3 <- Dfprov3 %>%
  group_by(Treatment) %>% # Group by Treatment
  mutate(
    Block = rep(1:n_blocks, each = n_reps, length.out = n()),         # Assign blocks (5 blocks per treatment)
    Repetition = rep(1:n_reps, times = n_blocks, length.out = n())   # Assign repetitions (1, 2, 3 in each block)
  ) %>%
  ungroup() # Remove grouping

# Reorder columns to place Block and Repetition after Treatment
Dfprov3 <- Dfprov3 %>%
  select(Treatment, Block, Repetition, everything())

# View the updated dataset
View(Dfprov3)