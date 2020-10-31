library(shiny)
library(tidyverse)
library(plotly)


args <- commandArgs(trailingOnly=T)

port <- as.numeric(args[[1]])

data <- read_csv("derived_data/Overall.csv") 
  

stats <- data %>% select(-WDuratDays, -Americas) %>% names();


# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Days of exposure by Americas indicator"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      div("How do super hero powers depend on their moral alignment?"),
      
      # Input: Slider for the number of bins ----
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      
      selectInput(inputId = "stat",
                  label="Select Stat",
                  choices=stats),
      
      selectInput(inputId = "plotType",
                  label = "Plot Type",
                  choices=c("histogram","density plot"))
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      plotlyOutput(outputId = "distPlot")
      
    )
  )
)

server <- function(input, output) {
  
  output$distPlot <- renderPlotly({
    
    stat <- input$stat;
    bins <- input$bins;
    
    if(input$plotType=="histogram"){
      ggplotly(ggplot(data, aes_string(WDuratDays))+geom_histogram(aes(y = (..count..)/sum(..count..),fill=Americas),
                                                             position="dodge",
                                                             bins=bins));
    } else {
      d <- data[[stat]];
      mn <- min(d);
      mx <- max(d);
      bw <- (mx-mn)/bins;
      ggplotly(ggplot(data, aes_string(WDuratDays))+geom_density(aes(fill=Americas),
                                                           alpha=0.3,
                                                           bw=bw));
      
    }
    
  })
  
}

 ggplot(data, aes(WDuratDays)) + 
    geom_histogram(aes(y = (..count..)/sum(..count..),fill=Americas)) +
    theme(plot.title = element_text(hjust = 0.5))+xlab('Total days of war')+ylab('Proportion of total wars by Americas group')




print(sprintf("Starting shiny on port %d", port));
shinyApp(ui = ui, server = server, options = list(port=port, host="0.0.0.0"))