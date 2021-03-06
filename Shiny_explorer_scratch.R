library(shiny)
library(tidyverse)
library(plotly)
library(dplyr)

args <- commandArgs(trailingOnly=T)

port <- as.numeric(args[[1]])

data2 <- read_csv("derived_data/Overall.csv") %>%filter(StartMo1>0)%>%rename(Relative_difference_in_initator_deaths=RelDiffDeathsImp,Absolute_difference_in_initiator_deaths=AbsDiffDeathsImp,Total_deaths=TotalBDeathsU)



size<-data2%>%select(Relative_difference_in_initator_deaths,Absolute_difference_in_initiator_deaths,Total_deaths)

xdat<-data2%>%select(StartYr1,StartMo1)

#For now keep one color category
ydat<-data2%>%select(WDuratDays,WDuratMo)


#For now keep one color category
col<-data2%>%select(WarTypeD)

  
  
ui<-fluidPage(
  fluidRow(
    column(4,selectInput("X_axis_Category",label="Starting time (calendar scale)",choices=as.list(colnames(xdat)),selected="StartYr1")        
     ),
    column(4,selectInput("Y_axis_Category",label="Total duration of war (calendar scale)",choices=as.list(colnames(ydat)),selected="WDuratDays")           
    ),
     column(4,selectInput("Size_Category",label="Sizing by relative diff,abs diff, or total deaths of given war",choices=as.list(colnames(size)),selected="Total_deaths")
     ),
    column(4,selectInput("Color_Category",label="Color Category (default 1 only)",choices=as.list(colnames(col)),selected="WarTypeD")
    ),
    
   column(12, plotOutput("plotui",brush=brushOpts("plot_brush",resetOnNew=T))),
    column(12,verbatimTextOutput("brush_info")),
    
    wellPanel(width=9,h4("Take cursor and select observations to get war outcome information:"),dataTableOutput("plot_brushed_points")),
  
    
    
    #Suppressed for future panel chanes
    # mainPanel(
    #   
    #   # Output: Tabset w/ plot, summary, and table ----
    #   tabsetPanel(type = "tabs",
    #               tabPanel("Plotui", plotOutput("plotui",brush=brushOpts("plot_brush",resetOnNew=T))),
    #               tabPanel("Summary", verbatimTextOutput("Summary")),
    #               tabPanel("Table", tableOutput("table"))
    #   )
    #   
    # )
    
    )
)

server<-function(input,output){
  
  
 
  dat<-data2  
  #x_means<-reactive({
  #  mean(sample_scores[,input$X_axis_Category])
  #})
  y_means<-reactive({
    mean(data2[,input$Y_axis_Category])
    
  })
  #size_means<-reactive({
  #  mean(data2[,input$Size_Category])
    
#  })
  
  
  x_var<-reactive({
    as.character(input$X_axis_Category)
  })
  
  y_var<-reactive({
    as.character(input$Y_axis_Category)
  })
  
  output$plotui= renderPlot({
    
    pc<-ggplot(data2,aes_string(x=input$X_axis_Category,y=input$Y_axis_Category,size=input$Size_Category,colour=input$Color_Category))+
      geom_point()+facet_grid(~Americas)+theme(legend.title = element_blank())
    
    
   pc
  })
  
 # output$Table <- renderTable({
  output$plot_brushed_points<-renderDataTable({
    res<-brushedPoints(dat,input$plot_brush)
    subset_res<-subset(res,select=c(WarName,Initiator,StartYr1,WDuratDays,Relative_difference_in_initator_deaths,Total_deaths,WarTypeD,OutcomeE))
    
  #  output$table1 <- renderDataTable(print(subset_res))
      
   subset_res
    
   
   
    
    })
  
 # })
  
  
  #Currently suppressed but in process for additional summary tabs
 # output$Summary <- renderPrint({
  # output$plot_brushed_points<-renderDataTable({
  #   res<-brushedPoints(dat,input$plot_brush)
  #   subset_res<-subset(res,select=c(WarName,Initiator,StartYr1,WDuratDays,RelDiffDeathsImp,TotalBDeathsU,WarTypeD,OutcomeE))
  # 
  # 
  # 
  #    subset_res %>% group_by(StartYr1) %>%summarize(mean_TotalBDeathsU = mean(TotalBDeathsU, na.rm = TRUE),Exposure=mean(WDuratDays))
  # 
  # 
  # })
 # })
 
  #output$brush_info<-renderPrint({
 #   h4("Demo - brushedPoints - Interactive plots - select data points in plot - return the rows of data that are selected by brush")
    
  #  cat("input$plot_brush:\n")
  #  str(input$plot_brush)
#  })
  
  
}


print(sprintf("Starting shiny on port 8788"));
shinyApp(ui = ui, server = server, options = list(port=port, host="0.0.0.0"))
