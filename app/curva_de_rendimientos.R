#Seccion Curva de Rendimientos

#-##-#-#-#-#-#-#-#-#-#
#-#-NELSON Y SIEGEL#-#
#-##-#-#-#-#-#-#-#-#-#

#####

########.
##TIF###.
########.
#fecha
output$p2<-renderPrint({paste(substr(input$n2,9,10),substr(input$n2,6,7),substr(input$n2,1,4),sep = "/")})
#eleccion de titulos
output$q1_ns<-renderPrint({c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns)})
#precio promedio
#funcion auxiliar
tf_ns <- reactive({pos1(c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),0)})
#eleccion precio promedio
output$pre1_ns <-renderPrint({tf_ns()})
#caracteristica
output$Ca_ns <- renderDataTable({
  ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
  if(class(ca)=="try-error"){
    v <- print("El archivo no se encuentra, descargar y recargar página!")
    return(as.data.frame(v))
  }else{
    return(ca)
  }
})

#seccion parametros iniciales
#parametros inciciales
output$pa_tif_ns <- renderPrint({(pa_ns)})
#precios iniciales
output$p_est_tif_ns <- renderDataTable({Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = pa_ns,ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")) ,fe2=0,fe3=0)[[1]] })
#grafico
output$c_tif_ns <- renderPlot({
  ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=nelson_siegel(t=seq(0.1,20,0.1),pa=pa_ns)*100),aes(x=x,y=y))+
    geom_line(color="blue")+xlab("Maduración (años)")+
    ylab("Rendimiento (%)")+theme_gray()+
    ggtitle("Curva de rendimiento Nelson y Siegel Parámetros Iniciales TIF")+
    theme(plot.title = element_text(hjust = 0.5))
  
})


#seccion elegir parametros 
#parametros elegidos
output$new_ns_tif <- renderPrint({(data.frame('B0'=input$ns_b0_tif,'B1'=input$ns_b1_tif,'B2'=input$ns_b2_tif,'T'=input$ns_t_tif,row.names = " " ))})
#verificacion
output$ver_ns_tif <- renderPrint({data.frame('Condición_1'=input$ns_b0_tif>0,'Condición_2'=input$ns_b0_tif+input$ns_b1_tif>0,'Condición_3'=input$ns_t_tif>0,row.names = " " )})
#precios estimados
output$p_est_tif_ns_el <- renderDataTable({Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = c(input$ns_b0_tif,input$ns_b1_tif,input$ns_b2_tif,input$ns_t_tif),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]] })
#grafico
output$c_tif_ns1_new <- renderPlot({
  ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=nelson_siegel(t=seq(0.1,20,0.1),pa=c(input$ns_b0_tif,input$ns_b1_tif,input$ns_b2_tif,input$ns_t_tif))*100),aes(x=x,y=y))+
    geom_line(color="brown")+xlab("Maduración (años)")+
    ylab("Rendimiento (%)")+theme_gray()+
    ggtitle("Curva de rendimiento Nelson y Siegel Parámetros elegidos TIF")+
    theme(plot.title = element_text(hjust = 0.5))
})

#seccion optimizar parametros 
#precios optimizados
output$p_est_tif_opt_ns <- renderDataTable({
  if(input$opt_tif_ns==1){
    withProgress(message = 'Calculando precios teóricos...', value = 0, {
      incProgress(1/2, detail = "Realizando iteraciones")
      #Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = c(1,1,1,1),ind = 0,C = C,fe2=input$opt_tif_ns,fe3=0)[[1]] 
      Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = c(1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")) ,fe2=input$opt_tif_ns,fe3=0)[[1]] 
      
    })
  }else{
    Aviso <- "No se optimizará, revisar precios sección parámetros iniciales"
    return(as.data.frame(Aviso))
  }
})

#parametros optimizados
#funcion auxiliar
gra_tif_ns <- reactive({Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = c(1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_tif_ns,fe3=0)[[2]] })
#resultado
output$par_tif_ns_op<-renderPrint({if(input$opt_tif_ns==1){gra_tif_ns()
}else{}})
#grafico
output$c_tif_ns_op <- renderPlot({if(input$opt_tif_ns==1){
  #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
  ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=nelson_siegel(t=seq(0.1,20,0.1),pa=gra_tif_ns())*100),aes(x=x,y=y))+
    geom_line(color="green")+xlab("Maduración (años)")+
    ylab("Rendimiento (%)")+theme_gray()+
    ggtitle("Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")+
    theme(plot.title = element_text(hjust = 0.5))
}else{}})

###########.
###VEBONO##.
###########.



#####

#-##-#-#-#-#-#-#-#-#-#
#-#-#-#SVENSSON#-#-#-#
#-##-#-#-#-#-#-#-#-#-#

#####

########.
##TIF###.
########.


###########.
###VEBONO##.
###########.

#####

#-##-#-#-#-#-#-#-#-#-#-#
#-#-#-#DIEBOLD LI#-#-#-#
#-##-#-#-#-#-#-#-#-#-#-#

#####

########.
##TIF###.
########.


###########.
###VEBONO##.
###########.

#####

#-##-#-#-#-#-#-#-#-#-#-#
#-#-#-#-#SPLINES-#-#-#-#
#-##-#-#-#-#-#-#-#-#-#-#

#####

########.
##TIF###.
########.


###########.
###VEBONO##.
###########.

#####
