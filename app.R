# ==========================================================
# Load libraries and scripts
# ==========================================================
source("source.R")


# =======================================================
# Define UI
# ========================================================
ui <- fluidPage(
     titlePanel("Drosohila Developmental Single-cell Atlas, 2020 (beta ver.)"),
     #img(src="xx.png", height=. width = "100%")),
     
     tabsetPanel(
          tabPanel("tSNE", fluid = TRUE,
                   sidebarLayout(
                        sidebarPanel(width = 2,
                                     textInput("gene",label = "Gene"),
                                     helpText("tSNE: gene expression in clusters"),
                                     submitButton("Plot")
                                   ),
                        mainPanel(fluidRow(
                                  column(12, plotOutput("tsne")))
                        )
                   )
          ),
          
          tabPanel("Heatmap", fluid = TRUE,
                   sidebarLayout(
                        sidebarPanel(width = 2,
                                     textInput("gene",label = "Gene"),
                                     helpText("Heatmap: compare gene expression in all neurons"),
                                     submitButton("Plot")
                                    ),
                        mainPanel(fluidRow(
                                   column(12, plotOutput("heatmap"), height = "250px"))
                         )
               )
          ),
          
          
          tabPanel("Lineplot", fluid = TRUE,
                   sidebarLayout(
                        sidebarPanel(width = 2,
                                     textInput("cell",label = "Cell type"),
                                     textInput("gene",label = "Gene"),
                                     helpText("Lineplot: gene expression trajectory within a cell type"),
                                     submitButton("Plot")
                        ),
                         mainPanel(fluidRow(
                              column(6, plotOutput("lineplot")))
                         )
                   )
          )
     )
)




# =======================================================
# Define server logic
# ========================================================
server <- function(input, output, session) {
     
     output$tsne <- renderPlot({
          ggplot(cordTSNE, aes(x=tSNE_1, y=tSNE_2)) +
               geom_point(aes(x=tSNE_1, y=tSNE_2), colour = 'lightgrey', alpha = 0.5)+
               geom_point(data = dataTSNE %>% filter(gene == input$gene), 
                          aes(x=tSNE_1, y=tSNE_2, fill=expr), inherit.aes = FALSE) +
               scale_fill_continuous(low = "#132B43",
                                     high = "#56B1F7",
                                     space = "Lab",
                                     na.value = "grey50",
                                     guide = "colourbar",
                                     aesthetics = "fill") +
               theme_void()
          
     })
     
     output$heatmap <- renderPlot({
          ggplot(dataExpr %>% filter(gene == input$gene), aes(fill=expr,x=type1, y=gene)) +
               geom_tile(colour='grey50') +
               scale_fill_gradient(low="white",high="darkblue", na.value = 'white')+
               theme(axis.text.x = element_text(angle=90, hjust=1))
     })
     
     output$lineplot <- renderPlot({
          ggplot(dataExpr %>% filter(type1 == input$cell) %>% filter(gene == input$gene), 
                 aes(x = time, y=expr, fill=gene, group=gene))+
               geom_point() +
               geom_line() +
               theme_minimal()
     })
     
}




shinyApp(ui, server)
