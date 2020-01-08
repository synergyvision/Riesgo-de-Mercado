library(rintrojs)
library(shiny)
library(shinydashboard)
library(shinyBS)
library(shinyjs)

intro_df <- data.frame(element = c('#plot_box', '#bttn2_intro', '#box', '#plot', '#shiny-modal'),
                       intro = c('test plot_box', 'test bttn2', 'test box', 'plot', 'test modal'))

ui <- shinyUI(fluidPage(
  dashboardPage(dashboardHeader(title = "Test"),
                dashboardSidebar(sidebarMenu(menuItem("item1", tabName = "item1"))),
                dashboardBody(tabItems(tabItem("item1", actionButton("bttn", "start intro"))))),
  useShinyjs()
  # tags$head(tags$style(".introjs-fixParent.modal {
  #                         z-index:1050 !important;  
  #                       }")),
  # introjsUI()
))

server <- shinyServer(function(input, output, session) {
  output$plot <- renderPlot({
    plot(rnorm(50))
  })
  
  output$plot_box <- renderUI({
    box(id = 'box',
        div(id = "bttn2_intro", actionButton('bttn2', 'dummy')),
        plotOutput('plot'), width = '100%'
    )
  })
  
  observeEvent(input$bttn,{
    showModal(modalDialog(uiOutput('plot_box')))
  })
  
  observeEvent(input$bttn2, {
    introjs(session, options = list(steps = intro_df))
  })
  
})
shinyApp(ui = ui, server = server)