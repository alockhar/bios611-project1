library(shiny)
library(tidyverse)
library(plotly)
library(dplyr)

args <- commandArgs(trailingOnly=T)

#port <- as.numeric(args[[1]])

data <- read_csv("derived_data/Overall.csv") 
  
 # ggplot(data, 
 #       aes(x = StartYr1, y = WDuratDays,size=TotalBDeathsU,color=WarTypeD)) +
 #   geom_point(show.legend = FALSE)+facet_grid(~Americas)+ylab('Total Expsure (Days)')+xlab('Start year')+ labs(color='War Type')+theme(legend.title = element_blank())


#stats <- data %>% select(WDuratDays, Americas,RelDiffDeathsImp,WarTypeD,TotalBDeathsU) %>% names();
#out_vars=c("Total Deaths","Relative Difference in deaths")

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Relationship of exposure by Americas indicator?"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      div("Do total deaths depend on year and hemisphere?"),
      
      # Input: Slider for the number of deaths ----
      sliderInput(inputId = "TotalBDeathsU",
                  label = "TotalBDeathsU:",
                  min = 500,
                  max = 50000,
                  value = 50000),

      
      sliderInput(inputId = "RelDiffDeathsImp",
                  label = "RelDiffDeathsImp:",
                  min = 0,
                  max = .55,
                  value = .55),
      
     
      
      
      # selectInput(inputId = "stat",
      #             label="Select Stat",
      #             choices=stats),
      
      selectInput(inputId = "deathType",
                  label = "Death Type",
                  choices=c("Total Deaths","Relative Difference in deaths")),
      
      selectInput(inputId = "WarTypeD",
                  label = "War Type:",
                  choices=data$WarTypeD,
                  selected =data$WarTypeD ),
      
      uiOutput("selected_wartype")
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      plotlyOutput(outputId = "geomPlot")
      
    )
  )
)

server <- function(input, output) {
  
  output$selected_wartype<-renderUI({
    checkboxGroupInput(inputId = "show_levels",label="Select category/ies to represent:",choices=choices_wt(), selected = choices_wt())})
    
    choices_wt<-reactive({return(levels(input$WarTypeD[[1]]))   })
  
       output$geomPlot <- renderPlotly({
    
    #stat <- input$stat;
    #TotalDeathsU <- input$TotalDeathsU;
    
    # if(input$plotType=="histogram"){
    #   ggplotly(ggplot(data, aes(WDuratDays))+geom_histogram(aes(y = (..count..)/sum(..count..),fill=Americas),
    #                                                          position="dodge",
    #                                                          bins=bins));
    # }
       #data2<-select(data,input$TotalBDeathsU,input$RelDiffDeathsImp, StartYr1,WDuratDays,input$WarTypeD)%>%filter(!!(as.name(input$WarTypeD)) %in% input$show_levels)
    
    if(input$deathType=="Total Deaths"){
    ggplot(data, 
           aes(x = StartYr1, y = WDuratDays,size=input$TotalBDeathsU,color=input$WarTypeD)) +
      geom_point(show.legend = FALSE)+facet_grid(~Americas)+ylab('Total Expsure (Days)')+xlab('Start year')+ labs(color='War Type')
    }
    else {
     # d <- data[[stat]];
     # mn <- min(d);
     # mx <- max(d);
      #bw <- (mx-mn)/bins;
      #ggplotly(ggplot(data, aes(WDuratDays))+geom_density(aes(fill=Americas),
                                                        #   alpha=0.3,
                                                          # bw=bw));
      
    
      ggplot(data, 
             aes(x = StartYr1, y = WDuratDays,size=input$RelDiffDeathsImp,color=input$WarTypeD)) +
        geom_point(show.legend = FALSE)+facet_grid(~Americas)+ylab('Total Expsure (Days)')+xlab('Start year')+ labs(color='War Type')+theme(legend.title = element_blank())
      
      
      
      
      }
    
  })
  
}

# ggplot(data, aes(WDuratDays)) + 
 #   geom_histogram(aes(y = (..count..)/sum(..count..),fill=Americas)) +
 #   theme(plot.title = element_text(hjust = 0.5))+xlab('Total days of war')+ylab('Proportion of total wars by Americas group')




print(sprintf("Starting shiny on port 8788"));
shinyApp(ui = ui, server = server, options = list(port=8788, host="0.0.0.0"))