#For Agronomics Fruit Yield and Number of Fruit

#Load and Import the Data from Excel 
library(readxl)
Data_2_FruitYield_NoFruit <- read_excel("DATA/Data (1).xlsx", 
                                        sheet = "Agronomic")
View(Data_2_FruitYield_NoFruit)

#Call the Data, Arrange the Fruit Yield
Dfprov1 <- Data_2_FruitYield_NoFruit[-1, ]
View(Dfprov1)

#Title of Column
colnames(Dfprov1) <- c("Treatment","Repetition","Cluster1","Cluster2","Cluster3",
                       "Cluster4","Cluster5", "Cluster6")


#Call the Data, Arrange Number of Fruit
Dfprov2 <-  Dfprov1 [,-c(9,10,11,12,19:30)]
View(Dfprov2)

colnames(Dfprov2) <- c("Treatment","Repetition","Cluster1","Cluster2","Cluster3",
                       "Cluster4","Cluster5", "Cluster6","Cluster1N","Cluster2N","Cluster3N",
                       "Cluster4N","Cluster5N", "Cluster6N")
View(Dfprov2)


#Call the libr
library(dplyr)
library(tidyr)

# Transforming Data (Long Table)
df_yield <- Dfprov2 %>%
  pivot_longer(cols = c(Cluster1,Cluster2,Cluster3,
                        Cluster4,Cluster5, Cluster6),
               names_to = "Clusters",
               values_to = "Yield")
dfjustyield <- df_yield[,-c(3:8)]
View(dfjustyield)


df_fruits <- Dfprov2 %>%
  pivot_longer(
    cols = c(Cluster1N, Cluster2N, Cluster3N, Cluster4N, Cluster5N, Cluster6N),
    names_to = "Clusters",
    values_to = "Number_of_Fruits"
  ) %>%
  mutate(
    Clusters = gsub("N$", "", Clusters) 
  )
View(df_fruits)
dfjustfruit <- df_fruits[,-c(3:8)]
View(dfjustfruit)
dfjustfruit <- dfjustfruit %>% group_by(Treatment, Repetition, Clusters) %>% slice(1) %>% ungroup()
dfjustyield <- dfjustyield %>% group_by(Treatment, Repetition, Clusters) %>% slice(1) %>% ungroup()
df_long <- left_join(dfjustfruit, dfjustyield, by = c("Treatment", "Repetition", "Clusters"))
View(df_long)

Bloc <- rep(1:5, each = 18)
df_long$Blocks <- Bloc
View(df_long)

df_long <- df_long %>%
  select(1:2, 6, 3:5, everything())
View(df_long)
