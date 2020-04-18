library(shiny)
library(Seurat)
library(tidyverse)
library(ggplot2)
library(dplyr)
library(gameofthrones)


## 0. Data loading
data <- readRDS(file = "expDat.rds")

# expDat <- vroom::vroom(expDat.tsv)



## 1. tSNE plot


## 2. Heatmap


## 3. Lineplot
lineplot <- function(data, cell, gene){ 
     ggplot(data, aes(fill=Gene, y=log.exp, x=Time, group = Gene)) + 
          geom_point(aes(colour = Gene)) +
          geom_line(aes(colour = Gene), size = 1.2)+
          scale_color_got(discrete = TRUE, option = "Daenerys")+
          theme_minimal()
}





## 4. ShinyApp setup

plotType <- c("tSNE","Heatmap","Lineplot")
ui <- fluidPage(
     titlePanel("Drosohila Developmental Single-cell Atlas, 2020 (beta ver.)"),
     sidebarLayout(
          # inputs
          sidebarPanel(
               textInput("cell",label = "Cell type"),
               textInput("gene",label = "Gene"),
               radioButtons("rb", "Plot",
                            choiceNames = list("tSNE","Heatmap","Lineplot"),
                            choiceValues = list("tSNE","heatmap","lineplot")
               ),
               actionButton("click","Plot")
          ),
          # outputs
          mainPanel(
               plotOutput("lineplot", width = "100%")
               # x1 <- eventReactive(input$click,{
               #     input$gene, input$celltype, input$plot
               # })
          )
     )
)


server <- function(input, output, session) {
     # back end logic
     pdat_line <- reactive(data %>% filter(Cell == input$cell) %>% filter(Gene %in% input$gene))
     pdat_heat <- reactive(data %>% filter(Gene %in% input$gene))
     
     if(input$Plot == "lineplot"){
     output$lineplot <- renderPlot({
          ggplot(pdat_line(), aes(fill=Gene, y=log.exp, x=Time, group = Gene)) + 
               geom_point(aes(colour = Gene)) +
               geom_line(aes(colour = Gene), size = 1.2)+
               scale_color_got(discrete = TRUE, option = "Daenerys")+
               theme_minimal()
     })
     }
     
#     if(input$Plot == "heatmap"){
#     output$heatmap <- renderPlot({
#          ggplot(pdat_heat(), aes(fill=log.exp, y=Gene, x=Time))+
#               geom_tile()+
#               theme_classic()
#     })
#     }
     
}

shinyApp(ui, server)

