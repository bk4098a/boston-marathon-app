
library(shiny)
library(ggplot2)
library(bslib)
library(scales)
library(DT)
library(thematic)
library(shinyWidgets)
library(plotly)
library(sf)
library(caret)
library(dplyr)  # Required for group_by, summarise, and n()

thematic_shiny(font = "auto")

# Load marathon data
marathon_data <- read.csv("boston_marathon_2023.csv", stringsAsFactors = FALSE)

ui <- fluidPage(
  theme = bslib::bs_theme(version = 5, bootswatch = "materia"),
  sidebarLayout(
    sidebarPanel(
      pickerInput(
        "gender", "Select Gender",
        choices = c("All", "M", "W"),
        selected = "All",
        multiple = FALSE
      ),
      pickerInput(
        "age_group", "Select Age Group",
        choices = unique(marathon_data$age_group),
        multiple = TRUE,
        selected = unique(marathon_data$age_group),
        options = pickerOptions(
          liveSearch = TRUE,
          actionsBox = TRUE
        )
      ),
      sliderInput(
        "time", "Finish Time Range (Minutes)",
        min = min(marathon_data$finish_net_minutes, na.rm = TRUE),
        max = max(marathon_data$finish_net_minutes, na.rm = TRUE),
        value = c(min(marathon_data$finish_net_minutes, na.rm = TRUE),
                  max(marathon_data$finish_net_minutes, na.rm = TRUE))
      ),
      downloadButton('downFile', label = "Download Filtered Data")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Overview", h3("Boston Marathon 2023 Data"), dataTableOutput("summary_table")),
        tabPanel("Visualizations", plotlyOutput("barplot_counts"), plotlyOutput("scatterplot_performance"))
      )
    )
  )
)

server <- function(input, output, session) {

  # Reactive filtered dataset
  filtered_data <- reactive({
    df <- marathon_data
    if("finish_net_minutes" %in% names(df)) {
      df <- df %>%
        filter(
          age_group %in% input$age_group,
          finish_net_minutes >= input$time[1], 
          finish_net_minutes <= input$time[2]
        )
    } else {
      stop("Column 'finish_net_minutes' not found.")
    }
    return(df)
  })

  # Update age group input based on gender
  observe({
    df <- marathon_data
    gender_data <- df
    if (input$gender != "All") {
      gender_data <- gender_data %>% filter(gender == input$gender)
    }
    updatePickerInput(
      session,
      "age_group",
      choices = unique(gender_data$age_group),
      selected = unique(gender_data$age_group)
    )
  })

  # Summary table
  output$summary_table <- renderDataTable({
    filtered_data() %>%
      group_by(age_group, gender) %>%
      summarise(
        Total_Runners = n(),
        Avg_Finish_Time = mean(finish_net_minutes, na.rm = TRUE),
        .groups = "drop"
      )
  })

  # Barplot
  output$barplot_counts <- renderPlotly({
    plot <- ggplot(filtered_data(), aes(x = age_group, fill = gender)) +
      geom_bar() +
      labs(
        title = "Number of Runners by Age Group and Gender",
        x = "Age Group",
        y = "Count"
      ) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    ggplotly(plot)
  })

  # Scatterplot
  output$scatterplot_performance <- renderPlotly({
    plot <- ggplot(filtered_data(), aes(x = age_group, y = finish_net_minutes, color = gender)) +
      geom_point(alpha = 0.5) +
      labs(
        title = "Performance by Age Group and Gender",
        x = "Age Group",
        y = "Finish Time (Minutes)"
      ) +
      theme_minimal() +
      theme(legend.position = "bottom")
    ggplotly(plot)
  })
}

shinyApp(ui = ui, server = server)
