# This is the server logic for a Shiny web application.

library(shiny)
library(ggplot2)

shinyServer(function(input, output) {

    popTot <- 2000

    output$distPlot <- renderPlot({

        # Generate Data Based on Input Parameters
        set.seed(7722)
        popSick <- popTot * input$prevalence / 100
        popHealthy <- popTot - popSick
        pop_h <- rnorm(popHealthy, mean = input$healthyMean, sd = input$healthySD)
        pop_s <- rnorm(popSick, mean = input$sickMean, sd = input$sickSD)
        df_pop_h <- data.frame(test = pop_h, sick = FALSE)
        df_pop_s <- data.frame(test = pop_s, sick = TRUE)
        df_pop <- rbind(df_pop_h, df_pop_s)
        sep <- input$thresholdValue
        TN <<- nrow(df_pop[df_pop$sick == FALSE & df_pop$test < sep,])
        FP <<- nrow(df_pop[df_pop$sick == FALSE & df_pop$test >= sep,])
        FN <<- nrow(df_pop[df_pop$sick == TRUE & df_pop$test < sep,])
        TP <<- nrow(df_pop[df_pop$sick == TRUE & df_pop$test >= sep,])
        TPR <<- TP / (TP+FN)
        SPC <<- TN / (TN+FP)
        ACC <<- (TP + TN) / (TP + FP + FN + TN)

        # Draw Plot
        ggplot(df_pop, aes(x = test)) +
            geom_bar(data=subset(df_pop, sick== FALSE), stat='bin', binwidth = 5,  fill = 'blue', alpha = 0.5) +
            geom_bar(data=subset(df_pop, sick== TRUE), stat='bin', binwidth = 5,  fill = 'red', alpha = 0.5) +
            geom_bar(data=subset(df_pop, sick== FALSE & test >= sep ), stat='bin', binwidth = 5,  fill = 'blue', alpha = 0.5) +
            geom_bar(data=subset(df_pop, sick== TRUE & test < sep ), stat='bin', binwidth = 5,  fill = 'red', alpha = 0.5)  +
            geom_vline(xintercept = sep, linetype=2, size=1.1)

    })

    output$summary <- renderUI({
        # Generate summary report
        i1 <- input$prevalence
        i1 <- input$healthyMean
        i1 <- input$healthySD
        i1 <- input$sickMean
        i1 <- input$sickSD
        i1 <- input$thresholdValue
        txt <- tags$div(
            tags$h3("Results"),
            tags$h4(paste("Sensitivity:", round(TPR, 3))),
            tags$h4(paste("Specificity:", round(SPC, 3))),
            tags$h4(paste("Accuracy:", round(ACC, 3))),
            tags$h4(paste("True Negative:", TN)),
            tags$h4(paste("True Positive:", TP)),
            tags$h4(paste("False Negative:", FN)),
            tags$h4(paste("False Positive:", FP))
        )
        txt
    })

    output$help <- renderUI({
        # Generate help page
        tags$div(tags$h4('Overview'),
                 tags$p('This simulation creates hipotetical test results for healty and sick patients.'),
                 tags$p('Then it uses a single threshold value to classify patients as healty or sick.'),
                 tags$p('While there is an overlap between both groups, we cannot get a perfect classification.'),
                 tags$p('So, play with the controls to see how it affects the classification performance.'),
                 tags$h4('Plot'),
                 tags$p('The plot shows the healty group in blue and the sick group in red.'),
                 tags$p('The classification threshold shows as a vertical dottet line.'),
                 tags$p('The overlaping area above and below the threshold show in darker colors. That is where the misclassification happens.'),
                 tags$h4('Results'),
                 tags$p('The result report shows values for the following items:'),
                 tags$li('Sensitivity: True positive rate for the classification'),
                 tags$li('Specificity: True negative rate for the classification'),
                 tags$li('Accuracy: The overall accuracy for the classification'),
                 tags$li('True Negative: Healty patients correctlly classified as healty'),
                 tags$li('True Positive: Sick patients correctlly classified as sick'),
                 tags$li('False Negative: Sick patients misclassified as healty'),
                 tags$li('False Positive: Healty patients misclassified as sick'),
                 tags$a(href="en.wikipedia.org/wiki/Sensitivity_and_specificity", "Read more about sensitivity and specificity on Wikipedia."),
                 tags$h4('Controls'),
                 tags$li('Prevalence of Condition: percentage of sick people in the population.'),
                 tags$li('Mean of Healthy Population: average test result values for the healty group.'),
                 tags$li('Standard Deviation of Healthy Population: standard deviation of test result values for the healty group.'),
                 tags$li('Mean of Sick Population: average test result values for the sick group.'),
                 tags$li('Standard Deviation of Sick Population: standard deviation of test result values for the sick group.'),
                 tags$li('Diagnosis Threshold: threshold for classification, test values below the threshold are considered as healty.')
                 )

        })
})
