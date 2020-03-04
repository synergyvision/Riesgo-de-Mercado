shinyServer(function(input, output,session) {

  source(paste(getwd(),"Modulos","Curva_rend_ind.R",sep = "/"),local = TRUE)
 
  #observe_helpers(withMathJax = TRUE)
  
  # start introjs when button is pressed with custom options and events
  # observeEvent(input$help,
  #              introjs(session, options = list("nextLabel"="Siguiente",
  #                                              "prevLabel"="Regresar",
  #                                              "skipLabel"="Salir"
  #                                              ),
  #                      events = list("oncomplete"=I('alert("Listo!")')))
  # )
  
  #
  # observeEvent(input$help1,
  #              introjs(session, options = list("nextLabel"="Siguiente",
  #                                              "prevLabel"="Regresar",
  #                                              "skipLabel"="Salir"),
  #                      events = list("oncomplete"=I('alert("Listo!")')))
  # )
  
  #DEFINO PASOS PARA INTRO SIN INTROBOX
  # steps_1 <- reactive(data.frame(
  #   element=c("#menu1","#menu2","#menu3","#menu4","#menu5","#menu6"),
  #   intro=c("Sección Curva de Rendimientos","Sección Comparativo","Sección Valor en Riesgo",
  #           "Sección Backtesting","Sección Valoración","Sección de información"),
  #   position=c("bottom","bottom","bottom","bottom","bottom","bottom")
  # ))
  
  observeEvent(input$help2,
               introjs(session, options = list("nextLabel"="Siguiente",
                                               "prevLabel"="Regresar",
                                               "skipLabel"="Salir",
                                               "doneLabel"="Aceptar",steps=boton()
                                               ),
                       events = list(onbeforechange = readCallback("switchTabs"))
                       ))
  
  #PASOS DE PRUEBA
  # steps_2 <- reactive(data.frame(
  #   element=c("#menu1","#m1","#tab1","#Ca_leida","#tab6"),
  #   intro=c("Sección Curva de Rendimientos","Sección Datos","Datos","Documento Características","Comparativo"),
  #   position=c("bottom","bottom","bottom","bottom","bottom")
  # ))
  
  #PASOS CR-DATOS
  # steps_datos_curvas <- reactive(data.frame(
  #   element=c("#menu1","#m1","#Ca_leida","#docbcv","#pre_prom_tif","#pre_prom_veb","#tab6"),
  #   intro=c("Sección Curvas de Rendimiento","Sección Datos",
  #           "Documento Características","Documento 0-22","Precios promedios TIF",
  #           "Precios promedios VEBONO","Comp"),
  #   position=c("bottom","bottom","bottom","bottom","bottom","bottom","bottom")
  # ))
  steps_datos_curvas <- reactive(data.frame(
    element=c("#menu1","#Ca_leida","#docbcv","#pre_prom_tif","#pre_prom_veb"),
    intro=c("Sección Curvas de Rendimiento",
            "Documento Características","Documento 0-22","Precios promedios TIF",
            "Precios promedios VEBONO"),
    position=c("bottom","bottom","bottom","bottom","bottom")
  ))
  
  
  #PASOS CR-NELSON Y SIEGEL
  steps_cr_ns <- reactive(data.frame(
    
    element=c("#menu1","#m2","#date1_ns","#date2_ns","#tit1_ns","#tit2_ns","#q1_ns1","#pre1_ns","#ad_pns_tif",
              "#vec1_ns","#np_ns1","#sal1_ns","#Ca_ns","#pa_tif_ns","#p_est_tif_ns","#c_tif_ns","#el1_ns",
              "#new_ns_tif","#ver_ns_tif","#p_est_tif_ns_el","#c_tif_ns1_new","#opt_tif_ns","#p_est_tif_opt_ns",
              "#par_tif_ns_op","#c_tif_ns_op"),
    
    intro=c("Sección Curvas de Rendimiento","Sección Nelson y Siegel","Fecha a seleccionar",
            "Fecha seleccionada","Títulos TIF a seleccionar","Opción para ingresar archivo con títulos TIF",
            "Títulos seleccionados","Precios Promedio","Advertencias","Ingresar precio promedio",
            "Nuevos precios ingresados","Nuevos precios promedio","Documento Características","Parámetros iniciales TIF",
            "Precios estimados iniciales TIF","Curva de Rendimientos inicial TIF","Opción para ingresar parámetros de la Curva de Rendimientos",
            "Nuevos parámetros ingresados","Verificación","Precios estimados usando parámetros ingresados",
            "Curva de Rendimientos con nuevos parámetros","Opción de selección para optimizar o no los párametros","Precios optimizados obtenidos",
            "Parámetros optimizados","Curva de Rendimientos con parámetros optimizados"),
    
    position=c("bottom","bottom","bottom","bottom","bottom","bottom","bottom","bottom","bottom","bottom",
               "bottom","bottom","bottom","bottom","bottom","bottom","bottom","bottom","bottom","bottom",
               "bottom","bottom","bottom","bottom","bottom")
  ))
  
  #PASOS CR-SVENSSON  
  steps_cr_sv <- reactive(data.frame(
    
    element=c("#menu1","#m3","#date1_sv","#date2_sv","#tit1_sv","#tit2_sv","#q_sv1","#pre1","#ad_psv_tif",
              "#vec1_sv","#np_sv1","#sal1_sv","#Ca","#pa_tif","#p_est_tif","#c_tif_sven","#el1_sv",
              "#new_sven_tif","#ver_sven_tif","#p_est_tif_opt_sven_el","#c_tif_sven_new","#opt_tif_sven","#p_est_tif_opt",
              "#par_tif_sven_op","#c_tif_sven_op"),
    
    intro=c("Sección Curvas de Rendimiento","Sección Svensson","Fecha a seleccionar",
            "Fecha seleccionada","Títulos TIF a seleccionar","Opción para ingresar archivo con títulos TIF",
            "Títulos seleccionados","Precios Promedio","Advertencias","Ingresar precio promedio",
            "Nuevos precios ingresados","Nuevos precios promedio","Documento Características","Parámetros iniciales TIF",
            "Precios estimados iniciales TIF","Curva de Rendimientos inicial TIF","Opción para ingresar parámetros de la Curva de Rendimientos",
            "Nuevos parámetros ingresados","Verificación","Precios estimados usando parámetros ingresados",
            "Curva de Rendimientos con nuevos parámetros","Opción de selección para optimizar o no los párametros","Precios optimizados obtenidos",
            "Parámetros optimizados","Curva de Rendimientos con parámetros optimizados"),
    
    position=c("bottom","bottom","bottom","bottom","bottom","bottom","bottom","bottom","bottom","bottom",
               "bottom","bottom","bottom","bottom","bottom","bottom","bottom","bottom","bottom","bottom",
               "bottom","bottom","bottom","bottom","bottom")
  ))
  
  #PASOS CR-DIEBOLD-LI  
  steps_cr_dl <- reactive(data.frame(
    
    element=c("#menu1","#m4","#date1_dl","#date2_dl","#tit1_dl","#tit2_dl","#q1_dl","#pre1_dl",
              "#Ca_dl","#d_tif_dl","#spline_tif","#parametro_tif_dl","#c_tif_splines_dl",
              "#p_est_dl_tif","#curva_tif_dl"),
    
    intro=c("Sección Curvas de Rendimiento","Sección Diebold-Li","Fecha a seleccionar",
            "Fecha seleccionada","Títulos TIF a seleccionar","Opción para ingresar archivo con títulos TIF",
            "Títulos seleccionados","Precios Promedio",
            "Documento Características","Cantidad de observaciones(días) a considerar en el histórico",
            "Spline a usar","Parámetro de suavizamiento de la curva Spline","Curva Spline obtenida",
            "Precios estimados usando la metodología de Diebold-Li","Curva de Rendimientos obtenida mediante la metodología Diebold-Li"),
    
    position=c("bottom","bottom","bottom","bottom","bottom","bottom","bottom","bottom",
               "bottom","bottom","bottom","bottom","bottom","bottom","bottom")
  ))
  
  #PASOS CR-SPLINES  
  steps_cr_sp <- reactive(data.frame(
    
    element=c("#menu1","#m5","#date1_sp","#date2_sp","#tit1_sp","#tit2_sp","#q1_sp","#pre1_sp",
              "#Ca_sp","#d_tif","#tit_cand_tif","#parametro_tif","#pre_sp_tif",
              "#c_tif_splines","#selectUI_tif","#tit_cand_tif_new","#precios_tif_nuevos","#c_tif_splines_new"),
    
    intro=c("Sección Curvas de Rendimiento","Sección Splines","Fecha a seleccionar",
            "Fecha seleccionada","Títulos TIF a seleccionar","Opción para ingresar archivo con títulos TIF",
            "Títulos seleccionados","Precios Promedio",
            "Documento Características","Cantidad de observaciones(días) a considerar en el histórico",
            "Títulos candidatos a usar para graficar curva Spline","Parámetro de suavizamiento de la curva Spline","Precios obtenidos mediante la metodología Splines",
            "Curva de Rendimientos obtenida mediante la metodología Splines","Opción para eliminar observaciones correspondientes a los títulos candidatos",
            "Nuevos títulos candidatos considerados","Precios nuevos obtenidos mediante la metodología Splines ","Nueva curva de Rendimientos obtenida mediante la metodología Splines"),
    
    position=c("bottom","bottom","bottom","bottom","bottom","bottom","bottom","bottom",
               "bottom","bottom","bottom","bottom","bottom","bottom","bottom","bottom","bottom","bottom")
  ))
  
  #PASOS COMP-METODOLOGIAS
  steps_comp_met <- reactive(data.frame(
    
    element=c("#menu2","#m6","#date1_compa","#date2_compa","#tit1_compa","#tit2_compa","#q1_comp",
              "#Ca_comp","#seccion_ns","#seccion_sv","#seccion_dl","#seccion_sp"),
    
    intro=c("Sección Comparativo de Curvas de Rendimiento","Sección Metodologías","Fecha a seleccionar",
            "Fecha seleccionada","Títulos TIF a seleccionar","Opción para ingresar archivo con títulos TIF",
            "Títulos seleccionados",
            "Documento Características","Sección Nelson y Siegel",
            "Sección Svensson","Sección Diebold-Li","Sección Splines"),
    
    position=c("bottom","bottom","bottom","bottom","bottom","bottom","bottom","bottom",
               "bottom","bottom","bottom","bottom")
  ))
  
  #PASOS COMP-PRECIOS
  steps_comp_pre <- reactive(data.frame(
    
    element=c("#menu2","#m7","#comp_pre_tif","#comp_pre_veb"),
    
    intro=c("Sección Comparativo de Curvas de Rendimiento","Sección Precios","Precios comparativo TIF",
            "Precios Comparativos VEBONO"),
    
    position=c("bottom","bottom","bottom","bottom")
  ))
  
  #PASOS COMP-CURVAS
  steps_comp_curvas <- reactive(data.frame(
    
    element=c("#menu2","#m8","#curva_comp_tif","#curva_comp_veb","#report"),
    
    intro=c("Sección Comparativo de Curvas de Rendimiento","Sección Curvas","Comparativo Curvas de Rendimiento TIF",
            "Comparativo Curvas de Rendimiento VEBONO","Reporte sobre comparativo de instrumentos"),
    
    position=c("bottom","bottom","bottom","bottom","bottom")
  ))
  
  #PASOS VAR-DATOS
  steps_var_datos <- reactive(data.frame(
    
    element=c("#menu3","#m9","#var1_dat","#var2_dat","#datatable","#var3_dat","#var4_dat","#datatable_pos",
              "#aviso_datos_var","#var5_dat"),
    
    intro=c("Sección Valor en Riesgo","Sección Datos","Opción para cargar archivo de precios",
            "Opción para seleccionar separadores","Archivo de precios","Opción para cargar archivo de posiciones",
            "Opción para seleccionar separadores","Archivo de posiciones","Aviso de coincidencia de instrumentos","Fechas disponibles para el cálculo del VaR"),
    
    position=c("bottom","bottom","bottom","bottom","bottom",
               "bottom","bottom","bottom","bottom","bottom")
  ))
  
  #PASOS VAR-DISTRIBUCION
  steps_var_dist <- reactive(data.frame(
    
    element=c("#menu3","#m10","#advertencia_dist_varp_el","#instrumento_varp","#result_varp","#var3_distr","#parametros_dist_varp","#seleccion_varp",
              "#seleccion_dist","#var1_distr","#var2_distr","#dist_elegir"),
    
    intro=c("Sección Valor en Riesgo","Sección Elegir Distribución","Advertencias sobre algún problema con los datos",
            "Opción para seleccionar instrumento","Resultados preliminares ajuste distribución","Opción para elegir alguna distribución",
            "Parámetros obtenidos según distribución considerada","Opción que permite guardar la distribución elegida para cada instrumento","Opción que habilita la carga de un archivo con las distribuciones de cada instrumento",
            "Opción para cargar archivo de distribuciones","Opción para seleccionar los separadoes","Vista del archivo de distribuciónes"),
    
    position=c("bottom","bottom","bottom","bottom","bottom",
               "bottom","bottom","bottom","bottom","bottom","bottom","bottom")
  ))
  
  #PASOS VAR-VAR
  steps_var_v <- reactive(data.frame(
    
    element=c("#menu3","#m11","#rend_varn","#advertencia_varn","#parametros_varn","#var_v1","#tabla_varn","#varn_portafolio",
              "#advertencia_varsh","#grafico_pesos","#suma_posvarsh","#suma_pesos","#escenarios_varsh","#var_v2","#ubicacion_varsh",
              "#varind_sh","#varsh","#rend_varmc_n","#advertencia_varmc_n","#parametros_varmc_n","#var_v3","#var_v4","#tabla_varmc_n","#varmc_portafolio_n1",
              "#rend_varmc_el","#advertencia_varmc_el","#dist_varmc_el","#var_v5","#var_v6","#tabla_varmc_el","#varmc_portafolio_el1"),
    
    intro=c("Sección Valor en Riesgo","Sección VaR","Rendimientos de los precios de cada instrumento",
            "Advertencia sobre posibles problemas con los rendimientos","Parámetros seleccionados","Opción para elegir el porcentaje del VaR",
            "Vares individuales calculados","VaR de portafolio","Advertencia sobre posibles problemas con los rendimientos",
            "Pesos según valor nominal de los instrumentos","Valor nominal del portafolio","Suma de pesos","Escenarios","Opción para elegir el porcentaje del VaR",
            "Ubicación o punto de corte del VaR","Vares individuales calculados","VaR de portafolio","Rendimientos de los precios de cada instrumento",
            "Advertencia sobre posibles problemas con los rendimientos","Parámetros seleccionados","Opción para elegir el porcentaje del VaR",
            "Opción para seleccionar la cantidad de simulaciones a realizar","Vares individuales calculados","VaR de portafolio",
            "Rendimientos de los precios de cada instrumento","Advertencia sobre posibles problemas con los rendimientos",
            "Mejores distribuciones seleccionadas","Opción para elegir el porcentaje del VaR",
            "Opción para seleccionar la cantidad de simulaciones a realizar","Vares individuales calculados","VaR de portafolio"),
    
    position=c("bottom","bottom","bottom","bottom","bottom",
               "bottom","bottom","bottom","bottom","bottom","bottom","bottom",
               "bottom","bottom","bottom","bottom","bottom",
               "bottom","bottom","bottom","bottom","bottom","bottom","bottom",
               "bottom","bottom","bottom","bottom","bottom","bottom","bottom")
  ))
  
  #PASOS VAR-GRAFICOS
  steps_var_graf <- reactive(data.frame(
    
    element=c("#menu3","#m12","#grafico_vnominal","#reporte_var","#grafico_vind","#grafico_vcomp","#grafico_hist_sh","#grafico_vind_sh",
              "#grafico_comp_sh","#grafico_hist_smcn","#grafico_vind_mcn","#grafico_comp_mcn","#grafico_hist_smc_el","#grafico_vind_mc_el","#grafico_comp_mc_el",
              "#grafico_var_comp"),
    
    intro=c("Sección Valor en Riesgo","Sección Gráficos de VaRes","Gráfico del Valor Nominal de cada instrumento",
            "Botón para descargar reporte sobre el VaR","Gráfico VaRes individuales con la metodología paramétrica","Gráfico VaR Portafolio vs suma de VaRes individuales con la metodología paramétrica",
            "Gráfico de Escenarios obtenidos mediante la simulación histórica","Gráfico VaRes individuales con la metodología de simulación histórica","Gráfico VaR Portafolio vs suma de VaRes individuales con la metodología de simulación histórica",
            "Gráfico de Escenarios obtenidos mediante la simulación de MonteCarlo Normal","Gráfico VaRes individuales con la metodología de simulación de MonteCarlo normal","Gráfico VaR Portafolio vs suma de VaRes individuales con la metodología de simulación de MonteCarlo normal",
            "Gráfico de Escenarios obtenidos mediante la simulación de MonteCarlo considerando mejor distribución","Gráfico VaRes individuales con la metodología de simulación de MonteCarlo considerando mejor distribución","Gráfico VaR Portafolio vs suma de VaRes individuales con la metodología de simulación de MonteCarlo considerando mejor distribución",
            "Gráfico comparativo de VaRes"),
    
    position=c("bottom","bottom","bottom","bottom","bottom",
               "bottom","bottom","bottom","bottom","bottom","bottom","bottom",
               "bottom","bottom","bottom","bottom")
  ))
  
  #PASOS VAR-HISTORICOS
  steps_var_hist <- reactive(data.frame(
    
    element=c("#menu3","#m13","#fechas_disponibles_par","#dateRange_par","#historico_par","#data_var_par","#fechas_disponibles_hist","#dateRange_hist",
              "#historico_hist","#data_var_hist","#fechas_disponibles_smc1","#dateRange_smc1","#historico_smc1","#data_var_smc1","#fechas_disponibles_smc2",
              "#dateRange_smc2","#historico_smc2","#data_var_smc2"),
    
    intro=c("Sección Valor en Riesgo","Sección Histórico de VaRes","Rango de fechas disponibles para calcular el VaR",
            "Opción para elegir fechas","Histórico de VaRes con la metodología paramétrica","Opción para descargar data con la metodología paramétrica","Rango de fechas disponibles para calcular el VaR",
            "Opción para elegir fechas","Histórico de VaRes con la metodología de simulación histórica","Opción para descargar data con la metodología de simulación histórica",
            "Rango de fechas disponibles para calcular el VaR",
            "Opción para elegir fechas","Histórico de VaRes con la metodología de MonteCarlo normal","Opción para descargar data con la metodología de MonteCarlo normal","Rango de fechas disponibles para calcular el VaR",
            "Opción para elegir fechas","Histórico de VaRes con la metodología de MonteCarlo considerando mejor distribución","Opción para descargar data con la metodología de MonteCarlo considerando mejor distribución"
            ),
    
    position=c("bottom","bottom","bottom","bottom","bottom",
               "bottom","bottom","bottom","bottom","bottom","bottom","bottom",
               "bottom","bottom","bottom","bottom","bottom","bottom")
  ))
  
  #PASOS BACKTESTING-DATOS
  steps_var_back_d <- reactive(data.frame(
    
    element=c("#menu4","#m14","#backv1","#backv2"),
    
    intro=c("Sección Backtesting","Sección Datos","Opción para cargar archivo","Vista preliminar de archivo"),
    
    position=c("bottom","bottom","bottom","bottom")
  ))
  
  #PASOS BACKTESTING-DATOS
  steps_var_back_r <- reactive(data.frame(
    
    element=c("#menu4","#m15","#back_por","#result_back","#grafico_back","#report_back"),
    
    intro=c("Sección Backtesting","Sección Resultados","Opción para elegir nivel de confianza","Resultados obtenidos","Valores críticos obtenidos",
            "Botón para descargar reporte"),
    
    position=c("bottom","bottom","bottom","bottom","bottom","bottom")
  ))
  
  #PASOS VALORACION-DATOS
  steps_val_d <- reactive(data.frame(
    
    element=c("#menu5","#m16","#valo1","#datatable_val"),
    
    intro=c("Sección Valoración","Sección Datos","Opción para seleccionar archivo",
            "Vista preliminar del archivo"),
    
    position=c("bottom","bottom","bottom","bottom")
  ))
  
  #PASOS VALORACION-RESULTADOS
  steps_val_r <- reactive(data.frame(
    
    element=c("#menu5","#m17","#result_val","#grafico_val1","#result_val_port","#report_val1"),
    
    intro=c("Sección Valoración","Sección Resultados de la Valoración","Resultados de la valoración","Gráfico de Utilidad o Pérdida",
            "Resumen de la valoración del portafolio","Botón para descargar reporte de Valoración"),
    
    position=c("bottom","bottom","bottom","bottom","bottom","bottom")
  ))
  
  #PASOS VALORACION-RESULTADOS-ESTRES
  steps_val_est <- reactive(data.frame(
    
    element=c("#menu5","#m18","#val_est1","#val_est2","#datatable_val_estres_ad",
              "#result_val_estres","#grafico_val2","#result_val_estres_port","#report_val2"),
    
    intro=c("Sección Valoración","Sección Resultados Valoración estresada","Opción para cargar archivo de precios","Diferentes opciones de separadores",
            "Advertencia sobre posible error con el archivo","Resultados de la valoración estresada",
            "Gráfico de Utilidad o Pérdida","Resumen de valoración estresada del portafolio","Botón para descargar reporte de Valoración estresada"),
    
    position=c("bottom","bottom","bottom","bottom","bottom","bottom",
               "bottom","bottom","bottom")
  ))
  
  #PASOS ACERCA
  steps_acerca <- reactive(data.frame(
    
    element=c("#menu6","#acer1"),
    
    intro=c("Sección Acerca","Información acerca de la aplicación"),
    
    position=c("bottom","bottom")
  ))
  
  #CONDICIONALES CON TABITEMS
  boton <- reactive({
    if(input$tabs=="datos_curvas"){
      return(steps_datos_curvas())
    }else if(input$tabs=="subitem1"){
      return(steps_cr_ns())
    }else if(input$tabs=="subitem2"){
      return(steps_cr_sv())
    }else if(input$tabs=="subitem3"){
      return(steps_cr_dl())
    }else if(input$tabs=="subitem4"){
      return(steps_cr_sp())
    }else if(input$tabs=="metodologias"){
      return(steps_comp_met())
    }else if(input$tabs=="precios"){
      return(steps_comp_pre())
    }else if(input$tabs=="curvas"){
      return(steps_comp_curvas())
    }else if(input$tabs=="datos_var"){
      return(steps_var_datos())
    }else if(input$tabs=="distribucion_var"){
      return(steps_var_dist())
    }else if(input$tabs=="var"){
      return(steps_var_v())
    }else if(input$tabs=="graficos"){
      return(steps_var_graf())
    }else if(input$tabs=="historicos"){
      return(steps_var_hist())
    }else if(input$tabs=="datos_back"){
      return(steps_var_back_d())
    }else if(input$tabs=="resultados_back"){
      return(steps_var_back_r())
    }else if(input$tabs=="datos_val"){
      return(steps_val_d())
    }else if(input$tabs=="resultados_val"){
      return(steps_val_r())
    }else if(input$tabs=="resultados_val_estres"){
      return(steps_val_est())
    }else if(input$tabs=="acerca"){
      return(steps_acerca())
    }else{}
    
    
  })
  
  #CREDENCIALES
  # login status and info will be managed by shinyauthr module and stores here
  credentials <- callModule(shinyauthr::login, "login",
                            data = user_base,
                            user_col = user,
                            pwd_col = password,
                            sodium_hashed = TRUE,
                            log_out = reactive(logout_init()))
  
  # logout status managed by shinyauthr module and stored here
  logout_init <- callModule(shinyauthr::logout, "logout", reactive(credentials()$user_auth))
  
  # this opens or closes the sidebar on login/logout
  observe({
    if(credentials()$user_auth) {
      shinyjs::removeClass(selector = "body", class = "sidebar-collapse")
    } else {
      shinyjs::addClass(selector = "body", class = "sidebar-collapse")
    }
  })
  
  
  observe({
    if(credentials()$user_auth) {
      V8::JS(js$hidehead(''))
    } else {
      V8::JS(js$hidehead('none'))
    }
  })
  # only when credentials()$user_auth is TRUE, render your desired sidebar menu
  output$sidebar <- renderMenu({
    req(credentials()$user_auth)
    sidebarMenu(
      id = "tabs",
                #fluidPage(
                  # Application title

      menuItem(tags$span(id="menu1","Curva de Rendimiento"), icon = icon("chart-area"),
               #introBox(
                  menuSubItem(tags$span(id="m1","Datos"), tabName = "datos_curvas", icon = icon("folder-open")),
              #    data.step = 1,
               #   data.intro = "Esta es la sección de Datos",
                #  data.position = c("right")
               #), #final introbox
                #  introBox(
                  menuSubItem(tags$span(id="m2","Nelson y Siegel"), tabName = "subitem1", icon = icon("circle-o")),
                 # data.step = 2,
                  #data.intro = "Esta es la sección de Nelson y Siegel",
                  #data.position = c("right")
                #), #final introbox
                 # introBox(
                  menuSubItem(tags$span(id="m3","Svensson"), tabName = "subitem2", icon = icon("circle-o")),
                  #data.step = 3,
                  #data.intro = "Esta es la sección de Svensson",
                  #data.position = c("right")
                  #), #final introbox
                #introBox(
                  menuSubItem(tags$span(id="m4","Diebold-Li"), tabName = "subitem3", icon = icon("circle-o")),
                 # data.step = 4,
                #  data.intro = "Esta es la sección de Diebold-Li, El Fútbol Club Barcelona, conocido
                 # popularmente como Barça,  es una entidad polideportiva de Barcelona, España. 
                  #Fue fundado como club de fútbol el 29 de noviembre de 1899.",
                  #data.position = c("right")
               #), #final introbox
               #introBox(
                  menuSubItem(tags$span(id="m5","Splines"), tabName = "subitem4", icon = icon("circle-o"))
                #  data.step = 5,
                #  data.intro = "Esta es la sección de Splines",
                #  data.position = c("right")
               #), #final introbox
               #introBox(
                # actionButton("help", "Ayuda",width = '80px',icon = icon("folder-open")),
                # data.step = 6,
                # data.intro = "Boton de instrucciones"
               #) #final introbox
               
               
               )
      
      ,#fin menuitem


                  #menuItem("Comparativo", icon = icon("circle-o"), tabName = "comparativo"),
      #introBox(
      menuItem(tags$span(id="menu2","Comparativo"), icon = icon("th-list"),

                  #menuSubItem("Datos", tabName = "datos", icon = icon("circle-o")),
               #introBox(
                  menuSubItem(tags$span(id="m6","Metodologías"), tabName = "metodologias", icon = icon("clipboard-list")),
               #data.step = 1,
               #data.intro = "Esta es la sección de Metodologías",
               #data.position = c("right")
              #), #final introbox
                  menuSubItem(tags$span(id="m7","Precios estimados"), tabName = "precios", icon = icon("coins")),
              #introBox(
                  menuSubItem(tags$span(id="m8","Curvas"), tabName = "curvas", icon = icon("chart-line"))
              #data.step = 7,
              #data.intro = "Esta es la sección de Splines",
              #data.position = c("right")
      #), #final introbox
       #        introBox(
        #         actionButton("help1", "Ayuda",width = '80px',icon = icon("folder-open"))
                 #data.step = 2,
                 #data.intro = "Boton de instrucciones"
         #      ) #final introbox

                ),#fin menuitem
      #data.step = 2,
      #data.intro = "Esta es la sección de curvas de Comparativos"
      #), #final introbox

      menuItem(tags$span(id="menu3","Valor en Riesgo"), icon = icon("coins"),

               menuSubItem(tags$span(id="m9","Datos"), tabName = "datos_var", icon = icon("folder-open")),

               menuSubItem(tags$span(id="m10","Distribución"), tabName = "distribucion_var", icon = icon("project-diagram")),

               menuSubItem(tags$span(id="m11","VaR"), tabName = "var", icon = icon("file-invoice-dollar")),

               menuSubItem(tags$span(id="m12","Gráficos"), tabName = "graficos", icon = icon("chart-pie")),

               menuSubItem(tags$span(id="m13","Históricos"), tabName = "historicos", icon = icon("calendar-alt"))

      ),#fin menuitem
                menuItem(tags$span(id="menu4","Backtesting"), icon = icon("angle-double-left"),
                         menuSubItem(tags$span(id="m14","Datos"), tabName = "datos_back", icon = icon("folder-open")),
                         menuSubItem(tags$span(id="m15","Resultados"), tabName = "resultados_back", icon = icon("file-alt"))
                ),
       menuItem(tags$span(id="menu5","Valoración"), icon = icon("bar-chart-o"),
               menuSubItem(tags$span(id="m16","Datos"), tabName = "datos_val", icon = icon("folder-open")),
               menuSubItem(tags$span(id="m17","Resultados"), tabName = "resultados_val", icon = icon("file-alt")),
               menuSubItem(tags$span(id="m18","Resultados Prueba de Estrés"), tabName = "resultados_val_estres", icon = icon("file-contract"))
        ),

                  menuItem(tags$span(id="menu6","Acerca"), icon = icon("exclamation-circle"), tabName = "acerca"),

                #)#final fluidpage
      #introBox(
          actionButton("help2", "Instrucciones") 
       #   data.step = 9,
        #  data.intro = "Boton de instrucciones"
        #) #final introbox
      
      )#final sidebarmenu
  })

  output$dropmenu <- renderMenu({
    req(credentials()$user_auth)
    dropdownMenu(type = "messages",
                 messageItem(
                   from = "Señal",
                   message = "Volatilidad Anormal",
                   icon = icon("life-ring"),
                   time = "2018-05-12"
                 )
    )

  })
  
  
  
  #BIENVENIDA
  user_info <- reactive({credentials()$info})
  
  output$bienvenida <- renderText({
    req(credentials()$user_auth)
    
    glue("Bienvenid@ {user_info()$name}")
  })
  
  #MODULO ACERCA
  #LO COLOCO PARA EVITAR QUE SE MUESTRE AL SALIR DE LA SESION
  output$acerca1 <- renderUI({
    req(credentials()$user_auth)
    box(id="acer1" ,width = 9, status="warning",
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
  })
  
  #TAB 1 - datos_curvas
  output$tab1 <- renderUI({
    req(credentials()$user_auth)
    wellPanel(
    h2(" Descarga de archivos"),
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
                             DT::dataTableOutput("Ca_leida"))
                         )
                ,
                tabPanel("Operaciones BCV 022",
                         h5("Documento 0-22"),
                         box(style="overflow-x:scroll",width = 12,
                             DT::dataTableOutput("docbcv"))
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
    )

    
  })
  
  #TAB 2 - subitem1 - Nelson y Siegel
  output$tab2 <- renderUI({
    req(credentials()$user_auth)
    wellPanel(
      h2("Nelson y Siegel"),
      fluidRow(column(width = 6,box(id="date1_ns", width = 12, background = "navy",
                                     dateInput(inputId="n2", label="Por favor, seleccionar una fecha", language= "es",
                                               width = "100%")#final dateimput 
      )#final box
      ),#final column
      box(id="date2_ns", width = 6,height = 2,title = "Fecha de valoración: ",verbatimTextOutput('p2')) #final box
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
                                                  wellPanel(id="tit1_ns",
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
                                                  fluidRow(id="tit2_ns",
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
                                                    box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('datatable_tit_tif'))
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
                             
                             h2(" Características"),box(style="overflow-x:scroll",width = 12,DT::dataTableOutput("Ca_ns")),
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
                                                     
                                                     fluidRow(id="el1_ns",
                                                     column(width = 3,numericInput( inputId = "ns_b0_tif", label="B0: ", min = 0, max = 50,step = 0.1, value = "0.52" , width = "40%")
                                                            , verbatimTextOutput("num_ns_b0_tif")),#final column,
                                                     column(width = 3,numericInput( inputId = "ns_b1_tif", label="B1: ", min = -10, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                            verbatimTextOutput("num_ns_b1_tif")),#final column
                                                     column(width = 3,numericInput( inputId = "ns_b2_tif", label="B2: ", min = -10, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                            verbatimTextOutput("num_ns_b2_tif")),#final column
                                                     column(width = 3,numericInput( inputId = "ns_t_tif", label="T: ", min = 0, max = 50,step = 0.1, value = "0.52", width = "40%"),
                                                            verbatimTextOutput("num_ns_t_tif"))#final column
                                                     
                                                     ),
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
                                                    box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('datatable_tit_veb'))
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
                             
                             
                             h2(" Características"),box(style="overflow-x:scroll",width = 12,DT::dataTableOutput("Ca1_ns")),
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
      
      
    )#finalfluidpage
    
  })
  
  #TAB 3 - subitem1 - Svensson
  output$tab3 <- renderUI({
    req(credentials()$user_auth)
    wellPanel(
      h2("  Svensson"),
      fluidRow(column(width = 6,box(id="date1_sv", width = 12, background = "navy",
                                     dateInput(inputId="n1", label="Por favor, seleccionar una fecha", language= "es",
                                               width = "100%")#final dateimput 
      )#final box
      ),#final column
      column(width = 6,box(id="date2_sv",width = 12,height = 2,title = "Fecha de valoración: ",verbatimTextOutput('p1')
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
                                                  wellPanel(id="tit1_sv",
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
                                                  fluidRow(id="tit2_sv",
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
                                                    box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('datatable_tit_tif_sv'))
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
                             
                             
                             h2(" Características"),box(style="overflow-x:scroll",width = 12,DT::dataTableOutput("Ca")),
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
                                                    
                                                    fluidRow(id="el1_sv",
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
                                                           verbatimTextOutput("num_sven_t2_tif"))#final column
                                                    
                                                    ),
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
                                                    box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('datatable_tit_veb_sv'))
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
                             
                             
                             h2(" Características"),box(style="overflow-x:scroll",width = 12,DT::dataTableOutput("Ca1")),
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
      
    )#finalfluidpage
    
  })
  
  #TAB 4 - subitem1 - Diebold Li
  output$tab4 <- renderUI({
    req(credentials()$user_auth)
    wellPanel(
      h2("Diebold-Li"),
      fluidRow(column( width = 6,box(id="date1_dl" ,width = 12, background = "navy",
                                      dateInput(inputId="n3", label="Por favor, seleccionar una fecha", language= "es",
                                                width = "100%")#final dateimput 
      )#final box
      ),#final column
      box(id="date2_dl" , width = 6,height = 2,title = "Fecha de valoración: ",verbatimTextOutput('p3')) #finalbox
      ),#final fluidrow
      h2("  Títulos"), h5("  Favor seleccionar los títulos a considerar: "),
      wellPanel(
        #tabBox(width = 12, title = "Títulos", id = "tab3", height = "50px", 
        tabsetPanel(type="tabs", 
                    tabPanel("TIF",
                             tabsetPanel(type="pills",
                                         tabPanel("Títulos disponibles",
                                                  wellPanel(id="tit1_dl" ,
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
                                                  fluidRow(id="tit2_dl" ,
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
                                                    box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('datatable_tit_tif_dl'))
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
                             
                             h2(" Características"),box(style="overflow-x:scroll",width = 12,DT::dataTableOutput("Ca_dl")),
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
                                                    box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('datatable_tit_veb_dl'))
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
                             
                             h2(" Características"),box(style="overflow-x:scroll",width = 12,DT::dataTableOutput("Ca1_dl")),
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
      
    )#final fluidpage
    
    })
    
  #TAB 5 - subitem1 -  Splines
  output$tab5 <- renderUI({
    req(credentials()$user_auth)
    wellPanel(
      h2("Splines"),
      fluidRow(column( width = 6,box(id="date1_sp", width = 12, background = "navy",
                                      dateInput(inputId="n4", label="Por favor, seleccionar una fecha", language= "es",
                                                width = "100%")#final dateimput 
      )#final box
      ),#final column
      box(id="date2_sp", width = 6,height = 2,title = "Fecha de valoración: ",verbatimTextOutput('p4'))),
      h2("  Títulos"), h5("  Favor seleccionar los títulos a considerar: "),
      wellPanel(
        #tabBox(width = 12, title = "Títulos", id = "tab3", height = "50px", 
        tabsetPanel(type="tabs", 
                    tabPanel("TIF",
                             tabsetPanel(type="pills",
                                         tabPanel("Títulos disponibles",
                                                  wellPanel(id="tit1_sp",
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
                                                  fluidRow(id="tit2_sp",
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
                                                    box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('datatable_tit_tif_sp'))
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
                             
                             h2(" Características"),box(style="overflow-x:scroll",width = 12,DT::dataTableOutput("Ca_sp")),
                             h3(" Por favor seleccionar el cantidad de días "),
                             box(width=12,title="Importante",status="primary",solidHeader=TRUE ,collapsible = TRUE,
                                 collapse= TRUE,"Recuerde que esta es la cantidad de días a considerar hacia atras en el tiempo
                                        con el fin de generar la data con la que se trabajará, por ejemplo si se elige 30 la data 
                                        a considerar serán las observaciones comprendidas entre la fecha de valoración y 
                                        la fecha resultante luego de restarle 30 días a la fecha de valoración" 
                             ),#final box
                             numericInput( inputId = "d_tif", label="Días: ", min = 1, max = 100,step = 1, value = 40, width = "40%"),
                             verbatimTextOutput("dias_tif"),
                             h2(" Títulos candidatos"),box(style="overflow-x:scroll",width = 12,DT::dataTableOutput("tit_cand_tif")),
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
                             box(style="overflow-x:scroll",width = 12,DT::dataTableOutput("tit_cand_tif_new")),
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
                                                    box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('datatable_tit_veb_sp'))
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
                             
                             h2(" Características"),box(style="overflow-x:scroll",width = 12,DT::dataTableOutput("Ca1_sp")),
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
                             box(style="overflow-x:scroll",width = 12,DT::dataTableOutput("tit_cand_veb")),
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
                             box(style="overflow-x:scroll",width = 12,DT::dataTableOutput("tit_cand_veb_new")),
                             h2(" Nuevos precios"),
                             box(width = "12",column(width = 12,DT::dataTableOutput("precios_veb_nuevos"),
                                                     style="overflow-y: scroll;overflow-x: scroll")),
                             
                             h2(" Nueva curva de rendimientos"),
                             rbokehOutput("c_veb_splines_new")
                    )#final tabpanel veb
        )#final tabbox
      )#final fluidrow
      
      
    )#final fluidpage
    
  })
    
  
  #TAB 6 - Comparativo - Metodologias
  output$tab6 <- renderUI({
    req(credentials()$user_auth)
    wellPanel(
      h2(" Comparativo"),
      fluidRow(column(width = 6,box(id="date1_compa",width = 12, background = "navy",
                                     dateInput(inputId="n5", label="Por favor, seleccionar una fecha", language= "es",
                                               width = "100%")#final dateimput 
      )#final box
      ),#final column
      box(id="date2_compa", width = 6,height = 2,title = "Fecha de valoración: ",verbatimTextOutput('p5')) #final box
      ),#final fluidrow
      h2("  Títulos"), h5("  Favor seleccionar los títulos a considerar: "),
      wellPanel(
        #tabBox(width = 12, title = "Títulos", id = "tab5", height = "50px",
        tabsetPanel(type="tabs",      
                    tabPanel("TIF",
                             tabsetPanel(type="pills",
                                         tabPanel("Títulos disponibles",
                                                  wellPanel(id="tit1_compa",
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
                                                  fluidRow(id="tit2_compa",
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
                                                    box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('datatable_tit_tif_comp'))
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
                             h2(" Características"),box(style="overflow-x:scroll",width = 12,DT::dataTableOutput("Ca_comp")),
                             h2(" Metodologías"),
                             wellPanel(
                               #tabBox(width = 12, title = " ", id = "tab5", height = "50px", 
                               tabsetPanel(type="tabs", 
                                           tabPanel("Nelson y siegel",
                                                    fluidPage(id="seccion_ns",
                                                    
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
                                                    
                                                    )#final fluidpage
                                           ),#final tabpanel Nelson y siegel
                                           
                                           tabPanel("Svensson",
                                                    fluidPage(id="seccion_sv",
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
                                                    
                                                    )#final fluidpage
                                                    
                                           ),#final tabpanel Svensson 
                                           tabPanel("Diebold Li",
                                                    
                                                    fluidPage(id="seccion_dl",
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
                                                    )#final fluidpage
                                                    
                                           ),#final tabpanel Diebold li 
                                           tabPanel("Splines",
                                                    fluidPage(id="seccion_sp",
                                                    h3(" Por favor seleccionar el cantidad de días "),
                                                    box(width=12,title="Importante",status="primary",solidHeader=TRUE ,collapsible = TRUE,
                                                        collapse= TRUE,"Recuerde que esta es la cantidad de días a considerar hacia atras en el tiempo
                                                          con el fin de generar la data con la que se trabajará, por ejemplo si se elige 30 la data 
                                                          a considerar serán las observaciones comprendidas entre la fecha de valoración y 
                                                          la fecha resultante luego de restarle 30 días a la fecha de valoración" 
                                                    ),#final box
                                                    numericInput( inputId = "d_tif_comp", label="Días: ", min = 1, max = 100,step = 1, value = 40, width = "40%"),
                                                    verbatimTextOutput("dias_tif_comp"),
                                                    h2(" Títulos candidatos"),box(style="overflow-x:scroll",width = 12,DT::dataTableOutput("tit_cand_tif_comp")),
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
                                                    box(style="overflow-x:scroll",width = 12,DT::dataTableOutput("tit_cand_tif_new_comp")),
                                                    h2(" Nuevos precios"),
                                                    box(width = "12",column(width = 12,DT::dataTableOutput("precios_tif_nuevos_comp"),
                                                                            style="overflow-y: scroll;overflow-x: scroll")),
                                                    
                                                    h2(" Nueva curva de rendimientos"),
                                                    rbokehOutput("c_tif_splines_new_comp")
                                                    
                                                    
                                           )#final fluidpage
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
                                                    box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('datatable_tit_veb_comp'))
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
                             h2(" Características"),box(style="overflow-x:scroll",width = 12,DT::dataTableOutput("Ca1_comp")),
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
                                                    h2(" Títulos candidatos"),box(style="overflow-x:scroll",width = 12,DT::dataTableOutput("tit_cand_veb_comp")),
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
                                                    box(style="overflow-x:scroll",width = 12,DT::dataTableOutput("tit_cand_veb_new_comp")),
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
      
    )#final fluidpage
  })
  
  
  #TAB 7 - Comparativo - Precios estimados
  output$tab7 <- renderUI({
    req(credentials()$user_auth)
    wellPanel(
      fluidPage(
      h2("Comparativo de precios"),
      #tabBox( width = 12, title = "Instrumentos", id = "precios_comp", height = "50px", 
      tabsetPanel(type="pills",       
              tabPanel("TIF",
                       box(id="comp_pre_tif",style="overflow-x:scroll",width = 12,DT::dataTableOutput("comparativo_precios_tif")),
                       h3("Selección de metodologías:"),
                       h3("Selección realizada:")
                       
              ),#final tabpanel
              tabPanel("VEBONO",
                       
                       box(id="comp_pre_veb",style="overflow-x:scroll",width = 12,DT::dataTableOutput("comparativo_precios_veb")),
                       h3("Selección de metodologías:"),
                       h3("Selección realizada:")
                       
              )#final tabpanel
      )#final tabbox
      )
      
    )#final fluidpage
  })
  
  #TAB 8 - Comparativo - Curvas
  output$tab8 <- renderUI({
    req(credentials()$user_auth)
    wellPanel(
      fluidPage(
      h2("Comparativo de curvas"),
      #tabBox( width = 12, title = "Instrumentos", id = "curvas_comp", height = "50px", 
      tabsetPanel(type="pills",       
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
      
      )
    )#final fluidpage
  })
  
  #TAB 9 - VAR - Datos
  output$tab9 <- renderUI({
    req(credentials()$user_auth)
    wellPanel(
      h2(" Seleccionar archivo"),
      h2(" Histórico de precios:"),
      fluidRow(
        box(width = 12, title = h3(UPLOADDATA_TEXT),
            box(id="var1_dat",width=12,background = "navy",
                 fileInput('file_data', SELECTFILE_TEXT, accept = UPLOADFILETYPE_CONF,
                           placeholder = FILESELEC_TEXT, buttonLabel = BUTTSELEC_TEXT )
            ),
            fluidRow(id="var2_dat",
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
        box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('datatable'))
      ),
      h2(" Posiciones:"),
      fluidRow(
        box(id="var3_dat",width = 12, title = h3(UPLOADDATA_TEXT),
            box( width=12,background = "navy",
                 fileInput('file_data_pos', SELECTFILE_TEXT, accept = UPLOADFILETYPE_CONF,
                           placeholder = FILESELEC_TEXT, buttonLabel = BUTTSELEC_TEXT )
            ),
            fluidRow(id="var4_dat",
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
        box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('datatable_pos'))
      ),
      h2(" Aviso"),
      fluidRow(
        box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('aviso_datos_var'))
      ),
      h2(" Fechas Disponibles"),
      fluidRow(id="var5_dat",
        box(width=6,htmlOutput("fechas_var"))
        ,
        #h2(" Fecha seleccionada"),
        box(width=6,verbatimTextOutput("fecha_elegida"),title = "Fecha Seleccionada")
      ),
       h1("Historico TIF 2019"),
       #,
       DT::dataTableOutput("ta")
      #,
      #h2(" Nueva Data"),
      #box(width=12,style="overflow-x:scroll",status = "success",dataTableOutput("datatable1"))
      
      
    )#final fluidpage
    
    })
  
  
  #FLEXTABLE
  output$ta <- DT::renderDataTable({

    DF_PRE <- read.csv(paste0(getwd(),"/data/DF_PRE_TIF_19.txt"), sep="")

    DF_ET <- read.csv(paste0(getwd(),"/data/DF_ET_TIF_19.txt"), sep="")
    
    #ACTUALIZO COLORES
    #PONGO COLOR
    a2 <- DT::datatable(DF_PRE,extensions = 'FixedColumns',
                        options = list(
                          scrollX = TRUE))
    
    indice_col_1 <- function(i,data){
      #FILAS DE LA COLi QUE TIENEN PRECIO NS
      z1 <- which(data[,i]==1)
      #FILAS DE LA COLi QUE TIENEN PRECIO SV
      z2 <- which(data[,i]==2)
      #FILAS DE LA COLi QUE TIENEN PRECIO SV
      z3 <- which(data[,i]==3)
      #FILAS DE LA COLi QUE TIENEN PRECIO SP
      z4 <- which(data[,i]==4)
      #FILAS DE LA COLi QUE TIENEN PRECIO VENCIDO
      z5 <- which(data[,i]==5)
      #FILAS DE LA COLi QUE TIENEN PRECIO VENCIDO
      z6 <- which(data[,i]==6)
      if(length(z6)!=0){
        return(DT::styleEqual(c(row.names(data)[z1],row.names(data)[z2],
                                row.names(data)[z3],row.names(data)[z4],
                                row.names(data)[z5],row.names(data)[z6])
                              , c(rep("blue",length(z1)),rep("green",length(z2)),
                                  rep("yellow",length(z3)),rep("orange",length(z4)),
                                  rep("brown",length(z5)),rep("red",length(z6))
                              ) ))
      }else{
        return(DT::styleEqual(c(row.names(data)[z1],row.names(data)[z2],
                                row.names(data)[z3],row.names(data)[z4],
                                row.names(data)[z5])
                              , c(rep("blue",length(z1)),rep("green",length(z2)),
                                  rep("yellow",length(z3)),rep("orange",length(z4)),
                                  rep("brown",length(z5))
                              ) ))
        
      }
    }
    
    
    
    for(i in 1:ncol(DF_PRE)){
      a2 <- DT::formatStyle(a2,
                            columns = i,
                            valueColumns = 0,
                            target = 'cell',
                            backgroundColor = indice_col_1(i,DF_ET)
      )
    }
    
    
    return(a2)
    
    
   
    
  })
  
  
  #TAB 10 - VAR - distribucion
  output$tab10 <- renderUI({
    req(credentials()$user_auth)
    fluidPage(
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
                             box(id="var3_distr", width=12,background = "navy",
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
                                   box(id="var1_distr", width=12,background = "navy",
                                        fileInput('file_data_dist', SELECTFILE_TEXT, accept = UPLOADFILETYPE_CONF,
                                                  placeholder = FILESELEC_TEXT, buttonLabel = BUTTSELEC_TEXT )
                                   ),
                                   fluidRow(id="var2_distr",
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
      
      
      
    )#final fluidpage
    
  })
    
  #TAB 11 - VAR - VaR
  output$tab11 <- renderUI({
    req(credentials()$user_auth)
    fluidPage(
      wellPanel(
        #tabBox( width = 12, title = "VaR", id = "vares", height = "50px", 
        tabsetPanel(type="tabs", 
                    tabPanel("Paramétrico",
                             fluidRow(
                               tags$h2(style="padding-left:15px;","VaR normal"),
                               tags$h3(style="padding-left:15px;","Rendimientos:"),
                               box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('rend_varn')),
                               tags$h3(style="padding-left:15px;","Advertencias:"),
                               box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('advertencia_varn')),
                               tags$h3(style="padding-left:15px;","Parámetros seleccionados:"),
                               box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('parametros_varn')),
                               tags$h3(style="padding-left:15px;","Elegir porcentaje del VaR:"),
                               box(id="var_v1", width = 12, background = "navy",
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
                               box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('escenarios_varsh')),
                               tags$h3(style="padding-left:15px;","Elegir porcentaje del VaR:"),
                               box(id="var_v2", width = 12, background = "navy",
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
                                                      box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('rend_varmc_n')),
                                                      tags$h3(style="padding-left:15px;"," Advertencias:"),
                                                      box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('advertencia_varmc_n')),
                                                      tags$h3(style="padding-left:15px;"," Parámetros seleccionados:"),
                                                      box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('parametros_varmc_n')),
                                                      tags$h3(style="padding-left:15px;"," Elegir porcentaje del VaR:"),
                                                      box(id="var_v3", width = 12, background = "navy",
                                                           selectInput( inputId = "porVarmc_n", "Seleccione Porcentaje del VaR", choices = c(.90, .95, .99), selected = .95)
                                                      ),
                                                      box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('porcentaje_varmc_n')),
                                                      tags$h3(style="padding-left:15px;"," Elegir cantidad de simulaciones:"),
                                                      box(id="var_v4", width = 12, background = "navy",
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
                                                      box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('rend_varmc_el')),
                                                      tags$h3(style="padding-left:15px;"," Advertencias:"),
                                                      box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('advertencia_varmc_el')),
                                                      tags$h3(style="padding-left:15px;"," Mejores distribuciones elegidas:"),
                                                      box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('dist_varmc_el')),
                                                      tags$h3(style="padding-left:15px;"," Elegir porcentaje del VaR:"),
                                                      box( id="var_v5",width = 12, background = "navy",
                                                           selectInput( inputId = "porVarmc_el", "Seleccione Porcentaje del VaR", choices = c(.90, .95, .99), selected = .95)
                                                      ),
                                                      box(width=12,style="overflow-x:scroll",status = "success",verbatimTextOutput('porcentaje_varmc_el')),
                                                      tags$h3(style="padding-left:15px;"," Elegir cantidad de simulaciones"),
                                                      box(id="var_v6", width = 12, background = "navy",
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
      
      
    )#final fluidpage
    
  })
  
  #TAB 12 - VAR - Graficos
  output$tab12 <- renderUI({
    req(credentials()$user_auth)
    fluidPage(
      
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
      
      
      
    )#final fluidpage
    
  })
  
  #TAB 13 - VAR - Historicos
  output$tab13 <- renderUI({
    req(credentials()$user_auth)
    fluidPage(
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
                             box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('historico_par')),
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
                             box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('historico_hist')),
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
                             box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('historico_smc1')),
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
                             box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('historico_smc2')),
                             h2("Descargar"),
                             downloadButton("data_var_smc2", "Descargar")
                             
                             
                             
                    )
                    
                    
        )#final tabbox
        
        
      )#final wellpanel   
      
      #)#final fluidrow
      
      
      
      
    )#final fluidpage
    
  })
    
  #TAB 14 - BACKTESTING - Datos
  output$tab14 <- renderUI({
    req(credentials()$user_auth)
    wellPanel(
      h2(" Seleccionar archivo"),
      fluidRow(id="backv1",
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
      fluidRow(id="backv2",
        box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('datatable_back'))
      )
      # h1("Prueba DT"),
      # #,
      # DT::dataTableOutput("ta")
      
    )#final fluidpage
  })
  
  #TAB 15 - BACKTESTING - Resultados
  output$tab15 <- renderUI({
    req(credentials()$user_auth)
    wellPanel(
      h3(" Elegir porcentaje del Backtesting:"),
      box(id="back_por",width = 12, background = "navy",
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
      
    )#final fluidpage
  })
  
  #TAB 16 - VALORACION - Datos
  output$tab16 <- renderUI({
    req(credentials()$user_auth)
    wellPanel(
      h2(" Seleccionar archivo"),
      fluidRow(id="valo1",
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
        box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('datatable_val'))
      )
      
      
      
    )#final fluidpage
  })
  
  #TAB 17 - VALORACION - Resultados
  output$tab17 <- renderUI({
    req(credentials()$user_auth)
    wellPanel(
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
        box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('result_val_port'))
      ),
      h2("Reporte"),
      downloadButton("report_val1", "Descargar")
      
      
    )#final fluidpage
  })
  
  #TAB 18 - VALORACION - Resultados prueba estres
  output$tab18 <- renderUI({
    req(credentials()$user_auth)
    wellPanel(
      h2("Precios históricos"),
      fluidRow(id="val_est1",
        box(width = 12, title = h3(UPLOADDATA_TEXT),
            box( width=12,background = "navy",
                 fileInput('file_data_val_estres', SELECTFILE_TEXT, accept = UPLOADFILETYPE_CONF,
                           placeholder = FILESELEC_TEXT, buttonLabel = BUTTSELEC_TEXT )
            ),
            fluidRow(id="val_est2",
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
        box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('datatable_val_estres'))
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
        box(width=12,style="overflow-x:scroll",status = "success",DT::dataTableOutput('result_val_estres_port'))
      ),
      h2("Reporte"),
      downloadButton("report_val2", "Descargar")
    )#final fluidpage
  })
  
  
  #fechas
  #Svensson
  #output$p1<-renderPrint({paste(substr(input$n1,9,10),substr(input$n1,6,7),substr(input$n1,1,4),sep = "/")})
  #Nelson y Siegel
  #output$p2<-renderPrint({paste(substr(input$n2,9,10),substr(input$n2,6,7),substr(input$n2,1,4),sep = "/")})
  #Diebold-Li
  output$p3<-renderPrint({paste(substr(input$n3,9,10),substr(input$n3,6,7),substr(input$n3,1,4),sep = "/")})
  #Splines
  output$p4<-renderPrint({paste(substr(input$n4,9,10),substr(input$n4,6,7),substr(input$n4,1,4),sep = "/")})
  #Comparativo
  output$p5<-renderPrint({paste(substr(input$n5,9,10),substr(input$n5,6,7),substr(input$n5,1,4),sep = "/")})
  
  #titulos
  #tif
  output$q1<-renderPrint({c(input$t1,input$t2,input$t3)})
  #output$q1_ns<-renderPrint({c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns)})
  #output$q1_ns<-renderPrint({input$fred})
  
  output$q1_dl <- renderPrint({dl1()})
  output$q1_sp <- renderPrint({c(input$t1_sp,input$t2_sp,input$t3_sp)})
  output$q1_comp <- renderPrint({c(input$t1_comp,input$t2_comp,input$t3_comp)})
  
  #vebonos

  #output$q2_ns<-renderPrint({c(input$v1_ns,input$v2_ns,input$v3_ns,input$v4_ns)})
  output$q2_dl<-renderPrint({dl2()})
  output$q2_sp<-renderPrint({c(input$v1_sp,input$v2_sp,input$v3_sp)})
  output$q2_comp<-renderPrint({c(input$v1_comp,input$v2_comp,input$v3_comp)})
  
  #titulos nuevos
  #funcion auxiliar - lee caracteristicas y me da los nombres
  nombres_ns_tif <- reactive({
    ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
    if(class(ca)=="try-error"){
      v <- print("El archivo no se encuentra, descargar y recargar página!")
      return(as.data.frame(v))
    }else{
      nombres <- as.character(ca[,2])
      a <- which(substr(nombres,1,3)=="TIF")
      return(nombres[a])
    }    
  })
  
  output$tit_new_ns_tif <- renderUI({ 
    selectInput("tit_ns_tif", "Seleccionar títulos", nombres_ns_tif(),multiple = TRUE)
  })
  
  output$t_ns_tif <- renderPrint(input$tit_ns_tif)
  #variable auxiliar muy util
  #tif
  # ns1 <- reactive({
  #   if(is.null(data_tit_tif_ns())){
  #     #input$t1_ns1
  #     c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns)
  #   }else{
  #     a <- data_tit_tif_ns() 
  #     as.character(a[,1])
  #   }
  # })
  
  #prueba
  #funcion auxiliar nombres tif
  # carac_tif <- function(tit){
  #   data <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
  #   
  #   if(tit=="TIF"){
  #     a <- which(substr(data[,2],1,3)=="TIF")
  #     data1 <- data[a,]
  #     data1[,5] <- as.Date(data1[,5],format="%d/%m/%Y")
  #     data1 <- data1[order(data1[,5]),]
  #     return(as.character(data1[,2]))
  #     
  #   }else if(tit=="VEBONO"){
  #     a1 <- which(substr(data[,2],1,3)=="VEB")
  #     return(as.character(data[a1,2]))
  #   }
  #   
  # }
  # 
  # output$freddy <- renderUI({ 
  #   selectInput("t1_ns1", "Seleccionar títulos", choices = carac_tif("TIF") ,multiple = TRUE)
  # })
  
  #veb
  # ns2 <- reactive({
  #   if(is.null(data_tit_veb_ns())){
  #     #input$t1_ns2
  #     c(input$v1_ns,input$v2_ns,input$v3_ns,input$v4_ns)
  #     
  #   }else{
  #     a <- data_tit_veb_ns() 
  #     as.character(a[,1])
  #   }
  # })
  
  #variable que muestra selccion ya sea de los tit disponibles
  #o del txt q se ingrese 
  # output$q1_ns1 <- renderPrint(
  #   ns1()
  #   )
  
  #
  # output$q1_ns2 <- renderPrint(
  #   ns2()
  # )
  
  #titulos
  # data_tit_tif_ns <- reactive({
  #   # input$file1 will be NULL initially. After the user selects
  #   # and uploads a file, it will be a data frame with 'name',
  #   # 'size', 'type', and 'datapath' columns. The 'datapath'
  #   # column will contain the local filenames where the data can
  #   # be found.
  #   
  #   inFile <- input$data_tit_tif
  #   
  #   if (is.null(inFile))
  #     return(NULL)
  #   
  #   read.table(inFile$datapath, header = input$header_tit_tif,
  #              sep = input$sep_tit_tif, quote = input$quote_tit_tif)
  #   
  # })
  
  #veb
  # data_tit_veb_ns <- reactive({
  #   # input$file1 will be NULL initially. After the user selects
  #   # and uploads a file, it will be a data frame with 'name',
  #   # 'size', 'type', and 'datapath' columns. The 'datapath'
  #   # column will contain the local filenames where the data can
  #   # be found.
  #   
  #   inFile <- input$data_tit_veb
  #   
  #   if (is.null(inFile))
  #     return(NULL)
  #   
  #   read.table(inFile$datapath, header = input$header_tit_veb,
  #              sep = input$sep_tit_veb, quote = input$quote_tit_veb)
  #   
  # })
  
  
  ###############################################################################
  ###############################################################################
  #################################    Datos    #################################
  ###############################################################################
  ###############################################################################
  #tif
  #output$datatable_tit_tif<-renderDataTable({
  #   if(is.null(data_tit_tif_ns())){return()}
  #   #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
  #   #datatable(data_pos())
  #   data_tit_tif_ns()
  # })
  
  #veb
  # output$datatable_tit_veb<-renderDataTable({
  #   if(is.null(data_tit_veb_ns())){return()}
  #   #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
  #   #datatable(data_pos())
  #   data_tit_veb_ns()
  # })
  
  #SVENSSON
  #SVENSSON
  #SVENSSON
  #data tif
  # data_tif_sv <- reactive({
  #   
  #   inFile <- input$data_tit_tif_sv
  #   
  #   if (is.null(inFile))
  #     return(NULL)
  #   
  #   read.table(inFile$datapath, header = input$header_tit_tif_sv,
  #              sep = input$sep_tit_tif_sv, quote = input$quote_tit_tif_sv)
  #   
  # })
  
  #muestro data
  # output$datatable_tit_tif_sv<-renderDataTable({
  #   if(is.null(data_tif_sv())){return()}
  #   #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
  #   #datatable(data_pos())
  #   data_tif_sv()
  # })
  # 
  
  #funcion auxiliar
  # sv1 <- reactive({
  #   if(is.null(data_tif_sv())){
  #     #input$t_sv1
  #     c(input$t1,input$t2,input$t3)
  #   }else{
  #     a <- data_tif_sv() 
  #     as.character(a[,1])
  #   }
  # })
  
  # output$q_sv1 <- renderPrint(
  #   sv1()
  # )
  
  #data veb
  # data_veb_sv <- reactive({
  #   
  #   inFile <- input$data_tit_veb_sv
  #   
  #   if (is.null(inFile))
  #     return(NULL)
  #   
  #   read.table(inFile$datapath, header = input$header_tit_veb_sv,
  #              sep = input$sep_tit_veb_sv, quote = input$quote_tit_veb_sv)
  #   
  # })
  
  #muestro data
  # output$datatable_tit_veb_sv<-renderDataTable({
  #   if(is.null(data_veb_sv())){return()}
  #   #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
  #   #datatable(data_pos())
  #   data_veb_sv()
  # })
  
  
  
  
  #veb
  # sv2 <- reactive({
  #   if(is.null(data_veb_sv())){
  #     #input$t_sv1
  #     c(input$v1,input$v2,input$v3)
  #   }else{
  #     a <- data_veb_sv() 
  #     as.character(a[,1])
  #   }
  # })
  
  output$q2<-renderPrint({  
    sv2()
  })
  
  
  #DIEBOLD-LI
  #DIEBOLD-LI
  #DIEBOLD-LI
  #data tif
  data_tif_dl <- reactive({
    
    inFile <- input$data_tit_tif_dl
    
    if (is.null(inFile))
      return(NULL)
    
    read.table(inFile$datapath, header = input$header_tit_tif_dl,
               sep = input$sep_tit_tif_dl, quote = input$quote_tit_tif_dl)
    
  })
  
  #muestro data
  output$datatable_tit_tif_dl<- DT::renderDataTable({
    if(is.null(data_tif_dl())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    #datatable(data_pos())
    data_tif_dl()
  })
  
  
  #funcion auxiliar
  dl1 <- reactive({
    if(is.null(data_tif_dl())){
      #input$t_sv1
      c(input$t1_dl,input$t2_dl,input$t3_dl)
    }else{
      a <- data_tif_dl() 
      as.character(a[,1])
    }
  })
  
  output$q1_dl <- renderPrint(
    dl1()
  )
  
  
  #data veb
  data_veb_dl <- reactive({
    
    inFile <- input$data_tit_veb_dl
    
    if (is.null(inFile))
      return(NULL)
    
    read.table(inFile$datapath, header = input$header_tit_veb_dl,
               sep = input$sep_tit_veb_dl, quote = input$quote_tit_veb_dl)
    
  })
  
  #muestro data
  output$datatable_tit_veb_dl<-DT::renderDataTable({
    if(is.null(data_veb_dl())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    #datatable(data_pos())
    data_veb_dl()
  })
  
  
  #funcion auxiliar
  dl2 <- reactive({
    if(is.null(data_veb_dl())){
      #input$t_sv1
      c(input$v1_dl,input$v2_dl,input$v3_dl)
    }else{
      a <- data_veb_dl() 
      as.character(a[,1])
    }
  })
  
  output$q2_dl <- renderPrint(
    dl2()
  )
  
  
  #SPLINES
  #SPLINES
  #SPLINES
  #data tif
  data_tif_sp <- reactive({
    
    inFile <- input$data_tit_tif_sp
    
    if (is.null(inFile))
      return(NULL)
    
    read.table(inFile$datapath, header = input$header_tit_tif_sp,
               sep = input$sep_tit_tif_sp, quote = input$quote_tit_tif_sp)
    
  })
  
  #muestro data
  output$datatable_tit_tif_sp<-DT::renderDataTable({
    if(is.null(data_tif_sp())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    #datatable(data_pos())
    data_tif_sp()
  })
  
  
  #funcion auxiliar
  sp1 <- reactive({
    if(is.null(data_tif_sp())){
      #input$t_sv1
      c(input$t1_sp,input$t2_sp,input$t3_sp)
    }else{
      a <- data_tif_sp() 
      as.character(a[,1])
    }
  })
  
  output$q1_sp <- renderPrint(
    sp1()
  )
  
  #data veb
  data_veb_sp <- reactive({
    
    inFile <- input$data_tit_veb_sp
    
    if (is.null(inFile))
      return(NULL)
    
    read.table(inFile$datapath, header = input$header_tit_veb_sp,
               sep = input$sep_tit_veb_sp, quote = input$quote_tit_veb_sp)
    
  })
  
  #muestro data
  output$datatable_tit_veb_sp<-DT::renderDataTable({
    if(is.null(data_veb_sp())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    #datatable(data_pos())
    data_veb_sp()
  })
  
  
  #funcion auxiliar
  sp2 <- reactive({
    if(is.null(data_veb_sp())){
      #input$t_sv1
      c(input$v1_sp,input$v2_sp,input$v3_sp)
    }else{
      a <- data_veb_sp() 
      as.character(a[,1])
    }
  })
  
  output$q2_sp <- renderPrint(
    sp2()
  )
  
  #COMPARATIVO
  #COMPARATIVO
  #COMPARATIVO
  #data tif
  data_tif_comp <- reactive({
    
    inFile <- input$data_tit_tif_comp
    
    if (is.null(inFile))
      return(NULL)
    
    read.table(inFile$datapath, header = input$header_tit_tif_comp,
               sep = input$sep_tit_tif_comp, quote = input$quote_tit_tif_comp)
    
  })
  
  #muestro data
  output$datatable_tit_tif_comp<-DT::renderDataTable({
    if(is.null(data_tif_comp())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    #datatable(data_pos())
    data_tif_comp()
  })
  
  
  #funcion auxiliar
  comp1 <- reactive({
    if(is.null(data_tif_comp())){
      #input$t_sv1
      c(input$t1_comp,input$t2_comp,input$t3_comp)
    }else{
      a <- data_tif_comp() 
      as.character(a[,1])
    }
  })
  
  output$q1_comp <- renderPrint(
    comp1()
  )
  
  #data veb
  data_veb_comp <- reactive({

    inFile <- input$data_tit_veb_comp

    if (is.null(inFile))
      return(NULL)

    read.table(inFile$datapath, header = input$header_tit_veb_comp,
               sep = input$sep_tit_veb_comp, quote = input$quote_tit_veb_comp)

  })

  #muestro data
  output$datatable_tit_veb_comp<-DT::renderDataTable({
    if(is.null(data_veb_comp())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    #datatable(data_pos())
    data_veb_comp()
  })


  #funcion auxiliar
  comp2 <- reactive({
    if(is.null(data_veb_comp())){
      #input$t_sv1
      c(input$v1_comp,input$v2_comp,input$v3_comp)
    }else{
      a <- data_veb_comp()
      as.character(a[,1])
    }
  })

  output$q2_comp <- renderPrint(
    comp2()
  )


  
  #precios
  #tf <- reactive({pos1(c(input$t1,input$t2,input$t3),0)})
  #tf <- reactive({pos1(sv1(),0)})
  
  
  #tf_ns <- reactive({pos1(c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),0)})
  # tf_ns <- reactive({
  #   # a <- pos1(ns1(),0)
  #   # if(length(which(a==0))==0){
  #   #   return(a)
  #   # }else{
  #   #   return("existen precios nulos")
  #   # }
  #   
  #   pos1(ns1(),0)
  #   })
  # 
  
  #tf_dl <- reactive({pos(c(input$t1_dl,input$t2_dl,input$t3_dl),0)})
  tf_dl <- reactive({pos1(dl1(),0)})
  
  #tf_sp <- reactive({pos(c(input$t1_sp,input$t2_sp,input$t3_sp),0)})
  tf_sp <- reactive({pos1(sp1(),0)})
  
  #tv <- reactive({pos(c(input$v1,input$v2,input$v3),1)})
  #tv <- reactive({pos1(sv2(),1)})
  
  #tv_ns <- reactive({pos1(c(input$v1_ns,input$v2_ns,input$v3_ns,input$v4_ns),1)})
  #tv_ns <- reactive({pos1(ns2(),1)})
  
  
  #tv_dl <- reactive({pos(c(input$v1_dl,input$v2_dl,input$v3_dl),1)})
  tv_dl <- reactive({pos1(dl2(),1)})
  
  #tv_sp <- reactive({pos(c(input$v1_sp,input$v2_sp,input$v3_sp),1)})
  tv_sp <- reactive({pos1(sp2(),1)})
  
  #output$pre1 <-renderPrint({tf()})
  #output$pre1_ns <-renderPrint({tf_ns()})
  
  #advertencia TIF
  # output$ad_pns_tif <- renderPrint({
  #   if(length(tf_ns())==1 & sum(tf_ns()==0)>=1){ return("No hay instrumentos seleccionados")}else{
  # 
  #   p <- tf_ns()
  # 
  #   if(length(which(p==0))!=0){
  #     return("Existen precios promedios nulos")
  #   }else{
  #     return("Precios promedio diferentes de cero")
  #   }
  # 
  #   }# final if inicial
  # 
  # })
  # 
  #ad - VEB
  # output$ad_pns_veb <- renderPrint({
  #   if(length(tv_ns())==1 & sum(tv_ns()==0)>=1){ return("No hay instrumentos seleccionados")}else{
  #     
  #     p <- tv_ns()
  #     
  #     if(length(which(p==0))!=0){
  #       return("Existen precios promedios nulos")
  #     }else{
  #       return("Precios promedio diferentes de cero")
  #     }
  #     
  #   }# final if inicial
  #   
  # })
  
  #funcion auxiliar
  #tif
  # ad_ns_t1 <- reactive({
  #   p <- tf_ns()
  #   a <- which(p==0)
  #   
  #   if(length(a)!=0){
  #   return(names(p)[a])
  #   }else{
  #     return(NULL)
  #   }
  #   
  # })
  
  #veb
  # ad_ns_t2 <- reactive({
  #   p <- tv_ns()
  #   a <- which(p==0)
  #   
  #   if(length(a)!=0){
  #     return(names(p)[a])
  #   }else{
  #     return(NULL)
  #   }
  #   
  # })
  #instrumentos a seleccionar
  #TIF
  output$ad_ns_tif <- renderUI({ 
    selectInput("ad_ns1", "Seleccionar títulos para modificar su precio promedio", ad_ns_t1(),multiple = TRUE)
  })
  
  #ingreso nuevo precio promedio
  output$Pp_ns1 <- renderPrint({input$pp_ns1})
  
  #variable nueva creada a partir de precios nulos
  #tif
  # output$np_ns1 <- renderPrint({
  #   if(is.null(ad_ns_t1())){ return("No hay precios promedios nulos")}
  #   #obtengo nombres de los instrumentos con precio 0
  #   a <- ad_ns_t1()
  #   
  #   b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  #   names(b) <- c("Títulos","Precio promedio")
  #   b[,1] <-  a
  #   
  #   
  #   c <- as.numeric(unlist(strsplit(input$vec1_ns,",")))
  #   if(length(c)>nrow(b)){
  #     return("Existen más precios de lo necesario, revisar precios ingresados")
  #   }else{
  #   
  #   b[,2] <- c
  #   
  #   #write.table(b,paste(getwd(),"data","pp_ns1.txt",sep = "/"),row.names = FALSE)
  #   
  #   b
  #   }
  # 
  # })
  
  #variable nueva creada a partir de precios nulos
  #VEB
  # output$np_ns2 <- renderPrint({
  #   if(is.null(ad_ns_t2())){ return("No hay precios promedios nulos")}
  #   #obtengo nombres de los instrumentos con precio 0
  #   a <- ad_ns_t2()
  #   
  #   b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  #   names(b) <- c("Títulos","Precio promedio")
  #   b[,1] <-  a
  #   
  #   
  #   c <- as.numeric(unlist(strsplit(input$vec2_ns,",")))
  #   if(length(c)>nrow(b)){
  #     return("Existen más precios de lo necesario, revisar precios ingresados")
  #   }else{
  #     
  #     b[,2] <- c
  #     
  #     #write.table(b,paste(getwd(),"data","pp_ns1.txt",sep = "/"),row.names = FALSE)
  #     
  #     b
  #   }
  #   
  # })
  
  #Salida
  # output$salida <-renderPrint({
  #   x <- as.numeric(unlist(strsplit(input$vec1_ns,",")))
  #  print(x)
  # })
  
  #variable auxiliar
  #tif
  # dat <- reactive({
  #   if(is.null(ad_ns_t1())){ return("Seleccionar instrumento")}
  #   #obtengo nombres de los instrumentos con precio 0
  #   a <- ad_ns_t1()
  #   
  #   b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  #   names(b) <- c("Títulos","Precio promedio")
  #   b[,1] <-  a
  #   
  #   
  #   c <- as.numeric(unlist(strsplit(input$vec1_ns,",")))
  #   if(length(c)>nrow(b)){
  #     return("Existen más precios de lo necesario, revisar precios ingresados")
  #   }else{
  #     
  #     b[,2] <- c
  #     
  #   }
  #     b
  # })
  
  #veb
  # dat1 <- reactive({
  #   if(is.null(ad_ns_t2())){ return("Seleccionar instrumento")}
  #   #obtengo nombres de los instrumentos con precio 0
  #   a <- ad_ns_t2()
  #   
  #   b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  #   names(b) <- c("Títulos","Precio promedio")
  #   b[,1] <-  a
  #   
  #   
  #   c <- as.numeric(unlist(strsplit(input$vec2_ns,",")))
  #   if(length(c)>nrow(b)){
  #     return("Existen más precios de lo necesario, revisar precios ingresados")
  #   }else{
  #     
  #     b[,2] <- c
  #   }
  #   b
  # })
  
  
  #sal
  #tif
  # output$sal1_ns <-renderPrint({
  #   a <- try(TF_NS())
  #   if(class(a)!="try-error"){return(a)}else{"Existen más precios de lo necesario, revisar precios ingresados"}
  #   
  # })
  
  #veb
  # output$sal2_ns <-renderPrint({
  #   a <- try(TV_NS())
  #   if(class(a)!="try-error"){return(a)}else{"Existen más precios de lo necesario, revisar precios ingresados"}
  #   
  # })
  
  #variable que utilizare para buscar precios promedio
  #tif
  # tf_ns1 <- reactive({
  #   a <- tf_ns()
  #   
  #   if(length(which(a==0))==0){
  #     return(a)
  #   }else{
  #     #a <- tf_ns()
  #     b <-dat()
  #     
  # 
  #     #return(b)
  #     #nombres de variables con precios nulos
  #     if(is.null(ad_ns_t1())){ return("Seleccionar instrumento")}
  #     
  #     n <- ad_ns_t1()
  #     
  #     ind <- c()
  #     for(i in 1:length(n)){
  #       ind[i] <- which(n[i]==names(a))
  #     }
  #     
  #     #asigno nuevos precios
  #     # for(i in 1:length(ind)){
  #     # a[ind[i]] <- b[i,2]
  #     # }
  #     a[ind] <- b[,2]
  #     return(a)
  #   
  #     
  #     
  #   }
  # })
  
  #veb
  # tv_ns1 <- reactive({
  #   a <- tv_ns()
  #   
  #   if(length(which(a==0))==0){
  #     return(a)
  #   }else{
  #     #a <- tf_ns()
  #     b <-dat1()
  #     #return(b)
  #     #nombres de variables con precios nulos
  #     if(is.null(ad_ns_t2())){ return("Seleccionar instrumento")}
  #     
  #     n <- ad_ns_t2()
  #     
  #     ind <- c()
  #     for(i in 1:length(n)){
  #       ind[i] <- which(n[i]==names(a))
  #     }
  #     
  #     #asigno nuevos precios
  #     # for(i in 1:length(ind)){
  #     # a[ind[i]] <- b[i,2]
  #     # }
  #     a[ind] <- b[,2]
  #     return(a)
  #   }
  #   
  #   
  # })
  
  #NUEVA VARIABLE
  #TIF
  # TF_NS <- reactive({
  #   a <- tf_ns()
  #   
  #   if(length(which(a==0))!=0){
  #     #return("Existen precios prom nulos")
  #     return(tf_ns1())
  #   }else{
  #     #return("precios bien")
  #     return(a)
  #   }
  #   
  #   
  # })
  
  #VEB
  # TV_NS <- reactive({
  #   a <- tv_ns()
  #   
  #   if(length(which(a==0))!=0){
  #     #return("Existen precios prom nulos")
  #     return(tv_ns1())
  #   }else{
  #     #return("precios bien")
  #     return(a)
  #   }
  #   
  #   
  # })
  
  
  #SVENSSON #SVENSSON
  #SVENSSON #SVENSSON
  #SVENSSON #SVENSSON
  #advertencia TIF
  # output$ad_psv_tif <- renderPrint({
  #   if(length(tf())==1 & sum(tf()==0)>=1){ return("No hay instrumentos seleccionados")}else{
  #     
  #     p <- tf()
  #     
  #     if(length(which(p==0))!=0){
  #       return("Existen precios promedios nulos")
  #     }else{
  #       return("Precios promedio diferentes de cero")
  #     }
  #     
  #   }# final if inicial
  #   
  # })
  
  #variable auxiliar
  #tif
  # ad_sv_t1 <- reactive({
  #   p <- tf()
  #   a <- which(p==0)
  #   
  #   if(length(a)!=0){
  #     return(names(p)[a])
  #   }else{
  #     return(NULL)
  #   }
  #   
  # })
  
  
  #variable nueva creada a partir de precios nulos
  #tif
  # output$np_sv1 <- renderPrint({
  #   if(is.null(ad_sv_t1())){ return("No hay precios promedios nulos")}
  #   #obtengo nombres de los instrumentos con precio 0
  #   a <- ad_sv_t1()
  #   
  #   b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  #   names(b) <- c("Títulos","Precio promedio")
  #   b[,1] <-  a
  #   
  #   
  #   c <- as.numeric(unlist(strsplit(input$vec1_sv,",")))
  #   if(length(c)>nrow(b)){
  #     return("Existen más precios de lo necesario, revisar precios ingresados")
  #   }else{
  #     
  #     b[,2] <- c
  # 
  #     b
  #   }
  #   
  # })
  
  #sal
  #tif
  # output$sal1_sv <-renderPrint({
  #   a <- try(TF())
  #   if(class(a)!="try-error"){return(a)}else{"Existen más precios de lo necesario, revisar precios ingresados"}
  #   
  # })
  
  #NUEVA VARIABLE
  #TIF
  # TF <- reactive({
  #   a <- tf()
  #   
  #   if(length(which(a==0))!=0){
  #     #return("Existen precios prom nulos")
  #     return(tf_1())
  #   }else{
  #     #return("precios bien")
  #     return(a)
  #   }
  #   
  # })
  
  #variable que utilizare para buscar precios promedio
  #tif
  # tf_1 <- reactive({
  #   a <- tf()
  #   
  #   if(length(which(a==0))==0){
  #     return(a)
  #   }else{
  #     b <-dat1_sv()
  #     #nombres de variables con precios nulos
  #     if(is.null(ad_sv_t1())){ return("Seleccionar instrumento")}
  #     
  #     n <- ad_sv_t1()
  #     
  #     ind <- c()
  #     for(i in 1:length(n)){
  #       ind[i] <- which(n[i]==names(a))
  #     }
  #     
  #     a[ind] <- b[,2]
  #     return(a)
  #   }
  #   
  #   
  # })
  
  #tif
  # dat1_sv <- reactive({
  #   if(is.null(ad_sv_t1())){ return("Seleccionar instrumento")}
  #   #obtengo nombres de los instrumentos con precio 0
  #   a <- ad_sv_t1()
  #   
  #   b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  #   names(b) <- c("Títulos","Precio promedio")
  #   b[,1] <-  a
  #   
  #   
  #   c <- as.numeric(unlist(strsplit(input$vec1_sv,",")))
  #   if(length(c)>nrow(b)){
  #     return("Existen más precios de lo necesario, revisar precios ingresados")
  #   }else{
  #     
  #     b[,2] <- c
  #   }
  #   b
  # })
  
  #VEBONOS
  #ad - VEB
  # output$ad_psv_veb <- renderPrint({
  #   if(length(tv())==1 & sum(tv()==0)>=1){ return("No hay instrumentos seleccionados")}else{
  #     
  #     p <- tv()
  #     
  #     if(length(which(p==0))!=0){
  #       return("Existen precios promedios nulos")
  #     }else{
  #       return("Precios promedio diferentes de cero")
  #     }
  #     
  #   }# final if inicial
  #   
  # })
  
  #VEB
  # output$np_sv2 <- renderPrint({
  #   if(is.null(ad_sv_t2())){ return("No hay precios promedios nulos")}
  #   #obtengo nombres de los instrumentos con precio 0
  #   a <- ad_sv_t2()
  #   
  #   b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  #   names(b) <- c("Títulos","Precio promedio")
  #   b[,1] <-  a
  #   
  #   
  #   c <- as.numeric(unlist(strsplit(input$vec2_sv,",")))
  #   if(length(c)>nrow(b)){
  #     return("Existen más precios de lo necesario, revisar precios ingresados")
  #   }else{
  #     
  #     b[,2] <- c
  #     b
  #   }
  #   
  # })
  
  #veb
  # ad_sv_t2 <- reactive({
  #   p <- tv()
  #   a <- which(p==0)
  #   
  #   if(length(a)!=0){
  #     return(names(p)[a])
  #   }else{
  #     return(NULL)
  #   }
  #   
  # })
  
  #veb
  # output$sal2_sv <-renderPrint({
  #   a <- try(TV())
  #   if(class(a)!="try-error"){return(a)}else{"Existen más precios de lo necesario, revisar precios ingresados"}
  #   
  # })
  
  #VEB
  # TV <- reactive({
  #   a <- tv()
  #   
  #   if(length(which(a==0))!=0){
  #     #return("Existen precios prom nulos")
  #     return(tv_1())
  #   }else{
  #     #return("precios bien")
  #     return(a)
  #   }
  #   
  #   
  # })
  
  #veb
  # tv_1 <- reactive({
  #   a <- tv()
  #   
  #   if(length(which(a==0))==0){
  #     return(a)
  #   }else{
  #     #a <- tf_ns()
  #     b <-dat2_sv()
  #     #return(b)
  #     #nombres de variables con precios nulos
  #     if(is.null(ad_sv_t2())){ return("Seleccionar instrumento")}
  #     
  #     n <- ad_sv_t2()
  #     
  #     ind <- c()
  #     for(i in 1:length(n)){
  #       ind[i] <- which(n[i]==names(a))
  #     }
  #     
  #     a[ind] <- b[,2]
  #     return(a)
  #   }
  #   
  #   
  # })
  
  #veb
  # dat2_sv <- reactive({
  #   if(is.null(ad_sv_t2())){ return("Seleccionar instrumento")}
  #   #obtengo nombres de los instrumentos con precio 0
  #   a <- ad_sv_t2()
  #   
  #   b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  #   names(b) <- c("Títulos","Precio promedio")
  #   b[,1] <-  a
  #   
  #   
  #   c <- as.numeric(unlist(strsplit(input$vec2_sv,",")))
  #   if(length(c)>nrow(b)){
  #     return("Existen más precios de lo necesario, revisar precios ingresados")
  #   }else{
  #     
  #     b[,2] <- c
  #   }
  #   b
  # })
  
  
  #COMPARATIVO #COMPARATIVO
  #COMPARATIVO #COMPARATIVO
  #COMPARATIVO #COMPARATIVO
  #TIF
  #advertencia TIF
  output$ad_pnsc_tif <- renderPrint({
    if(length(tf_comp())==1 & sum(tf_comp()==0)>=1){ return("No hay instrumentos seleccionados")}else{
      
      p <- tf_comp()
      
      if(length(which(p==0))!=0){
        return("Existen precios promedios nulos")
      }else{
        return("Precios promedio diferentes de cero")
      }
      
    }# final if inicial
    
  })
  
  #tif
  output$np_nsc1 <- renderPrint({
    if(is.null(ad_nsc_t1())){ return("No hay precios promedios nulos")}
    #obtengo nombres de los instrumentos con precio 0
    a <- ad_nsc_t1()
    
    b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
    names(b) <- c("Títulos","Precio promedio")
    b[,1] <-  a
    
    
    c <- as.numeric(unlist(strsplit(input$vec1_nsc,",")))
    if(length(c)>nrow(b)){
      return("Existen más precios de lo necesario, revisar precios ingresados")
    }else{
      
      b[,2] <- c

      b
    }
    
  })
  
  #tif
  ad_nsc_t1 <- reactive({
    p <- tf_comp()
    a <- which(p==0)
    
    if(length(a)!=0){
      return(names(p)[a])
    }else{
      return(NULL)
    }
    
  })
  
  #tif
  output$sal1_nsc <-renderPrint({
    a <- try(TF_NSC())
    if(class(a)!="try-error"){return(a)}else{"Existen más precios de lo necesario, revisar precios ingresados"}
    
  })
  
  #TIF
  TF_NSC <- reactive({
    a <- tf_comp()
    
    if(length(which(a==0))!=0){
      #return("Existen precios prom nulos")
      return(tf_nsc1())
    }else{
      #return("precios bien")
      return(a)
    }
    
    
  })
  
  #
  tf_nsc1 <- reactive({
    a <- tf_comp()
    
    if(length(which(a==0))==0){
      return(a)
    }else{
      #a <- tf_ns()
      b <-dat_nsc1()
      #return(b)
      #nombres de variables con precios nulos
      if(is.null(ad_nsc_t1())){ return("Seleccionar instrumento")}
      
      n <- ad_nsc_t1()
      
      ind <- c()
      for(i in 1:length(n)){
        ind[i] <- which(n[i]==names(a))
      }
      
      #asigno nuevos precios
      # for(i in 1:length(ind)){
      # a[ind[i]] <- b[i,2]
      # }
      a[ind] <- b[,2]
      return(a)
    }
    
    
  })
  
  #tif
  dat_nsc1 <- reactive({
    if(is.null(ad_nsc_t1())){ return("Seleccionar instrumento")}
    #obtengo nombres de los instrumentos con precio 0
    a <- ad_nsc_t1()
    
    b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
    names(b) <- c("Títulos","Precio promedio")
    b[,1] <-  a
    
    
    c <- as.numeric(unlist(strsplit(input$vec1_nsc,",")))
    if(length(c)>nrow(b)){
      return("Existen más precios de lo necesario, revisar precios ingresados")
    }else{
      
      b[,2] <- c
    }
    b
  })
  
  #VEBONOS
  #VEBONOS
  #VEBONOS
  #ad - VEB
  output$ad_pnsc_veb <- renderPrint({
    if(length(tv_comp())==1 & sum(tv_comp()==0)>=1){ return("No hay instrumentos seleccionados")}else{
      
      p <- tv_comp()
      
      if(length(which(p==0))!=0){
        return("Existen precios promedios nulos")
      }else{
        return("Precios promedio diferentes de cero")
      }
      
    }# final if inicial
    
  })
  
  #VEB
  output$np_nsc2 <- renderPrint({
    if(is.null(ad_nsc_t2())){ return("No hay precios promedios nulos")}
    #obtengo nombres de los instrumentos con precio 0
    a <- ad_nsc_t2()
    
    b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
    names(b) <- c("Títulos","Precio promedio")
    b[,1] <-  a
    
    
    c <- as.numeric(unlist(strsplit(input$vec2_nsc,",")))
    if(length(c)>nrow(b)){
      return("Existen más precios de lo necesario, revisar precios ingresados")
    }else{
      
      b[,2] <- c
      
      b
    }
    
  })
  
  #veb
  ad_nsc_t2 <- reactive({
    p <- tv_comp()
    a <- which(p==0)
    
    if(length(a)!=0){
      return(names(p)[a])
    }else{
      return(NULL)
    }
    
  })
  
  #
  output$sal2_nsc <-renderPrint({
    a <- try(TV_NSC())
    if(class(a)!="try-error"){return(a)}else{"Existen más precios de lo necesario, revisar precios ingresados"}
    
  })
  
  #VEB
  TV_NSC <- reactive({
    a <- tv_comp()
    
    if(length(which(a==0))!=0){
      #return("Existen precios prom nulos")
      return(tv_nsc1())
    }else{
      #return("precios bien")
      return(a)
    }
    
    
  })
 
  #veb
  tv_nsc1 <- reactive({
    a <- tv_comp()
    
    if(length(which(a==0))==0){
      return(a)
    }else{
      #a <- tf_ns()
      b <-dat_nsc2()
      #return(b)
      #nombres de variables con precios nulos
      if(is.null(ad_nsc_t2())){ return("Seleccionar instrumento")}
      
      n <- ad_nsc_t2()
      
      ind <- c()
      for(i in 1:length(n)){
        ind[i] <- which(n[i]==names(a))
      }
    
      a[ind] <- b[,2]
      return(a)
    }
    
    
  })
  
  
  #veb
  dat_nsc2 <- reactive({
    if(is.null(ad_nsc_t2())){ return("Seleccionar instrumento")}
    #obtengo nombres de los instrumentos con precio 0
    a <- ad_nsc_t2()
    
    b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
    names(b) <- c("Títulos","Precio promedio")
    b[,1] <-  a
    
    
    c <- as.numeric(unlist(strsplit(input$vec2_nsc,",")))
    if(length(c)>nrow(b)){
      return("Existen más precios de lo necesario, revisar precios ingresados")
    }else{
      
      b[,2] <- c
    }
    b
  })
  
  #SVENSSON SVENSSON 
  #SVENSSON SVENSSON 
  #SVENSSON SVENSSON 
  #advertencia TIF
  output$ad_psvc_tif <- renderPrint({
    if(length(tf_comp())==1 & sum(tf_comp()==0)>=1){ return("No hay instrumentos seleccionados")}else{
      
      p <- tf_comp()
      
      if(length(which(p==0))!=0){
        return("Existen precios promedios nulos")
      }else{
        return("Precios promedio diferentes de cero")
      }
      
    }# final if inicial
    
  })
  
  #tif
  output$np_svc1 <- renderPrint({
    if(is.null(ad_svc_t1())){ return("No hay precios promedios nulos")}
    #obtengo nombres de los instrumentos con precio 0
    a <- ad_svc_t1()
    
    b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
    names(b) <- c("Títulos","Precio promedio")
    b[,1] <-  a
    
    
    c <- as.numeric(unlist(strsplit(input$vec1_svc,",")))
    if(length(c)>nrow(b)){
      return("Existen más precios de lo necesario, revisar precios ingresados")
    }else{
      
      b[,2] <- c
      
      b
    }
    
  })
  
  #tif
  ad_svc_t1 <- reactive({
    p <- tf_comp()
    a <- which(p==0)
    
    if(length(a)!=0){
      return(names(p)[a])
    }else{
      return(NULL)
    }
    
  })
  
  #tif
  output$sal1_svc <-renderPrint({
    a <- try(TF_SV())
    if(class(a)!="try-error"){return(a)}else{"Existen más precios de lo necesario, revisar precios ingresados"}
    
  })
  
  #TIF
  TF_SV <- reactive({
    a <- tf_comp()
    
    if(length(which(a==0))!=0){
      #return("Existen precios prom nulos")
      return(tf_c1())
    }else{
      #return("precios bien")
      return(a)
    }
    
  })
  
  #tif
  tf_c1 <- reactive({
    a <- tf_comp()
    
    if(length(which(a==0))==0){
      return(a)
    }else{
      b <-dat1_svc()
      #nombres de variables con precios nulos
      if(is.null(ad_svc_t1())){ return("Seleccionar instrumento")}
      
      n <- ad_svc_t1()
      
      ind <- c()
      for(i in 1:length(n)){
        ind[i] <- which(n[i]==names(a))
      }
      
      a[ind] <- b[,2]
      return(a)
    }
    
    
  })
  
  #tif
  dat1_svc <- reactive({
    if(is.null(ad_svc_t1())){ return("Seleccionar instrumento")}
    #obtengo nombres de los instrumentos con precio 0
    a <- ad_svc_t1()
    
    b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
    names(b) <- c("Títulos","Precio promedio")
    b[,1] <-  a
    
    
    c <- as.numeric(unlist(strsplit(input$vec1_svc,",")))
    if(length(c)>nrow(b)){
      return("Existen más precios de lo necesario, revisar precios ingresados")
    }else{
      
      b[,2] <- c
    }
    b
  })
  
  #ad - VEB
  output$ad_psvc_veb <- renderPrint({
    if(length(tv_comp())==1 & sum(tv_comp()==0)>=1){ return("No hay instrumentos seleccionados")}else{
      
      p <- tv_comp()
      
      if(length(which(p==0))!=0){
        return("Existen precios promedios nulos")
      }else{
        return("Precios promedio diferentes de cero")
      }
      
    }# final if inicial
    
  })
  
  #VEB
  output$np_svc2 <- renderPrint({
    if(is.null(ad_svc_t2())){ return("No hay precios promedios nulos")}
    #obtengo nombres de los instrumentos con precio 0
    a <- ad_svc_t2()
    
    b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
    names(b) <- c("Títulos","Precio promedio")
    b[,1] <-  a
    
    
    c <- as.numeric(unlist(strsplit(input$vec2_svc,",")))
    if(length(c)>nrow(b)){
      return("Existen más precios de lo necesario, revisar precios ingresados")
    }else{
      
      b[,2] <- c
      b
    }
    
  })
  
  #veb
  ad_svc_t2 <- reactive({
    p <- tv_comp()
    a <- which(p==0)
    
    if(length(a)!=0){
      return(names(p)[a])
    }else{
      return(NULL)
    }
    
  })
  
  #veb
  output$sal2_svc <-renderPrint({
    a <- try(TV_SV())
    if(class(a)!="try-error"){return(a)}else{"Existen más precios de lo necesario, revisar precios ingresados"}
    
  })
  
  #VEB
  TV_SV <- reactive({
    a <- tv_comp()
    
    if(length(which(a==0))!=0){
      #return("Existen precios prom nulos")
      return(tv_c1())
    }else{
      #return("precios bien")
      return(a)
    }
    
    
  })
  
  #veb
  tv_c1 <- reactive({
    a <- tv_comp()
    
    if(length(which(a==0))==0){
      return(a)
    }else{
      #a <- tf_ns()
      b <-dat2_svc()
      #return(b)
      #nombres de variables con precios nulos
      if(is.null(ad_svc_t2())){ return("Seleccionar instrumento")}
      
      n <- ad_svc_t2()
      
      ind <- c()
      for(i in 1:length(n)){
        ind[i] <- which(n[i]==names(a))
      }
      
      a[ind] <- b[,2]
      return(a)
    }
    
    
  })
  
  #veb
  dat2_svc <- reactive({
    if(is.null(ad_svc_t2())){ return("Seleccionar instrumento")}
    #obtengo nombres de los instrumentos con precio 0
    a <- ad_svc_t2()
    
    b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
    names(b) <- c("Títulos","Precio promedio")
    b[,1] <-  a
    
    
    c <- as.numeric(unlist(strsplit(input$vec2_svc,",")))
    if(length(c)>nrow(b)){
      return("Existen más precios de lo necesario, revisar precios ingresados")
    }else{
      
      b[,2] <- c
    }
    b
  })
  
  
  ##
  #output$pre2 <-renderPrint({tv()})
  #output$pre2_ns <-renderPrint({tv_ns()})
  
  output$pre1_dl <-renderPrint({tf_dl()})
  output$pre1_sp <-renderPrint({tf_sp()})
  
  output$pre2_dl <-renderPrint({tv_dl()})
  output$pre2_sp <-renderPrint({tv_sp()})
  
  #comparativo
  #Nelson y Siegel - Svensson
  tf_comp <- reactive({pos1(comp1(),0)})
  tv_comp <- reactive({pos1(comp2(),1)})
  
  output$pre_comp_tif_ns <- renderPrint({tf_comp()})
  output$pre_comp_tif_sven <- renderPrint({tf_comp()})
  output$pre_comp_veb_ns <- renderPrint({tv_comp()})
  output$pre_comp_veb_sven <- renderPrint({tv_comp()})
  
  #output$pre1_ns_comp <-renderPrint({tf_ns_comp()})
  #output$pre2_ns_comp <-renderPrint({tv_ns_comp()})
  
  #Svensson
  #tf_comp <- reactive({pos(c(input$t1_comp,input$t2_comp,input$t3_comp),0)})
  #tv_comp <- reactive({pos(c(input$v1_comp,input$v2_comp,input$v3_comp),1)})
  
  
  #output$pre1_comp <-renderPrint({tf_comp()})
  #output$pre2_comp <-renderPrint({tv_comp()})
  
  #parametros
  #output$pa_tif <- renderPrint({print(paste0("$$\\beta_{0}$$"))})
  #output$pa_tif <- renderPrint({pa_sven})
  # output$formula <- renderPrint({
  #   return(paste0("Use this formula: $$\beta_{0}", 1,"$$"))
  # })
  # output$ex1 <- renderPrint({
  #  #withMathJax(helpText('$$\\beta_{0} \\quad \\beta_{1}  \\quad \\beta_{2} \\quad \\beta_{3} \\quad \\tau_{1} \\quad\\tau_{2} $$'))
  #   withMathJax(print(pa_ns))
  #   })
  #output$pa_tif_ns <- renderPrint({(pa_ns)})
  output$pa_tif_ns_el <- renderPrint({(pa_ns)})
  #output$pa_veb <- renderPrint({pa1_sven})
  #output$pa_veb_ns <- renderPrint({pa1_ns})
  
  #parametros elegir
  #NELSON Y SIEGEL
  #tif
  #individuales
  output$num_ns_b0_tif<-renderPrint({input$ns_b0_tif})
  output$num_ns_b1_tif<-renderPrint({input$ns_b1_tif})
  output$num_ns_b2_tif<-renderPrint({input$ns_b2_tif})
  output$num_ns_t_tif<-renderPrint({input$ns_t_tif})
  
  #conjunto
  #output$new_ns_tif <- renderPrint({(data.frame('B0'=input$ns_b0_tif,'B1'=input$ns_b1_tif,'B2'=input$ns_b2_tif,'T'=input$ns_t_tif,row.names = " " ))})
  
  #verificacion
  #output$ver_ns_tif <- renderPrint({data.frame('Condición_1'=input$ns_b0_tif>0,'Condición_2'=input$ns_b0_tif+input$ns_b1_tif>0,'Condición_3'=input$ns_t_tif>0,row.names = " " )})
  
  #Comparacion
  output$num_ns_b0_tif_comp <-renderPrint({input$ns_b0_tif_comp})
  output$num_ns_b1_tif_comp <-renderPrint({input$ns_b1_tif_comp})
  output$num_ns_b2_tif_comp <-renderPrint({input$ns_b2_tif_comp})
  output$num_ns_t_tif_comp <-renderPrint({input$ns_t_tif_comp})
  
  #conjunto
  output$new_ns_tif_comp <- renderPrint({
    #take dependency
    input$boton5
    
    #
    isolate(data.frame('B0'=input$ns_b0_tif_comp,'B1'=input$ns_b1_tif_comp,'B2'=input$ns_b2_tif_comp,'T'=input$ns_t_tif_comp,row.names = " " ))
    
    })
  
  #verificacion
  output$ver_ns_tif_comp <- renderPrint({
    #take dependency
    input$boton5
    
    #
    isolate(
    data.frame('Condición_1'=input$ns_b0_tif_comp>0,'Condición_2'=input$ns_b0_tif_comp+input$ns_b1_tif_comp>0,'Condición_3'=input$ns_t_tif_comp>0,row.names = " " )
    )
    
    })
  
  
  #veb
  #individuales
  output$num_ns_b0_veb<-renderPrint({input$ns_b0_veb})
  output$num_ns_b1_veb<-renderPrint({input$ns_b1_veb})
  output$num_ns_b2_veb<-renderPrint({input$ns_b2_veb})
  output$num_ns_t_veb<-renderPrint({input$ns_t_veb})
  
  #conjunto
  #output$new_ns_veb <- renderPrint({(data.frame('B0'=input$ns_b0_veb,'B1'=input$ns_b1_veb,'B2'=input$ns_b2_veb,'T'=input$ns_t_veb,row.names = " " ))})
  
  #verificacion
  #output$ver_ns_veb <- renderPrint({data.frame('Condición_1'=input$ns_b0_veb>0,'Condición_2'=input$ns_b0_veb+input$ns_b1_veb>0,'Condición_3'=input$ns_t_veb>0,row.names = " " )})
  
  #comparativo
  output$num_ns_b0_veb_comp<-renderPrint({input$ns_b0_veb_comp})
  output$num_ns_b1_veb_comp<-renderPrint({input$ns_b1_veb_comp})
  output$num_ns_b2_veb_comp<-renderPrint({input$ns_b2_veb_comp})
  output$num_ns_t_veb_comp<-renderPrint({input$ns_t_veb_comp})
  
  #conjunto
  output$new_ns_veb_comp <- renderPrint({
    #take dependency
    input$boton7
    
    #
    isolate(data.frame('B0'=input$ns_b0_veb_comp,'B1'=input$ns_b1_veb_comp,'B2'=input$ns_b2_veb_comp,'T'=input$ns_t_veb_comp,row.names = " " ))
    
    })
  
  #verificacion
  output$ver_ns_veb_comp <- renderPrint({
    #take dependency
    input$boton7
    
    #
    isolate(
    data.frame('Condición_1'=input$ns_b0_veb_comp>0,'Condición_2'=input$ns_b0_veb_comp+input$ns_b1_veb_comp>0,'Condición_3'=input$ns_t_veb_comp>0,row.names = " " )
    )
    })
  
  
  #SVENSSON
  #tif
  #individuales
  output$num_sven_b0_tif<-renderPrint({input$sven_b0_tif})
  output$num_sven_b1_tif<-renderPrint({input$sven_b1_tif})
  output$num_sven_b2_tif<-renderPrint({input$sven_b2_tif})
  output$num_sven_b3_tif<-renderPrint({input$sven_b3_tif})
  output$num_sven_t1_tif<-renderPrint({input$sven_t1_tif})
  output$num_sven_t2_tif<-renderPrint({input$sven_t2_tif})
  
  #conjunto
  #output$new_sven_tif <- renderPrint({(data.frame('B0'=input$sven_b0_tif,'B1'=input$sven_b1_tif,'B2'=input$sven_b2_tif,'B3'=input$sven_b3_tif,'T1'=input$sven_t1_tif,'T2'=input$sven_t2_tif,row.names = " " ))})
  
  #verificacion
  #output$ver_sven_tif <- renderPrint({data.frame('Condición_1'=input$sven_b0_tif>0,'Condición_2'=input$sven_b0_tif+input$sven_b1_tif>0,'Condición_3'=input$sven_t1_tif>0,'Condición_4'=input$sven_t2_tif>0,row.names = " " )})
  
  #comparativo
  output$num_sven_b0_tif_comp<-renderPrint({input$sven_b0_tif_comp})
  output$num_sven_b1_tif_comp<-renderPrint({input$sven_b1_tif_comp})
  output$num_sven_b2_tif_comp<-renderPrint({input$sven_b2_tif_comp})
  output$num_sven_b3_tif_comp<-renderPrint({input$sven_b3_tif_comp})
  output$num_sven_t1_tif_comp<-renderPrint({input$sven_t1_tif_comp})
  output$num_sven_t2_tif_comp<-renderPrint({input$sven_t2_tif_comp})
  
  #conjunto
  output$new_sven_tif_comp <- renderPrint({
    #take dependency
    input$boton6
    
    #
    isolate(data.frame('B0'=input$sven_b0_tif_comp,'B1'=input$sven_b1_tif_comp,'B2'=input$sven_b2_tif_comp,'B3'=input$sven_b3_tif_comp,'T1'=input$sven_t1_tif_comp,'T2'=input$sven_t2_tif_comp,row.names = " " ))
    
    })
  
  #verificacion
  output$ver_sven_tif_comp <- renderPrint({
    #take dependency
    input$boton6
    
    #
    isolate(
    data.frame('Condición_1'=input$sven_b0_tif_comp>0,'Condición_2'=input$sven_b0_tif_comp+input$sven_b1_tif_comp>0,'Condición_3'=input$sven_t1_tif_comp>0,'Condición_4'=input$sven_t2_tif_comp>0,row.names = " " )
    )
    
    })
  
  
  
  
  #veb
  output$num_sven_b0_veb<-renderPrint({input$sven_b0_veb})
  output$num_sven_b1_veb<-renderPrint({input$sven_b1_veb})
  output$num_sven_b2_veb<-renderPrint({input$sven_b2_veb})
  output$num_sven_b3_veb<-renderPrint({input$sven_b3_veb})
  output$num_sven_t1_veb<-renderPrint({input$sven_t1_veb})
  output$num_sven_t2_veb<-renderPrint({input$sven_t2_veb})
  
  #conjunto
  #output$new_sven_veb <- renderPrint({(data.frame('B0'=input$sven_b0_veb,'B1'=input$sven_b1_veb,'B2'=input$sven_b2_veb,'B3'=input$sven_b3_veb,'T1'=input$sven_t1_veb,'T2'=input$sven_t2_veb,row.names = " " ))})
  
  #verificacion
  #output$ver_sven_veb <- renderPrint({data.frame('Condición_1'=input$sven_b0_veb>0,'Condición_2'=input$sven_b0_veb+input$sven_b1_veb>0,'Condición_3'=input$sven_t1_veb>0,'Condición_4'=input$sven_t2_veb>0,row.names = " " )})
  
  #comparativo
  output$num_sven_b0_veb_comp<-renderPrint({input$sven_b0_veb_comp})
  output$num_sven_b1_veb_comp<-renderPrint({input$sven_b1_veb_comp})
  output$num_sven_b2_veb_comp<-renderPrint({input$sven_b2_veb_comp})
  output$num_sven_b3_veb_comp<-renderPrint({input$sven_b3_veb_comp})
  output$num_sven_t1_veb_comp<-renderPrint({input$sven_t1_veb_comp})
  output$num_sven_t2_veb_comp<-renderPrint({input$sven_t2_veb_comp})
  
  #conjunto
  output$new_sven_veb_comp <- renderPrint({
    #take dependency
    input$boton8
    
    #
    isolate(data.frame('B0'=input$sven_b0_veb_comp,'B1'=input$sven_b1_veb_comp,'B2'=input$sven_b2_veb_comp,'B3'=input$sven_b3_veb_comp,'T1'=input$sven_t1_veb_comp,'T2'=input$sven_t2_veb_comp,row.names = " " ))
    
    })
  
  #verificacion
  output$ver_sven_veb_comp <- renderPrint({
    #take dependency
    input$boton8
    
    #
    isolate(
    data.frame('Condición_1'=input$sven_b0_veb_comp>0,'Condición_2'=input$sven_b0_veb_comp+input$sven_b1_veb_comp>0,'Condición_3'=input$sven_t1_veb_comp>0,'Condición_4'=input$sven_t2_veb_comp>0,row.names = " " )
    )
    
    })
  
  
  #muestro caracteristicas
  #output$Ca <- renderDataTable({C})
  # output$Ca <- renderDataTable({
  #   ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
  #   if(class(ca)=="try-error"){
  #     v <- print("El archivo no se encuentra, descargar y recargar página!")
  #     return(as.data.frame(v))
  #   }else{
  #     return(ca)
  #   }
  # })
  
  #output$Ca_ns <- renderDataTable({C})
  # output$Ca_ns <- renderDataTable({
  #   ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
  #   if(class(ca)=="try-error"){
  #     v <- print("El archivo no se encuentra, descargar y recargar página!")
  #     return(as.data.frame(v))
  #   }else{
  #     return(ca)
  #   }
  # })
  output$Ca_dl <- DT::renderDataTable({
    ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
    if(class(ca)=="try-error"){
      v <- print("El archivo no se encuentra, descargar y recargar página!")
      return(as.data.frame(v))
    }else{
      return(ca)
    }
  })
  #output$Ca_sp <- renderDataTable({C})
  output$Ca_sp <- DT::renderDataTable({
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    })
  
  # output$Ca1 <- renderDataTable({
  #   ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
  #   if(class(ca)=="try-error"){
  #     v <- print("El archivo no se encuentra, descargar y recargar página!")
  #     return(as.data.frame(v))
  #   }else{
  #     return(ca)
  #   }
  # })
  
  
  # output$Ca1_ns <- renderDataTable({
  #   ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
  #   if(class(ca)=="try-error"){
  #     v <- print("El archivo no se encuentra, descargar y recargar página!")
  #     return(as.data.frame(v))
  #   }else{
  #     return(ca)
  #   }
  #   })
  output$Ca1_dl <- DT::renderDataTable({
    ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
    if(class(ca)=="try-error"){
      v <- print("El archivo no se encuentra, descargar y recargar página!")
      return(as.data.frame(v))
    }else{
      return(ca)
    }
  })
  output$Ca1_sp <- DT::renderDataTable({
    ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
    if(class(ca)=="try-error"){
      v <- print("El archivo no se encuentra, descargar y recargar página!")
      return(as.data.frame(v))
    }else{
      return(ca)
    }
  })
  output$Ca_comp <- DT::renderDataTable({
    ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
    if(class(ca)=="try-error"){
      v <- print("El archivo no se encuentra, descargar y recargar página!")
      return(as.data.frame(v))
    }else{
      return(ca)
    }
  })
  output$Ca1_comp <- DT::renderDataTable({
    ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
    if(class(ca)=="try-error"){
      v <- print("El archivo no se encuentra, descargar y recargar página!")
      return(as.data.frame(v))
    }else{
      return(ca)
    }
  })
  

  
  #precios estimados iniciales
  # output$p_est_tif <- renderDataTable({
  #   if(length(sv1())!=0){
  #   a <- try(Tabla.sven(fv = input$n1 ,tit = sv1(),pr =TF() ,pa = pa_sven,ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]] )
  #   if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  #   
  #   }else{}
  #   })
  #output$p_est_tif_ns <- renderDataTable({Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = pa_ns,ind = 0,C = C,fe2=0,fe3=0)[[1]] })
  # output$p_est_tif_ns <- renderDataTable({
  #   #if(length(c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns))!=0){
  #   if(length(ns1())!=0){
  #   a <- try(Tabla.ns(fv = input$n2 ,tit = ns1(),pr =TF_NS() ,pa = pa_ns,ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")) ,fe2=0,fe3=0)[[1]] )
  #   if(class(a)!="try-error"){datatable(a, options = list(paging = FALSE))}else{}
  #   
  #   }else{}
  #   })
  #output$p_est_tif_ns_el <- renderDataTable({Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = c(input$ns_b0_tif,input$ns_b1_tif,input$ns_b2_tif,input$ns_t_tif),ind = 0,C = C,fe2=0,fe3=0)[[1]] })
  # output$p_est_tif_ns_el <- renderDataTable({
  #   if(length(ns1())!=0){
  #   a <- try(Tabla.ns(fv = input$n2 ,tit = ns1(),pr =TF_NS() ,pa = c(input$ns_b0_tif,input$ns_b1_tif,input$ns_b2_tif,input$ns_t_tif),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]] )
  #   if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  #   }else{}
  #     })
  
  
  #comparativo
  output$p_est_tif_ns_el_comp <- DT::renderDataTable({
    #take dependency
    input$boton5
    
    #
    isolate(    
      a <- try(Tabla.ns(fv = input$n5 ,tit = comp1(),pr =TF_NSC() ,pa = c(input$ns_b0_tif_comp,input$ns_b1_tif_comp,input$ns_b2_tif_comp,input$ns_t_tif_comp),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]] )
    )
      if(class(a)!="try-error"){
      DT::datatable(a, options = list(paging = FALSE))
      }else{}
    
    
    })
  
  
  # output$p_est_veb <- renderDataTable({
  #   if((length(sv2()))!=0){
  #   a <- try(Tabla.sven(fv = input$n1 ,tit = sv2(),pr =TV() ,pa = pa1_sven,ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]] )
  #   if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  #   
  #   }else{}
  #   })
  
  # output$p_est_veb_ns <- renderDataTable({
  #   if(length(ns2())!=0){
  #   a <- try(Tabla.ns(fv = input$n2 ,tit = ns2(),pr =TV_NS() ,pa = pa1_ns,ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]])
  #   if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  #   }else{}
  #   })
  # output$p_est_veb_ns_el <- renderDataTable({
  #   if(length(ns2())!=0){
  #   a <- try(Tabla.ns(fv = input$n2 ,tit = ns2(),pr =TV_NS() ,pa =c(input$ns_b0_veb,input$ns_b1_veb,input$ns_b2_veb,input$ns_t_veb) ,ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]])
  #   if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  #   }else{}
  #     })
  
  #comparativo
  output$p_est_veb_ns_el_comp <- DT::renderDataTable({
    #take dependency
    input$boton7
    
    #
    isolate(
    a <- try(Tabla.ns(fv = input$n5 ,tit = comp2(),pr =TV_NSC() ,pa =c(input$ns_b0_veb_comp,input$ns_b1_veb_comp,input$ns_b2_veb_comp,input$ns_t_veb_comp) ,ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]])
    )
    
    if(class(a)!="try-error"){
      DT::datatable(a, options = list(paging = FALSE))
    }else{}
    
    })
  
  
  #precios estimados optimizados
  #paquete alabama
  # output$p_est_tif_opt <- renderDataTable({
  #   if(input$opt_tif_sven==1){
  #   withProgress(message = 'Calculando parámetros optimizados', value = 0, {
  #     incProgress(1/2, detail = "Realizando iteraciones")
  #   a <- try(Tabla.sven(fv = input$n1 ,tit = sv1(),pr =TF() ,pa = c(1,1,1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_tif_sven,fe3=0)[[1]] )
  #   if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  #   
  #   })
  #   }else{
  #     Aviso <- "No se optimizará, revisar los precios de la sección parámetros iniciales"
  #     return(as.data.frame(Aviso))
  #   }
  #   })
  
  # output$p_est_tif_opt_ns <- renderDataTable({
  #   if(input$opt_tif_ns==1){
  #   withProgress(message = 'Calculando precios teóricos...', value = 0, {
  #     incProgress(1/2, detail = "Realizando iteraciones")
  #   #Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = c(1,1,1,1),ind = 0,C = C,fe2=input$opt_tif_ns,fe3=0)[[1]] 
  #   a <- try(Tabla.ns(fv = input$n2 ,tit = ns1(),pr =TF_NS() ,pa = c(1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")) ,fe2=input$opt_tif_ns,fe3=0)[[1]] )
  #   if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  #   
  #   })
  #   }else{
  #     Aviso <- "No se optimizará, revisar precios sección parámetros iniciales"
  #     return(as.data.frame(Aviso))
  #   }
  #   })
  
  # output$p_est_tif_opt_sven_el <- renderDataTable({
  #   if(length(sv1())!=0){
  #   a <- try(Tabla.sven(fv = input$n1 ,tit = sv1(),pr =TF() ,pa = c(input$sven_b0_tif,input$sven_b1_tif,input$sven_b2_tif,input$sven_b3_tif,input$sven_t1_tif,input$sven_t2_tif),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]])
  #   if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  #   
  #   }else{}
  #   })
  
  #comparacion
  output$p_est_tif_opt_comp <- DT::renderDataTable({
    #pongo dependencia
    input$boton_7
    
    #
    isolate({
    
    if(input$opt_tif_sven_comp==1){
    withProgress(message = 'Calculando parámetros optimizados', value = 0, {
      incProgress(1/2, detail = "Realizando iteraciones")
    a <- try(Tabla.sven(fv = input$n5 ,tit = comp1(),pr =TF_SV() ,pa = c(1,1,1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_tif_sven_comp,fe3=0)[[1]])
    if(class(a)!="try-error"){return(DT::datatable(a, options = list(paging = FALSE)))}else{}
    
    #incProgress(1/2, detail = "Fin")
     })
    }else{
      Aviso <- "No se optimizará, revisar los precios de la sección parámetros iniciales"
      return(as.data.frame(Aviso))
    }
      
    }) #final isolate
    
    })
  
  output$p_est_tif_opt_ns_comp <- DT::renderDataTable({
    #pongo dependencia
    input$boton_5
    
    #
    isolate({
    
    if(input$opt_tif_ns_comp==1){
    withProgress(message = 'Calculando parámetros optimizados', value = 0, {
      incProgress(1/2, detail = "Realizando iteraciones")
    a <- try(Tabla.ns(fv = input$n5 ,tit = comp1(),pr =TF_NSC() ,pa = c(1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_tif_ns_comp,fe3=0)[[1]] )
    if(class(a)!="try-error"){return(DT::datatable(a, options = list(paging = FALSE)))}else{}
    
    #incProgress(1/2, detail = "Fin")
    })
    }else{
      Aviso <- "No se optimizará, revisar los precios de la sección parámetros iniciales"
      return(as.data.frame(Aviso))
    }
      
    }) #final isolate
    })
  
  #
  output$p_est_tif_opt_sven_el_comp <- DT::renderDataTable({
    #take dependency
    input$boton6
    
    #
    isolate(
    a <- try(Tabla.sven(fv = input$n5 ,tit = comp1(),pr =TF_SV() ,pa = c(input$sven_b0_tif_comp,input$sven_b1_tif_comp,input$sven_b2_tif_comp,input$sven_b3_tif_comp,input$sven_t1_tif_comp,input$sven_t2_tif_comp),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]]) 
    )
    if(class(a)!="try-error"){
      DT::datatable(a, options = list(paging = FALSE))
    }else{}
    })
  
  
  # output$p_est_veb_opt <- renderDataTable({
  #   if(input$opt_veb_sven==1){
  #   withProgress(message = 'Calculando parámetros optimizados', value = 0, {
  #     incProgress(1/2, detail = "Realizando iteraciones")
  #   a <- try(Tabla.sven(fv = input$n1 ,tit = sv2(),pr =TV() ,pa = c(1,1,1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_veb_sven,fe3=0)[[1]])
  #   if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  #   
  #   })
  #   }else{
  #     Aviso <- "No se optimizará, revisar los precios de la sección parámetros iniciales"
  #     return(as.data.frame(Aviso))
  #     }
  #   })
  
  # output$p_est_veb_opt_ns <- renderDataTable({
  #   if(input$opt_veb_ns==1){
  #   withProgress(message = 'Calculando parámetros optimizados', value = 0, {
  #     incProgress(1/2, detail = "Realizando iteraciones")
  #   a <- try(Tabla.ns(fv = input$n2 ,tit = ns2(),pr =TV_NS() ,pa = c(1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_veb_ns,fe3=0)[[1]] )
  #   if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  #   })
  #   }else{
  #     Aviso <- "No se optimizará, revisar los precios de la sección parámetros iniciales"
  #     return(as.data.frame(Aviso))
  #   }
  #   })
  
  # output$p_est_veb_opt_sven_el <- renderDataTable({
  #   if(length(sv2())!=0){
  #   a <- try(Tabla.sven(fv = input$n1 ,tit = sv2(),pr =TV() ,pa = c(input$sven_b0_veb,input$sven_b1_veb,input$sven_b2_veb,input$sven_b3_veb,input$sven_t1_veb,input$sven_t2_veb),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]])
  #   if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  #   
  #   }else{}
  #   })
  
  #comparacion
  output$p_est_veb_opt_comp <- DT::renderDataTable({
    #pongo dependencia
    input$boton_8
    
    #
    isolate({
    
    if(input$opt_veb_sven_comp==1){
    withProgress(message = 'Calculando precios teóricos...', value = 0, {
      incProgress(1/2, detail = "Realizando iteraciones")
      a <- try(Tabla.sven(fv = input$n5 ,tit = comp2(),pr =TV_SV() ,pa = c(1,1,1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_veb_sven_comp,fe3=0)[[1]])
      if(class(a)!="try-error"){return(DT::datatable(a, options = list(paging = FALSE)))}else{}
      
    })
    }else{
      Aviso <- "No se optimizará, revisar los precios de la sección parámetros iniciales"
      return(as.data.frame(Aviso))
    }
      
    }) #final isolate
    })
  
  output$p_est_veb_opt_sven_el_comp <- DT::renderDataTable({
    #take dependency
    input$boton8
    
    #
    isolate(
    a <- try(Tabla.sven(fv = input$n5 ,tit = comp2(),pr =TV_SV() ,pa = c(input$sven_b0_veb_comp,input$sven_b1_veb_comp,input$sven_b2_veb_comp,input$sven_b3_veb_comp,input$sven_t1_veb_comp,input$sven_t2_veb_comp),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]])
    )
    
    if(class(a)!="try-error"){
      DT::datatable(a, options = list(paging = FALSE))
    }else{}
    })
  
  #
  output$p_est_veb_opt_ns_comp <- DT::renderDataTable({
    #pongo dependencia
    input$boton_6
    
    #
    isolate({
    
    if(input$opt_veb_ns_comp==1){
    withProgress(message = 'Calculando precios...', value = 0, {
      incProgress(1/2, detail = "Realizando iteraciones")
      a <- try(Tabla.ns(fv = input$n5 ,tit = comp2(),pr =TV_NSC() ,pa = c(1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_veb_ns_comp,fe3=0)[[1]] )
      if(class(a)!="try-error"){return(DT::datatable(a, options = list(paging = FALSE)))}else{}
      #incProgress(1/2, detail = "Fin")
      })
    }else{
    Aviso <- "No se optimizará, revisar los precios de la sección parámetros iniciales"
    return(as.data.frame(Aviso))
    }
    }) #final isolate
      
    })
  
  
  #precios DL
  #extraigo spline
  #parametro de suavizamiento de splines para DL
  #TIF
  output$spar_tif_dl <- renderPrint({input$parametro_tif_dl})
  
  #cantidad de dias DL TIF
  output$dias_tif_dl <- renderPrint({input$d_tif_dl})
  
  #cantidad de dias DL VEBONOS
  output$dias_veb_dl <- renderPrint({input$d_veb_dl})
  
  #defino funcion auxliliar que hace el llamado a la funcion tabla.Splines
  #una sola vez
  tabla_sp_dl_tif <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    Tabla.splines(data = dat,tipo = "TIF",fe=input$n3,num =input$d_tif_dl,par = input$parametro_tif_dl,tit=dl1(),car,pr=tf_dl())
    })
  
  dl_spline_tif <- reactive({
    withProgress(message = 'Calculando spline a utilizar', value = 0, {
      # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
      # dat[,3] <- as.Date(as.character(dat[,3]))
      # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
      tabla_sp_dl_tif()[[4]]
      # a <- try(tabla_sp_dl_tif()[[4]],silent = TRUE)
      # if(class(a)!="try-error"){
      #   a
      # }else{
      #   return("Poca cantidad de observaciones, favor seleccionar una cantidad mayor")
      # }
      
    })
    })
  
  output$spline_tif <- renderPrint({
    #agrego dependencia 
    input$boton9
    
    #
    isolate(
    a <- try(dl_spline_tif())
    )
    if(class(a)!="try-error"){
      a
    }else{
      #b <- 
      return("Poca cantidad de observaciones, favor seleccionar una cantidad mayor")
    }
    
    })
  
  output$p_est_dl_tif <- DT::renderDataTable({
    #agrego dependencia 
    input$boton9
    
    #
    withProgress(message = 'Calculando precios teóricos', value = 0, {
      incProgress(1/2, detail = "Realizando iteraciones")
      car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    a <- isolate(try(precio.dl(tit = dl1(),fv = input$n3 ,C = car,pa = c(1,1,1,1),spline1 = dl_spline_tif(),pr=tf_dl())[[1]]))
    
    if(class(a)!="try-error"){
      isolate(DT::datatable(a, options = list(paging = FALSE)))
    }else{}
    
    })
    })
  
  #comparativo
  output$spar_tif_dl_comp <- renderPrint({input$parametro_tif_dl_comp})
  
  #numero de observaciones tif
  output$dias_tif_dl_comp<- renderPrint({input$d_tif_dl_comp})
  
  
  #creo funcion para acelerar calculo en seccion comparativo DL 
  tabla_sp_dl_tif_comp  <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    Tabla.splines(data = dat,tipo = "TIF",fe=input$n5,num=input$d_tif_dl_comp,par = input$parametro_tif_dl_comp,tit=comp1(),car,pr=tf_comp())
  })
  
  dl_spline_tif_comp <- reactive({
    withProgress(message = 'Calculando spline a utilizar...', value = 0, {
      # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
      # dat[,3] <- as.Date(as.character(dat[,3]))
      # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
      # Tabla.splines(data = dat,tipo = "TIF",fe=input$n5,num =40,par = input$parametro_tif_dl_comp,tit=c(input$t1_comp,input$t2_comp,input$t3_comp),car,pr=tf_comp())[[4]] 
      tabla_sp_dl_tif_comp()[[4]] 
      #incProgress(1/2, detail = "Fin")
    })
    })
  
  output$spline_tif_comp_out <- renderPrint({
    #pongo dependencia
    input$boton15
    
    #
    isolate({
    a <- try(dl_spline_tif_comp())
    if(class(a)!="try-error"){
      a
    }else{
      return("Poca cantidad de observaciones, favor seleccionar una cantidad mayor")
    }
    
    })
      
    })
  
  output$p_est_dl_tif_comp <- DT::renderDataTable({
    #pongo dependencia
    input$boton15
    
    #
    isolate({
    withProgress(message = 'Calculando precios teóricos...', value = 0, {
      incProgress(1/2, detail = "Realizando iteraciones")
      a <- try(precio.dl(tit = comp1(),fv = input$n5 ,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")) ,pa = c(1,1,1,1),spline1 = dl_spline_tif_comp(),pr=tf_comp())[[1]])
      if(class(a)!="try-error"){
        DT::datatable(a, options = list(paging = FALSE))
      }else{}
      
      })
      
    }) #final isolate
    })
  
  
  #Vebonos
  output$spar_veb_dl <- renderPrint({input$parametro_veb_dl})
  
  #defino funcion auxliliar que hace el llamado a la funcion tabla.Splines
  #una sola vez
  tabla_sp_dl_veb <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n3,num =input$d_veb_dl,par = input$parametro_veb_dl,tit=dl2(),car,pr=tv_dl())
  })
  
  
  dl_spline_veb <- reactive({
    withProgress(message = 'Calculando spline a utilizar...', value = 0, {
      # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
      # dat[,3] <- as.Date(as.character(dat[,3]))
      # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
      # Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n3,num =40,par = input$parametro_veb_dl,tit=c(input$v1_dl,input$v2_dl,input$v3_dl),car,pr=tv_dl())[[4]] 
      tabla_sp_dl_veb()[[4]] 
    })
    })
  
  output$spline_veb <- renderPrint({
    #agrego dependencia 
    input$boton10
    
    #
    a <- isolate(try(dl_spline_veb()))
    if(class(a)!="try-error"){
      return(a)
    }else{
      return("Poca cantidad de observaciones, favor seleccionar una cantidad mayor")
    }
    
    })
  
  output$p_est_dl_veb <- DT::renderDataTable({
    #agrego dependencia 
    input$boton10
    
    withProgress(message = 'Calculando precios teóricos...', value = 0, {
      incProgress(1/2, detail = "Realizando iteraciones")
      car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    a <- isolate(try(precio.dl(tit = dl2(),fv = input$n3 ,C = car ,pa = c(1,1,1,1),spline1 = dl_spline_veb(),pr=tv_dl())[[1]]))
    
    if(class(a)!="try-error"){
      isolate(DT::datatable(a, options = list(paging = FALSE)))
    }else{}
    })
    })
  
  #Comparativo
  output$spar_veb_dl_comp <- renderPrint({input$parametro_veb_dl_comp})
  
  #numero de observaciones veb
  output$dias_veb_dl_comp <- renderPrint({input$d_veb_dl_comp})
  
  
  #
  #creo funcion que me calcula una sola llamada de la funcion de splines
  tabla_sp_dl_veb_comp <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num =input$d_veb_dl_comp,par = input$parametro_veb_dl_comp,tit=comp2(),car,pr=tv_comp())
    
  })
  
  
  
  dl_spline_veb_comp <- reactive({
    withProgress(message = 'Calculando spline a utilizar...', value = 0, {
    #   dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    #   dat[,3] <- as.Date(as.character(dat[,3]))
    #   car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num =40,par = input$parametro_veb_dl_comp,tit=c(input$v1_comp,input$v2_comp,input$v3_comp),car,pr=tv_comp())[[4]] 
      tabla_sp_dl_veb_comp()[[4]]
    })
      })
  
  output$spline_veb_comp_out <- renderPrint({
    #pongo dependencia
    input$boton16
    
    #
    isolate({
    a <- try(dl_spline_veb_comp())
    if(class(a)!="try-error"){
      a
    }else{
      return("Poca cantidad de observaciones, favor seleccionar una cantidad mayor")
    }
    
    }) #final isolate
    
    })
  
  output$p_est_dl_veb_comp <- DT::renderDataTable({
    #pongo dependencia
    input$boton16
    
    #
    isolate({
    
    withProgress(message = 'Calculando precios teóricos', value = 0, {
      incProgress(1/2, detail = "Realizando iteraciones")
      a <- try(precio.dl(tit = comp2(),fv = input$n5 ,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")) ,pa = c(1,1,1,1),spline1 = dl_spline_veb_comp(),pr=tv_comp())[[1]])
      if(class(a)!="try-error"){
        DT::datatable(a, options = list(paging = FALSE))
        }else{}
      
      })
    }) #final isolate
      
    })
  
  
  #grafico 
  #extraigo puntos con los q se hace la curva, para DL
  #tif
  pto_sp_tif_dl <- reactive({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n3,num = 40,par = input$parametro_tif_dl,tit=c(input$t1_dl,input$t2_dl,input$t3_dl),car,pr=tf_dl())[[2]]
    a <- tabla_sp_dl_tif()[[2]]
    
    # a1 <- cbind.data.frame(a$Plazo,a$Rendimiento)
    # names(a1) <- c("Plazo","Rendimiento")
    return(a)
  })
  
  #comparativo
  pto_sp_tif_dl_comp <- reactive({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # 
    # a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n5,num = 40,par = input$parametro_tif_dl_comp,tit=c(input$t1_comp,input$t2_comp,input$t3_comp),car,pr=tf_comp())[[2]]
    a <- tabla_sp_dl_tif_comp()[[2]]
    # a1 <- cbind.data.frame(a$Plazo,a$Rendimiento)
    # names(a1) <- c("Plazo","Rendimiento")
    return(a)
  })
  
  
  #veb
  pto_sp_veb_dl <- reactive({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # a <- Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n3,num = 40,par = input$parametro_veb_dl,tit=c(input$v1_dl,input$v2_dl,input$v3_dl),car,pr=tv_dl())[[2]]
    a <- tabla_sp_dl_veb()[[2]]
    
    
    # a1 <- cbind.data.frame(a$Plazo,a$Rendimiento)
    # names(a1) <- c("Plazo","Rendimiento")
    return(a)
  })
  
  #comparativo
  pto_sp_veb_dl_comp <- reactive({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # a <- Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num = 40,par = input$parametro_veb_dl_comp,tit=c(input$v1_comp,input$v2_comp,input$v3_comp),car,pr=tv_comp())[[2]]
    a <- tabla_sp_dl_veb_comp()[[2]]
    # a1 <- cbind.data.frame(a$Plazo,a$Rendimiento)
    # names(a1) <- c("Plazo","Rendimiento")
    return(a)
  })
  
  
  #Splines para Diebold-Li
  #tif
  output$c_tif_splines_dl <- renderRbokeh({
    #agrego dependencia 
    input$boton9
    
    #
    withProgress(message = 'Graficando curva de rendimiento...', value = 0, {
      incProgress(1/2, detail = "Calculando alturas")
      # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
      # dat[,3] <- as.Date(as.character(dat[,3]))
      # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
      #y <-predict(Tabla.splines(data = dat,tipo = "TIF",fe=input$n3,num = 40,par = input$parametro_tif_dl,tit=c(input$t1_dl,input$t2_dl,input$t3_dl),car,pr=tf_dl())[[4]],seq(0.1,20,0.1)*365)$y
      y <-isolate(try(predict(tabla_sp_dl_tif()[[4]],seq(0.9,20,0.1)*365)$y))
      
      if(class(y)!="try-error"){
      
      incProgress(1/2, detail = "Ajustando spline")
        isolate(
    figure(width = 1000,height = 400) %>%
      ly_points(pto_sp_tif_dl()[,4],pto_sp_tif_dl()[,7],pto_sp_tif_dl(),hover=list("Nombre"=pto_sp_tif_dl()[,1],"Fecha de operación"=pto_sp_tif_dl()[,2])) %>%
      ly_points(x=cbind.data.frame(x=seq(0.9,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.9,20,0.1)*365,y)[,2],color="green",hover=list("Plazo"=cbind.data.frame(x=seq(0.9,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.9,20,0.1)*365,y)[,2]),size=4) %>%
      # theme_title(text_color="green",text_align="center",text_font_style="italic")%>%
      x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
      )
      }else{}
    
    
    })
  })
  
  #comparativo
  output$c_tif_splines_dl_comp <- renderRbokeh({
    #pongo dependencia
    input$boton15
    
    #
    isolate({
    
    withProgress(message = 'Graficando curva de rendimiento...', value = 0, {
      incProgress(1/2, detail = "Calculando alturas")
      # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
      # dat[,3] <- as.Date(as.character(dat[,3]))
      # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    #y <-predict(Tabla.splines(data = dat,tipo = "TIF",fe=input$n5,num = 40,par = input$parametro_tif_dl_comp,tit=c(input$t1_comp,input$t2_comp,input$t3_comp),car,pr=tf_comp())[[4]],seq(0.1,20,0.1)*365)$y
     a <- try(tabla_sp_dl_tif_comp()[[4]])
      
     if(class(a)!="try-error"){
       y <-predict(a,seq(0.1,20,0.1)*365)$y
      incProgress(1/2, detail = "ajustando spline")
    figure(width = 1000,height = 400) %>%
      ly_points(pto_sp_tif_dl_comp()[,4],pto_sp_tif_dl_comp()[,7],pto_sp_tif_dl_comp(),hover=list("Nombre"=pto_sp_tif_dl_comp()[,1],"Fecha de operación"=pto_sp_tif_dl_comp()[,2])) %>%
      ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="green",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
      # theme_title(text_color="green",text_align="center",text_font_style="italic")%>%
      x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
     }else{}
    
    })
    }) #final isolate
      
  })
  
  #vebonos
  output$c_veb_splines_dl <- renderRbokeh({
    #agrego dependencia 
    input$boton10
    
    withProgress(message = 'Graficando curva de rendimiento...', value = 0, {
      incProgress(1/2, detail = "Calculando alturas")
    #   dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    #   dat[,3] <- as.Date(as.character(dat[,3]))
    #   car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # y <-predict(Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n3,num = 40,par = input$parametro_veb_dl,tit=c(input$v1_dl,input$v2_dl,input$v3_dl),car,pr=tv_dl())[[4]],seq(0.1,20,0.1)*365)$y
      y <-isolate(try(predict(tabla_sp_dl_veb()[[4]],seq(0.1,20,0.1)*365)$y))
      
      if(class(y)!="try-error"){
      
      incProgress(1/2, detail = "Ajustando spline")
    
        isolate(
    figure(width = 1000,height = 400) %>%
      ly_points(pto_sp_veb_dl()[,4],pto_sp_veb_dl()[,7],pto_sp_veb_dl(),hover=list("Nombre"=pto_sp_veb_dl()[,1],"Fecha de operación"=pto_sp_veb_dl()[,2])) %>%
      ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="brown",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
      # theme_title(text_color="green",text_align="center",text_font_style="italic")%>%
      x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
        )
      }else{}
    
    
    })
  })
  
  #comparativo
  output$c_veb_splines_dl_comp <- renderRbokeh({
    #pongo dependencia
    input$boton16
    
    #
    isolate({
    withProgress(message = 'Graficando curva de rendimiento...', value = 0, {
      incProgress(1/2, detail = "Calculando alturas")
    #   dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    #   dat[,3] <- as.Date(as.character(dat[,3]))
    #   car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # y <-predict(Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num = 40,par = input$parametro_veb_dl_comp,tit=c(input$v1_comp,input$v2_comp,input$v3_comp),car,pr=tv_comp())[[4]],seq(0.1,20,0.1)*365)$y
    a <- try(tabla_sp_dl_veb_comp()[[4]])
      
    if(class(a)!="try-error"){
      y <-predict(a,seq(0.1,20,0.1)*365)$y
    incProgress(1/2, detail = "ajustando spline")
    figure(width = 1000,height = 400) %>%
      ly_points(pto_sp_veb_dl_comp()[,4],pto_sp_veb_dl_comp()[,7],pto_sp_veb_dl_comp(),hover=list("Nombre"=pto_sp_veb_dl_comp()[,1],"Fecha de operación"=pto_sp_veb_dl_comp()[,2])) %>%
      ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="brown",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
      # theme_title(text_color="green",text_align="center",text_font_style="italic")%>%
      x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
    
    }else{}
    
    })
      
    }) #final isolate
  })
  
  #Grafico 3D!
  #tif
  output$curva_tif_dl <- renderPlotly({ 
    #agrego dependencia 
    input$boton9
    
    #
    #defino eje maduracion
    X1 <- seq(1,20,0.1)
    
    #defino tiempos
    Y1 <- seq(1,50,1)
    
    #
    var_par <- as.data.frame(matrix(0,length(Y1),4))
    
    #defino variable spline
    a <- isolate(try(dl_spline_tif()))
    
    if(class(a)!="try-error"){
      isolate(
    #guardo parametros segun cada tiempo
    for(i in 1:length(Y1)){
      #var_par[i,] <- par_dl(t[i],spline1,pa=c(1,1,1,1))
      var_par[i,] <- par_dl(Y1,a,pa=c(1,1,1,1))
      
    }
      )
    #calculo nuevos rendimientos a partir de los nuevos parametros
    new_rend <- as.data.frame(matrix(0,length(X1),length(Y1)))
    
    isolate(
    for(i in 1:length(Y1)){
      
      new_rend[,i] <- diebold_li(as.numeric(var_par[i,]),X1)
      #new_rend[,i] <- nelson_siegel(as.numeric(var_par[i,]),X)
    }
    )
    
    Z1 <- as.matrix(new_rend*100)
    row.names(Z1) <- X1
    colnames(Z1) <- Y1
    
    #defino configuracion de los ejes
    # Create lists for axis properties
    # f1 <- list(
    #   family = "Arial, sans-serif",
    #   size = 18,
    #   color = "blue")
    # 
    # f2 <- list(
    #   family = "Old Standard TT, serif",
    #   size = 14,
    #   color = "green")
    # 
    # axis <- list(
    #   titlefont = f1,
    #   tickfont = f2
    #   #showgrid = F
    # )
    
    scene = list(
      xaxis = list(domain = c(0, 50),
                   title = "Tiempo"),
      yaxis = list(domain = c(0, 200),
                   title = "Maduración (años)"),
      zaxis = list(domain = c(0, 0.12),
                   title = "Rendimiento (%)"),
      camera = list(eye = list(x = -1.25, y = 1.25, z = 1.25))
    )
    
    
    plot_ly(z = Z1,  type = "surface") %>%
      layout(title = "Curva de Rendimientos metodología Diebold-Li",scene = scene)
    
      
    }else{}
    })
  
  #comparativo
  output$curva_tif_dl_comp <- renderPlotly({ 
    #pongo dependencia
    input$boton15
    
    #
    isolate({
    
    #defino eje maduracion
    X1 <- seq(1,20,0.1)
    
    #defino tiempos
    Y1 <- seq(1,50,1)
    
    #
    var_par <- as.data.frame(matrix(0,length(Y1),4))
    
    #calculo spline
    a <- try(dl_spline_tif_comp())
    
    if(class(a)!="try-error"){
    #guardo parametros segun cada tiempo
    for(i in 1:length(Y1)){
      #var_par[i,] <- par_dl(t[i],spline1,pa=c(1,1,1,1))
      var_par[i,] <- par_dl(Y1,a,pa=c(1,1,1,1))
      
    }
    
    #calculo nuevos rendimientos a partir de los nuevos parametros
    new_rend <- as.data.frame(matrix(0,length(X1),length(Y1)))
    
    
    for(i in 1:length(Y1)){
      
      new_rend[,i] <- diebold_li(as.numeric(var_par[i,]),X1)
      #new_rend[,i] <- nelson_siegel(as.numeric(var_par[i,]),X)
    }
    
    Z1 <- as.matrix(new_rend*100)
    row.names(Z1) <- X1
    colnames(Z1) <- Y1
    
    #defino configuracion de los ejes
    # Create lists for axis properties
    # f1 <- list(
    #   family = "Arial, sans-serif",
    #   size = 18,
    #   color = "blue")
    # 
    # f2 <- list(
    #   family = "Old Standard TT, serif",
    #   size = 14,
    #   color = "green")
    # 
    # axis <- list(
    #   titlefont = f1,
    #   tickfont = f2
    #   #showgrid = F
    # )
    
    scene = list(
      xaxis = list(domain = c(0, 50),
                   title = "Tiempo"),
      yaxis = list(domain = c(0, 200),
                   title = "Maduración (años)"),
      zaxis = list(domain = c(0, 0.12),
                   title = "Rendimiento (%)"),
      camera = list(eye = list(x = -1.25, y = 1.25, z = 1.25))
    )
    
    
    plot_ly(z = Z1,  type = "surface") %>%
      layout(title = "Curva de Rendimientos metodología Diebold-Li",scene = scene)
    
    }else{}
    
    }) #final isolate
    
  })
  
  #vebonos
  output$curva_veb_dl <- renderPlotly({ 
    #agrego dependencia 
    input$boton10
    
    #
    #defino eje maduracion
    X1 <- seq(1,20,0.1)
    
    #defino tiempos
    Y1 <- seq(1,50,1)
    
    #
    var_par <- as.data.frame(matrix(0,length(Y1),4))
    
    #defino spline
    a <- isolate(try(dl_spline_veb()))
    
    if(class(a)!="try-error"){
      isolate(
    #guardo parametros segun cada tiempo
    for(i in 1:length(Y1)){
      #var_par[i,] <- par_dl(t[i],spline1,pa=c(1,1,1,1))
      var_par[i,] <- par_dl(Y1,a,pa=c(1,1,1,1))
      
    }
      )
    #calculo nuevos rendimientos a partir de los nuevos parametros
    new_rend <- as.data.frame(matrix(0,length(X1),length(Y1)))
    
    isolate(
    for(i in 1:length(Y1)){
      
      new_rend[,i] <- diebold_li(as.numeric(var_par[i,]),X1)
      #new_rend[,i] <- nelson_siegel(as.numeric(var_par[i,]),X)
    }
    )
    
    Z1 <- as.matrix(new_rend*100)
    row.names(Z1) <- X1
    colnames(Z1) <- Y1
    
    #defino configuracion de los ejes
    # Create lists for axis properties
    # f1 <- list(
    #   family = "Arial, sans-serif",
    #   size = 18,
    #   color = "blue")
    # 
    # f2 <- list(
    #   family = "Old Standard TT, serif",
    #   size = 14,
    #   color = "green")
    # 
    # axis <- list(
    #   titlefont = f1,
    #   tickfont = f2
    #   #showgrid = F
    # )
    
    scene = list(
      xaxis = list(domain = c(0, 50),
                   title = "Tiempo"),
      yaxis = list(domain = c(0, 200),
                   title = "Maduración (años)"),
      zaxis = list(domain = c(0, 0.12),
                   title = "Rendimiento (%)"),
      camera = list(eye = list(x = -1.25, y = 1.25, z = 1.25))
    )
    
    
    plot_ly(z = Z1,  type = "surface") %>%
      layout(title = "Curva de Rendimientos metodología Diebold-Li",scene = scene)
    
    }else{}
    
    
  })
  
  #Comparativo
  output$curva_veb_dl_comp <- renderPlotly({ 
    #pongo dependencia
    input$boton16
    
    #
    isolate({
    #defino eje maduracion
    X1 <- seq(1,20,0.1)
    
    #defino tiempos
    Y1 <- seq(1,50,1)
    
    #
    var_par <- as.data.frame(matrix(0,length(Y1),4))
    
    #calculo spline
    a <- try(dl_spline_veb_comp())
    
    if(class(a)!="try-error"){
    
    #guardo parametros segun cada tiempo
    for(i in 1:length(Y1)){
      #var_par[i,] <- par_dl(t[i],spline1,pa=c(1,1,1,1))
      var_par[i,] <- par_dl(Y1,a,pa=c(1,1,1,1))
      
    }
    
    #calculo nuevos rendimientos a partir de los nuevos parametros
    new_rend <- as.data.frame(matrix(0,length(X1),length(Y1)))
    
    
    for(i in 1:length(Y1)){
      
      new_rend[,i] <- diebold_li(as.numeric(var_par[i,]),X1)
      #new_rend[,i] <- nelson_siegel(as.numeric(var_par[i,]),X)
    }
    
    Z1 <- as.matrix(new_rend*100)
    row.names(Z1) <- X1
    colnames(Z1) <- Y1
    
    #defino configuracion de los ejes
    # Create lists for axis properties
    # f1 <- list(
    #   family = "Arial, sans-serif",
    #   size = 18,
    #   color = "blue")
    # 
    # f2 <- list(
    #   family = "Old Standard TT, serif",
    #   size = 14,
    #   color = "green")
    # 
    # axis <- list(
    #   titlefont = f1,
    #   tickfont = f2
    #   #showgrid = F
    # )
    
    scene = list(
      xaxis = list(domain = c(0, 50),
                   title = "Tiempo"),
      yaxis = list(domain = c(0, 200),
                   title = "Maduración (años)"),
      zaxis = list(domain = c(0, 0.12),
                   title = "Rendimiento (%)"),
      camera = list(eye = list(x = -1.25, y = 1.25, z = 1.25))
    )
    
    
    plot_ly(z = Z1,  type = "surface") %>%
      layout(title = "Curva de Rendimientos metodología Diebold-Li",scene = scene)
    
    }else{}
    
    }) #final isolate
    
  })
  
  #parametros optimizados
  # output$par_tif_ns_op <- renderPrint({a <- Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = pa_ns,ind = 0,C = C,fe2=input$opt_tif_ns,fe3=0)
  # a[[2]]
  # })
  
  #graficos
  #output$c_tif_ns <- renderPlot({plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=pa_ns)*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Iniciales")})
  #NELSON Y SIEGEL
  #TIF 
  #  output$c_tif_ns <- renderPlot({
  #   ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=nelson_siegel(t=seq(0.1,20,0.1),pa=pa_ns)*100),aes(x=x,y=y))+
  #     geom_line(color="blue")+xlab("Maduración (años)")+
  #     ylab("Rendimiento (%)")+theme_gray()+
  #     ggtitle("Curva de rendimiento Nelson y Siegel Parámetros Iniciales TIF")+
  #     theme(plot.title = element_text(hjust = 0.5))
  #   
  # })
   #
   # output$c_tif_ns1_new <- renderPlot({
   #   ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=nelson_siegel(t=seq(0.1,20,0.1),pa=c(input$ns_b0_tif,input$ns_b1_tif,input$ns_b2_tif,input$ns_t_tif))*100),aes(x=x,y=y))+
   #     geom_line(color="brown")+xlab("Maduración (años)")+
   #     ylab("Rendimiento (%)")+theme_gray()+
   #     ggtitle("Curva de rendimiento Nelson y Siegel Parámetros elegidos TIF")+
   #     theme(plot.title = element_text(hjust = 0.5))
   # })
   #comparativo
   output$c_tif_ns1_new_comp <- renderPlotly({
     #take dependency
     input$boton5
     
     #
     isolate({
     
     a <- ggplot(cbind.data.frame(plazo=seq(0.9,20,0.1),rendimiento=nelson_siegel(t=seq(0.9,20,0.1),pa=c(input$ns_b0_tif_comp,input$ns_b1_tif_comp,input$ns_b2_tif_comp,input$ns_t_tif_comp))*100),aes(x=plazo,y=rendimiento))+
       geom_line(color="blue")+xlab("Maduración (años)")+
       ylab("Rendimiento (%)")+theme_gray()+
       ggtitle("Curva de rendimiento Nelson y Siegel Parámetros elegidos TIF")+
       theme(plot.title = element_text(hjust = 0.5))
     
     ggplotly(a)
     })
   })
   
   
   #
   # output$c_veb_ns1_new <- renderPlot({
   #   ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=nelson_siegel(t=seq(0.1,20,0.1),pa=c(input$ns_b0_veb,input$ns_b1_veb,input$ns_b2_veb,input$ns_t_veb))*100),aes(x=x,y=y))+
   #     geom_line(color="brown")+xlab("Maduración (años)")+
   #     ylab("Rendimiento (%)")+theme_gray()+
   #     ggtitle("Curva de rendimiento Nelson y Siegel Parámetros elegidos VEBONO")+
   #     theme(plot.title = element_text(hjust = 0.5))
   # })
   
   #comparativo
   output$c_veb_ns1_new_comp <- renderPlotly({
     #take dependency
     input$boton7
     
     #
     isolate({
     a <- ggplot(cbind.data.frame(plazo=seq(0.9,20,0.1),rendimiento=nelson_siegel(t=seq(0.9,20,0.1),pa=c(input$ns_b0_veb_comp,input$ns_b1_veb_comp,input$ns_b2_veb_comp,input$ns_t_veb_comp))*100),aes(x=plazo,y=rendimiento))+
       geom_line(color="blue")+xlab("Maduración (años)")+
       ylab("Rendimiento (%)")+theme_gray()+
       ggtitle("Curva de rendimiento Nelson y Siegel Parámetros elegidos VEBONO")+
       theme(plot.title = element_text(hjust = 0.5))
    
     ggplotly(a)
      })
   })
   
   
  #
  # output$c_veb_ns <- renderPlot({
  #   ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=nelson_siegel(t=seq(0.1,20,0.1),pa=pa1_ns)*100),aes(x=x,y=y))+
  #     geom_line(color="blue")+xlab("Maduración (años)")+
  #     ylab("Rendimiento (%)")+theme_gray()+
  #     ggtitle("Curva de rendimiento Nelson y Siegel Parámetros Iniciales VEBONOS")+
  #     theme(plot.title = element_text(hjust = 0.5))
  #   
  # })
  
  #SVENSSON
  # output$c_tif_sven <- renderPlot({
  #   ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=sven(t=seq(0.1,20,0.1),pa=pa_sven)*100),aes(x=x,y=y))+
  #     geom_line(color="blue")+xlab("Maduración (años)")+
  #     ylab("Rendimiento (%)")+theme_gray()+
  #     ggtitle("Curva de rendimiento Svensson Parámetros Iniciales TIF")+
  #     theme(plot.title = element_text(hjust = 0.5))
  #   
  # })
  #
  # output$c_veb_sven <- renderPlot({
  #   ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=sven(t=seq(0.1,20,0.1),pa=pa1_sven)*100),aes(x=x,y=y))+
  #     geom_line(color="blue")+xlab("Maduración (años)")+
  #     ylab("Rendimiento (%)")+theme_gray()+
  #     ggtitle("Curva de rendimiento Svensson Parámetros Iniciales VEBONOS")+
  #     theme(plot.title = element_text(hjust = 0.5))
  #   
  # })
  
  #
  # output$c_tif_sven_new <- renderPlot({
  #   ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=sven(t=seq(0.1,20,0.1),pa=c(input$sven_b0_tif,input$sven_b1_tif,input$sven_b2_tif,input$sven_b3_tif,input$sven_t1_tif,input$sven_t2_tif))*100),aes(x=x,y=y))+
  #     geom_line(color="brown")+xlab("Maduración (años)")+
  #     ylab("Rendimiento (%)")+theme_gray()+
  #     ggtitle("Curva de rendimiento Nelson y Siegel Parámetros elegidos TIF")+
  #     theme(plot.title = element_text(hjust = 0.5))
  # })
  
  #comparativo
  output$c_tif_sven_new_comp <- renderPlotly({
    #take dependency
    input$boton6
    
    #
    isolate({
    a <- ggplot(cbind.data.frame(plazo=seq(0.9,20,0.1),rendimiento=sven(t=seq(0.9,20,0.1),pa=c(input$sven_b0_tif_comp,input$sven_b1_tif_comp,input$sven_b2_tif_comp,input$sven_b3_tif_comp,input$sven_t1_tif_comp,input$sven_t2_tif_comp))*100),aes(x=plazo,y=rendimiento))+
      geom_line(color="blue")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de rendimiento Svensson Parámetros elegidos TIF")+
      theme(plot.title = element_text(hjust = 0.5))
    
    ggplotly(a)
    })
  })
  
  #
  # output$c_veb_sven_new <- renderPlot({
  #   ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=sven(t=seq(0.1,20,0.1),pa=c(input$sven_b0_veb,input$sven_b1_veb,input$sven_b2_veb,input$sven_b3_veb,input$sven_t1_veb,input$sven_t2_veb))*100),aes(x=x,y=y))+
  #     geom_line(color="brown")+xlab("Maduración (años)")+
  #     ylab("Rendimiento (%)")+theme_gray()+
  #     ggtitle("Curva de rendimiento Svensson Parámetros elegidos VEBONOS")+
  #     theme(plot.title = element_text(hjust = 0.5))
  # })
  
  #comparativo
  output$c_veb_sven_new_comp <- renderPlotly({
    #take dependency
    input$boton8
    
    #
    isolate({
    a <- ggplot(cbind.data.frame(plazo=seq(0.9,20,0.1),rendimiento=sven(t=seq(0.9,20,0.1),pa=c(input$sven_b0_veb_comp,input$sven_b1_veb_comp,input$sven_b2_veb_comp,input$sven_b3_veb_comp,input$sven_t1_veb_comp,input$sven_t2_veb_comp))*100),aes(x=plazo,y=rendimiento))+
      geom_line(color="blue")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de rendimiento Svensson Parámetros elegidos VEBONOS")+
      theme(plot.title = element_text(hjust = 0.5))
    
    ggplotly(a)
    })
  })
  
  #caso Nelson y Siegel
  #gra_tif_ns <- reactive({Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = c(1,1,1,1),ind = 0,C = C,fe2=input$opt_tif_ns,fe3=0)[[2]] })
  # gra_tif_ns <- reactive({
  #   a <- try(Tabla.ns(fv = input$n2 ,tit = ns1(),pr =TF_NS() ,pa = c(1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_tif_ns,fe3=0)[[2]])
  #   if(class(a)!="try-error"){return(a)}else{}
  #   })
  
  # gra_veb_ns <- reactive({
  #   a <- try(Tabla.ns(fv = input$n2 ,tit = ns2(),pr =TV_NS() ,pa = c(1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_veb_ns,fe3=0)[[2]])
  #   if(class(a)!="try-error"){return(a)}else{}
  #   })
  

  # output$par_tif_ns_op<-renderPrint({if(input$opt_tif_ns==1){gra_tif_ns()
  # }else{}})
  
  #comparativo
  gra_tif_ns_comp <- reactive({
    a <- try(Tabla.ns(fv = input$n5 ,tit = comp1(),pr =TF_NSC() ,pa = c(1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_tif_ns_comp,fe3=0)[[2]])
    if(class(a)!="try-error"){return(a)}else{}
    
    })
  
  
  output$par_tif_ns_op_comp<-renderPrint({
    #pongo dependencia
    input$boton_5
    
    #
    isolate({
    if(input$opt_tif_ns_comp==1){gra_tif_ns_comp()
  }else{return("No se optimizará")}
    }) #final isolate
      
      })
  
  
  # output$c_tif_ns_op <- renderPlot({if(input$opt_tif_ns==1){
  #   #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
  #   ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=nelson_siegel(t=seq(0.1,20,0.1),pa=gra_tif_ns())*100),aes(x=x,y=y))+
  #     geom_line(color="green")+xlab("Maduración (años)")+
  #     ylab("Rendimiento (%)")+theme_gray()+
  #     ggtitle("Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")+
  #     theme(plot.title = element_text(hjust = 0.5))
  #   }else{}})
  # output$c_tif_ns_op <- renderPlot({if(input$opt_tif_ns==1){
  #   a <- try(cbind.data.frame(x=seq(0.1,20,0.1),y=nelson_siegel(t=seq(0.1,20,0.1),pa=gra_tif_ns())*100))
  #   if(class(a)!="try-error"){
  #     #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
  #     ggplot(a,aes(x=x,y=y))+
  #       geom_line(color="green")+xlab("Maduración (años)")+
  #       ylab("Rendimiento (%)")+theme_gray()+
  #       ggtitle("Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")+
  #       theme(plot.title = element_text(hjust = 0.5))
  #   }else{}
  # }else{}})
  
  #comparativo
  output$c_tif_ns_op_comp <- renderPlotly({
    #pongo dependencia
    input$boton_5
    
    #
    isolate({
    
    if(input$opt_tif_ns_comp==1){
    #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
    a <- ggplot(cbind.data.frame(plazo=seq(0.9,20,0.1),rendimiento=nelson_siegel(t=seq(0.9,20,0.1),pa=gra_tif_ns_comp())*100),aes(x=plazo,y=rendimiento))+
      geom_line(color="blue")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")+
      theme(plot.title = element_text(hjust = 0.5))
    ggplotly(a)
    
  }else{}
    }) #final isolate
      
      })
  
  
  #
  # output$par_veb_ns_op<-renderPrint({if(input$opt_veb_ns==1){gra_veb_ns()
  # }else{}})

  # output$c_veb_ns_op <- renderPlot({if(input$opt_veb_ns==1){
  #   #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
  #   a <- try(cbind.data.frame(x=seq(0.1,20,0.1),y=nelson_siegel(t=seq(0.1,20,0.1),pa=gra_tif_ns())*100))
  #   if(class(a)!="try-error"){
  #     ggplot(a,aes(x=x,y=y))+
  #       geom_line(color="green")+xlab("Maduración (años)")+
  #       ylab("Rendimiento (%)")+theme_gray()+
  #       ggtitle("Curva de redimientos Nelson y Siegel Parametros Optimizados VEBONOS")+
  #       theme(plot.title = element_text(hjust = 0.5))
  #   }else{}
  # }else{}})
  
  #comparativo
  gra_veb_ns_comp <- reactive({
    a <- try(Tabla.ns(fv = input$n5 ,tit = comp2(),pr =TV_NSC() ,pa = c(1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_veb_ns_comp,fe3=0)[[2]] )
    if(class(a)!="try-error"){return(a)}else{}
    
    })
  
  
  output$par_veb_ns_op_comp<-renderPrint({
    #pongo dependencia
    input$boton_6
    
    #
    isolate({
    if(input$opt_veb_ns_comp==1){gra_veb_ns_comp()
  }else{return("No se optimizará")}
    }) #final isolate
      
      })
  
  output$c_veb_ns_op_comp <- renderPlotly({
    #pongo dependencia
    input$boton_6
    
    #
    isolate({
    
    if(input$opt_veb_ns_comp==1){
    #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
    a <- ggplot(cbind.data.frame(plazo=seq(0.9,20,0.1),rendimiento=nelson_siegel(t=seq(0.9,20,0.1),pa=gra_veb_ns_comp())*100),aes(x=plazo,y=rendimiento))+
      geom_line(color="blue")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de redimientos Nelson y Siegel Parametros Optimizados VEBONOS")+
      theme(plot.title = element_text(hjust = 0.5))
    
    ggplotly(a)
  }else{}
    }) #final isolate
      
      })
  
  #caso Svensson
  # gra_tif_sven <- reactive({
  #   a <- try(Tabla.sven(fv = input$n1 ,tit = sv1(),pr =TF() ,pa = c(1,1,1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_tif_sven,fe3=0)[[2]])
  #   if(class(a)!="try-error"){return(a)}else{}
  #   
  #   })
  # gra_veb_sven <- reactive({
  #   a <- try(Tabla.sven(fv = input$n1 ,tit = sv2(),pr =TV() ,pa = c(1,1,1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_veb_sven,fe3=0)[[2]])
  #   if(class(a)!="try-error"){return(a)}else{}
  #   
  #   })
  
  #tif
  # output$par_tif_sven_op<-renderPrint({if(input$opt_tif_sven==1){gra_tif_sven()
  # }else{}})
  
  #
  # output$c_tif_sven_op <- renderPlot({if(input$opt_tif_sven==1){
  #   #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
  #   a <- try(cbind.data.frame(x=seq(0.1,20,0.1),y=sven(t=seq(0.1,20,0.1),pa=gra_tif_sven())*100))
  #   
  #   if(class(a)!="try-error"){
  #   ggplot(a,aes(x=x,y=y))+
  #     geom_line(color="green")+xlab("Maduración (años)")+
  #     ylab("Rendimiento (%)")+theme_gray()+
  #     ggtitle("Curva de redimientos Svensson Parametros Optimizados TIF")+
  #     theme(plot.title = element_text(hjust = 0.5))
  #   }else{}
  # }else{}})
  
  #comparativo
  gra_tif_sven_comp <- reactive({
    a <- try(Tabla.sven(fv = input$n5 ,tit = comp1(),pr =TF_SV() ,pa = c(1,1,1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_tif_sven_comp,fe3=0)[[2]])
    if(class(a)!="try-error"){return(a)}else{}
    
    })
  gra_veb_sven_comp <- reactive({
    a <- try(Tabla.sven(fv = input$n5 ,tit = comp2(),pr =TV_SV() ,pa = c(1,1,1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_veb_sven_comp,fe3=0)[[2]])
    if(class(a)!="try-error"){return(a)}else{}
    
    })
  
  #tif
  output$par_tif_sven_op_comp<-renderPrint({
    #pongo dependencia
    input$boton_7
    
    #
    isolate({
    if(input$opt_tif_sven_comp==1){gra_tif_sven_comp()
  }else{return("No se optimizará")}
    }) #final isolate
    })
  
  #
  output$c_tif_sven_op_comp <- renderPlotly({
    #pongo dependencia
    input$boton_7
    
    #
    isolate({
    if(input$opt_tif_sven_comp==1){
    #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
    a <- ggplot(cbind.data.frame(plazo=seq(0.9,20,0.1),rendimiento=sven(t=seq(0.9,20,0.1),pa=gra_tif_sven_comp())*100),aes(x=plazo,y=rendimiento))+
      geom_line(color="blue")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de redimientos Svensson Parametros Optimizados TIF")+
      theme(plot.title = element_text(hjust = 0.5))
    
    ggplotly(a)
  }else{}
      
    }) #final isolate
      })
  
  #veb
  # output$par_veb_sven_op<-renderPrint({if(input$opt_veb_sven==1){gra_veb_sven()
  # }else{}})
  
  #
  # output$c_veb_sven_op <- renderPlot({if(input$opt_veb_sven==1){
  #   #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
  #   a <- try(cbind.data.frame(x=seq(0.1,20,0.1),y=sven(t=seq(0.1,20,0.1),pa=gra_veb_sven())*100))
  #   
  #   if(class(a)!="try-error"){
  #   ggplot(a,aes(x=x,y=y))+
  #     geom_line(color="green")+xlab("Maduración (años)")+
  #     ylab("Rendimiento (%)")+theme_gray()+
  #     ggtitle("Curva de redimientos Svensson Parametros Optimizados VEBONOS")+
  #     theme(plot.title = element_text(hjust = 0.5))
  #   }else{}
  # }else{}})
  
  #comparativo
  output$par_veb_sven_op_comp<-renderPrint({
    #pongo dependencia
    input$boton_8
    
    #
    isolate({
    if(input$opt_veb_sven_comp==1){gra_veb_sven_comp()
  }else{return("No se optimizará")}
    }) #final isolate
      
      })
  
  #
  output$c_veb_sven_op_comp <- renderPlotly({
    #pongo dependencia
    input$boton_8
    
    #
    isolate({
    if(input$opt_veb_sven_comp==1){
    #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
    a <- ggplot(cbind.data.frame(plazo=seq(0.9,20,0.1),rendimiento=sven(t=seq(0.9,20,0.1),pa=gra_veb_sven_comp())*100),aes(x=plazo,y=rendimiento))+
      geom_line(color="blue")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de redimientos Svensson Parametros Optimizados VEBONOS")+
      theme(plot.title = element_text(hjust = 0.5))
    
    ggplotly(a)
  }else{}
    }) #final isolate
      
      })
  
  #SPLINES
  #tif
  output$dias_tif <- renderPrint({input$d_tif})
  output$spar_tif <- renderPrint({input$parametro_tif})
  
  #comparativo
  output$dias_tif_comp <- renderPrint({input$d_tif_comp})
  output$spar_tif_comp <- renderPrint({input$parametro_tif_comp})
  
  #veb
  output$dias_veb <- renderPrint({input$d_veb})
  output$spar_veb <- renderPrint({input$parametro_veb})
  
  #comparativo
  output$dias_veb_comp <- renderPrint({input$d_veb_comp})
  output$spar_veb_comp <- renderPrint({input$parametro_veb_comp})
  
  
  #precios
  #output$pre_sp_tif <- renderDataTable({Tabla.splines(data = data_splines,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),C_splines,pr=tf_sp())[[5]] })
  output$pre_sp_tif <- DT::renderDataTable({
    #Tabla.splines(data = data_splines,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),C_splines,pr=tf_sp())[[5]] 
    #  dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    #  dat[,3] <- as.Date(as.character(dat[,3]))
    #  car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # # #print(str(data_splines))
    # #print(str(dat))
     #Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())[[5]]
    #agrego dependencia 
    input$boton11
    
    #
    a <- isolate(try(tabla_sp_tif()))
    if(class(a)!="try-error"){
      isolate(DT::datatable(a[[5]], options = list(paging = FALSE)))
    }else{}
     # 
    
    })
  
  #output$pre_sp <- renderPrint({precio_diario_sp(fe=input$n4,num=input$d_tif,par =input$parametro_tif ,datatif =datatif ,tit =tf_sp() ,C=C_splines,letra=c(97,1.34)) })
  output$pre_sp_veb <- DT::renderDataTable({
    #Tabla.splines(data = data_splines,tipo = "VEBONO",fe=input$n4,num = input$d_veb,par = input$parametro_veb,tit=c(input$v1_sp,input$v2_sp,input$v3_sp),C_splines,pr=tv_sp())[[5]] 
     # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
     # dat[,3] <- as.Date(as.character(dat[,3]))
     # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
     # 
     # Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n4,num = input$d_veb,par = input$parametro_veb,tit=c(input$v1_sp,input$v2_sp,input$v3_sp),car,pr=tv_sp())[[5]] 
     # 
    #pongo dependencia
    input$boton13
    
    #
    #isolate({
    a <- isolate(try(tabla_sp_veb()))
    
    if(class(a)!="try-error"){
      isolate(DT::datatable(a[[5]], options = list(paging = FALSE)))
    }else{}
    
    #}) #final isolate
      
    })
  
  #comparativo
  #tif
  output$pre_sp_tif_comp <- DT::renderDataTable({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # Tabla.splines(data = dat,tipo = "TIF",fe=input$n5,num = input$d_tif_comp,par = input$parametro_tif_comp,tit=c(input$t1_comp,input$t2_comp,input$t3_comp),car,pr=tf_comp())[[5]] 
    #pongo dependencia
    input$boton17
    
    #
    isolate({
    
     a <- try(tabla_sp_tif_comp()[[5]])
    if(class(a)!="try-error"){
      DT::datatable(a, options = list(paging = FALSE))
    }else{}
     
    }) #final isolate
      
    })

  #veb
  output$pre_sp_veb_comp <- DT::renderDataTable({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num = input$d_veb_comp,par = input$parametro_veb_comp,tit=c(input$v1_comp,input$v2_comp,input$v3_comp),car,pr=tv_comp())[[5]] 
    #pongo dependencia
    input$boton19
    
    #
    isolate({
    
    a <- try(tabla_sp_veb_comp()[[5]])
    if(class(a)!="try-error"){
      DT::datatable(a, options = list(paging = FALSE))
      }else{}
    }) #final isolate
    
    })
  
  
  
  #curva de rendimiento
  #tif
  output$c_tif_splines <- renderRbokeh({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # 
    # y <-predict(Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())[[4]],seq(0.1,20,0.1)*365)$y
    #agrego dependencia 
    input$boton11
    
    a <- isolate(try(tabla_sp_tif()))
    
    if(class(a)!="try-error"){
    y <-predict(a[[4]],seq(0.1,20,0.1)*365)$y
    
    # f <- ggplot(cbind.data.frame(x=seq(1,20,0.1)*365,y),aes(x=x,y=y))+
    #   geom_line(color="black")+
    #   geom_point(data = pto_sp_tif(),aes(x=pto_sp_tif()[,1],y=pto_sp_tif()[,2]),color="blue",size=3)+
    #   xlab("Maduración (días)")+
    #   ylab("Rendimiento (%)")+theme_gray()+
    #   ggtitle("Curva de redimientos Splines TIF ")+
    #   theme(plot.title = element_text(hjust = 0.5))
    #   
    # 
    # ggplotly(f) 
    
    #letra <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())[[3]]
    letra <- a[[3]]
    
    #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
  
     #names(letra1)=names(a[[2]])
     
    #condicional letra
    if(is.null(names(letra))){
      #print(letra)
      letra0 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
      letra0[,2] <- as.Date(letra0[,2])
      letra0[,3] <- as.Date(letra0[,3])
      #cand <- a[[2]]
      
      #names(letra0)=names(cand)
      
      #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    }else{
      letra[,6] <- as.Date(letra[,6])
      letra0 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      #cand <- a[[2]]
      
      #names(letra0)=names(cand)
      
      #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      
    }
    
    names(letra0)=names(a[[2]])
    
      isolate(
      figure(width = 1000,height = 400) %>%
      #ly_points(c(letra[,7],a[[2]][,4]),c(letra[,15],a[[2]][,7]),rbind.data.frame(letra1,a[[2]]),hover=list("Nombre"=c(as.character(letra[,2]),as.character(a[[2]][,1])),"Fecha de operación"=c(letra[,3],a[[2]][,2]))) %>%
        ly_points(c(letra0[,4],a[[2]][,4]),c(letra0[,7],a[[2]][,7]),rbind.data.frame(letra0,a[[2]]),hover=list("Nombre"=c(as.character(letra0[,1]),as.character(a[[2]][,1])),"Fecha de operación"=c(letra0[,2],a[[2]][,2]))) %>%
        ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="blue",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
      # theme_title(text_color="green",text_align="center",text_font_style="italic")%>%
      x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)")
      )
    }else{}
  })

  #comparativo
  output$c_tif_splines_comp <- renderRbokeh({
    #y <-predict(tabla_sp_tif_comp()[[4]],seq(0.1,20,0.1)*365)$y
    
    
    #figure(width = 1000,height = 400) %>%
     # ly_points(pto_sp_tif_comp()[,4],pto_sp_tif_comp()[,7],pto_sp_tif_comp(),hover=list("Nombre"=pto_sp_tif_comp()[,1],"Fecha de operación"=pto_sp_tif_comp()[,2])) %>%
      #ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="blue",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
      # theme_title(text_color="green",text_align="center",text_font_style="italic")%>%
      #x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
    #pongo dependencia
    input$boton17
    
    #
    isolate({
    a <- try(tabla_sp_tif_comp())
    
    if(class(a)!="try-error"){
    y <-predict(a[[4]],seq(0.1,20,0.1)*365)$y
    
    
    #letra <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())[[3]]
    letra <- a[[3]]
    #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    
    # names(letra1)=names(pto_sp_tif())
    # 
    # figure(width = 1000,height = 400) %>%
    #   ly_points(c(letra[,7],pto_sp_tif()[,4]),c(letra[,15],pto_sp_tif()[,7]),rbind.data.frame(letra1,pto_sp_tif()),hover=list("Nombre"=c(as.character(letra[,2]),as.character(pto_sp_tif()[,1])),"Fecha de operación"=c(letra[,3],pto_sp_tif()[,2]))) %>%
    
    #names(letra1)=names(a[[2]])
    
    #condicional letra
    if(is.null(names(letra))){
      #print(letra)
      letra0 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
      letra0[,2] <- as.Date(letra0[,2])
      letra0[,3] <- as.Date(letra0[,3])
      #cand <- a[[2]]
      
      #names(letra0)=names(cand)
      
      #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    }else{
      letra[,6] <- as.Date(letra[,6])
      letra0 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      #cand <- a[[2]]
      
      #names(letra0)=names(cand)
      
      #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      
    }
    
    names(letra0)=names(a[[2]])
    
    
    
    figure(width = 1000,height = 400) %>%
      #ly_points(c(letra[,7],a[[2]][,4]),c(letra[,15],a[[2]][,7]),rbind.data.frame(letra1,a[[2]]),hover=list("Nombre"=c(as.character(letra[,2]),as.character(a[[2]][,1])),"Fecha de operación"=c(letra[,3],a[[2]][,2]))) %>%
      ly_points(c(letra0[,4],a[[2]][,4]),c(letra0[,7],a[[2]][,7]),rbind.data.frame(letra0,a[[2]]),hover=list("Nombre"=c(as.character(letra0[,1]),as.character(a[[2]][,1])),"Fecha de operación"=c(letra0[,2],a[[2]][,2]))) %>%
      ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="blue",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
      # theme_title(text_color="green",text_align="center",text_font_style="italic")%>%
      x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
    
    }else{}
    
    }) #final isolate
  })
  
  #veb
  output$c_veb_splines <- renderRbokeh({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # 
    # y <-predict(Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n4,num = input$d_veb,par = input$parametro_veb,tit=c(input$v1_sp,input$v2_sp,input$v3_sp),car,pr=tv_sp())[[4]],seq(0.1,20,0.1)*365)$y
    #pongo dependencia
    input$boton13
    
    #
    #isolate({
    
    a <- isolate(try(tabla_sp_veb()))
    
    if(class(a)!="try-error"){
    y <-predict(a[[4]],seq(0.1,20,0.1)*365)$y
    
    
    # f <- ggplot(cbind.data.frame(x=seq(1,20,0.1)*365,y),aes(x=x,y=y))+
    #   geom_line(color="black")+
    #   geom_point(data = pto_sp_veb(),aes(x=pto_sp_veb()[,1],y=pto_sp_veb()[,2]),color="blue",size=3)+
    #   xlab("Maduración (días)")+
    #   ylab("Rendimiento (%)")+theme_gray()+
    #   ggtitle("Curva de redimientos Splines VEBONO ")+
    #   theme(plot.title = element_text(hjust = 0.5))
    # 
    # 
    # ggplotly(f) 
    # %>%
    #   add_markers(text= ~  pto_sp_tif()[,1],hoverinfo = "text")
    # figure(width = 1000,height = 400) %>%
    #   ly_points(pto_sp_veb()[,4],pto_sp_veb()[,7],pto_sp_veb(),hover=list("Nombre"=pto_sp_veb()[,1],"Fecha de operación"=pto_sp_veb()[,2])) %>%
    #   ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="blue",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
    #   # theme_title(text_color="green",text_align="center",text_font_style="italic")%>%
    #   x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
    # 
    
    letra <- a[[3]]
    #condicional letra
    if(is.null(names(letra))){
      #print(letra)
      letra0 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
      letra0[,2] <- as.Date(letra0[,2])
      letra0[,3] <- as.Date(letra0[,3])
      #cand <- a[[2]]
      
      #names(letra0)=names(cand)
      
      #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    }else{
      letra[,6] <- as.Date(letra[,6])
      letra0 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      #cand <- a[[2]]
      
      #names(letra0)=names(cand)
      
      #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")

    }
    
    #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    
    # names(letra1)=names(pto_sp_tif())
    # 
    # figure(width = 1000,height = 400) %>%
    #   ly_points(c(letra[,7],pto_sp_tif()[,4]),c(letra[,15],pto_sp_tif()[,7]),rbind.data.frame(letra1,pto_sp_tif()),hover=list("Nombre"=c(as.character(letra[,2]),as.character(pto_sp_tif()[,1])),"Fecha de operación"=c(letra[,3],pto_sp_tif()[,2]))) %>%
    
    names(letra0)=names(a[[2]])
    
    isolate(
    figure(width = 1000,height = 400) %>%
      #ly_points(c(letra[,7],a[[2]][,4]),c(letra[,15],a[[2]][,7]),rbind.data.frame(letra1,a[[2]]),hover=list("Nombre"=c(as.character(letra[,2]),as.character(a[[2]][,1])),"Fecha de operación"=c(letra[,3],a[[2]][,2]))) %>%
      ly_points(c(letra0[,4],a[[2]][,4]),c(letra0[,7],a[[2]][,7]),rbind.data.frame(letra0,a[[2]]),hover=list("Nombre"=c(as.character(letra0[,1]),as.character(a[[2]][,1])),"Fecha de operación"=c(letra0[,2],a[[2]][,2]))) %>%
      ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="blue",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
      ## theme_title(text_color="green",text_align="center",text_font_style="italic")%>%
      x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
    )
    
    }else{}
    
   # }) #final isolate
    
  })
  
  #comparativo
  output$c_veb_splines_comp <- renderRbokeh({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # y <-predict(Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num = input$d_veb_comp,par = input$parametro_veb_comp,tit=c(input$v1_comp,input$v2_comp,input$v3_comp),car,pr=tv_comp())[[4]],seq(0.1,20,0.1)*365)$y
    #pongo dependencia
    input$boton19
    
    #
    isolate({
    
    a <- try(tabla_sp_veb_comp())
    
    if(class(a)!="try-error"){
    y <-predict(a[[4]],seq(0.1,20,0.1)*365)$y
    
    
    #letra <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())[[3]]
    letra <- a[[3]]
    
    #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    
    # names(letra1)=names(pto_sp_tif())
    # 
    # figure(width = 1000,height = 400) %>%
    #   ly_points(c(letra[,7],pto_sp_tif()[,4]),c(letra[,15],pto_sp_tif()[,7]),rbind.data.frame(letra1,pto_sp_tif()),hover=list("Nombre"=c(as.character(letra[,2]),as.character(pto_sp_tif()[,1])),"Fecha de operación"=c(letra[,3],pto_sp_tif()[,2]))) %>%
    
    #names(letra1)=names(a[[2]])
    #condicional letra
    if(is.null(names(letra))){
      #print(letra)
      letra0 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
      letra0[,2] <- as.Date(letra0[,2])
      letra0[,3] <- as.Date(letra0[,3])
      #cand <- a[[2]]
      
      #names(letra0)=names(cand)
      
      #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    }else{
      letra[,6] <- as.Date(letra[,6])
      letra0 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      #cand <- a[[2]]
      
      #names(letra0)=names(cand)
      
      #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      
    }
    
    names(letra0)=names(a[[2]])
    
    
    
    figure(width = 1000,height = 400) %>%
      #ly_points(c(letra[,7],a[[2]][,4]),c(letra[,15],a[[2]][,7]),rbind.data.frame(letra1,a[[2]]),hover=list("Nombre"=c(as.character(letra[,2]),as.character(a[[2]][,1])),"Fecha de operación"=c(letra[,3],a[[2]][,2]))) %>%
      ly_points(c(letra0[,4],a[[2]][,4]),c(letra0[,7],a[[2]][,7]),rbind.data.frame(letra0,a[[2]]),hover=list("Nombre"=c(as.character(letra0[,1]),as.character(a[[2]][,1])),"Fecha de operación"=c(letra0[,2],a[[2]][,2]))) %>%
      ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="blue",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
      # theme_title(text_color="green",text_align="center",text_font_style="italic")%>%
      x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)")  
    
    }else{}
    
    }) #final isolate
  })
  
  #titulos candidatos
  #funcion que calcula una sola vez valores de funcion "Tabla Spline"
  #TIF
  tabla_sp_tif <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=sp1(),car,pr=tf_sp())
    return(a)
  })
  
  #VEBONOS
  tabla_sp_veb <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    a <- Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n4,num = input$d_veb,par = input$parametro_veb,tit=sp2(),car,pr=tv_sp())
    return(a)
  })
  
  
  #tif
  output$tit_cand_tif <- DT::renderDataTable({
    #Tabla.splines(data = data_splines,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),C_splines,pr=tf_sp())[[2]]
     # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
     # dat[,3] <- as.Date(as.character(dat[,3]))
     # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    #return(car)
     # #print(str(data_splines))
    # #print(str(dat))
     #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())
    #agrego dependencia 
    input$boton11 
    
    #
    a <- isolate(try(tabla_sp_tif()))
     
     if(class(a)!="try-error"){
     letra <- a[[3]]
     
     #letra[,6] <- as.Date(letra[,6])
     #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
     #cand <- a[[2]]
     
     
     #names(letra1)=names(cand)
     
     #a1 <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
     #return(a1)
     #condicional letra
     if(is.null(names(letra))){
       #print(letra)
       letra1 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
       letra1[,2] <- as.Date(letra1[,2])
       letra1[,3] <- as.Date(letra1[,3])
       cand <- a[[2]]
       
       names(letra1)=names(cand)
       
       a1 <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
       return(a1)
     }else{
       letra[,6] <- as.Date(letra[,6])
       letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
       cand <- a[[2]]
       
       names(letra1)=names(cand)
       
       a1 <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
       return(a1)
       
     }
     
     }else{
       Aviso <- "Poca cantidad de observaciones, favor seleccionar mas días"
       return(as.data.frame(Aviso))
     }
     #Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())[[2]]
    
     })
  
  #comparativo
  #creo funcion para llamar una sola vez a la funcion splines
  tabla_sp_tif_comp <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    Tabla.splines(data = dat,tipo = "TIF",fe=input$n5,num = input$d_tif_comp,par = input$parametro_tif_comp,tit=comp1(),car,pr=tf_comp())
  })
  
  
  output$tit_cand_tif_comp <- DT::renderDataTable({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # Tabla.splines(data = dat,tipo = "TIF",fe=input$n5,num = input$d_tif_comp,par = input$parametro_tif_comp,tit=c(input$t1_comp,input$t2_comp,input$t3_comp),car,pr=tf_comp())[[2]] 
    
    #pongo dependencia
    input$boton17
    
    #
    isolate({
    a <- try(tabla_sp_tif_comp())
    
    if(class(a)!="try-error"){
    
    letra <- a[[3]]
    
    #letra[,6] <- as.Date(letra[,6])
    #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    #cand <- a[[2]]
    
    #names(letra1)=names(cand)
    
    #a1 <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
    #return(a1)
    #condicional letra
    if(is.null(names(letra))){
      #print(letra)
      letra1 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
      letra1[,2] <- as.Date(letra1[,2])
      letra1[,3] <- as.Date(letra1[,3])
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a1 <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      return(a1)
    }else{
      letra[,6] <- as.Date(letra[,6])
      letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a1 <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      return(a1)
      
    }
    
    
    }else{
      Aviso <- "Poca cantidad de observaciones, favor seleccionar mas días"
      return(as.data.frame(Aviso))
    }
  
    }) #final isolate
    })
  
  
  #veb
  output$tit_cand_veb <- DT::renderDataTable({
    #Tabla.splines(data = data_splines,tipo = "VEBONO",fe=input$n4,num = input$d_veb,par = input$parametro_veb,tit=c(input$v1_sp,input$v2_sp,input$v3_sp),C_splines,pr=tv_sp())[[2]] 
     # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
     # dat[,3] <- as.Date(as.character(dat[,3]))
     # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
     # 
     # Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n4,num = input$d_veb,par = input$parametro_veb,tit=c(input$v1_sp,input$v2_sp,input$v3_sp),car,pr=tv_sp())[[2]] 
     # 
    #pongo dependencia
    input$boton13
    
    #
    #isolate({
    a <- isolate(try(tabla_sp_veb()))
    
    if(class(a)!="try-error"){
      
    letra <- a[[3]]
    #condicional letra
    if(is.null(names(letra))){
      #print(letra)
      letra1 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
      letra1[,2] <- as.Date(letra1[,2])
      letra1[,3] <- as.Date(letra1[,3])
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a1 <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      return(a1)
    }else{
      letra[,6] <- as.Date(letra[,6])
      letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a1 <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      return(a1)
      
      }
    
    
    }else{
      Aviso <- "Poca cantidad de observaciones, favor seleccionar mas días"
      return(as.data.frame(Aviso))
    }
    #}) #final isolate
    
    })
  
  #comparativo
  #creo funcion auxiliar para llamar una sola vez a funcion splines
  tabla_sp_veb_comp <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num = input$d_veb_comp,par = input$parametro_veb_comp,tit=comp2(),car,pr=tv_comp()) 
  })
  
  output$tit_cand_veb_comp <- DT::renderDataTable({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num = input$d_veb_comp,par = input$parametro_veb_comp,tit=c(input$v1_comp,input$v2_comp,input$v3_comp),car,pr=tv_comp())[[2]] 
    #tabla_sp_veb_comp()[[2]]
    #pongo dependencia
    input$boton19
    
    #
    isolate({
    
    a <- try(tabla_sp_veb_comp())
    
    if(class(a)!="try-error"){
    letra <- a[[3]]
    
    #letra[,6] <- as.Date(letra[,6])
    #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    #cand <- a[[2]]
    
    #names(letra1)=names(cand)
    
    #a1 <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
    #return(a1)
    #condicional letra
    if(is.null(names(letra))){
      #print(letra)
      letra1 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
      letra1[,2] <- as.Date(letra1[,2])
      letra1[,3] <- as.Date(letra1[,3])
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a1 <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      return(a1)
    }else{
      letra[,6] <- as.Date(letra[,6])
      letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a1 <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      return(a1)
      
    }
    
    
    }else{
      Aviso <- "Poca cantidad de observaciones, favor seleccionar mas días"
      return(as.data.frame(Aviso))
    }
    }) #final isolate
    })
  
  
  
  #extraigo puntos con los q se hace la curva
  #tif
  pto_sp_tif <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    
    a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())[[2]]
    
    #a <- Tabla.splines(data = data_splines,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),C_splines,pr=tf_sp())[[2]]
    # a1 <- cbind.data.frame(a$Plazo,a$Rendimiento)
    # names(a1) <- c("Plazo","Rendimiento")
    return(a)
    })
  
  #comparativo
  pto_sp_tif_comp <- reactive({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n5,num = input$d_tif_comp,par = input$parametro_tif_comp,tit=c(input$t1_comp,input$t2_comp,input$t3_comp),car,pr=tf_comp())[[2]]
    a <- tabla_sp_tif_comp()[[2]]
    # a1 <- cbind.data.frame(a$Plazo,a$Rendimiento)
    # names(a1) <- c("Plazo","Rendimiento")
    return(a)
  })
  
  #veb
  pto_sp_veb <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    a <- Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n4,num = input$d_veb,par = input$parametro_veb,tit=c(input$v1_sp,input$v2_sp,input$v3_sp),car,pr=tv_sp())[[2]]
    # a1 <- cbind.data.frame(a$Plazo,a$Rendimiento)
    # names(a1) <- c("Plazo","Rendimiento")
    return(a)
  })
  
  #comparativo
  pto_sp_veb_comp <- reactive({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # a <- Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num = input$d_veb_comp,par = input$parametro_veb_comp,tit=c(input$v1_comp,input$v2_comp,input$v3_comp),car,pr=tv_comp())[[2]]
    a <- tabla_sp_veb_comp()[[2]]
    # a1 <- cbind.data.frame(a$Plazo,a$Rendimiento)
    # names(a1) <- c("Plazo","Rendimiento")
    return(a)
  })
  
  
  #output$datos <- renderPrint({pto_sp_tif()})
  
  #COMPARATIVO DE PRECIOS
  #tif
  gra_tif_ns_comp_i <- reactive({
    #Tabla.ns(fv = input$n5 ,tit = comp1(),pr =tf_comp() ,pa = c(1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=1,fe3=0)[[2]] 
    Tabla.ns(fv = input$n5 ,tit = comp1(),pr =TF_NSC() ,pa = c(1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=1,fe3=0)[[2]] 
    })
  
  gra_tif_sven_comp_i <- reactive({
    #Tabla.sven(fv = input$n5 ,tit = comp1(),pr =tf_comp() ,pa = c(1,1,1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=1,fe3=0)[[2]] 
    Tabla.sven(fv = input$n5 ,tit = comp1(),pr =TF_SV() ,pa = c(1,1,1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=1,fe3=0)[[2]] 
    })
  
  
  precios_tif <- reactive({
    #ojo con los dos primeros
    withProgress(message = 'Calculando precios...', value = 0, {
      incProgress(1/5, detail = "Metodología Nelson y Siegel")
      dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
      dat[,3] <- as.Date(as.character(dat[,3]))
      car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    #a <-   Tabla.ns(fv = input$n5 ,tit = comp1(),pr =tf_comp() ,pa = gra_tif_ns_comp_i(),ind = 0,C = car,fe2=0,fe3=0)[[3]]
    a <-   Tabla.ns(fv = input$n5 ,tit = comp1(),pr =TF_NSC() ,pa = gra_tif_ns_comp_i(),ind = 0,C = car,fe2=0,fe3=0)[[3]]
    incProgress(1/5, detail = "Metodología Svensson")
    #b <-   Tabla.sven(fv = input$n5 ,tit = comp1(),pr =tf_comp() ,pa = gra_tif_sven_comp_i() ,ind = 0,C = car,fe2=0,fe3=0)[[3]]
    b <-   Tabla.sven(fv = input$n5 ,tit = comp1(),pr =TF_SV() ,pa = gra_tif_sven_comp_i() ,ind = 0,C = car,fe2=0,fe3=0)[[3]]
    #
    incProgress(1/5, detail = "Metodología Diebold-Li")
    c <-   precio.dl(tit = comp1(),fv = input$n5 ,C = car ,pa = c(1,1,1,1),spline1 = dl_spline_tif_comp(),pr=tf_comp())[[2]]
    incProgress(1/5, detail = "Metodología Splines")
    d <-   Tabla.splines(data = dat,tipo = "TIF",fe=input$n5,num = input$d_tif_comp,par = input$parametro_tif_comp,tit=comp1(),car,pr=tf_comp())[[1]]
    
    })
    
    #f <- cbind.data.frame(c(tf_comp(),0),a[,2],b[,2],c[,2],d[,2])
    #podria servir TF_NSC tambien
    f <- cbind.data.frame(c(TF_SV(),0),a[,2],b[,2],c[,2],d[,2])
    names(f) <- c("Precio Promedio","Nelson y Siegel","Svensson","Diebold-Li","Splines")
    #row.names(f)[length(f[,1])] <- "SRC"
    row.names(f)[dim(f)[1]] <- "SRC"
    
    #modifico ultima fila de c y d con el fin de calcular el SRC
    a1 <- Tabla.ns(fv = input$n5 ,tit = comp1(),pr =TF_NSC() ,pa = gra_tif_ns_comp_i(),ind = 0,C = car,fe2=0,fe3=0)[[1]]
    pond <- as.numeric(sub(",",".",a1[12,]))
    
    #SRC DL
    a2 <- sum(((c[1:(nrow(f)-1),2]-f[1:(nrow(f)-1),1])*pond)^2)
    f[nrow(f),4] <- a2
    
    #SRC SP
    a3 <- sum(((d[1:(nrow(f)-1),2]-f[1:(nrow(f)-1),1])*pond)^2)
    f[nrow(f),5] <- a3
    
    return(f)
    
  })
  
  output$comparativo_precios_tif <- DT::renderDataTable({
    a <- try(precios_tif())
    if(class(a)!="try-error"){
      a
    }else{
      Aviso <- "Por favor seleccionar instrumentos"
      return(as.data.frame(Aviso))
    }
    })
  
  
  #veb
  gra_veb_ns_comp_i <- reactive({
    #Tabla.ns(fv = input$n5 ,tit = comp2(),pr =tv_comp() ,pa = c(1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=1,fe3=0)[[2]] 
    Tabla.ns(fv = input$n5 ,tit = comp2(),pr =TV_NSC() ,pa = c(1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=1,fe3=0)[[2]] 
    })
  
  gra_veb_sven_comp_i <- reactive({
    #Tabla.sven(fv = input$n5 ,tit = comp2(),pr =tv_comp() ,pa = c(1,1,1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=1,fe3=0)[[2]] 
    Tabla.sven(fv = input$n5 ,tit = comp2(),pr =TV_SV() ,pa = c(1,1,1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=1,fe3=0)[[2]] 
    })
  
  
  precios_veb <- reactive({
    #ojo con los dos primeros
    withProgress(message = 'Calculando precios...', value = 0, {
      incProgress(1/5, detail = "Metodología Nelson y Siegel")
      dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
      dat[,3] <- as.Date(as.character(dat[,3]))
      car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
     #a <-   Tabla.ns(fv = input$n5 ,tit = comp2(),pr =tv_comp() ,pa = gra_veb_ns_comp_i(),ind = 1,C = car,fe2=0,fe3=0)[[3]]
     a <-   Tabla.ns(fv = input$n5 ,tit = comp2(),pr =TV_NSC() ,pa = gra_veb_ns_comp_i(),ind = 1,C = car,fe2=0,fe3=0)[[3]]
     incProgress(1/5, detail = "Metodología Svensson")
     #b <-   Tabla.sven(fv = input$n5 ,tit = comp2(),pr =tv_comp() ,pa = gra_veb_sven_comp_i() ,ind = 1,C = car,fe2=0,fe3=0)[[3]]
     b <-   Tabla.sven(fv = input$n5 ,tit = comp2(),pr =TV_SV() ,pa = gra_veb_sven_comp_i() ,ind = 1,C = car,fe2=0,fe3=0)[[3]]
     #
     incProgress(1/5, detail = "Metodología Diebold-Li")
     c <-   precio.dl(tit = comp2(),fv = input$n5 ,C = car ,pa = c(1,1,1,1),spline1 = dl_spline_veb_comp(),pr=tv_comp())[[2]]
     incProgress(1/5, detail = "Metodología Splines")
      d <-   Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num = input$d_veb_comp,par = input$parametro_veb_comp,tit=comp2(),car,pr=tv_comp())[[1]]
    
    })
     
    #podria servir TV_NSC tambien
     #f <- cbind.data.frame(c(tv_comp(),0),a[,2],b[,2],c[,2],d[,2])
    f <- cbind.data.frame(c(TV_SV(),0),a[,2],b[,2],c[,2],d[,2])
    names(f) <- c("Precio Promedio","Nelson y Siegel","Svensson","Diebold-Li","Splines")
     #row.names(f)[length(f[,1])] <- "SRC"
     row.names(f)[dim(f)[1]] <- "SRC"
    
     
     #modifico ultima fila de c y d con el fin de calcular el SRC
     a1 <- Tabla.ns(fv = input$n5 ,tit = comp2(),pr =TV_NSC() ,pa = gra_veb_ns_comp_i(),ind = 1,C = car,fe2=0,fe3=0)[[1]]
     pond <- as.numeric(sub(",",".",a1[12,]))
     
     #SRC DL
     a2 <- sum(((c[1:(nrow(f)-1),2]-f[1:(nrow(f)-1),1])*pond)^2)
     f[nrow(f),4] <- a2
     
     #SRC SP
     a3 <- sum(((d[1:(nrow(f)-1),2]-f[1:(nrow(f)-1),1])*pond)^2)
     f[nrow(f),5] <- a3
     
     return(f)
    
  })
  
  output$comparativo_precios_veb <- DT::renderDataTable({
    a <- try(precios_veb())
    if(class(a)!="try-error"){
      a
    }else{
      Aviso <- "Por favor seleccionar instrumentos"
      return(as.data.frame(Aviso))
    }
    })
  
  #Graficas comparativos
  #tif
  spline_tif_comp <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    Tabla.splines(data = dat,tipo = "TIF",fe=input$n5,num =input$d_tif_comp,par = input$parametro_tif_comp,tit=comp1(),car,pr=tf_comp())[[4]] 
    })
  
  dl_spline_tif_comp_i <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    Tabla.splines(data = dat,tipo = "TIF",fe=input$n5,num =input$d_tif_comp,par = input$parametro_tif_dl_comp,tit=comp1(),car,pr=tf_comp())[[4]] 
    })
  
  

  dl_tif <- reactive({
  #defino eje maduracion
  X1 <- seq(0.1,20,0.1)
  
  #defino tiempos
  Y1 <- seq(1,50,1)
  
  #
  var_par <- as.data.frame(matrix(0,length(Y1),4))
  
  #guardo parametros segun cada tiempo
  for(i in 1:length(Y1)){
    #var_par[i,] <- par_dl(t[i],spline1,pa=c(1,1,1,1))
    var_par[i,] <- par_dl(Y1,dl_spline_tif_comp_i(),pa=c(1,1,1,1))
    
  }
  
  return(var_par[dim(var_par)[1],])
  })
  
  
  #TIF
  output$curva_comp_tif <- renderPlotly({ 
    #data
    x <- seq(1,20,0.1)
    withProgress(message = 'Calculando alturas...', value = 0, {
    #y_ns <- c(0.0097,nelson_siegel(x[2:length(x)],pa=gra_tif_ns_comp_i()))*100
    incProgress(1/5, detail = "Metodología Nelson y Siegel")
    y_ns <- try(nelson_siegel(x,pa=gra_tif_ns_comp_i())*100)
    incProgress(1/5, detail = "Metodología Svensson")
    y_sven <- try(sven(x,pa=gra_tif_sven_comp_i())*100)
    incProgress(1/5, detail = "Metodología Diebold-Li")
    y_dl <- try(diebold_li(pa=as.numeric(dl_tif()),x)*100)
    incProgress(1/5, detail = "Metodología Splines")
    y_sp <- try(predict(spline_tif_comp(),x*365)$y)
  
    })
    
    if(class(y_ns)!="try-error" & class(y_sven)!="try-error" & class(y_dl)!="try-error" & class(y_sp)!="try-error"){
    #dataframe
    data <- data.frame(x,y_ns,y_sven,y_dl,y_sp)
    
    #curva 
    #defino nombres de ejes
    f <- list(
      family = "Courier New, monospace",
      size = 18,
      color = "#7f7f7f"
    )
    x1 <- list(
      title = "Maduración (días)",
      titlefont = f
    )
    y1 <- list(
      title = "Rendimientos (%)",
      titlefont = f
    )
    
    #
    plot_ly(data, x = ~x, y = ~y_ns, name = 'Nelson y Siegel', type = 'scatter', mode = 'lines') %>% 
    add_trace(y = ~y_sven, name = 'Svensson', mode = 'lines') %>% 
    add_trace(y = ~y_dl, name = 'Diebold-Li', mode = 'lines') %>% 
    add_trace(y = ~y_sp, name = 'Splines', mode = 'lines') %>%
     layout(title = "Curvas de Rendimientos TIF",xaxis = x1, yaxis = y1)
      
    }else{}
    
    })
  
  #VEBONOS
  
  spline_veb_comp <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num =input$d_veb_comp,par = input$parametro_veb_comp,tit=comp2(),car,pr=tv_comp())[[4]]
    #tabla_sp_dl_veb_comp()[[4]]
    })
  
  dl_spline_veb_comp_i <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num =input$d_veb_dl_comp,par = input$parametro_veb_dl_comp,tit=comp2(),car,pr=tv_comp())[[4]]
    })
  
  
  
  dl_veb <- reactive({
    #defino eje maduracion
    X1 <- seq(0.1,20,0.1)
    
    #defino tiempos
    Y1 <- seq(1,50,1)
    
    #
    var_par <- as.data.frame(matrix(0,length(Y1),4))
    
    #guardo parametros segun cada tiempo
    for(i in 1:length(Y1)){
      #var_par[i,] <- par_dl(t[i],spline1,pa=c(1,1,1,1))
      var_par[i,] <- par_dl(Y1,dl_spline_veb_comp_i(),pa=c(1,1,1,1))
      
    }
    
    return(var_par[dim(var_par)[1],])
  })
  
  
  #TIF
  output$curva_comp_veb <- renderPlotly({ 
    #data
    x <- seq(1,20,0.1)
    withProgress(message = 'Calculando alturas...', value = 0, {
      incProgress(1/5, detail = "Metodología Nelson y Siegel")  
    y_ns <- try(nelson_siegel(x,pa=gra_veb_ns_comp_i())*100)
    incProgress(1/5, detail = "Metodología Svensson")
    y_sven <- try(sven(x,pa=gra_veb_sven_comp_i())*100)
    incProgress(1/5, detail = "Metodología Diebold-Li")
    y_dl <- try(diebold_li(pa=as.numeric(dl_veb()),x)*100)
    incProgress(1/5, detail = "Metodología Splines")
    y_sp <- try(predict(spline_veb_comp(),x*365)$y)
    })
    
    
    if(class(y_ns)!="try-error" & class(y_sven)!="try-error" & class(y_dl)!="try-error" & class(y_sp)!="try-error"){
    #dataframe
    data <- data.frame(x,y_ns,y_sven,y_dl,y_sp)
    
    #curva 
    #defino nombres de ejes
    f <- list(
      family = "Courier New, monospace",
      size = 18,
      color = "#7f7f7f"
    )
    x1 <- list(
      title = "Maduración (días)",
      titlefont = f
    )
    y1 <- list(
      title = "Rendimientos (%)",
      titlefont = f
    )
    
    #
    plot_ly(data, x = ~x, y = ~y_ns, name = 'Nelson y Siegel', type = 'scatter', mode = 'lines') %>%
      add_trace(y = ~y_sven, name = 'Svensson', mode = 'lines') %>% 
      add_trace(y = ~y_dl, name = 'Diebold-Li', mode = 'lines') %>% 
      add_trace(y = ~y_sp, name = 'Splines', mode = 'lines') %>%
      layout(title = "Curvas de Rendimientos VEBONO",xaxis = x1, yaxis = y1)
    
    }else{}
    
  })
  
  # Reporte código genérico
  
  output$report <- downloadHandler(
    filename = "reporte1.pdf",
    content = function(file) {
      tempReport <- file.path(tempdir(), "reporte1.Rmd")
      #tempReport <- file.path(getwd(), "reporte1.Rmd")
      
      file.copy("reporte1.Rmd", tempReport, overwrite = TRUE)
      
      # Configuración de parámetros pasados a documento Rmd
      params <- list(fecha = input$n5,
                    titulos = comp1(),
                    pre_prom = tf_comp(),
                    par_ns_t = gra_tif_ns_comp_i(),
                    par_sven_t= gra_tif_sven_comp_i(),
                    par_dl_t=dl_tif(),
                    par_sp_t=spline_tif_comp(),
                    comp_pre_t=precios_tif()
                    
                    
                     # data2 = data()$corriente,
                     # data3 = data()$corriente.rem,
                     # dist1 = input$distVarA,
                     # dist2 = input$distVarC,
                     # dist3 = input$distVarCR,
                     # pconf = input$porVar,
                     # reali = input$reali,
                     # revi = input$revi
                     )
      
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempReport, output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
      )
    })
  
  #reporte vebonos
  output$report1 <- downloadHandler(
    filename = "reporte2.pdf",
    content = function(file) {
      tempReport <- file.path(tempdir(), "reporte2.Rmd")
      #tempReport <- file.path(getwd(), "reporte1.Rmd")
      
      file.copy("reporte2.Rmd", tempReport, overwrite = TRUE)
      
      # Configuración de parámetros pasados a documento Rmd
      params <- list(fecha = input$n5,
                     titulos = comp2(),
                     pre_prom = tv_comp(),
                     par_ns_v = gra_veb_ns_comp_i(),
                     par_sven_v= gra_veb_sven_comp_i(),
                     par_dl_v=dl_veb(),
                     par_sp_v=spline_veb_comp(),
                     comp_pre_v=precios_veb()
                     
                     
                     # data2 = data()$corriente,
                     # data3 = data()$corriente.rem,
                     # dist1 = input$distVarA,
                     # dist2 = input$distVarC,
                     # dist3 = input$distVarCR,
                     # pconf = input$porVar,
                     # reali = input$reali,
                     # revi = input$revi
      )
      
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempReport, output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
      )
    })
  
  #descarga BCV
  
  
  # datasetInput <- reactive({
  #   switch(input$dataset,
  #          "0-22" = ruta_bcv("0-22"),
  #          "Caracteristicas" = ruta_bcv("caracteristicas"))
  # })
  
  #output$desc <- renderPrint({ input$dataset })
  
    # Downloadable csv of selected dataset ----
  # output$downloadData <- downloadHandler(
  #   filename = function() {
  #     paste(input$dataset, ".xls", sep = "")
  #   },
  #   content = function(file) {
  #     file<-paste(getwd(),"data",paste(input$dataset, ".xls", sep = ""),sep="/")
  #     #antes en method estaba libcurl
  #     download.file(url=datasetInput(),destfile=file,method = "internal",mode="wb")
  #     #GET(datasetInput(), write_disk(file, overwrite=TRUE))
  #     #write.xlsx(datasetInput(), file, row.names = FALSE)
  #   }
  # )
  
  #leo caracteristica guardada en carpeta data
  # output$Ca_leida <- renderDataTable({
  #   ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
  #   if(class(ca)=="try-error"){
  #     Aviso <- print("El archivo no se encuentra, descargar y recargar página!")
  #     #return(datatable(Aviso, options = list(paging = FALSE)))
  #     return(as.data.frame(Aviso))
  #   }else{
  #   #return(datatable(ca, options = list(paging = FALSE)))
  #     return(ca)
  #   }
  #   })
  # 
  #leo documento 022
  # output$docbcv <- renderDataTable({
  #   ca <- try(Preciosbcv(paste(getwd(),"data","0-22.xls",sep = "/")))
  #   ca1 <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
  #   
  #   if(class(ca)=="try-error" | class(ca1)=="try-error" ){
  #     Aviso <- print("El archivo no se encuentra, descargar y recargar página!")
  #     return(as.data.frame(Aviso))
  #   }else{
  #     #condicional cuando no hay obs
  #     if(is.null(dim(ca))){
  #       Aviso <- "No existen operaciones para el mes actual"
  #       return(as.data.frame(Aviso))
  #     }else{
  #     
  #     ca2 <- formatop(ca1,ca)
  #     #convierto fecha de op y venc en fechas
  #     ca2$`Fecha op` <- as.Date(as.character(ca2$`Fecha op`),format="%d/%m/%Y")
  #     ca2$F.Vencimiento <- as.Date(as.character(ca2$F.Vencimiento),format="%d/%m/%Y")
  # 
  #     #este data frame es el que utiliza la metodologia Spline para los calculos
  #     ca3 <- dplyr::arrange(ca2,(`Fecha op`))
  # 
  #     #guardo historico_actualizado
  #     hist <- read.csv(paste(getwd(),"data","Historico.txt",sep = "/"),sep="")
  #     hist[,3] <- as.Date(as.character(hist[,3]))
  #     hist[,6] <- as.Date(as.character(hist[,6]))
  # 
  # 
  #     names(ca3)=names(hist)
  #    #print(str(ca3))
  #    #print(str(hist))
  # 
  #     hist_act <- rbind.data.frame(hist,ca3)
  # 
  # 
  #     write.table(hist_act,paste(getwd(),"data","Historico_act.txt",sep = "/"),row.names = FALSE)
  # 
  #     return(ca3)
  #     }#final condicional no hay operaciones
  #   }
  # })
  # 
  
  # output$pre_prom_tif <- renderPrint({
  #           #leo el historico actualizado
  #           hist <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
  #           
  #           #como primer enfoque busco todos los tif y veb
  #           #luego se puede buscar solamente los tit seleccionados
  #           #no seria muy dificil este cambio
  #           hist_19 <- pre_prom(hist,"2019")
  #           hist_18 <- pre_prom(hist,"2018")
  #           hist_17 <- pre_prom(hist,"2017")
  #           hist_16 <- pre_prom(hist,"2016")
  #           
  #           #para buscar tif uso hist_18 u otro año y uso el segundo 
  #           #elemento de la lista
  #           #busco tif de mi cartera en historico 2018
  #           tif_19 <- comp(tit,hist_19[[2]])
  #           
  #           #los tif que no encuentro en 2018 los busco en 2017
  #           if(length(tif_19[[2]])!=0){
  #             tif_18 <- comp(tif_19[[2]],hist_18[[2]])
  #           }else{
  #             print("Todos los instrumentos estan")
  #           }
  #           
  #           ##tif_18 <- comp(tit,hist_18[[2]])
  #           
  #           #los tif que no encuentro en 2018 los busco en 2017
  #           if(length(tif_18[[2]])!=0){
  #             tif_17 <- comp(tif_18[[2]],hist_17[[2]])
  #           }else{
  #             print("Todos los instrumentos estan")
  #           }
  #           
  #           #los tif que no encuentro en 2017 los busco en 2016
  #           if(length(tif_17[[2]])!=0){
  #             tif_16 <- comp(tif_17[[2]],hist_16[[2]])
  #           }else{
  #             print("Todos los instrumentos estan")
  #           }
  #           
  #           #precios promedio que salen
  #           #TIF <- rbind.data.frame(tif_18[[1]],tif_17[[1]],tif_16[[1]])
  #           TIF <- rbind.data.frame(tif_19[[1]],tif_18[[1]],tif_17[[1]],tif_16[[1]])
  #           
  #           names(TIF) <- c("Títulos","Precio Promedio","Año")
  #           write.table(TIF,paste(getwd(),"data","Precio_prom_tif.txt",sep = "/"),row.names = FALSE)
  #           
  #           
  #           #titulos tif que no salen
  #           no_tif <- as.data.frame(tif_16[[2]])
  #           names(no_tif) <- "Títulos faltantes"
  #           write.table(no_tif,paste(getwd(),"data","Tif_faltantes.txt",sep = "/"),row.names = FALSE)
  #           
  #           
  #           #return(TIF)
  #           print("Titulos en historico")
  #           print(TIF)
  #           
  #           print("Titulos que no salen")
  #           print(no_tif)
  # 
  #           
  #           
  #                         })
    
    
  # output$pre_prom_veb <- renderPrint({
  #   #leo el historico actualizado
  #   hist <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
  #   
  #   #como primer enfoque busco todos los tif y veb
  #   #luego se puede buscar solamente los tit seleccionados
  #   #no seria muy dificil este cambio
  #   hist_19 <- pre_prom(hist,"2019")
  #   hist_18 <- pre_prom(hist,"2018")
  #   hist_17 <- pre_prom(hist,"2017")
  #   hist_16 <- pre_prom(hist,"2016")
  #   
  #   #para buscar tif uso hist_18 u otro año y uso el tercer 
  #   #elemento de la lista
  #   #busco veb de mi cartera en historico 2018
  #   veb_19 <- comp(tit1,hist_19[[3]])
  #   #veb_18 <- comp(tit1,hist_18[[3]])
  #   
  #   #los tif que no encuentro en 2019 los busco en 2018
  #   if(length(veb_19[[2]])!=0){
  #     veb_18 <- comp(veb_19[[2]],hist_18[[3]])
  #   }else{
  #     print("Todos los instrumentos estan")
  #   }
  #   
  #   #los tif que no encuentro en 2018 los busco en 2017
  #   if(length(veb_18[[2]])!=0){
  #     veb_17 <- comp(veb_18[[2]],hist_17[[3]])
  #   }else{
  #     print("Todos los instrumentos estan")
  #   }
  #   
  #   #los tif que no encuentro en 2017 los busco en 2016
  #   if(length(veb_17[[2]])!=0){
  #     veb_16 <- comp(veb_17[[2]],hist_16[[3]])
  #   }else{
  #     print("Todos los instrumentos estan")
  #   }
  #   
  #   #precios promedio que salen
  #   #VEB <- rbind.data.frame(veb_18[[1]],veb_17[[1]],veb_16[[1]])
  #   VEB <- rbind.data.frame(veb_19[[1]],veb_18[[1]],veb_17[[1]],veb_16[[1]])
  #   
  #   names(VEB) <- c("Títulos","Precio Promedio","Año")
  #   write.table(VEB,paste(getwd(),"data","Precio_prom_veb.txt",sep = "/"),row.names = FALSE)
  #   
  #   
  #   #titulos tif que no salen
  #   no_veb <- as.data.frame(veb_16[[2]])
  #   names(no_veb) <- "Títulos faltantes"
  #   write.table(no_veb,paste(getwd(),"data","Veb_faltantes.txt",sep = "/"),row.names = FALSE)
  #   
  #   
  #   #return(TIF)
  #   print("Titulos en historico")
  #   print(VEB)
  #   
  #   print("Titulos que no salen")
  #   print(no_veb)
  #   
  #   
  #   
  # })
  
  #opcion eliminar SPLINES
  # output$tabla_elim_tif <- renderDataTable({
  #   if(input$elim_tif==1){
  #       
  # 
  #   }else{
  #     Aviso <- "No se eliminarán observaciones iniciales"
  #     return(as.data.frame(Aviso))
  #   }
  # })
  
  #calculo candidatos a elimnar
  #TIF
  obs_elim_tif <- reactive({
    #Tabla.splines(data = data_splines,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),C_splines,pr=tf_sp())[[2]]
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # #return(car)
    # #print(str(data_splines))
    # #print(str(dat))
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())[[2]]
    
     #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())
    #agrego dependencia 
    #input$boton12 
    
    a <- (try(tabla_sp_tif()))
     
     if(class(a)!="try-error"){
     letra <- a[[3]]
     #cand <- a[[2]]
     
     #a1 <- c(as.character(letra[,2]),as.character(cand[,1]))
     #return(as.character(a1))
     #condicional letra
     if(is.null(names(letra))){
       #print(letra)
       letra1 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
       letra1[,2] <- as.Date(letra1[,2])
       letra1[,3] <- as.Date(letra1[,3])
       cand <- a[[2]]
       
       names(letra1)=names(cand)
       
       a1 <- c(as.character(letra1[,1]),as.character(cand[,1]))
       return(as.character(a1))
     }else{
       letra[,6] <- as.Date(letra[,6])
       letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
       cand <- a[[2]]
       
       names(letra1)=names(cand)
       
       a1 <- c(as.character(letra1[,1]),as.character(cand[,1]))
       return(as.character(a1))
       
     }
     
     
     
     }else{}
    #return(as.character(a[,1]))
  })
  
  #TIF-COMP
  obs_elim_tif_comp <- reactive({
    #Tabla.splines(data = data_splines,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),C_splines,pr=tf_sp())[[2]]
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # #return(car)
    # #print(str(data_splines))
    # #print(str(dat))
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())[[2]]
    
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())
    a <- try(tabla_sp_tif_comp())
    
    if(class(a)!="try-error"){
    letra <- a[[3]]
    
    #cand <- a[[2]]
    
    #a1 <- c(as.character(letra[,2]),as.character(cand[,1]))
    #return(as.character(a1))
    #condicional letra
    if(is.null(names(letra))){
      #print(letra)
      letra1 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
      letra1[,2] <- as.Date(letra1[,2])
      letra1[,3] <- as.Date(letra1[,3])
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a1 <- c(as.character(letra1[,1]),as.character(cand[,1]))
      return(as.character(a1))
    }else{
      letra[,6] <- as.Date(letra[,6])
      letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a1 <- c(as.character(letra1[,1]),as.character(cand[,1]))
      return(as.character(a1))
      
    }
    
    
    
    }else{}
    
  })
  
  #VEBONO
  obs_elim_veb <- reactive({
    a <- try(tabla_sp_veb())
    
    if(class(a)!="try-error"){
    letra <- a[[3]]
    
    #condicional letra
    if(is.null(names(letra))){
      #print(letra)
      letra1 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
      letra1[,2] <- as.Date(letra1[,2])
      letra1[,3] <- as.Date(letra1[,3])
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a1 <- c(as.character(letra1[,1]),as.character(cand[,1]))
      return(a1)
    }else{
      letra[,6] <- as.Date(letra[,6])
      letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a1 <- c(as.character(letra1[,1]),as.character(cand[,1]))
      return(a1)
      
    }
    
  
    }else{}
    
  })

  #VEBONO-COMP
  obs_elim_veb_comp <- reactive({
    #Tabla.splines(data = data_splines,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),C_splines,pr=tf_sp())[[2]]
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # #return(car)
    # #print(str(data_splines))
    # #print(str(dat))
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())[[2]]
    
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())
    a <- try(tabla_sp_veb_comp())
    
    if(class(a)!="try-error"){
    letra <- a[[3]]
    
    #cand <- a[[2]]
    
    #a1 <- c(as.character(letra[,2]),as.character(cand[,1]))
    #return(as.character(a1))
    #condicional letra
    if(is.null(names(letra))){
      #print(letra)
      letra1 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
      letra1[,2] <- as.Date(letra1[,2])
      letra1[,3] <- as.Date(letra1[,3])
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a1 <- c(as.character(letra1[,1]),as.character(cand[,1]))
      return(as.character(a1))
    }else{
      letra[,6] <- as.Date(letra[,6])
      letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a1 <- c(as.character(letra1[,1]),as.character(cand[,1]))
      return(as.character(a1))
      
    }
    
    
    
    }else{}
    
  })
  
  #hago el imputselect interactivo
  #TIF
  output$selectUI_tif <- renderUI({ 

    selectInput("obs_tif", "Seleccionar títulos", obs_elim_tif(),multiple = TRUE)
    
     })
  
  #TIF - COMPARATIVO
  output$selectUI_tif_comp <- renderUI({ 
    selectInput("obs_tif_comp", "Seleccionar títulos", obs_elim_tif_comp(),multiple = TRUE)
  })
  
  
  #VEBONO
  output$selectUI_veb <- renderUI({ 
    selectInput("obs_veb", "Seleccionar títulos", obs_elim_veb(),multiple = TRUE)
  })
  
  #VEBONO - COMPARATIVO
  output$selectUI_veb_comp <- renderUI({ 
    selectInput("obs_veb_comp", "Seleccionar títulos", obs_elim_veb_comp(),multiple = TRUE)
  })
  
  #imprimo titulos seleccionados a eliminar
  #TIF
  output$obs_elim_tif <- renderPrint(input$obs_tif)
  
  #TIF-COMP
  output$obs_elim_tif_comp <- renderPrint(input$obs_tif_comp)
  
  
  #VEBONO
  output$obs_elim_veb <- renderPrint(input$obs_veb)
  
  #VEBONO-COMP
  output$obs_elim_veb_comp <- renderPrint(input$obs_veb_comp)
  
  #muestro nuevos candidatos
  #TIF
  output$tit_cand_tif_new <- DT::renderDataTable({
    #Tabla.splines(data = data_splines,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),C_splines,pr=tf_sp())[[2]]
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # #return(car)
    # #print(str(data_splines))
    # #print(str(dat))
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())[[2]]
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())
    #agrego dependencia 
    input$boton12
    
    #
    isolate({ 
    a <- try(tabla_sp_tif())
    
    if(class(a)!="try-error"){
  
    letra <- (a[[3]])
    
    #letra[,6] <- (as.Date(letra[,6]))
    #letra1 <- (data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1"))
    #cand <- (a[[2]])
  
    #names(letra1)=names(cand)
    
    #a <- (rbind.data.frame(letra1,cand,make.row.names = FALSE))
    #condicional letra
    if(is.null(names(letra))){
      #print(letra)
      letra1 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
      letra1[,2] <- as.Date(letra1[,2])
      letra1[,3] <- as.Date(letra1[,3])
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      
    }else{
      letra[,6] <- as.Date(letra[,6])
      letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      
      
    }
    
    
    if(length(input$obs_tif)==0){
      Aviso <- "No se ha seleccionado nada"
      return(as.data.frame(Aviso))
      
    }else{
      
    b <- c()
      
      
    for(i in 1:length(input$obs_tif)){
    b[i] <- (which(input$obs_tif[i]==as.character(a[,1])))
    }
      
    
    #a <- (a[-b,])
    #return(a)
     
      return( (a[-b,]) )
      
    }
    
    
    
    }else{}
    
    }) #final isolate
  })
  
  #TIF - COMP
  
  output$tit_cand_tif_new_comp <- DT::renderDataTable({
    #pongo dependencia
    input$boton18
    
    #
    isolate({
    a <- try(tabla_sp_tif_comp())
    
    if(class(a)!="try-error"){
    letra <- a[[3]]
    
    #letra[,6] <- as.Date(letra[,6])
    #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    #cand <- a[[2]]
    
    
    #names(letra1)=names(cand)
    
    #a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
    
    #condicional letra
    if(is.null(names(letra))){
      #print(letra)
      letra1 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
      letra1[,2] <- as.Date(letra1[,2])
      letra1[,3] <- as.Date(letra1[,3])
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
    }else{
      letra[,6] <- as.Date(letra[,6])
      letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)

    }
    
    
    if(length(input$obs_tif_comp)==0){
      Aviso <- "No se ha seleccionado nada"
      return(as.data.frame(Aviso))
      
    }else{
      
      b <- c()
      for(i in 1:length(input$obs_tif_comp)){
        b[i] <- which(input$obs_tif_comp[i]==as.character(a[,1]))
      }
      a <- a[-b,]
      return(a)
      
    }
    
    }else{}
    }) #final isolate
    
  })
  
  
  #VEBONOS
  output$tit_cand_veb_new <- DT::renderDataTable({
    #pongo dependencia
    input$boton14
    
    #
    isolate({
    
    a <- try(tabla_sp_veb())
    
    if(class(a)!="try-error"){
    letra <- a[[3]]
    #letra[,6] <- as.Date(letra[,6])
    #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    #cand <- a[[2]]
    
    
    #names(letra1)=names(cand)
    
    #a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
    
    #condicional letra
    if(is.null(names(letra))){
      #print(letra)
      letra1 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
      letra1[,2] <- as.Date(letra1[,2])
      letra1[,3] <- as.Date(letra1[,3])
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      
    }else{
      letra[,6] <- as.Date(letra[,6])
      letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      
      
    }
    
    
    if(length(input$obs_veb)==0){
      Aviso <- "No se ha seleccionado nada"
      return(as.data.frame(Aviso))
      
    }else{
      
      b <- c()
      for(i in 1:length(input$obs_veb)){
        b[i] <- which(input$obs_veb[i]==as.character(a[,1]))
      }
      #a <- a[-b,]
      return(a[-b,])
      
    }
    
    }else{}
    
    }) #final isolate
    
  })
  
  #VEBONOS-COMP
  output$tit_cand_veb_new_comp <- DT::renderDataTable({
    #pongo dependencia
    input$boton20
    
    #
    isolate({
    a <- try(tabla_sp_veb_comp())
    
    if(class(a)!="try-error"){
    letra <- a[[3]]
    
    #letra[,6] <- as.Date(letra[,6])
    #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    #cand <- a[[2]]
    
    #names(letra1)=names(cand)
    
    #a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
    #condicional letra
    if(is.null(names(letra))){
      #print(letra)
      letra1 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
      letra1[,2] <- as.Date(letra1[,2])
      letra1[,3] <- as.Date(letra1[,3])
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      
    }else{
      letra[,6] <- as.Date(letra[,6])
      letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      
      
    }
    
    
    if(length(input$obs_veb_comp)==0){
      Aviso <- "No se ha seleccionado nada"
      return(as.data.frame(Aviso))
      
    }else{
      
      b <- c()
      for(i in 1:length(input$obs_veb_comp)){
        b[i] <- which(input$obs_veb_comp[i]==as.character(a[,1]))
      }
      a <- a[-b,]
      return(a)
      
    }
    
    }else{}
    }) #final isolate
    
  })
  
  #calculo nuevos precios
  #TIF
  output$precios_tif_nuevos <- DT::renderDataTable({
    #agrego dependencia 
    input$boton12
    
    #
    isolate({
    #Tabla.splines(data = data_splines,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),C_splines,pr=tf_sp())[[2]]
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
     car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # #return(car)
    # #print(str(data_splines))
    # #print(str(dat))
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())[[2]]
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())
    a <- (try(tabla_sp_tif()))
    
    if(class(a)!="try-error"){
    letra <- a[[3]]
    
    #letra[,6] <- as.Date(letra[,6])
    #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    #cand <- a[[2]]

    #names(letra1)=names(cand)
    
    #a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
    #condicional letra
    if(is.null(names(letra))){
      #print(letra)
      letra1 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
      letra1[,2] <- as.Date(letra1[,2])
      letra1[,3] <- as.Date(letra1[,3])
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      
    }else{
      letra[,6] <- as.Date(letra[,6])
      letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      
    }
    
    
    if(length(input$obs_tif)==0){
      Aviso <- "No se ha eliminado nada, ver tabla anterior"
      return(as.data.frame(Aviso))
      
    }else{
      
      b <- c()
      for(i in 1:length(input$obs_tif)){
        b[i] <- which(input$obs_tif[i]==as.character(a[,1]))
      }
      a <- a[-b,]
      
      
      #calculo spline
      spline <- smooth.spline(a[,4],a[,7],spar = input$parametro_tif)
      
      #calculo precios
      pre <- precio(tit = sp1(),spline1 = spline,fv =input$n4 ,C = car)
      
      pre1 <- cbind.data.frame("Títulos"=sp1(),"Precios"=pre)
      
      return(DT::datatable(pre1, options = list(paging = FALSE)))
    }
    
    }else{}
    
    })
  
  })
  
  #TIF-COMP
  output$precios_tif_nuevos_comp <- DT::renderDataTable({
    #pongo dependencia
    input$boton18
    
    #
    isolate({
    
    #Tabla.splines(data = data_splines,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),C_splines,pr=tf_sp())[[2]]
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # #return(car)
    # #print(str(data_splines))
    # #print(str(dat))
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())[[2]]
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())
    a <- try(tabla_sp_tif_comp())
    
    if(class(a)!="try-error"){
    letra <- a[[3]]
    
    #letra[,6] <- as.Date(letra[,6])
    #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    #cand <- a[[2]]
    
    
    #names(letra1)=names(cand)
    
    #a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
    #condicional letra
    if(is.null(names(letra))){
      #print(letra)
      letra1 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
      letra1[,2] <- as.Date(letra1[,2])
      letra1[,3] <- as.Date(letra1[,3])
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
     
    }else{
      letra[,6] <- as.Date(letra[,6])
      letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      
      
    }
    
    
    
    if(length(input$obs_tif_comp)==0){
      Aviso <- "No se ha eliminado nada, ver tabla anterior"
      return(as.data.frame(Aviso))
      
    }else{
      
      b <- c()
      for(i in 1:length(input$obs_tif_comp)){
        b[i] <- which(input$obs_tif_comp[i]==as.character(a[,1]))
      }
      a <- a[-b,]
      
      
      #calculo spline
      spline <- smooth.spline(a[,4],a[,7],spar = input$parametro_tif_comp)
      
      #calculo precios
      pre <- precio(tit = comp1(),spline1 = spline,fv =input$n5 ,C = car)
      
      pre1 <- cbind.data.frame("Títulos"=comp1(),"Precios"=pre)
      
      return(DT::datatable(pre1, options = list(paging = FALSE)))
    }
    
    }else{}
    
    }) #final isolate
  })
  
  
  #VEBONOS
  output$precios_veb_nuevos <- DT::renderDataTable({
    #pongo dependencia
    input$boton14
    
    #
    isolate({
    
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    a <- try(tabla_sp_veb())
    
    if(class(a)!="try-error"){
    letra <- a[[3]]
    
    #letra[,6] <- as.Date(letra[,6])
    #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    #cand <- a[[2]]
    
    
    #names(letra1)=names(cand)
    
    #a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
    #condicional letra
    if(is.null(names(letra))){
      #print(letra)
      letra1 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
      letra1[,2] <- as.Date(letra1[,2])
      letra1[,3] <- as.Date(letra1[,3])
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      
    }else{
      letra[,6] <- as.Date(letra[,6])
      letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      
    }
    
    
    if(length(input$obs_veb)==0){
      Aviso <- "No se ha eliminado nada, ver tabla anterior"
      return(as.data.frame(Aviso))
      
    }else{
      
      b <- c()
      for(i in 1:length(input$obs_veb)){
        b[i] <- which(input$obs_veb[i]==as.character(a[,1]))
      }
      a <- a[-b,]
      
      
      #calculo spline
      spline <- smooth.spline(a[,4],a[,7],spar = input$parametro_veb)
      
      #calculo precios
      pre <- precio(tit = sp2(),spline1 = spline,fv =input$n4 ,C = car)
      
      pre1 <- cbind.data.frame("Títulos"=sp2(),"Precios"=pre)
      
      return(DT::datatable(pre1, options = list(paging = FALSE)))
    }
    
    }else{}
    
    }) #final isolate
  })
  
  #VEBONO-COMP
  output$precios_veb_nuevos_comp <- DT::renderDataTable({
    #pongo dependencia
    input$boton20
    
    #
    isolate({
    
    #Tabla.splines(data = data_splines,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),C_splines,pr=tf_sp())[[2]]
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # #return(car)
    # #print(str(data_splines))
    # #print(str(dat))
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())[[2]]
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())
    a <- try(tabla_sp_veb_comp())
    
    if(class(a)!="try-error"){
    letra <- a[[3]]
    
    #letra[,6] <- as.Date(letra[,6])
    #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    #cand <- a[[2]]
  
    #names(letra1)=names(cand)
    
    #a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
    #condicional letra
    if(is.null(names(letra))){
      #print(letra)
      letra1 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
      letra1[,2] <- as.Date(letra1[,2])
      letra1[,3] <- as.Date(letra1[,3])
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      
    }else{
      letra[,6] <- as.Date(letra[,6])
      letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      
      
    }
    
    if(length(input$obs_veb_comp)==0){
      Aviso <- "No se ha eliminado nada, ver tabla anterior"
      return(as.data.frame(Aviso))
      
    }else{
      
      b <- c()
      for(i in 1:length(input$obs_veb_comp)){
        b[i] <- which(input$obs_veb_comp[i]==as.character(a[,1]))
      }
      a <- a[-b,]
      
      
      #calculo spline
      spline <- smooth.spline(a[,4],a[,7],spar = input$parametro_veb_comp)
      
      #calculo precios
      pre <- precio(tit = comp2(),spline1 = spline,fv =input$n5 ,C = car)
      
      pre1 <- cbind.data.frame("Títulos"=comp2(),"Precios"=pre)
      
      return(DT::datatable(pre1, options = list(paging = FALSE)))
    }
    
    }else{}
    }) #final isolate
    
  })
  
  
  #nueva curva TIF
  #renderRbokeh
  output$c_tif_splines_new <- renderRbokeh({
    #agrego dependencia 
    input$boton12
    
    #
    isolate({
     withProgress(message = 'Graficando curva de rendimiento...', value = 0, {
       incProgress(1/2, detail = "Calculando alturas")
       # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
       # dat[,3] <- as.Date(as.character(dat[,3]))
       # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
       # 
       #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())[[2]]
       #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())
       a <- (try(tabla_sp_tif()))
       
       if(class(a)!="try-error"){
       letra <- a[[3]]
       
       #letra[,6] <- as.Date(letra[,6])
       #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
       #cand <- a[[2]]
       
       #names(letra1)=names(cand)
       
       #a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
       #condicional letra
       if(is.null(names(letra))){
         #print(letra)
         letra1 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
         letra1[,2] <- as.Date(letra1[,2])
         letra1[,3] <- as.Date(letra1[,3])
         cand <- a[[2]]
         
         names(letra1)=names(cand)
         
         a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
         
       }else{
         letra[,6] <- as.Date(letra[,6])
         letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
         cand <- a[[2]]
         
         names(letra1)=names(cand)
         
         a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
         
         
       }
       
       if(length(input$obs_tif)==0){
         figure(width = 1000,height = 400) 
       }else{
         
         b <- c()
         for(i in 1:length(input$obs_tif)){
           b[i] <- which(input$obs_tif[i]==as.character(a[,1]))
         }
         a <- a[-b,]
       }
         
         #calculo spline
         spline <- smooth.spline(a[,4],a[,7],spar = input$parametro_tif)
         
       y <-predict(spline,seq(0.1,20,0.1)*365)$y
       incProgress(1/2, detail = "Ajustando spline")
       
    #   plot(seq(0.1,20,0.1)*365,y)
    #   figure(width = 1000,height = 400) %>%
    #     ly_points(pto_sp_tif_dl()[,4],pto_sp_tif_dl()[,7],pto_sp_tif_dl(),hover=list("Nombre"=pto_sp_tif_dl()[,1],"Fecha de operación"=pto_sp_tif_dl()[,2])) %>%
    #     ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="green",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
    #     x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
         
       
       figure(width = 1000,height = 400) %>%
           ly_points(a[,4],a[,7],a,hover=list("Nombre"=a[,1],"Fecha de operación"=a[,2])) %>%
           ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="green",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
           x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)")
       
         }else{}
         
       })
      
    })#final isolate
  })
  
  #TIF-COMP
  output$c_tif_splines_new_comp <- renderRbokeh({
    #pongo dependencia
    input$boton18
    
    #
    isolate({
    withProgress(message = 'Graficando curva de rendimiento...', value = 0, {
      incProgress(1/2, detail = "Calculando alturas")
      # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
      # dat[,3] <- as.Date(as.character(dat[,3]))
      # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
      # 
      #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())[[2]]
      #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())
      a <- try(tabla_sp_tif_comp())
      
      if(class(a)!="try-error"){
      letra <- a[[3]]
      
      #letra[,6] <- as.Date(letra[,6])
      #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      #cand <- a[[2]]
      
      
      #names(letra1)=names(cand)
      
      #a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      
      #condicional letra
      if(is.null(names(letra))){
        #print(letra)
        letra1 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
        letra1[,2] <- as.Date(letra1[,2])
        letra1[,3] <- as.Date(letra1[,3])
        cand <- a[[2]]
        
        names(letra1)=names(cand)
        
        a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      
      }else{
        letra[,6] <- as.Date(letra[,6])
        letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
        cand <- a[[2]]
        
        names(letra1)=names(cand)
        
        a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
       
        
      }
      
      if(length(input$obs_tif_comp)==0){
        figure(width = 1000,height = 400) 
      }else{
        
        b <- c()
        for(i in 1:length(input$obs_tif_comp)){
          b[i] <- which(input$obs_tif_comp[i]==as.character(a[,1]))
        }
        a <- a[-b,]
      }
      
      #calculo spline
      spline <- smooth.spline(a[,4],a[,7],spar = input$parametro_tif_comp)
      
      y <-predict(spline,seq(0.1,20,0.1)*365)$y
      incProgress(1/2, detail = "Ajustando spline")
      
      #   plot(seq(0.1,20,0.1)*365,y)
      #   figure(width = 1000,height = 400) %>%
      #     ly_points(pto_sp_tif_dl()[,4],pto_sp_tif_dl()[,7],pto_sp_tif_dl(),hover=list("Nombre"=pto_sp_tif_dl()[,1],"Fecha de operación"=pto_sp_tif_dl()[,2])) %>%
      #     ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="green",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
      #     x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
      figure(width = 1000,height = 400) %>%
        ly_points(a[,4],a[,7],a,hover=list("Nombre"=a[,1],"Fecha de operación"=a[,2])) %>%
        ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="green",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
        x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)")
      
      }else{}
    })
    
    }) #final isolate
  })
  
  #VEBONOS
  output$c_veb_splines_new <- renderRbokeh({
    #pongo dependencia
    input$boton14
    
    #
    isolate({
    withProgress(message = 'Graficando curva de rendimiento...', value = 0, {
      incProgress(1/2, detail = "Calculando alturas")
      a <- try(tabla_sp_veb())
      
      if(class(a)!="try-error"){
      letra <- a[[3]]
      
      #letra[,6] <- as.Date(letra[,6])
      #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      #cand <- a[[2]]
      
      #names(letra1)=names(cand)
      
      #a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      #condicional letra
      if(is.null(names(letra))){
        #print(letra)
        letra1 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
        letra1[,2] <- as.Date(letra1[,2])
        letra1[,3] <- as.Date(letra1[,3])
        cand <- a[[2]]
        
        names(letra1)=names(cand)
        
        a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
    
      }else{
        letra[,6] <- as.Date(letra[,6])
        letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
        cand <- a[[2]]
        
        names(letra1)=names(cand)
        
        a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
        
        
      }
      
      if(length(input$obs_veb)==0){
        figure(width = 1000,height = 400) 
      }else{
        
        b <- c()
        for(i in 1:length(input$obs_veb)){
          b[i] <- which(input$obs_veb[i]==as.character(a[,1]))
        }
        a <- a[-b,]
      }
      
      #calculo spline
      spline <- smooth.spline(a[,4],a[,7],spar = input$parametro_veb)
      
      y <-predict(spline,seq(0.1,20,0.1)*365)$y
      incProgress(1/2, detail = "Ajustando spline")
      
      figure(width = 1000,height = 400) %>%
        ly_points(a[,4],a[,7],a,hover=list("Nombre"=a[,1],"Fecha de operación"=a[,2])) %>%
        ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="green",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
        x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)")
      
      }else{}
      
    })
    }) #final isolate
  })
  
  #VEBONO_COMP
  
  output$c_veb_splines_new_comp <- renderRbokeh({
    #pongo dependencia
    input$boton20
    
    #
    isolate({
    
    withProgress(message = 'Graficando curva de rendimiento...', value = 0, {
      incProgress(1/2, detail = "Calculando alturas")
      # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
      # dat[,3] <- as.Date(as.character(dat[,3]))
      # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
      # 
      #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())[[2]]
      #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp),car,pr=tf_sp())
      a <- try(tabla_sp_veb_comp())
      
      if(class(a)!="try-error"){
      letra <- a[[3]]
      
      #letra[,6] <- as.Date(letra[,6])
      #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      #cand <- a[[2]]
      
      #names(letra1)=names(cand)
      
      #a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      #condicional letra
      if(is.null(names(letra))){
        #print(letra)
        letra1 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
        letra1[,2] <- as.Date(letra1[,2])
        letra1[,3] <- as.Date(letra1[,3])
        cand <- a[[2]]
        
        names(letra1)=names(cand)
        
        a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
        
      }else{
        letra[,6] <- as.Date(letra[,6])
        letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
        cand <- a[[2]]
        
        names(letra1)=names(cand)
        
        a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
        
        
      }
      
      
      if(length(input$obs_veb_comp)==0){
        figure(width = 1000,height = 400) 
      }else{
        
        b <- c()
        for(i in 1:length(input$obs_veb_comp)){
          b[i] <- which(input$obs_veb_comp[i]==as.character(a[,1]))
        }
        a <- a[-b,]
      }
      
      #calculo spline
      spline <- smooth.spline(a[,4],a[,7],spar = input$parametro_veb_comp)
      
      y <-predict(spline,seq(0.1,20,0.1)*365)$y
      incProgress(1/2, detail = "Ajustando spline")
      
      #   plot(seq(0.1,20,0.1)*365,y)
      #   figure(width = 1000,height = 400) %>%
      #     ly_points(pto_sp_tif_dl()[,4],pto_sp_tif_dl()[,7],pto_sp_tif_dl(),hover=list("Nombre"=pto_sp_tif_dl()[,1],"Fecha de operación"=pto_sp_tif_dl()[,2])) %>%
      #     ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="green",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
      #     x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
      figure(width = 1000,height = 400) %>%
        ly_points(a[,4],a[,7],a,hover=list("Nombre"=a[,1],"Fecha de operación"=a[,2])) %>%
        ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="green",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
        x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)")
   
      }else{}
       })
    }) #final isolate
    
  })
  
  ##############
  ##############
  ##############
  #VALUE AT RISK 
  ##############
  ##############
  #funcion que lee los datos iniciales para asi determinar
  #las posibles fechas para el VaR
  data1 <- reactive({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file_data
    
    if (is.null(inFile))
      return(NULL)
    
    # read.table(inFile$datapath, header = input$header,
    #            sep = input$sep, quote = input$quote)
    a <- read.delim2(inFile$datapath, header = input$header,
              sep = input$sep, quote = input$quote)
    
    #ordeno la data de fecha mas reciente a fecha mas antigua
    a[,1] <- as.Date(a[,1])
    a <- a[order(a[,1],decreasing = TRUE),]
    
    #seleciono 252 obs
    a <- a[1:252,]
    
    return(a)
    
  })
  
  #variable que uso para el calculo
  #una vez seleccionada la fecha procedo a tomar solo la data
  #necesaria de la data completa
  data <- reactive({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file_data
    
    if (is.null(inFile))
      return(NULL)
    
    # read.table(inFile$datapath, header = input$header,
    #            sep = input$sep, quote = input$quote)
    a <- try(read.delim2(inFile$datapath, header = input$header,
                     sep = input$sep, quote = input$quote))
    
    if(class(a)!="try-error"){
    
    #ordeno la data de fecha mas reciente a fecha mas antigua
    a[,1] <- as.Date(a[,1])
    a <- a[order(a[,1],decreasing = TRUE),]
    
    #seleciono 252 obs segun fecha seleccionada
    
    a <- a[which(input$date_var==a[,1]):(251+which(input$date_var==a[,1])),]
    
    return(a)
    }else{return(NULL)}
  })
  
  ###############################################################################
  ###############################################################################
  #################################    Datos    #################################
  ###############################################################################
  ###############################################################################
  
  output$datatable<-DT::renderDataTable({
    #if(is.null(data())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    a <- try(data())
    if(class(a)!="try-error"){
      DT::datatable(a)
    }else{return(as.data.frame("Error, favor seleccionar otro delimitador"))}
    
    })
  
  #data distribuciones por instrumento
  
  datadist <- reactive({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file_data_dist
    
    if (is.null(inFile))
      return(NULL)
    
    # read.table(inFile$datapath, header = input$header,
    #            sep = input$sep, quote = input$quote)
    a <- try(read.delim2(inFile$datapath, header = input$header_dist,
                         sep = input$sep_dist, quote = input$quote_dist))
    
    if(class(a)!="try-error"){
      return(a)
      #ordeno la data de fecha mas reciente a fecha mas antigua
      #a[,1] <- as.Date(a[,1])
      #a <- a[order(a[,1],decreasing = TRUE),]
      
      #seleciono 252 obs segun fecha seleccionada
      
      #a <- a[which(input$date_var==a[,1]):(251+which(input$date_var==a[,1])),]
      
      #return(a)
    }else{return(NULL)}
  })
  
  
  output$data_dist<-renderDataTable({
    #if(is.null(data())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    a <- try(datadist())
    if(class(a)!="try-error"){
      datatable(a)
    }else{return(as.data.frame("Error, favor seleccionar otro delimitador"))}
    
  })
  
  
  #data nueva
  output$datatable1<-renderDataTable({
    if(is.null(data())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    datatable(data())
  })
  
 #POSICIONES
  
  data_pos <- reactive({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file_data_pos
    
    if (is.null(inFile))
      return(NULL)
    
    read.table(inFile$datapath, header = input$header_pos,
               sep = input$sep_pos, quote = input$quote_pos)
  
  })
  
  ###############################################################################
  ###############################################################################
  #################################    Datos    #################################
  ###############################################################################
  ###############################################################################
  
  output$datatable_pos<-DT::renderDataTable({
    #if(is.null(data_pos())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    #datatable(data_pos())
    a <- data_pos()
    if(class(a)!="try-error"){
      a
    }else{return(as.data.frame("Error, favor seleccionar otro delimitador"))}
    
    
  })
  
  
  #MUESTRO FECHAS DISPONIBLES PARA CALCULAR VAR
  #funcion auxiliar
  fe_var <- reactive({
    inFile <- input$file_data
    
    if (is.null(inFile))
      return(NULL)
    A <- read.delim2(inFile$datapath, header = input$header,
                     sep = input$sep, quote = input$quote)
    A[,1] <- as.Date(A[,1])
    A <- A[order(A[,1],decreasing = TRUE),]
    obs <- nrow(A)-252
    fechas <- A[1:obs,1]
    return(fechas)
  })
  
  #output
  output$fechas_var <- renderUI({ 
    selectInput("date_var", "Seleccionar fecha", fe_var(),multiple = FALSE)
  })
  
  #fecha elegida
  output$fecha_elegida <- renderPrint({input$date_var})
  
  
   #DISTRIBUCION
  #CALCULO RENDIMIENTOS
  
  output$dat_rend<-renderDataTable({
    if(is.null(data())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    data1 <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]
    
    
    for(i in 1:(ncol(data())-1)){
      data1[,i] <- diff(log(data()[,i+1]))
    }
    
    #datatable(head(data1))
    datatable(data1)
  })
  
  #muestro posibles elecciones de titulos
  output$instrumento <- renderUI({ 
    selectInput("inst", "Seleccionar títulos",choices =  names(data())[-1] )
  })
  
  #eleccion
  output$elec <- renderPrint({input$inst})
  
  #advertencia titulos con problemas
  output$advertencia_dist_varp_el <- renderPrint({
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    if(sum(a)>=1){
      print("Existen problemas con los rendimientos de los títulos")
      print(names(rend)[which(a==1)])
      print("los mismos se excluirán del estudio")
    }else{
      print("No hay problemas con los rendimientos")
    }
    
  })
  
  
  #VaR portafolio - eleccion distribucion
  #creo variable auxiliar
  opcion <- reactive({
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #titulos donde hay problema
    b <- which(a==1)
    
    if(sum(a)>=1){
      # print("Existen problemas con los rendimientos de los títulos")
      # print(names(rend)[which(a==1)])
      # print("los mismos se excluirán del estudio")
        rend <- rend[,-b]
      return(names(rend))
    }else{
      #print("No hay problemas con los rendimientos")
      return(names(rend))
    }
    
  })
  
  output$instrumento_varp <- renderUI({ 
    #selectInput("inst_varp", "Seleccionar títulos",choices =  names(data())[-1] )
    selectInput("inst_varp", "Seleccionar títulos",choices =  opcion() )
    })
  
  #eleccion
  output$elec_varp <- renderPrint({input$inst_varp})
  
  #muestro resultados de ajuste
  output$result <- renderTable({
    if(is.null(data())){return()}
    n <- which(input$inst==names(data()))
    dat <- data()[,n]
    dat1 <- diff(log(dat))
    dat2 <- useFitdist(dat1)
    dat2$res.matrix
    #AHORRO.BA <-uFitdifflog(data()$ahorro)
    #AHORRO.BA$res.matrix
  },
  rownames = TRUE, striped = TRUE,
  hover = TRUE, bordered = TRUE
  )
  
  #resultados ajuste distribucion VaR portafolio
  output$result_varp <- renderTable({
    if(is.null(data())){return()}
    #a <- try(data())
    
    #if(class(a)!="try-error"){
    n <- which(input$inst_varp==names(data()))
    dat <- data()[,n]
    dat1 <- diff(log(dat))
    dat2 <- try(useFitdist(dat1))
    
    if(class(dat2)!="try-error"){
    return(dat2$res.matrix)
      }else{}
    #}else{}
  }
  #,
  #rownames = TRUE, striped = TRUE,
  #hover = TRUE, bordered = TRUE
  )
  
  #muestro valores de los paramentros ajustados
  #defino funciones auxiliares
  #Calcula el log() diff() y useFitdist()
  uFitdifflog<-function(data) {
    useFitdist(diff(log(data)))
  }
  ##Funciones para calcular parámetros de las distribuciones
  ##Normal
  mediaNormal <- function(data)
  { uFitdifflog(data)$fit.list$Normal$estimate[1] }
  sdNormal <- function(data)
  { uFitdifflog(data)$fit.list$Normal$estimate[2] }
  ##Esponencial
  lambdaExponential <- function(data)
  { uFitdifflog(data)$fit.list$Exponential$estimate[1]}
  ##Logistica
  s1Logistic <- function(data)
  { uFitdifflog(data)$fit.list$Logistic$estimate[1] }
  s2Logistic <- function(data)
  { uFitdifflog(data)$fit.list$Logistic$estimate[2] }
  ##Cauchy
  muCauchy <- function(data)
  { uFitdifflog(data)$fit.list$Cauchy$estimate[1] }
  thetaCauchy <- function(data)
  { uFitdifflog(data)$fit.list$Cauchy$estimate[2] }
  ##Beta
  s1Beta <- function(data)
  { uFitdifflog(data)$fit.list$Beta$estimate[1] }
  s2Beta <- function(data)
  { uFitdifflog(data)$fit.list$Beta$estimate[2] }
  ##Chi Cuadrado
  dfChisquare <- function(data)
  { uFitdifflog(data)$fit.list$`Chi-square`$estimate[1] }
  ##Uniforme
  minUniform <- function(data)
  { uFitdifflog(data)$fit.list$Uniform$estimate[1] }
  maxUniform <- function(data)
  { uFitdifflog(data)$fit.list$Uniform$estimate[2] }
  ##Gamma
  mGamma <- function(data)
  { uFitdifflog(data)$fit.list$Gamma$estimate[1] }
  lambdaGamma <- function(data)
  { uFitdifflog(data)$fit.list$Gamma$estimate[2] }
  ##Lognormal
  mediaLognormal <- function(data)
  { uFitdifflog(data)$fit.list$Lognormal$estimate[1] }
  sdLognormal <- function(data)
  { uFitdifflog(data)$fit.list$Lognormal$estimate[2] }
  ##Weibull
  s1Weibull <- function(data)
  { uFitdifflog(data)$fit.list$Weibull$estimate[1] }
  s2Weibull <- function(data)
  { uFitdifflog(data)$fit.list$Weibull$estimate[2] }
  ##Fisher
  df1F <- function(data)
  { uFitdifflog(data)$fit.list$F$estimate[1] }
  df2F <- function(data)
  { uFitdifflog(data)$fit.list$F$estimate[2] }
  ##T-student
  dfStudent <- function(data)
  { uFitdifflog(data)$fit.list$Student$estimate[1] }
  ##Gompertz
  s1Gompertz <- function(data)
  { uFitdifflog(data)$fit.list$Gompertz$estimate[1] }
  s2Gompertz <- function(data)
  { uFitdifflog(data)$fit.list$Gompertz$estimate[2] }
  
  
  #Nombre de parámetros con valores de dichos parámetros
  distParams<-function(condition, data) {
    v<-switch(condition,
              "Normal"=c(NLABEL1,mediaNormal(data),NLABEL2,sdNormal(data)),
              "Exponential"=c(ELABEL1,lambdaExponential(data), NULL, NULL),
              "Cauchy"=c(CLABEL1,muCauchy(data),CLABEL2,thetaCauchy(data)),
              "Logistic"=c(LLABEL1,s1Logistic(data),LLABEL2,s2Logistic(data)),
              "Beta"=c(BLABEL1,s1Beta(data),BLABEL2,s2Beta(data)),
              "Chi-square"=c(CCLABEL,dfChisquare(data), NULL, NULL),
              "Uniform"=c(ULABEL1,minUniform(data),ULABEL2,maxUniform(data)),
              "Gamma"=c(GLABEL1,mGamma(data),GLABEL2,lambdaGamma(data)),
              "Lognormal"=c(LNLABEL1,mediaLognormal(data),LNLABEL2,sdLognormal(data)),
              "Weibull"=c(WLABEL1,s1Weibull(data),WLABEL2,s2Weibull(data)),
              "F"=c(FLABEL1,df1F(data),FLABEL2,df2F(data)),
              "Student"=c(TLABEL1,dfStudent(data), NULL, NULL),
              "Gompertz"=c(GOLABEL1,s1Gompertz(data),GOLABEL2,s2Gompertz(data))
    )
  }
  
  #Caja con parámetros de distribución
  distBox<-function(label1, out1, label2, out2) {
    box( width = 12, status ="success",
         h5(label1), out1,
         h5(label2), out2
    )
  }
  
  Distrib<- reactive ({
    n <- which(input$inst==names(data()))
    dat <- data()[,n]
    #dat1 <- diff(log(dat))
    v<-distParams(input$distsA, dat)
    distBox(v[1],v[2],v[3],v[4])
  })
  
  output$parametros_dist<-renderUI({
    if(is.null(data())){return()}
    Distrib()
  })
  
  #var de portafolio
  Distrib_varp<- reactive ({
    n <- which(input$inst_varp==names(data()))
    dat <- data()[,n]
    v<-distParams(input$distsA_varp, dat)
    distBox(v[1],v[2],v[3],v[4])
  })
  
  output$parametros_dist_varp<-renderUI({
    if(is.null(data())){return()}
    Distrib_varp()
  })
  
  #calculo VaR
  #defino funcion auxiliar
  ##Función para mostrar el VAR y VART en riesgo
  VarR<-function(p,data,condition) {
    switch(condition,
           "Normal"    =c(VARINNOR_TEXT,
                          varnormal(p, as.numeric(data$fit.list$Normal$estimate[1]),as.numeric(data$fit.list$Normal$estimate[2])),
                          VARTINNOR_TEXT,
                          esnormal(p, as.numeric(data$fit.list$Normal$estimate[1]),as.numeric(data$fit.list$Normal$estimate[2])) ) ,
           "Exponential" =c(VARINEXP_TEXT,
                            varexponential(p, as.numeric(data$fit.list$Exponential$estimate[1])),
                            VARTINEXP_TEXT,
                            esexponential(p, as.numeric(data$fit.list$Exponential$estimate[1])) ),
           "Cauchy"    =c(VARINCAU_TEXT,
                          varCauchy(p, as.numeric(data$fit.list$Cauchy$estimate[1]),as.numeric(data$fit.list$Cauchy$estimate[2])),
                          VARTINCAU_TEXT,
                          esCauchy(p, as.numeric(data$fit.list$Cauchy$estimate[1]),as.numeric(data$fit.list$Cauchy$estimate[2])) ),
           "Logistic"  =c(VARINLOG_TEXT,
                          varlogistic(p, as.numeric(data$fit.list$Logistic$estimate[1]),as.numeric(data$fit.list$Logistic$estimate[2])),
                          VARTINLOG_TEXT,
                          eslogistic(p, as.numeric(data$fit.list$Logistic$estimate[1]),as.numeric(data$fit.list$Logistic$estimate[2])) ),
           "Beta"      =c(VARINBET_TEXT,
                          NULL,
                          VARTINBET_TEXT,
                          NULL ),
           "Chi-square"=c(VARINCHC_TEXT,
                          NULL,
                          VARTINCHC_TEXT,
                          NULL),
           "Uniform"   =c(VARINUNF_TEXT,
                          varuniform(p, as.numeric(data$fit.list$Uniform$estimate[1]), as.numeric(data$fit.list$Uniform$estimate[2])),
                          VARTINUNF_TEXT,
                          esuniform(p, as.numeric(data$fit.list$Uniform$estimate[1]), as.numeric(data$fit.list$Uniform$estimate[2])) ),
           "Gamma"     =c(VARINGAM_TEXT,
                          varGamma(p, as.numeric(data$fit.list$Gamma$estimate[1]), as.numeric(data$fit.list$Gamma$estimate[2])),
                          VARTINGAM_TEXT,
                          esGamma(p, as.numeric(data$fit.list$Gamma$estimate[1]), as.numeric(data$fit.list$Gamma$estimate[2])) ),
           "Lognormal" =c(VARINLGN_TEXT,
                          varlognorm(p, as.numeric(data$fit.list$Lognormal$estimate[1]), as.numeric(data$fit.list$Lognormal$estimate[2])),
                          VARTINLGN_TEXT,
                          eslognorm(p, as.numeric(data$fit.list$Lognormal$estimate[1]), as.numeric(data$fit.list$Lognormal$estimate[2])) ),
           "Weibull"   =c(VARINWEI_TEXT,
                          varWeibull(p, as.numeric(data$fit.list$Weibull$estimate[1]),as.numeric(data$fit.list$Weibull$estimate[2])),
                          VARTINWEI_TEXT,
                          esWeibull(p, as.numeric(data$fit.list$Weibull$estimate[1]),as.numeric(data$fit.list$Weibull$estimate[2])) ),
           "F"         =c(VARINF_TEXT,
                          varF(p, as.numeric(data$fit.list$F$estimate[1]), as.numeric(data$fit.list$F$estimate[2])),
                          VARTINF_TEXT,
                          esF(p, as.numeric(data$fit.list$F$estimate[1]), as.numeric(data$fit.list$F$estimate[2])) ),
           "Student"   =c(VARINTST_TEXT,
                          varT(p, as.numeric(data$fit.list$Student$estimate[1])),
                          VARTINTST_TEXT,
                          esT(p, as.numeric(data$fit.list$Student$estimate[1])) ),
           "Gompertz"  =c(VARINGOM_TEXT,
                          NULL,
                          VARTINGOM_TEXT,
                          NULL)
    )
  }
  
  #datos VaR
  # output$datos_var <- renderTable({
  #   if(is.null(data())){return()}
  #   n <- which(input$inst==names(data()))
  #   dat <- data()[,n]
  #   dat1 <- as.numeric(diff(log(dat)))
  #   dat2 <- useFitdist(dat1)
  #   #dat2$res.matrix
  #   #data.frame(mu=as.numeric(dat2$fit.list$Normal$estimate[1]),sd=as.numeric(dat2$fit.list$Normal$estimate[2]))
  #   #varnormal(as.numeric(input$porVar0), as.numeric(dat2$fit.list$Normal$estimate[1]),as.numeric(dat2$fit.list$Normal$estimate[2]))
  #   varnormal(as.numeric(sub(",",".",input$porVar)), as.numeric(dat2$fit.list$Normal$estimate[1]),as.numeric(dat2$fit.list$Normal$estimate[2]))
  #   #c(class(input$porVar0),class(as.numeric(input$porVar0)),input$porVar0,as.numeric(sub(",",".",input$porVar0)))
  #   })
  
  #output del VaR
  output$VaR_inicial<-renderUI({
    if(is.null(data())){return()}
    n <- which(input$inst==names(data()))
    dat <- data()[,n]
    dat1 <- diff(log(dat))
    dat2 <- useFitdist(dat1)
    v<-VarR(p = as.numeric(sub(",",".",input$porVar)),data = dat2,condition = input$distsA)
    box( width=12, status="success",
         withMathJax(v[1]), br(),
         withMathJax( sprintf("$$VaR_p(X) = %0.05s$$", v[2] ) ), br(),
         withMathJax(v[3]), br(),
         withMathJax( sprintf("$$TVaR_p(X) = %0.05s$$", v[4] ) )
    )
  })
  
  #tabla dinamica que me guarda la distribucion de cada instrumento
  #creo funcion auxiliar
  varp_dist <- function(data,ind,dist){
    
    # n <- which(input$inst_varp==names(data()))
    # a[,(n-1)] <- input$distsA_varp
    # a
    n <- which(ind==names(data))
    data[,n] <- dist
    return(data)
    
  }
  
  distribuciones <- reactive({
    #a <- as.data.frame(matrix(NA,nrow = 1,ncol = (ncol(data())-1)))
    a <- as.data.frame(matrix("Nada",nrow = 1,ncol = length(opcion())))
    
    names(a) <- opcion()
    rownames(a) <- "Distribuciones"
    a <- varp_dist(data = a ,ind =input$inst_varp  ,dist =input$distsA_varp )
    #write.table(a,paste(getwd(),"data","distribuciones.txt",sep = "/"),row.names = FALSE)
    
    #a
   if(input$seleccion_varp==1){
    #write.table(a,paste(getwd(),"data","distribuciones.txt",sep = "/"),row.names = FALSE)
    b <- read.csv(paste(getwd(),"data","distribuciones.txt",sep = "/"),sep="")
    c <- varp_dist(data = b ,ind =input$inst_varp ,dist =input$distsA_varp )
    #c
    
    #actualizo
    write.table(c,paste(getwd(),"data","distribuciones.txt",sep = "/"),row.names = FALSE)
    c
   }else{
     write.table(a,paste(getwd(),"data","distribuciones.txt",sep = "/"),row.names = FALSE)
     a
   }
    
    
    })

  
  output$dist_varp <- renderTable({
    if(is.null(data())){return()}
    distribuciones()
    # a <- as.data.frame(matrix(NA,nrow = 1,ncol = (ncol(data())-1)))
    # names(a) <- names(data())[-1]
    # rownames(a) <- "Distribuciones"
    # 
    # b <- varp_dist(data = a ,ind =input$inst_varp  ,dist =input$distsA_varp )
    # b
    
  })
  
  #ELIJO DISTRIBUCIONES MEDIANTE UN ARCHIVO
  output$dist_elegir <- renderTable({
   # if(is.null(data())){return()}
  #  distribuciones()
  if(input$seleccion_dist==0){
    return()
  }else if(input$seleccion_dist==1){
    #as.data.frame(rep(1,10))
    #b <- read.csv(paste(getwd(),"data","distribuciones2.txt",sep = "/"),sep="")
    #b
    datadist()
  }
    
  })
  
  #seccion VaR Parametrico Normal
  output$rend_varn<-DT::renderDataTable({
    if(is.null(data())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    data1 <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]
    
    
    for(i in 1:(ncol(data())-1)){
      data1[,i] <- diff(log(data()[,i+1]))
    }
    
    #datatable(head(data1))
    DT::datatable(data1)
  })
  
  
  #parametros u y sigma de cada titulo
  output$parametros_varn<-DT::renderDataTable({
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo problemas con rend
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      #creo data frame para distribuciones
      data1 <- as.data.frame(matrix(0,nrow = 2,ncol = ncol(rend) ))
      names(data1) <- names(data())[-c(1,(b+1))]
      rownames(data1) <- c("Media","Desviación estandar")
      
      for(i in 1:ncol(data1)){
        data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[1]
        data1[2,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
        
      }
      return(data1)
 
    }
    
    #creo data frame para distribuciones
    data1 <- as.data.frame(matrix(0,nrow = 2,ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]
    rownames(data1) <- c("Media","Desviación estandar")
    
    for(i in 1:ncol(data1)){
    #   if(anyNA(rend[,i])){
    #     a <- which(is.na(rend[,i])|is.infinite(rend[,i]))
    #     data1[1,i] <- as.numeric(fitdistr(rend[-a,i],"normal")$estimate)[1]
    #     data1[2,i] <- as.numeric(fitdistr(rend[-a,i],"normal")$estimate)[2]
    #   }else{
    # data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[1]
    # data1[2,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
    #   }
       data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[1]
       data1[2,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      
    }
    data1
  })
  
  #elijo % del VaR
  output$porcentaje_varn <- renderPrint({
    print(as.numeric(sub(",",".",input$porVarn)))
  })
  
  
  #creo tabla para VaR individuales metodo parametrico
  output$tabla_varn<-DT::renderDataTable({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
  
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      #creo estructura de tabla
      tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 4))
      names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
      rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")
      
      data1 <- as.data.frame(matrix(0,nrow = 1,ncol = ncol(rend)))
      names(data1) <- names(data())[-c(1,(b+1))]
      
      
      for(i in 1:ncol(data1)){
        data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      }
      
      #relleno desviaciones estandar
      tabla[,1] <- c(as.numeric(data1),NA)
      
      # #relleno valor nominal
      tabla[,2] <- c(data_pos()[-b,2],sum(data_pos()[-b,2]))
      
      # #relleno Vares individuales
      tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
      tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
      
      #relleno VaR en porcentaje
      tabla[,4] <- tabla[,3]*100/tabla[nrow(tabla),3]
      tabla[nrow(tabla),4] <- sum(tabla[1:((nrow(tabla))-1),4])
      
      return(DT::datatable(tabla, options = list(paging = FALSE)))
      
    }
    
    #creo estructura de tabla
    tabla <- as.data.frame(matrix(0,nrow = (ncol(data())),ncol = 4))
    names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
    rownames(tabla) <- c(names(data())[-1],"Totales")
    
    data1 <- as.data.frame(matrix(0,nrow = 1,ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]
    
    
    for(i in 1:ncol(data1)){
      # if(anyNA(rend[,i])){
      #   a <- which(is.na(rend[,i])|is.infinite(rend[,i]))
      #   data1[1,i] <- as.numeric(fitdistr(rend[-a,i],"normal")$estimate)[2]
      # }else{
      #   data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      # }
      data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      
    }
    
    #relleno desviaciones estandar
     tabla[,1] <- c(as.numeric(data1),NA)
  
    # #relleno valor nominal
     tabla[,2] <- c(data_pos()[,2],sum(data_pos()[,2]))
    
    # #relleno Vares individuales
     tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
     tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
    
    #relleno VaR en porcentaje
     tabla[,4] <- tabla[,3]*100/tabla[nrow(tabla),3]
     tabla[nrow(tabla),4] <- sum(tabla[1:((nrow(tabla))-1),4])
     
     datatable(tabla, options = list(paging = FALSE))
  })
  
  #calculo VaR normal Portafolio
  output$varn_portafolio <- renderPrint({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      #creo estructura de tabla
      tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 4))
      names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
      rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")
      
      data1 <- as.data.frame(matrix(0,nrow = 1,ncol = ncol(rend)))
      names(data1) <- names(data())[-c(1,(b+1))]
      
      
      for(i in 1:ncol(data1)){
        data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      }
      
      #relleno desviaciones estandar
      tabla[,1] <- c(as.numeric(data1),NA)
      
      # #relleno valor nominal
      tabla[,2] <- c(data_pos()[-b,2],sum(data_pos()[-b,2]))
      
      # #relleno Vares individuales
      tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
      tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
      
      
      #calculo matriz de correlaciones (diagonal de 1's)
      S<- cor(rend)
      
      #VaR
      var_ind <- tabla[1:(nrow(tabla)-1),3]
      #var_ind%*%S
      VaR <- sqrt(var_ind%*%S%*%as.matrix(var_ind))
      return(VaR)
 
      
    }#final if problemas de rend
    
    #creo estructura de tabla
    tabla <- as.data.frame(matrix(0,nrow = (ncol(data())),ncol = 3))
    names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual")
    rownames(tabla) <- c(names(data())[-1],"Totales")
    
    
    data1 <- as.data.frame(matrix(0,nrow = 1,ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]
    
    
    for(i in 1:ncol(data1)){
     data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
    }
    
    #relleno desviaciones estandar
    tabla[,1] <- c(as.numeric(data1),NA)
    
    # #relleno valor nominal
    tabla[,2] <- c(data_pos()[,2],sum(data_pos()[,2]))
    
    # #relleno Vares individuales
    tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
    tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
    
    #calculo matriz de correlaciones (diagonal de 1's)
    S<- cor(rend)
    
    #VaR
     var_ind <- tabla[1:(nrow(tabla)-1),3]
     #var_ind%*%S
     VaR <- sqrt(var_ind%*%S%*%as.matrix(var_ind))
     VaR

    
    
  })
  
  #advertencia por problemas en rend
  output$advertencia_varn <-renderPrint({
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
         a[i] <- 1
      }
    }
    
    if(sum(a)>=1){
      print("Existen problemas con los rendimientos de los títulos")
      print(names(rend)[which(a==1)])
      print("los mismos se excluirán del estudio")
    }else{
    print("No hay problemas con los rendimientos")
    }
    
  })
  
  #GRAFICOS
  #VALOR NOMINAL
  output$grafico_vnominal <- renderPlotly({ 
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      #creo estructura de tabla
      tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 4))
      names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
      rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")
      
      data1 <- as.data.frame(matrix(0,nrow = 1,ncol = ncol(rend)))
      names(data1) <- names(data())[-c(1,(b+1))]
      
      
      for(i in 1:ncol(data1)){
        data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      }
      
      #relleno desviaciones estandar
      tabla[,1] <- c(as.numeric(data1),NA)
      
      # #relleno valor nominal
      tabla[,2] <- c(data_pos()[-b,2],sum(data_pos()[-b,2]))
      
      # #relleno Vares individuales
      tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
      tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
      
      #relleno VaR en porcentaje
      tabla[,4] <- tabla[,3]*100/tabla[nrow(tabla),3]
      tabla[nrow(tabla),4] <- sum(tabla[1:((nrow(tabla))-1),4])
      
      #return(tabla)
      
    }else{
    
    # #creo estructura de tabla
    tabla <- as.data.frame(matrix(0,nrow = (ncol(data())),ncol = 4))
    names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
    rownames(tabla) <- c(names(data())[-1],"Totales")

    data1 <- as.data.frame(matrix(0,nrow = 1,ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]


    for(i in 1:ncol(data1)){
      # if(anyNA(rend[,i])){
      #   a <- which(is.na(rend[,i])|is.infinite(rend[,i]))
      #   data1[1,i] <- as.numeric(fitdistr(rend[-a,i],"normal")$estimate)[2]
      # }else{
      #   data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      # }
      data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]

    }

    #relleno desviaciones estandar
    tabla[,1] <- c(as.numeric(data1),NA)

    # #relleno valor nominal
    tabla[,2] <- c(data_pos()[,2],sum(data_pos()[,2]))

    # #relleno Vares individuales
    tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
    tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])

    #relleno VaR en porcentaje
    tabla[,4] <- tabla[,3]*100/tabla[nrow(tabla),3]
    tabla[nrow(tabla),4] <- sum(tabla[1:((nrow(tabla))-1),4])

    }
    
    pie <- cbind.data.frame(rownames(tabla)[-nrow(tabla)],tabla[1:(nrow(tabla)-1),2])
    names(pie) <- c("Titulo","nominal")
    
    p <- plot_ly(pie, labels = ~Titulo, values = ~nominal, type = 'pie') %>%
      layout(title = 'Valor nominal',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    
    
    p
    
    
    })
  
  #VARES INDIVIDUALES
  output$grafico_vind <- renderPlotly({ 
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      #creo estructura de tabla
      tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 4))
      names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
      rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")
      
      data1 <- as.data.frame(matrix(0,nrow = 1,ncol = ncol(rend)))
      names(data1) <- names(data())[-c(1,(b+1))]
      
      
      for(i in 1:ncol(data1)){
        data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      }
      
      #relleno desviaciones estandar
      tabla[,1] <- c(as.numeric(data1),NA)
      
      # #relleno valor nominal
      tabla[,2] <- c(data_pos()[-b,2],sum(data_pos()[-b,2]))
      
      # #relleno Vares individuales
      tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
      tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
      
      #relleno VaR en porcentaje
      tabla[,4] <- tabla[,3]*100/tabla[nrow(tabla),3]
      tabla[nrow(tabla),4] <- sum(tabla[1:((nrow(tabla))-1),4])
      
      #return(tabla)
      
    }else{
    
    # #creo estructura de tabla
    tabla <- as.data.frame(matrix(0,nrow = (ncol(data())),ncol = 4))
    names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
    rownames(tabla) <- c(names(data())[-1],"Totales")
    
    data1 <- as.data.frame(matrix(0,nrow = 1,ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]
    
    
    for(i in 1:ncol(data1)){
      # if(anyNA(rend[,i])){
      #   a <- which(is.na(rend[,i])|is.infinite(rend[,i]))
      #   data1[1,i] <- as.numeric(fitdistr(rend[-a,i],"normal")$estimate)[2]
      # }else{
      #   data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      # }
      data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      
    }
    
    #relleno desviaciones estandar
    tabla[,1] <- c(as.numeric(data1),NA)
    
    # #relleno valor nominal
    tabla[,2] <- c(data_pos()[,2],sum(data_pos()[,2]))
    
    # #relleno Vares individuales
    tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
    tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
    
    #relleno VaR en porcentaje
    tabla[,4] <- tabla[,3]*100/tabla[nrow(tabla),3]
    tabla[nrow(tabla),4] <- sum(tabla[1:((nrow(tabla))-1),4])
    
    }
    
    
    pie <- cbind.data.frame(rownames(tabla)[-nrow(tabla)],tabla[1:(nrow(tabla)-1),3])
    names(pie) <- c("Titulo","ind")
    
    p <- plot_ly(pie, labels = ~Titulo, values = ~ind, type = 'pie') %>%
      layout(title = 'VaRes Individuales',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    
    
    p
    
    
  })
    
  #COMPARATIVO VAR INDIVIDUAL VS VAR PORTAFOLIO
  output$grafico_vcomp <- renderPlotly({ 
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      #creo estructura de tabla
      tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 4))
      names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
      rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")
      
      data1 <- as.data.frame(matrix(0,nrow = 1,ncol = ncol(rend)))
      names(data1) <- names(data())[-c(1,(b+1))]
      
      
      for(i in 1:ncol(data1)){
        data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      }
      
      #relleno desviaciones estandar
      tabla[,1] <- c(as.numeric(data1),NA)
      
      # #relleno valor nominal
      tabla[,2] <- c(data_pos()[-b,2],sum(data_pos()[-b,2]))
      
      # #relleno Vares individuales
      tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
      tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
      
      #relleno VaR en porcentaje
      tabla[,4] <- tabla[,3]*100/tabla[nrow(tabla),3]
      tabla[nrow(tabla),4] <- sum(tabla[1:((nrow(tabla))-1),4])
      
      #return(tabla)
      
    }else{
      
      # #creo estructura de tabla
      tabla <- as.data.frame(matrix(0,nrow = (ncol(data())),ncol = 4))
      names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
      rownames(tabla) <- c(names(data())[-1],"Totales")
      
      data1 <- as.data.frame(matrix(0,nrow = 1,ncol = (ncol(data())-1)))
      names(data1) <- names(data())[-1]
      
      
      for(i in 1:ncol(data1)){
        # if(anyNA(rend[,i])){
        #   a <- which(is.na(rend[,i])|is.infinite(rend[,i]))
        #   data1[1,i] <- as.numeric(fitdistr(rend[-a,i],"normal")$estimate)[2]
        # }else{
        #   data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
        # }
        data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
        
      }
      
      #relleno desviaciones estandar
      tabla[,1] <- c(as.numeric(data1),NA)
      
      # #relleno valor nominal
      tabla[,2] <- c(data_pos()[,2],sum(data_pos()[,2]))
      
      # #relleno Vares individuales
      tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",as.numeric(sub(",",".",input$porVarn)))),0,1))
      tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
      
      #relleno VaR en porcentaje
      tabla[,4] <- tabla[,3]*100/tabla[nrow(tabla),3]
      tabla[nrow(tabla),4] <- sum(tabla[1:((nrow(tabla))-1),4])
      
    }
    
    #CALCULO VAR
    #calculo matriz de correlaciones (diagonal de 1's)
    S<- cor(rend)
    
    #VaR
    var_ind <- tabla[1:(nrow(tabla)-1),3]
    #var_ind%*%S
    VaR <- sqrt(var_ind%*%S%*%as.matrix(var_ind))
    
    
    p <- plot_ly(marker = list(color = 'royalblue1',
                               line = list(color = 'rgb(8,48,107)',
                                           width = 3))) %>%
      add_bars(
        x = c("Individual"),
        y = c(sum(tabla[,3])),
        width = 0.3,
        marker = list(
          color = 'royalblue1'
        ),
        name = 'Suma VaRes individuales'
      ) %>%
      add_bars(
        x = c("Portafolio"),
        y = c(VaR),
        width = 0.3,
        marker = list(
          color = 'mediumseagreen'
        ),
        name = 'VaR Portafolio'
      )
    
    p
    
    
  })
  
  #AVISO DATOS VAR
  output$aviso_datos_var <- renderPrint({
    if(is.null(data())|is.null(data_pos())){return()}
    
    a <- data()
    b <- data_pos() 
    
    if(sum(names(a)[-1]==as.character(b[,1]))==nrow(b)){
      print("Coincidencia en nombres")
    }else{
      print("Problemas coincidencias nombres, revisar data")
    }
    
    
  })
  
  #ADVERTENCIA VAR SIMULACION HISTORICA
  output$advertencia_varsh <-renderPrint({
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    if(sum(a)>=1){
      print("Existen problemas con los rendimientos de los títulos")
      print(names(rend)[which(a==1)])
      print("los mismos se excluirán del estudio")
    }else{
      print("No hay problemas con los rendimientos")
    }
    
  })
  
  
  #GRAFICO DE PESOS
  output$grafico_pesos <- renderPlotly({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a1 <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a1[i] <- 1
      }
    }
    

    #cuando hay problemas con rend
    #titulos donde hay problema
    b1 <- which(a1==1)
    if(sum(a1)>=1){
      a <- data_pos()[-b1,]
      b <- sum(a[,2])
      
      a$pesos <- a[,2]/b
      
      pie <- cbind.data.frame(as.character(a[,1]),a[,3])
      names(pie) <- c("Titulo","Pesos")
      
      p <- plot_ly(pie, labels = ~Titulo, values = ~Pesos, type = 'pie') %>%
        layout(title = 'Pesos según valor nominal',
               xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
               yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
      
      
      p
      
      
    }else{
      
      a <- data_pos()
      b <- sum(a[,2])
      
      a$pesos <- a[,2]/b
      
      pie <- cbind.data.frame(as.character(a[,1]),a[,3])
      names(pie) <- c("Titulo","Pesos")
      
      p <- plot_ly(pie, labels = ~Titulo, values = ~Pesos, type = 'pie') %>%
        layout(title = 'Pesos según valor nominal',
               xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
               yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
      
      
      p
    }
    
    
    
    
  })
  
  #POSICION TOTAL
  output$suma_posvarsh <- renderPrint({
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a1 <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a1[i] <- 1
      }
    }
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b1 <- which(a1==1)
    if(sum(a1)>=1){
      a <- data_pos()[-b1,]
      sum(a[,2])
      
      
    }else{
      sum(data_pos()[,2])
     
    }
    

    
  })
  
  #SUMA DE PESOS
  output$suma_pesos <- renderPrint({
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a1 <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a1[i] <- 1
      }
    }
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b1 <- which(a1==1)
    if(sum(a1)>=1){
      a <- data_pos()[-b1,]
      a$pesos <- a[,2]/sum(a[,2])
      sum(a[,3])
      
    }else{
      a <- data_pos()
      a$pesos <- a[,2]/sum(a[,2])
      sum(a[,3])
      
    }
    
   
  })
  
  
  #ESCENARIOS VAR SIMULACION HISTORICA
  output$escenarios_varsh <- DT::renderDataTable({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #calculo pesos
    p <- data_pos()
    p$pesos <- p[,2]/sum(p[,2])
    

    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo pesos
      p <- p[-b,]
      p[,3] <- p[,2]/sum(p[,2])

      esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
      if(sum(p[,3])==1){
        #calculo escenarios
        for(i in 1:nrow(rend)){
          esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        }
        esc
      }else{return()}
      
    }else{
      esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
      if(sum(p[,3])==1){
        #calculo escenarios
        for(i in 1:nrow(rend)){
          esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        }
        esc
      }else{return()}
      
    }
    
    
  })
  
  
  #PORCENTAJE VAR SIMULACION HISTORICA
  output$porcentaje_varsh <- renderPrint({
    print(as.numeric(sub(",",".",input$porVarsh)))
  })
  
  
  #UBICACION
  output$ubicacion_varsh <- renderPrint({
    round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))
  })
  
  #VAR SIMULACION HISTORICA
  output$varsh <- renderPrint({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #calculo pesos
    p <- data_pos()
    p$pesos <- p[,2]/sum(p[,2])
    

    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo pesos
      p <- p[-b,]
      p[,3] <- p[,2]/sum(p[,2])
      
      esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
      if(sum(p[,3])==1){
        #calculo escenarios
        for(i in 1:nrow(rend)){
          esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        }
        
        #Ordeno data
        esc1 <- esc[,ncol(esc)]
        esc1 <- esc1[order(esc1)]
        
        VaRsh <- sum(p[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        VaRsh
        }else{return()}
      
    }else{
      esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
      if(sum(p[,3])==1){
        #calculo escenarios
        for(i in 1:nrow(rend)){
          esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        }
        #esc[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh)))),ncol(esc)]
        esc1 <- esc[,ncol(esc)]
        esc1 <- esc1[order(esc1)]
        
        VaRsh <- sum(data_pos()[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        VaRsh        
        
      }else{return()}
      
    }
    
    
    
    
  })
  
  #HISTOGRAMA VAR SIMULACION HISTORICA
  output$grafico_hist_sh <- renderPlotly({ 
    
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #calculo pesos
    p <- data_pos()
    p$pesos <- p[,2]/sum(p[,2])
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo pesos
      p <- p[-b,]
      p[,3] <- p[,2]/sum(p[,2])
      
      esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
      if(sum(p[,3])==1){
        #calculo escenarios
        for(i in 1:nrow(rend)){
          esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        }
        
        #Ordeno data
        esc1 <- esc[,ncol(esc)]
        esc1 <- esc1[order(esc1)]
        
        vc <- esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        
        p2 <- plot_ly(cbind.data.frame(seq(1,length(esc1)),esc1), x = ~esc1) %>% add_histogram(name="Histograma")  %>%
          add_segments(x=vc, y=0, xend=vc, yend=mean(hist(esc1)$counts), line=list(color="red", width = 4),name="Valor Corte") %>%
          layout(title = 'Histograma de Escenarios',
                 xaxis = list(title=" "))
        p2
        
      }else{return()}
      
    }else{
      esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
      if(sum(p[,3])==1){
        #calculo escenarios
        for(i in 1:nrow(rend)){
          esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        }
        #esc[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh)))),ncol(esc)]
        esc1 <- esc[,ncol(esc)]
        esc1 <- esc1[order(esc1)]
        
        vc <- esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        
        p2 <- plot_ly(cbind.data.frame(seq(1,length(esc1)),esc1), x = ~esc1) %>% add_histogram(name="Histograma")  %>%
          add_segments(x=vc, y=0, xend=vc, yend=mean(hist(esc1)$counts), line=list(color="red", width = 4),name="Valor Corte") %>%
          layout(title = 'Histograma de Escenarios',
                 xaxis = list(title=" "))
        p2
        
      }else{return()}
      
    }
    
    
  })
  
  
  #GRAFICO COMPARACION VAR SH VS VAR NORMAL VS MONTE CARLO
  output$grafico_var_comp <- renderPlotly({ 
    #calculo Var Monte Carlo Normal
    varmc <- varmc_por_n1()[[1]]
    
    #calculo Var Monte Carlo Normal
    varmc_el <- varmc_por_el1()[[1]]
    
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #calculo pesos
    p <- data_pos()
    p$pesos <- p[,2]/sum(p[,2])
    
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #creo estructura de tabla
      tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 4))
      names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
      rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")
      
      data1 <- as.data.frame(matrix(0,nrow = 1,ncol = ncol(rend)))
      names(data1) <- names(data())[-c(1,(b+1))]
      
      
      for(i in 1:ncol(data1)){
        data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      }
      
      #relleno desviaciones estandar
      tabla[,1] <- c(as.numeric(data1),NA)
      
      # #relleno valor nominal
      tabla[,2] <- c(data_pos()[-b,2],sum(data_pos()[-b,2]))
      
      # #relleno Vares individuales
      tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
      tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
      
      
      #calculo matriz de correlaciones (diagonal de 1's)
      S<- cor(rend)
      
      #CALCULO VAR NORMAL
      var_ind <- tabla[1:(nrow(tabla)-1),3]
      #var_ind%*%S
      VaR_n <- sqrt(var_ind%*%S%*%as.matrix(var_ind))

      
      #CALCULO VAR SH
      #actualizo pesos
      p <- p[-b,]
      p[,3] <- p[,2]/sum(p[,2])
      
      esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
      if(sum(p[,3])==1){
        #calculo escenarios
        for(i in 1:nrow(rend)){
          esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        }
        
        #Ordeno data
        esc1 <- esc[,ncol(esc)]
        esc1 <- esc1[order(esc1)]
        
        VaRsh <- sum(p[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
  
      }else{return()}#final if suma de pesos
      
      
      
      p1 <- plot_ly(marker = list(color = 'royalblue1',
                                 line = list(color = 'rgb(8,48,107)',
                                             width = 3))) %>%
        add_bars(
          x = c("Normal"),
          y = VaR_n,
          width = 0.3,
          marker = list(
            color = 'royalblue1'
          ),
          name = 'VaR Delta-Normal'
        ) %>%
        add_bars(
          x = c("Simulación Histórica"),
          y = VaRsh,
          width = 0.3,
          marker = list(
            color = 'mediumseagreen'
          ),
          name = 'VaR Simulación Histórica'
        ) %>%
        add_bars(
          x = c("SMC Normal"),
          y = varmc,
          width = 0.3,
          marker = list(
            color = 'purple'
          ),
          name = 'VaR SMC Normal'
        ) %>%
        add_bars(
          x = c("SMC Mejor Distribución"),
          y = varmc_el,
          width = 0.3,
          marker = list(
            color = 'orange'
          ),
          name = 'VaR SMC Mejor Distribución'
        )
      
      p1
      
      
    }else{#final if problemas de rend
    
    #creo estructura de tabla
    tabla <- as.data.frame(matrix(0,nrow = (ncol(data())),ncol = 3))
    names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual")
    rownames(tabla) <- c(names(data())[-1],"Totales")
    
    
    data1 <- as.data.frame(matrix(0,nrow = 1,ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]
    
    
    for(i in 1:ncol(data1)){
      data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
    }
    
    #relleno desviaciones estandar
    tabla[,1] <- c(as.numeric(data1),NA)
    
    # #relleno valor nominal
    tabla[,2] <- c(data_pos()[,2],sum(data_pos()[,2]))
    
    # #relleno Vares individuales
    tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
    tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
    
    #calculo matriz de correlaciones (diagonal de 1's)
    S<- cor(rend)
    
    #CALCULO VAR NORMAL
    var_ind <- tabla[1:(nrow(tabla)-1),3]
    #var_ind%*%S
    VaR_n <- sqrt(var_ind%*%S%*%as.matrix(var_ind))
    
    
    #CALCULO VAR SH
    esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
    if(sum(p[,3])==1){
      #calculo escenarios
      for(i in 1:nrow(rend)){
        esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
      }
      #esc[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh)))),ncol(esc)]
      esc1 <- esc[,ncol(esc)]
      esc1 <- esc1[order(esc1)]
      
      VaRsh <- sum(data_pos()[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
              
      
    }else{return()}
    
    p1 <- plot_ly(marker = list(color = 'royalblue1',
                                line = list(color = 'rgb(8,48,107)',
                                            width = 3))) %>%
      add_bars(
        x = c("Normal"),
        y = VaR_n,
        width = 0.3,
        marker = list(
          color = 'royalblue1'
        ),
        name = 'VaR Delta-Normal'
      ) %>%
      add_bars(
        x = c("Simulación Histórica"),
        y = VaRsh,
        width = 0.3,
        marker = list(
          color = 'mediumseagreen'
        ),
        name = 'VaR Simulación Histórica'
      ) %>%
      add_bars(
        x = c("SMC Normal"),
        y = varmc,
        width = 0.3,
        marker = list(
          color = 'purple'
        ),
        name = 'VaR SMC Normal'
      ) %>%
      add_bars(
        x = c("SMC Mejor Distribución"),
        y = varmc_el,
        width = 0.3,
        marker = list(
          color = 'orange'
        ),
        name = 'VaR SMC Mejor Distribución'
      )
    
    p1
    
    
    
    }
    
  })
  
  
  #CALCULO VARES INDIVIDUALES SIMULACION HISTORICA
  output$varind_sh <- DT::renderDataTable({ 
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #leo posiciones
    p <- data_pos()
    #p$pesos <- p[,2]/sum(p[,2])
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo posiciones
      p <- p[-b,]
      #p[,3] <- p[,2]/sum(p[,2])
      
      ma <- as.data.frame(matrix(0,nrow = nrow(rend),ncol = ncol(rend)))
      names(ma) <- paste(names(rend),"esc",sep = "_")
  
 
        #calculo escenarios
        for(i in 1:ncol(ma)){
          ma[,i] <- (1+as.numeric(rend[,i]))*(p[i,2])
        }
      
         #esc <- cbind.data.frame(rend,ma)
     
         #creo estructura para guardar Vares individuales
         var_ind <- cbind.data.frame("Títulos"=c(as.character(p[,1]),"Totales"),"Valor Nominal"=c(p[,2],sum(p[,2])),"Vares individuales"=rep(0,1+nrow(p)))
         
         for(i in 1:ncol(rend)){
           ma1 <- ma[order(ma[,i]),i]
           var_ind[i,3] <- (p[i,2])-ma1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        
         }
         
         var_ind[nrow(var_ind),3] <- sum(var_ind[1:(nrow(var_ind)-1),3])
         
         DT::datatable(var_ind, options = list(paging = FALSE))
        # #Ordeno data
        # esc1 <- esc[,ncol(esc)]
        # esc1 <- esc1[order(esc1)]
        
        #VaRsh <- sum(p[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        #VaRsh
        
        
        
        
      #}else{return()}
      
    }else{
      ma <- as.data.frame(matrix(0,nrow = nrow(rend),ncol = ncol(rend)))
      names(ma) <- paste(names(rend),"esc",sep = "_")
      
      
      
      #calculo escenarios
      for(i in 1:ncol(ma)){
        ma[,i] <- (1+as.numeric(rend[,i]))*(p[i,2])
      }
      
      #esc <- cbind.data.frame(rend,ma)
      
      #creo estructura para guardar Vares individuales
      var_ind <- cbind.data.frame("Títulos"=c(as.character(p[,1]),"Totales"),"Valor Nominal"=c(p[,2],sum(p[,2])),"Vares individuales"=rep(0,1+nrow(p)))
      
      for(i in 1:ncol(rend)){
        ma1 <- ma[order(ma[,i]),i]
        var_ind[i,3] <- (p[i,2])-ma1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        
      }
      
      var_ind[nrow(var_ind),3] <- sum(var_ind[1:(nrow(var_ind)-1),3])
      DT::datatable(var_ind, options = list(paging = FALSE))
        #if(sum(p[,3])==1){
        #calculo escenarios
        # for(i in 1:nrow(rend)){
        #   esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        # }
        # #esc[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh)))),ncol(esc)]
        # esc1 <- esc[,ncol(esc)]
        # esc1 <- esc1[order(esc1)]
        # 
        # VaRsh <- sum(data_pos()[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        # VaRsh        
        
     # }else{return()}
      
    }
    
    
    
  })
  
  #GRAFICO VAR INDIVIDUALES SIMULACION HISTORICA 
  output$grafico_vind_sh <- renderPlotly({ 
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #leo posiciones
    p <- data_pos()
    #p$pesos <- p[,2]/sum(p[,2])
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo posiciones
      p <- p[-b,]
      #p[,3] <- p[,2]/sum(p[,2])
      
      ma <- as.data.frame(matrix(0,nrow = nrow(rend),ncol = ncol(rend)))
      names(ma) <- paste(names(rend),"esc",sep = "_")
      
      
      #calculo escenarios
      for(i in 1:ncol(ma)){
        ma[,i] <- (1+as.numeric(rend[,i]))*(p[i,2])
      }
      
      #esc <- cbind.data.frame(rend,ma)
      
      #creo estructura para guardar Vares individuales
      var_ind <- cbind.data.frame("Títulos"=c(as.character(p[,1]),"Totales"),"Valor Nominal"=c(p[,2],sum(p[,2])),"Vares individuales"=rep(0,1+nrow(p)))
      
      for(i in 1:ncol(rend)){
        ma1 <- ma[order(ma[,i]),i]
        var_ind[i,3] <- (p[i,2])-ma1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        
      }
      
      var_ind[nrow(var_ind),3] <- sum(var_ind[1:(nrow(var_ind)-1),3])
      
      #grafico
      pie <- cbind.data.frame(var_ind[1:(nrow(var_ind)-1),1],var_ind[1:(nrow(var_ind)-1),3])
      names(pie) <- c("Titulo","ind")
      
      p <- plot_ly(pie, labels = ~Titulo, values = ~ind, type = 'pie') %>%
        layout(title = 'VaRes Individuales')
      
      
      p
      
      
      
      
      #}else{return()}
      
    }else{
      ma <- as.data.frame(matrix(0,nrow = nrow(rend),ncol = ncol(rend)))
      names(ma) <- paste(names(rend),"esc",sep = "_")
      
      
      
      #calculo escenarios
      for(i in 1:ncol(ma)){
        ma[,i] <- (1+as.numeric(rend[,i]))*(p[i,2])
      }
      
      #esc <- cbind.data.frame(rend,ma)
      
      #creo estructura para guardar Vares individuales
      var_ind <- cbind.data.frame("Títulos"=c(as.character(p[,1]),"Totales"),"Valor Nominal"=c(p[,2],sum(p[,2])),"Vares individuales"=rep(0,1+nrow(p)))
      
      for(i in 1:ncol(rend)){
        ma1 <- ma[order(ma[,i]),i]
        var_ind[i,3] <- (p[i,2])-ma1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        
      }
      
      var_ind[nrow(var_ind),3] <- sum(var_ind[1:(nrow(var_ind)-1),3])
      
      #grafico
      pie <- cbind.data.frame(var_ind[1:(nrow(var_ind)-1),1],var_ind[1:(nrow(var_ind)-1),3])
      names(pie) <- c("Titulo","ind")
      
      p <- plot_ly(pie, labels = ~Titulo, values = ~ind, type = 'pie') %>%
        layout(title = 'VaRes Individuales')
      
      p
      
      
      
    }
    
  })
  
  #GRAFICO COMPARATIVO SUMA VARES INDIVIDUALES VS VAR PORTAFOLIO SH
  output$grafico_comp_sh <- renderPlotly({ 
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #leo posiciones
    p <- data_pos()
    p$pesos <- p[,2]/sum(p[,2])
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo posiciones
      p <- p[-b,]
      p[,3] <- p[,2]/sum(p[,2])
      
      ma <- as.data.frame(matrix(0,nrow = nrow(rend),ncol = ncol(rend)))
      names(ma) <- paste(names(rend),"esc",sep = "_")
      
      
      #calculo escenarios
      for(i in 1:ncol(ma)){
        ma[,i] <- (1+as.numeric(rend[,i]))*(p[i,2])
      }
      
      #esc <- cbind.data.frame(rend,ma)
      
      #creo estructura para guardar Vares individuales
      var_ind <- cbind.data.frame("Títulos"=c(as.character(p[,1]),"Totales"),"Valor Nominal"=c(p[,2],sum(p[,2])),"Vares individuales"=rep(0,1+nrow(p)))
      
      for(i in 1:ncol(rend)){
        ma1 <- ma[order(ma[,i]),i]
        var_ind[i,3] <- (p[i,2])-ma1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        
      }
      
      var_ind[nrow(var_ind),3] <- sum(var_ind[1:(nrow(var_ind)-1),3])
      
      #calculo VaR portafolio
      esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
      if(sum(p[,3])==1){
        #calculo escenarios
        for(i in 1:nrow(rend)){
          esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        }
        
        #Ordeno data
        esc1 <- esc[,ncol(esc)]
        esc1 <- esc1[order(esc1)]
        
        VaRsh <- sum(p[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        VaRsh
      
      #grafico
      p <- plot_ly(marker = list(color = 'royalblue1',
                                 line = list(color = 'rgb(8,48,107)',
                                             width = 3))) %>%
        add_bars(
          x = c("Individual"),
          y = var_ind[nrow(var_ind),3],
          width = 0.3,
          marker = list(
            color = 'royalblue1'
          ),
          name = 'Suma VaRes individuales'
        ) %>%
        add_bars(
          x = c("Portafolio"),
          y = VaRsh,
          width = 0.3,
          marker = list(
            color = 'mediumseagreen'
          ),
          name = 'VaR Portafolio'
        )
      
      p
      
      
      
      
      }else{return()}
      
    }else{
      ma <- as.data.frame(matrix(0,nrow = nrow(rend),ncol = ncol(rend)))
      names(ma) <- paste(names(rend),"esc",sep = "_")
      
      
      
      #calculo escenarios
      for(i in 1:ncol(ma)){
        ma[,i] <- (1+as.numeric(rend[,i]))*(p[i,2])
      }
      
      #esc <- cbind.data.frame(rend,ma)
      
      #creo estructura para guardar Vares individuales
      var_ind <- cbind.data.frame("Títulos"=c(as.character(p[,1]),"Totales"),"Valor Nominal"=c(p[,2],sum(p[,2])),"Vares individuales"=rep(0,1+nrow(p)))
      
      for(i in 1:ncol(rend)){
        ma1 <- ma[order(ma[,i]),i]
        var_ind[i,3] <- (p[i,2])-ma1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        
      }
      
      var_ind[nrow(var_ind),3] <- sum(var_ind[1:(nrow(var_ind)-1),3])
      
      #calculo VaR portafolio
      esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
      if(sum(p[,3])==1){
        #calculo escenarios
        for(i in 1:nrow(rend)){
          esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        }
        
        #Ordeno data
        esc1 <- esc[,ncol(esc)]
        esc1 <- esc1[order(esc1)]
        
        VaRsh <- sum(p[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        VaRsh
        
        #grafico
        p <- plot_ly(marker = list(color = 'royalblue1',
                                   line = list(color = 'rgb(8,48,107)',
                                               width = 3))) %>%
          add_bars(
            x = c("Individual"),
            y = var_ind[nrow(var_ind),3],
            width = 0.3,
            marker = list(
              color = 'royalblue1'
            ),
            name = 'Suma VaRes individuales'
          ) %>%
          add_bars(
            x = c("Portafolio"),
            y = VaRsh,
            width = 0.3,
            marker = list(
              color = 'mediumseagreen'
            ),
            name = 'VaR Portafolio'
          )
        
        p
     
      }else{return()}
      
      
    }
    
  })
  
  ##################
  ##VAR MONTECARLO##
  ##################
  #ASUMO NORMALIDAD
  #RENDIMIENTOS
  output$rend_varmc_n<-DT::renderDataTable({
    if(is.null(data())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    data1 <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]
    
    
    for(i in 1:(ncol(data())-1)){
      data1[,i] <- diff(log(data()[,i+1]))
    }
    
    #datatable(head(data1))
    DT::datatable(data1)
  })
  
  #ADVERTENCIA
  output$advertencia_varmc_n <-renderPrint({
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    if(sum(a)>=1){
      print("Existen problemas con los rendimientos de los títulos")
      print(names(rend)[which(a==1)])
      print("los mismos se excluirán del estudio")
    }else{
      print("No hay problemas con los rendimientos")
    }
    
  })
  
  #PARAMETROS SELECCIONADOS
  output$parametros_varmc_n<-DT::renderDataTable({
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo problemas con rend
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      #creo data frame para distribuciones
      data1 <- as.data.frame(matrix(0,nrow = 2,ncol = ncol(rend) ))
      names(data1) <- names(data())[-c(1,(b+1))]
      rownames(data1) <- c("Media","Desviación estandar")
      
      for(i in 1:ncol(data1)){
        data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[1]
        data1[2,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
        
      }
      return(data1)
      
    }
    
    #creo data frame para distribuciones
    data1 <- as.data.frame(matrix(0,nrow = 2,ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]
    rownames(data1) <- c("Media","Desviación estandar")
    
    for(i in 1:ncol(data1)){
      data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[1]
      data1[2,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      
    }
    data1
  })
  
  #% VAR
  output$porcentaje_varmc_n <- renderPrint({
    print(as.numeric(sub(",",".",input$porVarmc_n)))
  })
  
  #CREO FUNCION REACTIVA QUE ME CALCULA EL VAR INDIVIDUAL MONTE CARLO
  varmc_ind_n <- reactive({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #leo posiciones
    p <- data_pos()
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo posiciones
      p <- p[-b,]
      
      #creo vector de vares individuales
      var_n <- rep(0,ncol(rend))
      
      for(i in 1:ncol(rend)){
        #Calculo numeros aleatorios
        n_norm <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
        
        #calculo incrementos 
        pre_inc <- p[i,2]*n_norm
        
        #precio
        pre <- p[i,2]+pre_inc
        
        #valor corte
        #ordeno precios
        pre1 <- pre[order(pre)]
        vc <- pre1[length(n_norm)*(1-as.numeric(sub(",",".",input$porVarmc_n)))]
        
        #VaR
        var_n[i] <- p[i,2]-vc
        
      }#final for vares individuales
      
      #creo estructura de tabla
      tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 3))
      names(tabla) <- c("Valor Nominal","VaR Individual","VaR Porcentaje")
      rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")
      
      #relleno valor nominal
      tabla[,1] <- c(p[,2],sum(p[,2]))
      
      #relleno Vares individuales
      tabla[,2] <- c(var_n,sum(var_n))
      
      #relleno VaR en porcentaje
      tabla[,3] <- tabla[,2]*100/tabla[nrow(tabla),2]
      tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
      
      return(tabla)
      
    }
    
    #creo vector de vares individuales
    var_n <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      #Calculo numeros aleatorios
      n_norm <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
      
      #calculo incrementos 
      pre_inc <- p[i,2]*n_norm
      
      #precio
      pre <- p[i,2]+pre_inc
      
      #valor corte
      #ordeno precios
      pre1 <- pre[order(pre)]
      #vc <- pre1[length(n_norm)*5/100]
      vc <- pre1[length(n_norm)*(1-as.numeric(sub(",",".",input$porVarmc_n)))]
      
      
      #VaR
      var_n[i] <- p[i,2]-vc
      
    }#final for vares individuales
    
    #creo estructura de tabla
    tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 3))
    names(tabla) <- c("Valor Nominal","VaR Individual","VaR Porcentaje")
    rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")
    
    #relleno valor nominal
    tabla[,1] <- c(p[,2],sum(p[,2]))
    
    
    #relleno Vares individuales
    tabla[,2] <- c(var_n,sum(var_n))
    
    #relleno VaR en porcentaje
    tabla[,3] <- tabla[,2]*100/tabla[nrow(tabla),2]
    tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
    
    return(tabla)
    
  })
  
  
  #CALCULO VARES INDIVIDUALES MC
  output$tabla_varmc_n <-DT::renderDataTable({
    #añado dependencia
    input$boton21
    
    #
    isolate({
    DT::datatable(varmc_ind_n(), options = list(paging = FALSE))
    })
      
      })
  
  #CREO FUNCION REACTIVA QUE ME CALCULA EL VAR DE PORTAFOLIO MONTE CARLO
  varmc_por_n <- reactive({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #leo posiciones
    p <- data_pos()
    p$pesos <- p[,2]/sum(p[,2])
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo posiciones
      p <- p[-b,]
      p[,3] <- p[,2]/sum(p[,2])
      
      #creo matriz donde guardare simulaciones de cada instrumento
      mat <- as.data.frame(matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend)+2)))
      names(mat) <- c(names(rend),"incremento","escenario")
      
      #relleno matriz de simulaciones
      withProgress(message = 'Calculando números aleatorios', value = 0, {
        incProgress(1/3, detail = "Realizando iteraciones")
      for(i in 1:ncol(rend)){
        mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
      }
      })
      
      #calculo columna "incremento precio"
      withProgress(message = 'Calculando variaciones de precio', value = 0, {
        incProgress(1/2, detail = "Realizando iteraciones")
      for(i in 1:nrow(mat)){
        mat$incremento[i] <- sum(p[,2])*sum(as.numeric(p[,3])*as.numeric(mat[i,1:ncol(rend)]))
      }
      })
      #calculo columna "escenario"
      withProgress(message = 'Calculando simulaciones', value = 0, {
        incProgress(2/3, detail = "Realizando iteraciones")
      for(i in 1:nrow(mat)){
        mat$escenario[i] <- sum(p[,2])+mat$incremento[i]
      }
      })
      #ordeno columna "escenarios"
      mat1 <- mat$escenario
      mat1 <- mat1[order(mat1)]
      
      #calculo valor de corte y VaR Monte Carlo
      #vc <- (mat1[length(mat1)*5/100])
      vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_n)))])
      var_sm <- sum(p[,2])-vc
      
      lista <- list(var_sm,mat1,vc)
      
      return(lista)
      
      
      
    }#final if
    
    #creo matriz donde guardare simulaciones de cada instrumento
    mat <- as.data.frame(matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend)+2)))
    names(mat) <- c(names(rend),"incremento","escenario")
    
    #relleno matriz de simulaciones
    for(i in 1:ncol(rend)){
      mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
    }
    
    #calculo columna "incremento precio"
    for(i in 1:nrow(mat)){
      mat$incremento[i] <- sum(p[,2])*sum(as.numeric(p[,3])*as.numeric(mat[i,1:ncol(rend)]))
    }
    
    #calculo columna "escenario"
    for(i in 1:nrow(mat)){
      mat$escenario[i] <- sum(p[,2])+mat$incremento[i]
    }
    
    #ordeno columna "escenarios"
    mat1 <- mat$escenario
    mat1 <- mat1[order(mat1)]
    
    #calculo valor de corte y VaR Monte Carlo
    #vc <- (mat1[length(mat1)*5/100])
    vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_n)))])
    var_sm <- sum(p[,2])-vc
    #return(var_sm)
    lista <- list(var_sm,mat1,vc)
    
    return(lista)
    
  })
  
  #CALCULO VAR PORTAFOLIO MC
  output$varmc_portafolio_n<-renderPrint({
    varmc_por_n()[[1]]
  })
  
  
  #ELEGIR CANTIDAD DE SIMULACIONES
  output$simulaciones_varmc_n <- renderPrint({
    input$sim_varmc_n
  })
  
 
  
  #GRAFICO VARES INDIVIDUALES SIMULACION MONTE CARLO
  output$grafico_vind_mcn <- renderPlotly({ 
    if(is.null(data())){return()}
    
    #obtengo tabla con vares individuales
    tabla <- varmc_ind_n()

      #grafico
      pie <- cbind.data.frame(rownames(tabla)[-nrow(tabla)],tabla[1:(nrow(tabla)-1),2])
      names(pie) <- c("Titulo","ind")
      
      p <- plot_ly(pie, labels = ~Titulo, values = ~ind, type = 'pie') %>%
        layout(title = 'VaRes Individuales')

      p
  })
  
  #GRAFICO COMPARATIVO VARES INDIVIDUALES VS VAR PORTAFOLIO SIMULACION MONTE CARLO
  output$grafico_comp_mcn <- renderPlotly({ 
    if(is.null(data())){return()}
    
    #obtengo vares individuales 
     varind <- varmc_ind_n()
     
     #obtengo var portafolio
     varpor <- varmc_por_n1()[[1]]
    
    
        #grafico
        p <- plot_ly(marker = list(color = 'royalblue1',
                                   line = list(color = 'rgb(8,48,107)',
                                               width = 3))) %>%
          add_bars(
            x = c("Individual"),
            y = varind[nrow(varind),2],
            width = 0.3,
            marker = list(
              color = 'royalblue1'
            ),
            name = 'Suma VaRes individuales'
          ) %>%
          add_bars(
            x = c("Portafolio"),
            y = varpor,
            width = 0.3,
            marker = list(
              color = 'mediumseagreen'
            ),
            name = 'VaR Portafolio'
          )
        
        p
   
  })
  
  #GRAFICO HISTOGRAMA DE ESCENARIOS VAR SMC DIST NORMAL
  output$grafico_hist_smcn <- renderPlotly({ 

    if(is.null(data())){return()}
    #obtengo data escenarios
    mat1 <- varmc_por_n1()[[2]]
    
    #calculo valor de corte y VaR Monte Carlo
    #vc <- (mat1[length(mat1)*5/100])
    vc <- varmc_por_n1()[[3]]
    #var_sm <- sum(p[,2])-vc
    #return(var_sm)
    
        
    p2 <- plot_ly(cbind.data.frame(seq(1,length(mat1)),mat1), x = ~mat1) %>% add_histogram(name="Histograma")  %>%
      add_segments(x=vc, y=0, xend=vc, yend=mean(hist(mat1)$counts), line=list(color="red", width = 4),name="Valor Corte") %>%
      layout(title = 'Histograma de Escenarios',
             xaxis = list(title=" "))
    
    p2
    
    
  })
  
   #ELEGIR DISTRIBUCION
  #RENDIMIENTOS ELEGIR DISTRIBUCION VAR MC
  output$rend_varmc_el<-DT::renderDataTable({
    if(is.null(data())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    data1 <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]
    
    
    for(i in 1:(ncol(data())-1)){
      data1[,i] <- diff(log(data()[,i+1]))
    }
    
    #datatable(head(data1))
    DT::datatable(data1)
  })
  
  
  #ADVERTENCIAS ELEGIR DISTRIBUCION VAR MC
  output$advertencia_varmc_el <-renderPrint({
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    if(sum(a)>=1){
      print("Existen problemas con los rendimientos de los títulos")
      print(names(rend)[which(a==1)])
      print("los mismos se excluirán del estudio")
    }else{
      print("No hay problemas con los rendimientos")
    }
    
  })
  
  #TABLA DISTRIBUCIONES ELEGIR DISTRIBUCION VAR MC
  output$dist_varmc_el <- DT::renderDataTable({
    #leo el historico actualizado
   # hist <- read.csv(paste(getwd(),"data","distribuciones.txt",sep = "/"),sep="")
   #  hist 
    #distribuciones()
    if(input$seleccion_dist==0){
      a <- try(distribuciones())
      
      if(class(a)!="try-error"){
        a
      }else{}
      
    }else if(input$seleccion_dist==1){
      #as.data.frame(rep(1,10))
      #b <- read.csv(paste(getwd(),"data","distribuciones2.txt",sep = "/"),sep="")
      #b
      a <- try(datadist())
      
      if(class(a)!="try-error"){
        a
      }else{}
      
    }
  })
  
  
  # % VAR ELEGIR DISTRIBUCION VAR MC
  output$porcentaje_varmc_el <- renderPrint({
    print(as.numeric(sub(",",".",input$porVarmc_el)))
  })
  
  #NUMERO DE SIMULACIONES ELEGIR DISTRIBUCION VAR MC
  output$simulaciones_varmc_el <- renderPrint({
    input$sim_varmc_el
  })
  
  #VARES INDIVIDUALES ELEGIR DISTRIBUCION VAR MC
  varmc_ind_el <- reactive({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #leo posiciones
    p <- data_pos()
    
    #leo tabla de distribuciones
    if(input$seleccion_dist==0){
      dist <- distribuciones()
    }else if(input$seleccion_dist==1){
      #dist <- read.csv(paste(getwd(),"data","distribuciones2.txt",sep = "/"),sep="")
    dist <- datadist()
      }
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo posiciones
      p <- p[-b,]
      
      #creo vector de vares individuales
      var_n <- rep(0,ncol(rend))
      
      #return(as.character(dist[,2])=="Normal")
      
      
      for(i in 1:ncol(rend)){
        #Calculo numeros aleatorios
        #n_norm <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
        if(as.character(dist[,i])=="Normal"){
          #n_rand <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="nor") #normal   
          #realizo simulacion
          n_rand <- rlmomco(input$sim_varmc_el,b1) 
        }else if(as.character(dist[,i])=="Exponential"){
          #n_rand <- rexp(n = input$sim_varmc_n,rate = as.numeric(fitdistr(rend[,i],"exponential")$estimate))
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="exp") #normal   
          #realizo simulacion
          n_rand <- rlmomco(input$sim_varmc_el,b1)
        }else if(as.character(dist[,i])=="Cauchy"){
          #n_rand <- rcauchy(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[2])
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="cau") #normal   
          #realizo simulacion
          n_rand <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Logistic"){
          #n_rand <- rlogis(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"logistic")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"logistic")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="glo") #normal
            #realizo simulacion
            n_rand <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Beta"){
          #
        }else if(as.character(dist[,i])=="Chi-square"){
          #
        }else if(as.character(dist[,i])=="Uniform"){
          #
        }else if(as.character(dist[,i])=="Gamma"){
          #n_rand <- rgamma(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[1],rate = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[2])
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="gam") #normal   
          #realizo simulacion
          n_rand <- rlmomco(input$sim_varmc_el,b1)
        }else if(as.character(dist[,i])=="Lognormal"){
          n_rand <- rlnorm(n = input$sim_varmc_el,meanlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[1],sdlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[2])
        }else if(as.character(dist[,i])=="Weibull"){
          #n_rand <- rweibull(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[1],scale = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[2])
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="wei") #normal   
          #realizo simulacion
          n_rand <- rlmomco(input$sim_varmc_el,b1)
        }else if(as.character(dist[,i])=="F"){
          #
        }else if(as.character(dist[,i])=="Student"){
          #
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="st3") #normal   
          #realizo simulacion
          n_rand <- rlmomco(input$sim_varmc_el,b1)
        }else if(as.character(dist[,i])=="Gompertz"){
          #
        }else{
          n_rand <- 0
        }
        
        
        #calculo incrementos 
        pre_inc <- p[i,2]*n_rand
        
        #precio
        pre <- p[i,2]+pre_inc
        
        #valor corte
        #ordeno precios
        pre1 <- pre[order(pre)]
        #vc <- pre1[length(n_norm)*5/100]
        vc <- pre1[input$sim_varmc_el*(1-as.numeric(sub(",",".",input$porVarmc_el)))]
        
        
        #VaR
        var_n[i] <- p[i,2]-vc
        
      }#final for vares individuales
      
      #creo estructura de tabla
      tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 3))
      names(tabla) <- c("Valor Nominal","VaR Individual","VaR Porcentaje")
      rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")
      
      #relleno valor nominal
      tabla[,1] <- c(p[,2],sum(p[,2]))
      
      
      #relleno Vares individuales
      tabla[,2] <- c(var_n,sum(var_n))
      
      #relleno VaR en porcentaje
      tabla[,3] <- tabla[,2]*100/tabla[nrow(tabla),2]
      tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
      
      return(tabla)
      
      
    }
    
    #creo vector de vares individuales
    var_n <- rep(0,ncol(rend))
    
    #leo tabla de distribuciones
    #dist <- distribuciones()
    
    #return(as.character(dist[,2])=="Normal")
    
    for(i in 1:ncol(rend)){
      #Calculo numeros aleatorios
      #n_norm <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
      if(as.character(dist[,i])=="Normal"){
        #n_rand <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="nor") #normal   
        #realizo simulacion
        n_rand <- rlmomco(input$sim_varmc_el,b1) 
      }else if(as.character(dist[,i])=="Exponential"){
        #n_rand <- rexp(n = input$sim_varmc_n,rate = as.numeric(fitdistr(rend[,i],"exponential")$estimate))
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="exp") #normal   
        #realizo simulacion
        n_rand <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="Cauchy"){
        #n_rand <- rcauchy(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[2])
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="cau") #normal   
        #realizo simulacion
        n_rand <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="Logistic"){
        #n_rand <- rlogis(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"logistic")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"logistic")$estimate)[2])
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="glo") #normal   
        #realizo simulacion
        n_rand <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="Beta"){
        #
      }else if(as.character(dist[,i])=="Chi-square"){
        #
      }else if(as.character(dist[,i])=="Uniform"){
        #
      }else if(as.character(dist[,i])=="Gamma"){
        #n_rand <- rgamma(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[1],rate = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[2])
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="gam") #normal   
        #realizo simulacion
        n_rand <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="Lognormal"){
        n_rand <- rlnorm(n = input$sim_varmc_el,meanlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[1],sdlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[2])
      }else if(as.character(dist[,i])=="Weibull"){
        #n_rand <- rweibull(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[1],scale = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[2])
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="wei") #normal   
        #realizo simulacion
        n_rand <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="F"){
        #
      }else if(as.character(dist[,i])=="Student"){
        #
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="st3") #normal   
        #realizo simulacion
        n_rand <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="Gompertz"){
        #
      }else{
        n_rand <- 0
      }
      
      
      
      #calculo incrementos 
      pre_inc <- p[i,2]*n_rand
      
      #precio
      pre <- p[i,2]+pre_inc
      
      #valor corte
      #ordeno precios
      pre1 <- pre[order(pre)]
      #vc <- pre1[length(n_norm)*5/100]
      vc <- pre1[input$sim_varmc_el*(1-as.numeric(sub(",",".",input$porVarmc_el)))]
      
      
      #VaR
      var_n[i] <- p[i,2]-vc
      
    }#final for vares individuales
    
    #creo estructura de tabla
    tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 3))
    names(tabla) <- c("Valor Nominal","VaR Individual","VaR Porcentaje")
    rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")
    
    #relleno valor nominal
    tabla[,1] <- c(p[,2],sum(p[,2]))
    
    
    #relleno Vares individuales
    tabla[,2] <- c(var_n,sum(var_n))
    
    #relleno VaR en porcentaje
    tabla[,3] <- tabla[,2]*100/tabla[nrow(tabla),2]
    tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
    
    return(tabla)
    
  })
  
  
  
  output$tabla_varmc_el <- DT::renderDataTable({
    #añado dependencia
    input$boton22
    
    #
    isolate({
  
    DT::datatable(varmc_ind_el(), options = list(paging = FALSE))
      
    })#fin isolate
  })
  
  #VAR PORTAFOLIO ELEGIR DISTRIBUCION VAR MC
  #CREO FUNCION REACTIVA QUE ME CALCULA EL VAR DE PORTAFOLIO MONTE CARLO
  varmc_por_el <- reactive({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #leo posiciones
    p <- data_pos()
    p$pesos <- p[,2]/sum(p[,2])
    
    #leo distribuciones
    if(input$seleccion_dist==0){
      dist <- distribuciones()
    }else if(input$seleccion_dist==1){
      #dist <- read.csv(paste(getwd(),"data","distribuciones2.txt",sep = "/"),sep="")
    dist <- datadist()
      }
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo posiciones
      p <- p[-b,]
      p[,3] <- p[,2]/sum(p[,2])
      
      #creo matriz donde guardare simulaciones de cada instrumento
      mat <- as.data.frame(matrix(0,nrow = input$sim_varmc_el,ncol = (ncol(rend)+2)))
      names(mat) <- c(names(rend),"incremento","escenario")
      
      
      #relleno matriz de simulaciones
      withProgress(message = 'Calculando números aleatorios', value = 0, {
        incProgress(1/3, detail = "Realizando iteraciones")
        for(i in 1:ncol(rend)){
          #mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
          if(as.character(dist[,i])=="Normal"){
            #n_rand <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="nor") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1) 
          }else if(as.character(dist[,i])=="Exponential"){
            #n_rand <- rexp(n = input$sim_varmc_n,rate = as.numeric(fitdistr(rend[,i],"exponential")$estimate))
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="exp") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Cauchy"){
            #n_rand <- rcauchy(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="cau") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Logistic"){
            #n_rand <- rlogis(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"logistic")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"logistic")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="glo") #normal
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Beta"){
            #
          }else if(as.character(dist[,i])=="Chi-square"){
            #
          }else if(as.character(dist[,i])=="Uniform"){
            #
          }else if(as.character(dist[,i])=="Gamma"){
            #n_rand <- rgamma(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[1],rate = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="gam") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Lognormal"){
            mat[,i] <- rlnorm(n = input$sim_varmc_el,meanlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[1],sdlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[2])
          }else if(as.character(dist[,i])=="Weibull"){
            #n_rand <- rweibull(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[1],scale = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="wei") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="F"){
            #
          }else if(as.character(dist[,i])=="Student"){
            #
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="st3") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Gompertz"){
            #
          }else{
            mat[,i] <- rep(0,input$sim_varmc_el)
          }
          
          
          }
      })
      
      #calculo columna "incremento precio"
      withProgress(message = 'Calculando variaciones de precio', value = 0, {
        incProgress(1/2, detail = "Realizando iteraciones")
        for(i in 1:nrow(mat)){
          mat$incremento[i] <- sum(p[,2])*sum(as.numeric(p[,3])*as.numeric(mat[i,1:ncol(rend)]))
          }
      })
      #calculo columna "escenario"
      withProgress(message = 'Calculando simulaciones', value = 0, {
        incProgress(2/3, detail = "Realizando iteraciones")
        for(i in 1:nrow(mat)){
          mat$escenario[i] <- sum(p[,2])+mat$incremento[i]
        }
      })
      #ordeno columna "escenarios"
      mat1 <- mat$escenario
      mat1 <- mat1[order(mat1)]
      
      #calculo valor de corte y VaR Monte Carlo
      #vc <- (mat1[length(mat1)*5/100])
      vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_el)))])
      var_sm <- sum(p[,2])-vc
      
      lista <- list(var_sm,mat1,vc)
      
      return(lista)
      
      
      
    }#final if
    
    #creo matriz donde guardare simulaciones de cada instrumento
    mat <- as.data.frame(matrix(0,nrow = input$sim_varmc_el,ncol = (ncol(rend)+2)))
    names(mat) <- c(names(rend),"incremento","escenario")
    
    #relleno matriz de simulaciones
    for(i in 1:ncol(rend)){
      #mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
      if(as.character(dist[,i])=="Normal"){
        #n_rand <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="nor") #normal   
        #realizo simulacion
        mat[,i] <- rlmomco(input$sim_varmc_el,b1) 
      }else if(as.character(dist[,i])=="Exponential"){
        #n_rand <- rexp(n = input$sim_varmc_n,rate = as.numeric(fitdistr(rend[,i],"exponential")$estimate))
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="exp") #normal   
        #realizo simulacion
        mat[,i] <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="Cauchy"){
        #n_rand <- rcauchy(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[2])
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="cau") #normal   
        #realizo simulacion
        mat[,i] <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="Logistic"){
        #n_rand <- rlogis(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"logistic")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"logistic")$estimate)[2])
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="glo") #normal
        #realizo simulacion
        mat[,i] <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="Beta"){
        #
      }else if(as.character(dist[,i])=="Chi-square"){
        #
      }else if(as.character(dist[,i])=="Uniform"){
        #
      }else if(as.character(dist[,i])=="Gamma"){
        #n_rand <- rgamma(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[1],rate = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[2])
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="gam") #normal   
        #realizo simulacion
        mat[,i] <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="Lognormal"){
        mat[,i] <- rlnorm(n = input$sim_varmc_el,meanlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[1],sdlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[2])
      }else if(as.character(dist[,i])=="Weibull"){
        #n_rand <- rweibull(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[1],scale = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[2])
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="wei") #normal   
        #realizo simulacion
        mat[,i] <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="F"){
        #
      }else if(as.character(dist[,i])=="Student"){
        #
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="st3") #normal   
        #realizo simulacion
        mat[,i] <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="Gompertz"){
        #
      }else{
        mat[,i] <- rep(0,input$sim_varmc_el)
      }
      }
    
    #calculo columna "incremento precio"
    for(i in 1:nrow(mat)){
      mat$incremento[i] <- sum(p[,2])*sum(as.numeric(p[,3])*as.numeric(mat[i,1:ncol(rend)]))
    }
    
    #calculo columna "escenario"
    for(i in 1:nrow(mat)){
      mat$escenario[i] <- sum(p[,2])+mat$incremento[i]
    }
    
    #ordeno columna "escenarios"
    mat1 <- mat$escenario
    mat1 <- mat1[order(mat1)]
    
    #calculo valor de corte y VaR Monte Carlo
    #vc <- (mat1[length(mat1)*5/100])
    vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_el)))])
    var_sm <- sum(p[,2])-vc
    #return(var_sm)
    lista <- list(var_sm,mat1,vc)
    
    return(lista)
    
  })
  
  #CALCULO VAR PORTAFOLIO MC
  output$varmc_portafolio_el<-renderPrint({
    varmc_por_el()[[1]]
  })

  ###############
  #CALCULO VAR MONTECARLO PORTAFOLIO USANDO MATRIZ DE CORRELACION
  #SECCION ELEGIR DISTRIBUCION
  #CREO FUNCION AUXILIAR
  varmc_por_el1 <- reactive({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #leo posiciones
    p <- data_pos()
    #p$pesos <- p[,2]/sum(p[,2])
    
    #leo distribuciones
    if(input$seleccion_dist==0){
      dist <- distribuciones()
    }else if(input$seleccion_dist==1){
      #dist <- read.csv(paste(getwd(),"data","distribuciones2.txt",sep = "/"),sep="")
    dist <- datadist()
      }
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo posiciones
      p <- p[-b,]
      #p[,3] <- p[,2]/sum(p[,2])
      
      #creo matriz donde guardare simulaciones de cada instrumento
      #mat <- as.data.frame(matrix(0,nrow = input$sim_varmc_el,ncol = (ncol(rend)+2)))
      #names(mat) <- c(names(rend),"incremento","escenario")
      mat <- (matrix(0,nrow = input$sim_varmc_el,ncol = (ncol(rend))))
      names(mat) <- c(names(rend))
      
      
      #relleno matriz de simulaciones
      withProgress(message = 'Calculando números aleatorios', value = 0, {
        incProgress(1/3, detail = "Realizando iteraciones")
        for(i in 1:ncol(rend)){
          #mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
          if(as.character(dist[,i])=="Normal"){
            #n_rand <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="nor") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1) 
          }else if(as.character(dist[,i])=="Exponential"){
            #n_rand <- rexp(n = input$sim_varmc_n,rate = as.numeric(fitdistr(rend[,i],"exponential")$estimate))
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="exp") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Cauchy"){
            #n_rand <- rcauchy(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="cau") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Logistic"){
            #n_rand <- rlogis(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"logistic")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"logistic")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="glo") #normal
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Beta"){
            #
          }else if(as.character(dist[,i])=="Chi-square"){
            #
          }else if(as.character(dist[,i])=="Uniform"){
            #
          }else if(as.character(dist[,i])=="Gamma"){
            #n_rand <- rgamma(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[1],rate = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="gam") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Lognormal"){
            mat[,i] <- rlnorm(n = input$sim_varmc_el,meanlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[1],sdlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[2])
          }else if(as.character(dist[,i])=="Weibull"){
            #n_rand <- rweibull(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[1],scale = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="wei") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="F"){
            #
          }else if(as.character(dist[,i])=="Student"){
            #
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="st3") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Gompertz"){
            #
          }else{
            mat[,i] <- rep(0,input$sim_varmc_el)
          }
          
          
        }
      })
      
      #CALCULO MATRIZ DE CHOLESKY
      cholesky <- t(chol(cor(rend,use="complete.obs")))
      
      #5) REALIZO PRODUCTO DE MATRIZ DE N ALEATORIOS*MAT CHOLESKY
      mrs <- mat%*%t(cholesky)
      
      #6) calculo "incremento de precio"
      mrs1 <- mrs%*%p[,2]
      
      #7) calculo "precio" (siempre positivo)
      mrs2 <- sum(p[,2])+mrs1
      
      
      #10) CALCULO CUANTIL, QUE ES EL VAR
      #quantile(gop2,  probs = c(0.05),type = 1)
      #ordeno columna "escenarios"
      mat1 <- mrs2[order(mrs2)]
      
      #calculo valor de corte y VaR Monte Carlo
      #vc <- (mat1[length(mat1)*5/100])
      vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_el)))])
      var_sm <- sum(p[,2])-vc
      
      lista <- list(var_sm,mat1,vc)
      
      return(lista)
      
      
      
    }#final if
    
    #creo matriz donde guardare simulaciones de cada instrumento
    #mat <- as.data.frame(matrix(0,nrow = input$sim_varmc_el,ncol = (ncol(rend)+2)))
    #names(mat) <- c(names(rend),"incremento","escenario")
    mat <- (matrix(0,nrow = input$sim_varmc_el,ncol = (ncol(rend))))
    names(mat) <- c(names(rend))
    
    
    #relleno matriz de simulaciones
    withProgress(message = 'Calculando números aleatorios', value = 0, {
      incProgress(1/3, detail = "Realizando iteraciones")
      for(i in 1:ncol(rend)){
        #mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
        if(as.character(dist[,i])=="Normal"){
          #n_rand <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="nor") #normal   
          #realizo simulacion
          mat[,i] <- rlmomco(input$sim_varmc_el,b1) 
        }else if(as.character(dist[,i])=="Exponential"){
          #n_rand <- rexp(n = input$sim_varmc_n,rate = as.numeric(fitdistr(rend[,i],"exponential")$estimate))
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="exp") #normal   
          #realizo simulacion
          mat[,i] <- rlmomco(input$sim_varmc_el,b1)
        }else if(as.character(dist[,i])=="Cauchy"){
          #n_rand <- rcauchy(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[2])
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="cau") #normal   
          #realizo simulacion
          mat[,i] <- rlmomco(input$sim_varmc_el,b1)
        }else if(as.character(dist[,i])=="Logistic"){
          #n_rand <- rlogis(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"logistic")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"logistic")$estimate)[2])
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="glo") #normal
          #realizo simulacion
          mat[,i] <- rlmomco(input$sim_varmc_el,b1)
        }else if(as.character(dist[,i])=="Beta"){
          #
        }else if(as.character(dist[,i])=="Chi-square"){
          #
        }else if(as.character(dist[,i])=="Uniform"){
          #
        }else if(as.character(dist[,i])=="Gamma"){
          #n_rand <- rgamma(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[1],rate = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[2])
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="gam") #normal   
          #realizo simulacion
          mat[,i] <- rlmomco(input$sim_varmc_el,b1)
        }else if(as.character(dist[,i])=="Lognormal"){
          mat[,i] <- rlnorm(n = input$sim_varmc_el,meanlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[1],sdlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[2])
        }else if(as.character(dist[,i])=="Weibull"){
          #n_rand <- rweibull(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[1],scale = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[2])
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="wei") #normal   
          #realizo simulacion
          mat[,i] <- rlmomco(input$sim_varmc_el,b1)
        }else if(as.character(dist[,i])=="F"){
          #
        }else if(as.character(dist[,i])=="Student"){
          #
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="st3") #normal   
          #realizo simulacion
          mat[,i] <- rlmomco(input$sim_varmc_el,b1)
        }else if(as.character(dist[,i])=="Gompertz"){
          #
        }else{
          mat[,i] <- rep(0,input$sim_varmc_el)
        }
        
        
      }
    })
    
    #CALCULO MATRIZ DE CHOLESKY
    cholesky <- t(chol(cor(rend,use="complete.obs")))
    
    #5) REALIZO PRODUCTO DE MATRIZ DE N ALEATORIOS*MAT CHOLESKY
    mrs <- mat%*%t(cholesky)
    
    #6) calculo "incremento de precio"
    mrs1 <- mrs%*%p[,2]
    
    #7) calculo "precio" (siempre positivo)
    mrs2 <- sum(p[,2])+mrs1
    
    
    #10) CALCULO CUANTIL, QUE ES EL VAR
    #quantile(gop2,  probs = c(0.05),type = 1)
    #ordeno columna "escenarios"
    mat1 <- mrs2[order(mrs2)]
    
    #calculo valor de corte y VaR Monte Carlo
    #vc <- (mat1[length(mat1)*5/100])
    vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_el)))])
    var_sm <- sum(p[,2])-vc
    
    lista <- list(var_sm,mat1,vc)
    
    return(lista)
  })
  
  #CALCULO VAR PORTAFOLIO MC USANDO MATRIZ DE CORRELACIONES
  #SECCION ELEGIR DISTRIBUCION
  output$varmc_portafolio_el1<-renderPrint({
    #añado dependencia
    input$boton22
    
    #
    isolate({
    varmc_por_el1()[[1]]
    })#fin isolate
  })
  
  ###############
  #CALCULO VAR MONTECARLO PORTAFOLIO USANDO MATRIZ DE CORRELACION
  #SECCION  DISTRIBUCION NORMAL
  #CREO FUNCION AUXILIAR
  varmc_por_n1 <- reactive({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #leo posiciones
    p <- data_pos()
    #p$pesos <- p[,2]/sum(p[,2])
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo posiciones
      p <- p[-b,]
      #p[,3] <- p[,2]/sum(p[,2])
      
      #creo matriz donde guardare simulaciones de cada instrumento
      mat <- (matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend))))
      names(mat) <- c(names(rend))
      
      #relleno matriz de simulaciones
      withProgress(message = 'Calculando números aleatorios', value = 0, {
        incProgress(1/3, detail = "Realizando iteraciones")
        for(i in 1:ncol(rend)){
          mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
        }
      })
      
      #2) CALCULO MATRIZ DE CHOLESKY
      cholesky <- t(chol(cor(rend,use="complete.obs")))
      
      #5) REALIZO PRODUCTO DE ESC*MAT CHOLESKY
      mrs <- mat%*%t(cholesky)
      
      # #6) CALCULO PRECIO SIMULADO DE CADA DIA
      # psim <- (matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend))))
      # names(psim) <- c(names(rend))
      # 
      # #relleno matriz de precios simulados
      # for(i in 1:ncol(rend)){
      #   psim[,i] <-  data()[nrow(data()),i+1]*exp(mrs[,i])
      # }
      # 
      # #7) CALCULO PRECIO REAL
      # preal <- (matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend))))
      # names(preal) <- c(names(rend))
      # 
      # #relleno matriz de precios simulados
      # for(i in 1:ncol(rend)){
      #   preal[,i] <-  p[i,2]*psim[,i]/100
      # }
      # 
      # #8) CALCULO GANANCIA O PERDIDA
      # gop <- (matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend))))
      # names(gop) <- c(names(rend))
      # 
      # #relleno matriz de precios simulados
      # for(i in 1:ncol(rend)){
      #   gop[,i] <-  preal[,i]-(data()[nrow(data()),i+1]/100*p[i,2])
      # }
      # 
      # #9) CALCULO GOP DE CADA DIA
      # gop2 <- rowSums(gop)
      # 
      
      #6) calculo "incremento de precio"
      mrs1 <- mrs%*%(p[,2])
      
      #7) calculo "precio" (siempre positivo)
      mrs2 <- sum(p[,2])+mrs1
      
      
      #10) CALCULO CUANTIL, QUE ES EL VAR
      mat1 <- mrs2[order(mrs2)]
      
      
      vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_n)))])
      var_sm <- sum(p[,2])-vc
      
      lista <- list(var_sm,mat1,vc)
      
      return(lista)
      
      
      
    }#final if
    
    #creo matriz donde guardare simulaciones de cada instrumento
    mat <- (matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend))))
    names(mat) <- c(names(rend))
    
    #relleno matriz de simulaciones
    withProgress(message = 'Calculando números aleatorios', value = 0, {
      incProgress(1/3, detail = "Realizando iteraciones")
      for(i in 1:ncol(rend)){
        mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
      }
    })
    
    #2) CALCULO MATRIZ DE CHOLESKY
    cholesky <- t(chol(cor(rend,use="complete.obs")))
    
    #5) REALIZO PRODUCTO DE ESC*MAT CHOLESKY
    mrs <- mat%*%t(cholesky)
    
    # #6) CALCULO PRECIO SIMULADO DE CADA DIA
    # psim <- (matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend))))
    # names(psim) <- c(names(rend))
    # 
    # #relleno matriz de precios simulados
    # for(i in 1:ncol(rend)){
    #   psim[,i] <-  data()[nrow(data()),i+1]*exp(mrs[,i])
    # }
    # 
    # #7) CALCULO PRECIO REAL
    # preal <- (matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend))))
    # names(preal) <- c(names(rend))
    # 
    # #relleno matriz de precios simulados
    # for(i in 1:ncol(rend)){
    #   preal[,i] <-  p[i,2]*psim[,i]/100
    # }
    # 
    # #8) CALCULO GANANCIA O PERDIDA
    # gop <- (matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend))))
    # names(gop) <- c(names(rend))
    # 
    # #relleno matriz de precios simulados
    # for(i in 1:ncol(rend)){
    #   gop[,i] <-  preal[,i]-(data()[nrow(data()),i+1]/100*p[i,2])
    # }
    # 
    # #9) CALCULO GOP DE CADA DIA
    # gop2 <- rowSums(gop)
    # 
    
    #6) calculo "incremento de precio"
    mrs1 <- mrs%*%(p[,2])
    
    #7) calculo "precio" (siempre positivo)
    mrs2 <- sum(p[,2])+mrs1
    
    
    #10) CALCULO CUANTIL, QUE ES EL VAR
    mat1 <- mrs2[order(mrs2)]
    
    
    vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_n)))])
    var_sm <- sum(p[,2])-vc
    
    lista <- list(var_sm,mat1,vc)
    
    return(lista)
  })
  
  
  #CALCULO VAR PORTAFOLIO MC USANDO MATRIZ DE CORRELACIONES
  #SECCION DISTRIBUCION NORMAL
  output$varmc_portafolio_n1<-renderPrint({
    #añado dependencia
    input$boton21
    
    #
    isolate({
    varmc_por_n1()[[1]]
    })#fin isolate
      
  })
  
  #GRAFICOS SECCION VAR MONTECARLO ELEGIR DISTRIBUCION
  #GRAFICO HISTOGRAMA DE ESCENARIOS VAR SMC DIST ELEGIDA
  output$grafico_hist_smc_el <- renderPlotly({ 
    
    if(is.null(data())){return()}
    #obtengo data escenarios
    mat1 <- (varmc_por_el1()[[2]])
    
    #calculo valor de corte y VaR Monte Carlo
    #vc <- (mat1[length(mat1)*5/100])
    vc <- (varmc_por_el1()[[3]])
    #var_sm <- sum(p[,2])-vc
    #return(var_sm)
    
    
    p2 <- plot_ly(cbind.data.frame(seq(1,length(mat1)),mat1), x = ~mat1) %>% add_histogram(name="Histograma")  %>%
      add_segments(x=vc, y=0, xend=vc, yend=mean(hist(mat1)$counts), line=list(color="red", width = 4),name="Valor Corte") %>%
      layout(title = 'Histograma de Escenarios',
             xaxis = list(title=" "))
    
    p2
    
    
  })
  
  #GRAFICO VARES INDIVIDUALES SIMULACION MONTE CARLO
  output$grafico_vind_mc_el <- renderPlotly({ 
    if(is.null(data())){return()}
    
    #obtengo tabla con vares individuales
    tabla <- varmc_ind_el()
    
    #grafico
    pie <- cbind.data.frame(rownames(tabla)[-nrow(tabla)],tabla[1:(nrow(tabla)-1),2])
    names(pie) <- c("Titulo","ind")
    
    p <- plot_ly(pie, labels = ~Titulo, values = ~ind, type = 'pie') %>%
      layout(title = 'VaRes Individuales')
    
    p
  })
  
  #GRAFICO COMPARATIVO VARES INDIVIDUALES VS VAR PORTAFOLIO SIMULACION MONTE CARLO
  output$grafico_comp_mc_el <- renderPlotly({ 
    if(is.null(data())){return()}
    
    #obtengo vares individuales 
    varind <- varmc_ind_el()
    
    #obtengo var portafolio
    varpor <- varmc_por_el1()[[1]]
    
    
    #grafico
    p <- plot_ly(marker = list(color = 'royalblue1',
                               line = list(color = 'rgb(8,48,107)',
                                           width = 3))) %>%
      add_bars(
        x = c("Individual"),
        y = varind[nrow(varind),2],
        width = 0.3,
        marker = list(
          color = 'royalblue1'
        ),
        name = 'Suma VaRes individuales'
      ) %>%
      add_bars(
        x = c("Portafolio"),
        y = varpor,
        width = 0.3,
        marker = list(
          color = 'mediumseagreen'
        ),
        name = 'VaR Portafolio'
      )
    
    p
    
  })
  
  #FUNCIONES AUXILIARES REPORTE VAR
  #VAR PARAMETRICO
  #vares normales individuales
  var_normal_ind<-reactive({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]

    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }

    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))

    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }

    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      #creo estructura de tabla
      tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 4))
      names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
      rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")

      data1 <- as.data.frame(matrix(0,nrow = 1,ncol = ncol(rend)))
      names(data1) <- names(data())[-c(1,(b+1))]


      for(i in 1:ncol(data1)){
        data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      }

      #relleno desviaciones estandar
      tabla[,1] <- c(as.numeric(data1),NA)

      # #relleno valor nominal
      tabla[,2] <- c(data_pos()[-b,2],sum(data_pos()[-b,2]))

      # #relleno Vares individuales
      tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
      tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])

      #relleno VaR en porcentaje
      tabla[,4] <- tabla[,3]*100/tabla[nrow(tabla),3]
      tabla[nrow(tabla),4] <- sum(tabla[1:((nrow(tabla))-1),4])

      return(tabla)

    }

    #creo estructura de tabla
    tabla <- as.data.frame(matrix(0,nrow = (ncol(data())),ncol = 4))
    names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
    rownames(tabla) <- c(names(data())[-1],"Totales")

    data1 <- as.data.frame(matrix(0,nrow = 1,ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]


    for(i in 1:ncol(data1)){
      # if(anyNA(rend[,i])){
      #   a <- which(is.na(rend[,i])|is.infinite(rend[,i]))
      #   data1[1,i] <- as.numeric(fitdistr(rend[-a,i],"normal")$estimate)[2]
      # }else{
      #   data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      # }
      data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]

    }

    #relleno desviaciones estandar
    tabla[,1] <- c(as.numeric(data1),NA)

    # #relleno valor nominal
    tabla[,2] <- c(data_pos()[,2],sum(data_pos()[,2]))

    # #relleno Vares individuales
    tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
    tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])

    #relleno VaR en porcentaje
    tabla[,4] <- tabla[,3]*100/tabla[nrow(tabla),3]
    tabla[nrow(tabla),4] <- sum(tabla[1:((nrow(tabla))-1),4])

    tabla
  })

  #var normal Portafolio
  #calculo VaR normal Portafolio
  var_normal_por <- reactive({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      #creo estructura de tabla
      tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 4))
      names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
      rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")
      
      data1 <- as.data.frame(matrix(0,nrow = 1,ncol = ncol(rend)))
      names(data1) <- names(data())[-c(1,(b+1))]
      
      
      for(i in 1:ncol(data1)){
        data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      }
      
      #relleno desviaciones estandar
      tabla[,1] <- c(as.numeric(data1),NA)
      
      # #relleno valor nominal
      tabla[,2] <- c(data_pos()[-b,2],sum(data_pos()[-b,2]))
      
      # #relleno Vares individuales
      tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
      tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
      
      
      #calculo matriz de correlaciones (diagonal de 1's)
      S<- cor(rend)
      
      #VaR
      var_ind <- tabla[1:(nrow(tabla)-1),3]
      #var_ind%*%S
      VaR <- sqrt(var_ind%*%S%*%as.matrix(var_ind))
      return(VaR)
      
      
    }#final if problemas de rend
    
    #creo estructura de tabla
    tabla <- as.data.frame(matrix(0,nrow = (ncol(data())),ncol = 3))
    names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual")
    rownames(tabla) <- c(names(data())[-1],"Totales")
    
    
    data1 <- as.data.frame(matrix(0,nrow = 1,ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]
    
    
    for(i in 1:ncol(data1)){
      data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
    }
    
    #relleno desviaciones estandar
    tabla[,1] <- c(as.numeric(data1),NA)
    
    # #relleno valor nominal
    tabla[,2] <- c(data_pos()[,2],sum(data_pos()[,2]))
    
    # #relleno Vares individuales
    tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
    tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
    
    #calculo matriz de correlaciones (diagonal de 1's)
    S<- cor(rend)
    
    #VaR
    var_ind <- tabla[1:(nrow(tabla)-1),3]
    #var_ind%*%S
    VaR <- sqrt(var_ind%*%S%*%as.matrix(var_ind))
    return(VaR)
    
    
    
  })
  
  #VAR SIMULACION HISTORICA
  #CALCULO VARES INDIVIDUALES SIMULACION HISTORICA
  var_historico_ind <- reactive({ 
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #leo posiciones
    p <- data_pos()
    #p$pesos <- p[,2]/sum(p[,2])
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo posiciones
      p <- p[-b,]
      #p[,3] <- p[,2]/sum(p[,2])
      
      ma <- as.data.frame(matrix(0,nrow = nrow(rend),ncol = ncol(rend)))
      names(ma) <- paste(names(rend),"esc",sep = "_")
      
      
      #calculo escenarios
      for(i in 1:ncol(ma)){
        ma[,i] <- (1+as.numeric(rend[,i]))*(p[i,2])
      }
      
      #esc <- cbind.data.frame(rend,ma)
      
      #creo estructura para guardar Vares individuales
      var_ind <- cbind.data.frame("Títulos"=c(as.character(p[,1]),"Totales"),"Valor Nominal"=c(p[,2],sum(p[,2])),"Vares individuales"=rep(0,1+nrow(p)))
      
      for(i in 1:ncol(rend)){
        ma1 <- ma[order(ma[,i]),i]
        var_ind[i,3] <- (p[i,2])-ma1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        
      }
      
      var_ind[nrow(var_ind),3] <- sum(var_ind[1:(nrow(var_ind)-1),3])
      var_ind
      # #Ordeno data
      # esc1 <- esc[,ncol(esc)]
      # esc1 <- esc1[order(esc1)]
      
      #VaRsh <- sum(p[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
      #VaRsh
      
      
      
      
      #}else{return()}
      
    }else{
      ma <- as.data.frame(matrix(0,nrow = nrow(rend),ncol = ncol(rend)))
      names(ma) <- paste(names(rend),"esc",sep = "_")
      
      
      
      #calculo escenarios
      for(i in 1:ncol(ma)){
        ma[,i] <- (1+as.numeric(rend[,i]))*(p[i,2])
      }
      
      #esc <- cbind.data.frame(rend,ma)
      
      #creo estructura para guardar Vares individuales
      var_ind <- cbind.data.frame("Títulos"=c(as.character(p[,1]),"Totales"),"Valor Nominal"=c(p[,2],sum(p[,2])),"Vares individuales"=rep(0,1+nrow(p)))
      
      for(i in 1:ncol(rend)){
        ma1 <- ma[order(ma[,i]),i]
        var_ind[i,3] <- (p[i,2])-ma1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        
      }
      
      var_ind[nrow(var_ind),3] <- sum(var_ind[1:(nrow(var_ind)-1),3])
      var_ind
      #if(sum(p[,3])==1){
      #calculo escenarios
      # for(i in 1:nrow(rend)){
      #   esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
      # }
      # #esc[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh)))),ncol(esc)]
      # esc1 <- esc[,ncol(esc)]
      # esc1 <- esc1[order(esc1)]
      # 
      # VaRsh <- sum(data_pos()[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
      # VaRsh        
      
      # }else{return()}
      
    }
    
    
    
  })
  
  #VaR historico Portafolio
  var_historico_por <- reactive({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #calculo pesos
    p <- data_pos()
    p$pesos <- p[,2]/sum(p[,2])
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo pesos
      p <- p[-b,]
      p[,3] <- p[,2]/sum(p[,2])
      
      esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
      if(sum(p[,3])==1){
        #calculo escenarios
        for(i in 1:nrow(rend)){
          esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        }
        
        #Ordeno data
        esc1 <- esc[,ncol(esc)]
        esc1 <- esc1[order(esc1)]
        
        VaRsh <- sum(p[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        VaRsh
      }else{return()}
      
    }else{
      esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
      if(sum(p[,3])==1){
        #calculo escenarios
        for(i in 1:nrow(rend)){
          esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        }
        #esc[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh)))),ncol(esc)]
        esc1 <- esc[,ncol(esc)]
        esc1 <- esc1[order(esc1)]
        
        VaRsh <- sum(data_pos()[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        VaRsh        
        
      }else{return()}
      
    }
    
    
    
    
  })
  
  
  #REPORTE VAR
  output$reporte_var <- downloadHandler(
    filename = "reporte_var.pdf",
    content = function(file) {
      tempReport <- file.path(tempdir(), "reporte_var.Rmd")
      #tempReport <- file.path(getwd(), "reporte1.Rmd")
      
      file.copy("reporte_var.Rmd", tempReport, overwrite = TRUE)
      
      # Configuración de parámetros pasados a documento Rmd
      # params <- list(titulos = c(input$t1_comp,input$t2_comp,input$t3_comp),
      #                pre_prom = tf_comp(),
      #                par_ns_t = gra_tif_ns_comp_i(),
      #                par_sven_t= gra_tif_sven_comp_i(),
      #                par_dl_t=dl_tif(),
      #                par_sp_t=spline_tif_comp(),
      #                comp_pre_t=precios_tif()
      # 
      # )
      
      params <- list(fecha = input$date_var,tabla_nominal = data_pos() ,
                     var_par_ind = var_normal_ind(), var_par_por = var_normal_por(),
                     var_hist_ind = var_historico_ind(),var_hist_por = var_historico_por(),
                     var_sm_ind_n = varmc_ind_n(), var_sm_por_n = varmc_por_n1()[[1]],
                     var_sm_ind_el = varmc_ind_el(),var_sm_por_el = varmc_por_el1()[[1]])
      
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempReport, output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
      )
    })
  
  #HISTORICOS
  #FECHAS DISPONIBLES
  output$fechas_disponibles_par <- renderText({
    paste(as.character(min(fe_var()))," al ",as.character(max(fe_var())))
  })
  
  output$fechas_disponibles_hist <- renderText({
    paste(as.character(min(fe_var()))," al ",as.character(max(fe_var())))
  })
  
  output$fechas_disponibles_smc1 <- renderText({
    paste(as.character(min(fe_var()))," al ",as.character(max(fe_var())))
  })
  
  output$fechas_disponibles_smc2 <- renderText({
    paste(as.character(min(fe_var()))," al ",as.character(max(fe_var())))
  })
  
  #VAR PARAMETRICO
  #MUESTRO FECHAS DISPONIBLES
  output$dateRangeText_par  <- renderText({
          paste(as.character(input$dateRange_par), collapse = " y ")
  })
  
  #FUNCION AUXILIAR DATA VAR PARAMETRICO
  data_var <- reactive({
    inFile <- input$file_data
    
    if (is.null(inFile))
      return(NULL)
    
    # read.table(inFile$datapath, header = input$header,
    #            sep = input$sep, quote = input$quote)
    a <- read.delim2(inFile$datapath, header = input$header,
                     sep = input$sep, quote = input$quote)
    
    #ordeno la data de fecha mas reciente a fecha mas antigua
    a[,1] <- as.Date(a[,1])
    a <- a[order(a[,1],decreasing = TRUE),]
    
    #seleciono 252 obs segun fecha seleccionada
    
    #a <- a[which(input$dateRange_par==a[,1]):(251+which(input$date_var==a[,1])),]
    
    return(a)
    
  })
  
  #FUNCION AUXILIAR QUE ME CALCULA FECHAS VARES PARAMETRICOS DIARIOS 
  fecha_par <- reactive({
    data <- data_var()
    
    #creo secuencia de fecha
    fe <- seq(input$dateRange_par[1],input$dateRange_par[2], "days")
    fe <- fe[order(fe,decreasing = TRUE)]
    fe1 <- rep(0,length(fe))
    
    
    for(i in 1:length(fe)){
      if(length(which(as.character(fe[i])==data[,1]))!=0){
        fe1[i] <- 1
      }
    }
    
    #veo que fechas si estan
    a <- which(fe1==1)
    
    #creo vector de fechas que si salen
    fe2 <- fe[a]
    
    # #creo estructura del VaR
    # var <- cbind.data.frame(fe2,rep(0,length(fe2)))
    # names(var) <- c("Fechas","VaR")
    # 
    # #relleno vares
    # for(i in 1:length(fe2)){
    #   var[i,2] <- funcion(fe2[i])
    # }
    
    return(fe2)
    
  })
  
  #FUNCION AUXILIAR QUE CALCULAR VAR PAR PARA UNA FECHA DADA
  #QUE VARIA SEGUN FECHAS SELECCIONADAS
  var_parametrico <- reactive({
    #LEO FECHAS A CALCULAR
    #if(is.null(fecha_par())){return()}
    fe <- fecha_par()
    
    #CREO ESTRUCTURA PARA GUARDAR LOS VARES
    var <- cbind.data.frame(fe,rep(0,length(fe)))
    names(var) <- c("Fechas","VaRes")
    
    #CREO FOR PARA CALCULAR TODOS LOS VARES PEDIDOS
    #ES POSIBLE QUE SE DEMORE UN TIEMPO
    for(j in 1:length(fe)){
    # 
    #j <- 1
    # #ACTUALIZO DATA CON LA QUE TRABAJARE
     data0 <- data_var()
     
    # #SELECCIONO 252 OBS SEGUN FECHA SELECCIONADA
     data <- data0[which(fe[j]==data0[,1]):(251+which(fe[j]==data0[,1])),]
     
    #calculo sd
     if(is.null(data)){return()}
     rend <- as.data.frame(matrix(0,nrow = (nrow(data)-1),ncol = (ncol(data)-1)))
     names(rend) <- names(data)[-1]
     
     for(i in 1:(ncol(data)-1)){
       rend[,i] <- diff(log(data[,i+1]))
     }
     
    #veo si hay valores NA o inf en la data
     a <- rep(0,ncol(rend))
     
     for(i in 1:ncol(rend)){
       if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
         a[i] <- 1
       }
     }
     
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
       rend <- rend[,-b]
      #creo estructura de tabla
       tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 4))
       names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
       rownames(tabla) <- c(names(data)[-c(1,(b+1))],"Totales")
     
       data1 <- as.data.frame(matrix(0,nrow = 1,ncol = ncol(rend)))
       names(data1) <- names(data)[-c(1,(b+1))]
     
     
       for(i in 1:ncol(data1)){
         data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
       }
     
       #relleno desviaciones estandar
       tabla[,1] <- c(as.numeric(data1),NA)
     
        #relleno valor nominal
       tabla[,2] <- c(data_pos()[-b,2],sum(data_pos()[-b,2]))
     
       #relleno Vares individuales
       tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
       tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
     
      #calculo matriz de correlaciones (diagonal de 1's)
       S<- cor(rend)
     
       #VaR
       var_ind <- tabla[1:(nrow(tabla)-1),3]
       #var_ind%*%S
       VaR <- sqrt(var_ind%*%S%*%as.matrix(var_ind))
       var[j,2] <- as.numeric(VaR)
    #  # return(VaR)
    # 
    # 
    #  var[j,2] <- tabla[nrow(tabla),3]
      #return(var)
     }else{#final if problemas de rend
     
     #creo estructura de tabla
       tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 4))
       names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
       rownames(tabla) <- c(names(data)[-c(1,(b+1))],"Totales")
    
     data1 <- as.data.frame(matrix(0,nrow = 1,ncol = (ncol(data)-1)))
     names(data1) <- names(data)[-1]
     
     
     for(i in 1:ncol(data1)){
       data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
     }
     
     #relleno desviaciones estandar
     tabla[,1] <- c(as.numeric(data1),NA)
     
     #relleno valor nominal
     tabla[,2] <- c(data_pos()[,2],sum(data_pos()[,2]))
     
     #relleno Vares individuales
     tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
     tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
     
     #calculo matriz de correlaciones (diagonal de 1's)
     S<- cor(rend)
     
     #VaR
     var_ind <- tabla[1:(nrow(tabla)-1),3]
     #var_ind%*%S
     VaR <- sqrt(var_ind%*%S%*%as.matrix(var_ind))
    # #return(VaR)
     var[j,2] <- as.numeric(VaR)
    # var[j,2] <- tabla[nrow(tabla),3]
     #return(var)
     }
     }

    return(var)
    
  })
  
  #GENERO OUTPUT
  output$historico_par <- DT::renderDataTable({
    #añado dependencia
    input$boton23
    
    #
    isolate({
    
    a <- try(var_parametrico())
    
    if(class(a)!="try-error"){
      write.table(a,paste(getwd(),"data","Historico_var_par.txt",sep = "/"),row.names = FALSE)
      a
    }else{}
    
    })#fin isolate
  })
  
  #EXPORTO DATA
  output$data_var_par <-  downloadHandler(
    filename = function() {
      paste("Var_parametrico", ".txt", sep = "")
    },
    content = function(file) {
      write.table(var_parametrico(), file, row.names = FALSE)
    }
  )
  
  #VAR HISTORICO
  output$dateRangeText_hist  <- renderText({
    paste(as.character(input$dateRange_hist), collapse = " y ")
  })
  
  #FUNCION AUXILIAR QUE ME CALCULA FECHAS VARES HISTORICOS DIARIOS 
  fecha_hist <- reactive({
    data <- data_var()
    
    #creo secuencia de fecha
    fe <- seq(input$dateRange_hist[1],input$dateRange_hist[2], "days")
    fe <- fe[order(fe,decreasing = TRUE)]
    fe1 <- rep(0,length(fe))
    
    
    for(i in 1:length(fe)){
      if(length(which(as.character(fe[i])==data[,1]))!=0){
        fe1[i] <- 1
      }
    }
    
    #veo que fechas si estan
    a <- which(fe1==1)
    
    #creo vector de fechas que si salen
    fe2 <- fe[a]
    
    return(fe2)
    
  })
  
  #FUNCION AUXILIAR QUE CALCULAR VAR PAR PARA UNA FECHA DADA
  #QUE VARIA SEGUN FECHAS SELECCIONADAS
  var_historico <- reactive({
    #LEO FECHAS A CALCULAR
    #if(is.null(fecha_par())){return()}
    fe <- fecha_hist()
    
    #CREO ESTRUCTURA PARA GUARDAR LOS VARES
    var <- cbind.data.frame(fe,rep(0,length(fe)))
    names(var) <- c("Fechas","VaRes")
    
    #CREO FOR PARA CALCULAR TODOS LOS VARES PEDIDOS
    #ES POSIBLE QUE SE DEMORE UN TIEMPO
    for(j in 1:length(fe)){
      # 
      #j <- 1
      # #ACTUALIZO DATA CON LA QUE TRABAJARE
      data0 <- data_var()
      
      # #SELECCIONO 252 OBS SEGUN FECHA SELECCIONADA
      data <- data0[which(fe[j]==data0[,1]):(251+which(fe[j]==data0[,1])),]
      
      #calculo sd
      if(is.null(data)){return()}
      rend <- as.data.frame(matrix(0,nrow = (nrow(data)-1),ncol = (ncol(data)-1)))
      names(rend) <- names(data)[-1]
      
      for(i in 1:(ncol(data)-1)){
        rend[,i] <- diff(log(data[,i+1]))
      }
      
      #veo si hay valores NA o inf en la data
      a <- rep(0,ncol(rend))
      
      for(i in 1:ncol(rend)){
        if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
          a[i] <- 1
        }
      }
      
      #calculo pesos
      p <- data_pos()
      p$pesos <- p[,2]/sum(p[,2])
      
      
      #cuando hay problemas con rend
      #titulos donde hay problema
      b <- which(a==1)
      if(sum(a)>=1){
        rend <- rend[,-b]
        
        #actualizo pesos
        p <- p[-b,]
        p[,3] <- p[,2]/sum(p[,2])
        
        esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
        if(sum(p[,3])==1){
          #calculo escenarios
          for(i in 1:nrow(rend)){
            esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
          }
          
          #Ordeno data
          esc1 <- esc[,ncol(esc)]
          esc1 <- esc1[order(esc1)]
          
          VaRsh <- sum(p[,2])-esc1[round((nrow(data)-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
          var[j,2] <- VaRsh
        }else{return()}
        
      }else{
        esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
        if(sum(p[,3])==1){
          #calculo escenarios
          for(i in 1:nrow(rend)){
            esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
          }
          #esc[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh)))),ncol(esc)]
          esc1 <- esc[,ncol(esc)]
          esc1 <- esc1[order(esc1)]
          
          VaRsh <- sum(data_pos()[,2])-esc1[round((nrow(data)-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
          var[j,2] <- VaRsh       
          
        }else{return()}
        
      }
    }#final for Vares
      
    return(var)
    
  })
  
  #GENERO OUTPUT
  output$historico_hist <- DT::renderDataTable({
    #añado dependencia
    input$boton24
    
    #
    isolate({
    
    a <- try(var_historico())
    
    if(class(a)!="try-error"){
    write.table(a,paste(getwd(),"data","Historico_var_sh.txt",sep = "/"),row.names = FALSE)
    a
    }else{}
    
    })#fin isolate
  })
  
  #DESCARGAR DATA
  output$data_var_hist <-  downloadHandler(
    filename = function() {
      paste("Var_historico", ".txt", sep = "")
    },
    content = function(file) {
      write.table(var_historico(), file, row.names = FALSE)
    }
  )
  
  #VAR SMC NORMAL
  output$dateRangeText_smc1  <- renderText({
    paste(as.character(input$dateRange_smc1), collapse = " y ")
  })
  
  #FUNCION AUXILIAR QUE ME CALCULA FECHAS VARES HISTORICOS DIARIOS 
  fecha_smc1 <- reactive({
    data <- data_var()
    
    #creo secuencia de fecha
    fe <- seq(input$dateRange_smc1[1],input$dateRange_smc1[2], "days")
    fe <- fe[order(fe,decreasing = TRUE)]
    fe1 <- rep(0,length(fe))
    
    
    for(i in 1:length(fe)){
      if(length(which(as.character(fe[i])==data[,1]))!=0){
        fe1[i] <- 1
      }
    }
    
    #veo que fechas si estan
    a <- which(fe1==1)
    
    #creo vector de fechas que si salen
    fe2 <- fe[a]
    
    return(fe2)
    
  })
  
  #FUNCION AUXILIAR QUE CALCULAR VAR PAR PARA UNA FECHA DADA
  #QUE VARIA SEGUN FECHAS SELECCIONADAS
  var_smc1 <- reactive({
    #LEO FECHAS A CALCULAR
    #if(is.null(fecha_par())){return()}
    fe <- fecha_smc1()
    
    #CREO ESTRUCTURA PARA GUARDAR LOS VARES
    var <- cbind.data.frame(fe,rep(0,length(fe)))
    names(var) <- c("Fechas","VaRes")
    
    #CREO FOR PARA CALCULAR TODOS LOS VARES PEDIDOS
    #ES POSIBLE QUE SE DEMORE UN TIEMPO
    for(j in 1:length(fe)){
      # 
      #j <- 1
      # #ACTUALIZO DATA CON LA QUE TRABAJARE
      data0 <- data_var()
      
      # #SELECCIONO 252 OBS SEGUN FECHA SELECCIONADA
      data <- data0[which(fe[j]==data0[,1]):(251+which(fe[j]==data0[,1])),]
      
      #--#
      #calculo sd
      if(is.null(data)){return()}
      rend <- as.data.frame(matrix(0,nrow = (nrow(data)-1),ncol = (ncol(data)-1)))
      names(rend) <- names(data)[-1]
      
      for(i in 1:(ncol(data)-1)){
        rend[,i] <- diff(log(data[,i+1]))
      }
      
      #veo si hay valores NA o inf en la data
      a <- rep(0,ncol(rend))
      
      for(i in 1:ncol(rend)){
        if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
          a[i] <- 1
        }
      }
      
      #leo posiciones
      p <- data_pos()
      #p$pesos <- p[,2]/sum(p[,2])
      
      
      #cuando hay problemas con rend
      #titulos donde hay problema
      b <- which(a==1)
      if(sum(a)>=1){
        rend <- rend[,-b]
        
        #actualizo posiciones
        p <- p[-b,]
        #p[,3] <- p[,2]/sum(p[,2])
        
        #creo matriz donde guardare simulaciones de cada instrumento
        mat <- (matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend))))
        names(mat) <- c(names(rend))
        
        #relleno matriz de simulaciones
        withProgress(message = 'Calculando números aleatorios', value = 0, {
          incProgress(1/3, detail = "Realizando iteraciones")
          for(i in 1:ncol(rend)){
            mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
          }
        })
        
        #2) CALCULO MATRIZ DE CHOLESKY
        cholesky <- t(chol(cor(rend,use="complete.obs")))
        
        #5) REALIZO PRODUCTO DE ESC*MAT CHOLESKY
        mrs <- mat%*%t(cholesky)
        
        #6) calculo "incremento de precio"
        mrs1 <- mrs%*%(p[,2])
        
        #7) calculo "precio" (siempre positivo)
        mrs2 <- sum(p[,2])+mrs1
        
        
        #10) CALCULO CUANTIL, QUE ES EL VAR
        mat1 <- mrs2[order(mrs2)]
        
        
        vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_n)))])
        var_sm <- sum(p[,2])-vc
        
        #lista <- list(var_sm,mat1,vc)
        
        #return(lista)
        var[j,2] <- var_sm
        
        
      }#final if
      
      #creo matriz donde guardare simulaciones de cada instrumento
      mat <- (matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend))))
      names(mat) <- c(names(rend))
      
      #relleno matriz de simulaciones
      withProgress(message = 'Calculando números aleatorios', value = 0, {
        incProgress(1/3, detail = "Realizando iteraciones")
        for(i in 1:ncol(rend)){
          mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
        }
      })
      
      #2) CALCULO MATRIZ DE CHOLESKY
      cholesky <- t(chol(cor(rend,use="complete.obs")))
      
      #5) REALIZO PRODUCTO DE ESC*MAT CHOLESKY
      mrs <- mat%*%t(cholesky)
      
      #6) calculo "incremento de precio"
      mrs1 <- mrs%*%(p[,2])
      
      #7) calculo "precio" (siempre positivo)
      mrs2 <- sum(p[,2])+mrs1
      
      
      #10) CALCULO CUANTIL, QUE ES EL VAR
      mat1 <- mrs2[order(mrs2)]
      
      
      vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_n)))])
      var_sm <- sum(p[,2])-vc
      
      #lista <- list(var_sm,mat1,vc)
      var[j,2] <- var_sm
      
      #--#
      
    }#final for Vares
    
    return(var)
    
  })
  
  #GENERO OUTPUT
  output$historico_smc1 <- DT::renderDataTable({
    #añado dependencia
    input$boton25
    
    #
    isolate({
      
    a <- try(var_smc1())
    
    if(class(a)!="try-error"){
    write.table(a,paste(getwd(),"data","Historico_var_smcn.txt",sep = "/"),row.names = FALSE)
    a
    }else{}
    })#fin isolate
  })
  
  #DESCARGO DATA
  output$data_var_smc1 <- downloadHandler(
    filename = function() {
      paste("Var_smc_normal", ".txt", sep = "")
    },
    content = function(file) {
      write.table(var_smc1(), file, row.names = FALSE)
    }
  )
  
  #VAR SMC MEJOR DISTRIBUCION
  output$dateRangeText_smc2  <- renderText({
    paste(as.character(input$dateRange_smc2), collapse = " y ")
  })
  
  #FUNCION AUXILIAR QUE ME CALCULA FECHAS VARES HISTORICOS DIARIOS 
  fecha_smc2 <- reactive({
    data <- data_var()
    
    #creo secuencia de fecha
    fe <- seq(input$dateRange_smc2[1],input$dateRange_smc2[2], "days")
    fe <- fe[order(fe,decreasing = TRUE)]
    fe1 <- rep(0,length(fe))
    
    
    for(i in 1:length(fe)){
      if(length(which(as.character(fe[i])==data[,1]))!=0){
        fe1[i] <- 1
      }
    }
    
    #veo que fechas si estan
    a <- which(fe1==1)
    
    #creo vector de fechas que si salen
    fe2 <- fe[a]
    
    return(fe2)
  })
  
  #FUNCION AUXILIAR QUE CALCULAR VAR PAR PARA UNA FECHA DADA
  #QUE VARIA SEGUN FECHAS SELECCIONADAS
  var_smc2 <- reactive({
    #LEO FECHAS A CALCULAR
    #if(is.null(fecha_par())){return()}
    fe <- fecha_smc2()

        #CREO ESTRUCTURA PARA GUARDAR LOS VARES
    var <- cbind.data.frame(fe,rep(0,length(fe)))
    names(var) <- c("Fechas","VaRes")
    
    
    #CREO FOR PARA CALCULAR TODOS LOS VARES PEDIDOS
    #ES POSIBLE QUE SE DEMORE UN TIEMPO
    for(j in 1:length(fe)){
      # 
      #j <- 1
      # #ACTUALIZO DATA CON LA QUE TRABAJARE
      data0 <- data_var()

     # #SELECCIONO 252 OBS SEGUN FECHA SELECCIONADA
      data <- data0[which(fe[j]==data0[,1]):(251+which(fe[j]==data0[,1])),]

      #--#
      #calculo sd
      if(is.null(data)){return()}
      rend <- as.data.frame(matrix(0,nrow = (nrow(data)-1),ncol = (ncol(data)-1)))
      names(rend) <- names(data)[-1]

      for(i in 1:(ncol(data)-1)){
        rend[,i] <- diff(log(data[,i+1]))
      }

      #veo si hay valores NA o inf en la data
      a <- rep(0,ncol(rend))

      for(i in 1:ncol(rend)){
        if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
          a[i] <- 1
        }
      }

      #leo posiciones
      p <- data_pos()
      #p$pesos <- p[,2]/sum(p[,2])

      #leo distribuciones
      if(input$seleccion_dist==0){
        dist <- distribuciones()
      }else if(input$seleccion_dist==1){
        #dist <- read.csv(paste(getwd(),"data","distribuciones2.txt",sep = "/"),sep="")
        #dist <- read.csv(paste(getwd(),"data","distribuciones3.txt",sep = "/"),sep="")
        dist <- datadist()

        }

      #cuando hay problemas con rend
      #titulos donde hay problema
      b <- which(a==1)
      if(sum(a)>=1){
        rend <- rend[,-b]

        #actualizo posiciones
        p <- p[-b,]
        #p[,3] <- p[,2]/sum(p[,2])

        #actualizo distribuciones
        dist <- dist[,-b]

        #creo matriz donde guardare simulaciones de cada instrumento
        #mat <- as.data.frame(matrix(0,nrow = input$sim_varmc_el,ncol = (ncol(rend)+2)))
        #names(mat) <- c(names(rend),"incremento","escenario")
        mat <- (matrix(0,nrow = input$sim_varmc_el,ncol = (ncol(rend))))
        names(mat) <- c(names(rend))


        #relleno matriz de simulaciones
        withProgress(message = 'Calculando números aleatorios', value = 0, {
          incProgress(1/3, detail = "Realizando iteraciones")
          for(i in 1:ncol(rend)){
            #mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
            if(as.character(dist[,i])=="Normal"){
              #n_rand <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
              #calculo momentos
              a1 <- lmom.ub(rend[,i])
              #convierto valor anterior en parametros
              b1 <- lmom2par(a1,type="nor") #normal
              #realizo simulacion
              mat[,i] <- rlmomco(input$sim_varmc_el,b1)
            }else if(as.character(dist[,i])=="Exponential"){
              #n_rand <- rexp(n = input$sim_varmc_n,rate = as.numeric(fitdistr(rend[,i],"exponential")$estimate))
              #calculo momentos
              a1 <- lmom.ub(rend[,i])
              #convierto valor anterior en parametros
              b1 <- lmom2par(a1,type="exp") #normal
              #realizo simulacion
              mat[,i] <- rlmomco(input$sim_varmc_el,b1)
            }else if(as.character(dist[,i])=="Cauchy"){
              #n_rand <- rcauchy(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[2])
              #calculo momentos
              a1 <- lmom.ub(rend[,i])
              #convierto valor anterior en parametros
              b1 <- lmom2par(a1,type="cau") #normal
              #realizo simulacion
              mat[,i] <- rlmomco(input$sim_varmc_el,b1)
            }else if(as.character(dist[,i])=="Logistic"){
              #n_rand <- rlogis(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"logistic")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"logistic")$estimate)[2])
              #calculo momentos
              a1 <- lmom.ub(rend[,i])
              #convierto valor anterior en parametros
              b1 <- lmom2par(a1,type="glo") #normal
              #realizo simulacion
              mat[,i] <- rlmomco(input$sim_varmc_el,b1)
            }else if(as.character(dist[,i])=="Beta"){
              #
            }else if(as.character(dist[,i])=="Chi-square"){
              #
            }else if(as.character(dist[,i])=="Uniform"){
              #
            }else if(as.character(dist[,i])=="Gamma"){
              #n_rand <- rgamma(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[1],rate = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[2])
              #calculo momentos
              a1 <- lmom.ub(rend[,i])
              #convierto valor anterior en parametros
              b1 <- lmom2par(a1,type="gam") #normal
              #realizo simulacion
              mat[,i] <- rlmomco(input$sim_varmc_el,b1)
            }else if(as.character(dist[,i])=="Lognormal"){
              mat[,i] <- rlnorm(n = input$sim_varmc_el,meanlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[1],sdlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[2])
            }else if(as.character(dist[,i])=="Weibull"){
              #n_rand <- rweibull(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[1],scale = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[2])
              #calculo momentos
              a1 <- lmom.ub(rend[,i])
              #convierto valor anterior en parametros
              b1 <- lmom2par(a1,type="wei") #normal
              #realizo simulacion
              mat[,i] <- rlmomco(input$sim_varmc_el,b1)
            }else if(as.character(dist[,i])=="F"){
              #
            }else if(as.character(dist[,i])=="Student"){
              #
              #calculo momentos
              a1 <- lmom.ub(rend[,i])
              #convierto valor anterior en parametros
              b1 <- lmom2par(a1,type="st3") #normal
              #realizo simulacion
              mat[,i] <- rlmomco(input$sim_varmc_el,b1)
            }else if(as.character(dist[,i])=="Gompertz"){
              #
            }else{
              mat[,i] <- rep(0,input$sim_varmc_el)
            }


          }
        })

        #CALCULO MATRIZ DE CHOLESKY
        cholesky <- t(chol(cor(rend,use="complete.obs")))

        #5) REALIZO PRODUCTO DE MATRIZ DE N ALEATORIOS*MAT CHOLESKY
        mrs <- mat%*%t(cholesky)

        #6) calculo "incremento de precio"
        mrs1 <- mrs%*%p[,2]

        #7) calculo "precio" (siempre positivo)
        mrs2 <- sum(p[,2])+mrs1


        #10) CALCULO CUANTIL, QUE ES EL VAR
        #quantile(gop2,  probs = c(0.05),type = 1)
        #ordeno columna "escenarios"
        mat1 <- mrs2[order(mrs2)]

        #calculo valor de corte y VaR Monte Carlo
         #vc <- (mat1[length(mat1)*5/100])
         vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_el)))])
         var_sm <- sum(p[,2])-vc

        var[j,2] <- var_sm

        #return(as.data.frame(var_sm))

      }else{#final if

      #creo matriz donde guardare simulaciones de cada instrumento
      #mat <- as.data.frame(matrix(0,nrow = input$sim_varmc_el,ncol = (ncol(rend)+2)))
      #names(mat) <- c(names(rend),"incremento","escenario")
      mat <- (matrix(0,nrow = input$sim_varmc_el,ncol = (ncol(rend))))
      names(mat) <- c(names(rend))


      #relleno matriz de simulaciones
      withProgress(message = 'Calculando números aleatorios', value = 0, {
        incProgress(1/3, detail = "Realizando iteraciones")
        for(i in 1:ncol(rend)){
          #mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
          if(as.character(dist[,i])=="Normal"){
            #n_rand <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="nor") #normal
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Exponential"){
            #n_rand <- rexp(n = input$sim_varmc_n,rate = as.numeric(fitdistr(rend[,i],"exponential")$estimate))
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="exp") #normal
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Cauchy"){
            #n_rand <- rcauchy(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="cau") #normal
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Logistic"){
            #n_rand <- rlogis(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"logistic")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"logistic")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="glo") #normal
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Beta"){
            #
          }else if(as.character(dist[,i])=="Chi-square"){
            #
          }else if(as.character(dist[,i])=="Uniform"){
            #
          }else if(as.character(dist[,i])=="Gamma"){
            #n_rand <- rgamma(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[1],rate = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="gam") #normal
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Lognormal"){
            mat[,i] <- rlnorm(n = input$sim_varmc_el,meanlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[1],sdlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[2])
          }else if(as.character(dist[,i])=="Weibull"){
            #n_rand <- rweibull(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[1],scale = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="wei") #normal
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="F"){
            #
          }else if(as.character(dist[,i])=="Student"){
            #
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="st3") #normal
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Gompertz"){
            #
          }else{
            mat[,i] <- rep(0,input$sim_varmc_el)
          }


        }
      })

      #CALCULO MATRIZ DE CHOLESKY
      cholesky <- t(chol(cor(rend,use="complete.obs")))

      #5) REALIZO PRODUCTO DE MATRIZ DE N ALEATORIOS*MAT CHOLESKY
      mrs <- mat%*%t(cholesky)

      #6) calculo "incremento de precio"
      mrs1 <- mrs%*%p[,2]

      #7) calculo "precio" (siempre positivo)
      mrs2 <- sum(p[,2])+mrs1


      #10) CALCULO CUANTIL, QUE ES EL VAR
      #quantile(gop2,  probs = c(0.05),type = 1)
      #ordeno columna "escenarios"
      mat1 <- mrs2[order(mrs2)]

      #calculo valor de corte y VaR Monte Carlo
      #vc <- (mat1[length(mat1)*5/100])
      vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_el)))])
      var_sm <- sum(p[,2])-vc

      var[j,2] <- var_sm

      }


    }#final for Vares

    return(var)
    
  })
  
  #GENERO OUTPUT
  output$historico_smc2 <- DT::renderDataTable({
    #añado dependencia
    input$boton26
    
    #
    isolate({
    a <- try(var_smc2())
    
    if(class(a)!="try-error"){
    write.table(a,paste(getwd(),"data","Historico_var_smcmd.txt",sep = "/"),row.names = FALSE)
    a
    }else{}
    })#fin isolate
  })
  
  #DESCARGO DATA
  output$data_var_smc2 <- downloadHandler(
    filename = function() {
      paste("Var_smc_md", ".txt", sep = "")
    },
    content = function(file) {
      write.table(var_smc2(), file, row.names = FALSE)
    }
  )
  
  ###############################################################################
  ###############################################################################
  #################################    BACKTESTING    ###########################
  ###############################################################################
  ###############################################################################
  
  
  data_back <- reactive({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file_data_back
    
    if (is.null(inFile))
      return(NULL)
    
    # read.table(inFile$datapath, header = input$header,
    #            sep = input$sep, quote = input$quote)
    a <- read.delim2(inFile$datapath, header = input$header_back,
                     sep = input$sep_back, quote = input$quote_back)
    
    return(a)
    
  })
  
  
  output$datatable_back<-DT::renderDataTable({
    if(is.null(data_back())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    DT::datatable(data_back())
  })
  
  #PORCENTAJE DEL VAR
  output$back_porcentaje <- renderPrint({as.numeric(sub(",",".",input$porback))})
  
  
  #funcion auxiliar Backtesting
  source(paste(getwd(),"Scripts auxiliares","kup1.R",sep = "/"))
  
  #muestro resultado Backtesting
  output$result_back <- renderPrint({
    data <- data_back()
    
    if(length(data[,1])!=0){
    
    #convierto a fecha
    data[,1] <- as.Date(as.character(data[,1]),format="%d/%m/%Y")
    #convierto en numero
    data[,2] <- as.numeric(as.character(data[,2]))
    data[,3] <- as.numeric(as.character(data[,3]))
    
    #diseño data frame para usarlo en kup1
    #numero de observaciones
    data$obs <- seq(1,nrow(data))
    
    #VaR -
    data$var_menos <- rep(0,nrow(data))
    for(i in 1:(nrow(data)-1)){
    data$var_menos[i] <- data[i+1,3]-data[i+1,2]
    }
    
    
    #VaR +
    data$var_mas <- rep(0,nrow(data))
    for(i in 1:(nrow(data)-1)){
      data$var_mas[i] <- data[i+1,3]+data[i+1,2]
    }
    
    #ordeno data
    data <- data[,c(4,1,2,5,3,6)]
    #names(data) <- c("obs","fecha","var","var_menos","posicion","var_mas")
    names(data) <- c("V1","V2","V3","V4","V5","V6")
    
    
    #uso funcion kup1
    #a <- kup1(data,0.05)
    a <- kup1(data,(1-as.numeric(sub(",",".",input$porback))))
    #return(a)
    }else{}
  })
  
  #GRAFICO BACKTESTING
  output$grafico_back <- renderPlotly({
    if(is.null(data_back())){return()}
    data <- data_back()
    
    if(length(data[,1])!=0){
      
      #convierto a fecha
      data[,1] <- as.Date(as.character(data[,1]),format="%d/%m/%Y")
      #convierto en numero
      data[,2] <- as.numeric(as.character(data[,2]))
      data[,3] <- as.numeric(as.character(data[,3]))
      
      #diseño data frame para usarlo en kup1
      #numero de observaciones
      data$obs <- seq(1,nrow(data))
      
      #VaR -
      data$var_menos <- rep(0,nrow(data))
      for(i in 1:(nrow(data)-1)){
        data$var_menos[i] <- data[i+1,3]-data[i+1,2]
      }
      
      
      #VaR +
      data$var_mas <- rep(0,nrow(data))
      for(i in 1:(nrow(data)-1)){
        data$var_mas[i] <- data[i+1,3]+data[i+1,2]
      }
      
      #ordeno data
      data <- data[,c(4,1,2,5,3,6)]
      #names(data) <- c("obs","fecha","var","var_menos","posicion","var_mas")
      names(data) <- c("V1","V2","V3","V4","V5","V6")
      
      
      #uso funcion kup1
      #a <- kup1(data,0.05)
      a <- kup1(data,(1-as.numeric(sub(",",".",input$porback))))
      #return(a)
    }else{}
    
    par <- a[[2]]
    #df2 <- data.frame(supp=rep(c("VC", "OJ"), each=3),
    #                                     dose=rep(c("D0.5", "D1", "D2"),2),
    #                                     len=c(6.8, 15, 33, 4.2, 10, 29.5))
    df2 <- data.frame(Valores=rep(c("Estadísticos", "Valores críticos"), each=3),
                                         Test=rep(c("Test Kupiec", "Test de Haas", "Test mixto"),2),
                                         Valor=c(as.numeric(par[1,]),as.numeric(par[2,])))
    
    p <- ggplot(data=df2, aes(x=Test, y=Valor, fill=Valores)) +
           geom_bar(stat="identity")+scale_fill_brewer(palette="Paired")
    
    p
  })
  
  #funcion auxiliar para reporte
  back <- reactive({
    data <- data_back()
    
    if(length(data[,1])!=0){
      
      #convierto a fecha
      data[,1] <- as.Date(as.character(data[,1]),format="%d/%m/%Y")
      #convierto en numero
      data[,2] <- as.numeric(as.character(data[,2]))
      data[,3] <- as.numeric(as.character(data[,3]))
      
      #diseño data frame para usarlo en kup1
      #numero de observaciones
      data$obs <- seq(1,nrow(data))
      
      #VaR -
      data$var_menos <- rep(0,nrow(data))
      for(i in 1:(nrow(data)-1)){
        data$var_menos[i] <- data[i+1,3]-data[i+1,2]
      }
      
      
      #VaR +
      data$var_mas <- rep(0,nrow(data))
      for(i in 1:(nrow(data)-1)){
        data$var_mas[i] <- data[i+1,3]+data[i+1,2]
      }
      
      #ordeno data
      data <- data[,c(4,1,2,5,3,6)]
      #names(data) <- c("obs","fecha","var","var_menos","posicion","var_mas")
      names(data) <- c("V1","V2","V3","V4","V5","V6")
      
      
      #uso funcion kup1
      #kup1(data,0.05)
      kup1(data,(1-as.numeric(sub(",",".",input$porback))))
      
    }else{}
  
  })
  ###############################################################################
  ###############################################################################
  #################################    BACKTESTING    ###########################
  ###############################################################################
  ###############################################################################
  
  
  data_back <- reactive({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file_data_back
    
    if (is.null(inFile))
      return(NULL)
    
    # read.table(inFile$datapath, header = input$header,
    #            sep = input$sep, quote = input$quote)
    a <- read.delim2(inFile$datapath, header = input$header_back,
                     sep = input$sep_back, quote = input$quote_back)
    
    return(a)
    
  })
  
  
  output$datatable_back<-DT::renderDataTable({
    if(is.null(data_back())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    DT::datatable(data_back())
  })
  
  # REPORTE BACKTESTING 
  
  output$report_back <- downloadHandler(
    filename = "reporte_back.pdf",
    content = function(file) {
      tempReport <- file.path(tempdir(), "reporte_back.Rmd")
      #tempReport <- file.path(getwd(), "reporte1.Rmd")
      
      file.copy("reporte_back.Rmd", tempReport, overwrite = TRUE)
      
      # Configuración de parámetros pasados a documento Rmd
      params <- list(resultados = back()
                     
                     
                     # data2 = data()$corriente,
                     # data3 = data()$corriente.rem,
                     # dist1 = input$distVarA,
                     # dist2 = input$distVarC,
                     # dist3 = input$distVarCR,
                     # pconf = input$porVar,
                     # reali = input$reali,
                     # revi = input$revi
      )
      
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempReport, output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
      )
    })
  
  
  ###############################################################################
  ###############################################################################
  #################################    VALORACION    ############################
  ###############################################################################
  ###############################################################################
  
  
  data_val <- reactive({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file_data_val
    
    if (is.null(inFile))
      return(NULL)
    
    # read.table(inFile$datapath, header = input$header,
    #            sep = input$sep, quote = input$quote)
    a <- read.delim2(inFile$datapath, header = input$header_val,
                     sep = input$sep_val, quote = input$quote_val)
    
    return(a)
    
  })
  
  
  output$datatable_val<-DT::renderDataTable({
    if(is.null(data_val())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    DT::datatable(data_val())
  })
  
  #DATA PRECIOS PARA VALORACION ESTRESADA
  data_val_estres <- reactive({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file_data_val_estres
    
    if (is.null(inFile))
      return(NULL)
    
    # read.table(inFile$datapath, header = input$header,
    #            sep = input$sep, quote = input$quote)
    a <- read.delim2(inFile$datapath, header = input$header_val_estres,
                     sep = input$sep_val_estres, quote = input$quote_val_estres)
    
    return(a)
    
  })
  
  
  output$datatable_val_estres<-DT::renderDataTable({
    if(is.null(data_val_estres())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    DT::datatable(data_val_estres())
  })
  
  #advertencia
  output$datatable_val_estres_ad <- renderPrint({
    if(is.null(data_val()) | is.null(data_val_estres()) ){return()}
    #cargo historico
    a <- data_val_estres()
    #data val
    b <- data_val()
    
    d <- names(a)[-1]==as.character(b[,1])
    
    if(sum(d)==nrow(b)){
      print("Coincidencia en instrumentos")
    }else{
      print("No existe coincidencia en instrumentos")
    }
    
    
  })
  
  #resultados valoracion
  output$result_val <- DT::renderDataTable({
    if(is.null(data_val())){return()}
    a <- data_val()
    #convierto en numero diferentes columnas
    #valor nominal
    a[,3] <- as.numeric(as.character(a[,3]))
    #precio hoy
    a[,4] <- as.numeric(as.character(a[,4]))
    #precio mercado
    a[,5] <- as.numeric(as.character(a[,5]))
    #calculo mtm
    a$mtm <- a[,3]*a[,5]/100
    #calculo utilidad o perdida
    a$ut_per <- a$mtm*((a[,5]-a[,4])/100)
    
    DT::datatable(a, options = list(paging = FALSE))
  })
  
  #GRAFICO
  output$grafico_val1 <- renderPlotly({
    if(is.null(data_val())){return()}
    a <- data_val()
    #convierto en numero diferentes columnas
    #valor nominal
    a[,3] <- as.numeric(as.character(a[,3]))
    #precio hoy
    a[,4] <- as.numeric(as.character(a[,4]))
    #precio mercado
    a[,5] <- as.numeric(as.character(a[,5]))
    #calculo mtm
    a$mtm <- a[,3]*a[,5]/100
    #calculo utilidad o perdida
    a$ut_per <- a$mtm*((a[,5]-a[,4])/100)
    
    #grafico
    b <- cbind.data.frame(as.character(a[,1]),a$ut_per)
    names(b) <- c("titulo","ut_per")
    
    
    p <- ggplot(b, aes(reorder(titulo,ut_per), ut_per, fill = titulo)) +
      geom_bar(position="stack", stat="identity",show.legend = FALSE) + coord_flip() +
      labs(x = "Títulos",y = "Utilidad o pérdida")+
      theme(axis.text.y=element_text(angle=0, hjust=1,size = 6))
    
    #plot_ly(p)
    p
  })
  
  #resultados portafolio
  output$result_val_port <- DT::renderDataTable({
    if(is.null(data_val())){return()}
    a <- data_val()
    #valor nominal
    a[,3] <- as.numeric(as.character(a[,3]))
    #precio hoy
    a[,4] <- as.numeric(as.character(a[,4]))
    #precio mercado
    a[,5] <- as.numeric(as.character(a[,5]))
    #calculo mtm
    a$mtm <- a[,3]*a[,5]/100
    #calculo utilidad o perdida
    a$ut_per <- a$mtm*((a[,5]-a[,4])/100)
    
    #resumen
    #determino cuantos tipos de instrumentos hay
    #a$tit <- substr(a[,1],1,3)
    #a$tit <- as.factor(a$tit)
    a[,2] <- as.factor(a[,2])
    
    #cant <- length(levels(a$tit))
    cant <- length(levels(a[,2]))
    le <- as.character(levels(a[,2]))
    
    b <- as.data.frame(matrix(0,nrow = cant,ncol = 3))
    names(b) <- c("Valor Nominal","Promedio Precio Mercado","UTD/PER")
    #extraigo tipos de titulos
    #supongo que solo hay un solo tipo de instrumento
    #d <- substr(as.character(a[1,1]),1,3)
    row.names(b) <- as.character(levels(a[,2]))
    
    #length(levels(data_valoracion_1$tit))
    for(i in 1:cant){
    #suma valor nominal
    b[i,1] <- sum(a[which(le[i]==a[,2]),3])
    #precio promedio ponderado
    b[i,2] <- sum((a[which(le[i]==a[,2]),3])*(a[which(le[i]==a[,2]),5]))/sum(a[which(le[i]==a[,2]),3])
    #utilidad o perdida
    b[i,3] <- sum(a$ut_per[which(le[i]==a[,2])])
    }
    #
    b1 <- rbind.data.frame(b,c(sum(b[,1]),(sum(b[,1]*b[,2])/sum(b[,1])),sum(b[,3])))
    row.names(b1)[nrow(b1)] <- "TOTALES" 
    b1
    #return(a)
  })
  
  #resultados valoracion estresada
  output$result_val_estres <- DT::renderDataTable({
    if(is.null(data_val()) | is.null(data_val_estres()) ){return()}
    a <- data_val()
    a[,3] <- as.numeric(as.character(a[,3]))
    #a[,5] <- as.numeric(as.character(a[,5]))
    a[,4] <- as.numeric(as.character(a[,4]))
    a[,5] <- as.numeric(as.character(a[,5]))
    
    #calculo desviacion estandar de historico de tit
    #data <- read.delim2(paste(getwd(),"data","tif.txt",sep = "/"))
    data <- data_val_estres()
    a$sd <-rep(0,nrow(a))
    
    for(i in 1:nrow(a)){
      #a$sd[i] <- sd(data[,i+1],na.rm = TRUE)
      a$sd[i] <- sd(as.numeric(sub(",",".",as.character(data[((nrow(data)-40):nrow(data)),i+1]))),na.rm = TRUE)
      #a$sd[i] <- as.numeric(sub(",",".",as.character(data[nrow(data),i+1])))
    }
    
    a$precio_estres <- a[,5]-a$sd
    a$mtm <- a[,3]*a$precio_estres/100
    #a$ut_per <- a$mtm-(a[,3]*a$precio_estres/100)
    a$ut_per1 <- a$mtm*((a[,5]-a[,4])/100)
    a$ut_per2 <- a$mtm*((a$precio_estres-a[,5])/100)
    DT::datatable(a, options = list(paging = FALSE))
  })
  
  #grafico estres
  output$grafico_val2 <- renderPlotly({
    if(is.null(data_val()) | is.null(data_val_estres()) ){return()}
    a <- data_val()
    a[,3] <- as.numeric(as.character(a[,3]))
    #a[,5] <- as.numeric(as.character(a[,5]))
    a[,4] <- as.numeric(as.character(a[,4]))
    a[,5] <- as.numeric(as.character(a[,5]))
    
    #calculo desviacion estandar de historico de tit
    #data <- read.delim2(paste(getwd(),"data","tif.txt",sep = "/"))
    data <- data_val_estres()
    a$sd <-rep(0,nrow(a))
    
    for(i in 1:nrow(a)){
      #a$sd[i] <- sd(data[,i+1],na.rm = TRUE)
      a$sd[i] <- sd(as.numeric(sub(",",".",as.character(data[((nrow(data)-40):nrow(data)),i+1]))),na.rm = TRUE)
      #a$sd[i] <- as.numeric(sub(",",".",as.character(data[nrow(data),i+1])))
    }
    
    a$precio_estres <- a[,5]-a$sd
    a$mtm <- a[,3]*a$precio_estres/100
    #a$ut_per <- a$mtm-(a[,3]*a$precio_estres/100)
    a$ut_per1 <- a$mtm*((a[,5]-a[,4])/100)
    a$ut_per2 <- a$mtm*((a$precio_estres-a[,5])/100)
    
    #grafico
    b <- cbind.data.frame(as.character(a[,1]),a$ut_per2)
    names(b) <- c("titulo","ut_per")
    
    
    p <- ggplot(b, aes(reorder(titulo,ut_per), ut_per, fill = titulo)) +
      geom_bar(position="stack", stat="identity",show.legend = FALSE) + coord_flip() +
      labs(x = "Títulos",y = "Utilidad o pérdida")+
      theme(axis.text.y=element_text(angle=0, hjust=1,size = 6))
    
    #plot_ly(p)
    p
  })
  
  
  
  #resultados prueba estres portafolio
  output$result_val_estres_port <- DT::renderDataTable({
    if(is.null(data_val()) | is.null(data_val_estres()) ){return()}
    a <- data_val()
    a[,3] <- as.numeric(as.character(a[,3]))
    #a[,5] <- as.numeric(as.character(a[,5]))
    a[,4] <- as.numeric(as.character(a[,4]))
    a[,5] <- as.numeric(as.character(a[,5]))
    
    #calculo desviacion estandar de historico de tit
    #data <- read.delim2(paste(getwd(),"data","tif.txt",sep = "/"))
    data <- data_val_estres()
    a$sd <-rep(0,nrow(a))
    
    for(i in 1:nrow(a)){
      #a$sd[i] <- sd(data[,i+1],na.rm = TRUE)
      a$sd[i] <- sd(as.numeric(sub(",",".",as.character(data[((nrow(data)-40):nrow(data)),i+1]))),na.rm = TRUE)
      
    }
    
    a$precio_estres <- a[,5]-a$sd
    a$mtm <- a[,3]*a$precio_estres/100
    #a$ut_per <- a$mtm-(a[,3]*a$precio_estres/100)
    a$ut_per1 <- a$mtm*((a[,5]-a[,4])/100)
    a$ut_per2 <- a$mtm*((a$precio_estres-a[,5])/100)
    a
    
    #a partir de aqui hacer resumen
    #determino cuantos tipos de instrumentos hay
    #a$tit <- substr(a[,1],1,3)
    #a$tit <- as.factor(a$tit)
    a[,2] <- as.factor(a[,2])
    
    #cant <- length(levels(a$tit))
    cant <- length(levels(a[,2]))
    le <- as.character(levels(a[,2]))
    
    b <- as.data.frame(matrix(0,nrow = cant,ncol = 4))
    names(b) <- c("Valor Nominal","Promedio Precio Mercado","UTD/PER","UTD/PER-ESTRÉS")
    #extraigo tipos de titulos
    #supongo que solo hay un solo tipo de instrumento
    #d <- substr(as.character(a[1,1]),1,3)
    row.names(b) <- as.character(levels(a[,2]))
    
    #length(levels(data_valoracion_1$tit))
    for(i in 1:cant){
      #suma valor nominal
      b[i,1] <- sum(a[which(le[i]==a[,2]),3])
      #precio promedio ponderado
      b[i,2] <- sum((a[which(le[i]==a[,2]),3])*(a[which(le[i]==a[,2]),5]))/sum(a[which(le[i]==a[,2]),3])
      #utilidad o perdida
      b[i,3] <- sum(a$ut_per1[which(le[i]==a[,2])])
      #utilidad o perdida estres
      b[i,4] <- sum(a$ut_per2[which(le[i]==a[,2])])

    }
    #
    b1 <- rbind.data.frame(b,c(sum(b[,1]),(sum(b[,1]*b[,2])/sum(b[,1])),sum(b[,3]),sum(b[,4])))
    row.names(b1)[nrow(b1)] <- "TOTALES" 
    b1
  })
  
  #VARIABLES AUXILIAR
  #resultados valoracion
  val1 <- reactive({
    if(is.null(data_val())){return()}
    a <- data_val()
    #convierto en numero diferentes columnas
    #valor nominal
    a[,3] <- as.numeric(as.character(a[,3]))
    #precio hoy
    a[,4] <- as.numeric(as.character(a[,4]))
    #precio mercado
    a[,5] <- as.numeric(as.character(a[,5]))
    #calculo mtm
    a$mtm <- a[,3]*a[,5]/100
    #calculo utilidad o perdida
    a$ut_per <- a$mtm*((a[,5]-a[,4])/100)
    a
  })
  
  #
  val2 <- reactive({
    if(is.null(data_val())){return()}
    a <- data_val()
    #valor nominal
    a[,3] <- as.numeric(as.character(a[,3]))
    #precio hoy
    a[,4] <- as.numeric(as.character(a[,4]))
    #precio mercado
    a[,5] <- as.numeric(as.character(a[,5]))
    #calculo mtm
    a$mtm <- a[,3]*a[,5]/100
    #calculo utilidad o perdida
    a$ut_per <- a$mtm*((a[,5]-a[,4])/100)
    
    #resumen
    #determino cuantos tipos de instrumentos hay
    #a$tit <- substr(a[,1],1,3)
    #a$tit <- as.factor(a$tit)
    a[,2] <- as.factor(a[,2])
    
    #cant <- length(levels(a$tit))
    cant <- length(levels(a[,2]))
    le <- as.character(levels(a[,2]))
    
    b <- as.data.frame(matrix(0,nrow = cant,ncol = 3))
    names(b) <- c("Valor Nominal","Promedio Precio Mercado","UTD/PER")
    #extraigo tipos de titulos
    #supongo que solo hay un solo tipo de instrumento
    #d <- substr(as.character(a[1,1]),1,3)
    row.names(b) <- as.character(levels(a[,2]))
    
    #length(levels(data_valoracion_1$tit))
    for(i in 1:cant){
      #suma valor nominal
      b[i,1] <- sum(a[which(le[i]==a[,2]),3])
      #precio promedio ponderado
      b[i,2] <- sum((a[which(le[i]==a[,2]),3])*(a[which(le[i]==a[,2]),5]))/sum(a[which(le[i]==a[,2]),3])
      #utilidad o perdida
      b[i,3] <- sum(a$ut_per[which(le[i]==a[,2])])
    }
    #
    b1 <- rbind.data.frame(b,c(sum(b[,1]),(sum(b[,1]*b[,2])/sum(b[,1])),sum(b[,3])))
    row.names(b1)[nrow(b1)] <- "TOTALES" 
    b1
    
  })
  
  # REPORTE VALORACION 1
  output$report_val1 <- downloadHandler(
    filename = "reporte_val1.pdf",
    content = function(file) {
      tempReport <- file.path(tempdir(), "reporte_val1.Rmd")
      #tempReport <- file.path(getwd(), "reporte1.Rmd")
      
      file.copy("reporte_val1.Rmd", tempReport, overwrite = TRUE)
      
      # Configuración de parámetros pasados a documento Rmd
      params <- list(valind = val1(),valpor = val2()
                     
                     
                     # data2 = data()$corriente,
                     # data3 = data()$corriente.rem,
                     # dist1 = input$distVarA,
                     # dist2 = input$distVarC,
                     # dist3 = input$distVarCR,
                     # pconf = input$porVar,
                     # reali = input$reali,
                     # revi = input$revi
      )
      
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempReport, output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
      )
    })
  
  #VARIABLES AUXILIARES VALORACION ESTRES
  val1_e <- reactive({
    if(is.null(data_val()) | is.null(data_val_estres()) ){return()}
    a <- data_val()
    a[,3] <- as.numeric(as.character(a[,3]))
    #a[,5] <- as.numeric(as.character(a[,5]))
    a[,4] <- as.numeric(as.character(a[,4]))
    a[,5] <- as.numeric(as.character(a[,5]))
    
    #calculo desviacion estandar de historico de tit
    #data <- read.delim2(paste(getwd(),"data","tif.txt",sep = "/"))
    data <- data_val_estres()
    a$sd <-rep(0,nrow(a))
    
    for(i in 1:nrow(a)){
      #a$sd[i] <- sd(data[,i+1],na.rm = TRUE)
      a$sd[i] <- sd(as.numeric(sub(",",".",as.character(data[((nrow(data)-40):nrow(data)),i+1]))),na.rm = TRUE)
      
    }
    
    a$precio_estres <- a[,5]-a$sd
    a$mtm <- a[,3]*a$precio_estres/100
    #a$ut_per <- a$mtm-(a[,3]*a$precio_estres/100)
    a$ut_per1 <- a$mtm*((a[,5]-a[,4])/100)
    a$ut_per2 <- a$mtm*((a$precio_estres-a[,5])/100)
    a
    
  })
  
  #
  val2_e <- reactive({
    if(is.null(data_val()) | is.null(data_val_estres()) ){return()}
    a <- data_val()
    a[,3] <- as.numeric(as.character(a[,3]))
    #a[,5] <- as.numeric(as.character(a[,5]))
    a[,4] <- as.numeric(as.character(a[,4]))
    a[,5] <- as.numeric(as.character(a[,5]))
    
    #calculo desviacion estandar de historico de tit
    #data <- read.delim2(paste(getwd(),"data","tif.txt",sep = "/"))
    data <- data_val_estres()
    a$sd <-rep(0,nrow(a))
    
    for(i in 1:nrow(a)){
      #a$sd[i] <- sd(data[,i+1],na.rm = TRUE)
      a$sd[i] <- sd(as.numeric(sub(",",".",as.character(data[((nrow(data)-40):nrow(data)),i+1]))),na.rm = TRUE)
      
    }
    
    a$precio_estres <- a[,5]-a$sd
    a$mtm <- a[,3]*a$precio_estres/100
    #a$ut_per <- a$mtm-(a[,3]*a$precio_estres/100)
    a$ut_per1 <- a$mtm*((a[,5]-a[,4])/100)
    a$ut_per2 <- a$mtm*((a$precio_estres-a[,5])/100)
    a
    
    #a partir de aqui hacer resumen
    #determino cuantos tipos de instrumentos hay
    #a$tit <- substr(a[,1],1,3)
    #a$tit <- as.factor(a$tit)
    a[,2] <- as.factor(a[,2])
    
    #cant <- length(levels(a$tit))
    cant <- length(levels(a[,2]))
    le <- as.character(levels(a[,2]))
    
    b <- as.data.frame(matrix(0,nrow = cant,ncol = 4))
    names(b) <- c("Valor Nominal","Promedio Precio Mercado","UTD/PER","UTD/PER-ESTRÉS")
    #extraigo tipos de titulos
    #supongo que solo hay un solo tipo de instrumento
    #d <- substr(as.character(a[1,1]),1,3)
    row.names(b) <- as.character(levels(a[,2]))
    
    #length(levels(data_valoracion_1$tit))
    for(i in 1:cant){
      #suma valor nominal
      b[i,1] <- sum(a[which(le[i]==a[,2]),3])
      #precio promedio ponderado
      b[i,2] <- sum((a[which(le[i]==a[,2]),3])*(a[which(le[i]==a[,2]),5]))/sum(a[which(le[i]==a[,2]),3])
      #utilidad o perdida
      b[i,3] <- sum(a$ut_per1[which(le[i]==a[,2])])
      #utilidad o perdida estres
      b[i,4] <- sum(a$ut_per2[which(le[i]==a[,2])])
      
    }
    #
    b1 <- rbind.data.frame(b,c(sum(b[,1]),(sum(b[,1]*b[,2])/sum(b[,1])),sum(b[,3]),sum(b[,4])))
    row.names(b1)[nrow(b1)] <- "TOTALES" 
    b1
    
  })
  
  
  # REPORTE VALORACION 2
  output$report_val2 <- downloadHandler(
    filename = "reporte_val2.pdf",
    content = function(file) {
      tempReport <- file.path(tempdir(), "reporte_val2.Rmd")
      #tempReport <- file.path(getwd(), "reporte1.Rmd")
      
      file.copy("reporte_val2.Rmd", tempReport, overwrite = TRUE)
      
      # Configuración de parámetros pasados a documento Rmd
      params <- list(valinde = val1_e(),valpore = val2_e()
                     
                     
                     # data2 = data()$corriente,
                     # data3 = data()$corriente.rem,
                     # dist1 = input$distVarA,
                     # dist2 = input$distVarC,
                     # dist3 = input$distVarCR,
                     # pconf = input$porVar,
                     # reali = input$reali,
                     # revi = input$revi
      )
      
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempReport, output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
      )
    })
  
  # Almacenar Variables Reactivas
  # RV <- reactiveValues()
  # 
  # set.seed(122)
  # histdata <- rnorm(500)
  # 
  # output$plot1 <- renderPlot({
  #   data <- histdata[seq_len(input$slider)]
  #   hist(data)
  # })
 
})
