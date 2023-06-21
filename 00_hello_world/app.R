## First Shiny App: Hello World!
## ------------------
library(shiny)

# Define UI ---
ui <- fluidPage("Hello, World!")

# Server logic ---
server <- function(input, output, session) {

}

# call to the app
shinyApp(ui = ui, server = server)
