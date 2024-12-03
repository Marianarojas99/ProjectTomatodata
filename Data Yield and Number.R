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

#Call the libr
library(dplyr)
library(tidyr)

# Transforming Data (Long Table)
dflong <- Dfprov2 %>%
  pivot_longer(cols = c(Cluster1,Cluster2,Cluster3,
                        Cluster4,Cluster5, Cluster6),
               names_to = "Clusters",
               values_to = "Yield")
View(dflong)

dflongcomp <- dflong %>%
  pivot_longer(cols = c(Cluster1N,Cluster2N,Cluster3N,
                        Cluster4N,Cluster5N, Cluster6N),
               names_to = "ClustersN",
               values_to = "Number of Fruits")

View(dflongcomp)

dffinal <- dflongcomp [,-5 ]
view(dffinal)