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
    paste(input$dataset, ".xls", sep = "")
  },
  content = function(file) {
    file<-paste(getwd(),"data",paste(input$dataset, ".xls", sep = ""),sep="/")
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
  ca <- try(Preciosbcv(paste(getwd(),"data","0-22.xls",sep = "/")))
  ca1 <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
  
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
    c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns)
  }else{
    a <- data_tit_tif_ns() 
    as.character(a[,1])
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
    b
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

output$c_tif_ns <- renderPlot({
  ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=nelson_siegel(t=seq(0.1,20,0.1),pa=pa_ns)*100),aes(x=x,y=y))+
    geom_line(color="blue")+xlab("Maduración (años)")+
    ylab("Rendimiento (%)")+theme_gray()+
    ggtitle("Curva de rendimiento Nelson y Siegel Parámetros Iniciales TIF")+
    theme(plot.title = element_text(hjust = 0.5))
  
})

#+++++++++++++++++++++++++++++#
# Muestro parametros elegidos #
#+++++++++++++++++++++++++++++#

output$new_ns_tif <- renderPrint({(data.frame('B0'=input$ns_b0_tif,'B1'=input$ns_b1_tif,'B2'=input$ns_b2_tif,'T'=input$ns_t_tif,row.names = " " ))})

#++++++++++++++#
# Verificacion #
#++++++++++++++#

output$ver_ns_tif <- renderPrint({data.frame('Condición_1'=input$ns_b0_tif>0,'Condición_2'=input$ns_b0_tif+input$ns_b1_tif>0,'Condición_3'=input$ns_t_tif>0,row.names = " " )})

#++++++++++++++++++++++++++++++++++++++++++#
# Muestro precios con parámetros escogidos #
#++++++++++++++++++++++++++++++++++++++++++#

output$p_est_tif_ns_el <- renderDataTable({
  if(length(ns1())!=0){
    a <- try(Tabla.ns(fv = input$n2 ,tit = ns1(),pr =TF_NS() ,pa = c(input$ns_b0_tif,input$ns_b1_tif,input$ns_b2_tif,input$ns_t_tif),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]] )
    if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  }else{}
})

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# Muestro curva de rendimientos con parámetros escogidos #
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

output$c_tif_ns1_new <- renderPlot({
  ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=nelson_siegel(t=seq(0.1,20,0.1),pa=c(input$ns_b0_tif,input$ns_b1_tif,input$ns_b2_tif,input$ns_t_tif))*100),aes(x=x,y=y))+
    geom_line(color="brown")+xlab("Maduración (años)")+
    ylab("Rendimiento (%)")+theme_gray()+
    ggtitle("Curva de rendimiento Nelson y Siegel Parámetros elegidos TIF")+
    theme(plot.title = element_text(hjust = 0.5))
})

#+++++++++++++++++++++++++++++#
# Muestro precios optimizados #
#+++++++++++++++++++++++++++++#

output$p_est_tif_opt_ns <- renderDataTable({
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
})

#++++++++++++++++++++++++++++++++#
# Muestro parametros optimizados #
#++++++++++++++++++++++++++++++++#

output$par_tif_ns_op<-renderPrint({if(input$opt_tif_ns==1){gra_tif_ns()
}else{}})

#+++++++++++++++++++++++++++++++#
# Muestro curva de rendimientos #
#+++++++++++++++++++++++++++++++#

output$c_tif_ns_op <- renderPlot({if(input$opt_tif_ns==1){
  #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
  ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=nelson_siegel(t=seq(0.1,20,0.1),pa=gra_tif_ns())*100),aes(x=x,y=y))+
    geom_line(color="green")+xlab("Maduración (años)")+
    ylab("Rendimiento (%)")+theme_gray()+
    ggtitle("Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")+
    theme(plot.title = element_text(hjust = 0.5))
}else{}})

#/////////////////#
#/# CASO VEBONO #/#
#/////////////////#

#/////////////////////////#
#/# SUBSECCION SVENSSON #/#
#/////////////////////////#

#//////////////#
#/# CASO TIF #/#
#//////////////#

#/////////////////#
#/# CASO VEBONO #/#
#/////////////////#


#///////////////////////////#
#/# SUBSECCION DIEBOLD-LI #/#
#///////////////////////////#

#//////////////#
#/# CASO TIF #/#
#//////////////#

#/////////////////#
#/# CASO VEBONO #/#
#/////////////////#

#////////////////////////#
#/# SUBSECCION SPLINES #/#
#////////////////////////#

#//////////////#
#/# CASO TIF #/#
#//////////////#


#/////////////////#
#/# CASO VEBONO #/#
#/////////////////#


