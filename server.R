# read raw data
data <- read_csv2(file = "TeamScores.csv")
data$dept_id <- as.factor(data$dept_id)

 # read info data
infos <- read_delim("infos.csv",";")

shinyServer (

    function(input, output) {
    
    # Scatterplot : Filtered data
    
    FilterData <- reactive({

      dept = as.numeric(input$dept)
      
      if (dept == 99){
        data # assign data to FilterData
      } else {
        m <- data %>%
          filter(dept_id == dept)
        
        m <- as.data.frame(m)
        
        m # assign m to FilterData
      }      
    })
    
    # Scatterplot : X-Axis, Y-Axis, X-Label, Y-Label
    
    variables <- infos[infos$type=="var",]$sname
    
    x_axis <- reactive({variables[as.numeric(input$xvar)]})
    y_axis <- reactive({variables[as.numeric(input$yvar)]})
    
    names <- infos[infos$type=="var",]$lname
    
    x_lab <- reactive({names[as.numeric(input$xvar)]})
    y_lab <- reactive({names[as.numeric(input$yvar)]})
    
    
    # Melted data (boxplot)
    
    
    MeltData <- reactive({
      
      dept = as.numeric(input$dept)
      # idvar <- c("count","dept_id","team")
      idvar <- infos[infos$type=="id",]$sname
      
      if (dept == 99){
        m <- melt(data,id = idvar )
      } else {
        m <- data %>%
          filter(dept_id == dept) %>%
          melt(id = idvar )
      }
        
        m$variable <- mapvalues(m$variable, from = infos[infos$type=="var",]$sname, to = infos[infos$type=="var",]$lname)

        m <- as.data.frame(m)
        
        m 
        
    })
    
    # Render plot
    
    ## Plot 1 : bowplot
    
    output$plot1<- renderPlot({
          
        names <- infos[infos$type=="var",]$lname
        
        if (as.numeric(input$order)==1){
          
          ggplot(MeltData(), aes(x = variable, y = value)) +
          geom_boxplot() + ylim(0,10) + scale_color_grey() + theme_classic() + coord_flip() + 
            xlab("Dimension") + ylab("Score")
        } 
        else{
          ggplot(MeltData(), aes(x = reorder(variable,value), y = value)) +
          geom_boxplot() + ylim(0,10) + scale_color_grey() + theme_classic() + coord_flip() + 
            xlab("Dimension") + ylab("Score")
        }
        

      },height = 750, width = 750)            
    
    ## Plot 2 : scatterplot
    
    output$plot2<- renderPlot({

      ggplot(FilterData(), aes_string(x= x_axis(),y_axis(),color = "dept_id")) + geom_point() + 
        xlab (x_lab()) + ylab(y_lab()) + xlim(0,10) + ylim(0,10)
    },height = 750, width = 750)
    
  }
)