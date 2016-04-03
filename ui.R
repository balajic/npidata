# Balaji's Version
library(shiny)
library(shinydashboard)

dashboardPage(
  dashboardHeader(title = "NPI data search"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("IDE",      tabName = "tabIDE",   icon = icon("th")),
      menuItem("HCP List", tabName = "tabHCP",   icon = icon("list")),
      menuItem("Stats",    tabName = "tabStats", icon = icon("pie-chart"))
    )
  ),
  dashboardBody(
    fluidRow( 
      tabItems(
        # IDE Tab
        tabItem(tabName = "tabIDE",
                fluidRow(column(width=12,h2("IDE"))),
                fluidRow(column(width=12,uiOutput("sqlDiv"))),
                actionButton("goButton", "Query"),
                div(style = 'overflow-x: scroll', dataTableOutput("resultOutput"))
        ),
        # HCP List Tab
        tabItem(tabName = "tabHCP",
                h2("HCP Search"),
                column(width=6,uiOutput("stateMenu")),
                fluidRow(column(width=12,div(style = 'overflow-x: scroll', dataTableOutput("HCPList"))))
        ),
        tabItem(tabName = "tabStats",
                h2("HCP Stats")
        )
      )# tabItems
    )# fluidRow
  )# dashboardBody
)# dashboardPage