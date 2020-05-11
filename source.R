#====================================
#SOURCE
# ==================================
library(shiny)
library(Seurat)
library(ggplot2)
library(dplyr)

# ====================================================== 
# Data loading
# ======================================================
dataTSNE <- readRDS(file = "data/dataTSNE.rds")
dataExpr <- readRDS(file = "data/dataExpr.rds")
cordTSNE <- readRDS(file = "data/cordTSNE.rds")


# =======================================================
# ui variables
# =======================================================




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
