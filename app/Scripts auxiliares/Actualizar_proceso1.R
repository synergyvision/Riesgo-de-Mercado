#PROCESO PARA ACTUALIZAR HISTORICO 0-22
#SCRPIT A EJECUTAR
#cargo funciones
#cargo librerias a usar
library(shiny)
library(readr)
library(rriskDistributions)
library(fitdistrplus)
library(shinydashboard)
library(dplyr)
library(lubridate)
library(ggplot2)
library(reshape2)
library(jrvFinance)
library(plotly)
library(rbokeh)
#library(reshape2)
#library(xlsx)
library(nloptr)
library(alabama)
library(DT)
library(xtable)
library(webshot)
library(readxl)
library(xml2)
library(rvest)
library(VaRES)
library(lmomco)


source(paste(getwd(),".Trash/Riesgo-de-Mercado",'app/funciones.R',sep="/"))
#funcion para determinar extension del archivo a descargar
# extension <- function(ruta){
#   s <- unlist(gregexpr(pattern ='/',ruta))
#   nombre <- substring(ruta,(s[length(s)]+1),nchar(ruta))
#   s1 <- unlist(gregexpr(pattern ="\\.",nombre))
#   ext <- substring(nombre,s1+1,nchar(ruta))
#   return(ext)
# }
# 
# #funcion ruta bcv
# ruta_bcv <- function(file){
#   if(file=="0-22"){
#     webpage <- read_html("http://www.bcv.org.ve/sistemas-de-pago/sicet/estadisticas")
#     # Extract records info
#     results <- webpage %>% html_nodes(".file")
#     
#     # Building the dataset
#     records <- vector("list", length = length(results))
#     
#     for (i in seq_along(results)) {
#       url <- results[i] %>% html_nodes("a") %>% html_attr("href")
#       records[[i]] <- data_frame(url = url)
#     }
#     
#     df <- bind_rows(records)
#     return(as.character(df[1,1]))
#   }#final if 0-22
#   else if(file=="caracteristicas" | file=="tasas"){
#     webpage <- read_html("http://www.bcv.org.ve/estadisticas/tasas-de-interes")
#     # Extract records info
#     #results <- webpage %>% html_nodes(".file")
#     
#     
#     # Building the dataset
#     #records <- vector("list", length = length(results))
#     
#     #for (i in seq_along(results)) {
#     #  url <- results[i] %>% html_nodes("a") %>% html_attr("href")
#     #  records[[i]] <- data_frame(url = url)
#     #}
#     
#     #df <- bind_rows(records)
#     if(file=="tasas"){
#       #return(as.character(df[33,1]))
#       results1 <- webpage %>% html_nodes(".odd")
#       text1 <- xml_text(results1)
#       a <- "Operaciones Interbancarias Overnight"
#       b <- as.numeric(gregexpr(a,text1))
#       c <- results1[which(b>0)] %>% html_nodes("a") %>% html_attr("href")
#       return(c)
#     }
#     if(file=="caracteristicas"){
#       #return(as.character(df[37,1]))
#       #return(as.character(df[40,1]))
#       results <- webpage %>% html_nodes(".even")
#       text <- xml_text(results)
#       a1 <- "Características de las emisiones de títulos valores"
#       b1 <- as.numeric(gregexpr(a1,text))
#       c1 <- results[which(b1>0)] %>% html_nodes("a") %>% html_attr("href")
#       return(c1)
#     }
#     
#     
#   }#final caracteristicas y tasas
#   else if(file=="abs"){
#     webpage <- read_html("http://www.bcv.org.ve/politica-monetaria/operaciones-absorcion-diaria")
#     # Extract records info
#     results <- webpage %>% html_nodes(".file")
#     
#     # Building the dataset
#     records <- vector("list", length = length(results))
#     
#     for (i in seq_along(results)) {
#       url <- results[i] %>% html_nodes("a") %>% html_attr("href")
#       records[[i]] <- data_frame(url = url)
#     }
#     
#     df <- bind_rows(records)
#     return(as.character(df[1,1]))
#   }#final abs
#   else if(file=="iny"){
#     webpage <- read_html("http://www.bcv.org.ve/politica-monetaria/operaciones-inyeccion-diaria")
#     # Extract records info
#     results <- webpage %>% html_nodes(".file")
#     
#     # Building the dataset
#     records <- vector("list", length = length(results))
#     
#     for (i in seq_along(results)) {
#       url <- results[i] %>% html_nodes("a") %>% html_attr("href")
#       records[[i]] <- data_frame(url = url)
#     }
#     
#     df <- bind_rows(records)
#     return(as.character(df[1,1]))
#   }#final iny
#   else if(file=="letras"){
#     webpage <- read_html("http://www.bcv.org.ve/politica-monetaria/letras-del-tesoro")
#     # Extract records info
#     results <- webpage %>% html_nodes(".file")
#     
#     # Building the dataset
#     records <- vector("list", length = length(results))
#     
#     for (i in seq_along(results)) {
#       url <- results[i] %>% html_nodes("a") %>% html_attr("href")
#       records[[i]] <- data_frame(url = url)
#     }
#     
#     df <- bind_rows(records)
#     return(as.character(df[1,1]))
#   }#final letras
#   else if(file=="tif" | file=="veb" ){
#     webpage <- read_html("http://www.bcv.org.ve/politica-monetaria/bonos-dpn")
#     # Extract records info
#     results <- webpage %>% html_nodes(".file")
#     
#     # Building the dataset
#     records <- vector("list", length = length(results))
#     
#     for (i in seq_along(results)) {
#       url <- results[i] %>% html_nodes("a") %>% html_attr("href")
#       records[[i]] <- data_frame(url = url)
#     }
#     
#     df <- bind_rows(records)
#     if(file=="tif"){return(as.character(df[10,1]))}
#     if(file=="veb"){return(as.character(df[6,1]))}
#   }#final tif o veb
#   else{
#     print("Nombre inválido, revise eintente nuevamente")
#   }
#   
# }#final funcion ruta_bcv
# 
# 
# Preciosbcv=function(ruta){
#   b5=array()
#   pes <- excel_sheets(ruta)
#   
#   
#   for(i in 1:(length(pes))){
#     nn=0
#     
#     #Validador de lectura pestaña 0-22
#     if(length(grep(pattern ='022',pes[i],fixed = TRUE))==1){
#       b=try(read_excel(ruta, sheet = i,range = "A10:I34",col_names = TRUE),silent = TRUE)
#       
#       #verificardor posible error
#       if(class(b)[1]=="try-error"){ #IF ESPACIO
#         print("Error de lectura")
#         print("Favor revisar la pestaña")
#         print(pes[i])
#       }
#       
#       #leo nombre del dia de operacion
#       #ojo es una manera, la otra forma seria usar el vector de dh
#       name <- try(read_excel(ruta, sheet = i,range = "A2",col_names = FALSE),silent = TRUE)
#       fecha <- substr(name,68,77)
#       
#       
#       if(ncol(b)==8){#if solo letras
#         print("Existe un dia donde hubo solo op de Letras!")
#         b=data.frame(b,nueva=rep(0,dim(b)[1]))
#       }#final if solo letras
#       
#       
#       
#       if(is.na(b[1,5])!=T){ 
#         
#         if(ncol(b)==8){#if solo letras
#           print("Existe un dia donde hubo solo op de Letras!")
#           b=data.frame(b,nueva=rep(0,dim(b)[1]))
#         }#final if solo letras
#         
#         names(b)[9]="Cupón...."
#         b1=b[-which(is.na(b[,1])),]
#         
#         #filtro para cuando no haya TICC
#         if(length(which(is.na(b1[,8])))!=0){
#           b2=b1[-which(is.na(b1[,8])),]
#           b3=b2[-which(b2[,1]=="Instrumento"),]
#           b3.=rep(fecha,length(b3[,1]))
#           b4=cbind(b3.,b3)
#           b5=rbind(b5,b4)
#           b5[which(substr(b5[,1],1,3)=="LTB"),10]=0
#           b5=faux(b5)
#         }else{
#           b3.=rep(fecha,length(b1[,1]))
#           b4=cbind(b3.,b1)
#           b5=rbind(b5,b4)
#           b5[which(substr(b5[,2],1,3)=="LTB"),10]=0
#           b5=faux(b5)
#         }
#         nn=nn+1
#       }
#       
#       # if(is.na(b[1,5])==T  & nn==0){
#       #   #caso en que no hay operaciones
#       #   print("No hubo operacion el dia ")
#       #   print(pes[i])
#       # }
#       
#       #caso normal
#       
#       if(is.na(b[1,5])!=T & nn==0){  
#         if(ncol(b)==8){#if solo letras
#           print("Existe un dia donde hubo solo op de Letras!")
#           b=data.frame(b,nueva=rep(0,dim(b)[1]))
#         }#final if solo letras
#         
#         names(b)[9]="Cupón...."
#         b1=b[-which(is.na(b[,1])),]
#         
#         #filtro para cuando no haya TICC
#         if(length(which(is.na(b1[,8])))!=0){
#           b2=b1[-which(is.na(b1[,8])),]
#           b3=b2[-which(b2[,1]=="Instrumento"),]
#           b3.=rep(fecha,length(b3[,1]))
#           b4=cbind(b3.,b3)
#           b5=rbind(b5,b4)
#           b5[which(substr(b5[,2],1,3)=="LTB"),10]=0
#           b5=faux(b5)
#         }else{
#           b3.=rep(fecha,length(b1[,1]))
#           b4=cbind(b3.,b1)
#           b5=rbind(b5,b4)
#           b5[which(substr(b5[,2],1,3)=="LTB"),10]=0
#           b5=faux(b5)
#         }
#       }
#       
#       if(is.na(b[1,5])==T){
#         #caso en que no hay operaciones
#         print("No hubo operacion el dia ")
#         print(pes[i])
#       }
#       
#       
#     }else{
#       # print("La pestaña")
#       # print(pes[i])
#       # print("No es pestaña 0-22")
#     }
#     
#     
#   }#final for
#   
#   if(nrow(b5)!=1){
#     b6=b5[-1,]
#     
#     b6=faux(b6)
#     
#     return(b6)}else{
#       print("No hay documento disponible")
#     } 
# }#final funcion
# 
# #funcion auxiliar
# #funcion que le da formato al data frame b6
# faux=function(b6){
#   b6[,5] =as.numeric(sub(",",".",b6[,5]))
#   b6[,3]=as.numeric(sub(",",".",b6[,3]))
#   b6[,4]=as.numeric(sub(",",".",b6[,4]))
#   b6[,6]=as.numeric(sub(",",".",b6[,6]))
#   b6[,7]=as.numeric(sub(",",".",b6[,7]))
#   b6[,8]=as.numeric(sub(",",".",b6[,8]))
#   b6[,9]=as.numeric(sub(",",".",b6[,9]))
#   b6[,10]=as.numeric(sub(",",".",b6[,10]))
#   return(b6)
# }
# 
# #funcion Carateristicas
# #funcion que extrae informacion del documento de las
# #caracteristicas y lee todas sus pesta?as
# Carac=function(ruta){
#   c=read_excel(ruta, sheet = "DPN",range = "A7:O90",col_names = TRUE)
#   c1=c[,c(3,5,6,8,10,11,13,15)]
#   c2=c1[-which(is.na(c1[,1])),]
#   c3=cbind(as.character(rep("TIF",1,length(c2[,1]))),c2)
#   c3[,1]=as.character(c3[,1])
#   c3[which(c3[,5]!="Tasa Fija"),1]="VEBONO"
#   names(c3)=c("Tipo Instrumento","Sicet","F.Emision","F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1","Pago cupon 2","Cupon")
#   
#   #tranformo formato fecha
#   a1 <- try(format(c3[,3],"%d/%m/%Y"),silent = TRUE)
#   
#   if(class(a1)!="try-error"){
#     c3[,3]=a1
#   }else{
#     print("Error en fecha")
#   }
#   
#   #
#   a2 <- try(format(c3[,4],"%d/%m/%Y"),silent = TRUE)
#   
#   if(class(a2)!="try-error"){
#     c3[,4]=a2
#   }else{
#     print("Error en fecha")
#   }
#   
#   #
#   a3 <- try(format(c3[,7],"%d/%m/%Y"),silent = TRUE)
#   
#   if(class(a3)!="try-error"){
#     c3[,7]=a3
#   }else{
#     print("Error en fecha")
#   }
#   
#   #
#   a4 <- try(format(c3[,8],"%d/%m/%Y"),silent = TRUE)
#   if(class(a4)!="try-error"){
#     c3[,8]=a4
#   }else{
#     print("Error en fecha")
#     #resulevo error
#     #obtengo nueva columna a partir de columna anterior
#     #el detalle es que queda en formato Date
#     c3[,8]=as.Date(c3[,7],"%d/%m/%Y")+91
#     
#     c3[,8]=paste(substr(c3[,8],9,10),substr(c3[,8],6,7),substr(c3[,8],1,4),sep = "/")
#     
#   }
#   #agrego columna Nombre TIf o Vebono + fecha venc
#   c4=c3[,1]
#   
#   Nombre=c()
#   for(i in 1:length(c4)){
#     Nombre[i]=paste(c4[i],paste(substr(c3[i,4],4,5),substr(c3[i,4],7,10),sep = ""),sep = "")
#   }
#   
#   c3=cbind(c3[,1],Nombre,c3[,2:ncol(c3)])
#   names(c3)[1]="Tipo Instrumento"
#   
#   
#   #pestaña DPN-TICC
#   #d=read.xlsx(ruta, sheetName = "DPN - TICC",startRow = 7,colIndex = 1:14,header = TRUE)
#   d <- try(read_excel(ruta,sheet = "DPN - TICC",range = "A7:N13",col_names = TRUE),silent = TRUE)
#   #Añado nuevo titulo VF
#   #v=try(read.xlsx(ruta, sheetName = "VF",startRow = 7,colIndex = 1:14,header = TRUE),silent = TRUE)
#   v=try(read_excel(ruta, sheet = "VF",range = "A7:N30" ,col_names = TRUE),silent = TRUE)
#   #
#   #vb=try(read.xlsx(ruta, sheetName = "VB",startRow = 7,colIndex = 1:15,header = TRUE),silent = TRUE)
#   vb=try(read_excel(ruta, sheet = "VB",range = "A7:O50",col_names = TRUE),silent = TRUE)
#   #
#   #cf=try(read.xlsx(ruta, sheetName = "CF",startRow = 7,colIndex = 1:14,header = TRUE),silent = TRUE)
#   cf=try(read_excel(ruta, sheet = "CF",range = "A7:N30",col_names = TRUE),silent = TRUE)
#   #
#   #cb=try(read.xlsx(ruta, sheetName = "CB",startRow = 7,colIndex = 1:14,header = TRUE),silent = TRUE)
#   cb=try(read_excel(ruta, sheet = "CB",range = "A7:N20",col_names = TRUE),silent = TRUE)
#   
#   
#   #if pestaña dpn - ticc
#   if(class(d)[1]=="try-error"){
#     d3=c()
#   }else{
#     d=d[-which(is.na(d[,2])),c(3,4,5,7,9,10,12,14)]
#     d <- as.data.frame(d)
#     #cambio formato fechas
#     d[,2]=format(d[,2],"%d/%m/%Y")
#     d[,3]=format(d[,3],"%d/%m/%Y")
#     d[,6]=format(d[,6],"%d/%m/%Y")
#     d[,7]=format(d[,7],"%d/%m/%Y")
#     
#     d1=rep("TICC",1,nrow(d))
#     
#     d2=c()
#     for(i in 1:length(d1)){
#       d2[i]=paste(d1[i],paste(substr(d[i,3],4,5),substr(d[i,3],7,10),sep = ""),sep = "")
#     }
#     
#     d3=cbind(d1,d2,d)
#     names(d3)=names(c3) 
#     
#   }
#   
#   
#   #if peta?a VF
#   if(class(v)[1]=="try-error"){
#     #print("No hay pesta?a VF")
#     w3=c()
#   }else{
#     #leo VF
#     v=v[-which(is.na(v[,2])),c(3,4,5,7,9,10,12,14)]
#     v<-as.data.frame(v)
#     #cambio formato fechas
#     v[,2]=format(v[,2],"%d/%m/%Y")
#     v[,3]=format(v[,3],"%d/%m/%Y")
#     v[,6]=format(v[,6],"%d/%m/%Y")
#     v[,7]=format(v[,7],"%d/%m/%Y")
#     
#     w1=rep("Valores Fin.",1,nrow(v))
#     
#     w2=c()
#     for(i in 1:length(w1)){
#       w2[i]=paste(w1[i],paste(substr(v[i,3],4,5),substr(v[i,3],7,10),sep = ""),sep = "")
#     }
#     
#     w3=cbind(w1,w2,v)
#     names(w3)=names(c3)
#     
#   }#final if VF
#   
#   #if Pesta?a VB
#   if(class(vb)[1]=="try-error"){
#     #print("No hay pesta?a VB")
#     #CARACTERISTICAS DEFINITIVA
#     #C3=rbind(c3,d3) 
#     
#     #En caso que no lea bien un numero
#     #C3$Cupon=as.numeric(sub(",",".",C3$Cupon))
#     
#     #return(C3)  
#     v3=c()
#   }else{
#     #leo Vb   
#     vb=vb[,-4]
#     vb=vb[-which(is.na(vb[,2])),c(3,4,5,7,9,10,12,14)]
#     vb <- as.data.frame(vb)
#     #cambio formato fechas
#     vb[,2]=format(vb[,2],"%d/%m/%Y")
#     vb[,3]=format(vb[,3],"%d/%m/%Y")
#     vb[,6]=format(vb[,6],"%d/%m/%Y")
#     vb[,7]=format(vb[,7],"%d/%m/%Y")
#     
#     v1=rep("Valores Bol.",1,nrow(vb))
#     
#     v2=c()
#     for(i in 1:length(v1)){
#       v2[i]=paste(v1[i],paste(substr(vb[i,3],4,5),substr(vb[i,3],7,10),sep = ""),sep = "")
#     }
#     
#     v3=cbind(v1,v2,vb)
#     names(v3)=names(c3) 
#     
#   }#final if VB
#   
#   
#   if(class(cf)[1]=="try-error"){
#     #print("No hay pesta?a CF")
#     #CARACTERISTICAS DEFINITIVA
#     #C3=rbind(c3,d3) 
#     
#     #En caso que no lea bien un numero
#     #C3$Cupon=as.numeric(sub(",",".",C3$Cupon))
#     
#     #return(C3)  
#     x3=c()
#   }else{
#     #leo cf
#     cf=cf[-which(is.na(cf[,2])),c(3,4,5,7,9,10,12,14)]
#     cf <- as.data.frame(cf)
#     #cambio formato fechas
#     cf[,2]=format(cf[,2],"%d/%m/%Y")
#     cf[,3]=format(cf[,3],"%d/%m/%Y")
#     cf[,6]=format(cf[,6],"%d/%m/%Y")
#     cf[,7]=format(cf[,7],"%d/%m/%Y")
#     
#     x1=rep("Certificado Part. Simon Bolivar",1,nrow(cf))
#     
#     x2=c()
#     for(i in 1:length(x1)){
#       x2[i]=paste(x1[i],paste(substr(cf[i,3],4,5),substr(cf[i,3],7,10),sep = ""),sep = "")
#     }
#     
#     x3=cbind(x1,x2,cf)
#     names(x3)=names(c3) 
#     
#   }#final if CF
#   
#   
#   if(class(cb)[1]=="try-error"){
#     #print("No hay pesta?a CB")
#     #CARACTERISTICAS DEFINITIVA
#     #C3=rbind(c3,d3) 
#     
#     #En caso que no lea bien un numero
#     #C3$Cupon=as.numeric(sub(",",".",C3$Cupon))
#     
#     #return(C3)  
#     y3=c()
#   }else{
#     
#     #leo cb
#     cb=cb[-which(is.na(cb[,2])),c(3,4,5,7,9,10,12,14)]
#     cb <- as.data.frame(cb)
#     #cambio formato fechas
#     cb[,2]=format(cb[,2],"%d/%m/%Y")
#     cb[,3]=format(cb[,3],"%d/%m/%Y")
#     cb[,6]=format(cb[,6],"%d/%m/%Y")
#     cb[,7]=format(cb[,7],"%d/%m/%Y")
#     
#     y1=rep("Certificado Part. Bandes",1,nrow(cb))
#     
#     y2=c()
#     for(i in 1:length(y1)){
#       y2[i]=paste(y1[i],paste(substr(cb[i,3],4,5),substr(cb[i,3],7,10),sep = ""),sep = "")
#     }
#     
#     y3=cbind(y1,y2,cb)
#     names(y3)=names(c3) 
#   }#final if CB
#   
#   #CARACTERISTICAS DEFINITIVA
#   #if de pesta?as
#   if(length(c3)==1|length(d3)==1|length(v3)==1|length(w3)==1|length(x3)==1|length(y3)==1){
#     #print("No hay una pesta?a!") 
#     ve=c(length(c3),length(d3),length(v3),length(w3),length(x3),length(y3))
#     #h1=which(ve==1)
#     
#     if(ve[2]==1){
#       # print("Falta pesta?a DPN-TICC")
#       C3=rbind(c3,v3,w3,x3,y3)
#       return(C3)
#     }
#     if(ve[3]==1){
#       #print("Falta pesta?a VB")
#       C3=rbind(c3,d3,w3,x3,y3)
#       return(C3)
#     }
#     if(ve[4]==1){
#       #print("Falta pesta?a VF")
#       C3=rbind(c3,d3,v3,x3,y3)
#       return(C3)
#     }
#     if(ve[5]==1){
#       # print("Falta pesta?a CF")
#       C3=rbind(c3,d3,v3,w3,y3)
#       return(C3)
#     }
#     if(ve[6]==1){
#       #print("Falta pesta?a CB")
#       C3=rbind(c3,d3,v3,w3,x3)
#       return(C3)
#     }
#     
#   }else{
#     # print("Existen todas las pesta?as!")   
#     C3=rbind(c3,d3,v3,w3,x3,y3) 
#     #En caso que no lea bien un numero
#     C3$Cupon=as.numeric(sub(",",".",C3$Cupon))
#     
#     #VERIFICO SI HAY DUPLICADOS Y AGREGO NOMBRES DIFERENTES
#     if(anyDuplicated(C3$Nombre)){
#       #print("título duplicado")
#       #print(as.character(C3$Nombre[anyDuplicated(C3$Nombre)]))
#       aa <- which(as.character(C3$Nombre[anyDuplicated(C3$Nombre)])==C3$Nombre)
#       C3$Nombre <- as.character(C3$Nombre)
#       C3$Nombre[aa[1]] <- paste0(C3$Nombre[aa[1]],"a")
#       C3$Nombre[aa[2]] <- paste0(C3$Nombre[aa[2]],"b")
#       C3$Nombre <- as.factor(C3$Nombre)
#       
#     }
#     
#     return(C3)}#final if pesta?as
#   
# }#final funcion Caracteristicas
# 
# 
# #Funcion Formato
# #funcion que toma la el documento de las caracteristicas informacion 
# #necesaria para darle formato al data frame b6
# formatop=function(C3,b3){
#   
#   #en caso de Haber letras pongo cupon 0
#   if(length(which(substr(b3$Instrumento,1,3)=="LTB"))!=0){
#     b3$'Cupón....'[which(substr(b3$Instrumento,1,3)=="LTB")]=0
#   }
#   
#   #traigo la fecha de vencimiento
#   b3$Vencimiento=as.character(b3$Vencimiento)
#   
#   for(i in 1:length(b3$b3.)){
#     if(substr(b3$Instrumento[i],1,3)!="LTB"){
#       #which(as.character(b3$Instrumento[i])==as.character(c3$Sicet))
#       b3$Vencimiento[i]=C3$F.Vencimiento[which(as.character(b3$Instrumento[i])==as.character(C3$Sicet))]
#     }else{ 
#       b3$Vencimiento[i]=as.character(format(as.Date("1900-01-01")+as.numeric(b3$Vencimiento[i])-2,"%d/%m/%Y"))
#     }
#   }
#   
#   #traigo si es TIF , VEBONO o TICC
#   b3.=cbind(as.character(rep("TIF",1,length(b3$b3.))),b3)
#   b3.$`as.character(rep("TIF", 1, length(b3$b3.)))`=as.character(b3.$`as.character(rep("TIF", 1, length(b3$b3.)))`)
#   
#   for(i in 1:length(b3.$b3.)){
#     if(substr(b3$Instrumento[i],1,3)!="LTB"){
#       b3.$`as.character(rep("TIF", 1, length(b3$b3.)))`[i]=as.character(C3$`Tipo Instrumento`[which(as.character(b3.$Instrumento[i])==as.character(C3$Sicet))])
#     }else{
#       b3.$`as.character(rep("TIF", 1, length(b3$b3.)))`[i]="LETRA"
#       
#     }
#   }
#   
#   #fuente
#   p=as.character(rep("022 BCV",1,length(b3.$b3.)))
#   
#   B3=cbind(b3.[,c(1,2)],p,b3.[,3:ncol(b3.)])
#   
#   #traigo columna Nombre de las caracteristicas
#   nom=c()
#   
#   for(i in 1:nrow(B3)){
#     if(substr(b3$Instrumento[i],1,3)!="LTB"){
#       nom[i]=as.character(C3$Nombre[which(as.character(B3$Instrumento[i])==C3$Sicet)])
#     }else{
#       n1=substr(b3.$Vencimiento[i],4,5)
#       n2=substr(b3.$Vencimiento[i],7,10)
#       
#       nom[i]=paste("LTB",n1,n2,sep="")
#     }
#   }
#   
#   #frecuencia y rendimiento
#   fre=rep(0,1,length(b3.$b3.))
#   rend=rep(0,1,length(b3.$b3.))
#   
#   B3=cbind(B3[,1],nom,B3[,2:ncol(B3)],fre,rend)
#   names(B3)=c("Tipo Instrumento","Nombre","Fecha op","Fuente","Sicet","F.Vencimiento","Plazo","Op","Monto","Pre min","Pre max","Pre prom","Cupon","Frecuencia","Rendimiento")
#   
#   #añado criterio de que si en caraceristica dice 91 dias es freq=4 si es 182 freq=2
#   for(i in 1:length(B3$`Tipo Instrumento`)){
#     if(substr(B3$Sicet[i],1,3)!="LTB"){
#       if(substr(as.character(C3$Inicio[which(as.character(B3$Sicet[i])==C3$Sicet)]),6,8)=="91 "){
#         B3$Frecuencia[i]=4
#       }
#       if(substr(as.character(C3$Inicio[which(as.character(B3$Sicet[i])==C3$Sicet)]),6,8)=="180" |substr(as.character(C3$Inicio[which(as.character(B3$Sicet[i])==C3$Sicet)]),6,8)=="182"){
#         B3$Frecuencia[i]=2
#       }
#     }
#   }
#   
#   #añado rendimiento que es la formula RENDTO de excel con base 0
#   for(i in 1:nrow(B3)){
#     if(substr(B3$Sicet[i],1,3)!="LTB"){
#       #B3$Rendimiento=bond.yields(as.Date(B3$`Fecha op`,"%d/%m/%Y"),as.Date(B3$F.Vencimiento,"%d/%m/%Y"),(B3$Cupon/100), B3$Frecuencia,B3$`Pre prom`,convention = c("30/360"),B3$Frecuencia)*100
#       B3$Rendimiento[i]=bond.yield(as.Date(B3$`Fecha op`[i],"%d/%m/%Y"),as.Date(B3$F.Vencimiento[i],"%d/%m/%Y"),(B3$Cupon[i]/100), B3$Frecuencia[i],B3$`Pre prom`[i],convention = c("ACT/360"),B3$Frecuencia[i])*100
#     }
#     if(substr(B3$Sicet[i],1,3)=="LTB"){
#       #B3$Rendimiento=bond.yields(as.Date(B3$`Fecha op`,"%d/%m/%Y"),as.Date(B3$F.Vencimiento,"%d/%m/%Y"),(B3$Cupon/100), B3$Frecuencia,B3$`Pre prom`,convention = c("30/360"),B3$Frecuencia)*100
#       B3$Rendimiento[i]=bond.yield(as.Date(B3$`Fecha op`[i],"%d/%m/%Y"),as.Date(B3$F.Vencimiento[i],"%d/%m/%Y"),0, 0.001,B3$`Pre prom`[i],convention = c("ACT/360"),0)*100
#     }
#   }
#   
#   return(B3)
# }#final funcion formato precios 022

#descargo archivos
download.file(url=ruta_bcv("caracteristicas"),destfile=paste(getwd(),".Trash/Riesgo-de-Mercado","app","data",paste0("Caracteristicas.",extension(ruta_bcv("caracteristicas"))),sep = "/"),method = "internal",mode="wb")
download.file(url=ruta_bcv("0-22"),destfile=paste(getwd(),".Trash/Riesgo-de-Mercado","app","data",paste0("0-22.",extension(ruta_bcv("0-22"))),sep = "/"),method = "internal",mode="wb")


#ca <- try(Preciosbcv(paste(getwd(),"data","0-22.xls",sep = "/")))
ca <- try(Preciosbcv(paste(getwd(),".Trash/Riesgo-de-Mercado","app","data",paste0("0-22.",extension(ruta_bcv("0-22"))),sep = "/")))
#ca1 <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
#ca1 <- try(Carac(paste(getwd(),".Trash/Riesgo-de-Mercado","app","data",paste0("Caracteristicas.",extension(ruta_bcv("caracteristicas"))),sep = "/")))
ca1 <- try(Carac(paste(getwd(),".Trash/Riesgo-de-Mercado","app","data",paste0("Caracteristicas.","xls"),sep = "/")))



ca2 <- formatop(ca1,ca)
  #convierto fecha de op y venc en fechas
  ca2$`Fecha op` <- as.Date(as.character(ca2$`Fecha op`),format="%d/%m/%Y")
  ca2$F.Vencimiento <- as.Date(as.character(ca2$F.Vencimiento),format="%d/%m/%Y")

  #este data frame es el que utiliza la metodologia Spline para los calculos
  ca3 <- dplyr::arrange(ca2,(`Fecha op`))

  #guardo historico_actualizado
  hist <- read.csv(paste(getwd(),".Trash/Riesgo-de-Mercado","app","data","Historico.txt",sep = "/"),sep="")
  hist[,3] <- as.Date(as.character(hist[,3]))
  hist[,6] <- as.Date(as.character(hist[,6]))


  names(ca3)=names(hist)
  #print(str(ca3))
  #print(str(hist))

  hist_act <- rbind.data.frame(hist,ca3)


  write.table(hist_act,paste(getwd(),".Trash/Riesgo-de-Mercado","app","data","Historico_act.txt",sep = "/"),row.names = FALSE)

 # return(ca3)