shinyUI(
  dashboardPage(
    
    dashboardHeader(title = NULL, titleWidth = 188,
                    
      dropdownMenu(type = "messages",

        messageItem(
          from = "Alerta",
          message = "Niveles de Riesgo Atípicos",
          icon = icon("exclamation-triangle"),
          time = "2018-05-12"
        ),
        
        messageItem(
         from = "Señal",
         message = "Volatilidad Anormal",
         icon = icon("life-ring"),
         time = "2018-05-12"
        )
      )
    ),
    
    dashboardSidebar(
      
      sidebarSearchForm(label = "Ingrese un Número", "searchText", "searchButton"),
      
      sidebarMenu(id = "tabs",
                  
        menuItem("Curva de Rendimiento", icon = icon("bar-chart-o"),
                 
          menuSubItem("Metodología Svensson", tabName = "subitem1", icon = icon("circle-o")),
          
          menuSubItem("Metodología Nelson y Siegel", tabName = "subitem2", icon = icon("circle-o")),
          
          menuSubItem("Metodología Splines", tabName = "subitem3", icon = icon("circle-o"))
        )
        ,
        menuItem("Acerca", icon = icon("exclamation-circle"), tabName = "acerca"))
  ),
    dashboardBody(VisionHeader(),

      tabItems(

       tabItem(tabName = "subitem1",
                fluidRow(    
                    h2("  Svensson"),
                    fluidRow(column( width = 6,box( width = 12, background = "navy",
                          dateInput(inputId="n1", label="Por favor, seleccionar una fecha", language= "es",
         width = "100%") )),column( width = 6,box( width = 12,height = 2,title = "Fecha de valoración: ",verbatimTextOutput('p1'))))
              , 
         h2("  Títulos"), h5("  Favor seleccionar los títulos a considerar: "),
        fluidRow(tabBox( width = 12, title = "Títulos", id = "tab1", height = "50px", 
                tabPanel("TIF",
        fluidRow(column(width = 3,checkboxGroupInput( inputId = "t1", label = " ",
                                           choices=tit[1:7])),
                              column(width = 3,checkboxGroupInput( inputId = "t2", label = " ",
                            choices=tit[8:13])), column(width = 3,checkboxGroupInput( inputId = "t3", 
                            label = " ",choices=tit[14:19])),column(width = 3,
                              checkboxGroupInput( inputId = "t4", label = " ",choices=tit[20:25])) ) ,
        
        verbatimTextOutput("q1"),h2(" Precios Promedios"),verbatimTextOutput("pre1"),
        h2(" Parámetros iniciales"),verbatimTextOutput("pa_tif"),
        h2(" Características"),verbatimTextOutput("Ca"),
        h2(" Precios estimados"),verbatimTextOutput("p_est_tif")),
        tabPanel("VEBONO",fluidRow(column(width = 3,
                                            checkboxGroupInput( inputId = "v1", label = " ",
                                                      choices=tit1[1:8])),
                                  column(width = 3,checkboxGroupInput( inputId = "v2", label = " ",
                              choices=tit1[9:16])), column(width = 3,checkboxGroupInput( inputId = "v3", 
                                label = " ",choices=tit1[17:24])),column(width = 3,
                        checkboxGroupInput( inputId = "v4", label = " ",choices=tit1[25:29])) ) ,
                                             verbatimTextOutput("q2"), h2(" Precios Promedios"),verbatimTextOutput("pre2")
                                            ,h2(" Parámetros iniciales"),verbatimTextOutput("pa_veb"), 
                 h2(" Características"),verbatimTextOutput("Ca1"))
      
        
        )
        
        )
       
        )),
      
      
      tabItem(tabName = "subitem2",
                   
                   h2("Nelson y Siegel"),
                   fluidRow( column( width = 6,box( width = 12, background = "navy",
                                                    dateInput(inputId="n2", label="Por favor, seleccionar una fecha", language= "es",
                                                              width = "100%") )),box( width = 6,height = 2,title = "Fecha de valoración: ",verbatimTextOutput('p2')) )
        ), tabItem(tabName = "subitem3",
                   
                   h2("Splines"),
                   fluidRow( column( width = 6,box( width = 12, background = "navy",
                                                    dateInput(inputId="n3", label="Por favor, seleccionar una fecha", language= "es",
                                                              width = "100%") )),box( width = 6,height = 2,title = "Fecha de valoración: ",verbatimTextOutput('p3')))
        ),
        tabItem(tabName = "acerca",
                box( width = 9, status="warning",
                     h3(ACERTITLE_TEXT),
                     tags$hr(),
                     h4(ACERVER_TEXT),
                     h4(ACERRIF_TEXT),
                     h4(ACERRS_TEXT),
                     h4(ACERRS_TEXT2),
                     tags$hr(),
                     tags$img(src="img/visionrisk.png", width=300, align = "left"),
                     br(),
                     h5(ACERSUBSV_TEXT),
                     br(),
                     tagList(shiny::icon("map-marker"), ACERDIR_TEXT),br(),
                     tagList(shiny::icon("phone"), ACERTLF_TEXT),br(),
                     tagList(shiny::icon("envelope-o"), ACERCORR_TEXT)
                )
        )
      )
    )
  )
)

