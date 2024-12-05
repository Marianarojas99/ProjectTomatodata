#For Agronomics Fruit Yield and Number of Fruit

#Load and Import the Data from Excel 
library(readxl)
Data_2_FruitYield_NoFruit <- read_excel("DATA/Data (1).xlsx", 
                                        sheet = "Agronomic")

library(dplyr)
library(tidyr)

dfnames <- Data_2_FruitYield_NoFruit[-1,-c(9,10,11,12,19:30)] %>% 
  setNames(c("Treatment", "Repetition", "Cluster1", "Cluster2", "Cluster3", 
             "Cluster4", "Cluster5", "Cluster6", "Cluster1N", "Cluster2N", 
             "Cluster3N", "Cluster4N", "Cluster5N", "Cluster6N"))

#Call the libr
library(dplyr)
library(tidyr)

# Transforming Data (Long Table)
df_yield <- dfnames %>%
  pivot_longer(cols = c(Cluster1,Cluster2,Cluster3,
                        Cluster4,Cluster5, Cluster6),
               names_to = "Clusters",
               values_to = "Yield")

dfjustyield <- df_yield[, c("Treatment","Clusters","Repetition","Yield")]



df_fruits <- dfnames %>%
  pivot_longer(
    cols = c(Cluster1N, Cluster2N, Cluster3N, Cluster4N, Cluster5N, Cluster6N),
    names_to = "Clusters",
    values_to = "Number_of_Fruits"
  ) %>%
  mutate(
    Clusters = gsub("N$", "", Clusters) 
  )


dfjustfruit <- df_fruits[,c("Treatment","Clusters","Repetition","Number_of_Fruits")]



##Add number of fruits
dfjustyield$Number_of_Fruits <- dfjustfruit$Number_of_Fruits



#Add Blocks 
dfjustyield <- dfjustyield %>%
  group_by(Treatment) %>%
  mutate(Block = rep(1:5, each = 18, length.out = n()))

#Reorganized the table 

dfjustyield <- dfjustyield %>%
  select(1:2, 6, 3:5, everything())

View(dfjustyield)
#Covert it csv
write.csv(dfjustyield,"Dfyield_number.csv", row.names = FALSE)

