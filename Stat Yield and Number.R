df <- read.csv("Dfyield_number.csv")
View(df)

Yieldaov <- aov(Yield~Treatment + Blocks, data = df)
summary(Yieldaov)

Numberoffruitsaov <- aov(Number_of_Fruits ~ Treatment + Blocks, data = df)
summary(Numberoffruitsaov)

