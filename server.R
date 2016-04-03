# Balaji's Version
source("qserver.R")

h<-open_connection("localhost",5001)
stateList <- execute(h,"exec distinct STATE from state")

fnTextareaInput <- function(id, label, value, rows=20, cols=35, class="form-control"){
  tags$div(
    class="form-group shiny-input-container",style="width:100%",
    tags$label('for'=id,label),
    tags$textarea(id=id,class=class,rows=rows,cols=cols,value))
}# fnTextareaInput

function(input, output, session) { 

  # IDE Tab
  output$sqlDiv <- renderUI({
    fnTextareaInput("txtKdbSql","Enter Q SQL ", "select from state where i < 20", rows = 5, cols = 100)
  })
  
  erDataTab <- eventReactive(input$goButton, {
    print(input$txtKdbSql)
    execute(h,input$txtKdbSql)
  })
  
  output$resultOutput <- renderDataTable({
    erDataTab()
  })

  # HCP List Tab
  output$stateMenu <- renderUI({
    selectInput("state","State" , c("Select State",stateList), selected = "Select All", multiple = FALSE, selectize = TRUE)
  })
  
  # Reactive Dropdown selection
  rHCPTab <- reactive({
    #print( session$token )
    if (is.null(input$state)) return()
    if (input$state == "Select State" ) return()
    sql <- paste0('select from npi where PR_BUSI_MAIL_ADD_STATE_NAME like "',input$state,'"')
    print(sql)
    execute(h,sql)
  })
  
  output$HCPList <- renderDataTable({
    rHCPTab()
  })
  
}