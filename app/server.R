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
  
  # Almacenar Variables Reactivas
  RV <- reactiveValues()

  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
 
})
