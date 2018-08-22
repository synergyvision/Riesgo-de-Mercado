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
  output$q1_dl <- renderPrint({c(input$t1_dl,input$t2_dl,input$t3_dl,input$t4_dl)})
  output$q1_sp <- renderPrint({c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp)})
  #vebonos
  output$q2<-renderPrint({c(input$v1,input$v2,input$v3,input$v4)})
  output$q2_ns<-renderPrint({c(input$v1_ns,input$v2_ns,input$v3_ns,input$v4_ns)})
  output$q2_dl<-renderPrint({c(input$v1_dl,input$v2_dl,input$v3_dl,input$v4_dl)})
  output$q2_sp<-renderPrint({c(input$v1_sp,input$v2_sp,input$v3_sp,input$v4_sp)})
  #precios
  tf <- reactive({pos(c(input$t1,input$t2,input$t3,input$t4),0)})
  tf_ns <- reactive({pos(c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),0)})
  tf_dl <- reactive({pos(c(input$t1_dl,input$t2_dl,input$t3_dl,input$t4_dl),0)})
  tf_sp <- reactive({pos(c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),0)})
  tv <- reactive({pos(c(input$v1,input$v2,input$v3,input$v4),1)})
  tv_ns <- reactive({pos(c(input$v1_ns,input$v2_ns,input$v3_ns,input$v4_ns),1)})
  tv_dl <- reactive({pos(c(input$v1_dl,input$v2_dl,input$v3_dl,input$v4_dl),1)})
  tv_sp <- reactive({pos(c(input$v1_sp,input$v2_sp,input$v3_sp,input$v4_sp),1)})
  output$pre1 <-renderPrint({tf()})
  output$pre1_ns <-renderPrint({tf_ns()})
  output$pre2 <-renderPrint({tv()})
  output$pre2_ns <-renderPrint({tv_ns()})
  
  output$pre1_dl <-renderPrint({tf_dl()})
  output$pre1_sp <-renderPrint({tf_sp()})
  
  output$pre2_dl <-renderPrint({tv_dl()})
  output$pre2_sp <-renderPrint({tv_sp()})
  
  #parametros
  #output$pa_tif <- renderPrint({print(paste0("$$\\beta_{0}$$"))})
  output$pa_tif <- renderPrint({pa_sven})
  # output$formula <- renderPrint({
  #   return(paste0("Use this formula: $$\beta_{0}", 1,"$$"))
  # })
  # output$ex1 <- renderPrint({
  #  #withMathJax(helpText('$$\\beta_{0} \\quad \\beta_{1}  \\quad \\beta_{2} \\quad \\beta_{3} \\quad \\tau_{1} \\quad\\tau_{2} $$'))
  #   withMathJax(print(pa_ns))
  #   })
  output$pa_tif_ns <- renderPrint({(pa_ns)})
  output$pa_tif_ns_el <- renderPrint({(pa_ns)})
  output$pa_veb <- renderPrint({pa1_sven})
  output$pa_veb_ns <- renderPrint({pa1_ns})
  
  #parametros elegir
  #NELSON Y SIEGEL
  #tif
  #individuales
  output$num_ns_b0_tif<-renderPrint({input$ns_b0_tif})
  output$num_ns_b1_tif<-renderPrint({input$ns_b1_tif})
  output$num_ns_b2_tif<-renderPrint({input$ns_b2_tif})
  output$num_ns_t_tif<-renderPrint({input$ns_t_tif})
  
  #conjunto
  output$new_ns_tif <- renderPrint({(data.frame('B0'=input$ns_b0_tif,'B1'=input$ns_b1_tif,'B2'=input$ns_b2_tif,'T'=input$ns_t_tif,row.names = " " ))})
  
  #verificacion
  output$ver_ns_tif <- renderPrint({data.frame('Condición_1'=input$ns_b0_tif>0,'Condición_2'=input$ns_b0_tif+input$ns_b1_tif>0,'Condición_3'=input$ns_t_tif>0,row.names = " " )})
  
  #veb
  #individuales
  output$num_ns_b0_veb<-renderPrint({input$ns_b0_veb})
  output$num_ns_b1_veb<-renderPrint({input$ns_b1_veb})
  output$num_ns_b2_veb<-renderPrint({input$ns_b2_veb})
  output$num_ns_t_veb<-renderPrint({input$ns_t_veb})
  
  #conjunto
  output$new_ns_veb <- renderPrint({(data.frame('B0'=input$ns_b0_veb,'B1'=input$ns_b1_veb,'B2'=input$ns_b2_veb,'T'=input$ns_t_veb,row.names = " " ))})
  
  #verificacion
  output$ver_ns_veb <- renderPrint({data.frame('Condición_1'=input$ns_b0_veb>0,'Condición_2'=input$ns_b0_veb+input$ns_b1_veb>0,'Condición_3'=input$ns_t_veb>0,row.names = " " )})
  
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
  output$new_sven_tif <- renderPrint({(data.frame('B0'=input$sven_b0_tif,'B1'=input$sven_b1_tif,'B2'=input$sven_b2_tif,'B3'=input$sven_b3_tif,'T1'=input$sven_t1_tif,'T2'=input$sven_t2_tif,row.names = " " ))})
  
  #verificacion
  output$ver_sven_tif <- renderPrint({data.frame('Condición_1'=input$sven_b0_tif>0,'Condición_2'=input$sven_b0_tif+input$sven_b1_tif>0,'Condición_3'=input$sven_t1_tif>0,'Condición_4'=input$sven_t2_tif>0,row.names = " " )})
  
  #veb
  output$num_sven_b0_veb<-renderPrint({input$sven_b0_veb})
  output$num_sven_b1_veb<-renderPrint({input$sven_b1_veb})
  output$num_sven_b2_veb<-renderPrint({input$sven_b2_veb})
  output$num_sven_b3_veb<-renderPrint({input$sven_b3_veb})
  output$num_sven_t1_veb<-renderPrint({input$sven_t1_veb})
  output$num_sven_t2_veb<-renderPrint({input$sven_t2_veb})
  
  #conjunto
  output$new_sven_veb <- renderPrint({(data.frame('B0'=input$sven_b0_veb,'B1'=input$sven_b1_veb,'B2'=input$sven_b2_veb,'B3'=input$sven_b3_veb,'T1'=input$sven_t1_veb,'T2'=input$sven_t2_veb,row.names = " " ))})
  
  #verificacion
  output$ver_sven_veb <- renderPrint({data.frame('Condición_1'=input$sven_b0_veb>0,'Condición_2'=input$sven_b0_veb+input$sven_b1_veb>0,'Condición_3'=input$sven_t1_veb>0,'Condición_4'=input$sven_t2_veb>0,row.names = " " )})
  
  
  #muestro caracteristicas
  output$Ca <- renderDataTable({head(C)})
  output$Ca_ns <- renderDataTable({head(C)})
  output$Ca_dl <- renderDataTable({head(C)})
  output$Ca_sp <- renderDataTable({head(C)})
  output$Ca1 <- renderDataTable({head(C)})
  output$Ca1_ns <- renderDataTable({head(C)})
  output$Ca1_dl <- renderDataTable({head(C)})
  output$Ca1_sp <- renderDataTable({head(C)})
  
  #precios estimados iniciales
  output$p_est_tif <- renderDataTable({Tabla.sven(fv = input$n1 ,tit = c(input$t1,input$t2,input$t3,input$t4),pr =tf() ,pa = pa_sven,ind = 0,C = C,fe2=0,fe3=0)[[1]] })
  output$p_est_tif_ns <- renderDataTable({Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = pa_ns,ind = 0,C = C,fe2=0,fe3=0)[[1]] })
  output$p_est_tif_ns_el <- renderDataTable({Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = c(input$ns_b0_tif,input$ns_b1_tif,input$ns_b2_tif,input$ns_t_tif),ind = 0,C = C,fe2=0,fe3=0)[[1]] })
  
  
  output$p_est_veb <- renderDataTable({Tabla.sven(fv = input$n1 ,tit = c(input$v1,input$v2,input$v3,input$v4),pr =tv() ,pa = pa1_sven,ind = 1,C = C,fe2=0,fe3=0)[[1]] })
  output$p_est_veb_ns <- renderDataTable({Tabla.ns(fv = input$n2 ,tit = c(input$v1_ns,input$v2_ns,input$v3_ns,input$v4_ns),pr =tv_ns() ,pa = pa1_ns,ind = 1,C = C,fe2=0,fe3=0)[[1]] })
  output$p_est_veb_ns_el <- renderDataTable({Tabla.ns(fv = input$n2 ,tit = c(input$v1_ns,input$v2_ns,input$v3_ns,input$v4_ns),pr =tv_ns() ,pa =c(input$ns_b0_veb,input$ns_b1_veb,input$ns_b2_veb,input$ns_t_veb) ,ind = 1,C = C,fe2=0,fe3=0)[[1]] })
  
  #precios estimados optimizados
  #paquete alabama
  output$p_est_tif_opt <- renderDataTable({Tabla.sven(fv = input$n1 ,tit = c(input$t1,input$t2,input$t3,input$t4),pr =tf() ,pa = pa_sven,ind = 0,C = C,fe2=input$opt_tif_sven,fe3=0)[[1]] })
  output$p_est_tif_opt_ns <- renderDataTable({Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = pa_ns,ind = 0,C = C,fe2=input$opt_tif_ns,fe3=0)[[1]] })
  output$p_est_tif_opt_sven_el <- renderDataTable({Tabla.sven(fv = input$n1 ,tit = c(input$t1,input$t2,input$t3,input$t4),pr =tf() ,pa = c(input$sven_b0_tif,input$sven_b1_tif,input$sven_b2_tif,input$sven_b3_tif,input$sven_t1_tif,input$sven_t2_tif),ind = 0,C = C,fe2=0,fe3=0)[[1]] })
  
  output$p_est_veb_opt <- renderDataTable({Tabla.sven(fv = input$n1 ,tit = c(input$v1,input$v2,input$v3,input$v4),pr =tv() ,pa = pa1_sven,ind = 1,C = C,fe2=input$opt_veb_sven,fe3=0)[[1]]})
  output$p_est_veb_opt_ns <- renderDataTable({Tabla.ns(fv = input$n2 ,tit = c(input$v1_ns,input$v2_ns,input$v3_ns,input$v4_ns),pr =tv_ns() ,pa = pa1_ns,ind = 1,C = C,fe2=input$opt_veb_ns,fe3=0)[[1]] })
  output$p_est_veb_opt_sven_el <- renderDataTable({Tabla.sven(fv = input$n1 ,tit = c(input$v1,input$v2,input$v3,input$v4),pr =tv() ,pa = c(input$sven_b0_veb,input$sven_b1_veb,input$sven_b2_veb,input$sven_b3_veb,input$sven_t1_veb,input$sven_t2_veb),ind = 1,C = C,fe2=0,fe3=0)[[1]]})
  
  #parametros optimizados
  # output$par_tif_ns_op <- renderPrint({a <- Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = pa_ns,ind = 0,C = C,fe2=input$opt_tif_ns,fe3=0)
  # a[[2]]
  # })
  
  #graficos
  #output$c_tif_ns <- renderPlot({plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=pa_ns)*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Iniciales")})
  #NELSON Y SIEGEL
  #TIF 
   output$c_tif_ns <- renderPlot({
    ggplot(cbind.data.frame(x=seq(1,20,0.1),y=nelson_siegel(t=seq(1,20,0.1),pa=pa_ns)*100),aes(x=x,y=y))+
      geom_line(color="blue")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de rendimiento Nelson y Siegel Parámetros Iniciales TIF")+
      theme(plot.title = element_text(hjust = 0.5))
    
  })
   #
   output$c_tif_ns1_new <- renderPlot({
     ggplot(cbind.data.frame(x=seq(1,20,0.1),y=nelson_siegel(t=seq(1,20,0.1),pa=c(input$ns_b0_tif,input$ns_b1_tif,input$ns_b2_tif,input$ns_t_tif))*100),aes(x=x,y=y))+
       geom_line(color="brown")+xlab("Maduración (años)")+
       ylab("Rendimiento (%)")+theme_gray()+
       ggtitle("Curva de rendimiento Nelson y Siegel Parámetros elegidos TIF")+
       theme(plot.title = element_text(hjust = 0.5))
   })
   #
   output$c_veb_ns1_new <- renderPlot({
     ggplot(cbind.data.frame(x=seq(1,20,0.1),y=nelson_siegel(t=seq(1,20,0.1),pa=c(input$ns_b0_veb,input$ns_b1_veb,input$ns_b2_veb,input$ns_t_veb))*100),aes(x=x,y=y))+
       geom_line(color="brown")+xlab("Maduración (años)")+
       ylab("Rendimiento (%)")+theme_gray()+
       ggtitle("Curva de rendimiento Nelson y Siegel Parámetros elegidos VEBONO")+
       theme(plot.title = element_text(hjust = 0.5))
   })
  #
  output$c_veb_ns <- renderPlot({
    ggplot(cbind.data.frame(x=seq(1,20,0.1),y=nelson_siegel(t=seq(1,20,0.1),pa=pa1_ns)*100),aes(x=x,y=y))+
      geom_line(color="blue")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de rendimiento Nelson y Siegel Parámetros Iniciales VEBONOS")+
      theme(plot.title = element_text(hjust = 0.5))
    
  })
  
  #SVENSSON
  output$c_tif_sven <- renderPlot({
    ggplot(cbind.data.frame(x=seq(1,20,0.1),y=sven(t=seq(1,20,0.1),pa=pa_sven)*100),aes(x=x,y=y))+
      geom_line(color="blue")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de rendimiento Svensson Parámetros Iniciales TIF")+
      theme(plot.title = element_text(hjust = 0.5))
    
  })
  #
  output$c_veb_sven <- renderPlot({
    ggplot(cbind.data.frame(x=seq(1,20,0.1),y=sven(t=seq(1,20,0.1),pa=pa1_sven)*100),aes(x=x,y=y))+
      geom_line(color="blue")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de rendimiento Svensson Parámetros Iniciales VEBONOS")+
      theme(plot.title = element_text(hjust = 0.5))
    
  })
  
  #
  output$c_tif_sven_new <- renderPlot({
    ggplot(cbind.data.frame(x=seq(1,20,0.1),y=sven(t=seq(1,20,0.1),pa=c(input$sven_b0_tif,input$sven_b1_tif,input$sven_b2_tif,input$sven_b3_tif,input$sven_t1_tif,input$sven_t2_tif))*100),aes(x=x,y=y))+
      geom_line(color="brown")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de rendimiento Nelson y Siegel Parámetros elegidos TIF")+
      theme(plot.title = element_text(hjust = 0.5))
  })
  
  #
  output$c_veb_sven_new <- renderPlot({
    ggplot(cbind.data.frame(x=seq(1,20,0.1),y=sven(t=seq(1,20,0.1),pa=c(input$sven_b0_veb,input$sven_b1_veb,input$sven_b2_veb,input$sven_b3_veb,input$sven_t1_veb,input$sven_t2_veb))*100),aes(x=x,y=y))+
      geom_line(color="brown")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de rendimiento Svensson Parámetros elegidos VEBONOS")+
      theme(plot.title = element_text(hjust = 0.5))
  })
  
  #caso Nelson y Siegel
  gra_tif_ns <- reactive({Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = pa_ns,ind = 0,C = C,fe2=input$opt_tif_ns,fe3=0)[[2]] })
  gra_veb_ns <- reactive({Tabla.ns(fv = input$n2 ,tit = c(input$v1_ns,input$v2_ns,input$v3_ns,input$v4_ns),pr =tv_ns() ,pa = pa1_ns,ind = 1,C = C,fe2=input$opt_veb_ns,fe3=0)[[2]] })
  

  output$par_tif_ns_op<-renderPrint({if(input$opt_tif_ns==1){gra_tif_ns()
  }else{}})
  
  
  output$c_tif_ns_op <- renderPlot({if(input$opt_tif_ns==1){
    #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
    ggplot(cbind.data.frame(x=seq(1,20,0.1),y=nelson_siegel(t=seq(1,20,0.1),pa=gra_tif_ns())*100),aes(x=x,y=y))+
      geom_line(color="green")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")+
      theme(plot.title = element_text(hjust = 0.5))
    }else{}})
  
  #
  output$par_veb_ns_op<-renderPrint({if(input$opt_veb_ns==1){gra_veb_ns()
  }else{}})
  
  output$c_veb_ns_op <- renderPlot({if(input$opt_veb_ns==1){
    #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
    ggplot(cbind.data.frame(x=seq(1,20,0.1),y=nelson_siegel(t=seq(1,20,0.1),pa=gra_veb_ns())*100),aes(x=x,y=y))+
      geom_line(color="green")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de redimientos Nelson y Siegel Parametros Optimizados VEBONOS")+
      theme(plot.title = element_text(hjust = 0.5))
  }else{}})
  
  #caso Svensson
  gra_tif_sven <- reactive({Tabla.sven(fv = input$n1 ,tit = c(input$t1,input$t2,input$t3,input$t4),pr =tf() ,pa = pa_sven,ind = 0,C = C,fe2=input$opt_tif_sven,fe3=0)[[2]] })
  gra_veb_sven <- reactive({Tabla.sven(fv = input$n1 ,tit = c(input$v1,input$v2,input$v3,input$v4),pr =tv() ,pa = pa1_sven,ind = 1,C = C,fe2=input$opt_veb_sven,fe3=0)[[2]] })
  
  #tif
  output$par_tif_sven_op<-renderPrint({if(input$opt_tif_sven==1){gra_tif_sven()
  }else{}})
  
  #
  output$c_tif_sven_op <- renderPlot({if(input$opt_tif_sven==1){
    #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
    ggplot(cbind.data.frame(x=seq(1,20,0.1),y=sven(t=seq(1,20,0.1),pa=gra_tif_sven())*100),aes(x=x,y=y))+
      geom_line(color="green")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de redimientos Svensson Parametros Optimizados TIF")+
      theme(plot.title = element_text(hjust = 0.5))
  }else{}})
  
  #veb
  output$par_veb_sven_op<-renderPrint({if(input$opt_veb_sven==1){gra_veb_sven()
  }else{}})
  
  #
  output$c_veb_sven_op <- renderPlot({if(input$opt_veb_sven==1){
    #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
    ggplot(cbind.data.frame(x=seq(1,20,0.1),y=sven(t=seq(1,20,0.1),pa=gra_veb_sven())*100),aes(x=x,y=y))+
      geom_line(color="green")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de redimientos Svensson Parametros Optimizados VEBONOS")+
      theme(plot.title = element_text(hjust = 0.5))
  }else{}})
  
  # Almacenar Variables Reactivas
  RV <- reactiveValues()

  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
 
})
