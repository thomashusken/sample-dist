#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  titlePanel("Generating a sampling distribution"),
  
  # Sidebar with a slider input for number of bins 
  fluidRow(
    column(4,
      wellPanel(
        headerPanel("Distribution of the data"),
        numericInput("n", "Number of observations to sample:", 100),
        fluidRow(
          column(6,
                 numericInput("mu", "Population Mean", 0)
          ),
          column(6, 
                 numericInput("sigma", "Population SD", 1)
          )         
        ),
        # fluidRow(
          # column(4,
                  actionButton("sample", "Draw a new sample!")
        #   ),
        #   column(4,
        #          numericInput("times", label = "", value = 1)
        #   ),
        #   column(4,
        #          "new samples"
        #   )
        # )
        ,
        actionButton("reset", "Reset!"),
        checkboxInput("density", "Density curve", F),
        verbatimTextOutput("dscdata")
      )
    ),
    
      # Show a plot of the generated distribution
    column(8,
      plotOutput("hist")
    )
  ),
  fluidRow(
    column(4,
      wellPanel(
        headerPanel("Sampling distribution of the mean"),
        verbatimTextOutput("desc"),
        checkboxInput("denssamp", "Density curve", F)
      )
    ),
    column(8,
      plotOutput("dist")
    )
  )
))
