Dataseverity <- read.csv("Phytophtora.csv")


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



# Load required packages and libraries for determine the differences between treatments in the severity of P. infestans, a repeated measures multivariate analysis of variance and Hotteling test (a = 0.05) 
install.packages("car")       # For MANOVA
install.packages("Hotelling") # For Hotelling's T-squared test

# Load required libraries
library(readxl)
library(dplyr)
library(tidyr)
library(lme4)
library(lmerTest)   # For p-values in mixed models
library(emmeans)    # For estimated marginal means
library(ggplot2)    # For visualization

# Ensure necessary packages are installed
if (!requireNamespace("car", quietly = TRUE)) {
  install.packages("car")
}
if (!requireNamespace("Hotelling", quietly = TRUE)) {
  install.packages("Hotelling")
}

library(car)        # For MANOVA
library(Hotelling)  # For Hotelling's T-squared test

# Step 1: Read the data
Data_1_Severity <- read_excel("DATA/Data (1).xlsx", sheet = "P. infestans")

# Step 2: Clean and reshape the data
colnames(Data_1_Severity) <- c("Treatment", "Block", "Week1", "Week3", "Week5", "Week7", "Week9")
data1 <- Data_1_Severity[-1, ]  # Remove first row if it is header
data1 <- data1 %>% mutate(across(everything(), as.character))  # Convert all columns to character

# Check column names and structure
print(colnames(data1))

# Convert relevant columns to numeric
data1 <- data1 %>%
  mutate(across(c(Week1, Week3, Week5, Week7, Week9), as.numeric))

# Reshape the data to long format
data_long <- data1 %>%
  pivot_longer(cols = c(Week1, Week3, Week5, Week7, Week9),
               names_to = "Weeks",
               values_to = "Severity") %>%
  filter(!is.na(Severity))  # Remove rows with NA severity

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

# Step 9: Prepare data for MANOVA
data_wide <- data1 %>%
  select(Treatment, Week1, Week3, Week5, Week7, Week9)

# Check the structure of data_wide
print(head(data_wide))

# Ensure numeric type for MANOVA
data_wide <- data_wide %>%
  mutate(across(Week1:Week9, as.numeric))

# Step 10: Perform MANOVA
manova_results <- manova(cbind(Week1, Week3, Week5, Week7, Week9) ~ Treatment, data = data_wide)
summary(manova_results)

# Step 11: Conduct Hotelling's T-squared Test
# Ensure there are at least two treatments
if (length(unique(data_wide$Treatment)) >= 2) {
  treatment_groups <- split(data_wide[, -1], data_wide$Treatment)
  
  # Perform Hotelling's T-squared test
  hotelling_results <- Hotelling::hotelling.test(treatment_groups[[1]], treatment_groups[[2]])
  print(hotelling_results)
} else {
  cat("Not enough treatment groups for Hotelling's T-squared test.\n")
}

# Optional: Print pairwise comparison results for clarity
print(pairwise_results)  
