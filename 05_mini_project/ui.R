library(shiny)

# Define UI
ui <- fluidPage(
  titlePanel("Survey App"),
  sidebarLayout(
    sidebarPanel(
      # Survey questions
      textInput(inputId = "name", label = "Your Name"),
      helpText("You do not have to give your real age!"), # style = "color:red;"
      numericInput(inputId = "age", label = "Your Age", value = numeric(0)),
      selectInput(inputId = "gender", label = "Your Gender", choices = c("Male", "Female", "Other")),
      checkboxGroupInput(
        inputId = "interests", label = "Your Interests",
        choices = c("Sports", "Music", "Art", "Technology"),
        selected = NULL
      ), # inline = TRUE
      textAreaInput(inputId = "comment", label = "Comment") # placeholder = "What more would you like to say?" , width = 300
      # actionButton(inputId = "submit", label = "Submit") # icon = icon("check"), class = "btn btn-primary"
    ),
    mainPanel(
      # Display responses
      h3("Summary of Responses"),
      textOutput("greet"),
      verbatimTextOutput("summary"),
      hr(),
      h4("Your comment"),
      textOutput("user_comment")
    )
  )
)
