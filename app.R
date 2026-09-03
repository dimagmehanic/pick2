library(shiny)
library(tidyverse)

source("R/cards.R")
source("R/ui.R")
source("R/server.R")

shinyApp(ui, server)
