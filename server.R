
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
library(plotly)

shinyServer(function(input, output) {

  output$distPlot <- renderPlotly({

      if (input$chartType == 'point')
      {
           p <- ggplot(data=mtcars , aes(x=disp, y=mpg, color=factor(cyl) )) +   geom_point() +
                 labs( color = "Cylinders" )+
                 xlab('Displacement (cu.in.)') +
                 ylab('Miles/(US) gallon')
           if (input$stat == TRUE)
           {
                 p <- p + geom_smooth(method = "lm") 
           }
      }
    
    else if (input$chartType == 'hist')
    {      
    # draw the histogram with the specified number of bins
    p <- ggplot(mtcars, aes(x=mpg)) + 
          geom_histogram(binwidth=2, colour="black", aes(y=..density.., fill=..count..))+
          xlab('Miles/(US) gallon')
      
      if (input$stat == TRUE)
      {
           p <- p + stat_function(fun=dnorm,
                                     color="red",
                                     args=list(mean=mean(mtcars$mpg), 
                                               sd=sd(mtcars$mpg)))
      }
    }
    else
    {
      p <-qplot(factor(cyl), mpg, data = mtcars, geom = "boxplot") +
            ylab('Miles/(US) gallon') +
            xlab('Cylinders')
   
    }

        # Theame managment
        if (input$theame == 'bw'){
              p <- p  + theme_bw()
        }
        else if (input$theame == 'dark'){
              p <- p  + theme_dark()
        }
        else if (input$theame == 'line'){
              p <- p  + theme_linedraw()
        }
        
    ggplotly(p)
  })
  
  # Generate a summary of the dataset
  output$summary <- renderPrint({
                summary(mtcars)
  })
  
  # Generate table
  
  output$table <- output$view <- renderTable({
        head(mtcars , addrownumsmt = TRUE, n = input$obs )}, include.rownames=TRUE
  )
   
  
  # mtcars table info
 output$tableInfo <-  renderText({"A data frame with 32 observations on 11 variables"})

})
