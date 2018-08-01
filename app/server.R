shinyServer(function(input, output) {

  #fechas
  output$p1<-renderPrint({paste(substr(input$n1,9,10),substr(input$n1,6,7),substr(input$n1,1,4),sep = "/")})
  output$p2<-renderPrint({paste(substr(input$n2,9,10),substr(input$n2,6,7),substr(input$n2,1,4),sep = "/")})
  output$p3<-renderPrint({paste(substr(input$n3,9,10),substr(input$n3,6,7),substr(input$n3,1,4),sep = "/")})
  #titulos
  #tif
  output$q1<-renderPrint({c(input$t1,input$t2,input$t3,input$t4)})
  #vebonos
  output$q2<-renderPrint({c(input$v1,input$v2,input$v3,input$v4)})
  #precios
  tf <- reactive({pos(c(input$t1,input$t2,input$t3,input$t4),0)})
  tv <- reactive({pos(c(input$v1,input$v2,input$v3,input$v4),1)})
  output$pre1 <-renderPrint({tf()})
  output$pre2 <-renderPrint({tv()})
  
  #parametros
  output$pa_tif <- renderPrint({pa})
  output$pa_veb <- renderPrint({pa1})
  
  #muestro caracteristicas
  output$Ca <- renderPrint({head(C)})
  output$Ca1 <- renderPrint({head(C)})
  
  #precios estimados iniciales
  output$p_est_tif <- renderPrint({Tabla.sven(fv = input$n1 ,tit = c(input$t1,input$t2,input$t3,input$t4),pr =tf() ,pa = pa,ind = 0,C = C,fe2=0,fe3=0) })
  output$p_est_veb <- renderPrint({Tabla.sven(fv = input$n1 ,tit = c(input$v1,input$v2,input$v3,input$v4),pr =tv() ,pa = pa1,ind = 1,C = C,fe2=0,fe3=0) })
  
  #precios estimados optimizados
  #paquete alabama
  output$p_est_tif_opt <- renderPrint({Tabla.sven(fv = input$n1 ,tit = c(input$t1,input$t2,input$t3,input$t4),pr =tf() ,pa = pa,ind = 0,C = C,fe2=input$opt_tif,fe3=0) })
  output$p_est_veb_opt <- renderPrint({Tabla.sven(fv = input$n1 ,tit = c(input$v1,input$v2,input$v3,input$v4),pr =tv() ,pa = pa1,ind = 1,C = C,fe2=input$opt_veb,fe3=0) })
  
  
  # Almacenar Variables Reactivas
  RV <- reactiveValues()

  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
 
})
