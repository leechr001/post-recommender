library("shiny")

source("app_server.r")
source("app_ui.r")

shinyApp(ui = app_ui, server = app_server)
