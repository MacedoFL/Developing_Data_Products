# This is the user-interface definition of a Shiny web application.

library(shiny)

shinyUI(fluidPage(

    # Application title
    titlePanel("Interactive Sensitivity & Specificity Simulation Based on Single Threshold Classification"),

    # Sidebar with simulation parameters
    sidebarLayout(
        sidebarPanel(
            sliderInput("prevalence",
                        "Prevalence of Condition:",
                        min = 0,
                        max = 100,
                        value = 25),
            sliderInput("healthyMean",
                        "Mean of Healthy Population:",
                        min = 30,
                        max = 150,
                        value = 90),
            sliderInput("healthySD",
                        "Standard Deviation of Healthy Population:",
                        min = 0,
                        max = 60,
                        value = 30),
            sliderInput("sickMean",
                        "Mean of Sick Population:",
                        min = 150,
                        max = 300,
                        value = 150),
            sliderInput("sickSD",
                        "Standard Deviation of Sick Population:",
                        min = 0,
                        max = 60,
                        value = 50),
            sliderInput("thresholdValue",
                        "Diagnosis Threshold:",
                        min = 0,
                        max = 300,
                        value = 125)
        ),

        # Show result of similation and help page
        mainPanel(
            tabsetPanel(
                tabPanel("Simulation", plotOutput("distPlot"), htmlOutput("summary")),
                tabPanel("Help", htmlOutput("help"))
            )
        )
    )))
