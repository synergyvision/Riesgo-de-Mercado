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
                         
                            menuSubItem("Nelson y Siegel", tabName = "subitem1", icon = icon("circle-o")),
                            
                            menuSubItem("Svensson", tabName = "subitem2", icon = icon("circle-o")),
                            
                            menuSubItem("Diebold-Li", tabName = "subitem3", icon = icon("circle-o")),
                            
                            menuSubItem("Splines", tabName = "subitem4", icon = icon("circle-o"))
                       
                          ),#fin menuitem 
                
                            #menuItem("Comparativo", icon = icon("circle-o"), tabName = "comparativo"),
                menuItem("Comparativo", icon = icon("bar-chart-o"), 
                         
                            menuSubItem("Datos", tabName = "datos", icon = icon("circle-o")),
                         
                            menuSubItem("Metodologías", tabName = "metodologias", icon = icon("circle-o")),
                         
                            menuSubItem("Precios estimados", tabName = "precios", icon = icon("circle-o")),
                         
                            menuSubItem("Curvas", tabName = "curvas", icon = icon("circle-o"))
                         
                          ),#fin menuitem 
                menuItem("Valor en Riesgo", icon = icon("bar-chart-o"), 
                         
                         menuSubItem("Datos", tabName = "datos_var", icon = icon("circle-o")),
                         
                         menuSubItem("Distribución", tabName = "distribucion_var", icon = icon("circle-o")),
                         
                         menuSubItem("VaR", tabName = "var", icon = icon("circle-o")),
                         
                         menuSubItem("Gráficos", tabName = "graficos", icon = icon("circle-o")),
                         
                         menuSubItem("Históricos", tabName = "historicos", icon = icon("circle-o"))
                         
                ),#fin menuitem 
                          menuItem("Backtesting", icon = icon("bar-chart-o"), 
                                   menuSubItem("Datos", tabName = "datos_back", icon = icon("circle-o"))
                          ),
                
                            menuItem("Acerca", icon = icon("exclamation-circle"), tabName = "acerca"))
                  
                ), #final dashboardsidebar
    #Body
    dashboardBody(VisionHeader(),
            tabItems(
              #NELSON Y SIEGEL
              
               tabItem(tabName = "subitem1",
                 fluidRow(    h2("Nelson y Siegel"),
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
                                                        
                                              #withMathJax(),
                                              #helpText('\\(\\beta_{0}\\) \\(\\beta_{1}\\) \\(\\beta_{2}\\) \\(\\tau_{1}\\) '),
                                              #uiOutput('ex1')
                                              
                                                        h2(" Características"),box(style="overflow-x:scroll",width = 12,dataTableOutput("Ca_ns")),
                                                        h2(" Parámetros"), 
                                              fluidRow(
                                                        tabBox( width = 12, title = "Parámetros", id = "tab1_ns_tif", height = "50px", 
                                                       
                                                        tabPanel(" Parámetros Iniciales ",
                                                        verbatimTextOutput("pa_tif_ns"),
                                                        h2(" Precios estimados iniciales"),box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_tif_ns")),
                                                        h2(" Curva de rendimientos inicial TIF"),
                                                        plotOutput("c_tif_ns")
                                                        
                                                        ),# final tabpanel pa iniciales 
                                                        
                                                        tabPanel(" Elegir Parámetros",
                                                                 # verbatimTextOutput("pa_tif_ns_el"),
                                                                 # h2(" Precios estimados"),dataTableOutput("p_est_tif_ns_el"),
                                                                 # h2(" Curva de rendimientos TIF"),
                                                                 # plotOutput("c_tif_ns_el")
                                                                 h4(" Por favor, insertar parámetros"),
                                                                 box(width=12,title="Importante",status="primary",solidHeader=TRUE ,collapsible = TRUE,
                                                                     collapse= TRUE,"Al ingresar los parámetros considere las siguientes restricciones, ",br(),withMathJax(helpText("$$1) \\quad \\beta_{0} > 0$$")),
                                                                     withMathJax(helpText("$$2) \\quad \\beta_{0}+\\beta_{1} > 0$$")),withMathJax(helpText("$$3) \\quad \\tau > 0$$"))),#final box
                                                                 column(width = 3,numericInput( inputId = "ns_b0_tif", label="B0: ", min = 0, max = 50,step = 0.1, value = 5, width = "40%")
                                                                        , verbatimTextOutput("num_ns_b0_tif")),#final column,
                                                                 column(width = 3,numericInput( inputId = "ns_b1_tif", label="B1: ", min = -10, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                        verbatimTextOutput("num_ns_b1_tif")),#final column
                                                                 column(width = 3,numericInput( inputId = "ns_b2_tif", label="B2: ", min = -10, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                        verbatimTextOutput("num_ns_b2_tif")),#final column
                                                                 column(width = 3,numericInput( inputId = "ns_t_tif", label="T: ", min = 0, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                        verbatimTextOutput("num_ns_t_tif")),#final column
                                                                 h4(" Los nuevos parámetros considerados son, "),
                                                                 verbatimTextOutput("new_ns_tif"),
                                                                 h4(" Verificación, "),
                                                                 verbatimTextOutput("ver_ns_tif"),
                                                                 h2(" Precios estimados"),box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_tif_ns_el")),
                                                                 h4(" Curva de Rendimiento"),
                                                                 plotOutput("c_tif_ns1_new")
                                                                 ),# final tabpanel pa elegir
                                                         
                                                        tabPanel(" Parámetros Optimizados",
                                                                 # verbatimTextOutput("pa_tif_ns_el"),
                                                                 # h2(" Precios estimados iniciales"),dataTableOutput("p_est_tif_ns_el"),
                                                                 # h2(" Curva de rendimientos inicial"),
                                                                 # plotOutput("c_tif_ns_el")
                                                                 h2(" Precios estimados optimizados"),
                                                                 radioButtons( inputId = "opt_tif_ns",label = "Desea optimizar los precios obtenidos:", 
                                                                               choices = c("Si"=1, "No"=0),
                                                                               selected=0), #finalradiobuttons
                                                                 box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_tif_opt_ns")),
                                                                 h2(" Parámetros optimizados"),
                                                                 verbatimTextOutput("par_tif_ns_op"),
                                                                 h2(" Curva de rendimientos TIF"),
                                                                 plotOutput("c_tif_ns_op")
                                                                  )#final tabpanel
                                                               
                                                                 )#final tabbox
                                              )#final fluidrow
                                                        
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
                                                       
                                                        h2(" Características"),box(style="overflow-x:scroll",width = 12,dataTableOutput("Ca1_ns")),
                                                    fluidRow(
                                                    tabBox( width = 12, title = "Parámetros", id = "tab1_ns_veb", height = "50px", 
                                                            tabPanel(" Parámetros Iniciales ",
                                                        h2(" Parámetros iniciales"),verbatimTextOutput("pa_veb_ns") ,
                                                        h2(" Precios estimados iniciales"),box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_veb_ns")),
                                                        h2(" Curva de rendimientos inicial"),
                                                        plotOutput("c_veb_ns")
                                                            ),#final tabpanel iniciales
                                                        tabPanel(" Elegir Parámetros ",
                                                                 # h2(" Parámetros iniciales"),verbatimTextOutput("pa_veb_ns_el") ,
                                                                 # h2(" Precios estimados iniciales"),dataTableOutput("p_est_veb_ns_el"),
                                                                 # h2(" Curva de rendimientos inicial"),
                                                                 # plotOutput("c_veb_ns_el")
                                                                 h4(" Por favor, insertar parámetros"),
                                                                 box(width=12,title="Importante",status="primary",solidHeader=TRUE ,collapsible = TRUE,
                                                                     collapse= TRUE,"Al ingresar los parámetros considere las siguientes restricciones, ",br(),withMathJax(helpText("$$1) \\quad \\beta_{0} > 0$$")),
                                                                     withMathJax(helpText("$$2) \\quad \\beta_{0}+\\beta_{1} > 0$$")),withMathJax(helpText("$$3) \\quad \\tau > 0$$"))),#final box
                                                                 column(width = 3,numericInput( inputId = "ns_b0_veb", label="B0: ", min = 0, max = 50,step = 0.1, value = 5, width = "40%")
                                                                        , verbatimTextOutput("num_ns_b0_veb")),#final column,
                                                                 column(width = 3,numericInput( inputId = "ns_b1_veb", label="B1: ", min = -10, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                        verbatimTextOutput("num_ns_b1_veb")),#final column
                                                                 column(width = 3,numericInput( inputId = "ns_b2_veb", label="B2: ", min = -10, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                        verbatimTextOutput("num_ns_b2_veb")),#final column
                                                                 column(width = 3,numericInput( inputId = "ns_t_veb", label="T: ", min = 0, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                        verbatimTextOutput("num_ns_t_veb")),#final column
                                                                 h4(" Los nuevos parámetros considerados son, "),
                                                                 verbatimTextOutput("new_ns_veb"),
                                                                 h4(" Verificación, "),
                                                                 verbatimTextOutput("ver_ns_veb"),
                                                                 h2(" Precios estimados"),box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_veb_ns_el")),
                                                                 h4(" Curva de Rendimiento"),
                                                                 plotOutput("c_veb_ns1_new")
                                                        ),#final tabpanel elegir
                                                        tabPanel(" Parámetros Optimizados ",
                                                        h2(" Precios estimados optimizados"),
                                                        radioButtons( inputId = "opt_veb_ns",label = "Desea optimizar los precios obtenidos:", 
                                                                      choices = c("Si"=1, "No"=0),
                                                                      selected=" "),#final radiobuttons
                                                        box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_veb_opt_ns")),
                                                        h2(" Parámetros optimizados"),
                                                        verbatimTextOutput("par_veb_ns_op"),
                                                        h2(" Curva de rendimientos"),
                                                        plotOutput("c_veb_ns_op")
                                                        )#final tabpanel
                                                        )#final tabbox
                                                        
                                                        )#final tabitem vebono,
                                           )#final fluidrow
                                              
                                        )#final tabbox
                                  )#final fluidrow
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
                                                
                                                h2(" Características"),box(style="overflow-x:scroll",width = 12,dataTableOutput("Ca")),
                                                h2(" Parámetros"),
                                                fluidRow(
                                                  tabBox( width = 12, title = "Parámetros", id = "tab1_sven_tif", height = "50px", 
                                                          tabPanel(" Parámetros Iniciales ",verbatimTextOutput("pa_tif"),#withMathJax(uiOutput("formula")),
                                                                   h2(" Precios estimados iniciales"),box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_tif")),
                                                                   h2(" Curva de rendimientos inicial"),
                                                                   plotOutput("c_tif_sven")
                                                          ),#final tabpanel p iniciales
                                                          tabPanel(" Elegir Parámetros ",
                                                                   # verbatimTextOutput("pa_tif"),#withMathJax(uiOutput("formula")),
                                                                   # h2(" Precios estimados iniciales"),dataTableOutput("p_est_tif"),
                                                                   # h2(" Curva de rendimientos inicial"),
                                                                   # plotOutput("c_tif_sven")
                                                                   h4(" Por favor, insertar parámetros"),
                                                                   box(width=12,title="Importante",status="primary",solidHeader=TRUE ,collapsible = TRUE,
                                                                       collapse= TRUE,"Al ingresar los parámetros considere las siguientes restricciones, ",br(),withMathJax(helpText("$$1) \\quad \\beta_{0} > 0$$")),
                                                                       withMathJax(helpText("$$2) \\quad \\beta_{0}+\\beta_{1} > 0$$")),withMathJax(helpText("$$3) \\quad \\tau_{1} > 0$$")),
                                                                       withMathJax(helpText("$$3) \\quad \\tau_{2} > 0$$"))),#final box
                                                                   column(width = 2,numericInput( inputId = "sven_b0_tif", label="B0: ", min = 0, max = 50,step = 0.1, value = 5, width = "40%")
                                                                          , verbatimTextOutput("num_sven_b0_tif")),#final column,
                                                                   column(width = 2,numericInput( inputId = "sven_b1_tif", label="B1: ", min = -10, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                          verbatimTextOutput("num_sven_b1_tif")),#final column
                                                                   column(width = 2,numericInput( inputId = "sven_b2_tif", label="B2: ", min = -10, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                          verbatimTextOutput("num_sven_b2_tif")),#final column
                                                                   column(width = 2,numericInput( inputId = "sven_b3_tif", label="B3: ", min = -10, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                          verbatimTextOutput("num_sven_b3_tif")),#final column
                                                                   column(width = 2,numericInput( inputId = "sven_t1_tif", label="T1: ", min = 0, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                          verbatimTextOutput("num_sven_t1_tif")),#final column
                                                                   column(width = 2,numericInput( inputId = "sven_t2_tif", label="T2: ", min = 0, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                          verbatimTextOutput("num_sven_t2_tif")),#final column
                                                                   h4(" Los nuevos parámetros considerados son, "),
                                                                   verbatimTextOutput("new_sven_tif"),
                                                                   h4(" Verificación, "),
                                                                   verbatimTextOutput("ver_sven_tif"),
                                                                   h2(" Precios estimados"),box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_tif_opt_sven_el")),
                                                                   h4(" Curva de Rendimiento"),
                                                                   plotOutput("c_tif_sven_new")
                                                                   
                                                          ),#final tabpanel p elegidos
                                                          tabPanel(" Parámetros Optimizados",
                                                                   h2(" Precios estimados optimizados"),
                                                                   radioButtons(inputId = "opt_tif_sven",label = "Desea optimizar los precios obtenidos:", 
                                                                                choices = c("Si"=1, "No"=0),
                                                                                selected=" "
                                                                   )#final radiobuttoms
                                                                   ,box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_tif_opt")),
                                                                   h2(" Parámetros optimizados"),
                                                                   verbatimTextOutput("par_tif_sven_op"),
                                                                   h2(" Curva de rendimientos TIF"),
                                                                   plotOutput("c_tif_sven_op")
                                                          )#final tabpanel p optimizados
                                                  )#final tabbox
                                                )#final fluidrow
                                                
                                                
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
                                                 
                                                h2(" Características"),box(style="overflow-x:scroll",width = 12,dataTableOutput("Ca1")),
                                                h2(" Parámetros"),
                                                fluidRow(
                                                  tabBox( width = 12, title = "Parámetros", id = "tab1_sven_veb", height = "50px", 
                                                          tabPanel(" Parámetros Iniciales ",verbatimTextOutput("pa_veb"),#withMathJax(uiOutput("formula")),
                                                                   h2(" Precios estimados iniciales"),box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_veb")),
                                                                   h2(" Curva de rendimientos inicial"),
                                                                   plotOutput("c_veb_sven")
                                                          ),#final tabpanel p iniciales
                                                          tabPanel(" Elegir Parámetros ",
                                                                   # verbatimTextOutput("pa_tif"),#withMathJax(uiOutput("formula")),
                                                                   # h2(" Precios estimados iniciales"),dataTableOutput("p_est_tif"),
                                                                   # h2(" Curva de rendimientos inicial"),
                                                                   # plotOutput("c_tif_sven")
                                                                   h4(" Por favor, insertar parámetros"),
                                                                   box(width=12,title="Importante",status="primary",solidHeader=TRUE ,collapsible = TRUE,
                                                                       collapse= TRUE,"Al ingresar los parámetros considere las siguientes restricciones, ",br(),withMathJax(helpText("$$1) \\quad \\beta_{0} > 0$$")),
                                                                       withMathJax(helpText("$$2) \\quad \\beta_{0}+\\beta_{1} > 0$$")),withMathJax(helpText("$$3) \\quad \\tau_{1} > 0$$")),
                                                                       withMathJax(helpText("$$3) \\quad \\tau_{2} > 0$$"))),#final box
                                                                   column(width = 2,numericInput( inputId = "sven_b0_veb", label="B0: ", min = 0, max = 50,step = 0.1, value = 5, width = "40%")
                                                                          , verbatimTextOutput("num_sven_b0_veb")),#final column,
                                                                   column(width = 2,numericInput( inputId = "sven_b1_veb", label="B1: ", min = -10, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                          verbatimTextOutput("num_sven_b1_veb")),#final column
                                                                   column(width = 2,numericInput( inputId = "sven_b2_veb", label="B2: ", min = -10, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                          verbatimTextOutput("num_sven_b2_veb")),#final column
                                                                   column(width = 2,numericInput( inputId = "sven_b3_veb", label="B3: ", min = -10, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                          verbatimTextOutput("num_sven_b3_veb")),#final column
                                                                   column(width = 2,numericInput( inputId = "sven_t1_veb", label="T1: ", min = 0, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                          verbatimTextOutput("num_sven_t1_veb")),#final column
                                                                   column(width = 2,numericInput( inputId = "sven_t2_veb", label="T2: ", min = 0, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                          verbatimTextOutput("num_sven_t2_veb")),#final column
                                                                   h4(" Los nuevos parámetros considerados son, "),
                                                                   verbatimTextOutput("new_sven_veb"),
                                                                   h4(" Verificación, "),
                                                                   verbatimTextOutput("ver_sven_veb"),
                                                                   h2(" Precios estimados"),box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_veb_opt_sven_el")),
                                                                   h4(" Curva de Rendimiento"),
                                                                   plotOutput("c_veb_sven_new")
                                                                   
                                                          ),#final tabpanel p elegidos
                                                          tabPanel(" Parámetros Optimizados",
                                                                   h2(" Precios estimados optimizados"),
                                                                   radioButtons(inputId = "opt_veb_sven",label = "Desea optimizar los precios obtenidos:", 
                                                                                choices = c("Si"=1, "No"=0),
                                                                                selected=" "),box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_veb_opt"))
                                                                   ,
                                                                   h2(" Parámetros optimizados"),
                                                                   verbatimTextOutput("par_veb_sven_op"),
                                                                   h2(" Curva de rendimientos VEBONOS"),
                                                                   plotOutput("c_veb_sven_op")
                                                          )#final tabpanel p optimizados
                                                         )#final tabbox
                                                      )#final fluidrow
                                               
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
                                   ),#final fluidrow
                                    h2("  Títulos"), h5("  Favor seleccionar los títulos a considerar: "),
                                    fluidRow(tabBox(width = 12, title = "Títulos", id = "tab3", height = "50px", 
                                                    tabPanel("TIF",fluidRow(column(width = 3,checkboxGroupInput( inputId = "t1_dl", label = " ",
                                                                                                                 choices=tit[1:7])#final checkboximput
                                                    ),#final column
                                                    column(width = 3,checkboxGroupInput( inputId = "t2_dl", label = " ",
                                                                                         choices=tit[8:13])#final checkboximput
                                                    ),#final column
                                                    column(width = 3,checkboxGroupInput( inputId = "t3_dl",label = " ", 
                                                                                         choices=tit[14:19])#final checkboximput
                                                    ),#final column
                                                    column(width = 3,checkboxGroupInput( inputId = "t4_dl", label = " ",
                                                                                         choices=tit[20:25])#final checkboximput
                                                    )#final column
                                                    ),#final fluidrow 
                                                    verbatimTextOutput("q1_dl"),h2(" Precios Promedios"),verbatimTextOutput("pre1_dl"),
                                                    
                                                    h2(" Características"),box(style="overflow-x:scroll",width = 12,dataTableOutput("Ca_dl")),
                                                    h2(" Parámetro de suavizamiento"),
                                                    numericInput( inputId = "parametro_tif_dl", label="Parámetro: ", min = -10, max = 100,step = 0.1, value = 1, width = "40%"),
                                                    verbatimTextOutput("spar_tif_dl"),
                                                    h2(" Spline a usar"),
                                                    verbatimTextOutput("spline_tif"),
                                                    h2(" Curva spline Tif"),
                                                    rbokehOutput("c_tif_splines_dl"),
                                                    h2(" Precios estimados"),
                                                    box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_dl_tif")),
                                                    h2(" Curva de Rendimientos"),
                                                    plotlyOutput("curva_tif_dl")
                                                    
                                                    
                                                    ),#final tabpanel tif
                                                    
                                                    tabPanel("VEBONO",fluidRow(
                                                      column(width = 3,checkboxGroupInput(inputId = "v1_dl", label = " ",
                                                                                          choices=tit1[1:8])#final checkboxgroupimput
                                                      ),#final column
                                                      column(width = 3,checkboxGroupInput( inputId = "v2_dl", label = " ",
                                                                                           choices=tit1[9:16])#final checkboxgroupimput
                                                      ),#final column
                                                      column(width = 3,checkboxGroupInput( inputId = "v3_dl",label = " ",
                                                                                           choices=tit1[17:24])#final checkboxgroupimput
                                                      ),#final column
                                                      column(width = 3,checkboxGroupInput( inputId = "v4_dl", label = " ",
                                                                                           choices=tit1[25:29])#final checkboxgroupimput
                                                      )#final column
                                                    ),#final fluidrow
                                                    verbatimTextOutput("q2_dl"), h2(" Precios Promedios"),verbatimTextOutput("pre2_dl"),
                                                    
                                                    h2(" Características"),box(style="overflow-x:scroll",width = 12,dataTableOutput("Ca1_dl")),
                                                    h2(" Parámetro de suavizamiento"),
                                                    numericInput( inputId = "parametro_veb_dl", label="Parámetro: ", min = -10, max = 100,step = 0.1, value = 1, width = "40%"),
                                                    verbatimTextOutput("spar_veb_dl"),
                                                    h2(" Spline a usar"),
                                                    verbatimTextOutput("spline_veb"),
                                                    h2(" Curva spline Vebonos"),
                                                    rbokehOutput("c_veb_splines_dl"),
                                                    h2(" Precios estimados"),
                                                    box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_dl_veb")),
                                                    h2(" Curva de Rendimientos"),
                                                    plotlyOutput("curva_veb_dl")
                                                    
                                                    
                                                    )#final tabpanel veb
                                    )#final tabbox
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
                                   box( width = 6,height = 2,title = "Fecha de valoración: ",verbatimTextOutput('p4'))),
                    h2("  Títulos"), h5("  Favor seleccionar los títulos a considerar: "),
                    fluidRow(tabBox(width = 12, title = "Títulos", id = "tab3", height = "50px", 
                                    tabPanel("TIF",fluidRow(column(width = 3,checkboxGroupInput( inputId = "t1_sp", label = " ",
                                                                                                 choices=tit[1:7])#final checkboximput
                                    ),#final column
                                    column(width = 3,checkboxGroupInput( inputId = "t2_sp", label = " ",
                                                                         choices=tit[8:13])#final checkboximput
                                    ),#final column
                                    column(width = 3,checkboxGroupInput( inputId = "t3_sp",label = " ", 
                                                                         choices=tit[14:19])#final checkboximput
                                    ),#final column
                                    column(width = 3,checkboxGroupInput( inputId = "t4_sp", label = " ",
                                                                         choices=tit[20:25])#final checkboximput
                                    )#final column
                                    ),#final fluidrow 
                                    verbatimTextOutput("q1_sp"),h2(" Precios Promedios"),verbatimTextOutput("pre1_sp"),
                                    
                                    h2(" Características"),box(style="overflow-x:scroll",width = 12,dataTableOutput("Ca_sp")),
                                    h3(" Por favor seleccionar el cantidad de días "),
                                    box(width=12,title="Importante",status="primary",solidHeader=TRUE ,collapsible = TRUE,
                                        collapse= TRUE,"Recuerde que esta es la cantidad de días a considerar hacia atras en el tiempo
                                        con el fin de generar la data con la que se trabajará, por ejemplo si se elige 30 la data 
                                        a considerar serán las observaciones comprendidas entre la fecha de valoración y 
                                        la fecha resultante luego de restarle 30 días a la fecha de valoración" 
                                        ),#final box
                                    numericInput( inputId = "d_tif", label="Días: ", min = 1, max = 100,step = 1, value = 40, width = "40%"),
                                           verbatimTextOutput("dias_tif"),
                                    h2(" Títulos candidatos"),box(style="overflow-x:scroll",width = 12,dataTableOutput("tit_cand_tif")),
                                    h3(" Por favor ingresar el parámetro de suavizamiento "),
                                    box(width=12,title="Importante",status="primary",solidHeader=TRUE ,collapsible = TRUE,
                                        collapse= TRUE,"Recuerde que este valor corresponde al grado de suavidad que tendrá la curva de rendimientos resultante" 
                                    ),#final box
                                    numericInput( inputId = "parametro_tif", label="Parámetro: ", min = -10, max = 100,step = 0.1, value = 1, width = "40%"),
                                           verbatimTextOutput("spar_tif"),
                                    h2(" Precios Splines"),
                                    box(style="overflow-x:scroll",width = 12,dataTableOutput("pre_sp_tif")),
                                    h2(" Curva de rendimientos TIF")
                                    ,
                                    rbokehOutput("c_tif_splines"),#verbatimTextOutput("datos")
                                    h2(" Eliminar observaciones"),
                                    htmlOutput("selectUI_tif"),
                                    h3(" Títulos elegidos"),
                                    verbatimTextOutput("obs_elim_tif"),
                                    h2(" Nuevos títulos candidatos"),
                                    box(style="overflow-x:scroll",width = 12,dataTableOutput("tit_cand_tif_new")),
                                    h2(" Nuevos precios"),
                                    box(style="overflow-x:scroll",width = 12,dataTableOutput("precios_tif_nuevos")),
                                    h2(" Nueva curva de rendimientos"),
                                    rbokehOutput("c_tif_splines_new")
                                    #plotOutput("c_tif_splines_new"),
                                    
                                    #radioButtons(inputId = "elim_tif",label = "Desea eliminar alguna observación:", 
                                     #            choices = c("Si"=1, "No"=0),
                                      #           selected="0"),
                                    #box(style="overflow-x:scroll",width = 12,dataTableOutput("tabla_elim_tif"))
                                    
                                    
                                    
                                    
                                    ),#final tabpanel tif
                                    
                                    tabPanel("VEBONO",fluidRow(
                                      column(width = 3,checkboxGroupInput(inputId = "v1_sp", label = " ",
                                                                          choices=tit1[1:8])#final checkboxgroupimput
                                      ),#final column
                                      column(width = 3,checkboxGroupInput( inputId = "v2_sp", label = " ",
                                                                           choices=tit1[9:16])#final checkboxgroupimput
                                      ),#final column
                                      column(width = 3,checkboxGroupInput( inputId = "v3_sp",label = " ",
                                                                           choices=tit1[17:24])#final checkboxgroupimput
                                      ),#final column
                                      column(width = 3,checkboxGroupInput( inputId = "v4_sp", label = " ",
                                                                           choices=tit1[25:29])#final checkboxgroupimput
                                      )#final column
                                    ),#final fluidrow
                                    verbatimTextOutput("q2_sp"), h2(" Precios Promedios"),verbatimTextOutput("pre2_sp"),
                                    
                                    h2(" Características"),box(style="overflow-x:scroll",width = 12,dataTableOutput("Ca1_sp")),
                                    h3(" Por favor seleccionar el cantidad de días "),
                                    box(width=12,title="Importante",status="primary",solidHeader=TRUE ,collapsible = TRUE,
                                        collapse= TRUE,"Recuerde que esta es la cantidad de días a considerar hacia atras en el tiempo
                                        con el fin de generar la data con la que se trabajará, por ejemplo si se elige 30 la data 
                                        a considerar serán las observaciones comprendidas entre la fecha de valoración y 
                                        la fecha resultante luego de restarle 30 días a la fecha de valoración" 
                                    ),#final box
                                    numericInput( inputId = "d_veb", label="Días: ", min = 1, max = 100,step = 1, value = 40, width = "40%"),
                                    verbatimTextOutput("dias_veb"),
                                    h2(" Títulos candidatos"),
                                    box(style="overflow-x:scroll",width = 12,dataTableOutput("tit_cand_veb")),
                                    h3(" Por favor ingresar el parámetro de suavizamiento "),
                                    box(width=12,title="Importante",status="primary",solidHeader=TRUE ,collapsible = TRUE,
                                        collapse= TRUE,"Recuerde que este valor corresponde al grado de suavidad que tendrá la curva de rendimientos resultante" 
                                    ),#final box
                                    numericInput( inputId = "parametro_veb", label="Parámetro: ", min = -10, max = 100,step = 0.1, value = 1, width = "40%"),
                                    verbatimTextOutput("spar_veb"),
                                    h2(" Precios Splines"),
                                    box(style="overflow-x:scroll",width = 12,dataTableOutput("pre_sp_veb")),
                                    h2(" Curva de rendimientos VEBONO"),
                                    rbokehOutput("c_veb_splines"),#verbatimTextOutput("datos")
                                    h2(" Eliminar observaciones"),
                                    htmlOutput("selectUI_veb"),
                                    h3(" Títulos elegidos"),
                                    verbatimTextOutput("obs_elim_veb"),
                                    h2(" Nuevos títulos candidatos"),
                                    box(style="overflow-x:scroll",width = 12,dataTableOutput("tit_cand_veb_new")),
                                    h2(" Nuevos precios"),
                                    box(style="overflow-x:scroll",width = 12,dataTableOutput("precios_veb_nuevos")),
                                    h2(" Nueva curva de rendimientos"),
                                    rbokehOutput("c_veb_splines_new")
                                    )#final tabpanel veb
                    )#final tabbox
                    )#final fluidrow
                    
                    ),#final tabitem
           
              
              #COMPARATIVO
             
              tabItem(tabName = "datos",
                      h2(" Descarga de archivos"),
                      # Input: Choose dataset ----
                      selectInput("dataset", "Elegir un Archivo:",
                                  choices = c("0-22", "Caracteristicas"
                                             )),
                      
                      # Button
                      downloadButton("downloadData", "Descargar"),
                      h5(" Usted seleccionó"),
                      verbatimTextOutput("desc"),
                      h5(" Vista previa"),
                      tabsetPanel(type="pills",
                          tabPanel("Características",
                              h5("Documento Características"),
                              box(style="overflow-x:scroll",width = 12,
                              dataTableOutput("Ca_leida"))),
                          tabPanel("Operaciones BCV 022",
                              h5("Documento 0-22"),
                              box(style="overflow-x:scroll",width = 12,
                              dataTableOutput("docbcv"))
                                )
                                ),
                      h2("Calculo precio promedio"),
                      #tabBox(width = 12, title = "Títulos", height = "50px",
                      #mainPanel(
                        tabsetPanel(type="pills",
                      tabPanel("TIF",
                      verbatimTextOutput("pre_prom_tif")),
                      tabPanel("VEBONOS",
                               verbatimTextOutput("pre_prom_veb"))
                        )
                      #)
                      #)
                      
                      
                      ),
              
              
                tabItem(tabName = "metodologias",
                      fluidRow(
                       h2(" Comparativo"),
                      fluidRow(column(width = 6,box( width = 12, background = "navy",
                                                     dateInput(inputId="n5", label="Por favor, seleccionar una fecha", language= "es",
                                                               width = "100%")#final dateimput 
                      )#final box
                      ),#final column
                      box( width = 6,height = 2,title = "Fecha de valoración: ",verbatimTextOutput('p5')) #final box
                      ),#final fluidrow
                      h2("  Títulos"), h5("  Favor seleccionar los títulos a considerar: "),
                      fluidRow(
                        tabBox(width = 12, title = "Títulos", id = "tab5", height = "50px", 
                                      tabPanel("TIF",fluidRow(column(width = 3,checkboxGroupInput( inputId = "t1_comp", label = " ",
                                                                                                   choices=tit[1:7])#final checkboximput
                                      ),#final column
                                      column(width = 3,checkboxGroupInput( inputId = "t2_comp", label = " ",
                                                                           choices=tit[8:13])#final checkboximput
                                      ),#final column
                                      column(width = 3,checkboxGroupInput( inputId = "t3_comp",label = " ", 
                                                                           choices=tit[14:19])#final checkboximput
                                      ),#final column
                                      column(width = 3,checkboxGroupInput( inputId = "t4_comp", label = " ",
                                                                           choices=tit[20:25])#final checkboximput
                                      )#final column
                                      ),#final fluidrow 
                                      verbatimTextOutput("q1_comp"),
                                      h2(" Características"),box(style="overflow-x:scroll",width = 12,dataTableOutput("Ca_comp")),
                                      h2(" Metodologías"),
                                      fluidRow(tabBox(width = 12, title = " ", id = "tab5", height = "50px", 
                                             tabPanel("Nelson y siegel",
                                                      h2(" Precios Promedios"),verbatimTextOutput("pre_comp_tif_ns"),
                                                      fluidRow(
                                                        tabBox( width = 12, title = "Parámetros", id = "tab1_ns_tif_comp", height = "50px", 
                                                                
                                                                tabPanel(" Elegir parámetros ",
                                                                         h4(" Por favor, insertar parámetros"),
                                                                         box(width=12,title="Importante",status="primary",solidHeader=TRUE ,collapsible = TRUE,
                                                                             collapse= TRUE,"Al ingresar los parámetros considere las siguientes restricciones, ",br(),withMathJax(helpText("$$1) \\quad \\beta_{0} > 0$$")),
                                                                             withMathJax(helpText("$$2) \\quad \\beta_{0}+\\beta_{1} > 0$$")),withMathJax(helpText("$$3) \\quad \\tau > 0$$"))),#final box
                                                                         column(width = 3,numericInput( inputId = "ns_b0_tif_comp", label="B0: ", min = 0, max = 50,step = 0.1, value = 5, width = "40%")
                                                                                , verbatimTextOutput("num_ns_b0_tif_comp")),#final column,
                                                                         column(width = 3,numericInput( inputId = "ns_b1_tif_comp", label="B1: ", min = -10, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                                verbatimTextOutput("num_ns_b1_tif_comp")),#final column
                                                                         column(width = 3,numericInput( inputId = "ns_b2_tif_comp", label="B2: ", min = -10, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                                verbatimTextOutput("num_ns_b2_tif_comp")),#final column
                                                                         column(width = 3,numericInput( inputId = "ns_t_tif_comp", label="T: ", min = 0, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                                verbatimTextOutput("num_ns_t_tif_comp")),#final column
                                                                         h4(" Los nuevos parámetros considerados son, "),
                                                                         verbatimTextOutput("new_ns_tif_comp"),
                                                                         h4(" Verificación, "),
                                                                         verbatimTextOutput("ver_ns_tif_comp"),
                                                                         h2(" Precios estimados"),box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_tif_ns_el_comp")),
                                                                         h4(" Curva de Rendimiento"),
                                                                         plotOutput("c_tif_ns1_new_comp")
                                                                       
                                                                         
                                                                ),# final tabpanel pa elegir 
                                                                tabPanel(" Parámetros optimizados",
                                                                         h2(" Precios estimados optimizados"),
                                                                         radioButtons( inputId = "opt_tif_ns_comp",label = "Desea optimizar los precios obtenidos:", 
                                                                                       choices = c("Si"=1, "No"=0),
                                                                                       selected=" "), #finalradiobuttons
                                                                         box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_tif_opt_ns_comp")),
                                                                         h2(" Parámetros optimizadoss"),
                                                                         verbatimTextOutput("par_tif_ns_op_comp"),
                                                                         h2(" Curva de rendimientos TIF"),
                                                                         plotOutput("c_tif_ns_op_comp")
                                                                         
                                                                )#final tabpabel pa optimizados
                                                                
                                                                )#final tabbox
                                                      )#final fluid row
                                                        
                                                      
                                             ),#final tabpanel Nelson y siegel
                                             
                                             tabPanel("Svensson",
                                                      h2(" Precios Promedios"),verbatimTextOutput("pre_comp_tif_sven"),
                                                      fluidRow(
                                                        tabBox( width = 12, title = "Parámetros", id = "tab1_sven_tif_comp", height = "50px", 
                                                                
                                                                tabPanel(" Elegir parámetros ",
                                                                         h4(" Por favor, insertar parámetros"),
                                                                         box(width=12,title="Importante",status="primary",solidHeader=TRUE ,collapsible = TRUE,
                                                                             collapse= TRUE,"Al ingresar los parámetros considere las siguientes restricciones, ",br(),withMathJax(helpText("$$1) \\quad \\beta_{0} > 0$$")),
                                                                             withMathJax(helpText("$$2) \\quad \\beta_{0}+\\beta_{1} > 0$$")),withMathJax(helpText("$$3) \\quad \\tau_{1} > 0$$")),
                                                                             withMathJax(helpText("$$3) \\quad \\tau_{2} > 0$$"))),#final box
                                                                         column(width = 2,numericInput( inputId = "sven_b0_tif_comp", label="B0: ", min = 0, max = 50,step = 0.1, value = 5, width = "40%")
                                                                                , verbatimTextOutput("num_sven_b0_tif_comp")),#final column,
                                                                         column(width = 2,numericInput( inputId = "sven_b1_tif_comp", label="B1: ", min = -10, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                                verbatimTextOutput("num_sven_b1_tif_comp")),#final column
                                                                         column(width = 2,numericInput( inputId = "sven_b2_tif_comp", label="B2: ", min = -10, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                                verbatimTextOutput("num_sven_b2_tif_comp")),#final column
                                                                         column(width = 2,numericInput( inputId = "sven_b3_tif_comp", label="B3: ", min = -10, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                                verbatimTextOutput("num_sven_b3_tif_comp")),#final column
                                                                         column(width = 2,numericInput( inputId = "sven_t1_tif_comp", label="T1: ", min = 0, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                                verbatimTextOutput("num_sven_t1_tif_comp")),#final column
                                                                         column(width = 2,numericInput( inputId = "sven_t2_tif_comp", label="T2: ", min = 0, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                                verbatimTextOutput("num_sven_t2_tif_comp")),#final column
                                                                         h4(" Los nuevos parámetros considerados son, "),
                                                                         verbatimTextOutput("new_sven_tif_comp"),
                                                                         h4(" Verificación, "),
                                                                         verbatimTextOutput("ver_sven_tif_comp"),
                                                                         h2(" Precios estimados"),box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_tif_opt_sven_el_comp")),
                                                                         h4(" Curva de Rendimiento"),
                                                                         plotOutput("c_tif_sven_new_comp")
                                                                         
                                                                         
                                                                ),# final tabpanel pa elegir 
                                                                tabPanel(" Parámetros optimizados",
                                                                         h2(" Precios estimados optimizados"),
                                                                         radioButtons(inputId = "opt_tif_sven_comp",label = "Desea optimizar los precios obtenidos:", 
                                                                                      choices = c("Si"=1, "No"=0),
                                                                                      selected=" "
                                                                         )#final radiobuttoms
                                                                         ,box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_tif_opt_comp")),
                                                                         h2(" Parámetros optimizados"),
                                                                         verbatimTextOutput("par_tif_sven_op_comp"),
                                                                         h2(" Curva de rendimientos TIF"),
                                                                         plotOutput("c_tif_sven_op_comp")
                                                                         
                                                                )#final tabpabel pa optimizados
                                                                
                                                        )#final tabbox
                                                      )#final fluid row
                                                      
                                             ),#final tabpanel Svensson 
                                             tabPanel("Diebold Li",
                                                      h2(" Parámetro de suavizamiento"),
                                                      numericInput( inputId = "parametro_tif_dl_comp", label="Parámetro: ", min = -10, max = 100,step = 0.1, value = 1, width = "40%"),
                                                      verbatimTextOutput("spar_tif_dl_comp"),
                                                      h2(" Spline a usar"),
                                                      verbatimTextOutput("spline_tif_comp_out"),
                                                      h2(" Curva spline Tif"),
                                                      rbokehOutput("c_tif_splines_dl_comp"),
                                                      h2(" Precios estimados"),
                                                      box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_dl_tif_comp")),
                                                      h2(" Curva de Rendimientos"),
                                                      plotlyOutput("curva_tif_dl_comp")
                                                      
                                             ),#final tabpanel Diebold li 
                                             tabPanel("Splines",
                                                      h3(" Por favor seleccionar el cantidad de días "),
                                                      box(width=12,title="Importante",status="primary",solidHeader=TRUE ,collapsible = TRUE,
                                                          collapse= TRUE,"Recuerde que esta es la cantidad de días a considerar hacia atras en el tiempo
                                                          con el fin de generar la data con la que se trabajará, por ejemplo si se elige 30 la data 
                                                          a considerar serán las observaciones comprendidas entre la fecha de valoración y 
                                                          la fecha resultante luego de restarle 30 días a la fecha de valoración" 
                                                      ),#final box
                                                      numericInput( inputId = "d_tif_comp", label="Días: ", min = 1, max = 100,step = 1, value = 40, width = "40%"),
                                                      verbatimTextOutput("dias_tif_comp"),
                                                      h2(" Títulos candidatos"),box(style="overflow-x:scroll",width = 12,dataTableOutput("tit_cand_tif_comp")),
                                                      h3(" Por favor ingresar el parámetro de suavizamiento "),
                                                      box(width=12,title="Importante",status="primary",solidHeader=TRUE ,collapsible = TRUE,
                                                          collapse= TRUE,"Recuerde que este valor corresponde al grado de suavidad que tendrá la curva de rendimientos resultante" 
                                                      ),#final box
                                                      numericInput( inputId = "parametro_tif_comp", label="Parámetro: ", min = -10, max = 100,step = 0.1, value = 1, width = "40%"),
                                                      verbatimTextOutput("spar_tif_comp"),
                                                      h2(" Precios Splines"),box(style="overflow-x:scroll",width = 12,dataTableOutput("pre_sp_tif_comp")),
                                                      h2(" Curva de rendimientos TIF"),
                                                      rbokehOutput("c_tif_splines_comp"),#verbatimTextOutput("datos")
                                                      h2(" Eliminar observaciones"),
                                                      htmlOutput("selectUI_tif_comp"),
                                                      h3(" Títulos elegidos"),
                                                      verbatimTextOutput("obs_elim_tif_comp"),
                                                      h2(" Nuevos títulos candidatos"),
                                                      box(style="overflow-x:scroll",width = 12,dataTableOutput("tit_cand_tif_new_comp")),
                                                      h2(" Nuevos precios"),
                                                      box(style="overflow-x:scroll",width = 12,dataTableOutput("precios_tif_nuevos_comp")),
                                                      h2(" Nueva curva de rendimientos"),
                                                      rbokehOutput("c_tif_splines_new_comp")
                                                      
                                                      
                                                      
                                                      )#final tabpanel Splines 
                                      )#final tabbox
                                      )#final fluidrow
                                      ),#final tabpanel tif
                      
                      tabPanel("VEBONO",fluidRow(
                        column(width = 3,checkboxGroupInput(inputId = "v1_comp", label = " ",
                                                            choices=tit1[1:8])#final checkboxgroupimput
                        ),#final column
                        column(width = 3,checkboxGroupInput( inputId = "v2_comp", label = " ",
                                                             choices=tit1[9:16])#final checkboxgroupimput
                        ),#final column
                        column(width = 3,checkboxGroupInput( inputId = "v3_comp",label = " ",
                                                             choices=tit1[17:24])#final checkboxgroupimput
                        ),#final column
                        column(width = 3,checkboxGroupInput( inputId = "v4_comp", label = " ",
                                                             choices=tit1[25:29])#final checkboxgroupimput
                        )#final column
                      ),#final fluidrow
                      verbatimTextOutput("q2_comp"),
                      h2(" Características"),box(style="overflow-x:scroll",width = 12,dataTableOutput("Ca1_comp")),
                      h2(" Metodologías"),
                      fluidRow(tabBox(width = 12, title = " ", id = "tab5", height = "50px", 
                             tabPanel("Nelson y siegel",
                                      h2(" Precios Promedios"),verbatimTextOutput("pre_comp_veb_ns"),
                                      fluidRow(
                                        tabBox( width = 12, title = "Parámetros", id = "tab1_ns_veb_comp", height = "50px", 
                                                
                                                tabPanel(" Elegir parámetros ",
                                                         h4(" Por favor, insertar parámetros"),
                                                         box(width=12,title="Importante",status="primary",solidHeader=TRUE ,collapsible = TRUE,
                                                             collapse= TRUE,"Al ingresar los parámetros considere las siguientes restricciones, ",br(),withMathJax(helpText("$$1) \\quad \\beta_{0} > 0$$")),
                                                             withMathJax(helpText("$$2) \\quad \\beta_{0}+\\beta_{1} > 0$$")),withMathJax(helpText("$$3) \\quad \\tau > 0$$"))),#final box
                                                         column(width = 3,numericInput( inputId = "ns_b0_veb_comp", label="B0: ", min = 0, max = 50,step = 0.1, value = 5, width = "40%")
                                                                , verbatimTextOutput("num_ns_b0_veb_comp")),#final column,
                                                         column(width = 3,numericInput( inputId = "ns_b1_veb_comp", label="B1: ", min = -10, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                verbatimTextOutput("num_ns_b1_veb_comp")),#final column
                                                         column(width = 3,numericInput( inputId = "ns_b2_veb_comp", label="B2: ", min = -10, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                verbatimTextOutput("num_ns_b2_veb_comp")),#final column
                                                         column(width = 3,numericInput( inputId = "ns_t_veb_comp", label="T: ", min = 0, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                verbatimTextOutput("num_ns_t_veb_comp")),#final column
                                                         h4(" Los nuevos parámetros considerados son, "),
                                                         verbatimTextOutput("new_ns_veb_comp"),
                                                         h4(" Verificación, "),
                                                         verbatimTextOutput("ver_ns_veb_comp"),
                                                         h2(" Precios estimados"),box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_veb_ns_el_comp")),
                                                         h4(" Curva de Rendimiento"),
                                                         plotOutput("c_veb_ns1_new_comp")
                                                         
                                                         
                                                         
                                                ),# final tabpanel pa elegir 
                                                tabPanel(" Parámetros optimizados",
                                                         h2(" Precios estimados optimizados"),
                                                         radioButtons( inputId = "opt_veb_ns_comp",label = "Desea optimizar los precios obtenidos:", 
                                                                       choices = c("Si"=1, "No"=0),
                                                                       selected=" "), #finalradiobuttons
                                                         box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_veb_opt_ns_comp")),
                                                         h2(" Parámetros optimizados"),
                                                         verbatimTextOutput("par_veb_ns_op_comp"),
                                                         h2(" Curva de rendimientos VEBONO"),
                                                         plotOutput("c_veb_ns_op_comp")
                                                         
                                                )#final tabpabel pa optimizados
                                                
                                        )#final tabbox
                                      )#final fluid row
                                      
                                      
                             ),#final tabpanel veb
                             tabPanel("Svensson",
                                      h2(" Precios Promedios"),verbatimTextOutput("pre_comp_veb_sven"),
                                      fluidRow(
                                        tabBox( width = 12, title = "Parámetros", id = "tab1_sven_veb_comp", height = "50px", 
                                                
                                                tabPanel(" Elegir parámetros ",
                                                         h4(" Por favor, insertar parámetros"),
                                                         box(width=12,title="Importante",status="primary",solidHeader=TRUE ,collapsible = TRUE,
                                                             collapse= TRUE,"Al ingresar los parámetros considere las siguientes restricciones, ",br(),withMathJax(helpText("$$1) \\quad \\beta_{0} > 0$$")),
                                                             withMathJax(helpText("$$2) \\quad \\beta_{0}+\\beta_{1} > 0$$")),withMathJax(helpText("$$3) \\quad \\tau_{1} > 0$$")),
                                                             withMathJax(helpText("$$3) \\quad \\tau_{2} > 0$$"))),#final box
                                                         column(width = 2,numericInput( inputId = "sven_b0_veb_comp", label="B0: ", min = 0, max = 50,step = 0.1, value = 5, width = "40%")
                                                                , verbatimTextOutput("num_sven_b0_veb_comp")),#final column,
                                                         column(width = 2,numericInput( inputId = "sven_b1_veb_comp", label="B1: ", min = -10, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                verbatimTextOutput("num_sven_b1_veb_comp")),#final column
                                                         column(width = 2,numericInput( inputId = "sven_b2_veb_comp", label="B2: ", min = -10, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                verbatimTextOutput("num_sven_b2_veb_comp")),#final column
                                                         column(width = 2,numericInput( inputId = "sven_b3_veb_comp", label="B3: ", min = -10, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                verbatimTextOutput("num_sven_b3_veb_comp")),#final column
                                                         column(width = 2,numericInput( inputId = "sven_t1_veb_comp", label="T1: ", min = 0, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                verbatimTextOutput("num_sven_t1_veb_comp")),#final column
                                                         column(width = 2,numericInput( inputId = "sven_t2_veb_comp", label="T2: ", min = 0, max = 50,step = 0.1, value = 5, width = "40%"),
                                                                verbatimTextOutput("num_sven_t2_veb_comp")),#final column
                                                         h4(" Los nuevos parámetros considerados son, "),
                                                         verbatimTextOutput("new_sven_veb_comp"),
                                                         h4(" Verificación, "),
                                                         verbatimTextOutput("ver_sven_veb_comp"),
                                                         h2(" Precios estimados"),box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_veb_opt_sven_el_comp")),
                                                         h4(" Curva de Rendimiento"),
                                                         plotOutput("c_veb_sven_new_comp")
                                                         
                                                         
                                                         
                                                ),# final tabpanel pa iniciales 
                                                tabPanel(" Parámetros optimizados",
                                                         h2(" Precios estimados optimizados"),
                                                         radioButtons(inputId = "opt_veb_sven_comp",label = "Desea optimizar los precios obtenidos:", 
                                                                      choices = c("Si"=1, "No"=0),
                                                                      selected=" "
                                                         )#final radiobuttoms
                                                         ,box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_veb_opt_comp")),
                                                         h2(" Parámetros optimizados"),
                                                         verbatimTextOutput("par_veb_sven_op_comp"),
                                                         h2(" Curva de rendimientos VEBONOS"),
                                                         plotOutput("c_veb_sven_op_comp")
                                                         
                                                )#final tabpabel pa optimizados
                                                
                                        )#final tabbox
                                      )#final fluid row
                             ),#final tabpanel Svensson 
                             tabPanel("Diebold Li",
                                      h2(" Parámetro de suavizamiento"),
                                      numericInput( inputId = "parametro_veb_dl_comp", label="Parámetro: ", min = -10, max = 100,step = 0.1, value = 1, width = "40%"),
                                      verbatimTextOutput("spar_veb_dl_comp"),
                                      h2(" Spline a usar"),
                                      verbatimTextOutput("spline_veb_comp_out"),
                                      h2(" Curva spline Tif"),
                                      rbokehOutput("c_veb_splines_dl_comp"),
                                      h2(" Precios estimados"),
                                      box(style="overflow-x:scroll",width = 12,dataTableOutput("p_est_dl_veb_comp")),
                                      h2(" Curva de Rendimientos"),
                                      plotlyOutput("curva_veb_dl_comp")
                             ),#final tabpanel Diebold li 
                             tabPanel("Splines",
                                      h3(" Por favor seleccionar el cantidad de días "),
                                      box(width=12,title="Importante",status="primary",solidHeader=TRUE ,collapsible = TRUE,
                                          collapse= TRUE,"Recuerde que esta es la cantidad de días a considerar hacia atras en el tiempo
                                          con el fin de generar la data con la que se trabajará, por ejemplo si se elige 30 la data 
                                          a considerar serán las observaciones comprendidas entre la fecha de valoración y 
                                          la fecha resultante luego de restarle 30 días a la fecha de valoración" 
                                      ),#final box
                                      numericInput( inputId = "d_veb_comp", label="Días: ", min = 1, max = 100,step = 1, value = 40, width = "40%"),
                                      verbatimTextOutput("dias_veb_comp"),
                                      h2(" Títulos candidatos"),box(style="overflow-x:scroll",width = 12,dataTableOutput("tit_cand_veb_comp")),
                                      h3(" Por favor ingresar el parámetro de suavizamiento "),
                                      box(width=12,title="Importante",status="primary",solidHeader=TRUE ,collapsible = TRUE,
                                          collapse= TRUE,"Recuerde que este valor corresponde al grado de suavidad que tendrá la curva de rendimientos resultante" 
                                      ),#final box
                                      numericInput( inputId = "parametro_veb_comp", label="Parámetro: ", min = -10, max = 100,step = 0.1, value = 1, width = "40%"),
                                      verbatimTextOutput("spar_veb_comp"),
                                      h2(" Precios Splines"),box(style="overflow-x:scroll",width = 12,dataTableOutput("pre_sp_veb_comp")),
                                      h2(" Curva de rendimientos VEBONOS"),
                                      rbokehOutput("c_veb_splines_comp"),#verbatimTextOutput("datos")
                                      h2(" Eliminar observaciones"),
                                      htmlOutput("selectUI_veb_comp"),
                                      h3(" Títulos elegidos"),
                                      verbatimTextOutput("obs_elim_veb_comp"),
                                      h2(" Nuevos títulos candidatos"),
                                      box(style="overflow-x:scroll",width = 12,dataTableOutput("tit_cand_veb_new_comp")),
                                      h2(" Nuevos precios"),
                                      box(style="overflow-x:scroll",width = 12,dataTableOutput("precios_veb_nuevos_comp")),
                                      h2(" Nueva curva de rendimientos"),
                                      rbokehOutput("c_veb_splines_new_comp")
                             )#final tabpanel Splines 
                      )#final tabbox
                      )#final fluid row
                      )#tabpanel veb
                    )#final tabbox tif y vebonos
                    
                  )#final fluidrow que engloba panel tif y veb
                  #  h2(" Comparativo de precios"),
                  # verbatimTextOutput("datos"),
                  #  h2(" Curva de rendimientos comparativa")
                      
              )#final fluid row  
              ),#final tabitem
              
              tabItem(tabName = "precios",
                      h2("Comparativo de precios"),
                      tabBox( width = 12, title = "Instrumentos", id = "precios_comp", height = "50px", 
                              tabPanel("TIF",
                                       box(style="overflow-x:scroll",width = 12,dataTableOutput("comparativo_precios_tif"))
                            
                              ),#final tabpanel
                              tabPanel("VEBONO",
                      
                                       box(style="overflow-x:scroll",width = 12,dataTableOutput("comparativo_precios_veb"))
                      
                              )#final tabpanel
                      )#final tabbox
                      
                      ),#final tabitem
              
              tabItem(tabName = "curvas",
                      h2("Comparativo de curvas"),
                      tabBox( width = 12, title = "Instrumentos", id = "curvas_comp", height = "50px", 
                              tabPanel("TIF",
                                       plotlyOutput("curva_comp_tif"),
                                       h2("Reporte"),
                                       downloadButton("report", "Descargar")
                                       
                                       
                                       
                              ),#final tabpanel
                              tabPanel("VEBONO",
                                       
                                       plotlyOutput("curva_comp_veb"),
                                       h2("Reporte"),
                                       downloadButton("report1", "Descargar")
                                       
                              )#final tabpanel
                      )#final tabbox
                      
                      
                      
              ),#final tabitem
              
              #VALUE AT RISK
              #CARGO DATOS VAR
              tabItem(tabName = "datos_var",
                      h2(" Seleccionar archivo"),
                      h2(" Histórico de precios:"),
                      fluidRow(
                        box(width = 12, title = h3(UPLOADDATA_TEXT),
                            box( width=12,background = "navy",
                                 fileInput('file_data', SELECTFILE_TEXT, accept = UPLOADFILETYPE_CONF,
                                           placeholder = FILESELEC_TEXT, buttonLabel = BUTTSELEC_TEXT )
                            ),
                            fluidRow(
                              box(width=4,background="olive",strong(ENCABEZADO_TEXT),
                                  checkboxInput( width="100%", 'header', WITHHEADER_TEXT, TRUE)),
                              box(width=4,background="olive",
                                  radioButtons( width="40%", 'sep', SEPARATOR_TEXT, UPLOADFILESEP_CONF, ';')),
                              box(width=4,background="olive",
                                  radioButtons( width="40%", 'quote', COMILLAS_TEXT, UPLOADCOMILLAS_CONF, ''))
                            )
                        )
                      ),
                      fluidRow(
                        box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('datatable'))
                      ),
                      h2(" Posiciones:"),
                      fluidRow(
                        box(width = 12, title = h3(UPLOADDATA_TEXT),
                            box( width=12,background = "navy",
                                 fileInput('file_data_pos', SELECTFILE_TEXT, accept = UPLOADFILETYPE_CONF,
                                           placeholder = FILESELEC_TEXT, buttonLabel = BUTTSELEC_TEXT )
                            ),
                            fluidRow(
                              box(width=4,background="olive",strong(ENCABEZADO_TEXT),
                                  checkboxInput( width="100%", 'header_pos', WITHHEADER_TEXT, TRUE)),
                              box(width=4,background="olive",
                                  radioButtons( width="40%", 'sep_pos', SEPARATOR_TEXT, UPLOADFILESEP_CONF, ';')),
                              box(width=4,background="olive",
                                  radioButtons( width="40%", 'quote_pos', COMILLAS_TEXT, UPLOADCOMILLAS_CONF, ''))
                            )
                        )
                      ),
                      fluidRow(
                        box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('datatable_pos'))
                      ),
                      h2(" Aviso"),
                      fluidRow(
                        box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('aviso_datos_var'))
                      ),
                      h2(" Fechas Disponibles"),
                      fluidRow(
                        box(width=6,htmlOutput("fechas_var"))
                      ,
                      #h2(" Fecha seleccionada"),
                      box(width=6,verbatimTextOutput("fecha_elegida"),title = "Fecha Seleccionada")
                      )
                      #,
                      #h2(" Nueva Data"),
                      #box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput("datatable1"))
                      
                      
                      
              ),
              #CALCULO Y BUSCO DISTRIBUCION DE LOS RETORNOS
              tabItem(tabName = "distribucion_var",
                      fluidRow(tabBox( width = 12, title = "VaR", id = "vares", height = "50px", 
                      
                        tabPanel("VaR Individual",
                              h2(" Muestro rendimientos"),
                               box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('dat_rend')),
                               h2(" Por favor seleccione un instrumento:"),
                               htmlOutput("instrumento"),
                               h3(" Elección:"),
                               verbatimTextOutput("elec"),
                               h2(" Resultados ajuste de distribución:"),
                                 box( width=12, style="overflow-x:scroll",status = "success",
                                      tableOutput("result")
                                 ),
                               h2(" Elegir distribución"),
                                 box( width=12,background = "navy",
                                             selectInput( width="100%", inputId = "distsA", label = SELECFUNCTION_TEXT,
                                                          choices= DISTANALAH_CONF, selected = NULL)
                               ),
                               htmlOutput("parametros_dist"),
                               h2(" Elegir porcentaje del VaR:"),
                                 box( width = 12, background = "navy",
                                      selectInput(  width="100%",inputId = "porVar", "Seleccione Porcentaje del VaR", choices = c(0.90, 0.95, 0.99), selected = 0.95)
                                 ),
                               h2(" VaR Individual:"),
                               uiOutput("VaR_inicial")  
                      ),#final tabpanel
                      tabPanel("VaR Portafolio",
                               fluidRow(tabBox( width = 12, title = "Distribuciones", id = "eleccion_dist", height = "50px", 
                                                
                                                tabPanel("Eleccíon individual",
                                                         h2(" Advertencias:"),
                                                         box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('advertencia_dist_varp_el')),
                                                         h2(" Por favor seleccione un instrumento:"),
                                                         htmlOutput("instrumento_varp"),
                                                         h3(" Elección:"),
                                                         verbatimTextOutput("elec_varp"),
                                                         h2(" Resultados ajuste de distribución:"),
                                                         box( width=12, style="overflow-x:scroll",status = "success",
                                                              tableOutput("result_varp")
                                                         ),
                                                         h2(" Elegir distribución"),
                                                         box( width=12,background = "navy",
                                                              selectInput( width="100%", inputId = "distsA_varp", label = SELECFUNCTION_TEXT,
                                                                           choices= DISTANALAH_CONF, selected = NULL)
                                                         ),
                                                         h2(" Parámetros obtenidos"),
                                                         htmlOutput("parametros_dist_varp"),
                                                         h2(" Distribuciones seleccionadas:"),
                                                         radioButtons( inputId = "seleccion_varp",label = "Desea guardar distribución:", 
                                                                       choices = c("Si"=1, "No"=0),selected=0), #finalradiobuttons  
                                                         box( width=12, style="overflow-x:scroll",status = "success",
                                                              tableOutput("dist_varp")
                                                         ),
                                                         h2(" Desea selecionar archivo de distribuciones:"),
                                                         radioButtons( inputId = "seleccion_dist",label = "Elija una opción:", 
                                                                       choices = c("Si"=1, "No"=0),selected=0),
                                                         box( width=12, style="overflow-x:scroll",status = "success",
                                                              tableOutput("dist_elegir")
                                                         )
                                                         
                                                )
                                                #,
                                                
                                                #tabPanel("Elección automática",
                                                #         h2(" Las distribuciones asignadas son:")
                                                #)
                                                
                               )#final tabbox
                               )#final fluidrow
                               
                               
                               
                               

                      )#final tabpanel
              )#final tabbox
                      )#final fluid row        
                      
              ),
              #CALCULO VAR PARA UN HORIZONTE TEMPORAL DADO
              tabItem(tabName = "var",
                      fluidRow(tabBox( width = 12, title = "VaR", id = "vares", height = "50px", 
                                       
                                       tabPanel("Paramétrico",
                                                h2(" VaR normal"),
                                                h3(" Rendimientos:"),
                                                box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('rend_varn')),
                                                h3(" Advertencias:"),
                                                box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('advertencia_varn')),
                                                h3(" Parámetros seleccionados:"),
                                                box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('parametros_varn')),
                                                h3(" Elegir porcentaje del VaR:"),
                                                box( width = 12, background = "navy",
                                                        selectInput( inputId = "porVarn", "Seleccione Porcentaje del VaR", choices = c(.90, .95, .99), selected = .95)
                                                       ),
                                                box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('porcentaje_varn')),
                                                h3(" Vares individuales:"),
                                                box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('tabla_varn')),
                                                h3(" VaR portafolio:"),
                                                box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('varn_portafolio'))
                                                #h3(" Graficos:"),
                                                #plotlyOutput("grafico_vnominal")
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                       ),
                                       tabPanel("Histórico",
                                                h2(" VaR simulación histórica"),
                                                h3(" Advertencia"),
                                                box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('advertencia_varsh')),
                                                h2(" Pesos"),
                                                plotlyOutput("grafico_pesos"),
                                                h2(" Valor Nominal Portafolio"),
                                                verbatimTextOutput("suma_posvarsh"),
                                                h2(" Suma de Pesos"),
                                                verbatimTextOutput("suma_pesos"),
                                                h2(" Escenarios"),
                                                box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('escenarios_varsh')),
                                                h3(" Elegir porcentaje del VaR:"),
                                                box( width = 12, background = "navy",
                                                     selectInput( inputId = "porVarsh", "Seleccione Porcentaje del VaR", choices = c(.90, .95, .99), selected = .95)
                                                ),
                                                box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('porcentaje_varsh')),
                                                h3(" Ubicación:"),
                                                box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('ubicacion_varsh')),
                                                h3(" VaRes Individuales:"),
                                                box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('varind_sh')),
                                                h3(" VaR Portafolio:"),
                                                box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('varsh'))
                                                
                                                
                                                
                                       ),
                                       tabPanel("Simulación Monte Carlo",
                                                fluidRow(tabBox( width = 12, title = "Monte Carlo", id = "var_mc", height = "50px", 
                                                                 
                                                                 tabPanel("Distribución Normal",
                                                                       #fluidRow(      
                                                                          h2(" VaR asumiendo distribución Normal"),    
                                                                       h3(" Rendimientos:"),
                                                                       box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('rend_varmc_n')),
                                                                       h3(" Advertencias:"),
                                                                       box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('advertencia_varmc_n')),
                                                                       h3(" Parámetros seleccionados:"),
                                                                       box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('parametros_varmc_n')),
                                                                       h3(" Elegir porcentaje del VaR:"),
                                                                       box( width = 12, background = "navy",
                                                                            selectInput( inputId = "porVarmc_n", "Seleccione Porcentaje del VaR", choices = c(.90, .95, .99), selected = .95)
                                                                       ),
                                                                       box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('porcentaje_varmc_n')),
                                                                       h3(" Elegir cantidad de simulaciones:"),
                                                                       box( width = 12, background = "navy",
                                                                       numericInput( inputId = "sim_varmc_n", label="Simulaciones a realizar: ", min = 0, max = 100000,step = 1, value = 100, width = "40%")),
                                                                       box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('simulaciones_varmc_n')),
                                                                       h3(" Vares individuales:"),
                                                                       box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('tabla_varmc_n')),
                                                                       h3(" VaR portafolio:"),
                                                                       box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('varmc_portafolio_n1'))
                                                                       #h3(" VaR portafolio 1:"),
                                                                       #box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('varmc_portafolio_n1'))
                                                                       
                                                                       
                                                                       
                                                                       
                                                                       
                                                                       
                                                                       
                                                                 #)#final fluid row
                                                                 ),#final tabpanel
                                                                 tabPanel("Elegir Distribución",
                                                                           h2(" VaR mejor distribución seleccionada"),    
                                                                           h3(" Rendimientos:"),
                                                                           box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('rend_varmc_el')),
                                                                           h3(" Advertencias:"),
                                                                           box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('advertencia_varmc_el')),
                                                                           h3(" Mejores distribuciones elegidas:"),
                                                                           box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('dist_varmc_el')),
                                                                           h3(" Elegir porcentaje del VaR:"),
                                                                           box( width = 12, background = "navy",
                                                                               selectInput( inputId = "porVarmc_el", "Seleccione Porcentaje del VaR", choices = c(.90, .95, .99), selected = .95)
                                                                           ),
                                                                           box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('porcentaje_varmc_el')),
                                                                           h3(" Elegir cantidad de simulaciones:"),
                                                                           box( width = 12, background = "navy",
                                                                               numericInput( inputId = "sim_varmc_el", label="Simulaciones a realizar: ", min = 0, max = 100000,step = 1, value = 100, width = "40%")),
                                                                           box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('simulaciones_varmc_el')),
                                                                           h3(" Vares individuales:"),
                                                                           box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('tabla_varmc_el')),
                                                                           h3(" VaR portafolio:"),
                                                                           box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('varmc_portafolio_el1'))
                                                                          #h3(" VaR portafolio 1:"),
                                                                          #box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('varmc_portafolio_el1'))
                                                                          

                                                                          
                                                                 )#,#final tabpanel
                                                                # tabPanel("Elección Automática",
                                                                #          h2(" Las mejores distribuciones ajustadas son:")    
                                                                          
                                                                # )#final tabpanel
                                               
                                                                
                                                                  )#final tabbox
                                                )#final fluidrow
                                                
                                                
                                                
                                                
                                                
                                       )
                                       
                                       
                      )#final tabbox
                      )#final fluidrow
                      # h2(" Elegir porcentaje del VaR:"),
                      # fluidRow(
                      #   box( width = 6, background = "navy",
                      #        selectInput( inputId = "porVarP", "Seleccione Porcentaje del VaR", choices = c(.90, .95, .99), selected = .95)
                      #   )
                      # ),
                      # box( width = 6, background = "navy",
                      #      selectInput( inputId = "distVarP", label = SELECFUNCTION_TEXT, choices= DISTANALAH_CONF, selected = NULL)
                      # ),
                      # uiOutput("VaR_inicialP"),
                      # 
                      # 
                      # h2(" Calculo VaR portafolio:")
                      
              ),
              #GRAFICOS
              tabItem(tabName = "graficos",
                      fluidRow(tabBox( width = 12, title = " ", id = "graficos_var_normal", height = "50px", 
                                       tabPanel("Valor Nominal",
                                                
                                                plotlyOutput("grafico_vnominal"),
                                                h2("Reporte"),
                                                downloadButton("reporte_var", "Descargar")
                                          
                                                        
                                       )
                                       ,
                                       tabPanel("VaRes",
                                                tabBox( width = 12, title = "", id = "graficos_vares_ind", height = "50px", 
                                                        
                                                        tabPanel("VaR Paramétrico",
                                                                 tabBox( width = 12, title = "Delta-Normal", id = "graficos_varn", height = "50px", 
                                                                         
                                                                         tabPanel("VaR individuales",
                                                                                  plotlyOutput("grafico_vind")
                                                                         ),
                                                                         tabPanel("Comparativo",
                                                                                  plotlyOutput("grafico_vcomp")
                                                                         )
                                                                 )#final tabbox
                                                                 
                                                        ),
                                                        tabPanel("VaR Simulación Histórica",
                                                                 tabBox( width = 12, title = "Simulación Histórica", id = "graficos_varsh", height = "50px", 
                                                                         
                                                                         tabPanel("Escenarios",
                                                                                  plotlyOutput("grafico_hist_sh")
                                                                         ),
                                                                         tabPanel("Vares individuales",
                                                                                  plotlyOutput("grafico_vind_sh")
                                                                         ),
                                                                         tabPanel("Comparativo",
                                                                                  plotlyOutput("grafico_comp_sh")
                                                                         )
                                                                         
                                                                 )#final tabbox
                                                                
                                                        ),
                                                        tabPanel("VaR Simulación Monte Carlo",
                                                                 # tabBox( width = 12, title = "Monte Carlo", id = "graficos_varmc", height = "50px", 
                                                                 #         
                                                                 # tabPanel("Escenarios",
                                                                 #        plotlyOutput("grafico_hist_smcn")
                                                                 # ),
                                                                 # tabPanel("Vares individuales",
                                                                 #       plotlyOutput("grafico_vind_mcn")
                                                                 # ),
                                                                 # tabPanel("Comparativo",
                                                                 #       plotlyOutput("grafico_comp_mcn")
                                                                 # )
                                                                 # )#final tabbox
                                                                 tabBox( width = 12, title = "Monte Carlo", id = "graficos_varmc", height = "50px",

                                                                 tabPanel("Distribución Normal",
                                                                          tabBox( width = 12, title = "", id = "graficos_varmc", height = "50px",

                                                                          tabPanel("Escenarios",
                                                                                 plotlyOutput("grafico_hist_smcn")
                                                                          ),
                                                                          tabPanel("Vares individuales",
                                                                                plotlyOutput("grafico_vind_mcn")
                                                                          ),
                                                                          tabPanel("Comparativo",
                                                                                plotlyOutput("grafico_comp_mcn")
                                                                          )
                                                                          )#final tabbox
                                                                          ),
                                                                 tabPanel("Distribución Elegida",
                                                                          tabBox( width = 12, title = "", id = "graficos_varmc_1", height = "50px",
                                                                                  
                                                                                  tabPanel("Escenarios",
                                                                                           plotlyOutput("grafico_hist_smc_el")
                                                                                  ),
                                                                                  tabPanel("Vares individuales",
                                                                                           plotlyOutput("grafico_vind_mc_el")
                                                                                  ),
                                                                                  tabPanel("Comparativo",
                                                                                           plotlyOutput("grafico_comp_mc_el")
                                                                                  )
                                                                          )#final tabbox
                                                                          )
                                                                 
                                                                 )#final tabbox
                                                                 
                                                        )
                                                )#final tabbox
                                                
                                       ),
                                       tabPanel("Comparativo VaRes",
                                                plotlyOutput("grafico_var_comp")
                                               
                                                
                                       )
                                       
                                       
                      )#final tabbox
                        
                        
                        
                       
                      )#final fluidrow
                      
                      
                      
                      ),#final tab item graficos
              #HISTORICOS
              tabItem(tabName = "historicos",
                      fluidRow(tabBox( width = 12, title = " ", id = "historico_vares", height = "50px", 
                                       tabPanel("VaR Paramétrico",
                                                h2("Rango de fechas disponibles:"),
                                                verbatimTextOutput("fechas_disponibles_par"),
                                                
                                                h2("Favor seleccionar fechas:"),
                                                
                                                dateRangeInput('dateRange_par',
                                                               label = 'Rango de fechas:',
                                                               start = Sys.Date() - 2, end = Sys.Date() + 2
                                                ),
                                                h4("El histórico se calculara para las fechas comprendidas entre:"),
                                                
                                                verbatimTextOutput("dateRangeText_par"),
                                                
                                                #verbatimTextOutput("hola"),
                                              
                                                box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('hola')),
                                                h2("Histórico")
                                     
                                       )
                                       ,
                                       tabPanel("VaR Histórico",
                                                h2("Rango de fechas disponibles:"),
                                                verbatimTextOutput("fechas_disponibles_hist"),
                                                h2("Favor seleccionar fechas:"),
                                                
                                                dateRangeInput('dateRange_hist',
                                                               label = 'Rango de fechas:',
                                                               start = Sys.Date() - 2, end = Sys.Date() + 2
                                                ),
                                                h4("El histórico se calculara para las fechas comprendidas entre:"),
                                                
                                                verbatimTextOutput("dateRangeText_hist"),
                                                
                                                h2("Histórico")
                                                
                                                
                                       ),
                                       tabPanel("VaR SMC Normal",
                                                h2("Rango de fechas disponibles:"),
                                                verbatimTextOutput("fechas_disponibles_smc1"),
                                                h2("Favor seleccionar fechas:"),
                                                
                                                dateRangeInput('dateRange_smc1',
                                                               label = 'Rango de fechas:',
                                                               start = Sys.Date() - 2, end = Sys.Date() + 2
                                                ),
                                                h4("El histórico se calculara para las fechas comprendidas entre:"),
                                                
                                                verbatimTextOutput("dateRangeText_smc1"),
                                               
                                                h2("Histórico")
                                                
                                                
                                       ),  
                                       tabPanel("VaR SMC Mejor Distribución",
                                                h2("Rango de fechas disponibles:"),
                                                verbatimTextOutput("fechas_disponibles_smc2"),
                                                h2("Favor seleccionar fechas:"),
                                                
                                                dateRangeInput('dateRange_smc2',
                                                               label = 'Rango de fechas:',
                                                               start = Sys.Date() - 2, end = Sys.Date() + 2
                                                ),
                                                h4("El histórico se calculara para las fechas comprendidas entre:"),
                                                
                                                verbatimTextOutput("dateRangeText_smc2"),    
                                                
                                                    h2("Histórico")
                                                    
                                                    
                                       )
                                       
                                       
                      )#final tabbox
                      
                      
                      
                      
                      )#final fluidrow
                      
                      
                      
              ),#final tab item Historico
              
              #BACKTESTING
              tabItem(tabName = "datos_back",
                      h2("Datos")
              ),#final tabitem Backtesting
              
              
              
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

