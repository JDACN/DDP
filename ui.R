
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(plotly)

shinyUI(fluidPage(


  # css
      tags$head(
            tags$style(HTML("
                            @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
                           
                            h4, li a {
                            font-family: 'Georgia', 'Serif';
                            font-weight: 500;
                            line-height: 1.3;
                            color:#428bca;
                            }

                            h1 {
                            font-family: 'Lobster', cursive;
                            font-weight: 900; line-height: 1.1; 
                            color: #4d3a7d;
                            }
                              
                           body {
                              background-color: #fff;
                            }
                            
                            "))
            ),

  # Application title

  headerPanel("Motor Trend Car Road Tests"),

  # Sidebar with a slider input for number of bins
  
  sidebarLayout(
    sidebarPanel(

          h4("Graph Settings"),      
          
          selectInput("chartType", "Chart Type:",
                      c("Box Plot" = "box",
                        "Scattered" = "point",
                        "Histograph" = "hist")),
          checkboxInput("stat", "Show Linear Regression / Normal Distribution", FALSE),
          
          # Input: Select the Theame type ----
          radioButtons("theame", "Theame type:",
                       c("Normal" = "norm",
                         "Black & White" = "bw",
                         "Dark" = "dark",
                         "linedraw" = "line")),
          

      hr(),
      h4("Table Settings"),
      sliderInput("obs",
                  "Number of observations shown in Table:",
                  min = 1,
                  max = 32,
                  value = 20)
      
     
    ),
   
  

    # Show a plot of the generated distribution
    mainPanel(
          tabsetPanel(
                tabPanel("Plot",
                         br(),
                         
                         plotlyOutput("distPlot" , height = "100%")
                         ),
                tabPanel("Table", tableOutput("table")),
                tabPanel("Summary", 
                         h2("Dataset: mtcars"),
                         verbatimTextOutput("summary"),
                         verbatimTextOutput("tableInfo"),
                         
                         div(class="header", checked=NA,
                             p("Find more information on dataset ", 
                               a(href="https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/mtcars.html", "here!")
                               )
                             
                         )
                         ),
                tabPanel("About",
                         div(class="header", checked=NA,
                              br(),
                              p( "This is Shiny application developed as part of Coursera Assignment: Course Project: Shiny Application and Reproducible Pitch" ),
                              p( " Developed By : Jayant Dhawale"),
                              p( " "),
                             div(class="header", checked=NA,
                                 p("Source code and other documentation avilable at", 
                                   a(href="https://github.com/JDACN/DDP", "https://github.com/JDACN/DDP")
                                 ))
                             )
                         )
               
          )
    )
  )
))
