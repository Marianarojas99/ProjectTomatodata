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



