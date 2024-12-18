---
editor_options: 
  markdown: 
    wrap: sentence
---

# "Data" R-project

This is the final project for the subject "Data Acquisition Analysis and Scientific Methods for Life Sciences" shorted as "Data" from the first course of the Master Plant Health at the Universitat Politècnica de València.

In this project the students chose a scientific article and redo all possible statistic analyses and graphics from it, trying different approaches to see if they can improve them.
They will use the data included in the article and follow the material and methods chapter as a guide.

## Group members

Group D:

Dana Mariya Eugenio, Qingyang Gao, Selam Aknaw Mekonnen, Mariana Lucia Rojas.

## Chosen article

[Impact of *Argemone mexicana* L. on tomato plants infected with *Phytophthora infestans*](https://peerj.com/articles/16666/)

The data is available in the supplemental Information as an excel file.
<https://dfzljdn9uc3pi.cloudfront.net/2024/16666/1/Data.xlsx>

## Introduction

The project is highly interesting as it addresses a critical issue in sustainable agriculture by exploring the potential of *Argemone mexicana* L.
extract as a natural alternative to conventional fungicides, specifically against *Phytophthora infestans*, a devastating pathogen in tomato production.
The study investigates not only the extract’s antifungal properties but also its broader effects on key agronomic traits such as fruit yield, number of fruits, fruit weight, stem diameter, and dry weight.

By comparing the extract to a conventional fungicide (captan) and untreated control, the researchers aim to assess its dual role as a protective agent and potential growth promoter.
The authors found that the *Argemone mexicana* extract was effective in controlling the pathogen and promoting growth in infected plants, highlighting its promise as an environmentally friendly and sustainable alternative to chemical fungicides.
This research offers significant insights into the potential of plant-based solutions to mitigate the impact of plant diseases while supporting agricultural productivity.

## Objectives

The study aimed to evaluate the potential of *Argemone mexicana* L.
extract as a control agent against *Phytophthora infestans* in tomatoes.
Specifically, the researchers sought to assess the extract's antifungal effectiveness, its impact on agronomic traits such as: fruit yield, number of fruit, fruit weight, stem diameter, dry weight (aerial and root), and its ability to mitigate oxidative stress in infected plants.

Through the assessment of biomarkers and non- enzymatic compounds.
They compared the performance of the plant extract to a conventional fungicide (captan) and untreated controls to determine its efficacy.

Additionally, the study intended to explore whether the extract could serve as both a protective and growth-promoting agent in sustainable agriculture.

### Hypothesis

-   Hypothesis 1: *Argemone mexicana* L.
    extract has significant antifungal activity against *Phytophthora infestans* comparable to or exceeding that of captan.

-   Hypothesis 2: Application of the extract improves plant growth metrics (e.g., leaf weight, fruit yield) and reduces oxidative stress markers.

-   Hypothesis 3: The extract promotes higher antioxidant levels (e.g., vitamin C) and mitigates damage from oxidative stress (e.g., MDA levels) compared to untreated plants.

### Methods

1.  Organize the data in long tables in order to make it easier to analyse, do the data validation, create a data dictionary.

2.  Statistical analysis:

The data of the article is divided in four different categories: Severity of disease in time, agronomic traits, bio markers and non-enzymatic assesments.
We will replicate the same analysis of the paper, prove the statistical assumptions.

*A) Plant Health Metrics* (Evaluate morphological parameters: Fruit yield (clusters), average of fruit weight, number of fruit (clusters),stem diameter, and dry weight):

-   ANOVA Purpose: To assess differences in growth-related variables among treatments.

-   Post Hoc Test: For pairwise comparisons across multiple treatments, replicate Fisher test and compare with Tukey HSD. If it is necessary, perform a transformation of the data.
    If assumptions for ANOVA are violated (non-normality or unequal variances), use a non-parametric treatment.

*B) Biomarkers and Non-enzymatic Assays* (Quantify Antioxidant Activity, Defense Enzymes, Chlorophyll Content):

-   ANOVA Purpose: To assess differences in growth-related variables among treatments.

-   Post Hoc Test: For pairwise comparisons across multiple treatments, replicate Fisher test and compare with Tukey HSD. If it is necessary, perform a transformation of the data.
    If assumptions for ANOVA are violated (non-normality or unequal variances), use a non-parametric treatment.

*C) Statistical Analysis for Treatment Efficacy*:

-   Replicate the analysis of the paper: Repeated Measures Analysis, for determining the severity of pathogen suppression over time. Use Hotelling's T² test for pairwise comparisons.

Perform a Repeated Measures Analysis for the other variables that were taken throughout time.
Create new plots showing the correlation between variables like principal component, among others.

# Protocol

1.  To download and arrange the data, render the file *01_data-format.qmd*.

    ```         
    quarto::quarto_render("DATA/01_data-format.qmd")
    ```

2.  To download and arrange the data, render the file *Doc1 Statistical Severity.qmd*

    ```         
    quarto::quarto_render("Doc1 Statistical Severity.qmd")
    ```

3.  To download and arrange the data, render the file *Doc2 Statistical Yield Nfruits Weight.qmd*

    ```         
    quarto::quarto_render("Doc2 Statistical Yield Nfruits Weight.qmd")
    ```

4.  To download and arrange the data, render the file *Doc3 Statistical Stem Diameter and Dry Weight.qmd*

    ```         
    quarto::quarto_render("Doc3 Statistical Stem Diameter and Dry Weight.qmd")
    ```

5.  To download and arrange the data, render the file *Doc4 Biomarkers and non enzymatic paper.qmd*

    ```         
    quarto::quarto_render("Doc4 Biomarkers and non enzymatic paper.qmd")
    ```

6.  To download and arrange the data, render the file *Doc5 Statistical Repeated Measurements.qmd*

    \`\`\`\
    quarto::quarto_render("Doc5 Statistical Repeated Measurements.qmd")

7.  To download and arrange the data, render the file *Doc6 Principal components.qmd*

    ```         
    quarto::quarto_render("Doc6 Principal components.qmd.qmd")  
    ```

# Files Description

## File 1. Statistical Analysis for Disease Severity

In this file the statistical assessment of pathogen severity over time in a study involving different treatments was explored.
The objective is to evaluate the severity of pathogen suppression under various treatment conditions over a series of weeks.
The data is analyzed using mixed-effects models to account for both fixed and random effects.
This method allows for the comparison of treatments while considering the grouping of data in blocks and samples.

*Key Steps:*

1.  Data Preparation: The dataset is loaded and organized in a long format for analysis, ensuring that each row represents a single observation.
    Mixed-Effects Model: A linear mixed-effects model (lme) is fitted to the severity data, with treatments and weeks as fixed effects, and block/samples as random effects.

2.  Estimated Marginal Means (EMMs): The emmeans function is used to calculate the estimated means of each treatment, while considering the weeks as a conditioning variable.

3.  Pairwise Comparisons: The pairs() function performs pairwise comparisons to determine which treatments differ significantly from each other.
    Summary Statistics: For each treatment, the mean severity at each week is calculated.

4.Visualization: A line graph is created to visualize the severity of pathogen suppression over time for each treatment.
Significant differences are annotated on the graph using letters derived from pairwise comparisons.

*Key Libraries:* lme4, lmerTest, nlme: For fitting mixed-effects models.
ggplot2: For data visualization.
emmeans: For calculating estimated marginal means and performing pairwise comparisons.
dplyr: For data manipulation and summarization.
multcompView, multcomp: For performing and interpreting multiple comparisons.

*Results:* The analysis identifies which treatments are significantly different in their ability to suppress pathogen severity across weeks.
A graphical representation helps to easily interpret the severity trends and treatment effects over time, highlighting which treatments are most effective.

## File 2. Statistical Analysis for Fruit Yield, Number, and Weight

This analysis investigates the effects of different treatments on tomato fruit yield, number, and weight, considering data from multiple blocks, clusters, and treatments.
Statistical techniques like ANOVA and post-hoc tests (Tukey’s HSD, Kruskal-Wallis) are employed to assess the significance of treatment effects and assumptions such as normality and homoscedasticity.

*Key Steps:*

1.  Data Preparation: Data is loaded for both cluster-level and total-level yield, number, and weight metrics.
    The datasets are organized to analyze the effects of treatments, blocks, and clusters on the response variables.

2.  Analysis of Variance (ANOVA): Yield: ANOVA models are applied to both cluster and total data to evaluate treatment effects on tomato yield.
    Number of Fruits: Similarly, ANOVA is used to assess the effects of treatments on the number of fruits.
    Fruit Weight: Although ANOVA did not show significant treatment effects on fruit weight, further analysis using non-parametric tests (Kruskal-Wallis) was performed due to non-normal residuals.

3.  Post-hoc Analysis: Tukey’s HSD test is used to identify significant differences between treatment groups, and Dunn’s test is applied to non-parametric data for fruit weight.

4.  Statistical Assumptions: Normality is tested using Shapiro-Wilk and Q-Q plots.
    Homoscedasticity is tested using Bartlett’s test.

5.Interpretation: Yield: Significant treatment effects are observed, with no significant block or interaction effects.
Post-hoc tests reveal distinct groups among treatments.
Number of Fruits: Treatment effects are significant, but clustering reduces the significance compared to the total data model.
Block effects remain non-significant.
Fruit Weight: No significant effects were observed through ANOVA, but the Kruskal-Wallis test revealed differences.
Post-hoc analysis suggests some trends but considerable overlap between treatments.

6.  Visualization: Boxplots, histograms, and Q-Q plots are used to visually interpret the behavior of the data, residuals, and treatment effects.

*Key Libraries:* ggplot2, agricolae, FSA: For data visualization and statistical tests.
dplyr: For data manipulation.
multcompView: For interpreting multiple comparisons.

*Results:* Yield: Treatments significantly affected yield, with no block effect or treatment-block interaction.
Number of Fruits: Significant treatment effects are observed, but the clustering reduces the statistical significance compared to total data.
Fruit Weight: Non-parametric tests suggest some significant differences across treatments despite no significant results from the initial ANOVA.

## File 3. Statistical Analysis for Stem Diameter, and Dry Weight (Root and Aerial)

This analysis evaluates the effects of five treatments and block designs on plant growth parameters: stem diameter, aerial dry weight, and root dry weight.
Statistical techniques such as ANOVA, Tukey’s HSD, and diagnostic tests (e.g., Shapiro-Wilk) are employed to assess treatment impacts and validate statistical assumptions.

*Key Steps:* 1.
Data Preparation:

Data on stem diameter and dry weights (aerial and root) is imported from Excel and organized by treatment and block for analysis.
Analysis of Variance (ANOVA):

Stem Diameter: ANOVA identifies significant treatment and block effects, with no significant treatment-block interaction.
Aerial Dry Weight: Neither treatment nor interaction effects are significant, though block effects are marginally significant.
Root Dry Weight: Block effects are significant, but treatment and interaction effects are not.

Post-hoc Analysis:

Tukey’s HSD test reveals significant differences between treatments for stem diameter, with EXAm treatment showing the highest mean diameter.
Statistical Assumptions:

Normality: Residuals for all variables pass the Shapiro-Wilk test, confirming normal distribution.
Interaction Effects: No significant interaction between treatment and block for any variable.
Visualization:

Boxplots and bar graphs with error bars illustrate treatment effects on stem diameter and dry weights.
Q-Q plots and histograms validate normality of residuals.

*Interpretation:* Stem Diameter:

Significant treatment effects are observed.
The EXAm treatment has the largest diameter (\~22.5 mm), while Infes has the smallest (\~17 mm).
Aerial Dry Weight:

No significant differences between treatments or interaction effects.
Block effects are marginally significant.
Root Dry Weight:

Block effects are significant, but treatment and interaction effects are not.

*Key Libraries:* ggplot2: For visualizing treatment effects.
agricolae: For conducting Tukey’s HSD test.
dplyr: For summarizing and manipulating data.
multcompView: For generating significance group letters.

*Results:* Stem Diameter: Treatments significantly influence stem diameter, with EXAm treatment showing the most robust growth.
Aerial Dry Weight: No significant treatment effects are identified, though block effects are marginally impactful.
Root Dry Weight: Significant block effects, but no significant treatment influence.## File 4.
Replication of Statistical Analysis of Biomarkers and Non-enzymatic

## File 4. Statistical Analysis from the Paper (Biomarkers and Non-enzymatic)

This file details the analysis of biomarker and non-enzymatic variable data collected at days 45, 60, 75, 90, and 105 post-transplantation.
The process applies uniformly to all variables, with hydrogen peroxide (H₂O₂) serving as an example.

*Key Steps*

1.  Data Collection Measurements were taken every two weeks, starting from day 45, to evaluate treatment effects on biomarkers and non-enzymatic variables.

2.  Statistical Analysis

The analysis involved:

Initialization: Creating structures to store test results.
Iterative Analysis: For each day, data was filtered, missing values replaced, and statistical tests (ANOVA, Shapiro-Wilk, transformations, Friedman test) were applied.
Post-hoc tests identified significant treatment differences.
Results Compilation: Test outcomes, transformations, and significance were recorded.
Visualization: Bar plots showed mean concentrations, error bars, and statistical significance, with separate panels for each day.

3.  Generalization This standardized workflow was applied to all variables, ensuring consistent, robust analysis across the dataset.

## File 5. Repeated Measurements (Biomarkers and Non-enzymatic)

This file outlines the use of repeated measures analysis for biomarker and non-enzymatic variable data collected at multiple time points (days 45, 60, 75, 90, and 105) post-transplantation.
The approach accounts for the correlation between repeated measurements on the same subjects over time.
H₂O₂ is used as an example for demonstrating the analysis.

1.  Repeated Measures Analysis Repeated measures analysis is employed when the same subjects are measured multiple times under different conditions.
    It accounts for the lack of independence in repeated observations, making it ideal for analyzing data collected over time.

2.  Statistical Model Fixed Effects: The model includes main effects for Treatment and Day, as well as their interaction (Treatment \* Day).
    Random Effects: A hierarchical random-effects structure is used, where random intercepts are specified for both Blocks and Samples.
    This means that variability within each block and between samples within blocks is accounted for.

3.  Post-Hoc Analysis After pairwise comparisons, the Tukey test was replaced by the Sidak adjustment, which is more appropriate for repeated measures data.

4.  Generalization This repeated measures approach is applied to all biomarkers and non-enzymatic variables, ensuring a robust analysis that properly accounts for the repeated nature of the measurements across time.

## File 6. Principal Component Analysis

This file contains the results of a Principal Components Analysis (PCA) on a dataset with biomarkers and non-enzymatic variables.
Numerical variables were filtered to replace missing or invalid values with 0 before performing PCA.
The resulting PCA scores matrix (`pca_result$x`) is included, along with treatment and day information from the original dataset for interpretation.

A scatter plot of the first two principal components (PC1 vs. PC2) is provided, with points colored by treatment and shaped by day.
The plot highlights the separation between treatments and shows how these differences evolve over time, particularly at days 90 and 105.
This file is useful for exploring patterns in the data related to treatment and temporal effects.
