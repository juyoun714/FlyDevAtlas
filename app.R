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
     
     sidebarLayout(
          # inputs
          sidebarPanel(
               textInput("cell",label = "Cell type"),
               textInput("gene",label = "Gene"),

               helpText("tSNE: gene expression in clusters",
                        "Heatmap: compare gene expression in all neurons",
                        "Lineplot: gene expression trajectory within a cell type"),
               
               submitButton("Plot")
          ),
          
               tabsetPanel(
                    tabPanel("tSNE", plotOutput("tsne")), 
                    tabPanel("Heatmap", plotOutput("heatmap", height = "100px")), 
                    tabPanel("Line", plotOutput("lineplot"))
               )
          )
     )




# =======================================================
# Define server logic
# ========================================================
server <- function(input, output, session) {
#     genes <- unlist(strsplit(input$gene, ","))
     
     output$tsne <- renderPlot({
          FeaturePlot(dataTSNE, features = input$gene, label = T)+
               theme_void()
          
     })
         
     output$heatmap <- renderPlot({
          ggplot(dataExpr %>% filter(gene == input$gene), aes(fill=expr,x=type1,y=gene)) +
               geom_tile(aes(fill = expr), colour='grey50')+ 
               theme(axis.text.x = element_text(angle=90), hjust=1)
     })
     
     output$lineplot <- renderPlot({
          ggplot(dataExpr %>% filter(type1 == input$cell), aes(x = time, y=expr,fill=gene,group=gene))+
               geom_point() +
               geom_line() +
               theme_minimal()
     })

}




shinyApp(ui, server)
