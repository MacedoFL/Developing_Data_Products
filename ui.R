
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Sensitivity & Specificity"),

  # Sidebar with a slider input for number of bins
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

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      htmlOutput("summary")
      #verbatimTextOutput("summary")
    )
  )
))
