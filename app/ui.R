shinyUI( 
  fluidPage(
  dashboardPage(
    #Header
    # dashboardHeader(title = NULL, titleWidth = 188,
    #           dropdownMenu(type = "messages",
    #                        messageItem(
    #                                   from = "Alerta",
    #                                   message = "Niveles de Riesgo Atípicos",
    #                                   icon = icon("exclamation-triangle"),
    #                                   time = "2018-05-12"
    #                                   )
    #                       )#final dropdownmenu
    #               ),#final dashboardheader
    dashboardHeader(
      title = NULL,
      tags$li(textOutput("bienvenida"), class = "dropdown", style = "padding: 8px;", shinyauthr::logoutUI(id ="logout",label = "Salir", icon = icon("sign-out")))
              
                  ),#final dashboardheader
    #Sidebar
    dashboardSidebar(
      introjsUI(),
      fluidPage(
                #sidebarSearchForm(label = "Ingrese un Número", "searchText", "searchButton"),
              
        collapsed = TRUE, sidebarMenuOutput("sidebar")
        
                # sidebarMenu(id = "tabs",
                #           #fluidPage(
                #             # Application title
                #                         
                # menuItem("Curva de Rendimiento", icon = icon("chart-area"),
                #          introBox(
                #             menuSubItem("Datos", tabName = "datos_curvas", icon = icon("folder-open")),
                #          
                #             menuSubItem("Nelson y Siegel", tabName = "subitem1", icon = icon("circle-o")),
                #             
                #             menuSubItem("Svensson", tabName = "subitem2", icon = icon("circle-o")),
                #             
                #             menuSubItem("Diebold-Li", tabName = "subitem3", icon = icon("circle-o")),
                #             
                #             menuSubItem("Splines", tabName = "subitem4", icon = icon("circle-o")),
                #             data.step = 1,
                #             data.intro = "Esta es la sección de curvas de rendimiento",
                #             data.position = c("right")
                #          ) #final introbox
                #           ),#fin menuitem 
                # 
                # 
                #             #menuItem("Comparativo", icon = icon("circle-o"), tabName = "comparativo"),
                # introBox( 
                # menuItem("Comparativo", icon = icon("th-list"), 
                #          
                #             #menuSubItem("Datos", tabName = "datos", icon = icon("circle-o")),
                #          
                #             menuSubItem("Metodologías", tabName = "metodologias", icon = icon("clipboard-list")),
                #          
                #             menuSubItem("Precios estimados", tabName = "precios", icon = icon("coins")),
                #          
                #             menuSubItem("Curvas", tabName = "curvas", icon = icon("chart-line"))
                #          
                #           ),#fin menuitem 
                # data.step = 2,
                # data.intro = "Esta es la sección de curvas de Comparativos"
                # ), #final introbox
                # 
                # menuItem("Valor en Riesgo", icon = icon("coins"), 
                #          
                #          menuSubItem("Datos", tabName = "datos_var", icon = icon("folder-open")),
                #          
                #          menuSubItem("Distribución", tabName = "distribucion_var", icon = icon("project-diagram")),
                #          
                #          menuSubItem("VaR", tabName = "var", icon = icon("file-invoice-dollar")),
                #          
                #          menuSubItem("Gráficos", tabName = "graficos", icon = icon("chart-pie")),
                #          
                #          menuSubItem("Históricos", tabName = "historicos", icon = icon("calendar-alt"))
                #          
                # ),#fin menuitem 
                #           menuItem("Backtesting", icon = icon("angle-double-left"), 
                #                    menuSubItem("Datos", tabName = "datos_back", icon = icon("folder-open")),
                #                    menuSubItem("Resultados", tabName = "resultados_back", icon = icon("file-alt"))
                #           ),
                #  menuItem("Valoración", icon = icon("bar-chart-o"), 
                #          menuSubItem("Datos", tabName = "datos_val", icon = icon("folder-open")),
                #          menuSubItem("Resultados", tabName = "resultados_val", icon = icon("file-alt")),
                #          menuSubItem("Resultados Prueba de Estrés", tabName = "resultados_val_estres", icon = icon("file-contract"))
                #   ),
                # 
                #             menuItem("Acerca", icon = icon("exclamation-circle"), tabName = "acerca")
                # 
                #           #)#final fluidpage
                # ),#final sidebarmenu
                  
                # introBox(
                #   actionButton("help", "Instrucciones"),
                #   data.step = 3,
                #   data.intro = "Boton de instrucciones"
                # ) #final introbox
                
      )#final fluidpage
                ), #final dashboardsidebar
    #Body
    dashboardBody(
      setBackgroundImage(src = "img/logogrande.png", shinydashboard = TRUE),
      VisionHeader(),
      shinyjs::useShinyjs(),
      extendShinyjs(text = "shinyjs.hidehead = function(parm){
                                    $('header').css('display', parm); }"),
      # put the shinyauthr login ui module here
      shinyauthr::loginUI(id = "login", title = NULL, user_title = "Usuario",
                          pass_title = "Clave", login_title = "Ingresar",
                          error_message = "Usuario o clave inválidos por favor intente de nuevo"
      ),
      # setup any tab pages you want after login here with uiOutputs
            tabItems(
              tabItem(tabName = "datos_curvas",
                      uiOutput("tab1")
              ),
              
              
              
              #NELSON Y SIEGEL
              
               tabItem(tabName = "subitem1",
                       uiOutput("tab2")
              ),#final tabitem
               #SVENSSON
               tabItem(tabName = "subitem2",
                       uiOutput("tab3")
               ),#final tabitem
               #DIEBOLD-LI
               tabItem(tabName = "subitem3",
                       uiOutput("tab4")
                       ),#final tabitem dl
               #SPLINES
               tabItem(tabName = "subitem4",
                       uiOutput("tab5")
                    ),#final tabitem
           
              
              #COMPARATIVO
             
              # tabItem(tabName = "datos",
              #         h2(" Descarga de archivos"),
              #         # Input: Choose dataset ----
              #         selectInput("dataset", "Elegir un Archivo:",
              #                     choices = c("0-22", "Caracteristicas"
              #                                )),
              #         
              #         # Button
              #         downloadButton("downloadData", "Descargar"),
              #         h5(" Usted seleccionó"),
              #         verbatimTextOutput("desc"),
              #         h5(" Vista previa"),
              #         tabsetPanel(type="pills",
              #             tabPanel("Características",
              #                 h5("Documento Características"),
              #                 box(style="overflow-x:scroll",width = 12,
              #                 dataTableOutput("Ca_leida"))),
              #             tabPanel("Operaciones BCV 022",
              #                 h5("Documento 0-22"),
              #                 box(style="overflow-x:scroll",width = 12,
              #                 dataTableOutput("docbcv"))
              #                   )
              #                   ),
              #         h2("Calculo precio promedio"),
              #         #tabBox(width = 12, title = "Títulos", height = "50px",
              #         #mainPanel(
              #           tabsetPanel(type="pills",
              #         tabPanel("TIF",
              #         verbatimTextOutput("pre_prom_tif")),
              #         tabPanel("VEBONOS",
              #                  verbatimTextOutput("pre_prom_veb"))
              #           )
              #         #)
              #         #)
              #         
              #         
              #         ),
              # 
              
                tabItem(tabName = "metodologias",
                          uiOutput("tab6")
              ),#final tabitem
              
              tabItem(tabName = "precios",
                      uiOutput("tab7")
                      ),#final tabitem
              
              tabItem(tabName = "curvas",
                      uiOutput("tab8")
              ),#final tabitem
              
              #VALUE AT RISK
              #CARGO DATOS VAR
              tabItem(tabName = "datos_var",
                      uiOutput("tab9")
              ),
              #CALCULO Y BUSCO DISTRIBUCION DE LOS RETORNOS
              tabItem(tabName = "distribucion_var",
                      uiOutput("tab10")
                      #fluidRow(
                        
                      #  tabBox( width = 12, title = "VaR", id = "vares", height = "50px", 
                      
                      #   tabPanel("VaR Individual",
                      #         h2(" Muestro rendimientos"),
                      #          box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('dat_rend')),
                      #          h2(" Por favor seleccione un instrumento:"),
                      #          htmlOutput("instrumento"),
                      #          h3(" Elección:"),
                      #          verbatimTextOutput("elec"),
                      #          h2(" Resultados ajuste de distribución:"),
                      #            box( width=12, style="overflow-x:scroll",status = "success",
                      #                 tableOutput("result")
                      #            ),
                      #          h2(" Elegir distribución"),
                      #            box( width=12,background = "navy",
                      #                        selectInput( width="100%", inputId = "distsA", label = SELECFUNCTION_TEXT,
                      #                                     choices= DISTANALAH_CONF, selected = NULL)
                      #          ),
                      #          htmlOutput("parametros_dist"),
                      #          h2(" Elegir porcentaje del VaR:"),
                      #            box( width = 12, background = "navy",
                      #                 selectInput(  width="100%",inputId = "porVar", "Seleccione Porcentaje del VaR", choices = c(0.90, 0.95, 0.99), selected = 0.95)
                      #            ),
                      #          h2(" VaR Individual:"),
                      #          uiOutput("VaR_inicial")  
                      # ),#final tabpanel
                      #tabPanel("VaR Portafolio",
                      
                      
                     # )#final tabpanel
              #)#final tabbox
                      #)#final fluid row        
                      
              ),
              #CALCULO VAR PARA UN HORIZONTE TEMPORAL DADO
              tabItem(tabName = "var",
                      uiOutput("tab11")
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
                      uiOutput("tab12")
                      ),#final tab item graficos
              #HISTORICOS
              tabItem(tabName = "historicos",
                      uiOutput("tab13")
              ),#final tab item Historico
              
              #BACKTESTING
              tabItem(tabName = "datos_back",
                      uiOutput("tab14")
              ),#final tabitem Backtesting
              tabItem(tabName = "resultados_back",
                      uiOutput("tab15")
              ),#final tabitem Backtesting
              
            #VALORACION
            tabItem(tabName = "datos_val",
                    uiOutput("tab16")
            ),#final tabitem Valoracion
            tabItem(tabName = "resultados_val",
                    uiOutput("tab17")
            ),#final tabitem Valoracion
            tabItem(tabName = "resultados_val_estres",
                    uiOutput("tab18")
            ),#final tabitem Valoracion   
              
              #ACERCA
                       tabItem(tabName = "acerca",
                               uiOutput('acerca1')
                      )#final tabitem
                    )#final tabitems
                  )#final dashboardbody
                )#final dashboardpage
              )#final fuidpage
        )#final shinyui

