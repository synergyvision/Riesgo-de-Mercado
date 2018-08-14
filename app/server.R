shinyServer(function(input, output) {

  #fechas
  #Svensson
  output$p1<-renderPrint({paste(substr(input$n1,9,10),substr(input$n1,6,7),substr(input$n1,1,4),sep = "/")})
  #Nelson y Siegel
  output$p2<-renderPrint({paste(substr(input$n2,9,10),substr(input$n2,6,7),substr(input$n2,1,4),sep = "/")})
  #Diebold-Li
  output$p3<-renderPrint({paste(substr(input$n3,9,10),substr(input$n3,6,7),substr(input$n3,1,4),sep = "/")})
  #Splines
  output$p4<-renderPrint({paste(substr(input$n4,9,10),substr(input$n4,6,7),substr(input$n4,1,4),sep = "/")})
  #titulos
  #tif
  output$q1<-renderPrint({c(input$t1,input$t2,input$t3,input$t4)})
  output$q1_ns<-renderPrint({c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns)})
  #vebonos
  output$q2<-renderPrint({c(input$v1,input$v2,input$v3,input$v4)})
  output$q2_ns<-renderPrint({c(input$v1_ns,input$v2_ns,input$v3_ns,input$v4_ns)})
  #precios
  tf <- reactive({pos(c(input$t1,input$t2,input$t3,input$t4),0)})
  tf_ns <- reactive({pos(c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),0)})
  tv <- reactive({pos(c(input$v1,input$v2,input$v3,input$v4),1)})
  tv_ns <- reactive({pos(c(input$v1_ns,input$v2_ns,input$v3_ns,input$v4_ns),1)})
  output$pre1 <-renderPrint({tf()})
  output$pre1_ns <-renderPrint({tf_ns()})
  output$pre2 <-renderPrint({tv()})
  output$pre2_ns <-renderPrint({tv_ns()})
  
  #parametros
  #output$pa_tif <- renderPrint({print(paste0("$$\\beta_{0}$$"))})
  output$pa_tif <- renderPrint({pa})
  # output$formula <- renderPrint({
  #   return(paste0("Use this formula: $$\beta_{0}", 1,"$$"))
  # })
  output$pa_tif_ns <- renderPrint({pa_ns})
  output$pa_veb <- renderPrint({pa1})
  output$pa_veb_ns <- renderPrint({pa1_ns})
  
  #muestro caracteristicas
  output$Ca <- renderDataTable({head(C)})
  output$Ca_ns <- renderDataTable({head(C)})
  output$Ca1 <- renderDataTable({head(C)})
  output$Ca1_ns <- renderDataTable({head(C)})
  
  #precios estimados iniciales
  output$p_est_tif <- renderDataTable({Tabla.sven(fv = input$n1 ,tit = c(input$t1,input$t2,input$t3,input$t4),pr =tf() ,pa = pa,ind = 0,C = C,fe2=0,fe3=0) })
  output$p_est_tif_ns <- renderDataTable({Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = pa_ns,ind = 0,C = C,fe2=0,fe3=0) })
  
  
  output$p_est_veb <- renderDataTable({Tabla.sven(fv = input$n1 ,tit = c(input$v1,input$v2,input$v3,input$v4),pr =tv() ,pa = pa1,ind = 1,C = C,fe2=0,fe3=0) })
  output$p_est_veb_ns <- renderDataTable({Tabla.ns(fv = input$n2 ,tit = c(input$v1_ns,input$v2_ns,input$v3_ns,input$v4_ns),pr =tv_ns() ,pa = pa1_ns,ind = 1,C = C,fe2=0,fe3=0) })
  
  
  #precios estimados optimizados
  #paquete alabama
  output$p_est_tif_opt <- renderDataTable({Tabla.sven(fv = input$n1 ,tit = c(input$t1,input$t2,input$t3,input$t4),pr =tf() ,pa = pa,ind = 0,C = C,fe2=input$opt_tif,fe3=0) })
  output$p_est_tif_opt_ns <- renderDataTable({Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = pa_ns,ind = 0,C = C,fe2=input$opt_tif_ns,fe3=0) })
  
  
  output$p_est_veb_opt <- renderDataTable({Tabla.sven(fv = input$n1 ,tit = c(input$v1,input$v2,input$v3,input$v4),pr =tv() ,pa = pa1,ind = 1,C = C,fe2=input$opt_veb,fe3=0) })
  output$p_est_veb_opt_ns <- renderDataTable({Tabla.ns(fv = input$n2 ,tit = c(input$v1_ns,input$v2_ns,input$v3_ns,input$v4_ns),pr =tv_ns() ,pa = pa1_ns,ind = 1,C = C,fe2=input$opt_veb_ns,fe3=0) })
  
  
  # Almacenar Variables Reactivas
  RV <- reactiveValues()

  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
 
})
