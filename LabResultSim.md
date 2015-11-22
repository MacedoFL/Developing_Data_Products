Lab Result Classifying Simulator
========================================================
author: Antonio Macedo
date: 11/19/2015

Overview
========================================================

## The Lab Result Classifying Simulator is an educational app.
## Facilitates the understanding of
### Simple classification.
### Average and Standard Deviation.
### Sensitivity and Specificity.
## Targets students, techincians and the general public.


How it Works
========================================================

This app generates random "lab result" values for two patient classes.

- Healthy
- Sick

The user can select the following parameters.
- Prevalence
- Threshold Value
- Mean value for Healthy Lab Results
- Standard Deviation for Healthy Lab Results
- Mean value for Sick Lab Results
- Standard Deviation for Sick Lab Results

Simulation
========================================================

## The app uses prevalence to split healthy and sick groups out of 2000 hypotetical patients.
### So if prevalence is 25%, the Healthy group will have 1500 patients and the sick group will have 500 patients.
## It uses the selected mean and standard deviation, to generate "lab result" data for healthy and sick groups.
### This is our training data.
## Then it uses the selected threshold to classify the lab results as healthy and sick.
### The hipotetical desease severity affects the best threshold value.


Result
========================================================

## The bar chart shows different colors based on class, overlap and missclassification.
## The summary report shows values for
### Sensitivity
### Specificity
### Accuracy
### True/False by Positive/Negative Counts
## It allows users to explore how the parametrs affect the performance of a classifier.
## The takeaway is that there is allways a grey area and any realistic classifier has to deal with mistakes.


