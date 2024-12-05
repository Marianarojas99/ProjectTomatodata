library(readxl)
Data_1_Severity <- read_excel("DATA/Data (1).xlsx", 
                              sheet = "P. infestans")
View(Data_1_Severity)
library(dplyr)
library(tidyr)
colnames(Data_1_Severity) <- c("Treatment","Block","Week1","Week3","Week5","Week7","Week9")
data1 <- Data_1_Severity[-1, ]
View(data1)

data_long <- data1 %>%
  pivot_longer(cols = c(Week1,Week3,Week5,Week7,Week9),
               names_to = "Weeks",
               values_to = "Severity") %>%
  select(where(~ all(!is.na(.))))
View(data_long)


install.packages("lme4")
install.packages("lmerTest")  # For p-values
install.packages("ggplot2")  # For visualization
library(lme4)
library(lmerTest)
library(ggplot2)
# Fit the mixed-effects model
model <- lmer(Severity ~ Weeks * Treatment + (1 | Block), data = data_long)
summary(model)
# Residuals vs Fitted plot
plot(model)

# QQ plot for normality of residuals
qqnorm(resid(model))
qqline(resid(model))
anova(model)
library(emmeans)  # For estimated marginal means

# Installing 
install.packages("pbkrtest")
library(pbkrtest)

# Obtain estimated marginal means
emm <- emmeans(model, ~ Treatment | Weeks)
summary(emm)

# Pairwise comparisons
pairs(emm)
# Calculate mean severity for each treatment at each week
library(dplyr)

mean_data <- data_long %>%
  group_by(Weeks, Treatment) %>%
  summarize(Mean_Severity = mean(Severity, na.rm = TRUE), .groups = 'drop')
# Create a line graph
ggplot(mean_data, aes(x = Weeks, y = Mean_Severity, color = Treatment, group = Treatment)) +
  geom_line(size = 1) +      # Line for each treatment
  geom_point(size = 3) +     # Points for each mean severity
  labs(title = "Severity of Pathogen Suppression Over Time",
       x = "Weeks",
       y = "Mean Severity") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Optional: Rotate x-axis labels for better readability


