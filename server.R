#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  data      <- reactiveValues(data = data.frame(x = isolate(rnorm(input$n, input$mu, input$sigma))))
  mean      <- reactiveValues(mean = data.frame(m = isolate(mean(data$data$x))))
  observeEvent(input$sample, {
    data$data <- data.frame(x = rnorm(input$n, input$mu, input$sigma))
    mean$mean <- data.frame(m = rbind(mean$mean, mean(data$data$x)))
    }
  )
  
  observeEvent(input$reset, {
    data$data      <- data.frame(x = rnorm(input$n, input$mu, sd = input$sigma))
    mean$mean      <- data.frame(m = mean(data$data$x))
  })
  
  output$hist <- renderPlot({
    bw <- diff(range(data$data$x)) / (2 * IQR(data$data$x) * length(data$data$x)^(1/3))
    p <- ggplot(data = data$data, aes(x = x, y = ..density..)) + geom_histogram(binwidth = bw) + theme_bw() +
      scale_x_continuous(limits = c(-5*input$sigma, 5*input$sigma)) + scale_y_continuous(limits=c(0,1))
    l <- geom_vline(xintercept = mean(data$data$x), col = "red")
    p <- p + l
    if(input$density){
      d <- geom_density(data = data$data, kernel = "gaussian", col = "red", lwd = 1.2)
      p <- p + d
    }
    p
  })
  
  output$dscdata <- renderPrint({
    cat("Sample mean:", mean(data$data$x),"\n","Sample SD:", sd(data$data$x)) 
  })
  
  output$dist <- renderPlot({
    s <- ggplot(data = mean$mean, aes(x = m)) + geom_histogram(binwidth = 0.05) + theme_bw() +      
      scale_x_continuous(limits = c(-5*input$sigma, 5*input$sigma)) + scale_y_continuous(limits = c(-0.1,20))
    if(input$denssamp){
      ds <- geom_density(data = mean$mean, kernel = "gaussian", col = "blue", lwd = 1.2)
      s  <- s + ds
    }
    s
  })
  
  output$desc <- renderPrint({
    cat("Mean:", mean(mean$mean$m, na.rm = T),"\n","SE:", sd(mean$mean$m, na.rm = T))
  })
  
})
