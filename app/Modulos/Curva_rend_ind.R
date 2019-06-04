#MODULO CURVA DE RENDIMIENTOS INDIVIDUAL (SERVER)

#//////////////////////#
#/# SUBSECCION DATOS #/#
#//////////////////////#

#++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# Selección de nombre de documento a descargar del BCV #
#++++++++++++++++++++++++++++++++++++++++++++++++++++++#

datasetInput <- reactive({
  switch(input$dataset,
         "0-22" = ruta_bcv("0-22"),
         "Caracteristicas" = ruta_bcv("caracteristicas"))
})

#++++++++++++++++++#
# Muestro elección #
#++++++++++++++++++#

output$desc <- renderPrint({ input$dataset })

#+++++++++++++++++++#
# Boton de descarga #
#+++++++++++++++++++#

output$downloadData <- downloadHandler(
  filename = function() {
    #paste(input$dataset, ".xls", sep = "")
    paste(input$dataset,paste0(".",extension(datasetInput())), sep = "")
  },
  content = function(file) {
    #file<-paste(getwd(),"data",paste(input$dataset, ".xls", sep = ""),sep="/")
    file<-paste(getwd(),"data",paste(input$dataset, paste0(".",extension(datasetInput())), sep = ""),sep="/")
    
    #antes en method estaba libcurl
    download.file(url=datasetInput(),destfile=file,method = "internal",mode="wb")
    #GET(datasetInput(), write_disk(file, overwrite=TRUE))
    #write.xlsx(datasetInput(), file, row.names = FALSE)
  }
)

#+++++++++++++++++++++++++++++++++++++#
# Muestro documento "Caracteristicas" #
#+++++++++++++++++++++++++++++++++++++#

output$Ca_leida <- renderDataTable({
  ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
  if(class(ca)=="try-error"){
    Aviso <- print("El archivo no se encuentra, descargar y recargar página!")
    #return(datatable(Aviso, options = list(paging = FALSE)))
    return(as.data.frame(Aviso))
  }else{
    #return(datatable(ca, options = list(paging = FALSE)))
    return(ca)
  }
})

#++++++++++++++++++++++++++#
# Muestro documento "0-22" #
#++++++++++++++++++++++++++#

output$docbcv <- renderDataTable({
  #ca <- try(Preciosbcv(paste(getwd(),"data","0-22.xls",sep = "/")))
  ca <- try(Preciosbcv(paste(getwd(),"data",paste0("0-22.",extension(ruta_bcv("0-22"))),sep = "/")))
  #ca1 <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
  ca1 <- try(Carac(paste(getwd(),"data",paste0("Caracteristicas.",extension(ruta_bcv("caracteristicas"))),sep = "/")))
  
  if(class(ca)=="try-error" | class(ca1)=="try-error" ){
    Aviso <- print("El archivo no se encuentra, descargar y recargar página!")
    return(as.data.frame(Aviso))
  }else{
    #condicional cuando no hay obs
    if(is.null(dim(ca))){
      Aviso <- "No existen operaciones para el mes actual"
      return(as.data.frame(Aviso))
    }else{
      
      ca2 <- formatop(ca1,ca)
      #convierto fecha de op y venc en fechas
      ca2$`Fecha op` <- as.Date(as.character(ca2$`Fecha op`),format="%d/%m/%Y")
      ca2$F.Vencimiento <- as.Date(as.character(ca2$F.Vencimiento),format="%d/%m/%Y")
      
      #este data frame es el que utiliza la metodologia Spline para los calculos
      ca3 <- dplyr::arrange(ca2,(`Fecha op`))
      
      #guardo historico_actualizado
      hist <- read.csv(paste(getwd(),"data","Historico.txt",sep = "/"),sep="")
      hist[,3] <- as.Date(as.character(hist[,3]))
      hist[,6] <- as.Date(as.character(hist[,6]))
      
      
      names(ca3)=names(hist)
      #print(str(ca3))
      #print(str(hist))
      
      hist_act <- rbind.data.frame(hist,ca3)
      
      
      write.table(hist_act,paste(getwd(),"data","Historico_act.txt",sep = "/"),row.names = FALSE)
      
      return(ca3)
    }#final condicional no hay operaciones
  }
})

#+++++++++++++++++++++++++++++#
# Calculo precio promedio TIF #
#+++++++++++++++++++++++++++++#

output$pre_prom_tif <- renderPrint({
  #leo el historico actualizado
  hist <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
  
  #como primer enfoque busco todos los tif y veb
  #luego se puede buscar solamente los tit seleccionados
  #no seria muy dificil este cambio
  hist_19 <- pre_prom(hist,"2019")
  hist_18 <- pre_prom(hist,"2018")
  hist_17 <- pre_prom(hist,"2017")
  hist_16 <- pre_prom(hist,"2016")
  
  #para buscar tif uso hist_18 u otro año y uso el segundo 
  #elemento de la lista
  #busco tif de mi cartera en historico 2018
  tif_19 <- comp(tit,hist_19[[2]])
  
  #los tif que no encuentro en 2018 los busco en 2017
  if(length(tif_19[[2]])!=0){
    tif_18 <- comp(tif_19[[2]],hist_18[[2]])
  }else{
    print("Todos los instrumentos estan")
  }
  
  ##tif_18 <- comp(tit,hist_18[[2]])
  
  #los tif que no encuentro en 2018 los busco en 2017
  if(length(tif_18[[2]])!=0){
    tif_17 <- comp(tif_18[[2]],hist_17[[2]])
  }else{
    print("Todos los instrumentos estan")
  }
  
  #los tif que no encuentro en 2017 los busco en 2016
  if(length(tif_17[[2]])!=0){
    tif_16 <- comp(tif_17[[2]],hist_16[[2]])
  }else{
    print("Todos los instrumentos estan")
  }
  
  #precios promedio que salen
  #TIF <- rbind.data.frame(tif_18[[1]],tif_17[[1]],tif_16[[1]])
  TIF <- rbind.data.frame(tif_19[[1]],tif_18[[1]],tif_17[[1]],tif_16[[1]])
  
  names(TIF) <- c("Títulos","Precio Promedio","Año")
  write.table(TIF,paste(getwd(),"data","Precio_prom_tif.txt",sep = "/"),row.names = FALSE)
  
  
  #titulos tif que no salen
  no_tif <- as.data.frame(tif_16[[2]])
  names(no_tif) <- "Títulos faltantes"
  write.table(no_tif,paste(getwd(),"data","Tif_faltantes.txt",sep = "/"),row.names = FALSE)
  
  
  #return(TIF)
  print("Titulos en historico")
  print(TIF)
  
  print("Titulos que no salen")
  print(no_tif)
  
  
  
})

#++++++++++++++++++++++++++++++++#
# Calculo precio promedio VEBONO #
#++++++++++++++++++++++++++++++++#

output$pre_prom_veb <- renderPrint({
  #leo el historico actualizado
  hist <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
  
  #como primer enfoque busco todos los tif y veb
  #luego se puede buscar solamente los tit seleccionados
  #no seria muy dificil este cambio
  hist_19 <- pre_prom(hist,"2019")
  hist_18 <- pre_prom(hist,"2018")
  hist_17 <- pre_prom(hist,"2017")
  hist_16 <- pre_prom(hist,"2016")
  
  #para buscar tif uso hist_18 u otro año y uso el tercer 
  #elemento de la lista
  #busco veb de mi cartera en historico 2018
  veb_19 <- comp(tit1,hist_19[[3]])
  #veb_18 <- comp(tit1,hist_18[[3]])
  
  #los tif que no encuentro en 2019 los busco en 2018
  if(length(veb_19[[2]])!=0){
    veb_18 <- comp(veb_19[[2]],hist_18[[3]])
  }else{
    print("Todos los instrumentos estan")
  }
  
  #los tif que no encuentro en 2018 los busco en 2017
  if(length(veb_18[[2]])!=0){
    veb_17 <- comp(veb_18[[2]],hist_17[[3]])
  }else{
    print("Todos los instrumentos estan")
  }
  
  #los tif que no encuentro en 2017 los busco en 2016
  if(length(veb_17[[2]])!=0){
    veb_16 <- comp(veb_17[[2]],hist_16[[3]])
  }else{
    print("Todos los instrumentos estan")
  }
  
  #precios promedio que salen
  #VEB <- rbind.data.frame(veb_18[[1]],veb_17[[1]],veb_16[[1]])
  VEB <- rbind.data.frame(veb_19[[1]],veb_18[[1]],veb_17[[1]],veb_16[[1]])
  
  names(VEB) <- c("Títulos","Precio Promedio","Año")
  write.table(VEB,paste(getwd(),"data","Precio_prom_veb.txt",sep = "/"),row.names = FALSE)
  
  
  #titulos tif que no salen
  no_veb <- as.data.frame(veb_16[[2]])
  names(no_veb) <- "Títulos faltantes"
  write.table(no_veb,paste(getwd(),"data","Veb_faltantes.txt",sep = "/"),row.names = FALSE)
  
  
  #return(TIF)
  print("Titulos en historico")
  print(VEB)
  
  print("Titulos que no salen")
  print(no_veb)
  
  
  
})

#////////////////////////////////#
#/# SUBSECCION NELSON Y SIEGEL #/#
#////////////////////////////////#

#//////////////#
#/# CASO TIF #/#
#//////////////#

#+++++++++++++++++++++#
# Fecha de valoración #
#+++++++++++++++++++++#

output$p2<-renderPrint({paste(substr(input$n2,9,10),substr(input$n2,6,7),substr(input$n2,1,4),sep = "/")})

#+++++++++++++++++++++++++++++++++++++++++++++#
# Selección de instrumentos por archivo plano #
#+++++++++++++++++++++++++++++++++++++++++++++#

output$datatable_tit_tif<-renderDataTable({
  if(is.null(data_tit_tif_ns())){return()}
  #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
  #datatable(data_pos())
  data_tit_tif_ns()
})

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar lectura instrumentos por archivo plano #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

data_tit_tif_ns <- reactive({
  # input$file1 will be NULL initially. After the user selects
  # and uploads a file, it will be a data frame with 'name',
  # 'size', 'type', and 'datapath' columns. The 'datapath'
  # column will contain the local filenames where the data can
  # be found.
  
  inFile <- input$data_tit_tif
  
  if (is.null(inFile))
    return(NULL)
  
  read.table(inFile$datapath, header = input$header_tit_tif,
             sep = input$sep_tit_tif, quote = input$quote_tit_tif)
  
})

#++++++++++++++++++++++++++++++++++#
# Muestro seleccion de los tituulos #
#++++++++++++++++++++++++++++++++++#

output$q1_ns1 <- renderPrint(
  ns1()
)

#+++++++++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar que muestra selección de títulos #
#+++++++++++++++++++++++++++++++++++++++++++++++++++#

ns1 <- reactive({
  if(is.null(data_tit_tif_ns())){
    #input$t1_ns1
    return(c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns))
  }else{
    a <- data_tit_tif_ns() 
    return(as.character(a[,1]))
  }
})

#++++++++++++++++++++++++++#
# Muestro precios promedio #
#++++++++++++++++++++++++++#

output$pre1_ns <-renderPrint({tf_ns()})

#+++++++++++++++++++++++++++++++++++#
# Funcion auxiliar precios promedio #
#+++++++++++++++++++++++++++++++++++#

tf_ns <- reactive({
  #pos1 esta en el global-pasar a funciones.R
  pos1(ns1(),0)
})

#+++++++++++++#
# Advertencia #
#+++++++++++++#

output$ad_pns_tif <- renderPrint({
  if(length(tf_ns())==1 & sum(tf_ns()==0)>=1){ return("No hay instrumentos seleccionados")}else{
    
    p <- tf_ns()
    
    if(length(which(p==0))!=0){
      return("Existen precios promedios nulos")
    }else{
      return("Precios promedio diferentes de cero")
    }
    
  }# final if inicial
  
})

#+++++++++++++++++++++++++++++++++++++++++++++++++#
# Muestro nombre titulos con precio promedio nulo #
#+++++++++++++++++++++++++++++++++++++++++++++++++#

output$np_ns1 <- renderPrint({
  if(is.null(ad_ns_t1())){ return("No hay precios promedios nulos")}
  #obtengo nombres de los instrumentos con precio 0
  a <- ad_ns_t1()
  
  b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  names(b) <- c("Títulos","Precio promedio")
  b[,1] <-  a
  
  
  c <- as.numeric(unlist(strsplit(input$vec1_ns,",")))
  if(length(c)>nrow(b)){
    return("Existen más precios de lo necesario, revisar precios ingresados")
  }else{

    b[,2] <- c
    return(b)
  }
  
})

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar nombre titulos con precio promedio nulo #
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

ad_ns_t1 <- reactive({
  p <- tf_ns()
  a <- which(p==0)
  
  if(length(a)!=0){
    return(names(p)[a])
  }else{
    return(NULL)
  }
  
})

#++++++++++++++++++++++++++++++++++++++++++#
# Muestro nuevos precios promedio no nulos #
#++++++++++++++++++++++++++++++++++++++++++#

output$sal1_ns <-renderPrint({
  a <- try(TF_NS())
  if(class(a)!="try-error"){return(a)}else{"Existen más precios de lo necesario, revisar precios ingresados"}
})

#+++++++++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar nuevos precios promedio no nulos #
#+++++++++++++++++++++++++++++++++++++++++++++++++++#

TF_NS <- reactive({
    a <- tf_ns()

    if(length(which(a==0))!=0){
      #return("Existen precios prom nulos")
      return(tf_ns1())
    }else{
      #return("precios bien")
      return(a)
    }


  })

#+++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar que busca precios promedio #
#+++++++++++++++++++++++++++++++++++++++++++++#

tf_ns1 <- reactive({
    a <- tf_ns()

    if(length(which(a==0))==0){
      return(a)
    }else{
      #a <- tf_ns()
      b <-dat()


      #return(b)
      #nombres de variables con precios nulos
      if(is.null(ad_ns_t1())){ return("Seleccionar instrumento")}

      n <- ad_ns_t1()

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
  
#+++++++++++++++++++#
# Variable auxiliar #
#+++++++++++++++++++#

dat <- reactive({
    if(is.null(ad_ns_t1())){ return("Seleccionar instrumento")}
    #obtengo nombres de los instrumentos con precio 0
    a <- ad_ns_t1()

    b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
    names(b) <- c("Títulos","Precio promedio")
    b[,1] <-  a


    c <- as.numeric(unlist(strsplit(input$vec1_ns,",")))
    if(length(c)>nrow(b)){
      return("Existen más precios de lo necesario, revisar precios ingresados")
    }else{

      b[,2] <- c

    }
      b
  })
  
#+++++++++++++++++++++++++++++++++++++#
# Muestro documento "Caracteristicas" #
#+++++++++++++++++++++++++++++++++++++#

output$Ca_ns <- renderDataTable({
  ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
  if(class(ca)=="try-error"){
    v <- print("El archivo no se encuentra, descargar y recargar página!")
    return(as.data.frame(v))
  }else{
    return(ca)
  }
})

#++++++++++++++++++++++++++++++#
# Muestro parametros iniciales #
#++++++++++++++++++++++++++++++#

#pa_ns esta en el global
output$pa_tif_ns <- renderPrint({(pa_ns)})

#+++++++++++++++++++++++++++++++++++++#
# Muestro precios estimados iniciales #
#+++++++++++++++++++++++++++++++++++++#

output$p_est_tif_ns <- renderDataTable({
  #if(length(c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns))!=0){
  if(length(ns1())!=0){
    a <- try(Tabla.ns(fv = input$n2 ,tit = ns1(),pr =TF_NS() ,pa = pa_ns,ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")) ,fe2=0,fe3=0)[[1]] )
    if(class(a)!="try-error"){datatable(a, options = list(paging = FALSE))}else{}
    
  }else{}
})

#++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# Muestro curva de rendimiento - parametros iniciales  #
#++++++++++++++++++++++++++++++++++++++++++++++++++++++#

output$c_tif_ns <- renderPlotly({
  a <- ggplot(cbind.data.frame(plazo=seq(0.9,20,0.1),rendimiento=nelson_siegel(t=seq(0.9,20,0.1),pa=pa_ns)*100),aes(x=plazo,y=rendimiento))+
    geom_line(color="blue")+xlab("Maduración (años)")+
    ylab("Rendimiento (%)")+theme_gray()+
    ggtitle("Curva de rendimiento Nelson y Siegel Parámetros Iniciales TIF")+
    theme(plot.title = element_text(hjust = 0.5))
  
  ggplotly(a)
})

#+++++++++++++++++++++++++++++#
# Muestro parametros elegidos #
#+++++++++++++++++++++++++++++#

output$new_ns_tif <- renderPrint({
  # Take a dependency on input$goButton
  input$boton1
  
  a <- isolate(data.frame('B0'=input$ns_b0_tif,'B1'=input$ns_b1_tif,'B2'=input$ns_b2_tif,'T'=input$ns_t_tif,row.names = " " ))
  a
  
  })

#++++++++++++++#
# Verificacion #
#++++++++++++++#

output$ver_ns_tif <- renderPrint({
  # Take a dependency on input$goButton
  input$boton1
  
  a <- isolate(data.frame('Condición_1'=input$ns_b0_tif>0,'Condición_2'=input$ns_b0_tif+input$ns_b1_tif>0,'Condición_3'=input$ns_t_tif>0,row.names = " " ))
  a
  
  })

#++++++++++++++++++++++++++++++++++++++++++#
# Muestro precios con parámetros escogidos #
#++++++++++++++++++++++++++++++++++++++++++#

output$p_est_tif_ns_el <- renderDataTable({
  #take dependency
  input$boton1
  
  #
  isolate(
  if(length(ns1())!=0){
    a <- try(Tabla.ns(fv = input$n2 ,tit = ns1(),pr =TF_NS() ,pa = c(input$ns_b0_tif,input$ns_b1_tif,input$ns_b2_tif,input$ns_t_tif),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]] )
    if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  }else{}
  )
})

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# Muestro curva de rendimientos con parámetros escogidos #
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

output$c_tif_ns1_new <- renderPlotly({
  #take dependency
  input$boton1
  
  #
  isolate({
  a <- ggplot(cbind.data.frame(plazo=seq(0.9,20,0.1),rendimiento=nelson_siegel(t=seq(0.9,20,0.1),pa=c(input$ns_b0_tif,input$ns_b1_tif,input$ns_b2_tif,input$ns_t_tif))*100),aes(x=plazo,y=rendimiento))+
    geom_line(color="blue")+xlab("Maduración (años)")+
    ylab("Rendimiento (%)")+theme_gray()+
    ggtitle("Curva de rendimiento Nelson y Siegel Parámetros elegidos TIF")+
    theme(plot.title = element_text(hjust = 0.5))
  ggplotly(a)
  })
})

#+++++++++++++++++++++++++++++#
# Muestro precios optimizados #
#+++++++++++++++++++++++++++++#

output$p_est_tif_opt_ns <- renderDataTable({
  #pongo dependencia
  input$boton_1
  
  #
  isolate({
  
  if(input$opt_tif_ns==1){
    withProgress(message = 'Calculando precios teóricos...', value = 0, {
      incProgress(1/2, detail = "Realizando iteraciones")
      #Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = c(1,1,1,1),ind = 0,C = C,fe2=input$opt_tif_ns,fe3=0)[[1]] 
      a <- try(Tabla.ns(fv = input$n2 ,tit = ns1(),pr =TF_NS() ,pa = c(1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")) ,fe2=input$opt_tif_ns,fe3=0)[[1]] )
      if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
      
    })
  }else{
    Aviso <- "No se optimizará, revisar precios sección parámetros iniciales"
    return(as.data.frame(Aviso))
  }
  }) #final isolate
    
})

#++++++++++++++++++++++++++++++++#
# Muestro parametros optimizados #
#++++++++++++++++++++++++++++++++#

output$par_tif_ns_op<-renderPrint({
  #pongo dependencia
  input$boton_1

  #
  isolate({
    
  if(input$opt_tif_ns==1){
    
  gra_tif_ns()
  #return(a)
  }else{
    Aviso <- "No se optimizará"
    return(Aviso)
  }
    
  }) #final isolate
    })

#+++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar parametros optimizados #
#+++++++++++++++++++++++++++++++++++++++++#

gra_tif_ns <- reactive({
  a <- try(Tabla.ns(fv = input$n2 ,tit = ns1(),pr =TF_NS() ,pa = c(1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_tif_ns,fe3=0)[[2]])
  if(class(a)!="try-error"){return(a)}else{}
})

#+++++++++++++++++++++++++++++++#
# Muestro curva de rendimientos #
#+++++++++++++++++++++++++++++++#

output$c_tif_ns_op <- renderPlotly({
  #pongo dependencia
  input$boton_1
  
  #
  isolate({
  
  if(input$opt_tif_ns==1){
  a <- try(cbind.data.frame(plazo=seq(0.9,20,0.1),rendimiento=nelson_siegel(t=seq(0.9,20,0.1),pa=gra_tif_ns())*100))
  if(class(a)!="try-error"){
    #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
    b <- ggplot(a,aes(x=plazo,y=rendimiento))+
      geom_line(color="blue")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")+
      theme(plot.title = element_text(hjust = 0.5))
    ggplotly(b)
    
  }else{}
  

}else{}

  }) #final isolate

})

#/////////////////#
#/# CASO VEBONO #/#
#/////////////////#

#+++++++++++++++++++++#
# Fecha de valoración #
#+++++++++++++++++++++#

# Misma variable p2 que en TIF

#+++++++++++++++++++++++++++++++++++++++++++++#
# Selección de instrumentos por archivo plano #
#+++++++++++++++++++++++++++++++++++++++++++++#

output$datatable_tit_veb<-renderDataTable({
  if(is.null(data_tit_veb_ns())){return()}
  #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
  #datatable(data_pos())
  data_tit_veb_ns()
})

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar lectura instrumentos por archivo plano #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

data_tit_veb_ns <- reactive({
  # input$file1 will be NULL initially. After the user selects
  # and uploads a file, it will be a data frame with 'name',
  # 'size', 'type', and 'datapath' columns. The 'datapath'
  # column will contain the local filenames where the data can
  # be found.
  
  inFile <- input$data_tit_veb
  
  if (is.null(inFile))
    return(NULL)
  
  read.table(inFile$datapath, header = input$header_tit_veb,
             sep = input$sep_tit_veb, quote = input$quote_tit_veb)
  
})

#+++++++++++++++++++++++++++++++++++#
# Muestro selección de los tituulos #
#+++++++++++++++++++++++++++++++++++#

output$q1_ns2 <- renderPrint(
  ns2()
)

#+++++++++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar que muestra selección de títulos #
#+++++++++++++++++++++++++++++++++++++++++++++++++++#

ns2 <- reactive({
  if(is.null(data_tit_veb_ns())){
    #input$t1_ns2
    c(input$v1_ns,input$v2_ns,input$v3_ns,input$v4_ns)
    
  }else{
    a <- data_tit_veb_ns() 
    as.character(a[,1])
  }
})

#++++++++++++++++++++++++++#
# Muestro precios promedio #
#++++++++++++++++++++++++++#

output$pre2_ns <-renderPrint({tv_ns()})

#+++++++++++++++++++++++++++++++++++#
# Funcion auxiliar precios promedio #
#+++++++++++++++++++++++++++++++++++#

tv_ns <- reactive({pos1(ns2(),1)})

#+++++++++++++#
# Advertencia #
#+++++++++++++#

output$ad_pns_veb <- renderPrint({
  if(length(tv_ns())==1 & sum(tv_ns()==0)>=1){ return("No hay instrumentos seleccionados")}else{
    
    p <- tv_ns()
    
    if(length(which(p==0))!=0){
      return("Existen precios promedios nulos")
    }else{
      return("Precios promedio diferentes de cero")
    }
    
  }# final if inicial
  
})

#+++++++++++++++++++++++++++++++++++++++++++++++++#
# Muestro nombre titulos con precio promedio nulo #
#+++++++++++++++++++++++++++++++++++++++++++++++++#

output$np_ns2 <- renderPrint({
  if(is.null(ad_ns_t2())){ return("No hay precios promedios nulos")}
  #obtengo nombres de los instrumentos con precio 0
  a <- ad_ns_t2()
  
  b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  names(b) <- c("Títulos","Precio promedio")
  b[,1] <-  a
  
  
  c <- as.numeric(unlist(strsplit(input$vec2_ns,",")))
  if(length(c)>nrow(b)){
    return("Existen más precios de lo necesario, revisar precios ingresados")
  }else{
    
    b[,2] <- c
    
    #write.table(b,paste(getwd(),"data","pp_ns1.txt",sep = "/"),row.names = FALSE)
    
    b
  }
  
})

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar nombre titulos con precio promedio nulo #
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

ad_ns_t2 <- reactive({
  p <- tv_ns()
  a <- which(p==0)
  
  if(length(a)!=0){
    return(names(p)[a])
  }else{
    return(NULL)
  }
  
})

#++++++++++++++++++++++++++++++++++++++++++#
# Muestro nuevos precios promedio no nulos #
#++++++++++++++++++++++++++++++++++++++++++#

output$sal2_ns <-renderPrint({
  a <- try(TV_NS())
  if(class(a)!="try-error"){return(a)}else{"Existen más precios de lo necesario, revisar precios ingresados"}
})

#+++++++++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar nuevos precios promedio no nulos #
#+++++++++++++++++++++++++++++++++++++++++++++++++++#

TV_NS <- reactive({
  a <- tv_ns()
  
  if(length(which(a==0))!=0){
    #return("Existen precios prom nulos")
    return(tv_ns1())
  }else{
    #return("precios bien")
    return(a)
  }
  
  
})

#+++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar que busca precios promedio #
#+++++++++++++++++++++++++++++++++++++++++++++#

tv_ns1 <- reactive({
  a <- tv_ns()
  
  if(length(which(a==0))==0){
    return(a)
  }else{
    #a <- tf_ns()
    b <-dat1()
    #return(b)
    #nombres de variables con precios nulos
    if(is.null(ad_ns_t2())){ return("Seleccionar instrumento")}
    
    n <- ad_ns_t2()
    
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

#++++++++++++++++++++++++++++#
# Variable auxiliar de datos #
#++++++++++++++++++++++++++++#

dat1 <- reactive({
  if(is.null(ad_ns_t2())){ return("Seleccionar instrumento")}
  #obtengo nombres de los instrumentos con precio 0
  a <- ad_ns_t2()
  
  b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  names(b) <- c("Títulos","Precio promedio")
  b[,1] <-  a
  
  
  c <- as.numeric(unlist(strsplit(input$vec2_ns,",")))
  if(length(c)>nrow(b)){
    return("Existen más precios de lo necesario, revisar precios ingresados")
  }else{
    
    b[,2] <- c
  }
  b
})

#+++++++++++++++++++++++++++++++++++++#
# Muestro documento "Caracteristicas" #
#+++++++++++++++++++++++++++++++++++++#

output$Ca1_ns <- renderDataTable({
  ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
  if(class(ca)=="try-error"){
    v <- print("El archivo no se encuentra, descargar y recargar página!")
    return(as.data.frame(v))
  }else{
    return(ca)
  }
})

#++++++++++++++++++++++++++++++#
# Muestro parametros iniciales #
#++++++++++++++++++++++++++++++#

#pa1_ns esta en el global
output$pa_veb_ns <- renderPrint({pa1_ns})

#+++++++++++++++++++++++++++++++++++++#
# Muestro precios estimados iniciales #
#+++++++++++++++++++++++++++++++++++++#

output$p_est_veb_ns <- renderDataTable({
  if(length(ns2())!=0){
    a <- try(Tabla.ns(fv = input$n2 ,tit = ns2(),pr =TV_NS() ,pa = pa1_ns,ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]])
    if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  }else{}
})

#++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# Muestro curva de rendimiento - parametros iniciales  #
#++++++++++++++++++++++++++++++++++++++++++++++++++++++#

output$c_veb_ns <- renderPlotly({
  a <- ggplot(cbind.data.frame(plazo=seq(0.9,20,0.1),rendimiento=nelson_siegel(t=seq(0.9,20,0.1),pa=pa1_ns)*100),aes(x=plazo,y=rendimiento))+
    geom_line(color="blue")+xlab("Maduración (años)")+
    ylab("Rendimiento (%)")+theme_gray()+
    ggtitle("Curva de rendimiento Nelson y Siegel Parámetros Iniciales VEBONOS")+
    theme(plot.title = element_text(hjust = 0.5))
  ggplotly(a)
  
})

#+++++++++++++++++++++++++++++#
# Muestro parametros elegidos #
#+++++++++++++++++++++++++++++#

output$new_ns_veb <- renderPrint({
  # Take a dependency on input$goButton
  input$boton2
  #
  isolate(data.frame('B0'=input$ns_b0_veb,'B1'=input$ns_b1_veb,'B2'=input$ns_b2_veb,'T'=input$ns_t_veb,row.names = " " ))
  
  })

#++++++++++++++#
# Verificacion #
#++++++++++++++#

output$ver_ns_veb <- renderPrint({
  #take dependency
  input$boton2
  
  isolate(
  data.frame('Condición_1'=input$ns_b0_veb>0,'Condición_2'=input$ns_b0_veb+input$ns_b1_veb>0,'Condición_3'=input$ns_t_veb>0,row.names = " " )
  )
  })

#++++++++++++++++++++++++++++++++++++++++++#
# Muestro precios con parámetros escogidos #
#++++++++++++++++++++++++++++++++++++++++++#

output$p_est_veb_ns_el <- renderDataTable({
  #take dependency
  input$boton2
  
  #
  isolate(
  if(length(ns2())!=0){
    a <- try(Tabla.ns(fv = input$n2 ,tit = ns2(),pr =TV_NS() ,pa =c(input$ns_b0_veb,input$ns_b1_veb,input$ns_b2_veb,input$ns_t_veb) ,ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]])
    if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  }else{}
  )
})

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# Muestro curva de rendimientos con parámetros escogidos #
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

output$c_veb_ns1_new <- renderPlotly({
  #take dependency
  input$boton2
  
  #
  isolate({
  a <- ggplot(cbind.data.frame(plazo=seq(0.9,20,0.1),rendimiento=nelson_siegel(t=seq(0.9,20,0.1),pa=c(input$ns_b0_veb,input$ns_b1_veb,input$ns_b2_veb,input$ns_t_veb))*100),aes(x=plazo,y=rendimiento))+
    geom_line(color="blue")+xlab("Maduración (años)")+
    ylab("Rendimiento (%)")+theme_gray()+
    ggtitle("Curva de rendimiento Nelson y Siegel Parámetros elegidos VEBONO")+
    theme(plot.title = element_text(hjust = 0.5))
  ggplotly(a)
  })
})

#+++++++++++++++++++++++++++++#
# Muestro precios optimizados #
#+++++++++++++++++++++++++++++#

output$p_est_veb_opt_ns <- renderDataTable({
  #pongo dependencia
  input$boton_2
  
  #
  isolate({
  
  if(input$opt_veb_ns==1){
    withProgress(message = 'Calculando parámetros optimizados', value = 0, {
      incProgress(1/2, detail = "Realizando iteraciones")
      a <- try(Tabla.ns(fv = input$n2 ,tit = ns2(),pr =TV_NS() ,pa = c(1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_veb_ns,fe3=0)[[1]] )
      if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
    })
  }else{
    Aviso <- "No se optimizará, revisar los precios de la sección parámetros iniciales"
    return(as.data.frame(Aviso))
  }
    
  }) #final isolate
})

#++++++++++++++++++++++++++++++++#
# Muestro parametros optimizados #
#++++++++++++++++++++++++++++++++#

output$par_veb_ns_op<-renderPrint({
  #pongo dependencia
  input$boton_2
  
  #
  isolate({
  if(input$opt_veb_ns==1){
    gra_veb_ns()
}else{return("No se optimizará")}
  
  }) #final isolate
  })

#+++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar parametros optimizados #
#+++++++++++++++++++++++++++++++++++++++++#

gra_veb_ns <- reactive({
  a <- try(Tabla.ns(fv = input$n2 ,tit = ns2(),pr =TV_NS() ,pa = c(1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_veb_ns,fe3=0)[[2]])
  if(class(a)!="try-error"){return(a)}else{}
})

#+++++++++++++++++++++++++++++++#
# Muestro curva de rendimientos #
#+++++++++++++++++++++++++++++++#

output$c_veb_ns_op <- renderPlotly({
  #pongo dependencia
  input$boton_2
  
  #
  isolate({
  
  if(input$opt_veb_ns==1){
  #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
  a <- try(cbind.data.frame(plazo=seq(0.9,20,0.1),rendimiento=nelson_siegel(t=seq(0.9,20,0.1),pa=gra_veb_ns())*100))
  if(class(a)!="try-error"){
  b <- ggplot(a,aes(x=plazo,y=rendimiento))+
    geom_line(color="blue")+xlab("Maduración (años)")+
    ylab("Rendimiento (%)")+theme_gray()+
    ggtitle("Curva de redimientos Nelson y Siegel Parametros Optimizados VEBONOS")+
    theme(plot.title = element_text(hjust = 0.5))
    
  ggplotly(b)
  }else{}
  
}else{}
    
  }) #final isolate
    })

#/////////////////////////#
#/# SUBSECCION SVENSSON #/#
#/////////////////////////#

#//////////////#
#/# CASO TIF #/#
#//////////////#

#+++++++++++++++++++++#
# Fecha de valoración #
#+++++++++++++++++++++#

output$p1<-renderPrint({paste(substr(input$n1,9,10),substr(input$n1,6,7),substr(input$n1,1,4),sep = "/")})

#+++++++++++++++++++++++++++++++++++++++++++++#
# Selección de instrumentos por archivo plano #
#+++++++++++++++++++++++++++++++++++++++++++++#

output$datatable_tit_tif_sv<-renderDataTable({
  if(is.null(data_tif_sv())){return()}
  #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
  #datatable(data_pos())
  data_tif_sv()
})

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar lectura instrumentos por archivo plano #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

data_tif_sv <- reactive({
  
  inFile <- input$data_tit_tif_sv
  
  if (is.null(inFile))
    return(NULL)
  
  read.table(inFile$datapath, header = input$header_tit_tif_sv,
             sep = input$sep_tit_tif_sv, quote = input$quote_tit_tif_sv)
  
})

#+++++++++++++++++++++++++++++++++++#
# Muestro selección de los tituulos #
#+++++++++++++++++++++++++++++++++++#

output$q_sv1 <- renderPrint(
  sv1()
)

#+++++++++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar que muestra selección de títulos #
#+++++++++++++++++++++++++++++++++++++++++++++++++++#

sv1 <- reactive({
  if(is.null(data_tif_sv())){
    #input$t_sv1
    c(input$t1,input$t2,input$t3,input$t4)
  }else{
    a <- data_tif_sv() 
    as.character(a[,1])
  }
})


#++++++++++++++++++++++++++#
# Muestro precios promedio #
#++++++++++++++++++++++++++#

output$pre1 <-renderPrint({tf()})

#+++++++++++++++++++++++++++++++++++#
# Funcion auxiliar precios promedio #
#+++++++++++++++++++++++++++++++++++#

tf <- reactive({pos1(sv1(),0)})

#+++++++++++++#
# Advertencia #
#+++++++++++++#

output$ad_psv_tif <- renderPrint({
  if(length(tf())==1 & sum(tf()==0)>=1){ return("No hay instrumentos seleccionados")}else{
    
    p <- tf()
    
    if(length(which(p==0))!=0){
      return("Existen precios promedios nulos")
    }else{
      return("Precios promedio diferentes de cero")
    }
    
  }# final if inicial
  
})

#+++++++++++++++++++++++++++++++++++++++++++++++++#
# Muestro nombre titulos con precio promedio nulo #
#+++++++++++++++++++++++++++++++++++++++++++++++++#

output$np_sv1 <- renderPrint({
  if(is.null(ad_sv_t1())){ return("No hay precios promedios nulos")}
  #obtengo nombres de los instrumentos con precio 0
  a <- ad_sv_t1()
  
  b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  names(b) <- c("Títulos","Precio promedio")
  b[,1] <-  a
  
  
  c <- as.numeric(unlist(strsplit(input$vec1_sv,",")))
  if(length(c)>nrow(b)){
    return("Existen más precios de lo necesario, revisar precios ingresados")
  }else{
    
    b[,2] <- c
    
    b
  }
  
})

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar nombre titulos con precio promedio nulo #
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

ad_sv_t1 <- reactive({
  p <- tf()
  a <- which(p==0)
  
  if(length(a)!=0){
    return(names(p)[a])
  }else{
    return(NULL)
  }
  
})

#++++++++++++++++++++++++++++++++++++++++++#
# Muestro nuevos precios promedio no nulos #
#++++++++++++++++++++++++++++++++++++++++++#

output$sal1_sv <-renderPrint({
  a <- try(TF())
  if(class(a)!="try-error"){return(a)}else{"Existen más precios de lo necesario, revisar precios ingresados"}
  
})

#+++++++++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar nuevos precios promedio no nulos #
#+++++++++++++++++++++++++++++++++++++++++++++++++++#

TF <- reactive({
  a <- tf()
  
  if(length(which(a==0))!=0){
    #return("Existen precios prom nulos")
    return(tf_1())
  }else{
    #return("precios bien")
    return(a)
  }
  
})

#+++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar que busca precios promedio #
#+++++++++++++++++++++++++++++++++++++++++++++#

tf_1 <- reactive({
  a <- tf()
  
  if(length(which(a==0))==0){
    return(a)
  }else{
    b <-dat1_sv()
    #nombres de variables con precios nulos
    if(is.null(ad_sv_t1())){ return("Seleccionar instrumento")}
    
    n <- ad_sv_t1()
    
    ind <- c()
    for(i in 1:length(n)){
      ind[i] <- which(n[i]==names(a))
    }
    
    a[ind] <- b[,2]
    return(a)
  }
  
  
})

#++++++++++++++++++++++++++++#
# Variable auxiliar de datos #
#++++++++++++++++++++++++++++#

dat1_sv <- reactive({
  if(is.null(ad_sv_t1())){ return("Seleccionar instrumento")}
  #obtengo nombres de los instrumentos con precio 0
  a <- ad_sv_t1()
  
  b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  names(b) <- c("Títulos","Precio promedio")
  b[,1] <-  a
  
  
  c <- as.numeric(unlist(strsplit(input$vec1_sv,",")))
  if(length(c)>nrow(b)){
    return("Existen más precios de lo necesario, revisar precios ingresados")
  }else{
    
    b[,2] <- c
  }
  b
})

#+++++++++++++++++++++++++++++++++++++#
# Muestro documento "Caracteristicas" #
#+++++++++++++++++++++++++++++++++++++#

output$Ca <- renderDataTable({
  ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
  if(class(ca)=="try-error"){
    v <- print("El archivo no se encuentra, descargar y recargar página!")
    return(as.data.frame(v))
  }else{
    return(ca)
  }
})

#++++++++++++++++++++++++++++++#
# Muestro parametros iniciales #
#++++++++++++++++++++++++++++++#

#pa_sven esta en el global
output$pa_tif <- renderPrint({pa_sven})

#+++++++++++++++++++++++++++++++++++++#
# Muestro precios estimados iniciales #
#+++++++++++++++++++++++++++++++++++++#

output$p_est_tif <- renderDataTable({
  if(length(sv1())!=0){
    a <- try(Tabla.sven(fv = input$n1 ,tit = sv1(),pr =TF() ,pa = pa_sven,ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]] )
    if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
    
  }else{}
})

#++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# Muestro curva de rendimiento - parametros iniciales  #
#++++++++++++++++++++++++++++++++++++++++++++++++++++++#

output$c_tif_sven <- renderPlotly({
  a <- ggplot(cbind.data.frame(plazo=seq(0.9,20,0.1),rendimiento=sven(t=seq(0.9,20,0.1),pa=pa_sven)*100),aes(x=plazo,y=rendimiento))+
    geom_line(color="blue")+xlab("Maduración (años)")+
    ylab("Rendimiento (%)")+theme_gray()+
    ggtitle("Curva de rendimiento Svensson Parámetros Iniciales TIF")+
    theme(plot.title = element_text(hjust = 0.5))
 ggplotly(a) 
})

#+++++++++++++++++++++++++++++#
# Muestro parametros elegidos #
#+++++++++++++++++++++++++++++#

output$new_sven_tif <- renderPrint({
  #take dependency
  input$boton3
  
  #
  
  isolate(data.frame('B0'=input$sven_b0_tif,'B1'=input$sven_b1_tif,'B2'=input$sven_b2_tif,'B3'=input$sven_b3_tif,'T1'=input$sven_t1_tif,'T2'=input$sven_t2_tif,row.names = " " ))
  
  
  })

#++++++++++++++#
# Verificacion #
#++++++++++++++#

output$ver_sven_tif <- renderPrint({
  #take dependency
  input$boton3
  
  #
  isolate(
  data.frame('Condición_1'=input$sven_b0_tif>0,'Condición_2'=input$sven_b0_tif+input$sven_b1_tif>0,'Condición_3'=input$sven_t1_tif>0,'Condición_4'=input$sven_t2_tif>0,row.names = " " )
  )
  })

#++++++++++++++++++++++++++++++++++++++++++#
# Muestro precios con parámetros escogidos #
#++++++++++++++++++++++++++++++++++++++++++#

output$p_est_tif_opt_sven_el <- renderDataTable({
  #take dependency
  input$boton3
  
  #
  isolate(
  if(length(sv1())!=0){
    a <- try(Tabla.sven(fv = input$n1 ,tit = sv1(),pr =TF() ,pa = c(input$sven_b0_tif,input$sven_b1_tif,input$sven_b2_tif,input$sven_b3_tif,input$sven_t1_tif,input$sven_t2_tif),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]])
    if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
    
  }else{}
  )
})

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# Muestro curva de rendimientos con parámetros escogidos #
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

output$c_tif_sven_new <- renderPlotly({
  #take dependency
  input$boton3
  
  #
  isolate({
  a <- ggplot(cbind.data.frame(plazo=seq(0.9,20,0.1),rendimiento=sven(t=seq(0.9,20,0.1),pa=c(input$sven_b0_tif,input$sven_b1_tif,input$sven_b2_tif,input$sven_b3_tif,input$sven_t1_tif,input$sven_t2_tif))*100),aes(x=plazo,y=rendimiento))+
    geom_line(color="blue")+xlab("Maduración (años)")+
    ylab("Rendimiento (%)")+theme_gray()+
    ggtitle("Curva de rendimiento Svensson Parámetros elegidos TIF")+
    theme(plot.title = element_text(hjust = 0.5))
  
  ggplotly(a)
  })
})

#+++++++++++++++++++++++++++++#
# Muestro precios optimizados #
#+++++++++++++++++++++++++++++#

output$p_est_tif_opt <- renderDataTable({
  #pongo dependencia
  input$boton_3
  
  #
  isolate({
  
  if(input$opt_tif_sven==1){
    withProgress(message = 'Calculando parámetros optimizados', value = 0, {
      incProgress(1/2, detail = "Realizando iteraciones")
      a <- try(Tabla.sven(fv = input$n1 ,tit = sv1(),pr =TF() ,pa = c(1,1,1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_tif_sven,fe3=0)[[1]] )
      if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
      
    })
  }else{
    Aviso <- "No se optimizará, revisar los precios de la sección parámetros iniciales"
    return(as.data.frame(Aviso))
  }
    
  }) #final isolate
})

#++++++++++++++++++++++++++++++++#
# Muestro parametros optimizados #
#++++++++++++++++++++++++++++++++#

output$par_tif_sven_op<-renderPrint({
  #pongo dependencia
  input$boton_3
  
  #
  isolate({
  if(input$opt_tif_sven==1){gra_tif_sven()
}else{return("No se optimizará")}
    
  }) #final isolate
    })

#+++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar parametros optimizados #
#+++++++++++++++++++++++++++++++++++++++++#

gra_tif_sven <- reactive({
  a <- try(Tabla.sven(fv = input$n1 ,tit = sv1(),pr =TF() ,pa = c(1,1,1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_tif_sven,fe3=0)[[2]])
  if(class(a)!="try-error"){return(a)}else{}
  
})

#+++++++++++++++++++++++++++++++#
# Muestro curva de rendimientos #
#+++++++++++++++++++++++++++++++#

output$c_tif_sven_op <- renderPlotly({
  #pongo dependencia
  input$boton_3
  
  #
  isolate({
  
  if(input$opt_tif_sven==1){
  #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
  a <- try(cbind.data.frame(plazo=seq(0.9,20,0.1),rendimiento=sven(t=seq(0.9,20,0.1),pa=gra_tif_sven())*100))
  
  if(class(a)!="try-error"){
    b <- ggplot(a,aes(x=plazo,y=rendimiento))+
      geom_line(color="blue")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de redimientos Svensson Parametros Optimizados TIF")+
      theme(plot.title = element_text(hjust = 0.5))
    
    ggplotly(b)
  }else{}
}else{}
    
  }) #final isolate
    })

#/////////////////#
#/# CASO VEBONO #/#
#/////////////////#

#+++++++++++++++++++++#
# Fecha de valoración #
#+++++++++++++++++++++#

#misma variable p1 que TIF

#+++++++++++++++++++++++++++++++++++++++++++++#
# Selección de instrumentos por archivo plano #
#+++++++++++++++++++++++++++++++++++++++++++++#

output$datatable_tit_veb_sv<-renderDataTable({
  if(is.null(data_veb_sv())){return()}
  #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
  #datatable(data_pos())
  data_veb_sv()
})

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar lectura instrumentos por archivo plano #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

data_veb_sv <- reactive({
  
  inFile <- input$data_tit_veb_sv
  
  if (is.null(inFile))
    return(NULL)
  
  read.table(inFile$datapath, header = input$header_tit_veb_sv,
             sep = input$sep_tit_veb_sv, quote = input$quote_tit_veb_sv)
  
})

#++++++++++++++++++++++++++++++++++#
# Muestro selección de los titulos #
#++++++++++++++++++++++++++++++++++#

output$q2<-renderPrint({  
  sv2()
})

#+++++++++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar que muestra selección de títulos #
#+++++++++++++++++++++++++++++++++++++++++++++++++++#

sv2 <- reactive({
  if(is.null(data_veb_sv())){
    #input$t_sv1
    c(input$v1,input$v2,input$v3,input$v4)
  }else{
    a <- data_veb_sv() 
    as.character(a[,1])
  }
})

#++++++++++++++++++++++++++#
# Muestro precios promedio #
#++++++++++++++++++++++++++#

output$pre2 <-renderPrint({tv()})

#+++++++++++++++++++++++++++++++++++#
# Funcion auxiliar precios promedio #
#+++++++++++++++++++++++++++++++++++#

tv <- reactive({pos1(sv2(),1)})

#+++++++++++++#
# Advertencia #
#+++++++++++++#

output$ad_psv_veb <- renderPrint({
  if(length(tv())==1 & sum(tv()==0)>=1){ return("No hay instrumentos seleccionados")}else{
    
    p <- tv()
    
    if(length(which(p==0))!=0){
      return("Existen precios promedios nulos")
    }else{
      return("Precios promedio diferentes de cero")
    }
    
  }# final if inicial
  
})

#+++++++++++++++++++++++++++++++++++++++++++++++++#
# Muestro nombre titulos con precio promedio nulo #
#+++++++++++++++++++++++++++++++++++++++++++++++++#

output$np_sv2 <- renderPrint({
  if(is.null(ad_sv_t2())){ return("No hay precios promedios nulos")}
  #obtengo nombres de los instrumentos con precio 0
  a <- ad_sv_t2()
  
  b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  names(b) <- c("Títulos","Precio promedio")
  b[,1] <-  a
  
  
  c <- as.numeric(unlist(strsplit(input$vec2_sv,",")))
  if(length(c)>nrow(b)){
    return("Existen más precios de lo necesario, revisar precios ingresados")
  }else{
    
    b[,2] <- c
    b
  }
  
})

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar nombre titulos con precio promedio nulo #
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

ad_sv_t2 <- reactive({
  p <- tv()
  a <- which(p==0)
  
  if(length(a)!=0){
    return(names(p)[a])
  }else{
    return(NULL)
  }
  
})

#++++++++++++++++++++++++++++++++++++++++++#
# Muestro nuevos precios promedio no nulos #
#++++++++++++++++++++++++++++++++++++++++++#

output$sal2_sv <-renderPrint({
  a <- try(TV())
  if(class(a)!="try-error"){return(a)}else{"Existen más precios de lo necesario, revisar precios ingresados"}
  
})

#+++++++++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar nuevos precios promedio no nulos #
#+++++++++++++++++++++++++++++++++++++++++++++++++++#

TV <- reactive({
  a <- tv()
  
  if(length(which(a==0))!=0){
    #return("Existen precios prom nulos")
    return(tv_1())
  }else{
    #return("precios bien")
    return(a)
  }
  
  
})

#+++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar que busca precios promedio #
#+++++++++++++++++++++++++++++++++++++++++++++#

tv_1 <- reactive({
  a <- tv()
  
  if(length(which(a==0))==0){
    return(a)
  }else{
    #a <- tf_ns()
    b <-dat2_sv()
    #return(b)
    #nombres de variables con precios nulos
    if(is.null(ad_sv_t2())){ return("Seleccionar instrumento")}
    
    n <- ad_sv_t2()
    
    ind <- c()
    for(i in 1:length(n)){
      ind[i] <- which(n[i]==names(a))
    }
    
    a[ind] <- b[,2]
    return(a)
  }
  
  
})

#++++++++++++++++++++++++++++#
# Variable auxiliar de datos #
#++++++++++++++++++++++++++++#

dat2_sv <- reactive({
  if(is.null(ad_sv_t2())){ return("Seleccionar instrumento")}
  #obtengo nombres de los instrumentos con precio 0
  a <- ad_sv_t2()
  
  b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  names(b) <- c("Títulos","Precio promedio")
  b[,1] <-  a
  
  
  c <- as.numeric(unlist(strsplit(input$vec2_sv,",")))
  if(length(c)>nrow(b)){
    return("Existen más precios de lo necesario, revisar precios ingresados")
  }else{
    
    b[,2] <- c
  }
  b
})

#+++++++++++++++++++++++++++++++++++++#
# Muestro documento "Caracteristicas" #
#+++++++++++++++++++++++++++++++++++++#

output$Ca1 <- renderDataTable({
  ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
  if(class(ca)=="try-error"){
    v <- print("El archivo no se encuentra, descargar y recargar página!")
    return(as.data.frame(v))
  }else{
    return(ca)
  }
})

#++++++++++++++++++++++++++++++#
# Muestro parametros iniciales #
#++++++++++++++++++++++++++++++#

#pa1_sven esta en el global
output$pa_veb <- renderPrint({pa1_sven})

#+++++++++++++++++++++++++++++++++++++#
# Muestro precios estimados iniciales #
#+++++++++++++++++++++++++++++++++++++#

output$p_est_veb <- renderDataTable({
  if((length(sv2()))!=0){
    a <- try(Tabla.sven(fv = input$n1 ,tit = sv2(),pr =TV() ,pa = pa1_sven,ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]] )
    if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
    
  }else{}
})

#++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# Muestro curva de rendimiento - parametros iniciales  #
#++++++++++++++++++++++++++++++++++++++++++++++++++++++#

output$c_veb_sven <- renderPlotly({
  a <- ggplot(cbind.data.frame(plazo=seq(0.9,20,0.1),rendimiento=sven(t=seq(0.9,20,0.1),pa=pa1_sven)*100),aes(x=plazo,y=rendimiento))+
    geom_line(color="blue")+xlab("Maduración (años)")+
    ylab("Rendimiento (%)")+theme_gray()+
    ggtitle("Curva de rendimiento Svensson Parámetros Iniciales VEBONOS")+
    theme(plot.title = element_text(hjust = 0.5))
  
  ggplotly(a)
})

#+++++++++++++++++++++++++++++#
# Muestro parametros elegidos #
#+++++++++++++++++++++++++++++#

output$new_sven_veb <- renderPrint({
  #take dependency
  input$boton4
  
  #
  isolate(data.frame('B0'=input$sven_b0_veb,'B1'=input$sven_b1_veb,'B2'=input$sven_b2_veb,'B3'=input$sven_b3_veb,'T1'=input$sven_t1_veb,'T2'=input$sven_t2_veb,row.names = " " ))
  
  })

#++++++++++++++#
# Verificacion #
#++++++++++++++#

output$ver_sven_veb <- renderPrint({
  #take dependency
  input$boton4
  
  #
  isolate(
  data.frame('Condición_1'=input$sven_b0_veb>0,'Condición_2'=input$sven_b0_veb+input$sven_b1_veb>0,'Condición_3'=input$sven_t1_veb>0,'Condición_4'=input$sven_t2_veb>0,row.names = " " )
  )
  
  })

#++++++++++++++++++++++++++++++++++++++++++#
# Muestro precios con parámetros escogidos #
#++++++++++++++++++++++++++++++++++++++++++#

output$p_est_veb_opt_sven_el <- renderDataTable({
  #take dependency
  input$boton4
  
  #
  isolate(
  if(length(sv2())!=0){
    a <- try(Tabla.sven(fv = input$n1 ,tit = sv2(),pr =TV() ,pa = c(input$sven_b0_veb,input$sven_b1_veb,input$sven_b2_veb,input$sven_b3_veb,input$sven_t1_veb,input$sven_t2_veb),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]])
    if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
    
  }else{}
  )
  
})

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# Muestro curva de rendimientos con parámetros escogidos #
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

output$c_veb_sven_new <- renderPlotly({
  #take dependency
  input$boton4
  
  #
  isolate({
  a <- ggplot(cbind.data.frame(plazo=seq(0.9,20,0.1),rendimiento=sven(t=seq(0.9,20,0.1),pa=c(input$sven_b0_veb,input$sven_b1_veb,input$sven_b2_veb,input$sven_b3_veb,input$sven_t1_veb,input$sven_t2_veb))*100),aes(x=plazo,y=rendimiento))+
    geom_line(color="blue")+xlab("Maduración (años)")+
    ylab("Rendimiento (%)")+theme_gray()+
    ggtitle("Curva de rendimiento Svensson Parámetros elegidos VEBONOS")+
    theme(plot.title = element_text(hjust = 0.5))
  
  ggplotly(a)
  })
})

#+++++++++++++++++++++++++++++#
# Muestro precios optimizados #
#+++++++++++++++++++++++++++++#

output$p_est_veb_opt <- renderDataTable({
  
  #pongo dependencia
  input$boton_4
  
  #
  isolate({
  if(input$opt_veb_sven==1){
    withProgress(message = 'Calculando parámetros optimizados', value = 0, {
      incProgress(1/2, detail = "Realizando iteraciones")
      a <- try(Tabla.sven(fv = input$n1 ,tit = sv2(),pr =TV() ,pa = c(1,1,1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_veb_sven,fe3=0)[[1]])
      if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
      
    })
  }else{
    Aviso <- "No se optimizará, revisar los precios de la sección parámetros iniciales"
    return(as.data.frame(Aviso))
  }
    
  }) #final isolate
})

#++++++++++++++++++++++++++++++++#
# Muestro parametros optimizados #
#++++++++++++++++++++++++++++++++#

output$par_veb_sven_op<-renderPrint({
  #pongo dependencia
  input$boton_4
  
  #
  isolate({
  if(input$opt_veb_sven==1){gra_veb_sven()
}else{return("No se optimizará")}
  }) #final isolate
    
    })

#+++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar parametros optimizados #
#+++++++++++++++++++++++++++++++++++++++++#

gra_veb_sven <- reactive({
  a <- try(Tabla.sven(fv = input$n1 ,tit = sv2(),pr =TV() ,pa = c(1,1,1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_veb_sven,fe3=0)[[2]])
  if(class(a)!="try-error"){return(a)}else{}
  
})

#+++++++++++++++++++++++++++++++#
# Muestro curva de rendimientos #
#+++++++++++++++++++++++++++++++#

output$c_veb_sven_op <- renderPlotly({
  #pongo dependencia
  input$boton_4
  
  #
  isolate({
  
  if(input$opt_veb_sven==1){
  #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
  a <- try(cbind.data.frame(plazo=seq(0.9,20,0.1),rendimiento=sven(t=seq(0.9,20,0.1),pa=gra_veb_sven())*100))
  
  if(class(a)!="try-error"){
    b <- ggplot(a,aes(x=plazo,y=rendimiento))+
      geom_line(color="blue")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de redimientos Svensson Parametros Optimizados VEBONOS")+
      theme(plot.title = element_text(hjust = 0.5))
    
    ggplotly(b)
  }else{}
}else{}
  }) #final isolate
    
    })

#///////////////////////////#
#/# SUBSECCION DIEBOLD-LI #/#
#///////////////////////////#

#//////////////#
#/# CASO TIF #/#
#//////////////#

#+++++++++++++++++++++#
# Fecha de valoración #
#+++++++++++++++++++++#

output$p3<-renderPrint({paste(substr(input$n3,9,10),substr(input$n3,6,7),substr(input$n3,1,4),sep = "/")})

#+++++++++++++++++++++++++++++++++++++++++++++#
# Selección de instrumentos por archivo plano #
#+++++++++++++++++++++++++++++++++++++++++++++#

output$datatable_tit_tif_dl<-renderDataTable({
  if(is.null(data_tif_dl())){return()}
  #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
  #datatable(data_pos())
  data_tif_dl()
})

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar lectura instrumentos por archivo plano #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

data_tif_dl <- reactive({
  
  inFile <- input$data_tit_tif_dl
  
  if (is.null(inFile))
    return(NULL)
  
  read.table(inFile$datapath, header = input$header_tit_tif_dl,
             sep = input$sep_tit_tif_dl, quote = input$quote_tit_tif_dl)
  
})

#++++++++++++++++++++++++++++++++++#
# Muestro selección de los titulos #
#++++++++++++++++++++++++++++++++++#

output$q1_dl <- renderPrint({dl1()})

#+++++++++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar que muestra selección de títulos #
#+++++++++++++++++++++++++++++++++++++++++++++++++++#

dl1 <- reactive({
  if(is.null(data_tif_dl())){
    #input$t_sv1
    c(input$t1_dl,input$t2_dl,input$t3_dl,input$t4_dl)
  }else{
    a <- data_tif_dl() 
    as.character(a[,1])
  }
})

#++++++++++++++++++++++++++#
# Muestro precios promedio #
#++++++++++++++++++++++++++#

output$pre1_dl <-renderPrint({tf_dl()})

#+++++++++++++++++++++++++++++++++++#
# Funcion auxiliar precios promedio #
#+++++++++++++++++++++++++++++++++++#

tf_dl <- reactive({pos1(dl1(),0)})

#+++++++++++++++++++++++++++++++++++++#
# Muestro documento "Caracteristicas" #
#+++++++++++++++++++++++++++++++++++++#

output$Ca_dl <- renderDataTable({
  ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
  if(class(ca)=="try-error"){
    v <- print("El archivo no se encuentra, descargar y recargar página!")
    return(as.data.frame(v))
  }else{
    return(ca)
  }
})

#+++++++++++++++++++++++++++++++++++#
# Muestro cantidad de observaciones #
#+++++++++++++++++++++++++++++++++++#

output$dias_tif_dl <- renderPrint({input$d_tif_dl})

#+++++++++++++++++++++++++++#
# Muestro Spline a utilizar #
#+++++++++++++++++++++++++++#

output$spline_tif <- renderPrint({
  a <- try(dl_spline_tif())
  if(class(a)!="try-error"){
    a
  }else{
    #b <- 
    return("Poca cantidad de observaciones, favor seleccionar una cantidad mayor")
  }
})

#++++++++++++++++++++++++++++++++++++++#
# Funcion auxiliar calculo de spline 1 #
#++++++++++++++++++++++++++++++++++++++#

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

#++++++++++++++++++++++++++++++++++++++#
# Funcion auxiliar calculo de spline 2 #
#++++++++++++++++++++++++++++++++++++++#

tabla_sp_dl_tif <- reactive({
  dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
  dat[,3] <- as.Date(as.character(dat[,3]))
  car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
  Tabla.splines(data = dat,tipo = "TIF",fe=input$n3,num =input$d_tif_dl,par = input$parametro_tif_dl,tit=dl1(),car,pr=tf_dl())
})

#++++++++++++++++++++++++++++++++++++#
# Muestro parámetro de suavizamiento #
#++++++++++++++++++++++++++++++++++++#

output$spar_tif_dl <- renderPrint({input$parametro_tif_dl})

#++++++++++++++++++++++#
# Muestro curva spline #
#++++++++++++++++++++++#

output$c_tif_splines_dl <- renderRbokeh({
  withProgress(message = 'Graficando curva de rendimiento...', value = 0, {
    incProgress(1/2, detail = "Calculando alturas")
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    #y <-predict(Tabla.splines(data = dat,tipo = "TIF",fe=input$n3,num = 40,par = input$parametro_tif_dl,tit=c(input$t1_dl,input$t2_dl,input$t3_dl,input$t4_dl),car,pr=tf_dl())[[4]],seq(0.1,20,0.1)*365)$y
    y <-try(predict(tabla_sp_dl_tif()[[4]],seq(0.1,20,0.1)*365)$y)
    
    if(class(y)!="try-error"){
      
      incProgress(1/2, detail = "Ajustando spline")
      
      figure(width = 1000,height = 400) %>%
        ly_points(pto_sp_tif_dl()[,4],pto_sp_tif_dl()[,7],pto_sp_tif_dl(),hover=list("Nombre"=pto_sp_tif_dl()[,1],"Fecha de operación"=pto_sp_tif_dl()[,2])) %>%
        ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="green",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
        # theme_title(text_color="green",text_align="center",text_font_style="italic")%>%
        x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
      
    }else{}
    
    
  })
})

#+++++++++++++++++++++++++++++++#
# Funcion auxiliar curva spline #
#+++++++++++++++++++++++++++++++#

pto_sp_tif_dl <- reactive({
  # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
  # dat[,3] <- as.Date(as.character(dat[,3]))
  # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
  #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n3,num = 40,par = input$parametro_tif_dl,tit=c(input$t1_dl,input$t2_dl,input$t3_dl,input$t4_dl),car,pr=tf_dl())[[2]]
  a <- tabla_sp_dl_tif()[[2]]
  
  # a1 <- cbind.data.frame(a$Plazo,a$Rendimiento)
  # names(a1) <- c("Plazo","Rendimiento")
  return(a)
})

#+++++++++++++++++++++++++++#
# Muestro precios estimados #
#+++++++++++++++++++++++++++#

output$p_est_dl_tif <- renderDataTable({
  withProgress(message = 'Calculando precios teóricos', value = 0, {
    incProgress(1/2, detail = "Realizando iteraciones")
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    a <- try(precio.dl(tit = dl1(),fv = input$n3 ,C = car,pa = c(1,1,1,1),spline1 = dl_spline_tif(),pr=tf_dl())[[1]])
    if(class(a)!="try-error"){
      datatable(a, options = list(paging = FALSE))
    }else{}
    
  })
})

#+++++++++++++++++++++++++++++++++#
# Muestro curva de rendimiento DL #
#+++++++++++++++++++++++++++++++++#

output$curva_tif_dl <- renderPlotly({ 
  #defino eje maduracion
  X1 <- seq(1,20,0.1)
  
  #defino tiempos
  Y1 <- seq(1,50,1)
  
  #
  var_par <- as.data.frame(matrix(0,length(Y1),4))
  
  #defino variable spline
  a <- try(dl_spline_tif())
  
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
})

#/////////////////#
#/# CASO VEBONO #/#
#/////////////////#

#+++++++++++++++++++++#
# Fecha de valoración #
#+++++++++++++++++++++#

#Misma variable p3 

#+++++++++++++++++++++++++++++++++++++++++++++#
# Selección de instrumentos por archivo plano #
#+++++++++++++++++++++++++++++++++++++++++++++#


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar lectura instrumentos por archivo plano #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++#


#++++++++++++++++++++++++++++++++++#
# Muestro selección de los titulos #
#++++++++++++++++++++++++++++++++++#


#+++++++++++++++++++++++++++++++++++++++++++++++++++#
# Función auxiliar que muestra selección de títulos #
#+++++++++++++++++++++++++++++++++++++++++++++++++++#


#++++++++++++++++++++++++++#
# Muestro precios promedio #
#++++++++++++++++++++++++++#


#+++++++++++++++++++++++++++++++++++#
# Funcion auxiliar precios promedio #
#+++++++++++++++++++++++++++++++++++#


#+++++++++++++++++++++++++++++++++++++#
# Muestro documento "Caracteristicas" #
#+++++++++++++++++++++++++++++++++++++#


#+++++++++++++++++++++++++++++++++++#
# Muestro cantidad de observaciones #
#+++++++++++++++++++++++++++++++++++#


#+++++++++++++++++++++++++++#
# Muestro Spline a utilizar #
#+++++++++++++++++++++++++++#


#++++++++++++++++++++++++++++++++++++++#
# Funcion auxiliar calculo de spline 1 #
#++++++++++++++++++++++++++++++++++++++#


#++++++++++++++++++++++++++++++++++++++#
# Funcion auxiliar calculo de spline 2 #
#++++++++++++++++++++++++++++++++++++++#


#++++++++++++++++++++++++++++++++++++#
# Muestro parámetro de suavizamiento #
#++++++++++++++++++++++++++++++++++++#


#++++++++++++++++++++++#
# Muestro curva spline #
#++++++++++++++++++++++#


#+++++++++++++++++++++++++++++++#
# Funcion auxiliar curva spline #
#+++++++++++++++++++++++++++++++#


#+++++++++++++++++++++++++++#
# Muestro precios estimados #
#+++++++++++++++++++++++++++#


#+++++++++++++++++++++++++++++++++#
# Muestro curva de rendimiento DL #
#+++++++++++++++++++++++++++++++++#



#////////////////////////#
#/# SUBSECCION SPLINES #/#
#////////////////////////#

#//////////////#
#/# CASO TIF #/#
#//////////////#


#/////////////////#
#/# CASO VEBONO #/#
#/////////////////#


