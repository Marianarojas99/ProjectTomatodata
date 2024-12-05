#Stem Diameter and Dry Weight

# Load and Import the Data from Excel
library(readxl)
library(dplyr)

# Load the dataset
Data_4_SDiamDryWeight <- read_excel("DATA/Data (1).xlsx", sheet = "Agronomic")
View(Data_4_SDiamDryWeight)

# Remove unwanted data (keep only relevant columns)
Dfprov4 <- Data_4_SDiamDryWeight[, -c(1:25)]
View(Dfprov4)
