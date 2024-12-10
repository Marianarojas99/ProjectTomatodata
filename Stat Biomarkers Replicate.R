Databiomarkers <- read.csv("biomarkers.csv")
View(Databiomarkers)

Days <- c(45, 60, 75, 90, 105)

results_table_H202 <- data.frame(
  Day = numeric(),
  Test = character(),
  Transformation = character(),
  PostHoc_Method = character(),
  stringsAsFactors = FALSE
)


if (!require("multcompView")) install.packages("multcompView")
if (!require("dplyr")) install.packages("dplyr")
if (!require("PMCMRplus")) install.packages("PMCMRplus")

posthoc_letters_list <- list()  

for (dia in Days) {
  
 
  df_filtered <- Databiomarkers[Databiomarkers$Day == dia, ]
  
  
  df_filtered$H202[is.na(df_filtered$H202)] <- 0
  
  
  df_filtered$Block <- as.factor(df_filtered$Block)
  df_filtered$Treatment <- as.factor(df_filtered$Treatment)
  
 
  anova_result <- aov(H202 ~ Treatment, data = df_filtered)
  residuos <- residuals(anova_result)
  shapiro_test_result <- shapiro.test(residuos)
  
  if (shapiro_test_result$p.value < 0.05) {
    
    df_filtered$h202_sqrt <- sqrt(df_filtered$H202)
    anova_result_sqrt <- aov(h202_sqrt ~ Treatment, data = df_filtered)
    residuos_sqrt <- residuals(anova_result_sqrt)
    shapiro_test_sqrt <- shapiro.test(residuos_sqrt)
    
    if (shapiro_test_sqrt$p.value < 0.05) {
      
      df_filtered$h202_log <- log(df_filtered$H202 + 1)  
      anova_result_log <- aov(h202_log ~ Treatment, data = df_filtered)
      residuos_log <- residuals(anova_result_log)
      shapiro_test_log <- shapiro.test(residuos_log)
      
      if (shapiro_test_log$p.value < 0.05) {
        
        friedman_result <- friedman.test(H202 ~ Treatment | Block, data = df_filtered)
        
        
        posthoc <- pairwise.wilcox.test(
          df_filtered$H202,
          df_filtered$Treatment,
          p.adjust.method = "bonferroni"
        )
        
     
        letters <- multcompLetters(posthoc$p.value)$Letters
        posthoc_letters_list[[as.character(dia)]] <- letters
        
        
        results_table_H202 <- rbind(results_table_H202, data.frame(
          Day = dia,
          Test = "Friedman",
          Transformation = "Non-Parametric",
          PostHoc_Method = "Bonferroni"
        ))
      } else {
        
        posthoc <- TukeyHSD(anova_result_log, "Treatment")
        letters <- multcompLetters(posthoc$Treatment[, "p adj"])$Letters
        posthoc_letters_list[[as.character(dia)]] <- letters
        
        results_table_H202 <- rbind(results_table_H202, data.frame(
          Day = dia,
          Test = "ANOVA",
          Transformation = "Log",
          PostHoc_Method = "Tukey"
        ))
      }
    } else {
     
      posthoc <- TukeyHSD(anova_result_sqrt, "Treatment")
      letters <- multcompLetters(posthoc$Treatment[, "p adj"])$Letters
      posthoc_letters_list[[as.character(dia)]] <- letters
      
      results_table_H202 <- rbind(results_table_H202, data.frame(
        Day = dia,
        Test = "ANOVA",
        Transformation = "Square Root",
        PostHoc_Method = "Tukey"
      ))
    }
  } else {
   
    posthoc <- TukeyHSD(anova_result, "Treatment")
    letters <- multcompLetters(posthoc$Treatment[, "p adj"])$Letters
    posthoc_letters_list[[as.character(dia)]] <- letters
    
    results_table_H202 <- rbind(results_table_H202, data.frame(
      Day = dia,
      Test = "ANOVA",
      Transformation = "None",
      PostHoc_Method = "Tukey"
    ))
  }
}


print(results_table_H202)


for (dia in Days) {
  cat("Día:", dia, "\n")
  print(posthoc_letters_list[[as.character(dia)]])
  cat("\n")
}


##MDA


results_table_MDA <- data.frame(
  Day = numeric(),
  Test = character(),
  Transformation = character(),
  PostHoc_Method = character(),
  stringsAsFactors = FALSE
)


posthoc_letters_list <- list()  

for (dia in Days) {
  
  df_filtered <- Databiomarkers[Databiomarkers$Day == dia, ]
  
  
  df_filtered$MDA[is.na(df_filtered$MDA)] <- 0
  
  
  df_filtered$Block <- as.factor(df_filtered$Block)
  df_filtered$Treatment <- as.factor(df_filtered$Treatment)
  

  anova_result <- aov(MDA ~ Treatment, data = df_filtered)
  residuos <- residuals(anova_result)
  shapiro_test_result <- shapiro.test(residuos)
  
  if (shapiro_test_result$p.value < 0.05) {
    
    df_filtered$mda_sqrt <- sqrt(df_filtered$MDA)
    anova_result_sqrt <- aov(mda_sqrt ~ Treatment, data = df_filtered)
    residuos_sqrt <- residuals(anova_result_sqrt)
    shapiro_test_sqrt <- shapiro.test(residuos_sqrt)
    
    if (shapiro_test_sqrt$p.value < 0.05) {
     
      df_filtered$mda_log <- log(df_filtered$MDA + 1)  
      anova_result_log <- aov(mda_log ~ Treatment, data = df_filtered)
      residuos_log <- residuals(anova_result_log)
      shapiro_test_log <- shapiro.test(residuos_log)
      
      if (shapiro_test_log$p.value < 0.05) {
     
        friedman_result <- friedman.test(MDA ~ Treatment | Block, data = df_filtered)
        
     
        posthoc <- pairwise.wilcox.test(
          df_filtered$MDA,
          df_filtered$Treatment,
          p.adjust.method = "bonferroni"
        )
        
      
        letters <- multcompLetters(posthoc$p.value)$Letters
        posthoc_letters_list[[as.character(dia)]] <- letters
        
       
        results_table_MDA <- rbind(results_table_MDA, data.frame(
          Day = dia,
          Test = "Friedman",
          Transformation = "Non-Parametric",
          PostHoc_Method = "Bonferroni"
        ))
      } else {
        
        posthoc <- TukeyHSD(anova_result_log, "Treatment")
        letters <- multcompLetters(posthoc$Treatment[, "p adj"])$Letters
        posthoc_letters_list[[as.character(dia)]] <- letters
        
        results_table_MDA <- rbind(results_table_MDA, data.frame(
          Day = dia,
          Test = "ANOVA",
          Transformation = "Log",
          PostHoc_Method = "Tukey"
        ))
      }
    } else {
      
      posthoc <- TukeyHSD(anova_result_sqrt, "Treatment")
      letters <- multcompLetters(posthoc$Treatment[, "p adj"])$Letters
      posthoc_letters_list[[as.character(dia)]] <- letters
      
      results_table_MDA <- rbind(results_table_MDA, data.frame(
        Day = dia,
        Test = "ANOVA",
        Transformation = "Square Root",
        PostHoc_Method = "Tukey"
      ))
    }
  } else {
    
    posthoc <- TukeyHSD(anova_result, "Treatment")
    letters <- multcompLetters(posthoc$Treatment[, "p adj"])$Letters
    posthoc_letters_list[[as.character(dia)]] <- letters
    
    results_table_MDA <- rbind(results_table_MDA, data.frame(
      Day = dia,
      Test = "ANOVA",
      Transformation = "None",
      PostHoc_Method = "Tukey"
    ))
  }
}


print(results_table_MDA)


for (dia in Days) {
  cat("Día:", dia, "\n")
  print(posthoc_letters_list[[as.character(dia)]])
  cat("\n")
}


##Superoxide anion
  
results_table_superoxide <- data.frame(
  Day = numeric(),
  Test = character(),
  Transformation = character(),
  PostHoc_Method = character(),
  stringsAsFactors = FALSE
)

posthoc_letters_list <- list()  

for (dia in Days) {
  
  
  df_filtered <- Databiomarkers[Databiomarkers$Day == dia, ]
  
 
  df_filtered$Superoxide.anion[is.na(df_filtered$Superoxide.anion)] <- 0
  
  
  df_filtered$Block <- as.factor(df_filtered$Block)
  df_filtered$Treatment <- as.factor(df_filtered$Treatment)
  
  
  anova_result <- aov(Superoxide.anion ~ Treatment, data = df_filtered)
  residuos <- residuals(anova_result)
  shapiro_test_result <- shapiro.test(residuos)
  
  if (shapiro_test_result$p.value < 0.05) {
   
    df_filtered$superoxide_sqrt <- sqrt(df_filtered$Superoxide.anion)
    anova_result_sqrt <- aov(superoxide_sqrt ~ Treatment, data = df_filtered)
    residuos_sqrt <- residuals(anova_result_sqrt)
    shapiro_test_sqrt <- shapiro.test(residuos_sqrt)
    
    if (shapiro_test_sqrt$p.value < 0.05) {
      
      df_filtered$superoxide_log <- log(df_filtered$Superoxide.anion + 1)  # Evitar log(0)
      anova_result_log <- aov(superoxide_log ~ Treatment, data = df_filtered)
      residuos_log <- residuals(anova_result_log)
      shapiro_test_log <- shapiro.test(residuos_log)
      
      if (shapiro_test_log$p.value < 0.05) {
       
        friedman_result <- friedman.test(Superoxide.anion ~ Treatment | Block, data = df_filtered)
        
        
        posthoc <- pairwise.wilcox.test(
          df_filtered$Superoxide.anion,
          df_filtered$Treatment,
          p.adjust.method = "bonferroni"
        )
        
      
        letters <- multcompLetters(posthoc$p.value)$Letters
        posthoc_letters_list[[as.character(dia)]] <- letters
        
       
        results_table_superoxide <- rbind(results_table_superoxide, data.frame(
          Day = dia,
          Test = "Friedman",
          Transformation = "Non-Parametric",
          PostHoc_Method = "Bonferroni"
        ))
      } else {
        
        posthoc <- TukeyHSD(anova_result_log, "Treatment")
        letters <- multcompLetters(posthoc$Treatment[, "p adj"])$Letters
        posthoc_letters_list[[as.character(dia)]] <- letters
        
        results_table_superoxide <- rbind(results_table_superoxide, data.frame(
          Day = dia,
          Test = "ANOVA",
          Transformation = "Log",
          PostHoc_Method = "Tukey"
        ))
      }
    } else {
      
      posthoc <- TukeyHSD(anova_result_sqrt, "Treatment")
      letters <- multcompLetters(posthoc$Treatment[, "p adj"])$Letters
      posthoc_letters_list[[as.character(dia)]] <- letters
      
      results_table_superoxide <- rbind(results_table_superoxide, data.frame(
        Day = dia,
        Test = "ANOVA",
        Transformation = "Square Root",
        PostHoc_Method = "Tukey"
      ))
    }
  } else {
    
    posthoc <- TukeyHSD(anova_result, "Treatment")
    letters <- multcompLetters(posthoc$Treatment[, "p adj"])$Letters
    posthoc_letters_list[[as.character(dia)]] <- letters
    
    results_table_superoxide <- rbind(results_table_superoxide, data.frame(
      Day = dia,
      Test = "ANOVA",
      Transformation = "None",
      PostHoc_Method = "Tukey"
    ))
  }
}


print(results_table_superoxide)


for (dia in Days) {
  cat("Día:", dia, "\n")
  print(posthoc_letters_list[[as.character(dia)]])
  cat("\n")
}

