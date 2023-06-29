## First Shiny App: Hello World!
## ------------------
library(shiny)

# Define UI ---
ui <- fluidPage(
  h1("hello world"),
  h2("hello world"),
  h3("hello world"),
  h4("hello world"),
  h5("hello world"),
  h6("hello world"),
  "Hello, World!",
  )

# Server logic ---
server <- function(input, output, session) {

}

# call to the app
shinyApp(ui = ui, server = server)
