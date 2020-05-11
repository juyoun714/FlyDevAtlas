#====================================
#SOURCE
# ==================================
library(shiny)
library(Seurat)
library(ggplot2)
library(dplyr)

# get just tSNE coordinates to plot later
#dataA.light <- readRDS("data/dataA.light.rds")
#exprAB.1 <- readRDS("data/exprAB.1.rds")

#tmp0<- FetchData(dataA.light, vars = c("set","rep","time","sample","class1","type1","tSNE_1", "tSNE_2"))

#dataA.light.tsne <- tmp0
#saveRDS(dataA.light.tsne, file = "data/dataA.light.tsne.rds")

# ====================================================== 
# Data loading
# ======================================================
dataTSNE <- readRDS(file = "data/dataTSNE.rds")
dataExpr <- readRDS(file = "data/dataExpr.rds")
cordTSNE <- readRDS(file = "data/cordTSNE.rds")


# =======================================================
# ui variables
# =======================================================
# plotType <- c("tSNE","Heatmap","Lineplot")




# =======================================================
# Server variables and functions
# =======================================================
# 1. tSNE plot
# 2. Heatmap
# 3. Lineplot
#lineplot <- function(data, cell, gene){ 
#     ggplot(data, aes(fill=Gene, y=log.exp, x=Time, group = Gene)) + 
#          geom_point(aes(colour = Gene)) +
#          geom_line(aes(colour = Gene), size = 1.2)+
#          scale_color_got(discrete = TRUE, option = "Daenerys")+
#          theme_minimal()
#}
