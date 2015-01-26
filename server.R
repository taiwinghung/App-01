# server.R

library(quantmod)
source("helpers.R")


shinyServer(function(input, output) {
  
  dataInput <- reactive({  
    getSymbols(input$symb, src = "yahoo", 
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
  })
  
  finalInput <- reactive({
#    if (!input$adjust) return(dataInput())
    adjust(dataInput())
  })

  output$plot <- renderPlot({
    chartSeries(finalInput(), theme = chartTheme("white"), 
                type = "line", log.scale = input$log, TA = NULL)
    
    #add_Series(finalInput_1())
  })
#output$plot <- renderPlot({
  
#  add_Series(ma(dataInput()))
  
  #add_Series(finalInput_1())
#})

})
