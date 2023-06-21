source("helper.R")
# Server
server <- function(input, output) {
  # Data Overview Page
  ## ----------------------

  # Plot
  output$plot1 <- renderPlotly({
    build_scatter_plot(data)
  })

  # Table
  output$table <- renderDataTable({
    # Display the entire dataset using DT
    datatable(data, options = list(pageLength = 20))
  })

  # Summary
  output$summary <- renderPrint({
    # Generate a summary of the dataset
    summary(data)
  })

  # Explore Page
  #-------------------------

  # Create a reactive data
  filter_data <- reactive({
    # salary
    input_03 <- lapply(input$i_slider_textinput, comma_removr) %>% as.integer()
    # Apply filter function
    filter_df(data,
      input_01 = input$i_slider, # age
      input_02 = input$i_numeric_range, # years of exeperience
      input_03 = input_03, # salary
      input_04 = input$i_checkbox,
      input_05 = input$i_checkbox_btn,
      input_06 = input$i_picker
    )
  })


  # Filter data summary
  output$filter_summary_data <- renderPrint({
    summary(filter_data())
  })

  # Table
  output$filtered_table <- renderDataTable({
    datatable(filter_data()) %>%
      formatCurrency(
        columns = "salary",
        currency = "USD",
        mark = ",",
        digits = 0
      )
  })

  # Plot_01
  output$Plot_01 <- renderEcharts4r({
    build_donut_chart(
      filter_data(),
      "gender",
      "Proportional of Gender in data"
    )
  })

  # Plot_03
  output$Plot_03 <- renderEcharts4r({
    build_donut_chart(
      filter_data(), "education_level",
      "Proportion of Educational Levels"
    )
  })

  # Plot_02
  output$Plot_02 <- renderPlot({
    build_column_chart(
      filter_data(),
      "job_title",
      x_label = "Job Title"
    )
  })
}