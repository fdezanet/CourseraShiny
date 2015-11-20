library(shiny)
library(ggplot2)
library(Cairo)
library (dplyr)
library(readr)
library(reshape2)
library(gridExtra)
library(plyr)

# read raw data
data <- read_csv2(file = "TeamScores.csv")

# read info data
infos <- read_delim("infos.csv",";")

dims <- seq(1,nrow(infos[infos$type =="var",]),1)
names(dims) <- infos[infos$type=="var",]$lname

depts <- seq(1,max(data$dept_id),1)
names(depts) <- paste (rep("Department",5), seq(1,max(data$dept_id),1))
depts <- c("All Departments" = 99,depts)


shinyUI(
  
  pageWithSidebar(
  
    headerPanel("Exploration of Team climate for performance data"),
    
    sidebarPanel(

      selectInput("xvar", 
            label = h4("Select dimension (X-Axis)"), 
            choices = dims, 
            selected = 1),
      
      p("Select here the dimension for the X-Axis of the scatterplot."),
      
      selectInput("yvar", 
                  label = h4("Select dimension (Y-Axis)"), 
                  choices = dims, 
                  selected = 8),
      
      p("Select here the dimension for the Y-Axis of the scatterplot."),
      
      selectInput("dept", label = h4("Department filter"), choices = depts, selected = 99),
      
      p("Filter the data by selecting a department.")

      ),
    
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Documentation",
                           h2("Usage"),
                           p("The shiny app has been developped to quickly data about team climate for performance"),
                           h2("Input"),
                           p("The file 'data.csv' contains the data about different dimensions of team climate as well as performance data."), 
                           p("These data have been directly collected among team meambers via survey. Data are agregated at a department level."),
                           p("The file 'infos.csv' describes the variables of the 'data.csv' file."),
                           p("More specifically, 'type' column indicates whether the variable is a segmentation variable or a dimension variable."),
                           p("The 'sname' column provides the dimension name as indicated in the 'data.csv' file. The 'lname' column provides a longer and more descriptive name for each dimension." ),
                           h2("Data exploration results"),
                           p("The shiny apps provides : "),
                           p("1. Descriptive statistics (boxplot). The results can be filtered by using the 'Department filter' list box. "),
                           p("2. A scatterplot of the relationship between two dimensions. Dimensions are selected via the 'select dimension' list boxes.The results can be filtered by using the 'Department filter' list box.")),
                  tabPanel("Descriptive statistics",
                           radioButtons("order", label = h6("Sort dimensions"),choices = list("No" = 1, "Yes" = 2), selected = 1),
                           plotOutput("plot1", width = 350)),
                  tabPanel("Relationship between dimensions",plotOutput("plot2", width = 350))
                   )

      )
  )
)