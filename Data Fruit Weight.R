#For Average Fruit Weight

#Load and Import the Data from Excel 
library(readxl)
Data_3_FruitWeight <- read_excel("DATA/Data (1).xlsx", 
                                        sheet = "Agronomic")

#Remove other Data
Dfprov3 <-  Data_3_FruitWeight [-1,-c(1:20,25:30)]
View(Dfprov3)

#Name the columns
colnames(Dfprov3) <- c("Treatment", "Fruits", "Average Weight", "Average Weight of Fruits")


View(Dfprov3)
