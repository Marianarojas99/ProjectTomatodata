library(readxl)
Data_1_Severity <- read_excel("DATA/Data (1).xlsx", 
                              sheet = "P. infestans")
View(Data_1_Severity)
library(dplyr)
library(tidyr)
colnames(Data_1_Severity) <- c("Treatment","Block","Week1","Week3","Week5","Week7","Week9", "Total")
data1 <- Data_1_Severity[-1, ]
View(data1)

data_long <- data1 %>%
  pivot_longer(cols = c(Week1,Week3,Week5,Week7,Week9),
               names_to = "Weeks",
               values_to = "Severity") %>%
  select(where(~ all(!is.na(.))))
View(data_long)

