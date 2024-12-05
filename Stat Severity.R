library(readxl)
Data_1_Severity <- read_excel("DATA/Data (1).xlsx", 
                              sheet = "P. infestans")
View(Data_1_Severity)
library(dplyr)
library(tidyr)
colnames(Data_1_Severity) <- c("Treatment","Block","Week1","Week3","Week5","Week7","Week9")
data1 <- Data_1_Severity[-1, ]


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



# Load required libraries for the P value analysis 
library(readxl)
library(dplyr)
library(tidyr)
library(lme4)
library(lmerTest)  # For p-values in mixed models
library(emmeans)   # For estimated marginal means
library(ggplot2)   # For visualization

# Step 1: Read the data
Data_1_Severity <- read_excel("DATA/Data (1).xlsx", sheet = "P. infestans")

# Step 2: Clean and reshape the data
colnames(Data_1_Severity) <- c("Treatment", "Block", "Week1", "Week3", "Week5", "Week7", "Week9")
data1 <- Data_1_Severity[-1, ]
data_long <- data1 %>%
  pivot_longer(cols = c(Week1, Week3, Week5, Week7, Week9),
               names_to = "Weeks",
               values_to = "Severity") %>%
  select(where(~ all(!is.na(.))))

# Step 3: Fit the mixed-effects model
model <- lmer(Severity ~ Weeks * Treatment + (1 | Block), data = data_long)

# Step 4: ANOVA for the mixed-effects model
anova_results <- anova(model)
print(anova_results)

# Step 5: Obtain estimated marginal means
emm <- emmeans(model, ~ Treatment | Weeks)
summary(emm)

# Step 6: Pairwise comparisons among treatments
pairwise_results <- pairs(emm)
summary(pairwise_results)

# Step 7: Convert estimated marginal means to a data frame for plotting
emm_df <- as.data.frame(emm)

# Step 8: Visualizing estimated marginal means with confidence intervals
ggplot(emm_df, aes(x = Weeks, y = emmean, color = Treatment)) +
  geom_line(size = 1) +
  geom_point(size = 3) +
  geom_errorbar(aes(ymin = lower.CL, ymax = upper.CL), width = 0.2) +
  labs(title = "Estimated Marginal Means of Severity by Treatment Over Time",
       x = "Weeks",
       y = "Estimated Mean Severity") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Optional: Print pairwise comparison results for clarity
print(pairwise_results)
