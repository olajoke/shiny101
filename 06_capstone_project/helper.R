# Install and Load package function



# load dataset
data <- readRDS("data/salary_data.rds") %>% na.omit()

# A lookup table with key-value pairs --- Education Level
lookup_table <- data.frame(
  key = c("Bachelor's", "PhD", "Master's"),
  value = c("Bachelor", "PhD", "Master")
)

# Remove commas from formatted numeric values e.g. "4,000" --> "4000"
comma_removr <- function(val) {
  stringr::str_remove(val, ",")
}

# Filter function
filter_df <- function(
    data,
    input_01 = c(23, 53), # age
    input_02 = c(0, 25), # years of exeperience
    input_03 = c(350, 250000), # salary
    input_04 = c("Male", "Female", "Others"), # gender
    input_05 = c("Bachelor's", "Master's", "PhD"), # education level
    input_06 = c("Director of Marketing", "Senior Business Analyst", "Senior Marketing Analyst", "Junior Business Analyst")) {
  # Start the filter process
  data <-
    data %>%
    filter(
      between(age, left = input_01[1], right = input_01[2]),
      between(years_of_experience, input_02[1], input_02[2]),
      between(salary, input_03[1], input_03[2])
    )

  if (!is.null(input_04)) {
    data <- data %>% filter(gender %in% input_04) # Only run if parameter is not NULL
  }

  if (!is.null(input_05)) {
    data <- data %>% filter(education_level %in% input_05) # Only run if parameter is not NULL
  }

  if (!is.null(input_06)) {
    data <- data %>% filter(job_title %in% input_06) # Only run if parameter is not NULL
  }
  # Return the data
  data
}


# Build a scatter plot with plotly
build_scatter_plot <- function(data) {
  # Create the Plotly plot
  plot <- plot_ly(data, x = ~age, y = ~salary, color = ~education_level, type = "scatter", mode = "markers") %>%
    layout(
      title = list(text = "Age vs Salary by Gender", y = 0.90),
      margin = list(t = 100),
      xaxis = list(title = "Age"), yaxis = list(title = "Salary")
    )
  # Display the Plotly plot
  plot
}


# Build count data function
build_count_data <- function(data, col) {
  # Validate Params
  stopifnot(col %in% colnames(data))
  stopifnot(is.character(data[[col]]) | is.factor(data[[col]]))

  # Create data
  data <- count(data, .data[[col]], name = "Value", sort = TRUE)

  # Add percentage column
  data$percentage <- data$Value / sum(data$Value)

  # Return data
  data
}

# build donut chart using echarts4r
build_donut_chart <- function(data, col = NULL, title = "Title") {
  data <- build_count_data(data, col)
  chart <-
    data %>%
    mutate(percentage = percentage * 100) %>%
    rename("col" = all_of(col)) %>%
    e_charts(col, height = "50%") %>%
    e_theme("westeros") %>%
    e_pie(percentage, radius = c("50%", "70%")) %>%
    e_legend(show = FALSE) %>%
    e_tooltip(formatter = htmlwidgets::JS(
      "function(params) {",
      "  return params.name + ' : ' + params.percent + '%';",
      "}"
    )) %>%
    e_title(title)

  # Return chart
  chart
}


# Build a color palette for ggplot
gg_colors <- function(x = 10) {
  palette <- c("#357560", "#009E73", "#D8D093", "#0072B2", "#56B4E9")
  color_palette <- colorRampPalette(palette)
  colors <- color_palette(x)
  colors
}

# Build column chart with ggplot2
build_column_chart <- function(data, col, x_label = "X Label", title = "Top Most Common Occupation") {
  data <- build_count_data(data, col) %>% head(10)
  colors <- gg_colors(nrow(data))

  # Create Plot
  plot <- ggplot(data, aes(x = reorder(data[[col]], -Value), y = Value, fill = data[[col]])) +
    geom_bar(stat = "identity") +
    scale_fill_manual(values = colors) +
    labs(x = x_label, y = "Count", fill = col) +
    ggtitle(title) +
    theme_minimal() +
    theme_minimal() +
    theme(
      panel.background = element_rect(fill = "white", color = NA),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      axis.line = element_blank(),
      axis.text = element_text(color = "black"),
      plot.title = element_text(color = "black")
    ) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))

  # Return Plot
  plot
}
