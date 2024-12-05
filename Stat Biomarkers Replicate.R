Databiomarkers <- read.csv("biomarkers.csv")
View(Databiomarkers)

results_tableH2020 <- data.frame(
  Day = integer(),
  ANOVA_F = numeric(),
  ANOVA_p = numeric(),
  Shapiro_Wilk_W = numeric(),
  Shapiro_Wilk_p = numeric(),
  Transformation = character(),
  NonParametric_p = numeric(),
  stringsAsFactors = FALSE
)

Days <- c(45, 60, 75, 90, 105)

for (dia in Days) {
  df_filtered <- Databiomarkers[Databiomarkers$Day == dia, ]
  
  anova_result <- aov(H202 ~ Block, data = df_filtered)
  residuos <- residuals(anova_result)
  shapiro_test_result <- shapiro.test(residuos)
  
  if (shapiro_test_result$p.value < 0.05) {
    df_filtered$H202_sqrt <- sqrt(df_filtered$H202)
    anova_result_sqrt <- aov(H202_sqrt ~ Block, data = df_filtered)
    residuos_sqrt <- residuals(anova_result_sqrt)
    shapiro_test_sqrt <- shapiro.test(residuos_sqrt)
    
    if (shapiro_test_sqrt$p.value < 0.05) {
      df_filtered$H202_log <- log(df_filtered$H202 + 1)  # Evitar log(0)
      anova_result_log <- aov(H202_log ~ Block, data = df_filtered)
      residuos_log <- residuals(anova_result_log)
      shapiro_test_log <- shapiro.test(residuos_log)
      
      if (shapiro_test_log$p.value < 0.05) {
        friedman_result <- friedman.test(H202 ~ Block | Treatment, data = df_filtered)
        results_table <- rbind(results_table, data.frame(
          Day = dia,
          ANOVA_F = NA,
          ANOVA_p = NA,
          Shapiro_Wilk_W = NA,
          Shapiro_Wilk_p = NA,
          Transformation = "Non-Parametric",
          NonParametric_p = friedman_result$p.value
        ))
      } else {
        anova_summary_log <- summary(anova_result_log)
        results_table <- rbind(results_table, data.frame(
          Day = dia,
          ANOVA_F = anova_summary_log[[1]]["Block", "F value"],
          ANOVA_p = anova_summary_log[[1]]["Block", "Pr(>F)"],
          Shapiro_Wilk_W = shapiro_test_log$statistic,
          Shapiro_Wilk_p = shapiro_test_log$p.value,
          Transformation = "Log",
          NonParametric_p = NA
        ))
      }
    } else {
      anova_summary_sqrt <- summary(anova_result_sqrt)
      results_table <- rbind(results_table, data.frame(
        Day = dia,
        ANOVA_F = anova_summary_sqrt[[1]]["Block", "F value"],
        ANOVA_p = anova_summary_sqrt[[1]]["Block", "Pr(>F)"],
        Shapiro_Wilk_W = shapiro_test_sqrt$statistic,
        Shapiro_Wilk_p = shapiro_test_sqrt$p.value,
        Transformation = "Square Root",
        NonParametric_p = NA
      ))
    }
  } else {
    anova_summary <- summary(anova_result)
    results_table <- rbind(results_table, data.frame(
      Day = dia,
      ANOVA_F = anova_summary[[1]]["Block", "F value"],
      ANOVA_p = anova_summary[[1]]["Block", "Pr(>F)"],
      Shapiro_Wilk_W = shapiro_test_result$statistic,
      Shapiro_Wilk_p = shapiro_test_result$p.value,
      Transformation = "None",
      NonParametric_p = NA
    ))
  }
}

print(results_tableH2020)

##MDA

Databiomarkers$MDA[is.na(Databiomarkers$MDA)] <- 0

results_table_mda <- data.frame(
  Day = integer(),
  ANOVA_F = numeric(),
  ANOVA_p = numeric(),
  Shapiro_Wilk_W = numeric(),
  Shapiro_Wilk_p = numeric(),
  Transformation = character(),
  NonParametric_p = numeric(),
  stringsAsFactors = FALSE
)

for (dia in Days) {
  
  df_filtered <- Databiomarkers[Databiomarkers$Day == dia, ]
  
  anova_result <- aov(MDA ~ Block, data = df_filtered)
  residuos <- residuals(anova_result)
  shapiro_test_result <- shapiro.test(residuos)
  
  if (shapiro_test_result$p.value < 0.05) {
   
    df_filtered$MDA_sqrt <- sqrt(df_filtered$MDA)
    anova_result_sqrt <- aov(MDA_sqrt ~ Block, data = df_filtered)
    residuos_sqrt <- residuals(anova_result_sqrt)
    shapiro_test_sqrt <- shapiro.test(residuos_sqrt)
    
    if (shapiro_test_sqrt$p.value < 0.05) {
      df_filtered$MDA_log <- log(df_filtered$MDA + 1)  
      anova_result_log <- aov(MDA_log ~ Block, data = df_filtered)
      residuos_log <- residuals(anova_result_log)
      shapiro_test_log <- shapiro.test(residuos_log)
      
      if (shapiro_test_log$p.value < 0.05) {
        friedman_result <- friedman.test(MDA ~ Block | Treatment, data = df_filtered)
        results_table_mda <- rbind(results_table_mda, data.frame(
          Day = dia,
          ANOVA_F = NA,
          ANOVA_p = NA,
          Shapiro_Wilk_W = NA,
          Shapiro_Wilk_p = NA,
          Transformation = "Non-Parametric",
          NonParametric_p = friedman_result$p.value
        ))
      } else {
        anova_summary_log <- summary(anova_result_log)
        results_table_mda <- rbind(results_table_mda, data.frame(
          Day = dia,
          ANOVA_F = anova_summary_log[[1]]["Block", "F value"],
          ANOVA_p = anova_summary_log[[1]]["Block", "Pr(>F)"],
          Shapiro_Wilk_W = shapiro_test_log$statistic,
          Shapiro_Wilk_p = shapiro_test_log$p.value,
          Transformation = "Log",
          NonParametric_p = NA
        ))
      }
    } else {
      anova_summary_sqrt <- summary(anova_result_sqrt)
      results_table_mda <- rbind(results_table_mda, data.frame(
        Day = dia,
        ANOVA_F = anova_summary_sqrt[[1]]["Block", "F value"],
        ANOVA_p = anova_summary_sqrt[[1]]["Block", "Pr(>F)"],
        Shapiro_Wilk_W = shapiro_test_sqrt$statistic,
        Shapiro_Wilk_p = shapiro_test_sqrt$p.value,
        Transformation = "Square Root",
        NonParametric_p = NA
      ))
    }
  } else {
    anova_summary <- summary(anova_result)
    results_table_mda <- rbind(results_table_mda, data.frame(
      Day = dia,
      ANOVA_F = anova_summary[[1]]["Block", "F value"],
      ANOVA_p = anova_summary[[1]]["Block", "Pr(>F)"],
      Shapiro_Wilk_W = shapiro_test_result$statistic,
      Shapiro_Wilk_p = shapiro_test_result$p.value,
      Transformation = "None",
      NonParametric_p = NA
    ))
  }
}

print(results_table_mda)

##Superoxide anion


results_table_superoxide <- data.frame(
  Day = integer(),
  ANOVA_F = numeric(),
  ANOVA_p = numeric(),
  Shapiro_Wilk_W = numeric(),
  Shapiro_Wilk_p = numeric(),
  Transformation = character(),
  NonParametric_p = numeric(),
  stringsAsFactors = FALSE
)


for (dia in Days) {
  
  df_filtered <- Databiomarkers[Databiomarkers$Day == dia, ]
  
  anova_result <- aov(Superoxide.anion ~ Block, data = df_filtered)
  residuos <- residuals(anova_result)
  shapiro_test_result <- shapiro.test(residuos)
  
  if (shapiro_test_result$p.value < 0.05) {
    
    df_filtered$superoxide_sqrt <- sqrt(df_filtered$Superoxide.anion)
    anova_result_sqrt <- aov(superoxide_sqrt ~ Block, data = df_filtered)
    residuos_sqrt <- residuals(anova_result_sqrt)
    shapiro_test_sqrt <- shapiro.test(residuos_sqrt)
    
    if (shapiro_test_sqrt$p.value < 0.05) {
      
      df_filtered$superoxide_log <- log(df_filtered$Superoxide.anion + 1)  # Evitar log(0)
      anova_result_log <- aov(superoxide_log ~ Block, data = df_filtered)
      residuos_log <- residuals(anova_result_log)
      shapiro_test_log <- shapiro.test(residuos_log)
      
      if (shapiro_test_log$p.value < 0.05) {
        
        friedman_result <- friedman.test(Superoxide.anion ~ Block | Treatment, data = df_filtered)
        results_table_superoxide <- rbind(results_table_superoxide, data.frame(
          Day = dia,
          ANOVA_F = NA,
          ANOVA_p = NA,
          Shapiro_Wilk_W = NA,
          Shapiro_Wilk_p = NA,
          Transformation = "Non-Parametric",
          NonParametric_p = friedman_result$p.value
        ))
      } else {
        anova_summary_log <- summary(anova_result_log)
        results_table_superoxide <- rbind(results_table_superoxide, data.frame(
          Day = dia,
          ANOVA_F = anova_summary_log[[1]]["Block", "F value"],
          ANOVA_p = anova_summary_log[[1]]["Block", "Pr(>F)"],
          Shapiro_Wilk_W = shapiro_test_log$statistic,
          Shapiro_Wilk_p = shapiro_test_log$p.value,
          Transformation = "Log",
          NonParametric_p = NA
        ))
      }
    } else {
      
      anova_summary_sqrt <- summary(anova_result_sqrt)
      results_table_superoxide <- rbind(results_table_superoxide, data.frame(
        Day = dia,
        ANOVA_F = anova_summary_sqrt[[1]]["Block", "F value"],
        ANOVA_p = anova_summary_sqrt[[1]]["Block", "Pr(>F)"],
        Shapiro_Wilk_W = shapiro_test_sqrt$statistic,
        Shapiro_Wilk_p = shapiro_test_sqrt$p.value,
        Transformation = "Square Root",
        NonParametric_p = NA
      ))
    }
  } else {
    anova_summary <- summary(anova_result)
    results_table_superoxide <- rbind(results_table_superoxide, data.frame(
      Day = dia,
      ANOVA_F = anova_summary[[1]]["Block", "F value"],
      ANOVA_p = anova_summary[[1]]["Block", "Pr(>F)"],
      Shapiro_Wilk_W = shapiro_test_result$statistic,
      Shapiro_Wilk_p = shapiro_test_result$p.value,
      Transformation = "None",
      NonParametric_p = NA
    ))
  }
}


print(results_table_superoxide)

library(multcompView)
library(ggplot2)
library(dplyr)
##Falta sacarle las letras
## hacer las medidas repetidas para los tres casos 

#componentes principales (en clase)

