library(shiny)

# Define server logic
server <- function(input, output) {
  output$summary <- renderText({
    # Generate summary of responses
    paste(
      " Name: ", input$name, "\n",
      "Age: ", input$age, "\n",
      "Gender: ", input$gender, "\n",
      "Interests: ", paste(input$interests, collapse = ", "), "\n"
    )
  })

  output$greet <- renderText({
    paste0("Hello, ", stringr::str_to_title(input$name), "!")
  })

  output$user_comment <- renderText({
    input$comment
  })
}

####################################
## Please do not uncomment yet!  ##
###################################

# server <- function(input, output) {
#
#   # Store survey responses
#   survey_data <- reactiveValues(name = character(),
#                                 age = numeric(),
#                                 gender = character(),
#                                 interests = character(),
#                                 comment = character()
#                                 )
#   observeEvent(input$submit, {
#     # Save survey responses
#     survey_data$name <- input$name
#     survey_data$age <- input$age # req(input$age)
#     survey_data$gender <- input$gender
#     survey_data$interests <- input$interests
#     survey_data$comment <- input$comment
#
#     if (is.null(input$name) || input$name == "") {
#       survey_data$name <- "Not given"
#     }
#   })
#
#
#   output$summary <- renderText({
#     # Generate summary of responses
#     paste(
#       " Name: ", survey_data$name, "\n",
#       "Age: ",   survey_data$age, "\n",
#       "Gender: ", survey_data$gender, "\n",
#       "Interests: ", paste(survey_data$interests, collapse = ", "), "\n"
#     )
#   })
#
#   output$greet <- renderText({
#     paste0("Hello, ", stringr::str_to_title(survey_data$name),"!")
#   })
#
#   output$user_comment <- renderText({
#     survey_data$comment
#   })
# }
