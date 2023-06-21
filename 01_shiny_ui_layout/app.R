## Shiny UI layout
## ------------------

library(shiny)
# Define UI
ui <- fluidPage(
  titlePanel("App Title"),
  sidebarLayout(
    sidebarPanel("The sidebar panel"),
    mainPanel("The main panel")
  )
)
# Define server logic
server <- function(input, output) {}

# Caller function to the app
shinyApp(ui = ui, server = server)
