# Balaji's Version
source("qserver.R")
h<-open_connection("localhost",5001)
stateList <- execute(h,"exec distinct STATE from state")
textareaInput <- function(id, label, value, rows=20, cols=35, class="form-control"){
  tags$div(
    class="form-group shiny-input-container",style="width:100%",
    tags$label('for'=id,label),
    tags$textarea(id=id,class=class,rows=rows,cols=cols,value))
}

minDate <- "2014/01/01"
maxDate <- "2014/12/31"

function(input, output, session) { 
  output$dateMenu <- renderUI({
    dateRangeInput("dateRange", label = 'Date range', start = as.Date(minDate) , end = as.Date(maxDate))
  })
  
  output$stateMenu <- renderUI({
    selectInput("state","State" , c("Select All",stateList), selected = "Select All", multiple = FALSE, selectize = TRUE)
  })

  output$sqlText <- renderUI({
    textareaInput("sqlText","Enter Q SQL ", "select from state where i < 20", rows = 5, cols = 600)
  })
  
  sqlOutput <- eventReactive(input$goButton, {   
    sqlOutput <- execute(h,input$sqlText)
  })
  
  output$sqlOutput <- renderTable({
    sqlOutput()
  })
}