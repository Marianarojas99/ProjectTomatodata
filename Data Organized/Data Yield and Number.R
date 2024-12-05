#For Agronomics Fruit Yield and Number of Fruit

#Load and Import the Data from Excel 
library(readxl)
Data_2_FruitYield_NoFruit <- read_excel("DATA/Data (1).xlsx", 
                                        sheet = "Agronomic")
View(Data_2_FruitYield_NoFruit)
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
dfjustyield <- df_yield[,-c(3:8)]



df_fruits <- dfnames %>%
  pivot_longer(
    cols = c(Cluster1N, Cluster2N, Cluster3N, Cluster4N, Cluster5N, Cluster6N),
    names_to = "Clusters",
    values_to = "Number_of_Fruits"
  ) %>%
  mutate(
    Clusters = gsub("N$", "", Clusters) 
  )
dfjustfruit <- df_fruits[,-c(3:8)]


dfjustfruit <- dfjustfruit %>% group_by(Treatment, Repetition, Clusters) %>% slice(1) %>% ungroup()
dfjustyield <- dfjustyield %>% group_by(Treatment, Repetition, Clusters) %>% slice(1) %>% ungroup()
Dfyield_number <- left_join(dfjustfruit, dfjustyield, by = c("Treatment", "Repetition", "Clusters"))


Bloc <- rep(1:5, each = 18)
Dfyield_number$Blocks <- Bloc


Dfyield_number <- Dfyield_number %>%
  select(1:2, 6, 3:5, everything())
View(Dfyield_number)
save(df, file = "Dfyield_number.RData")
