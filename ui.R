library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Generating a sampling distribution"),
  
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
        actionButton("sample", "Draw a new sample!"),
        actionButton("reset", "Reset!"),
        checkboxInput("density", "Density curve", F),
        verbatimTextOutput("dscdata")
      )
    ),
    
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
