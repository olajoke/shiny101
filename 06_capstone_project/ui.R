library(shiny)
library(shinythemes)
library(shinyWidgets)
library(dplyr)
library(ggplot2)
library(DT)
library(plotly)

source("helper.R")

# UI layout with navbarPage()
ui <- navbarPage(
  title = "Data Exploration App",
  theme = shinytheme("flatly"),
  includeCSS("www/style.css"),

  # First tab on the navbarPage
  navbarMenu(
    "Data Overview",
    icon = icon("list-alt"),
    tabPanel("Table", icon = icon("table"), dataTableOutput("table")),
    tabPanel("Trend", icon = icon("arrow-trend-up"), plotlyOutput("plot1")),
    tabPanel("Summary", icon = icon("info"), h4("Data Summary:"), verbatimTextOutput("summary"))
  ),

  # Second tab on the navbarPage
  tabPanel("Explore data",
    icon = icon("magnifying-glass"),
    # Tab structured with a sidebar Layout
    sidebarLayout(
      # Define Input Widgets on the sidebar
      sidebarPanel(
        h4("Select Options to Filter"),
        br(),
        sliderInput(
          inputId = "i_slider",
          label = "Filter by Age:",
          value = c(min(data$age), max(data$age)),
          step = 1,
          min = min(data$age),
          max = max(data$age)
        ),
        br(),
        checkboxGroupInput(
          inputId = "i_checkbox",
          label = "Choose Gender:",
          choices = unique(data$gender),
          selected = unique(data$gender),
          inline = TRUE
        ),
        br(),
        shinyWidgets::checkboxGroupButtons(
          inputId = "i_checkbox_btn",
          label = "Select Educational Level:",
          selected = unique(data$education_level),
          choiceNames = lookup_table$value[lookup_table$key %in% data$education_level] %>% sort(),
          choiceValues = unique(data$education_level),
          individual = TRUE
        ),
        br(),
        shinyWidgets::sliderTextInput(
          inputId = "i_slider_textinput",
          label = "Salary:",
          selected = format(c(min(data$salary), max(data$salary)), big.mark = ","),
          choices = format(sort(data$salary), big.mark = ",") %>% unique(),
          pre = "USD ",
          force_edges = TRUE
        ),
        br(),
        shinyWidgets::numericRangeInput(
          inputId = "i_numeric_range",
          label = "Years of Experience :",
          value = c(min(data$years_of_experience), max(data$years_of_experience)),
          min = min(data$years_of_experience),
          max = max(data$years_of_experience),
          step = 1,
          width = "50%"
        ),
        br(),
        shinyWidgets::pickerInput(
          inputId = "i_picker",
          label = "Select Occupation:",
          selected = unique(data$job_title),
          multiple = TRUE,
          choices = unique(data$job_title),
          options = list(
            `actions-box` = TRUE,
            `live-search` = TRUE
          )
        ),
        br(),
        br(),
        actionButton(inputId = "get_insight", "Click to Get Insight", class = "btn btn-primary btn-lg btn-block")
      ),
      # Define Output elements on the mainPanel
      mainPanel(
        h3("Data Insight :"),
        fluidRow(
          column(6, echarts4rOutput("Plot_01")),
          column(6, echarts4rOutput("Plot_03"))
        ),
        hr(),
        fluidRow(
          column(12, plotOutput("Plot_02"))
        ),
        hr(),
        dataTableOutput("filtered_table")
        #
        # tabsetPanel(
        #   tabPanel(
        #     "subtab 1",
        #     h3("Data Insight :"),
        #     fluidRow(
        #       column(6, echarts4rOutput("Plot_01")),
        #       column(6, echarts4rOutput("Plot_03"))
        #     ),
        #     hr(),
        #     fluidRow(
        #       column(12, plotOutput("Plot_02"))
        #     )
        #   ),
        #   tabPanel(
        #     "subtab 1",
        #     dataTableOutput("filtered_table")
        #   )
        # )
      )
    )
  )
)
