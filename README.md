# "Data" project

This is the final project for the subject "Data Acquisition Analysis and Scientific Methods for Life Sciences" shorted as "Data" from the first course of the Master Plant Health at the Universitat Politècnica de València.

In this project the students chose a scientific article and redo all possible statistic analyses and graphics from it, trying different approaches to see if they can improve them. They will use the data included in the article and follow the Material and methods chapter as a guide.

## Group members

Group D: 

Dana Mariya Eugenio, Qingyang Gao, Selam Aknaw Mekonnen, Mariana Lucia Rojas.

## Chosen article

[Impact of *Argemone mexicana* L. on tomato plants infected with *Phytophthora infestans*](https://peerj.com/articles/16666/)

The data is available in the supplemental Information as an excel file. <https://dfzljdn9uc3pi.cloudfront.net/2024/16666/1/Data.xlsx>

## Proposal

The study aimed to evaluate the potential of *Argemone mexicana* L. extract as a control agent against *Phytophthora infestans* in tomatoes. Specifically, the researchers sought to assess the extract's antifungal effectiveness, its impact on agronomic traits such as: fruit yield, number of fruit, fruit weight, stem diameter, dry weight (aerial and root), and its ability to mitigate oxidative stress in infected plants. Through the assessment of biomarkers and Non- enzymatic compounds. They compared the performance of the plant extract to a conventional fungicide (captan) and untreated controls to determine its efficacy. Additionally, the study intended to explore whether the extract could serve as both a protective and growth-promoting agent in sustainable agriculture.

You have a lot of work arranging the data into a table you can work with. 

Besides the analyses you propose, I want you to try a principal components analysis at least for the non-enzimatic composition.

### Main hypotheses

-   Hypothesis 1: *Argemone mexicana* L. extract has significant antifungal activity against *Phytophthora infestans* comparable to or exceeding that of captan.

-   Hypothesis 2: Application of the extract improves plant growth metrics (e.g., leaf weight, fruit yield) and reduces oxidative stress markers.

-   Hypothesis 3: The extract promotes higher antioxidant levels (e.g., vitamin C) and mitigates damage from oxidative stress (e.g., MDA levels) compared to untreated plants.

### Analyses needed or intended

1.  Organize the data in long tables in order to make it easier to analyse, do the data validation, create a data dictionary.

2.  Statistical analysis:

The data of the article is divided in four different categories: Severity of disease in time, agronomic traits, bio markers and Non-enzymatic assesments. We will replicate the same analysis of the paper, prove the statistical assumptions. Analyse which is the best test for presenting and analyzing the results.

*A) Plant Health Metrics* (Evaluate morphological parameters: Fruit yield (clusters), average of fruit weight, number of fruit (clusters),stem diameter, and dry weight):

-   ANOVA Purpose: To assess differences in growth-related variables among treatments.

-   Post Hoc Test: For pairwise comparisons across multiple treatments, replicate Fisher test and compare with Tukey HSD. If it is necessary, perform a transformation of the data. If assumptions for ANOVA are violated (non-normality or unequal variances), use a non-parametric treatment.

*B) Biomarkers and Non-enzymatic Assays* (Quantify Antioxidant Activity, Defense Enzymes, Chlorophyll Content):

-   ANOVA Purpose: To assess differences in growth-related variables among treatments.

-   Post Hoc Test: For pairwise comparisons across multiple treatments, replicate Fisher test and compare with Tukey HSD. If it is necessary, perform a transformation of the data. If assumptions for ANOVA are violated (non-normality or unequal variances), use a non-parametric treatment.

*C) Statistical Analysis for Treatment Efficacy*:

-   Replicate the analysis of the paper: Repeated Measures Analysis, for determinig the severity of pathogen suppression over time. Use Hotelling's T² test for pairwise comparisons.

3.  Perform a Repeated Measures Analysis for the other variables that were taken throughout time. Create new plots showing the correlation between variables like principal component, among others.

## Files description

## Protocol
