df <- read.csv("Dfyield_number.csv")
View(df)

##Yield

#Anova

Yieldaov <- aov(Yield~Treatment + Block, data = df)
summary(Yieldaov)


#Normality 
resyield <- residuals(Yieldaov)
shapiro.test(resyield)

#QQplot 

qqnorm(resyield)
qqline(res, col = "blue", lwd = 2)

#Homocedasticity

bartlett.test(Yield ~ Treatment, data = df)

##There is homocedasticity but not normality. 

#Transform data sqrt 
df$sqrt_Yield <- sqrt(df$Yield)
Yieldaovsqrt <- aov(sqrt_Yield~Treatment + Block, data = df)
resyieldsqrt <- residuals(Yieldaovsqrt)
shapiro.test(resyieldsqrt)

##didn't worked

##some of them are 0, so log and 1/x is not possible. 

#Fisher LSD (test what they did)

library(agricolae)
results_LSDYield <- LSD.test(Yieldaov, "Treatment", console = TRUE)
print(results_LSDYield)

#Friedman 
df_avg <- aggregate(Yield ~ Block + Treatment, data = df, FUN = mean)

df$Treatment <- as.factor(df$Treatment)
df$Blocks <- as.factor(df$Block)
friedman.test(Yield~Treatment|Block,data=df_avg)
pairwise_result <- pairwise.wilcox.test(df$Yield, df$Treatment, p.adjust.method = "bonferroni")
print(pairwise_result)
install.packages("multcompView")
library(multcompView)
letters <- multcompLetters(pairwise_result$p.value)
print(letters)

library(ggplot2)
df$Letters <- letters$Letters[match(df$Treatment, names(letters$Letters))]
ggplot(df, aes(x = Treatment, y = Yield, fill = Treatment)) +
  geom_boxplot() +
  geom_text(aes(label = Letters, y = max(Yield) + 1), size = 4) +  
  labs(title = "Yield", x = "Tratamientos", y = "Rendimiento") +
  theme_minimal()

##Number of fruits

Numberoffruitsaov <- aov(Number_of_Fruits ~ Treatment + Block, data = df)
summary(Numberoffruitsaov)

#Normality 
resnumoffruits <- residuals(Numberoffruitsaov)
shapiro.test(resnumoffruits)

#Transform data sqrt 
df$sqrt_Num <- sqrt(df$Number_of_Fruits)
Numaovsqrt <- aov(sqrt_Num~Treatment + Block, data = df)
resnumdsqrt <- residuals(Numaovsqrt)
shapiro.test(resnumdsqrt)

## no normal 

#Fisher LSD (test what they did)

library(agricolae)
results_LSDNum <- LSD.test(Numberoffruitsaov, "Treatment", console = TRUE)
print(results_LSDYield)

#Homocedasticity

bartlett.test(Number_of_Fruits ~ Treatment, data = df)

#Friedman 

df_avgnum <- aggregate(Number_of_Fruits ~ Block + Treatment, data = df, FUN = mean)

friedman.test(Number_of_Fruits~Treatment|Block,data=df_avgnum)


pairwise_result1 <- pairwise.wilcox.test(df$Number_of_Fruits, df$Treatment, p.adjust.method = "bonferroni")
print(pairwise_result1)
library(multcompView)
df_summary$letters <- letters1$Letters[match(df_summary$Treatment, names(letters1$Letters))]

# Verificar las letras y las asignaciones
library(dplyr)
df_summary <- df %>%
  group_by(Treatment) %>%
  summarise(
    mean_fruits = mean(Number_of_Fruits),
    sd_fruits = sd(Number_of_Fruits)
  )
ggplot(df_summary, aes(x = Treatment, y = mean_fruits, fill = Treatment)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.7) +  # Crear las barras
  geom_errorbar(aes(ymin = mean_fruits - sd_fruits, ymax = mean_fruits + sd_fruits), 
                width = 0.1, position = position_dodge(width = 0.7)) +  # Barras de error más pequeñas (ajustar width)
  geom_text(aes(label = letters, y = mean_fruits + sd_fruits + 1), size = 4, position = position_dodge(width = 0.7)) +  # Agregar las letras
  labs(title = "Número de Frutas por Tratamiento", x = "Tratamiento", y = "Promedio de Número de Frutas") +
  theme_minimal()
