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
                                      )
                           #,#final messageitem
                          
                          # messageItem(
                          #            from = "Señal",
                          #            message = "Volatilidad Anormal",
                          #            icon = icon("life-ring"),
                          #            time = "2018-05-12"
                          #             )#final messageitem
                          )#final dropdownmenu
                  ),#final dashboardheader
    #Sidebar
    dashboardSidebar(
      
                #sidebarSearchForm(label = "Ingrese un Número", "searchText", "searchButton"),
              
                sidebarMenu(id = "tabs",
                          
                menuItem("Curva de Rendimiento", icon = icon("chart-area"),
                         
                            menuSubItem("Datos", tabName = "datos_curvas", icon = icon("folder-open")),
                         
                            menuSubItem("Nelson y Siegel", tabName = "subitem1", icon = icon("circle-o")),
                            
                            menuSubItem("Svensson", tabName = "subitem2", icon = icon("circle-o")),
                            
                            menuSubItem("Diebold-Li", tabName = "subitem3", icon = icon("circle-o")),
                            
                            menuSubItem("Splines", tabName = "subitem4", icon = icon("circle-o"))
                       
                          ),#fin menuitem 
                
                            #menuItem("Comparativo", icon = icon("circle-o"), tabName = "comparativo"),
                menuItem("Comparativo", icon = icon("th-list"), 
                         
                            #menuSubItem("Datos", tabName = "datos", icon = icon("circle-o")),
                         
                            menuSubItem("Metodologías", tabName = "metodologias", icon = icon("clipboard-list")),
                         
                            menuSubItem("Precios estimados", tabName = "precios", icon = icon("coins")),
                         
                            menuSubItem("Curvas", tabName = "curvas", icon = icon("chart-line"))
                         
                          ),#fin menuitem 
                menuItem("Valor en Riesgo", icon = icon("coins"), 
                         
                         menuSubItem("Datos", tabName = "datos_var", icon = icon("folder-open")),
                         
                         menuSubItem("Distribución", tabName = "distribucion_var", icon = icon("project-diagram")),
                         
                         menuSubItem("VaR", tabName = "var", icon = icon("file-invoice-dollar")),
                         
                         menuSubItem("Gráficos", tabName = "graficos", icon = icon("chart-pie")),
                         
                         menuSubItem("Históricos", tabName = "historicos", icon = icon("calendar-alt"))
                         
                ),#fin menuitem 
                          menuItem("Backtesting", icon = icon("angle-double-left"), 
                                   menuSubItem("Datos", tabName = "datos_back", icon = icon("folder-open")),
                                   menuSubItem("Resultados", tabName = "resultados_back", icon = icon("file-alt"))
                          ),
                 menuItem("Valoración", icon = icon("bar-chart-o"), 
                         menuSubItem("Datos", tabName = "datos_val", icon = icon("folder-open")),
                         menuSubItem("Resultados", tabName = "resultados_val", icon = icon("file-alt")),
                         menuSubItem("Resultados Prueba de Estrés", tabName = "resultados_val_estres", icon = icon("file-contract"))
                  ),
                
                            menuItem("Acerca", icon = icon("exclamation-circle"), tabName = "acerca"))
                  
                ), #final dashboardsidebar
    #Body
    dashboardBody(VisionHeader(),
            tabItems(
              tabItem(tabName = "datos_curvas",
                      #h2(" Descarga de archivos"),
                      h2(" Archivos a utilizar"),
                      # Input: Choose dataset ----
                      # selectInput("dataset", "Elegir un Archivo:",
                      #             choices = c("0-22", "Caracteristicas"
                      #             )),
                      
                      # Button
                      #downloadButton("downloadData", "Descargar"),
                      #h5(" Usted seleccionó"),
                      #verbatimTextOutput("desc"),
                      #h5(" Vista previa"),
                      tabsetPanel(type="pills",
                                  tabPanel("Características",
                                           h5("Documento Características"),
                                           # box(height ="595",width = "12",column(width = 12,DT::dataTableOutput("Ca_leida"),
                                           #      style="height:500px;overflow-y: scroll;overflow-x: scroll"
                                           #     ))
                                           box(style="overflow-x:scroll",width = 12,
                                               dataTableOutput("Ca_leida"))
                                           )
                                  ,
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
                          wellPanel(
                            #tabBox( width = 12, title = "Títulos", id = "tab1", height = "50px", 
                            tabsetPanel(type="tabs", 
                                    tabPanel("TIF",
                                              #htmlOutput("tit_new_ns_tif"),
                                              #verbatimTextOutput("t_ns_tif"),
                                              
                                              #tabBox( width = 12, title = "Instrumentos", id = "tab_inst_tif", height = "50px", 
                                                  
                                              #tabPanel(" Títulos disponibles ",
                                              tabsetPanel(type="pills",
                                                          tabPanel("Títulos disponibles",
                                              wellPanel(
                                              # checkboxGroupInput(inputId = "t1_ns1", label = NULL,inline = TRUE,width = '100%',
                                              #                     choices = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))[which(substr(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))[,2],1,3)=="TIF"),2])
                                               #htmlOutput("freddy")
                                                #
                                                fluidRow(column(width = 4,checkboxGroupInput( inputId = "t1_ns", label = "Corto Plazo",
                                                                choices=tit[2:9])#final checkboxgroupimput
                                                                ),#final column
                                                         column(width = 4,checkboxGroupInput( inputId = "t2_ns", label = "Mediano Plazo",
                                                                choices=tit[10:20])#final checkboxgroupimput
                                                                ),#final column
                                                         column(width = 4,checkboxGroupInput( inputId = "t3_ns", label = "Largo plazo",
                                                                choices=tit[21:33])#final checkboxgroupimput
                                                                )
                                                         #,#final column
                                                         #column(width = 3,checkboxGroupInput( inputId = "t4_ns", label = " ",
                                                          #      choices=tit[26:33])#final checkboxgroupimput
                                                           #     ) #final column
                                                         )#final fluidrow


                                              )
                                              ),
                                              tabPanel("Elegir Instrumentos",
                                              h2("Seleccione"),
                                              fluidRow(
                                                box(width = 12, title = h3(UPLOADDATA_TEXT),
                                                    box( width=12,background = "navy",
                                                         fileInput('data_tit_tif', SELECTFILE_TEXT, accept = UPLOADFILETYPE_CONF,
                                                                   placeholder = FILESELEC_TEXT, buttonLabel = BUTTSELEC_TEXT )
                                                    ),
                                                    fluidRow(
                                                      box(width=4,background="olive",strong(ENCABEZADO_TEXT),
                                                          checkboxInput( width="100%", 'header_tit_tif', WITHHEADER_TEXT, TRUE)),
                                                      box(width=4,background="olive",
                                                          radioButtons( width="40%", 'sep_tit_tif', SEPARATOR_TEXT, UPLOADFILESEP_CONF, ';')),
                                                      box(width=4,background="olive",
                                                          radioButtons( width="40%", 'quote_tit_tif', COMILLAS_TEXT, UPLOADCOMILLAS_CONF, ''))
                                                    )
                                                )
                                              ),
                                              fluidRow(
                                                box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('datatable_tit_tif'))
                                              )
                                                       )#final tabpanel selecionar titulos
                                              ),
                                              h2("Titulos selecionados"),
                                              verbatimTextOutput("q1_ns1"),
                                              #),
                                              #tabPanel(" Elegir archivo ",
                                              #         h2("Selecione")
                                              #)
                                              #),
                                     
                                              # fluidRow(column(width = 3,checkboxGroupInput( inputId = "t1_ns", label = " ",
                                              #                 choices=tit[1:7])#final checkboxgroupimput
                                              #                 ),#final column
                                              #          column(width = 3,checkboxGroupInput( inputId = "t2_ns", label = " ",
                                              #                 choices=tit[8:13])#final checkboxgroupimput
                                              #                 ),#final column
                                              #          column(width = 3,checkboxGroupInput( inputId = "t3_ns", label = " ",
                                              #                 choices=tit[14:19])#final checkboxgroupimput
                                              #                 ),#final column
                                              #          column(width = 3,checkboxGroupInput( inputId = "t4_ns", label = " ",
                                              #                 choices=tit[20:25])#final checkboxgroupimput
                                              #                 ) #final column
                                              #          ),#final fluidrow
                                              #           verbatimTextOutput("q1_ns11"),
                                              h2(" Precios Promedios"),verbatimTextOutput("pre1_ns"),
                                                 h5("Advertencia"),verbatimTextOutput("ad_pns_tif"),
                                             textInput('vec1_ns', 'Ingrese un precio o vector de precios (separados por coma)'),
                                             #verbatimTextOutput("salida"),
                                             h5("Nuevos precios"),
                                             verbatimTextOutput("np_ns1"),
                                             h5("Nuevos precios promedio"), verbatimTextOutput("sal1_ns"),
                                             #h5("prueba"),verbatimTextOutput("freddy"),
                                              #withMathJax(),
                                              #helpText('\\(\\beta_{0}\\) \\(\\beta_{1}\\) \\(\\beta_{2}\\) \\(\\tau_{1}\\) '),
                                              #uiOutput('ex1')
                                              
                                                        h2(" Características"),box(style="overflow-x:scroll",width = 12,dataTableOutput("Ca_ns")),
                                                        h2(" Parámetros"), 
                                              wellPanel(
                                                        #tabBox( width = 12, title = "Parámetros", id = "tab1_ns_tif", height = "50px", 
                                                       tabsetPanel( type="tabs",
                                                        tabPanel(" Parámetros Iniciales ",
                                                                 
                                                        verbatimTextOutput("pa_tif_ns"),
                                                        h2(" Precios estimados iniciales"),
                                                        box(width = "12",column(width = 12,DT::dataTableOutput("p_est_tif_ns"),
                                                                                                    style="overflow-y: scroll;overflow-x: scroll")),
                                                        h2(" Curva de rendimientos inicial TIF"),
                                                        plotlyOutput("c_tif_ns")
                                                                 
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
                                                                 column(width = 3,numericInput( inputId = "ns_b0_tif", label="B0: ", min = 0, max = 50,step = 0.1, value = "0.52" , width = "40%")
                                                                        , verbatimTextOutput("num_ns_b0_tif")),#final column,
                                                                 column(width = 3,numericInput( inputId = "ns_b1_tif", label="B1: ", min = -10, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                        verbatimTextOutput("num_ns_b1_tif")),#final column
                                                                 column(width = 3,numericInput( inputId = "ns_b2_tif", label="B2: ", min = -10, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                        verbatimTextOutput("num_ns_b2_tif")),#final column
                                                                 column(width = 3,numericInput( inputId = "ns_t_tif", label="T: ", min = 0, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                        verbatimTextOutput("num_ns_t_tif")),#final column
                                                                 #boton q controla la reactividad
                                                                 actionButton("boton1", "Calcular", icon = icon("chart-area"),
                                                                              style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                                 
                                                                 h4(" Los nuevos parámetros considerados son, "),
                                                                 verbatimTextOutput("new_ns_tif"),
                                                                 h4(" Verificación, "),
                                                                 verbatimTextOutput("ver_ns_tif"),
                                                                 h2(" Precios estimados"),
                                                                 box(width = "12",column(width = 12,DT::dataTableOutput("p_est_tif_ns_el"),
                                                                                                       style="overflow-y: scroll;overflow-x: scroll")),
                                                                 h4(" Curva de Rendimiento"),
                                                                 plotlyOutput("c_tif_ns1_new")
                                                                 ),# final tabpanel pa elegir
                                                         
                                                        tabPanel(" Parámetros Optimizados",
                                                                 # verbatimTextOutput("pa_tif_ns_el"),
                                                                 # h2(" Precios estimados iniciales"),dataTableOutput("p_est_tif_ns_el"),
                                                                 # h2(" Curva de rendimientos inicial"),
                                                                 # plotOutput("c_tif_ns_el")
                                                                 
                                                                 radioButtons( inputId = "opt_tif_ns",label = "Desea optimizar los precios obtenidos:", 
                                                                               choices = c("Si"=1, "No"=0),
                                                                               selected=0), #finalradiobuttons
                                                                 
                                                                 #boton q controla la reactividad
                                                                 actionButton("boton_1", "Calcular", icon = icon("chart-area"),
                                                                              style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                                 
                                                                 h2(" Precios estimados optimizados"),
                                               
                                                                 box(width = "12",column(width = 12,DT::dataTableOutput("p_est_tif_opt_ns"),
                                                                                                       style="overflow-y: scroll;overflow-x: scroll")),
                                                                h2(" Parámetros optimizados"),
                                                                 verbatimTextOutput("par_tif_ns_op"),
                                                                 h2(" Curva de rendimientos TIF"),
                                                                plotlyOutput("c_tif_ns_op")
                                                                  )#final tabpanel
                                                               
                                                                 )#final tabbox
                                              )#final fluidrow
                                                        
                                              ),#final tabpanel tif
                                  
                                           tabPanel("VEBONO",
                                                    tabsetPanel(type="pills",
                                                                tabPanel("Títulos disponibles",
                                                                         wellPanel(
                                                                            #checkboxGroupInput( inputId = "t1_ns2", label = NULL,inline = TRUE,width = '100%',
                                                                            #                    choices = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))[which(substr(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))[,2],1,3)=="VEB"),2]),
                                                                           fluidRow(
                                                                             column(width = 4,checkboxGroupInput(inputId = "v1_ns", label = "Corto Plazo",
                                                                                       choices=tit1[3:15])#final checkboxgroupimput
                                                                                    ),#final column
                                                                             column(width = 4,checkboxGroupInput( inputId = "v2_ns", label = "Mediano Plazo",
                                                                                       choices=tit1[16:30])#final checkboxgroupimput
                                                                                    ),#final column
                                                                             column(width = 4,checkboxGroupInput( inputId = "v3_ns",label = "Largo Plazo",
                                                                                       choices=tit1[31:40])#final checkboxgroupimput
                                                                                    )
                                                                             #,#final column
                                                                             #column(width = 3,checkboxGroupInput( inputId = "v4_ns", label = " ",
                                                                              #         choices=tit1[32:40])#final checkboxgroupimput
                                                                               #     )#final column
                                                                                       )#final fluidrow
                                                                           
                                                                           
                                                                           
                                                                           )
                                                                ),
                                                                tabPanel("Elegir Instrumentos",
                                                                         h2("Seleccione"),
                                                                         fluidRow(
                                                                           box(width = 12, title = h3(UPLOADDATA_TEXT),
                                                                               box( width=12,background = "navy",
                                                                                    fileInput('data_tit_veb', SELECTFILE_TEXT, accept = UPLOADFILETYPE_CONF,
                                                                                              placeholder = FILESELEC_TEXT, buttonLabel = BUTTSELEC_TEXT )
                                                                               ),
                                                                               fluidRow(
                                                                                 box(width=4,background="olive",strong(ENCABEZADO_TEXT),
                                                                                     checkboxInput( width="100%", 'header_tit_veb', WITHHEADER_TEXT, TRUE)),
                                                                                 box(width=4,background="olive",
                                                                                     radioButtons( width="40%", 'sep_tit_veb', SEPARATOR_TEXT, UPLOADFILESEP_CONF, ';')),
                                                                                 box(width=4,background="olive",
                                                                                     radioButtons( width="40%", 'quote_tit_veb', COMILLAS_TEXT, UPLOADCOMILLAS_CONF, ''))
                                                                               )
                                                                           )
                                                                         ),
                                                                         fluidRow(
                                                                           box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('datatable_tit_veb'))
                                                                         )
                                                                )#final tabpanel selecionar titulos
                                                    ),
                                                    h2("Titulos selecionados"),
                                                    verbatimTextOutput("q1_ns2"),
                                                    
                                                    # fluidRow(
                                                    #   column(width = 3,checkboxGroupInput(inputId = "v1_ns", label = " ",
                                                    #             choices=tit1[1:8])#final checkboxgroupimput
                                                    #          ),#final column
                                                    #   column(width = 3,checkboxGroupInput( inputId = "v2_ns", label = " ",
                                                    #             choices=tit1[9:16])#final checkboxgroupimput
                                                    #          ),#final column
                                                    #   column(width = 3,checkboxGroupInput( inputId = "v3_ns",label = " ",
                                                    #             choices=tit1[17:24])#final checkboxgroupimput
                                                    #          ),#final column
                                                    #   column(width = 3,checkboxGroupInput( inputId = "v4_ns", label = " ",
                                                    #             choices=tit1[25:29])#final checkboxgroupimput
                                                    #          )#final column
                                                    #             ),#final fluidrow
                                                    #     verbatimTextOutput("q2_ns"),
                                                    
                                                    h2(" Precios Promedios"),verbatimTextOutput("pre2_ns"),
                                                    h5("Advertencia"),verbatimTextOutput("ad_pns_veb"),
                                                    textInput('vec2_ns', 'Ingrese un precio o vector de precios (separados por coma)'),
                                                    #verbatimTextOutput("salida"),
                                                    h5("Nuevos precios"),
                                                    verbatimTextOutput("np_ns2"),
                                                    h5("Nuevos precios promedio"), verbatimTextOutput("sal2_ns"),
                                                    
                                                    
                                                        h2(" Características"),box(style="overflow-x:scroll",width = 12,dataTableOutput("Ca1_ns")),
                                                    h2(" Parámetros"),
                                                    wellPanel(
                                                    #tabBox( width = 12, title = "Parámetros", id = "tab1_ns_veb", height = "50px", 
                                                     tabsetPanel(type="tabs",
                                                             tabPanel(" Parámetros Iniciales ",
                                                        h2(" Parámetros iniciales"),verbatimTextOutput("pa_veb_ns") ,
                                                        h2(" Precios estimados iniciales"),
                                                        box(width = "12",column(width = 12,DT::dataTableOutput("p_est_veb_ns"),
                                                                                              style="overflow-y: scroll;overflow-x: scroll")),
                                                        
                                                        h2(" Curva de rendimientos inicial"),
                                                        plotlyOutput("c_veb_ns")
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
                                                                 column(width = 3,numericInput( inputId = "ns_b0_veb", label="B0: ", min = 0, max = 50,step = 0.1, value = "0.52", width = "40%")
                                                                        , verbatimTextOutput("num_ns_b0_veb")),#final column,
                                                                 column(width = 3,numericInput( inputId = "ns_b1_veb", label="B1: ", min = -10, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                        verbatimTextOutput("num_ns_b1_veb")),#final column
                                                                 column(width = 3,numericInput( inputId = "ns_b2_veb", label="B2: ", min = -10, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                        verbatimTextOutput("num_ns_b2_veb")),#final column
                                                                 column(width = 3,numericInput( inputId = "ns_t_veb", label="T: ", min = 0, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                        verbatimTextOutput("num_ns_t_veb")),#final column
                                                                 #boton q controla la reactividad
                                                                 actionButton("boton2", "Calcular", icon = icon("chart-area"),
                                                                              style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                                 
                                                                 
                                                                 
                                                                 h4(" Los nuevos parámetros considerados son, "),
                                                                 verbatimTextOutput("new_ns_veb"),
                                                                 h4(" Verificación, "),
                                                                 verbatimTextOutput("ver_ns_veb"),
                                                                 h2(" Precios estimados"),
                                                                 box(width = "12",column(width = 12,DT::dataTableOutput("p_est_veb_ns_el"),
                                                                                                       style="overflow-y: scroll;overflow-x: scroll")),
                                                                 
                                                                 h4(" Curva de Rendimiento"),
                                                                 plotlyOutput("c_veb_ns1_new")
                                                        ),#final tabpanel elegir
                                                        tabPanel(" Parámetros Optimizados ",
                                                        
                                                        radioButtons( inputId = "opt_veb_ns",label = "Desea optimizar los precios obtenidos:", 
                                                                      choices = c("Si"=1, "No"=0),
                                                                      selected=0),#final radiobuttons
                                                        #boton q controla la reactividad
                                                        actionButton("boton_2", "Calcular", icon = icon("chart-area"),
                                                                     style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                        
                                                        
                                                        h2(" Precios estimados optimizados"),
                                                        box(width = "12",column(width = 12,DT::dataTableOutput("p_est_veb_opt_ns"),
                                                                                              style="overflow-y: scroll;overflow-x: scroll")),
                                                        
                                                        
                                                        h2(" Parámetros optimizados"),
                                                        verbatimTextOutput("par_veb_ns_op"),
                                                        h2(" Curva de rendimientos"),
                                                        plotlyOutput("c_veb_ns_op")
                                                        )#final tabpanel
                                                        )#final tabbox
                                                        
                                                        )#final tabitem vebono,
                                           )#final fluidrow
                                              
                                        )#final tabbox
                                  )#final fluidrow
              ),#final tabitem
               #SVENSSON
               tabItem(tabName = "subitem2",
                       h2("  Svensson"),
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
                      
                                wellPanel(
                                  #tabBox(width = 12, title = "Títulos", id = "tab1", height = "50px", 
                                  tabsetPanel(type="tabs", 
                                               tabPanel("TIF",
                                                         tabsetPanel(type="pills",
                                                                     tabPanel("Títulos disponibles",
                                                                              wellPanel(
                                                                                fluidRow(column(width = 4,checkboxGroupInput( inputId = "t1", label = "Corto Plazo",
                                                                                                                                             choices=tit[2:9])#final checkboximput
                                                                                ),#final column
                                                                                column(width = 4,checkboxGroupInput( inputId = "t2", label = "Mediano Plazo",
                                                                                                                     choices=tit[10:20])#final checkboximput
                                                                                ),#final column
                                                                                column(width = 4,checkboxGroupInput( inputId = "t3",label = "Largo Plazo",
                                                                                                                     choices=tit[21:33])#final checkboximput
                                                                                )
                                                                                #,#final column
                                                                                #column(width = 3,checkboxGroupInput( inputId = "t4", label = " ",
                                                                                  #                                   choices=tit[26:33])#final checkboximput
                                                                                #)#final column
                                                                                )#final fluidrow
                                                                                
                                                                                )
                                                                     ),
                                                                     tabPanel("Elegir Instrumentos",
                                                                              h2("Seleccione"),
                                                                              fluidRow(
                                                                                box(width = 12, title = h3(UPLOADDATA_TEXT),
                                                                                    box( width=12,background = "navy",
                                                                                         fileInput('data_tit_tif_sv', SELECTFILE_TEXT, accept = UPLOADFILETYPE_CONF,
                                                                                                   placeholder = FILESELEC_TEXT, buttonLabel = BUTTSELEC_TEXT )
                                                                                    ),
                                                                                    fluidRow(
                                                                                      box(width=4,background="olive",strong(ENCABEZADO_TEXT),
                                                                                          checkboxInput( width="100%", 'header_tit_tif_sv', WITHHEADER_TEXT, TRUE)),
                                                                                      box(width=4,background="olive",
                                                                                          radioButtons( width="40%", 'sep_tit_tif_sv', SEPARATOR_TEXT, UPLOADFILESEP_CONF, ';')),
                                                                                      box(width=4,background="olive",
                                                                                          radioButtons( width="40%", 'quote_tit_tif_sv', COMILLAS_TEXT, UPLOADCOMILLAS_CONF, ''))
                                                                                    )
                                                                                )
                                                                              ),
                                                                              fluidRow(
                                                                                box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('datatable_tit_tif_sv'))
                                                                              )
                                                                     )#final tabpanel selecionar titulos
                                                         ),
                                                         h2("Titulos selecionados"),
                                                         verbatimTextOutput("q_sv1"),

                                                #          fluidRow(column(width = 3,checkboxGroupInput( inputId = "t1", label = " ",
                                                #                                                              choices=tit[1:7])#final checkboximput
                                                # ),#final column
                                                # column(width = 3,checkboxGroupInput( inputId = "t2", label = " ",
                                                #                                      choices=tit[8:13])#final checkboximput
                                                # ),#final column
                                                # column(width = 3,checkboxGroupInput( inputId = "t3",label = " ", 
                                                #                                      choices=tit[14:19])#final checkboximput
                                                # ),#final column
                                                # column(width = 3,checkboxGroupInput( inputId = "t4", label = " ",
                                                #                                      choices=tit[20:25])#final checkboximput
                                                # )#final column
                                                # ),#final fluidrow 
                                                # verbatimTextOutput("q1"),
                                                
                                                h2(" Precios Promedios"),verbatimTextOutput("pre1"),
                                                h5("Advertencia"),verbatimTextOutput("ad_psv_tif"),
                                                textInput('vec1_sv', 'Ingrese un precio o vector de precios (separados por coma)'),
                                                #verbatimTextOutput("salida"),
                                                h5("Nuevos precios"),
                                                verbatimTextOutput("np_sv1"),
                                                h5("Nuevos precios promedio"), verbatimTextOutput("sal1_sv"),
                                                
                                                
                                                h2(" Características"),box(style="overflow-x:scroll",width = 12,dataTableOutput("Ca")),
                                                h2(" Parámetros"),
                                                wellPanel(
                                                  #tabBox( width = 12, title = "Parámetros", id = "tab1_sven_tif", height = "50px", 
                                                  tabsetPanel(type="tabs",        
                                                  tabPanel(" Parámetros Iniciales ",verbatimTextOutput("pa_tif"),#withMathJax(uiOutput("formula")),
                                                                   h2(" Precios estimados iniciales"),
                                                           box(width = "12",column(width = 12,DT::dataTableOutput("p_est_tif"),
                                                                                                 style="overflow-y: scroll;overflow-x: scroll")),
                                                           
                                                                   h2(" Curva de rendimientos inicial"),
                                                           plotlyOutput("c_tif_sven")
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
                                                                   column(width = 2,numericInput( inputId = "sven_b0_tif", label="B0: ", min = 0, max = 50,step = 0.1, value = "0.52", width = "40%")
                                                                          , verbatimTextOutput("num_sven_b0_tif")),#final column,
                                                                   column(width = 2,numericInput( inputId = "sven_b1_tif", label="B1: ", min = -10, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                          verbatimTextOutput("num_sven_b1_tif")),#final column
                                                                   column(width = 2,numericInput( inputId = "sven_b2_tif", label="B2: ", min = -10, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                          verbatimTextOutput("num_sven_b2_tif")),#final column
                                                                   column(width = 2,numericInput( inputId = "sven_b3_tif", label="B3: ", min = -10, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                          verbatimTextOutput("num_sven_b3_tif")),#final column
                                                                   column(width = 2,numericInput( inputId = "sven_t1_tif", label="T1: ", min = 0, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                          verbatimTextOutput("num_sven_t1_tif")),#final column
                                                                   column(width = 2,numericInput( inputId = "sven_t2_tif", label="T2: ", min = 0, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                          verbatimTextOutput("num_sven_t2_tif")),#final column
                                                                   #boton q controla la reactividad
                                                                   actionButton("boton3", "Calcular", icon = icon("chart-area"),
                                                                                style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                                   
                                                                   
                                                                   h4(" Los nuevos parámetros considerados son, "),
                                                                   verbatimTextOutput("new_sven_tif"),
                                                                   h4(" Verificación, "),
                                                                   verbatimTextOutput("ver_sven_tif"),
                                                                   h2(" Precios estimados"),
                                                                   box(width = "12",column(width = 12,DT::dataTableOutput("p_est_tif_opt_sven_el"),
                                                                                                         style="overflow-y: scroll;overflow-x: scroll")),
                                                                   
                                                                   h4(" Curva de Rendimiento"),
                                                                   plotlyOutput("c_tif_sven_new")
                                                                   
                                                          ),#final tabpanel p elegidos
                                                          tabPanel(" Parámetros Optimizados",
                                                                   
                                                                   radioButtons(inputId = "opt_tif_sven",label = "Desea optimizar los precios obtenidos:", 
                                                                                choices = c("Si"=1, "No"=0),
                                                                                selected=0),#final radiobuttoms
                                                                   #boton q controla la reactividad
                                                                   actionButton("boton_3", "Calcular", icon = icon("chart-area"),
                                                                                style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                                   
                                                                   
                                                                   
                                                                   h2(" Precios estimados optimizados"),
                                                                   box(width = "12",column(width = 12,DT::dataTableOutput("p_est_tif_opt"),
                                                                                                         style="overflow-y: scroll;overflow-x: scroll")),
                                                                   
                                                                   h2(" Parámetros optimizados"),
                                                                   verbatimTextOutput("par_tif_sven_op"),
                                                                   h2(" Curva de rendimientos TIF"),
                                                                   plotlyOutput("c_tif_sven_op")
                                                          )#final tabpanel p optimizados
                                                  )#final tabbox
                                                )#final fluidrow
                                                
                                                
                                                ),#final tabpanel tif
                                                tabPanel("VEBONO",
                                                         tabsetPanel(type="pills",
                                                                     tabPanel("Títulos disponibles",
                                                                              wellPanel(
                                                                                #checkboxGroupInput( inputId = "t1_ns2", label = NULL,inline = TRUE,width = '100%',
                                                                                #                    choices = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))[which(substr(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))[,2],1,3)=="VEB"),2]),
                                                                                fluidRow(
                                                                                  column(width = 4,checkboxGroupInput(inputId = "v1", label = "Corto Plazo",
                                                                                                                      choices=tit1[3:15])#final checkboxgroupimput
                                                                                  ),#final column
                                                                                  column(width = 4,checkboxGroupInput( inputId = "v2", label = "Mediano Plazo",
                                                                                                                       choices=tit1[16:30])#final checkboxgroupimput
                                                                                  ),#final column
                                                                                  column(width = 4,checkboxGroupInput( inputId = "v3",label = "Largo Plazo",
                                                                                                                       choices=tit1[31:40])#final checkboxgroupimput
                                                                                  )
                                                                                  #,#final column
                                                                                  #column(width = 3,checkboxGroupInput( inputId = "v4", label = " ",
                                                                                  #                                     choices=tit1[32:40])#final checkboxgroupimput
                                                                                  #)#final column
                                                                                )#final fluidrow
                                                                                
                                                                                
                                                                                
                                                                              )
                                                                     ),
                                                                     tabPanel("Elegir Instrumentos",
                                                                              h2("Seleccione"),
                                                                              fluidRow(
                                                                                box(width = 12, title = h3(UPLOADDATA_TEXT),
                                                                                    box( width=12,background = "navy",
                                                                                         fileInput('data_tit_veb_sv', SELECTFILE_TEXT, accept = UPLOADFILETYPE_CONF,
                                                                                                   placeholder = FILESELEC_TEXT, buttonLabel = BUTTSELEC_TEXT )
                                                                                    ),
                                                                                    fluidRow(
                                                                                      box(width=4,background="olive",strong(ENCABEZADO_TEXT),
                                                                                          checkboxInput( width="100%", 'header_tit_veb_sv', WITHHEADER_TEXT, TRUE)),
                                                                                      box(width=4,background="olive",
                                                                                          radioButtons( width="40%", 'sep_tit_veb_sv', SEPARATOR_TEXT, UPLOADFILESEP_CONF, ';')),
                                                                                      box(width=4,background="olive",
                                                                                          radioButtons( width="40%", 'quote_tit_veb_sv', COMILLAS_TEXT, UPLOADCOMILLAS_CONF, ''))
                                                                                    )
                                                                                )
                                                                              ),
                                                                              fluidRow(
                                                                                box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('datatable_tit_veb_sv'))
                                                                              )
                                                                     )#final tabpanel selecionar titulos
                                                         ),
                                                         
                                                         
                                                #          fluidRow(column(width = 3,checkboxGroupInput( inputId = "v1", label = " ",
                                                #                                                                 choices=tit1[1:8])#final checkboximput
                                                # ),#final column
                                                # column(width = 3,checkboxGroupInput( inputId = "v2", label = " ",
                                                #                                      choices=tit1[9:16])#final checkboximput
                                                # ),#final column
                                                # column(width = 3,checkboxGroupInput( inputId = "v3", label = " ",
                                                #                                      choices=tit1[17:24])#final checkboximput
                                                # ),#final column
                                                # column(width = 3,checkboxGroupInput( inputId = "v4", label = " ",
                                                #                                      choices=tit1[25:29])#final checkboximput
                                                # )#final column
                                                # ),#final fluidrow 
                                                verbatimTextOutput("q2"), h2(" Precios Promedios"),verbatimTextOutput("pre2"),
                                                h5("Advertencia"),verbatimTextOutput("ad_psv_veb"),
                                                textInput('vec2_sv', 'Ingrese un precio o vector de precios (separados por coma)'),
                                                #verbatimTextOutput("salida"),
                                                h5("Nuevos precios"),
                                                verbatimTextOutput("np_sv2"),
                                                h5("Nuevos precios promedio"), verbatimTextOutput("sal2_sv"),
                                                
                                                 
                                                h2(" Características"),box(style="overflow-x:scroll",width = 12,dataTableOutput("Ca1")),
                                                h2(" Parámetros"),
                                                wellPanel(
                                                  #tabBox( width = 12, title = "Parámetros", id = "tab1_sven_veb", height = "50px", 
                                                  tabsetPanel(type="tabs",       
                                                   tabPanel(" Parámetros Iniciales ",verbatimTextOutput("pa_veb"),#withMathJax(uiOutput("formula")),
                                                                   h2(" Precios estimados iniciales"),
                                                            box(width = "12",column(width = 12,DT::dataTableOutput("p_est_veb"),
                                                                                                  style="overflow-y: scroll;overflow-x: scroll")),
                                                            
                                                            
                                                                   h2(" Curva de rendimientos inicial"),
                                                            plotlyOutput("c_veb_sven")
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
                                                                   column(width = 2,numericInput( inputId = "sven_b0_veb", label="B0: ", min = 0, max = 50,step = 0.1, value = "0.52", width = "40%")
                                                                          , verbatimTextOutput("num_sven_b0_veb")),#final column,
                                                                   column(width = 2,numericInput( inputId = "sven_b1_veb", label="B1: ", min = -10, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                          verbatimTextOutput("num_sven_b1_veb")),#final column
                                                                   column(width = 2,numericInput( inputId = "sven_b2_veb", label="B2: ", min = -10, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                          verbatimTextOutput("num_sven_b2_veb")),#final column
                                                                   column(width = 2,numericInput( inputId = "sven_b3_veb", label="B3: ", min = -10, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                          verbatimTextOutput("num_sven_b3_veb")),#final column
                                                                   column(width = 2,numericInput( inputId = "sven_t1_veb", label="T1: ", min = 0, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                          verbatimTextOutput("num_sven_t1_veb")),#final column
                                                                   column(width = 2,numericInput( inputId = "sven_t2_veb", label="T2: ", min = 0, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                          verbatimTextOutput("num_sven_t2_veb")),#final column
                                                                   #boton q controla la reactividad
                                                                   actionButton("boton4", "Calcular", icon = icon("chart-area"),
                                                                                style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                                   
                                                                   
                                                                   h4(" Los nuevos parámetros considerados son, "),
                                                                   verbatimTextOutput("new_sven_veb"),
                                                                   h4(" Verificación, "),
                                                                   verbatimTextOutput("ver_sven_veb"),
                                                                   h2(" Precios estimados"),
                                                                   box(width = "12",column(width = 12,DT::dataTableOutput("p_est_veb_opt_sven_el"),
                                                                                                         style="overflow-y: scroll;overflow-x: scroll")),
                                                                   
                                                                   h4(" Curva de Rendimiento"),
                                                                   plotlyOutput("c_veb_sven_new")
                                                                   
                                                          ),#final tabpanel p elegidos
                                                          tabPanel(" Parámetros Optimizados",
                                                                   
                                                                   radioButtons(inputId = "opt_veb_sven",label = "Desea optimizar los precios obtenidos:", 
                                                                                choices = c("Si"=1, "No"=0),
                                                                                selected=0),
                                                                   #boton q controla la reactividad
                                                                   actionButton("boton_4", "Calcular", icon = icon("chart-area"),
                                                                                style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                                   
                                                                   h2(" Precios estimados optimizados"),
                                                                   box(width = "12",column(width = 12,DT::dataTableOutput("p_est_veb_opt"),
                                                                                                         style="overflow-y: scroll;overflow-x: scroll")),
                                                                   
                                                                   
                                                                   h2(" Parámetros optimizados"),
                                                                   verbatimTextOutput("par_veb_sven_op"),
                                                                   h2(" Curva de rendimientos VEBONOS"),
                                                                   plotlyOutput("c_veb_sven_op")
                                                          )#final tabpanel p optimizados
                                                         )#final tabbox
                                                      )#final fluidrow
                                               
                                  )#final tabitem vebono
                                )#final tabbox
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
                                    wellPanel(
                                      #tabBox(width = 12, title = "Títulos", id = "tab3", height = "50px", 
                                      tabsetPanel(type="tabs", 
                                                   tabPanel("TIF",
                                                             tabsetPanel(type="pills",
                                                                         tabPanel("Títulos disponibles",
                                                                                  wellPanel(
                                                                                    fluidRow(column(width = 4,checkboxGroupInput( inputId = "t1_dl", label = "Corto Plazo",
                                                                                                                                  choices=tit[2:9])#final checkboximput
                                                                                    ),#final column
                                                                                    column(width = 4,checkboxGroupInput( inputId = "t2_dl", label = "Mediano Plazo",
                                                                                                                         choices=tit[10:20])#final checkboximput
                                                                                    ),#final column
                                                                                    column(width = 4,checkboxGroupInput( inputId = "t3_dl",label = "Largo Plazo",
                                                                                                                         choices=tit[21:33])#final checkboximput
                                                                                    )
                                                                                    #,#final column
                                                                                    #column(width = 3,checkboxGroupInput( inputId = "t4_dl", label = " ",
                                                                                    #                                     choices=tit[26:33])#final checkboximput
                                                                                    #)#final column
                                                                                    )#final fluidrow
                                                                                    
                                                                                  )
                                                                         ),
                                                                         tabPanel("Elegir Instrumentos",
                                                                                  h2("Seleccione"),
                                                                                  fluidRow(
                                                                                    box(width = 12, title = h3(UPLOADDATA_TEXT),
                                                                                        box( width=12,background = "navy",
                                                                                             fileInput('data_tit_tif_dl', SELECTFILE_TEXT, accept = UPLOADFILETYPE_CONF,
                                                                                                       placeholder = FILESELEC_TEXT, buttonLabel = BUTTSELEC_TEXT )
                                                                                        ),
                                                                                        fluidRow(
                                                                                          box(width=4,background="olive",strong(ENCABEZADO_TEXT),
                                                                                              checkboxInput( width="100%", 'header_tit_tif_dl', WITHHEADER_TEXT, TRUE)),
                                                                                          box(width=4,background="olive",
                                                                                              radioButtons( width="40%", 'sep_tit_tif_dl', SEPARATOR_TEXT, UPLOADFILESEP_CONF, ';')),
                                                                                          box(width=4,background="olive",
                                                                                              radioButtons( width="40%", 'quote_tit_tif_dl', COMILLAS_TEXT, UPLOADCOMILLAS_CONF, ''))
                                                                                        )
                                                                                    )
                                                                                  ),
                                                                                  fluidRow(
                                                                                    box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('datatable_tit_tif_dl'))
                                                                                  )
                                                                         )#final tabpanel selecionar titulos
                                                             ),
                                                             
                                                             
                                                    #          fluidRow(column(width = 3,checkboxGroupInput( inputId = "t1_dl", label = " ",
                                                    #                                                              choices=tit[1:7])#final checkboximput
                                                    # ),#final column
                                                    # column(width = 3,checkboxGroupInput( inputId = "t2_dl", label = " ",
                                                    #                                      choices=tit[8:13])#final checkboximput
                                                    # ),#final column
                                                    # column(width = 3,checkboxGroupInput( inputId = "t3_dl",label = " ", 
                                                    #                                      choices=tit[14:19])#final checkboximput
                                                    # ),#final column
                                                    # column(width = 3,checkboxGroupInput( inputId = "t4_dl", label = " ",
                                                    #                                      choices=tit[20:25])#final checkboximput
                                                    # )#final column
                                                    # ),#final fluidrow 
                                                    verbatimTextOutput("q1_dl"),h2(" Precios Promedios"),verbatimTextOutput("pre1_dl"),
                                                    
                                                    h2(" Características"),box(style="overflow-x:scroll",width = 12,dataTableOutput("Ca_dl")),
                                                    h2(" Cantidad de observaciones"),
                                                    numericInput( inputId = "d_tif_dl", label="Días: ", min = 1, max = 100,step = 1, value = 40, width = "40%"),
                                                    verbatimTextOutput("dias_tif_dl"),
                                                   
                                                    h2(" Spline a usar"),
                                                    verbatimTextOutput("spline_tif"),
                                                    h2(" Parámetro de suavizamiento"),
                                                    numericInput( inputId = "parametro_tif_dl", label="Parámetro: ", min = -10, max = 100,step = 0.1, value = 1, width = "40%"),
                                                    verbatimTextOutput("spar_tif_dl"),
                                                    #boton q controla la reactividad
                                                    actionButton("boton9", "Calcular", icon = icon("chart-area"),
                                                                 style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                    
                                                    
                                                    
                                                    h2(" Curva spline Tif"),
                                                    rbokehOutput("c_tif_splines_dl"),
                                                    h2(" Precios estimados"),
                                                    box(width = "12",column(width = 12,DT::dataTableOutput("p_est_dl_tif"),
                                                                            style="overflow-y: scroll;overflow-x: scroll")),
                                                    
                                                    h2(" Curva de Rendimientos"),
                                                    plotlyOutput("curva_tif_dl")
                                                    
                                                    
                                                    ),#final tabpanel tif
                                                    
                                                    tabPanel("VEBONO",
                                                             tabsetPanel(type="pills",
                                                                         tabPanel("Títulos disponibles",
                                                                                  wellPanel(
                                                                                    #checkboxGroupInput( inputId = "t1_ns2", label = NULL,inline = TRUE,width = '100%',
                                                                                    #                    choices = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))[which(substr(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))[,2],1,3)=="VEB"),2]),
                                                                                    fluidRow(
                                                                                      column(width = 4,checkboxGroupInput(inputId = "v1_dl", label = "Corto Plazo",
                                                                                                                          choices=tit1[3:15])#final checkboxgroupimput
                                                                                      ),#final column
                                                                                      column(width = 4,checkboxGroupInput( inputId = "v2_dl", label = "Mediano Plazo",
                                                                                                                           choices=tit1[16:30])#final checkboxgroupimput
                                                                                      ),#final column
                                                                                      column(width = 4,checkboxGroupInput( inputId = "v3_dl",label = "Largo Plazo",
                                                                                                                           choices=tit1[31:40])#final checkboxgroupimput
                                                                                      )
                                                                                      #,#final column
                                                                                      #column(width = 3,checkboxGroupInput( inputId = "v4_dl", label = " ",
                                                                                       #                                    choices=tit1[32:40])#final checkboxgroupimput
                                                                                      #)#final column
                                                                                    )#final fluidrow
                                                                                    
                                                                                    
                                                                                    
                                                                                  )
                                                                         ),
                                                                         tabPanel("Elegir Instrumentos",
                                                                                  h2("Seleccione"),
                                                                                  fluidRow(
                                                                                    box(width = 12, title = h3(UPLOADDATA_TEXT),
                                                                                        box( width=12,background = "navy",
                                                                                             fileInput('data_tit_veb_dl', SELECTFILE_TEXT, accept = UPLOADFILETYPE_CONF,
                                                                                                       placeholder = FILESELEC_TEXT, buttonLabel = BUTTSELEC_TEXT )
                                                                                        ),
                                                                                        fluidRow(
                                                                                          box(width=4,background="olive",strong(ENCABEZADO_TEXT),
                                                                                              checkboxInput( width="100%", 'header_tit_veb_dl', WITHHEADER_TEXT, TRUE)),
                                                                                          box(width=4,background="olive",
                                                                                              radioButtons( width="40%", 'sep_tit_veb_dl', SEPARATOR_TEXT, UPLOADFILESEP_CONF, ';')),
                                                                                          box(width=4,background="olive",
                                                                                              radioButtons( width="40%", 'quote_tit_veb_dl', COMILLAS_TEXT, UPLOADCOMILLAS_CONF, ''))
                                                                                        )
                                                                                    )
                                                                                  ),
                                                                                  fluidRow(
                                                                                    box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('datatable_tit_veb_dl'))
                                                                                  )
                                                                         )#final tabpanel selecionar titulos
                                                             ),
                                                    #          fluidRow(
                                                    #   column(width = 3,checkboxGroupInput(inputId = "v1_dl", label = " ",
                                                    #                                       choices=tit1[1:8])#final checkboxgroupimput
                                                    #   ),#final column
                                                    #   column(width = 3,checkboxGroupInput( inputId = "v2_dl", label = " ",
                                                    #                                        choices=tit1[9:16])#final checkboxgroupimput
                                                    #   ),#final column
                                                    #   column(width = 3,checkboxGroupInput( inputId = "v3_dl",label = " ",
                                                    #                                        choices=tit1[17:24])#final checkboxgroupimput
                                                    #   ),#final column
                                                    #   column(width = 3,checkboxGroupInput( inputId = "v4_dl", label = " ",
                                                    #                                        choices=tit1[25:29])#final checkboxgroupimput
                                                    #   )#final column
                                                    # ),#final fluidrow
                                                    verbatimTextOutput("q2_dl"), h2(" Precios Promedios"),verbatimTextOutput("pre2_dl"),
                                                    
                                                    h2(" Características"),box(style="overflow-x:scroll",width = 12,dataTableOutput("Ca1_dl")),
                                                    h2(" Cantidad de observaciones"),
                                                    numericInput( inputId = "d_veb_dl", label="Días: ", min = 1, max = 100,step = 1, value = 40, width = "40%"),
                                                    verbatimTextOutput("dias_veb_dl"),
                                                    
                                                    h2(" Spline a usar"),
                                                    verbatimTextOutput("spline_veb"),
                                                    h2(" Parámetro de suavizamiento"),
                                                    numericInput( inputId = "parametro_veb_dl", label="Parámetro: ", min = -10, max = 100,step = 0.1, value = 1, width = "40%"),
                                                    verbatimTextOutput("spar_veb_dl"),
                                                    #boton q controla la reactividad
                                                    actionButton("boton10", "Calcular", icon = icon("chart-area"),
                                                                 style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                    
                                                    
                                                    h2(" Curva spline Vebonos"),
                                                    rbokehOutput("c_veb_splines_dl"),
                                                    h2(" Precios estimados"),
                                                    box(width = "12",column(width = 12,DT::dataTableOutput("p_est_dl_veb"),
                                                                            style="overflow-y: scroll;overflow-x: scroll")),
                                                    
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
                    wellPanel(
                      #tabBox(width = 12, title = "Títulos", id = "tab3", height = "50px", 
                      tabsetPanel(type="tabs", 
                                   tabPanel("TIF",
                                             tabsetPanel(type="pills",
                                                         tabPanel("Títulos disponibles",
                                                                  wellPanel(
                                                                    fluidRow(column(width = 4,checkboxGroupInput( inputId = "t1_sp", label = "Corto Plazo",
                                                                                                                  choices=tit[2:9])#final checkboximput
                                                                    ),#final column
                                                                    column(width = 4,checkboxGroupInput( inputId = "t2_sp", label = "Mediano Plazo",
                                                                                                         choices=tit[10:20])#final checkboximput
                                                                    ),#final column
                                                                    column(width = 4,checkboxGroupInput( inputId = "t3_sp",label = "Largo Plazo",
                                                                                                         choices=tit[21:33])#final checkboximput
                                                                    )
                                                                    #,#final column
                                                                    #column(width = 3,checkboxGroupInput( inputId = "t4_sp", label = " ",
                                                                    #                                     choices=tit[26:33])#final checkboximput
                                                                    #)#final column
                                                                    )#final fluidrow
                                                                    
                                                                  )
                                                         ),
                                                         tabPanel("Elegir Instrumentos",
                                                                  h2("Seleccione"),
                                                                  fluidRow(
                                                                    box(width = 12, title = h3(UPLOADDATA_TEXT),
                                                                        box( width=12,background = "navy",
                                                                             fileInput('data_tit_tif_sp', SELECTFILE_TEXT, accept = UPLOADFILETYPE_CONF,
                                                                                       placeholder = FILESELEC_TEXT, buttonLabel = BUTTSELEC_TEXT )
                                                                        ),
                                                                        fluidRow(
                                                                          box(width=4,background="olive",strong(ENCABEZADO_TEXT),
                                                                              checkboxInput( width="100%", 'header_tit_tif_sp', WITHHEADER_TEXT, TRUE)),
                                                                          box(width=4,background="olive",
                                                                              radioButtons( width="40%", 'sep_tit_tif_sp', SEPARATOR_TEXT, UPLOADFILESEP_CONF, ';')),
                                                                          box(width=4,background="olive",
                                                                              radioButtons( width="40%", 'quote_tit_tif_sp', COMILLAS_TEXT, UPLOADCOMILLAS_CONF, ''))
                                                                        )
                                                                    )
                                                                  ),
                                                                  fluidRow(
                                                                    box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('datatable_tit_tif_sp'))
                                                                  )
                                                         )#final tabpanel selecionar titulos
                                             ),
                                             
                                    #          fluidRow(column(width = 3,checkboxGroupInput( inputId = "t1_sp", label = " ",
                                    #                                                              choices=tit[1:7])#final checkboximput
                                    # ),#final column
                                    # column(width = 3,checkboxGroupInput( inputId = "t2_sp", label = " ",
                                    #                                      choices=tit[8:13])#final checkboximput
                                    # ),#final column
                                    # column(width = 3,checkboxGroupInput( inputId = "t3_sp",label = " ", 
                                    #                                      choices=tit[14:19])#final checkboximput
                                    # ),#final column
                                    # column(width = 3,checkboxGroupInput( inputId = "t4_sp", label = " ",
                                    #                                      choices=tit[20:25])#final checkboximput
                                    # )#final column
                                    # ),#final fluidrow 
                                    
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
                                    #boton q controla la reactividad
                                    actionButton("boton11", "Calcular", icon = icon("chart-area"),
                                                 style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                    
                                    
                                    h2(" Precios Splines"),
                                    box(width = "12",column(width = 12,DT::dataTableOutput("pre_sp_tif"),
                                                                          style="overflow-y: scroll;overflow-x: scroll")),
                                    
                                    h2(" Curva de rendimientos TIF"),
                                    rbokehOutput("c_tif_splines"),#verbatimTextOutput("datos")
                                    #
                                    h2(" Eliminar observaciones"),
                                    htmlOutput("selectUI_tif"),
                                    h3(" Títulos elegidos"),
                                    verbatimTextOutput("obs_elim_tif"),
                                    #boton q controla la reactividad
                                    actionButton("boton12", "Calcular", icon = icon("chart-area"),
                                                 style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                    
                                    h2(" Nuevos títulos candidatos"),
                                      box(style="overflow-x:scroll",width = 12,dataTableOutput("tit_cand_tif_new")),
                                    h2(" Nuevos precios"),
                                    box(width = "12",column(width = 12,DT::dataTableOutput("precios_tif_nuevos"),
                                                                          style="overflow-y: scroll;overflow-x: scroll")),
                                    
                                    h2(" Nueva curva de rendimientos"),
                                    rbokehOutput("c_tif_splines_new")
                                    #plotOutput("c_tif_splines_new"),
                                    
                                    #radioButtons(inputId = "elim_tif",label = "Desea eliminar alguna observación:", 
                                     #            choices = c("Si"=1, "No"=0),
                                      #           selected="0"),
                                    #box(style="overflow-x:scroll",width = 12,dataTableOutput("tabla_elim_tif"))
                                    
                                    
                                    
                                    
                                    ),#final tabpanel tif
                                    
                                    tabPanel("VEBONO",
                                             tabsetPanel(type="pills",
                                                         tabPanel("Títulos disponibles",
                                                                  wellPanel(
                                                                    #checkboxGroupInput( inputId = "t1_ns2", label = NULL,inline = TRUE,width = '100%',
                                                                    #                    choices = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))[which(substr(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))[,2],1,3)=="VEB"),2]),
                                                                    fluidRow(
                                                                      column(width = 4,checkboxGroupInput(inputId = "v1_sp", label = "Corto Plazo",
                                                                                                          choices=tit1[3:15])#final checkboxgroupimput
                                                                      ),#final column
                                                                      column(width = 4,checkboxGroupInput( inputId = "v2_sp", label = "Mediano Plazo",
                                                                                                           choices=tit1[16:30])#final checkboxgroupimput
                                                                      ),#final column
                                                                      column(width = 4,checkboxGroupInput( inputId = "v3_sp",label = "Largo Plazo",
                                                                                                           choices=tit1[31:40])#final checkboxgroupimput
                                                                      )
                                                                      #,#final column
                                                                      #column(width = 3,checkboxGroupInput( inputId = "v4_sp", label = " ",
                                                                      #                                     choices=tit1[32:40])#final checkboxgroupimput
                                                                      #)#final column
                                                                    )#final fluidrow
                                                                    
                                                                    
                                                                    
                                                                  )
                                                         ),
                                                         tabPanel("Elegir Instrumentos",
                                                                  h2("Seleccione"),
                                                                  fluidRow(
                                                                    box(width = 12, title = h3(UPLOADDATA_TEXT),
                                                                        box( width=12,background = "navy",
                                                                             fileInput('data_tit_veb_sp', SELECTFILE_TEXT, accept = UPLOADFILETYPE_CONF,
                                                                                       placeholder = FILESELEC_TEXT, buttonLabel = BUTTSELEC_TEXT )
                                                                        ),
                                                                        fluidRow(
                                                                          box(width=4,background="olive",strong(ENCABEZADO_TEXT),
                                                                              checkboxInput( width="100%", 'header_tit_veb_sp', WITHHEADER_TEXT, TRUE)),
                                                                          box(width=4,background="olive",
                                                                              radioButtons( width="40%", 'sep_tit_veb_sp', SEPARATOR_TEXT, UPLOADFILESEP_CONF, ';')),
                                                                          box(width=4,background="olive",
                                                                              radioButtons( width="40%", 'quote_tit_veb_sp', COMILLAS_TEXT, UPLOADCOMILLAS_CONF, ''))
                                                                        )
                                                                    )
                                                                  ),
                                                                  fluidRow(
                                                                    box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('datatable_tit_veb_sp'))
                                                                  )
                                                         )#final tabpanel selecionar titulos
                                             ),
                                    #          fluidRow(
                                    #   column(width = 3,checkboxGroupInput(inputId = "v1_sp", label = " ",
                                    #                                       choices=tit1[1:8])#final checkboxgroupimput
                                    #   ),#final column
                                    #   column(width = 3,checkboxGroupInput( inputId = "v2_sp", label = " ",
                                    #                                        choices=tit1[9:16])#final checkboxgroupimput
                                    #   ),#final column
                                    #   column(width = 3,checkboxGroupInput( inputId = "v3_sp",label = " ",
                                    #                                        choices=tit1[17:24])#final checkboxgroupimput
                                    #   ),#final column
                                    #   column(width = 3,checkboxGroupInput( inputId = "v4_sp", label = " ",
                                    #                                        choices=tit1[25:29])#final checkboxgroupimput
                                    #   )#final column
                                    # ),#final fluidrow
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
                                    #boton q controla la reactividad
                                    actionButton("boton13", "Calcular", icon = icon("chart-area"),
                                                 style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                    
                                    
                                    h2(" Precios Splines"),
                                    box(width = "12",column(width = 12,DT::dataTableOutput("pre_sp_veb"),
                                                                          style="overflow-y: scroll;overflow-x: scroll")),
                                    
                                    h2(" Curva de rendimientos VEBONO"),
                                    rbokehOutput("c_veb_splines"),#verbatimTextOutput("datos")
                                    h2(" Eliminar observaciones"),
                                    htmlOutput("selectUI_veb"),
                                    h3(" Títulos elegidos"),
                                    verbatimTextOutput("obs_elim_veb"),
                                    
                                    #boton q controla la reactividad
                                    actionButton("boton14", "Calcular", icon = icon("chart-area"),
                                                 style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                    
                                    h2(" Nuevos títulos candidatos"),
                                    box(style="overflow-x:scroll",width = 12,dataTableOutput("tit_cand_veb_new")),
                                    h2(" Nuevos precios"),
                                    box(width = "12",column(width = 12,DT::dataTableOutput("precios_veb_nuevos"),
                                                                          style="overflow-y: scroll;overflow-x: scroll")),
                                    
                                    h2(" Nueva curva de rendimientos"),
                                    rbokehOutput("c_veb_splines_new")
                                    )#final tabpanel veb
                    )#final tabbox
                    )#final fluidrow
                    
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
                       h2(" Comparativo"),
                      fluidRow(column(width = 6,box( width = 12, background = "navy",
                                                     dateInput(inputId="n5", label="Por favor, seleccionar una fecha", language= "es",
                                                               width = "100%")#final dateimput 
                      )#final box
                      ),#final column
                      box( width = 6,height = 2,title = "Fecha de valoración: ",verbatimTextOutput('p5')) #final box
                      ),#final fluidrow
                      h2("  Títulos"), h5("  Favor seleccionar los títulos a considerar: "),
                      wellPanel(
                        #tabBox(width = 12, title = "Títulos", id = "tab5", height = "50px",
                         tabsetPanel(type="tabs",      
                               tabPanel("TIF",
                               tabsetPanel(type="pills",
                                           tabPanel("Títulos disponibles",
                                                    wellPanel(
                                                      fluidRow(column(width = 4,checkboxGroupInput( inputId = "t1_comp", label = "Corto Plazo",
                                                                                                    choices=tit[2:9])#final checkboximput
                                                      ),#final column
                                                      column(width = 4,checkboxGroupInput( inputId = "t2_comp", label = "Mediano Plazo",
                                                                                           choices=tit[10:20])#final checkboximput
                                                      ),#final column
                                                      column(width = 4,checkboxGroupInput( inputId = "t3_comp",label = "Largo Plazo",
                                                                                           choices=tit[21:33])#final checkboximput
                                                      )
                                                      #,#final column
                                                      #column(width = 3,checkboxGroupInput( inputId = "t4_comp", label = " ",
                                                      #                                    choices=tit[26:33])#final checkboximput
                                                      #)#final column
                                                      )#final fluidrow
                                                      
                                                    )
                                           ),
                                           tabPanel("Elegir Instrumentos",
                                                    h2("Seleccione"),
                                                    fluidRow(
                                                      box(width = 12, title = h3(UPLOADDATA_TEXT),
                                                          box( width=12,background = "navy",
                                                               fileInput('data_tit_tif_comp', SELECTFILE_TEXT, accept = UPLOADFILETYPE_CONF,
                                                                         placeholder = FILESELEC_TEXT, buttonLabel = BUTTSELEC_TEXT )
                                                          ),
                                                          fluidRow(
                                                            box(width=4,background="olive",strong(ENCABEZADO_TEXT),
                                                                checkboxInput( width="100%", 'header_tit_tif_comp', WITHHEADER_TEXT, TRUE)),
                                                            box(width=4,background="olive",
                                                                radioButtons( width="40%", 'sep_tit_tif_comp', SEPARATOR_TEXT, UPLOADFILESEP_CONF, ';')),
                                                            box(width=4,background="olive",
                                                                radioButtons( width="40%", 'quote_tit_tif_comp', COMILLAS_TEXT, UPLOADCOMILLAS_CONF, ''))
                                                          )
                                                      )
                                                    ),
                                                    fluidRow(
                                                      box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('datatable_tit_tif_comp'))
                                                    )
                                           )#final tabpanel selecionar titulos
                               ),
                               
                                       
                                                #fluidRow(column(width = 3,checkboxGroupInput( inputId = "t1_comp", label = " ",
                                      #                                                              choices=tit[1:7])#final checkboximput
                                      # ),#final column
                                      # column(width = 3,checkboxGroupInput( inputId = "t2_comp", label = " ",
                                      #                                      choices=tit[8:13])#final checkboximput
                                      # ),#final column
                                      # column(width = 3,checkboxGroupInput( inputId = "t3_comp",label = " ", 
                                      #                                      choices=tit[14:19])#final checkboximput
                                      # ),#final column
                                      # column(width = 3,checkboxGroupInput( inputId = "t4_comp", label = " ",
                                      #                                      choices=tit[20:25])#final checkboximput
                                      # )#final column
                                      # ),#final fluidrow 
                                      verbatimTextOutput("q1_comp"),
                                      h2(" Características"),box(style="overflow-x:scroll",width = 12,dataTableOutput("Ca_comp")),
                                      h2(" Metodologías"),
                                      wellPanel(
                                        #tabBox(width = 12, title = " ", id = "tab5", height = "50px", 
                                        tabsetPanel(type="tabs", 
                                            tabPanel("Nelson y siegel",
                                                      h2(" Precios Promedios"),verbatimTextOutput("pre_comp_tif_ns"),
                                                     
                                                     h5("Advertencia"),verbatimTextOutput("ad_pnsc_tif"),
                                                     textInput('vec1_nsc', 'Ingrese un precio o vector de precios (separados por coma)'),
                                                     #verbatimTextOutput("salida"),
                                                     h5("Nuevos precios"),
                                                     verbatimTextOutput("np_nsc1"),
                                                     h5("Nuevos precios promedio"), verbatimTextOutput("sal1_nsc"),
                                                     
                                                        #tabBox( width = 12, title = "Parámetros", id = "tab1_ns_tif_comp", height = "50px", 
                                                         tabsetPanel(type="pills",       
                                                                tabPanel(" Elegir parámetros ",
                                                                         h4(" Por favor, insertar parámetros"),
                                                                         box(width=12,title="Importante",status="primary",solidHeader=TRUE ,collapsible = TRUE,
                                                                             collapse= TRUE,"Al ingresar los parámetros considere las siguientes restricciones, ",br(),withMathJax(helpText("$$1) \\quad \\beta_{0} > 0$$")),
                                                                             withMathJax(helpText("$$2) \\quad \\beta_{0}+\\beta_{1} > 0$$")),withMathJax(helpText("$$3) \\quad \\tau > 0$$"))),#final box
                                                                         column(width = 3,numericInput( inputId = "ns_b0_tif_comp", label="B0: ", min = 0, max = 50,step = 0.1, value = "0.52", width = "40%")
                                                                                , verbatimTextOutput("num_ns_b0_tif_comp")),#final column,
                                                                         column(width = 3,numericInput( inputId = "ns_b1_tif_comp", label="B1: ", min = -10, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                                verbatimTextOutput("num_ns_b1_tif_comp")),#final column
                                                                         column(width = 3,numericInput( inputId = "ns_b2_tif_comp", label="B2: ", min = -10, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                                verbatimTextOutput("num_ns_b2_tif_comp")),#final column
                                                                         column(width = 3,numericInput( inputId = "ns_t_tif_comp", label="T: ", min = 0, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                                verbatimTextOutput("num_ns_t_tif_comp")),#final column
                                                                         #boton q controla la reactividad
                                                                         actionButton("boton5", "Calcular", icon = icon("chart-area"),
                                                                                      style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                                         
                                                                         
                                                                         h4(" Los nuevos parámetros considerados son, "),
                                                                         verbatimTextOutput("new_ns_tif_comp"),
                                                                         h4(" Verificación, "),
                                                                         verbatimTextOutput("ver_ns_tif_comp"),
                                                                         h2(" Precios estimados"),
                                                                         box(width = "12",column(width = 12,DT::dataTableOutput("p_est_tif_ns_el_comp"),
                                                                                                               style="overflow-y: scroll;overflow-x: scroll")),
                                                                         
                                                                         h4(" Curva de Rendimiento"),
                                                                         plotlyOutput("c_tif_ns1_new_comp")
                                                                       
                                                                         
                                                                ),# final tabpanel pa elegir 
                                                                tabPanel(" Parámetros optimizados",
                                                                         
                                                                         radioButtons( inputId = "opt_tif_ns_comp",label = "Desea optimizar los precios obtenidos:", 
                                                                                       choices = c("Si"=1, "No"=0),
                                                                                       selected=0), #finalradiobuttons
                                                                         #boton q controla la reactividad
                                                                         actionButton("boton_5", "Calcular", icon = icon("chart-area"),
                                                                                      style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                                         
                                                                         
                                                                         h2(" Precios estimados optimizados"),
                                                                         
                                                                         box(width = "12",column(width = 12,DT::dataTableOutput("p_est_tif_opt_ns_comp"),
                                                                                                               style="overflow-y: scroll;overflow-x: scroll")),
                                                                         
                                                                         h2(" Parámetros optimizados"),
                                                                         verbatimTextOutput("par_tif_ns_op_comp"),
                                                                         h2(" Curva de rendimientos TIF"),
                                                                         plotlyOutput("c_tif_ns_op_comp")
                                                                         
                                                                )#final tabpabel pa optimizados
                                                                
                                                                )#final tabbox

                                                      
                                             ),#final tabpanel Nelson y siegel
                                             
                                             tabPanel("Svensson",
                                                      h2(" Precios Promedios"),verbatimTextOutput("pre_comp_tif_sven"),
                                                      h5("Advertencia"),verbatimTextOutput("ad_psvc_tif"),
                                                      textInput('vec1_svc', 'Ingrese un precio o vector de precios (separados por coma)'),
                                                      #verbatimTextOutput("salida"),
                                                      h5("Nuevos precios"),
                                                      verbatimTextOutput("np_svc1"),
                                                      h5("Nuevos precios promedio"), verbatimTextOutput("sal1_svc"),
                                                      
                                                      
                                                        #tabBox( width = 12, title = "Parámetros", id = "tab1_sven_tif_comp", height = "50px", 
                                                      tabsetPanel(type="pills",   
                                                             
                                                                tabPanel(" Elegir parámetros ",
                                                                         h4(" Por favor, insertar parámetros"),
                                                                         box(width=12,title="Importante",status="primary",solidHeader=TRUE ,collapsible = TRUE,
                                                                             collapse= TRUE,"Al ingresar los parámetros considere las siguientes restricciones, ",br(),withMathJax(helpText("$$1) \\quad \\beta_{0} > 0$$")),
                                                                             withMathJax(helpText("$$2) \\quad \\beta_{0}+\\beta_{1} > 0$$")),withMathJax(helpText("$$3) \\quad \\tau_{1} > 0$$")),
                                                                             withMathJax(helpText("$$3) \\quad \\tau_{2} > 0$$"))),#final box
                                                                         column(width = 2,numericInput( inputId = "sven_b0_tif_comp", label="B0: ", min = 0, max = 50,step = 0.1, value = "0.52", width = "40%")
                                                                                , verbatimTextOutput("num_sven_b0_tif_comp")),#final column,
                                                                         column(width = 2,numericInput( inputId = "sven_b1_tif_comp", label="B1: ", min = -10, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                                verbatimTextOutput("num_sven_b1_tif_comp")),#final column
                                                                         column(width = 2,numericInput( inputId = "sven_b2_tif_comp", label="B2: ", min = -10, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                                verbatimTextOutput("num_sven_b2_tif_comp")),#final column
                                                                         column(width = 2,numericInput( inputId = "sven_b3_tif_comp", label="B3: ", min = -10, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                                verbatimTextOutput("num_sven_b3_tif_comp")),#final column
                                                                         column(width = 2,numericInput( inputId = "sven_t1_tif_comp", label="T1: ", min = 0, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                                verbatimTextOutput("num_sven_t1_tif_comp")),#final column
                                                                         column(width = 2,numericInput( inputId = "sven_t2_tif_comp", label="T2: ", min = 0, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                                verbatimTextOutput("num_sven_t2_tif_comp")),#final column
                                                                         #boton q controla la reactividad
                                                                         actionButton("boton6", "Calcular", icon = icon("chart-area"),
                                                                                      style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                                         

                                                                         h4(" Los nuevos parámetros considerados son, "),
                                                                         verbatimTextOutput("new_sven_tif_comp"),
                                                                         h4(" Verificación, "),
                                                                         verbatimTextOutput("ver_sven_tif_comp"),
                                                                         h2(" Precios estimados"),
                                                                         box(width = "12",column(width = 12,DT::dataTableOutput("p_est_tif_opt_sven_el_comp"),
                                                                                                               style="overflow-y: scroll;overflow-x: scroll")),
                                                                         
                                                                         h4(" Curva de Rendimiento"),
                                                                         plotlyOutput("c_tif_sven_new_comp")
                                                                         
                                                                         
                                                                ),# final tabpanel pa elegir 
                                                                tabPanel(" Parámetros optimizados",
                                                                         
                                                                         radioButtons(inputId = "opt_tif_sven_comp",label = "Desea optimizar los precios obtenidos:", 
                                                                                      choices = c("Si"=1, "No"=0),
                                                                                      selected=0
                                                                         ),#final radiobuttoms
                                                                         #boton q controla la reactividad
                                                                         actionButton("boton_7", "Calcular", icon = icon("chart-area"),
                                                                                      style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                                         
                                                                         h2(" Precios estimados optimizados"),
                                                                         box(width = "12",column(width = 12,DT::dataTableOutput("p_est_tif_opt_comp"),
                                                                                                 style="overflow-y: scroll;overflow-x: scroll")),
                                                                         
                                                                         h2(" Parámetros optimizados"),
                                                                         verbatimTextOutput("par_tif_sven_op_comp"),
                                                                         h2(" Curva de rendimientos TIF"),
                                                                         plotlyOutput("c_tif_sven_op_comp")
                                                                         
                                                                )#final tabpabel pa optimizados
                                                                
                                                        )#final tabbox

                                             ),#final tabpanel Svensson 
                                             tabPanel("Diebold Li",
                                                      h2(" Cantidad de observaciones"),
                                                      numericInput( inputId = "d_tif_dl_comp", label="Días: ", min = 1, max = 100,step = 1, value = 40, width = "40%"),
                                                      verbatimTextOutput("dias_tif_dl_comp"),
                                                      h2(" Spline a usar"),
                                                      verbatimTextOutput("spline_tif_comp_out"),
                                                      h2(" Parámetro de suavizamiento"),
                                                      numericInput( inputId = "parametro_tif_dl_comp", label="Parámetro: ", min = -10, max = 100,step = 0.1, value = 1, width = "40%"),
                                                      verbatimTextOutput("spar_tif_dl_comp"),
                                                      #boton q controla la reactividad
                                                      actionButton("boton15", "Calcular", icon = icon("chart-area"),
                                                                   style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                      
                                                      
                                                      
                                                      h2(" Curva spline Tif"),
                                                      rbokehOutput("c_tif_splines_dl_comp"),
                                                      h2(" Precios estimados"),
                                                      box(width = "12",column(width = 12,DT::dataTableOutput("p_est_dl_tif_comp"),
                                                                                            style="overflow-y: scroll;overflow-x: scroll")),
                                                      
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
                                                      #boton q controla la reactividad
                                                      actionButton("boton17", "Calcular", icon = icon("chart-area"),
                                                                   style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                      
                                                      
                                                      h2(" Precios Splines"),
                                                      box(width = "12",column(width = 12,DT::dataTableOutput("pre_sp_tif_comp"),
                                                                                            style="overflow-y: scroll;overflow-x: scroll")),
                                                      
                                                      h2(" Curva de rendimientos TIF"),
                                                      rbokehOutput("c_tif_splines_comp"),#verbatimTextOutput("datos")
                                                      h2(" Eliminar observaciones"),
                                                      htmlOutput("selectUI_tif_comp"),
                                                      #boton q controla la reactividad
                                                      actionButton("boton18", "Calcular", icon = icon("chart-area"),
                                                                   style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                      
                                                      
                                                      h3(" Títulos elegidos"),
                                                      verbatimTextOutput("obs_elim_tif_comp"),
                                                      h2(" Nuevos títulos candidatos"),
                                                      box(style="overflow-x:scroll",width = 12,dataTableOutput("tit_cand_tif_new_comp")),
                                                      h2(" Nuevos precios"),
                                                      box(width = "12",column(width = 12,DT::dataTableOutput("precios_tif_nuevos_comp"),
                                                                                            style="overflow-y: scroll;overflow-x: scroll")),
                                                      
                                                      h2(" Nueva curva de rendimientos"),
                                                      rbokehOutput("c_tif_splines_new_comp")
                                                      
                                                      
                                                      
                                                      )#final tabpanel Splines 
                                      )#final tabbox
                                      )#final fluidrow
                                      ),#final tabpanel tif
                      
                      tabPanel("VEBONO",
                               tabsetPanel(type="pills",
                                           tabPanel("Títulos disponibles",
                                                    wellPanel(
                                                      #checkboxGroupInput( inputId = "t1_ns2", label = NULL,inline = TRUE,width = '100%',
                                                      #                    choices = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))[which(substr(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))[,2],1,3)=="VEB"),2]),
                                                      fluidRow(
                                                        column(width = 4,checkboxGroupInput(inputId = "v1_comp", label = "Corto Plazo",
                                                                                            choices=tit1[3:15])#final checkboxgroupimput
                                                        ),#final column
                                                        column(width = 4,checkboxGroupInput( inputId = "v2_comp", label = "Mediano Plazo",
                                                                                             choices=tit1[16:30])#final checkboxgroupimput
                                                        ),#final column
                                                        column(width = 4,checkboxGroupInput( inputId = "v3_comp",label = "Largo Plazo",
                                                                                             choices=tit1[31:40])#final checkboxgroupimput
                                                        )
                                                        #,#final column
                                                        #column(width = 3,checkboxGroupInput( inputId = "v4_comp", label = " ",
                                                        #                                     choices=tit1[32:40])#final checkboxgroupimput
                                                        #)#final column
                                                      )#final fluidrow
                                                      
                                                      
                                                      
                                                    )
                                           ),
                                           tabPanel("Elegir Instrumentos",
                                                    h2("Seleccione"),
                                                    fluidRow(
                                                      box(width = 12, title = h3(UPLOADDATA_TEXT),
                                                          box( width=12,background = "navy",
                                                               fileInput('data_tit_veb_comp', SELECTFILE_TEXT, accept = UPLOADFILETYPE_CONF,
                                                                         placeholder = FILESELEC_TEXT, buttonLabel = BUTTSELEC_TEXT )
                                                          ),
                                                          fluidRow(
                                                            box(width=4,background="olive",strong(ENCABEZADO_TEXT),
                                                                checkboxInput( width="100%", 'header_tit_veb_comp', WITHHEADER_TEXT, TRUE)),
                                                            box(width=4,background="olive",
                                                                radioButtons( width="40%", 'sep_tit_veb_comp', SEPARATOR_TEXT, UPLOADFILESEP_CONF, ';')),
                                                            box(width=4,background="olive",
                                                                radioButtons( width="40%", 'quote_tit_veb_comp', COMILLAS_TEXT, UPLOADCOMILLAS_CONF, ''))
                                                          )
                                                      )
                                                    ),
                                                    fluidRow(
                                                      box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('datatable_tit_veb_comp'))
                                                    )
                                           )#final tabpanel selecionar titulos
                               ),
                      #          fluidRow(
                      #   column(width = 3,checkboxGroupInput(inputId = "v1_comp", label = " ",
                      #                                       choices=tit1[1:8])#final checkboxgroupimput
                      #   ),#final column
                      #   column(width = 3,checkboxGroupInput( inputId = "v2_comp", label = " ",
                      #                                        choices=tit1[9:16])#final checkboxgroupimput
                      #   ),#final column
                      #   column(width = 3,checkboxGroupInput( inputId = "v3_comp",label = " ",
                      #                                        choices=tit1[17:24])#final checkboxgroupimput
                      #   ),#final column
                      #   column(width = 3,checkboxGroupInput( inputId = "v4_comp", label = " ",
                      #                                        choices=tit1[25:29])#final checkboxgroupimput
                      #   )#final column
                      # ),#final fluidrow
                      verbatimTextOutput("q2_comp"),
                      h2(" Características"),box(style="overflow-x:scroll",width = 12,dataTableOutput("Ca1_comp")),
                      h2(" Metodologías"),
                      wellPanel(
                        #tabBox(width = 12, title = " ", id = "tab5", height = "50px", 
                        tabsetPanel(type="tabs", 
                            tabPanel("Nelson y siegel",
                                      h2(" Precios Promedios"),verbatimTextOutput("pre_comp_veb_ns"),
                                     h5("Advertencia"),verbatimTextOutput("ad_pnsc_veb"),
                                     textInput('vec2_nsc', 'Ingrese un precio o vector de precios (separados por coma)'),
                                     #verbatimTextOutput("salida"),
                                     h5("Nuevos precios"),
                                     verbatimTextOutput("np_nsc2"),
                                     h5("Nuevos precios promedio"), verbatimTextOutput("sal2_nsc"),
                                        #tabBox( width = 12, title = "Parámetros", id = "tab1_ns_veb_comp", height = "50px", 
                                     tabsetPanel(type="pills",   
                                            
                                                tabPanel(" Elegir parámetros ",
                                                         h4(" Por favor, insertar parámetros"),
                                                         box(width=12,title="Importante",status="primary",solidHeader=TRUE ,collapsible = TRUE,
                                                             collapse= TRUE,"Al ingresar los parámetros considere las siguientes restricciones, ",br(),withMathJax(helpText("$$1) \\quad \\beta_{0} > 0$$")),
                                                             withMathJax(helpText("$$2) \\quad \\beta_{0}+\\beta_{1} > 0$$")),withMathJax(helpText("$$3) \\quad \\tau > 0$$"))),#final box
                                                         column(width = 3,numericInput( inputId = "ns_b0_veb_comp", label="B0: ", min = 0, max = 50,step = 0.1, value = "0.52", width = "40%")
                                                                , verbatimTextOutput("num_ns_b0_veb_comp")),#final column,
                                                         column(width = 3,numericInput( inputId = "ns_b1_veb_comp", label="B1: ", min = -10, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                verbatimTextOutput("num_ns_b1_veb_comp")),#final column
                                                         column(width = 3,numericInput( inputId = "ns_b2_veb_comp", label="B2: ", min = -10, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                verbatimTextOutput("num_ns_b2_veb_comp")),#final column
                                                         column(width = 3,numericInput( inputId = "ns_t_veb_comp", label="T: ", min = 0, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                verbatimTextOutput("num_ns_t_veb_comp")),#final column
                                                         #boton q controla la reactividad
                                                         actionButton("boton7", "Calcular", icon = icon("chart-area"),
                                                                      style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                         
                                                         
                                                         h4(" Los nuevos parámetros considerados son, "),
                                                         verbatimTextOutput("new_ns_veb_comp"),
                                                         h4(" Verificación, "),
                                                         verbatimTextOutput("ver_ns_veb_comp"),
                                                         h2(" Precios estimados"),
                                                         box(width = "12",column(width = 12,DT::dataTableOutput("p_est_veb_ns_el_comp"),
                                                                                               style="overflow-y: scroll;overflow-x: scroll")),
                                                         
                                                         h4(" Curva de Rendimiento"),
                                                         plotlyOutput("c_veb_ns1_new_comp")
                                                         
                                                         
                                                         
                                                ),# final tabpanel pa elegir 
                                                tabPanel(" Parámetros optimizados",
                                                         
                                                         radioButtons( inputId = "opt_veb_ns_comp",label = "Desea optimizar los precios obtenidos:", 
                                                                       choices = c("Si"=1, "No"=0),
                                                                       selected=0), #finalradiobuttons
                                                         #boton q controla la reactividad
                                                         actionButton("boton_6", "Calcular", icon = icon("chart-area"),
                                                                      style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                         
                                                         h2(" Precios estimados optimizados"),
                                                         box(width = "12",column(width = 12,DT::dataTableOutput("p_est_veb_opt_ns_comp"),
                                                                                               style="overflow-y: scroll;overflow-x: scroll")),
                                                         
                                                         h2(" Parámetros optimizados"),
                                                         verbatimTextOutput("par_veb_ns_op_comp"),
                                                         h2(" Curva de rendimientos VEBONO"),
                                                         plotlyOutput("c_veb_ns_op_comp")
                                                         
                                                )#final tabpabel pa optimizados
                                                
                                        )#final tabbox

                                      
                             ),#final tabpanel veb
                             tabPanel("Svensson",
                                      h2(" Precios Promedios"),verbatimTextOutput("pre_comp_veb_sven"),
                                      h5("Advertencia"),verbatimTextOutput("ad_psvc_veb"),
                                      textInput('vec2_svc', 'Ingrese un precio o vector de precios (separados por coma)'),
                                      #verbatimTextOutput("salida"),
                                      h5("Nuevos precios"),
                                      verbatimTextOutput("np_svc2"),
                                      h5("Nuevos precios promedio"), verbatimTextOutput("sal2_svc"),
                                      
                                      
                                        #tabBox( width = 12, title = "Parámetros", id = "tab1_sven_veb_comp", height = "50px", 
                                      tabsetPanel(type="pills",   
                                             
                                                tabPanel(" Elegir parámetros ",
                                                         h4(" Por favor, insertar parámetros"),
                                                         box(width=12,title="Importante",status="primary",solidHeader=TRUE ,collapsible = TRUE,
                                                             collapse= TRUE,"Al ingresar los parámetros considere las siguientes restricciones, ",br(),withMathJax(helpText("$$1) \\quad \\beta_{0} > 0$$")),
                                                             withMathJax(helpText("$$2) \\quad \\beta_{0}+\\beta_{1} > 0$$")),withMathJax(helpText("$$3) \\quad \\tau_{1} > 0$$")),
                                                             withMathJax(helpText("$$3) \\quad \\tau_{2} > 0$$"))),#final box
                                                         column(width = 2,numericInput( inputId = "sven_b0_veb_comp", label="B0: ", min = 0, max = 50,step = 0.1, value = "0.52", width = "40%")
                                                                , verbatimTextOutput("num_sven_b0_veb_comp")),#final column,
                                                         column(width = 2,numericInput( inputId = "sven_b1_veb_comp", label="B1: ", min = -10, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                verbatimTextOutput("num_sven_b1_veb_comp")),#final column
                                                         column(width = 2,numericInput( inputId = "sven_b2_veb_comp", label="B2: ", min = -10, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                verbatimTextOutput("num_sven_b2_veb_comp")),#final column
                                                         column(width = 2,numericInput( inputId = "sven_b3_veb_comp", label="B3: ", min = -10, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                verbatimTextOutput("num_sven_b3_veb_comp")),#final column
                                                         column(width = 2,numericInput( inputId = "sven_t1_veb_comp", label="T1: ", min = 0, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                verbatimTextOutput("num_sven_t1_veb_comp")),#final column
                                                         column(width = 2,numericInput( inputId = "sven_t2_veb_comp", label="T2: ", min = 0, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                                verbatimTextOutput("num_sven_t2_veb_comp")),#final column
                                                         #boton q controla la reactividad
                                                         actionButton("boton8", "Calcular", icon = icon("chart-area"),
                                                                      style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                         
                                                         
                                                         h4(" Los nuevos parámetros considerados son, "),
                                                         verbatimTextOutput("new_sven_veb_comp"),
                                                         h4(" Verificación, "),
                                                         verbatimTextOutput("ver_sven_veb_comp"),
                                                         h2(" Precios estimados"),
                                                         box(width = "12",column(width = 12,DT::dataTableOutput("p_est_veb_opt_sven_el_comp"),
                                                                                               style="overflow-y: scroll;overflow-x: scroll")),
                                                         
                                                         h4(" Curva de Rendimiento"),
                                                         plotlyOutput("c_veb_sven_new_comp")
                                                         
                                                         
                                                         
                                                ),# final tabpanel pa iniciales 
                                                tabPanel(" Parámetros optimizados",
                                                         
                                                         radioButtons(inputId = "opt_veb_sven_comp",label = "Desea optimizar los precios obtenidos:", 
                                                                      choices = c("Si"=1, "No"=0),
                                                                      selected=0
                                                         ),#final radiobuttoms
                                                         #boton q controla la reactividad
                                                         actionButton("boton_8", "Calcular", icon = icon("chart-area"),
                                                                      style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                         
                                                         
                                                         h2(" Precios estimados optimizados"),
                                                         box(width = "12",column(width = 12,DT::dataTableOutput("p_est_veb_opt_comp"),
                                                                                               style="overflow-y: scroll;overflow-x: scroll")),
                                                         
                                                         h2(" Parámetros optimizados"),
                                                         verbatimTextOutput("par_veb_sven_op_comp"),
                                                         h2(" Curva de rendimientos VEBONOS"),
                                                         plotlyOutput("c_veb_sven_op_comp")
                                                         
                                                )#final tabpabel pa optimizados
                                                
                                        )#final tabbox
                             ),#final tabpanel Svensson 
                             tabPanel("Diebold Li",
                                      h2(" Cantidad de observaciones"),
                                      numericInput( inputId = "d_veb_dl_comp", label="Días: ", min = 1, max = 100,step = 1, value = 40, width = "40%"),
                                      verbatimTextOutput("dias_veb_dl_comp"),
                                      h2(" Spline a usar"),
                                      verbatimTextOutput("spline_veb_comp_out"),
                                      h2(" Parámetro de suavizamiento"),
                                      numericInput( inputId = "parametro_veb_dl_comp", label="Parámetro: ", min = -10, max = 100,step = 0.1, value = 1, width = "40%"),
                                      verbatimTextOutput("spar_veb_dl_comp"),
                                      #boton q controla la reactividad
                                      actionButton("boton16", "Calcular", icon = icon("chart-area"),
                                                   style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                      
                                      
                                      h2(" Curva spline Tif"),
                                      rbokehOutput("c_veb_splines_dl_comp"),
                                      h2(" Precios estimados"),
                                      box(width = "12",column(width = 12,DT::dataTableOutput("p_est_dl_veb_comp"),
                                                                            style="overflow-y: scroll;overflow-x: scroll")),
                                      
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
                                      #boton q controla la reactividad
                                      actionButton("boton19", "Calcular", icon = icon("chart-area"),
                                                   style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                      
                                      
                                      h2(" Precios Splines"),
                                      box(width = "12",column(width = 12,DT::dataTableOutput("pre_sp_veb_comp"),
                                                                            style="overflow-y: scroll;overflow-x: scroll")),
                                      
                                      h2(" Curva de rendimientos VEBONOS"),
                                      rbokehOutput("c_veb_splines_comp"),#verbatimTextOutput("datos")
                                      h2(" Eliminar observaciones"),
                                      htmlOutput("selectUI_veb_comp"),
                                      h3(" Títulos elegidos"),
                                      verbatimTextOutput("obs_elim_veb_comp"),
                                      #boton q controla la reactividad
                                      actionButton("boton20", "Calcular", icon = icon("chart-area"),
                                                   style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                      
                                      
                                      h2(" Nuevos títulos candidatos"),
                                      box(style="overflow-x:scroll",width = 12,dataTableOutput("tit_cand_veb_new_comp")),
                                      h2(" Nuevos precios"),
                                      box(width = "12",column(width = 12,DT::dataTableOutput("precios_veb_nuevos_comp"),
                                                                            style="overflow-y: scroll;overflow-x: scroll")),
                                      
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
                      
                      wellPanel(
                        h2(" VaR Portafolio"),
                              # fluidRow(
                                 
                                 #tabBox( width = 12, title = "Distribuciones", id = "eleccion_dist", height = "50px", 
                                 tabsetPanel(type="tabs",   
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
                                                         # box( width=12, style="overflow-x:scroll",status = "success",
                                                         #      tableOutput("dist_elegir"),
                                                              fluidRow(
                                                                box(width = 12, title = h3(UPLOADDATA_TEXT),
                                                                    box( width=12,background = "navy",
                                                                         fileInput('file_data_dist', SELECTFILE_TEXT, accept = UPLOADFILETYPE_CONF,
                                                                                   placeholder = FILESELEC_TEXT, buttonLabel = BUTTSELEC_TEXT )
                                                                    ),
                                                                    fluidRow(
                                                                      box(width=4,background="olive",strong(ENCABEZADO_TEXT),
                                                                          checkboxInput( width="100%", 'header_dist', WITHHEADER_TEXT, TRUE)),
                                                                      box(width=4,background="olive",
                                                                          radioButtons( width="40%", 'sep_dist', SEPARATOR_TEXT, UPLOADFILESEP_CONF_1, ';')),
                                                                      box(width=4,background="olive",
                                                                          radioButtons( width="40%", 'quote_dist', COMILLAS_TEXT, UPLOADCOMILLAS_CONF, ''))
                                                                    )
                                                                )
                                                              ), 
                                                         fluidRow(
                                                                box( width=12, style="overflow-x:scroll",status = "success",
                                                                           tableOutput("dist_elegir"))
                                                              #fluidRow(
                                                              #   box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('data_dist'))
                                                              # )
                                                              
                                                              
                                                              
                                                         )
                                                         
                                                )
                                                #,
                                                
                                                #tabPanel("Elección automática",
                                                #         h2(" Las distribuciones asignadas son:")
                                                #)
                                                
                               )#final tabsetpannel
                              # )#final fluidrow
                               
                               
                      )#final wellpanel    
                               

                     # )#final tabpanel
              #)#final tabbox
                      #)#final fluid row        
                      
              ),
              #CALCULO VAR PARA UN HORIZONTE TEMPORAL DADO
              tabItem(tabName = "var",
                      wellPanel(
                        #tabBox( width = 12, title = "VaR", id = "vares", height = "50px", 
                               tabsetPanel(type="tabs", 
                                       tabPanel("Paramétrico",
                                                fluidRow(
                                                tags$h2(style="padding-left:15px;","VaR normal"),
                                                tags$h3(style="padding-left:15px;","Rendimientos:"),
                                                box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('rend_varn')),
                                                tags$h3(style="padding-left:15px;","Advertencias:"),
                                                box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('advertencia_varn')),
                                                tags$h3(style="padding-left:15px;","Parámetros seleccionados:"),
                                                box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('parametros_varn')),
                                                tags$h3(style="padding-left:15px;","Elegir porcentaje del VaR:"),
                                                box( width = 12, background = "navy",
                                                        selectInput( inputId = "porVarn", "Seleccione Porcentaje del VaR", choices = c(.90, .95, .99), selected = .95)
                                                       ),
                                                box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('porcentaje_varn')),
                                                tags$h3(style="padding-left:15px;","Vares individuales:"),
                                                box(height ="595",width = "12",status = "success",column(width = 12,DT::dataTableOutput("tabla_varn"),
                                                                                      style="height:500px;overflow-y: scroll;overflow-x: scroll")),
                                                
                                                #box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('tabla_varn')),
                                                tags$h3(style="padding-left:15px;","VaR portafolio:"),
                                                box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('varn_portafolio'))
                                                #h3(" Graficos:"),
                                                #plotlyOutput("grafico_vnominal")
                                                #box(width=12,background = "blue")
                                                #h3("----------------------------------------------------------------------------------------")

                                
                                                )#final fluidRow      
                                       ),
                                       tabPanel("Histórico",
                                                fluidRow(
                                                tags$h2(style="padding-left:15px;","VaR simulación histórica"),
                                                tags$h3(style="padding-left:15px;"," Advertencia"),
                                                box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('advertencia_varsh')),
                                                tags$h2(style="padding-left:15px;"," Pesos"),
                                                plotlyOutput("grafico_pesos"),
                                                tags$h2(style="padding-left:15px;"," Valor Nominal Portafolio"),
                                                verbatimTextOutput("suma_posvarsh"),
                                                tags$h2(style="padding-left:15px;"," Suma de Pesos"),
                                                verbatimTextOutput("suma_pesos"),
                                                tags$h2(style="padding-left:15px;"," Escenarios"),
                                                box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('escenarios_varsh')),
                                                tags$h3(style="padding-left:15px;","Elegir porcentaje del VaR:"),
                                                box( width = 12, background = "navy",
                                                     selectInput( inputId = "porVarsh", "Seleccione Porcentaje del VaR", choices = c(.90, .95, .99), selected = .95)
                                                ),
                                                box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('porcentaje_varsh')),
                                                tags$h3(style="padding-left:15px;","Ubicación:"),
                                                box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('ubicacion_varsh')),
                                                tags$h3(style="padding-left:15px;","VaR Individuales:"),
                                                box(height ="595",width = "12",status = "success",column(width = 12,DT::dataTableOutput("varind_sh"),
                                                                                                         style="height:500px;overflow-y: scroll;overflow-x: scroll")),
                                                
                                                #box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('varind_sh')),
                                                tags$h3(style="padding-left:15px;","VaR Portafolio:"),
                                                box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('varsh'))
                                                #h3("----------------------------------------------------------------------------------------")
                                                )#final FluidRow
                                                
                                                
                                       ),
                                       tabPanel("Simulación Monte Carlo",
                                                wellPanel(
                                                  #tabBox( width = 12, title = "Monte Carlo", id = "var_mc", height = "50px", 
                                                        tabsetPanel(type="pills",         
                                                                 tabPanel("Distribución Normal",
                                                                      fluidRow(  
                                                                       tags$h2(style="padding-left:15px;","  VaR asumiendo distribución Normal"),
                                                                       tags$h3(style="padding-left:15px;"," Rendimientos:"),
                                                                       box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('rend_varmc_n')),
                                                                       tags$h3(style="padding-left:15px;"," Advertencias:"),
                                                                       box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('advertencia_varmc_n')),
                                                                       tags$h3(style="padding-left:15px;"," Parámetros seleccionados:"),
                                                                       box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('parametros_varmc_n')),
                                                                       tags$h3(style="padding-left:15px;"," Elegir porcentaje del VaR:"),
                                                                       box( width = 12, background = "navy",
                                                                            selectInput( inputId = "porVarmc_n", "Seleccione Porcentaje del VaR", choices = c(.90, .95, .99), selected = .95)
                                                                       ),
                                                                       box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('porcentaje_varmc_n')),
                                                                       tags$h3(style="padding-left:15px;"," Elegir cantidad de simulaciones:"),
                                                                       box( width = 12, background = "navy",
                                                                       numericInput( inputId = "sim_varmc_n", label="Simulaciones a realizar: ", min = 0, max = 100000,step = 1, value = 100, width = "40%")),
                                                                       box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('simulaciones_varmc_n')),
                                                                       #boton q controla la reactividad
                                                                       actionButton("boton21", "Calcular", icon = icon("chart-area"),
                                                                                    style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                                       
                                                                       
                                                                       tags$h3(style="padding-left:15px;"," Vares individuales:"),
                                                                      box(height ="595",width = "12",status = "success",column(width = 12,DT::dataTableOutput("tabla_varmc_n"),
                                                                                                                               style="height:500px;overflow-y: scroll;overflow-x: scroll")),
                                                                      
                                                                       #box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('tabla_varmc_n')),
                                                                      tags$h3(style="padding-left:15px;"," VaR portafolio:"),
                                                                       box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('varmc_portafolio_n1'))
                                                                      #h3("-----------------------------------------------------------------------------------")
                                                                      
                                                                       #box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('varmc_portafolio_n1'))
                                                                 )#final fluid row
                                                                 ),#final tabpanel
                                                                 tabPanel("Elegir Distribución",
                                                                           fluidRow(
                                                                           tags$h2(style="padding-left:15px;"," VaR mejor distribución seleccionada"),
                                                                           tags$h3(style="padding-left:15px;"," Rendimientos:"),
                                                                           box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('rend_varmc_el')),
                                                                           tags$h3(style="padding-left:15px;"," Advertencias:"),
                                                                           box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('advertencia_varmc_el')),
                                                                           tags$h3(style="padding-left:15px;"," Mejores distribuciones elegidas:"),
                                                                           box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('dist_varmc_el')),
                                                                           tags$h3(style="padding-left:15px;"," Elegir porcentaje del VaR:"),
                                                                           box( width = 12, background = "navy",
                                                                               selectInput( inputId = "porVarmc_el", "Seleccione Porcentaje del VaR", choices = c(.90, .95, .99), selected = .95)
                                                                           ),
                                                                           box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('porcentaje_varmc_el')),
                                                                           tags$h3(style="padding-left:15px;"," Elegir cantidad de simulaciones"),
                                                                           box( width = 12, background = "navy",
                                                                               numericInput( inputId = "sim_varmc_el", label="Simulaciones a realizar: ", min = 0, max = 100000,step = 1, value = 100, width = "40%")),
                                                                           box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('simulaciones_varmc_el')),
                                                                           #boton q controla la reactividad
                                                                           actionButton("boton22", "Calcular", icon = icon("chart-area"),
                                                                                        style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                                           
                                                                           
                                                                           tags$h3(style="padding-left:15px;"," Vares individuales:"),
                                                                          box(height ="595",width = "12",status = "success",column(width = 12,DT::dataTableOutput("tabla_varmc_el"),
                                                                                                                                   style="height:500px;overflow-y: scroll;overflow-x: scroll")),
                                                                          
                                                                           #box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('tabla_varmc_el')),
                                                                          tags$h3(style="padding-left:15px;"," VaR portafolio:"),
                                                                           box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('varmc_portafolio_el1'))
                                                                          #h3(" VaR portafolio 1:"),
                                                                          #box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('varmc_portafolio_el1'))
                                                                          #h3("-----------------------------------------------------------------------------------")
                                                                           )#final fluidRow

                                                                          
                                                                 )#,#final tabpanel
                                                                # tabPanel("Elección Automática",
                                                                #          h2(" Las mejores distribuciones ajustadas son:")    
                                                                          
                                                                # )#final tabpanel
                                               
                                                                
                                                                  )#final tabbox
                                                )#final fluidrow
                                                
                                                
                                                
                                                
                                                
                                       )
                                         
                      )#final tabbox
                               
                      )#final wellPanel
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
                                                #tabBox( width = 12, title = "", id = "graficos_vares_ind", height = "50px", 
                                                  wellPanel(
                                                tabsetPanel(type="pills",      
                                                        tabPanel("VaR Paramétrico",
                                                                 #tabBox( width = 12, title = "Delta-Normal", id = "graficos_varn", height = "50px", 
                                                               # wellPanel(
                                                                  tabsetPanel(type="tabs",   
                                                                         tabPanel("VaR individuales",
                                                                                  plotlyOutput("grafico_vind")
                                                                         ),
                                                                         tabPanel("Comparativo",
                                                                                  plotlyOutput("grafico_vcomp")
                                                                         )
                                                                 )#final tabbox
                                                        #)#final well Panel   
                                                        ),
                                                        tabPanel("VaR Simulación Histórica",
                                                                 #tabBox( width = 12, title = "Simulación Histórica", id = "graficos_varsh", height = "50px", 
                                                                 tabsetPanel(type="tabs",    
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
                                                                 #tabBox( width = 12, title = "Monte Carlo", id = "graficos_varmc", height = "50px",
                                                                 tabsetPanel(type="tabs",
                                                                 tabPanel("Distribución Normal",
                                                                          #tabBox( width = 12, title = "", id = "graficos_varmc", height = "50px",
                                                                          tabsetPanel(type="pills",
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
                                                                          #tabBox( width = 12, title = "", id = "graficos_varmc_1", height = "50px",
                                                                          tabsetPanel(type="pills",   
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
                                       )#final well panel
                                       ),
                                       tabPanel("Comparativo VaRes",
                                                plotlyOutput("grafico_var_comp")
                                               
                                                
                                       )
                                       
                                       
                      )#final tabbox
                        
                        
                        
                       
                      )#final fluidrow
                      
                      
                      
                      ),#final tab item graficos
              #HISTORICOS
              tabItem(tabName = "historicos",
                    
                      #fluidRow(
                      wellPanel(  
                        #tabBox( width = 12, title = " ", id = "historico_vares", height = "50px", 
                        tabsetPanel(type="tabs",           
                                       tabPanel("VaR Paramétrico",
                                                #wellPanel(
                                                h2("Rango de fechas disponibles:"),
                                                verbatimTextOutput("fechas_disponibles_par"),
                                                
                                                h2("Favor seleccionar fechas:"),
                                                
                                                dateRangeInput('dateRange_par',
                                                               label = 'Rango de fechas:',
                                                               start = Sys.Date() - 2, end = Sys.Date() + 2
                                                ),
                                                h4("El histórico se calculara para las fechas comprendidas entre:"),
                                                
                                                verbatimTextOutput("dateRangeText_par"),
                                                #boton q controla la reactividad
                                                actionButton("boton23", "Calcular", icon = icon("chart-area"),
                                                             style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                
                                                #verbatimTextOutput("hola"),
                                                h2("Histórico"),
                                                box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('historico_par')),
                                                h2("Descargar"),
                                                downloadButton("data_var_par", "Descargar")
                                                #)#final wellpanel
                                                
                                     
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
                                                #boton q controla la reactividad
                                                actionButton("boton24", "Calcular", icon = icon("chart-area"),
                                                             style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                
                                                
                                                
                                                h2("Histórico"),
                                                box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('historico_hist')),
                                                h2("Descargar"),
                                                downloadButton("data_var_hist", "Descargar")
                                                
                                                
                                                
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
                                                #boton q controla la reactividad
                                                actionButton("boton25", "Calcular", icon = icon("chart-area"),
                                                             style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                
                                                
                                                h2("Histórico"),
                                                box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('historico_smc1')),
                                                h2("Descargar"),
                                                downloadButton("data_var_smc1", "Descargar")
                                                
                                                
                                                
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
                                                #boton q controla la reactividad
                                                actionButton("boton26", "Calcular", icon = icon("chart-area"),
                                                             style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                
                                                
                                                h2("Histórico"),
                                                box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('historico_smc2')),
                                                h2("Descargar"),
                                                downloadButton("data_var_smc2", "Descargar")
                                                
                                                    
                                                    
                                       )
                                       
                                      
                      )#final tabbox
                      
                      
                      )#final wellpanel   
                      
                      #)#final fluidrow
                      
                      
                      
              ),#final tab item Historico
              
              #BACKTESTING
              tabItem(tabName = "datos_back",
                      h2(" Seleccionar archivo"),
                      fluidRow(
                        box(width = 12, title = h3(UPLOADDATA_TEXT),
                            box( width=12,background = "navy",
                                 fileInput('file_data_back', SELECTFILE_TEXT, accept = UPLOADFILETYPE_CONF,
                                           placeholder = FILESELEC_TEXT, buttonLabel = BUTTSELEC_TEXT )
                            ),
                            fluidRow(
                              box(width=4,background="olive",strong(ENCABEZADO_TEXT),
                                  checkboxInput( width="100%", 'header_back', WITHHEADER_TEXT, TRUE)),
                              box(width=4,background="olive",
                                  radioButtons( width="40%", 'sep_back', SEPARATOR_TEXT, UPLOADFILESEP_CONF_1, ';')),
                              box(width=4,background="olive",
                                  radioButtons( width="40%", 'quote_back', COMILLAS_TEXT, UPLOADCOMILLAS_CONF, ''))
                            )
                        )
                      ),
                      fluidRow(
                        box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('datatable_back'))
                      )

                      
              ),#final tabitem Backtesting
              tabItem(tabName = "resultados_back",
                      h3(" Elegir porcentaje del Backtesting:"),
                      box(width = 12, background = "navy",
                           selectInput( inputId = "porback", "Seleccione Porcentaje del VaR", choices = c(.90, .95, .99), selected = .95)
                      ),
                      verbatimTextOutput("back_porcentaje"),
                      h2("Resultados"),
                      fluidRow(
                        box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('result_back'))
                      ),
                      h2(" Valores críticos"),
                      plotlyOutput("grafico_back"),
                      h2("Reporte"),
                      downloadButton("report_back", "Descargar")
                      
                      
              ),#final tabitem Backtesting
              
            #VALORACION
            tabItem(tabName = "datos_val",
                    h2(" Seleccionar archivo"),
                    fluidRow(
                      box(width = 12, title = h3(UPLOADDATA_TEXT),
                          box( width=12,background = "navy",
                               fileInput('file_data_val', SELECTFILE_TEXT, accept = UPLOADFILETYPE_CONF,
                                         placeholder = FILESELEC_TEXT, buttonLabel = BUTTSELEC_TEXT )
                          ),
                          fluidRow(
                            box(width=4,background="olive",strong(ENCABEZADO_TEXT),
                                checkboxInput( width="100%", 'header_val', WITHHEADER_TEXT, TRUE)),
                            box(width=4,background="olive",
                                radioButtons( width="40%", 'sep_val', SEPARATOR_TEXT, UPLOADFILESEP_CONF_1, ';')),
                            box(width=4,background="olive",
                                radioButtons( width="40%", 'quote_val', COMILLAS_TEXT, UPLOADCOMILLAS_CONF, ''))
                          )
                      )
                    ),
                    fluidRow(
                      box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('datatable_val'))
                    )
                    
                    
                    
            ),#final tabitem Valoracion
            tabItem(tabName = "resultados_val",
                    h2("Resultados"),
                    fluidRow(
                      box(height ="595",width = "12",status = "success",column(width = 12,DT::dataTableOutput("result_val"),
                                                                               style="height:500px;overflow-y: scroll;overflow-x: scroll"))
                      
                      #box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('result_val'))
                    ),
                    h2("Utilidad o pérdida"),
                    plotlyOutput("grafico_val1"),
                    
                    h2("Resúmen portafolio"),
                    fluidRow(
                      box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('result_val_port'))
                    ),
                    h2("Reporte"),
                    downloadButton("report_val1", "Descargar")
                    
                    
            ),#final tabitem Valoracion
            tabItem(tabName = "resultados_val_estres",
                    h2("Precios históricos"),
                    fluidRow(
                      box(width = 12, title = h3(UPLOADDATA_TEXT),
                          box( width=12,background = "navy",
                               fileInput('file_data_val_estres', SELECTFILE_TEXT, accept = UPLOADFILETYPE_CONF,
                                         placeholder = FILESELEC_TEXT, buttonLabel = BUTTSELEC_TEXT )
                          ),
                          fluidRow(
                            box(width=4,background="olive",strong(ENCABEZADO_TEXT),
                                checkboxInput( width="100%", 'header_val_estres', WITHHEADER_TEXT, TRUE)),
                            box(width=4,background="olive",
                                radioButtons( width="40%", 'sep_val_estres', SEPARATOR_TEXT, UPLOADFILESEP_CONF_1, ';')),
                            box(width=4,background="olive",
                                radioButtons( width="40%", 'quote_val_estres', COMILLAS_TEXT, UPLOADCOMILLAS_CONF, ''))
                          )
                      )
                    ),
                    fluidRow(
                      box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('datatable_val_estres'))
                    ),
                    h2("Advertencia"),
                    box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('datatable_val_estres_ad')),
                    
                    h2("Resultados prueba de estrés"),
                    fluidRow(
                      box(height ="595",width = "12",status = "success",column(width = 12,DT::dataTableOutput("result_val_estres"),
                                                                               style="height:500px;overflow-y: scroll;overflow-x: scroll"))
                      
                      #box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('result_val_estres'))
                    ),
                    h2("Utilidad o pérdida"),
                    plotlyOutput("grafico_val2"),
                    h2("Resúmen portafolio"),
                    fluidRow(
                      box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput('result_val_estres_port'))
                    ),
                    h2("Reporte"),
                    downloadButton("report_val2", "Descargar")
            ),#final tabitem Valoracion   
              
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

