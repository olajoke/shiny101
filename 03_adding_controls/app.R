## Adding UI Controls
## ------------------

library(shiny)

# Define UI objects
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("input_data",
        label = "Choose a data:",
        choices = ls(package:datasets)
      )
    ),
    mainPanel(
      br(),
      h4("VerbatimTextOutput here:"),
      verbatimTextOutput("display_summary"),
      br(),
      h4("tableOutput below:"),
      tableOutput("display_table")
    )
  )
)

# Server logic
server <- function(input, output) {

}

# Caller function to the app
shinyApp(ui = ui, server = server)
