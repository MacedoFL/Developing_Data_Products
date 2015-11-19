
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
#library(plyr)


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
        i1 <- input$prevalence
        i1 <- input$healthyMean
        i1 <- input$healthySD
        i1 <- input$sickMean
        i1 <- input$sickSD
        i1 <- input$thresholdValue
        txt <- tags$div(
            tags$h3("Results of Classification by Single Threshold"),
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

})
