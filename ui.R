# Balaji's Version
library(shiny)
library(shinydashboard)

dashboardPage(
  dashboardHeader(),
  dashboardSidebar(
    sidebarMenu(
      menuItem("IDE", tabName = "IDE", icon = icon("th")),
      menuItem("Dashboard 1", tabName = "dashboard1", icon = icon("dashboard")),
      menuItem("Dashboard 2", tabName = "dashboard2", icon = icon("dashboard"))
    )
  ),
  dashboardBody(
    fluidRow( 
      column(width=6,uiOutput("dateMenu")),
      column(width=6,uiOutput("stateMenu"))),
    tabItems(
      # First tab content
      tabItem(tabName = "IDE",         
              fluidRow(column(width=12,h2("IDE"))),
              fluidRow(column(width=12,uiOutput("sqlText"))),
              actionButton("goButton", "Go!"),
              div(style = 'overflow-x: scroll', tableOutput("sqlOutput"))
              ),
      tabItem(tabName = "dashboard1",          h2("DashBoard 1")),
      tabItem(tabName = "dashboard2",          h2("DashBoard 2"))
    )
  )
)