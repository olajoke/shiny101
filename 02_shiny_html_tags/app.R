## Shiny app built with Shiny Html Tags
## ------------------


library(shiny)

# Define UI objects
ui <- fluidPage(
  titlePanel("My Shiny App"),
  sidebarLayout(
    sidebarPanel(
      h2("Installation"),
      p("Shiny is available on CRAN, so you can install it in the usual way from your R console:"),
      code('install.packages("shiny")'),
      br(),
      br(),
      br(),
      br(),
      img(src = "rstudio-logo.png", height = 70, width = 200),
      br(),
      "Shiny is a product of ",
      span("RStudio", style = "color:blue")
    ),
    mainPanel(
      h1("Introducing Shiny"),
      p(
        "Shiny is a new package from RStudio that makes it ",
        em("incredibly easy "),
        "to build interactive web applications with R."
      ),
      br(),
      p(
        "For an introduction and live examples, visit the ",
        a("Shiny homepage.",
          href = "https://shiny.posit.co"
        )
      ),
      br(),
      h2("Features"),
      p("- Build useful web applications with only a few lines of code—no JavaScript required."),
      p(
        "- Shiny applications are automatically 'live' in the same way that ",
        strong("spreadsheets"),
        " are live. Outputs change instantly as users modify inputs, without requiring a reload of the browser."
      ),
      br(),
      br(),
      br(),
      p(
        a("source: shiny posit",
          href = "https://shiny.posit.co/r/getstarted/shiny-basics/lesson2/",
          style = "font-size: 12px; color:lightgray; font-style: italic; float:right;"
        )
      )
    )
  )
)

# Server logic ----
server <- function(input, output) {}

# Caller App function ---
shinyApp(ui = ui, server = server)
