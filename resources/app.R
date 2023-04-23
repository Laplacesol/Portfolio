# Load required libraries
library(shiny)
library(shinydashboard)
library(DT)
library(dplyr)
library(ggplot2)

# Sample data (replace with your own data)
set.seed(42)
n <- 100
sample_data <- data.frame(
  PatientID = 1:n,
  Age = sample(18:90, n, replace = TRUE),
  Gender = factor(sample(c("Male", "Female"), n, replace = TRUE)),
  Department = factor(sample(c("ER", "ICU", "Surgery", "Pediatrics"), n, replace = TRUE)),
  AdmissionDate = as.Date("2023-01-01") + sample(1:60, n, replace = TRUE),
  LengthOfStay = sample(1:30, n, replace = TRUE),
  Doctor = factor(sample(paste("Dr.", LETTERS[1:10]), n, replace = TRUE)),
  BedType = factor(sample(c("General", "Semi-Private", "Private"), n, replace = TRUE)),
  stringsAsFactors = FALSE
)

# Shiny app UI
ui <- dashboardPage(
  dashboardHeader(title = "Hospital Resource Management"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Admissions", tabName = "admissions", icon = icon("calendar-plus")),
      menuItem("Bed Availability", tabName = "bed_availability", icon = icon("bed")),
      menuItem("Staff Workload", tabName = "staff_workload", icon = icon("user-md"))
    )
  ),
  dashboardBody(
    tabItems(
      # Admissions tab content
      tabItem(
        tabName = "admissions",
        fluidRow(
          box(title = "Patient Admissions", width = 12, solidHeader = TRUE, status = "primary",
              dataTableOutput("admissionsTable")
          )
        )
      ),
      # Bed Availability tab content
      tabItem(
        tabName = "bed_availability",
        fluidRow(
          box(title = "Bed Availability", width = 12, solidHeader = TRUE, status = "primary",
              plotOutput("bedAvailabilityPlot")
          )
        )
      ),
      # Staff Workload tab content
      tabItem(
        tabName = "staff_workload",
        fluidRow(
          box(title = "Staff Workload", width = 12, solidHeader = TRUE, status = "primary",
              plotOutput("staffWorkloadPlot")
          )
        )
      )
    )
  )
)

# Shiny app server
server <- function(input, output) {
  # Server code to handle UI interactions and generate plots/tables
  
  output$admissionsTable <- renderDataTable({
    datatable(sample_data, options = list(pageLength = 10, lengthMenu = c(10, 25, 50, 100)), rownames = FALSE)
  })
  
  output$bedAvailabilityPlot <- renderPlot({
    bed_availability <- sample_data %>% count(BedType) %>% arrange(desc(n))
    ggplot(bed_availability, aes(x = BedType, y = n, fill = BedType)) +
      geom_bar(stat = "identity") +
      theme_minimal() +
      labs(title = "Bed Availability", x = "Bed Type", y = "Number of Beds") +
      theme(legend.position = "none")
  })
  
  output$staffWorkloadPlot <- renderPlot({
    staff_workload <- sample_data %>% count(Doctor) %>% arrange(desc(n))
    ggplot(staff_workload, aes(x = reorder(Doctor,-n), y = n, fill = Doctor)) +
      geom_bar(stat = "identity") +
      theme_minimal() +
      labs(title = "Staff Workload", x = "Doctor", y = "Number of Patients") +
      theme(legend.position = "none", axis.text.x = element_text(angle = 45, hjust = 1))
  })
}
#Run the Shiny app

shinyApp(ui = ui, server = server)
                                           