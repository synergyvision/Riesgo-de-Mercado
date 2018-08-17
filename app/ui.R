shinyUI(
  dashboardPage(
    #Header
    dashboardHeader(title = NULL, titleWidth = 188,
              dropdownMenu(type = "messages",
                           messageItem(
                                      from = "Alerta",
                                      message = "Niveles de Riesgo Atípicos",
                                      icon = icon("exclamation-triangle"),
                                      time = "2018-05-12"
                                      ),#final messageitem
                          
                          messageItem(
                                     from = "Señal",
                                     message = "Volatilidad Anormal",
                                     icon = icon("life-ring"),
                                     time = "2018-05-12"
                                      )#final messageitem
                          )#final dropdownmenu
                  ),#final dashboardheader
    #Sidebar
    dashboardSidebar(
      
                sidebarSearchForm(label = "Ingrese un Número", "searchText", "searchButton"),
              
                sidebarMenu(id = "tabs",
                          
                menuItem("Curva de Rendimiento", icon = icon("bar-chart-o"),
                         
                            menuSubItem("Metodología Nelson y Siegel", tabName = "subitem1", icon = icon("circle-o")),
                            
                            menuSubItem("Metodología Svensson", tabName = "subitem2", icon = icon("circle-o")),
                            
                            menuSubItem("Metodología Diebold-Li", tabName = "subitem3", icon = icon("circle-o")),
                            
                            menuSubItem("Metodología Splines", tabName = "subitem4", icon = icon("circle-o"))
                       
                          ),#fin menuitem 
                
                            menuItem("Acerca", icon = icon("exclamation-circle"), tabName = "acerca"))
                  
                ), #final dashboardsidebar
    #Body
    dashboardBody(VisionHeader(),
            tabItems(
              #NELSON Y SIEGEL
               tabItem(tabName = "subitem1",
                         h2("Nelson y Siegel"),
                         fluidRow(column(width = 6,box( width = 12, background = "navy",
                                                          dateInput(inputId="n2", label="Por favor, seleccionar una fecha", language= "es",
                                                                    width = "100%")#final dateimput 
                                                      )#final box
                                          ),#final column
                                  box( width = 6,height = 2,title = "Fecha de valoración: ",verbatimTextOutput('p2')) #final box
                                  ),#final fluidrow
                          h2("  Títulos"), h5("  Favor seleccionar los títulos a considerar: "),
                          fluidRow(tabBox( width = 12, title = "Títulos", id = "tab1", height = "50px", 
                                     tabPanel("TIF",
                                              fluidRow(column(width = 3,checkboxGroupInput( inputId = "t1_ns", label = " ",
                                                              choices=tit[1:7])#final checkboxgroupimput
                                                              ),#final column
                                                       column(width = 3,checkboxGroupInput( inputId = "t2_ns", label = " ",
                                                              choices=tit[8:13])#final checkboxgroupimput
                                                              ),#final column
                                                       column(width = 3,checkboxGroupInput( inputId = "t3_ns", label = " ",
                                                              choices=tit[14:19])#final checkboxgroupimput
                                                              ),#final column
                                                       column(width = 3,checkboxGroupInput( inputId = "t4_ns", label = " ",
                                                              choices=tit[20:25])#final checkboxgroupimput
                                                              ) #final column
                                                       ),#final fluidrow
                                                        verbatimTextOutput("q1_ns"),h2(" Precios Promedios"),verbatimTextOutput("pre1_ns"),
                                                        h2(" Parámetros iniciales"), 
                                              #withMathJax(),
                                              #helpText('\\(\\beta_{0}\\) \\(\\beta_{1}\\) \\(\\beta_{2}\\) \\(\\tau_{1}\\) '),
                                              #uiOutput('ex1')
                                              verbatimTextOutput("pa_tif_ns"),
                                                        h2(" Características"),dataTableOutput("Ca_ns"),
                                                        h2(" Precios estimados iniciales"),dataTableOutput("p_est_tif_ns"),
                                                        h2(" Curva de rendimientos inicial"),
                                                        plotOutput("c_tif_ns"),
                                                        h2(" Precios estimados optimizados"),
                                                        radioButtons( inputId = "opt_tif_ns",label = "Desea optimizar los precios obtenidos:", 
                                                                      choices = c("Si"=1, "No"=0),
                                                                      selected=" "), #finalradiobuttons
                                                        dataTableOutput("p_est_tif_opt_ns"),
                                                        h2(" Parámetros optimizados"),
                                                        verbatimTextOutput("par_tif_ns_op"),
                                                        h2(" Curva de rendimientos"),
                                                        plotOutput("c_tif_ns_op")
                                              ),#final tabpanel tif
                                     tabPanel("VEBONO",fluidRow(
                                                      column(width = 3,checkboxGroupInput(inputId = "v1_ns", label = " ",
                                                                choices=tit1[1:8])#final checkboxgroupimput
                                                             ),#final column
                                                      column(width = 3,checkboxGroupInput( inputId = "v2_ns", label = " ",
                                                                choices=tit1[9:16])#final checkboxgroupimput
                                                             ),#final column
                                                      column(width = 3,checkboxGroupInput( inputId = "v3_ns",label = " ",
                                                                choices=tit1[17:24])#final checkboxgroupimput
                                                             ),#final column
                                                      column(width = 3,checkboxGroupInput( inputId = "v4_ns", label = " ",
                                                                choices=tit1[25:29])#final checkboxgroupimput
                                                             )#final column
                                                                ),#final fluidrow
                                                        verbatimTextOutput("q2_ns"), h2(" Precios Promedios"),verbatimTextOutput("pre2_ns"),
                                                        h2(" Parámetros iniciales"),verbatimTextOutput("pa_veb_ns") ,
                                                        h2(" Características"),dataTableOutput("Ca1_ns"),
                                                        h2(" Precios estimados iniciales"),dataTableOutput("p_est_veb_ns"),
                                                        h2(" Curva de rendimientos inicial"),
                                                        plotOutput("c_veb_ns"),
                                                        h2(" Precios estimados optimizados"),
                                                        radioButtons( inputId = "opt_veb_ns",label = "Desea optimizar los precios obtenidos:", 
                                                                    choices = c("Si"=1, "No"=0),
                                                                    selected=" "),#final radiobuttons
                                                        dataTableOutput("p_est_veb_opt_ns"),
                                                        h2(" Parámetros optimizados"),
                                                        verbatimTextOutput("par_veb_ns_op"),
                                                        h2(" Curva de rendimientos"),
                                                        plotOutput("c_veb_ns_op")
                                              )#final tabitem vebono
                                        )#final tabbox
                                  )#final fluidrow
                      ),#final tabitem 
               #SVENSSON
               tabItem(tabName = "subitem2",
                       fluidRow(h2("  Svensson"),
                                fluidRow(column(width = 6,box( width = 12, background = "navy",
                                                               dateInput(inputId="n1", label="Por favor, seleccionar una fecha", language= "es",
                                                                         width = "100%")#final dateimput 
                                )#final box
                                ),#final column
                                column(width = 6,box(width = 12,height = 2,title = "Fecha de valoración: ",verbatimTextOutput('p1')
                                )#final box
                                )#final column
                                ),#final fluidrow
                                h2("  Títulos"), h5("  Favor seleccionar los títulos a considerar: "),
                                fluidRow(tabBox(width = 12, title = "Títulos", id = "tab1", height = "50px", 
                                                tabPanel("TIF",fluidRow(column(width = 3,checkboxGroupInput( inputId = "t1", label = " ",
                                                                                                             choices=tit[1:7])#final checkboximput
                                                ),#final column
                                                column(width = 3,checkboxGroupInput( inputId = "t2", label = " ",
                                                                                     choices=tit[8:13])#final checkboximput
                                                ),#final column
                                                column(width = 3,checkboxGroupInput( inputId = "t3",label = " ", 
                                                                                     choices=tit[14:19])#final checkboximput
                                                ),#final column
                                                column(width = 3,checkboxGroupInput( inputId = "t4", label = " ",
                                                                                     choices=tit[20:25])#final checkboximput
                                                )#final column
                                                ),#final fluidrow 
                                                verbatimTextOutput("q1"),h2(" Precios Promedios"),verbatimTextOutput("pre1"),
                                                h2(" Parámetros iniciales"),verbatimTextOutput("pa_tif"),#withMathJax(uiOutput("formula")),
                                                h2(" Características"),dataTableOutput("Ca"),
                                                h2(" Precios estimados iniciales"),dataTableOutput("p_est_tif"),
                                                h2(" Curva de rendimientos inicial"),
                                                plotOutput("c_tif_sven"),
                                                h2(" Precios estimados optimizados"),
                                                radioButtons(inputId = "opt_tif",label = "Desea optimizar los precios obtenidos:", 
                                                             choices = c("Si"=1, "No"=0),
                                                             selected=" "
                                                )#final radiobuttoms
                                                ,dataTableOutput("p_est_tif_opt") 
                                                ),#final tabpanel tif
                                                tabPanel("VEBONO",fluidRow(column(width = 3,checkboxGroupInput( inputId = "v1", label = " ",
                                                                                                                choices=tit1[1:8])#final checkboximput
                                                ),#final column
                                                column(width = 3,checkboxGroupInput( inputId = "v2", label = " ",
                                                                                     choices=tit1[9:16])#final checkboximput
                                                ),#final column
                                                column(width = 3,checkboxGroupInput( inputId = "v3", label = " ",
                                                                                     choices=tit1[17:24])#final checkboximput
                                                ),#final column
                                                column(width = 3,checkboxGroupInput( inputId = "v4", label = " ",
                                                                                     choices=tit1[25:29])#final checkboximput
                                                )#final column
                                                ),#final fluidrow 
                                                verbatimTextOutput("q2"), h2(" Precios Promedios"),verbatimTextOutput("pre2"),
                                                h2(" Parámetros iniciales"),verbatimTextOutput("pa_veb"), 
                                                h2(" Características"),dataTableOutput("Ca1"),
                                                h2(" Precios estimados iniciales"),dataTableOutput("p_est_veb"),
                                                h2(" Curva de rendimientos inicial"),
                                                plotOutput("c_veb_sven"),
                                                h2(" Precios estimados optimizados"),
                                                radioButtons(inputId = "opt_veb",label = "Desea optimizar los precios obtenidos:", 
                                                             choices = c("Si"=1, "No"=0),
                                                             selected=" "),dataTableOutput("p_est_veb_opt")
                                                )#final tabitem vebono
                                )#final tabbox
                                )#finalfluidrow
                       )#finalfluidrow
               ),#final tabitem
               #DIEBOLD-LI
               tabItem(tabName = "subitem3",
                    h2("Diebold-Li"),
                          fluidRow(column( width = 6,box( width = 12, background = "navy",
                                                        dateInput(inputId="n3", label="Por favor, seleccionar una fecha", language= "es",
                                                               width = "100%")#final dateimput 
                                                        )#final box
                                          ),#final column
                                   box( width = 6,height = 2,title = "Fecha de valoración: ",verbatimTextOutput('p3')) #finalbox
                                   )#final fluidrow
                       ),#final tabitem dl
               #SPLINES
               tabItem(tabName = "subitem4",
                    h2("Splines"),
                          fluidRow(column( width = 6,box( width = 12, background = "navy",
                                                          dateInput(inputId="n4", label="Por favor, seleccionar una fecha", language= "es",
                                                                    width = "100%")#final dateimput 
                                                        )#final box
                                           ),#final column
                                   box( width = 6,height = 2,title = "Fecha de valoración: ",verbatimTextOutput('p4')))
                      ),#final tabitem
              #ACERCA
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
                                )#final box
                      )#final tabitem
                    )#final tabitems
                  )#final dashboardbody
                )#final dashboardpage
        )#final shinyui

