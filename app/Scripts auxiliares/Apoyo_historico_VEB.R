#HISTORICO PRECIOS VEBONO

##############
##############
##############
#HISTORICO NELSON Y SIEGEL
##############
##############
##############

#CARGAR SIEMPRE!
#CORRER APP
#cargo funciones necesarias
source(paste0(getwd(),'/app/funciones.R'))

#Defino función para extraer precios promedio del archivo en la carpeta data
pos1 <- function(t,ind,tif){
  #caso tif
  if(ind==0){
    #tif <- read.csv(paste(getwd(),"data","Precio_prom_tif.txt",sep = "/"),sep="")
    tif$Títulos <- as.character(tif$Títulos)
    p <- c()
    
    #condicional de existencia
    for(i in 1:length(t)){
      if(length(which(t[i]==tif$Títulos))!=0){
        p[i] <- tif$Precio.Promedio[which(t[i]==tif$Títulos)]
      }else{
        #print("Titulo no encontrado")
        p[i] <- 0
      }
    }
    
    names(p) <- t
    return(p)
    
    
  } #final if tif
  
  
  #caso veb
  if(ind==1){
    #veb <- read.csv(paste(getwd(),"data","Precio_prom_veb.txt",sep = "/"),sep="")
    veb <- tif
    veb$Títulos <- as.character(veb$Títulos)
    
    p <- c()
    #condicional de existencia
    for(i in 1:length(t)){
      if(length(which(t[i]==veb$Títulos))!=0){
        p[i] <- veb$Precio.Promedio[which(t[i]==veb$Títulos)]
      }else{
        #print("Titulo no encontrado")
        p[i] <- 0
      }
    } 
    
    names(p) <- t
    return(p)
    
  }
  
  
  
}#final funcion pos1

#precios promedio nuevos
Precio_prom_veb <- read.csv("~/Riesgo-de-Mercado/app/data/Precio_prom_veb.txt", encoding="UTF-8", sep="")

#ENERO 2019
ene <- c("01/01/2019","02/01/2019","03/01/2019","04/01/2019","07/01/2019",
         "08/01/2019","09/01/2019","10/01/2019","11/01/2019","14/01/2019",
         "15/01/2019","16/01/2019","17/01/2019","18/01/2019","21/01/2019",
         "22/01/2019","23/01/2019","24/01/2019","25/01/2019","28/01/2019",
         "29/01/2019","30/01/2019","31/01/2019")

#leo caracteristicas
ca <- Carac("C:/Users/Ecuad/Downloads/30-05-2019.xls")
names(ca) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
               "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
               "Pago cupon 2","Cupon")

tit <- levels(as.factor(as.character(ca$Nombre[ca$`Tipo Instrumento`=="VEBONO"])))

#busco precio promedio
pp <- pos1(tit,1,Precio_prom_veb)

pp[which(pp==0)]


#

p2 <- rep(0,length(tit[-which(pp==0)])+1)

for(i in 1:length(ene)){
  print(i)
  p1 <- try(Tabla.ns(fv=ene[i],tit[-which(pp==0)],pos1(tit[-which(pp==0)],1,Precio_prom_veb),pa=c(1,1,1,1),ind=1,C=ca,fe2=1,fe3=0)[[3]])
  
  if(!is.null(p1)){
    p2 <- cbind.data.frame(p2,p1$Precios)  
  }else{
    p1 <- rep(0,length(tit[-which(pp==0)])+1)
    p2 <- cbind.data.frame(p2,p1) 
  }
  
}

q <- p2[-nrow(p2),-1]
names(q) <- ene
row.names(q) <- tit[-which(pp==0)]
q1 <- t(q)

write.table(q1,"precios_ns_veb_ene_19.txt")

#CREO FUNCION , QUE SERVIRIA DE ENERO HASTA NOVIEMBRE PARTE1
pre_veb <- function(ene,ca){
  tit <- levels(as.factor(as.character(ca$Nombre[ca$`Tipo Instrumento`=="VEBONO"])))
  
  #busco precio promedio
  pp <- pos1(tit,1,Precio_prom_veb)
  
  #
  p2 <- rep(0,length(tit[-which(pp==0)])+1)
  
  for(i in 1:length(ene)){
    print(i)
    p1 <- try(Tabla.ns(fv=ene[i],tit[-which(pp==0)],pos1(tit[-which(pp==0)],1,Precio_prom_veb),pa=c(1,1,1,1),ind=1,C=ca,fe2=1,fe3=0)[[3]])
    
    if(!is.null(p1)){
      p2 <- cbind.data.frame(p2,p1$Precios)  
    }else{
      p1 <- rep(0,length(tit[-which(pp==0)])+1)
      p2 <- cbind.data.frame(p2,p1) 
    }
    
  }
  
  # q <- p2[-nrow(p2),-1]
  # names(q) <- ene
  # row.names(q) <- tit[-which(pp==0)]
  # q1 <- t(q)
  return(p2)
}

#FEBRERO 2019
feb <- c("01/02/2019","04/02/2019","05/02/2019","06/02/2019","07/02/2019",
         "08/02/2019","11/02/2019","12/02/2019","13/02/2019","14/02/2019",
         "15/02/2019","18/02/2019","19/02/2019","20/02/2019","21/02/2019",
         "22/02/2019","25/02/2019","26/02/2019","27/02/2019","28/02/2019")

#leo caracteristicas
ca <- Carac("C:/Users/Ecuad/Downloads/30-05-2019.xls")
names(ca) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
               "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
               "Pago cupon 2","Cupon")


q1 <- pre_veb(feb,ca)

p2 <- q1

q <- p2[-nrow(p2),-1]
names(q) <- feb
row.names(q) <- tit[-which(pp==0)]
q1 <- t(q)

write.table(q1,"precios_ns_veb_feb_19.txt")

#MARZO 2019
mar <- c("01/03/2019","04/03/2019","05/03/2019","06/03/2019","07/03/2019",
         "08/03/2019","11/03/2019","12/03/2019","13/03/2019","14/03/2019",
         "15/03/2019","18/03/2019","19/03/2019","20/03/2019","21/03/2019",
         "22/03/2019","25/03/2019","26/03/2019","27/03/2019","28/03/2019",
         "29/03/2019")

#leo caracteristicas
ca <- Carac("C:/Users/Ecuad/Downloads/30-05-2019.xls")
names(ca) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
               "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
               "Pago cupon 2","Cupon")


q1 <- pre_veb(mar,ca)

p2 <- q1

q <- p2[-nrow(p2),-1]
names(q) <- mar
row.names(q) <- tit[-which(pp==0)]
q1 <- t(q)

write.table(q1,"precios_ns_veb_mar_19.txt")

#ABRIL 2019
abr <- c("01/04/2019","02/04/2019","03/04/2019","04/04/2019","05/04/2019",
         "08/04/2019","09/04/2019","10/04/2019","11/04/2019","12/04/2019",
         "15/04/2019","16/04/2019","17/04/2019","18/04/2019","19/04/2019",
         "22/04/2019","23/04/2019","24/04/2019","25/04/2019","26/04/2019",
         "29/04/2019","30/04/2019")

#leo caracteristicas
ca <- Carac("C:/Users/Ecuad/Downloads/30-05-2019.xls")
names(ca) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
               "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
               "Pago cupon 2","Cupon")

q1 <- pre_veb(abr,ca)

p2 <- q1

q <- p2[-nrow(p2),-1]
names(q) <- abr
row.names(q) <- tit[-which(pp==0)]
q1 <- t(q)

write.table(q1,"precios_ns_veb_abr_19.txt")


#MAYO 2019
may <- c("01/05/2019","02/05/2019","03/05/2019","06/05/2019","07/05/2019",
         "08/05/2019","09/05/2019","10/05/2019","13/05/2019","14/05/2019",
         "15/05/2019","16/05/2019","17/05/2019","20/05/2019","21/05/2019",
         "22/05/2019","23/05/2019","24/05/2019","27/05/2019","28/05/2019",
         "29/05/2019","30/05/2019","31/05/2019")


#leo caracteristicas
ca <- Carac("C:/Users/Ecuad/Downloads/30-05-2019.xls")
names(ca) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
               "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
               "Pago cupon 2","Cupon")

q1 <- pre_veb(may,ca)

p2 <- q1

q <- p2[-nrow(p2),-1]
names(q) <- may
row.names(q) <- tit[-which(pp==0)]
q1 <- t(q)

write.table(q1,"precios_ns_veb_may_19.txt")


#JUNIO 2019
jun <- c("03/06/2019","04/06/2019","05/06/2019","06/06/2019","07/06/2019",
         "10/06/2019","11/06/2019","12/06/2019","13/06/2019","14/06/2019",
         "17/06/2019","18/06/2019","19/06/2019","20/06/2019","21/06/2019",
         "24/06/2019","25/06/2019","26/06/2019","27/06/2019","28/06/2019")

#leo caracteristicas
ca <- Carac("C:/Users/Ecuad/Downloads/30-05-2019.xls")
names(ca) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
               "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
               "Pago cupon 2","Cupon")


q1 <- pre_veb(jun,ca)

p2 <- q1

q <- p2[-nrow(p2),-1]
names(q) <- jun
row.names(q) <- tit[-which(pp==0)]
q1 <- t(q)

write.table(q1,"precios_ns_veb_jun_19.txt")

#JULIO 2019
jul <- c("01/07/2019","02/07/2019","03/07/2019","04/07/2019","05/07/2019",
         "08/07/2019","09/07/2019","10/07/2019","11/07/2019","12/07/2019",
         "15/07/2019","16/07/2019","17/07/2019","18/07/2019","19/07/2019",
         "22/07/2019","23/07/2019","24/07/2019","25/07/2019","26/07/2019",
         "29/07/2019","30/07/2019","31/07/2019")

#leo caracteristicas
ca <- Carac("C:/Users/Ecuad/Downloads/30-05-2019.xls")
names(ca) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
               "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
               "Pago cupon 2","Cupon")

tit <- levels(as.factor(as.character(ca$Nombre[ca$`Tipo Instrumento`=="VEBONO"])))

q1 <- pre_veb(jul,ca)

p2 <- q1

q <- p2[-nrow(p2),-1]
names(q) <- jul
row.names(q) <- tit[-which(pp==0)]
q1 <- t(q)

write.table(q1,"precios_ns_veb_jul_19.txt")


#AGOSTO 2019
ago <- c("01/08/2019","02/08/2019","05/08/2019","06/08/2019","07/08/2019",
         "08/08/2019","09/08/2019","12/08/2019","13/08/2019","14/08/2019",
         "15/08/2019","16/08/2019","19/08/2019","20/08/2019","21/08/2019",
         "22/08/2019","23/08/2019","26/08/2019","27/08/2019","28/08/2019",
         "29/08/2019","30/08/2019")

#leo caracteristicas
ca <- Carac("C:/Users/Ecuad/Downloads/30-08-2019.xls")
names(ca) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
               "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
               "Pago cupon 2","Cupon")


tit <- levels(as.factor(as.character(ca$Nombre[ca$`Tipo Instrumento`=="VEBONO"])))

#busco precio promedio
pp <- pos1(tit,1,Precio_prom_veb)

q1 <- pre_veb(ago,ca)

p2 <- q1

q <- p2[-nrow(p2),-1]
names(q) <- ago
row.names(q) <- tit[-which(pp==0)]
q1 <- t(q)

write.table(q1,"precios_ns_veb_ago_19.txt")

#SEPTIEMBRE 2019
sep <- c("02/09/2019","03/09/2019","04/09/2019","05/09/2019","06/09/2019",
         "09/09/2019","10/09/2019","11/09/2019","12/09/2019","13/09/2019",
         "16/09/2019","17/09/2019","18/09/2019","19/09/2019","20/09/2019",
         "23/09/2019","24/09/2019","25/09/2019","26/09/2019","27/09/2019",
         "30/09/2019")


#leo caracteristicas
ca <- Carac("C:/Users/Ecuad/Downloads/30-09-2019.xls")
names(ca) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
               "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
               "Pago cupon 2","Cupon")

tit <- levels(as.factor(as.character(ca$Nombre[ca$`Tipo Instrumento`=="VEBONO"])))

#busco precio promedio
pp <- pos1(tit,1,Precio_prom_veb)

q1 <- pre_veb(sep,ca)

p2 <- q1

q <- p2[-nrow(p2),-1]
names(q) <- sep
row.names(q) <- tit[-which(pp==0)]
q1 <- t(q)

write.table(q1,"precios_ns_veb_sep_19.txt")


#OCTUBRE 2019
oct <- c("01/10/2019","02/10/2019","03/10/2019","04/10/2019","07/10/2019",
         "08/10/2019","09/10/2019","10/10/2019","11/10/2019","14/10/2019",
         "15/10/2019","16/10/2019","17/10/2019","18/10/2019","21/10/2019",
         "22/10/2019","23/10/2019","24/10/2019","25/10/2019","28/10/2019",
         "29/10/2019","30/10/2019","31/10/2019")

#leo caracteristicas
ca <- Carac("C:/Users/Ecuad/Downloads/11-10-2019.xls")
names(ca) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
               "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
               "Pago cupon 2","Cupon")

tit <- levels(as.factor(as.character(ca$Nombre[ca$`Tipo Instrumento`=="VEBONO"])))

#busco precio promedio
pp <- pos1(tit,1,Precio_prom_veb)

q1 <- pre_veb(oct,ca)

p2 <- q1

q <- p2[-nrow(p2),-1]
names(q) <- oct
row.names(q) <- tit[-which(pp==0)]
q1 <- t(q)

write.table(q1,"precios_ns_veb_oct_19.txt")

#NOVIEMBRE 2019
nov <- c("01/11/2019","04/11/2019","05/11/2019","06/11/2019","07/11/2019",
         "08/11/2019","11/11/2019","12/11/2019","13/11/2019","14/11/2019",
         "15/11/2019","18/11/2019","19/11/2019","20/11/2019","21/11/2019",
         "22/11/2019","25/11/2019","26/11/2019","27/11/2019","28/11/2019",
         "29/11/2019")

#leo caracteristicas
ca <- Carac("C:/Users/Ecuad/Downloads/07-11-2019.xls")
names(ca) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
               "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
               "Pago cupon 2","Cupon")

tit <- levels(as.factor(as.character(ca$Nombre[ca$`Tipo Instrumento`=="VEBONO"])))

#busco precio promedio
pp <- pos1(tit,1,Precio_prom_veb)

q1 <- pre_veb(nov,ca)

p2 <- q1

q <- p2[-nrow(p2),-1]
names(q) <- nov
row.names(q) <- tit[-which(pp==0)]
q1 <- t(q)

write.table(q1,"precios_ns_veb_nov_19.txt")

#DICIEMBRE 2019
dic <- c("02/12/2019","03/12/2019","04/12/2019","05/12/2019","06/12/2019",
         "09/12/2019","10/12/2019","11/12/2019","12/12/2019","13/12/2019",
         "16/12/2019","17/12/2019","18/12/2019","19/12/2019","20/12/2019",
         "23/12/2019","24/12/2019","25/12/2019","26/12/2019","27/12/2019",
         "30/12/2019","31/12/2019")

#leo caracteristicas
#ca <- Carac("C:/Users/Ecuad/Downloads/30-12-2019.xls")
ca <- Carac("C:/Users/Ecuad/Downloads/07-11-2019.xls")

names(ca) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
               "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
               "Pago cupon 2","Cupon")

tit <- levels(as.factor(as.character(ca$Nombre[ca$`Tipo Instrumento`=="VEBONO"])))

#busco precio promedio
pp <- pos1(tit,1,Precio_prom_veb)

q1 <- pre_veb(dic[1:21],ca)

p2 <- q1

q <- p2[-nrow(p2),-1]
names(q) <- dic[1:21]
row.names(q) <- tit[-which(pp==0)]
q1 <- t(q)

write.table(q1,"precios_ns_veb_dica_19.txt")

#JUNTO TODA LA DATA NS 2019
#VEBONO
ene_19 <- read.csv("~/Riesgo-de-Mercado/precios_ns_veb_ene_19.txt", sep="")
feb_19 <- read.csv("~/Riesgo-de-Mercado/precios_ns_veb_feb_19.txt", sep="")
mar_19 <- read.csv("~/Riesgo-de-Mercado/precios_ns_veb_mar_19.txt", sep="")
abr_19 <- read.csv("~/Riesgo-de-Mercado/precios_ns_veb_abr_19.txt", sep="")
may_19 <- read.csv("~/Riesgo-de-Mercado/precios_ns_veb_may_19.txt", sep="")
jun_19 <- read.csv("~/Riesgo-de-Mercado/precios_ns_veb_jun_19.txt", sep="")
jul_19 <- read.csv("~/Riesgo-de-Mercado/precios_ns_veb_jul_19.txt", sep="")
ago_19 <- read.csv("~/Riesgo-de-Mercado/precios_ns_veb_ago_19.txt", sep="")
sep_19 <- read.csv("~/Riesgo-de-Mercado/precios_ns_veb_sep_19.txt", sep="")
oct_19 <- read.csv("~/Riesgo-de-Mercado/precios_ns_veb_oct_19.txt", sep="")
nov_19 <- read.csv("~/Riesgo-de-Mercado/precios_ns_veb_nov_19.txt", sep="")
dic_19 <- read.csv("~/Riesgo-de-Mercado/precios_ns_veb_dica_19.txt", sep="")

NS_19 <- rbind.data.frame(ene_19,feb_19,mar_19,abr_19,may_19,jun_19,
                          jul_19,ago_19,sep_19,oct_19,nov_19,dic_19)

#
write.table(NS_19,"HIST_VEB_NS_19.txt")




##############
##############
##############
#HISTORICO SVENSSON
##############
##############
##############
#cargo funciones necesarias
source(paste0(getwd(),'/app/funciones.R'))

#Defino función para extraer precios promedio del archivo en la carpeta data
pos1 <- function(t,ind,tif){
  #caso tif
  if(ind==0){
    #tif <- read.csv(paste(getwd(),"data","Precio_prom_tif.txt",sep = "/"),sep="")
    tif$Títulos <- as.character(tif$Títulos)
    p <- c()
    
    #condicional de existencia
    for(i in 1:length(t)){
      if(length(which(t[i]==tif$Títulos))!=0){
        p[i] <- tif$Precio.Promedio[which(t[i]==tif$Títulos)]
      }else{
        #print("Titulo no encontrado")
        p[i] <- 0
      }
    }
    
    names(p) <- t
    return(p)
    
    
  } #final if tif
  
  
  #caso veb
  if(ind==1){
    #veb <- read.csv(paste(getwd(),"data","Precio_prom_veb.txt",sep = "/"),sep="")
    veb <- tif
    veb$Títulos <- as.character(veb$Títulos)
    
    p <- c()
    #condicional de existencia
    for(i in 1:length(t)){
      if(length(which(t[i]==veb$Títulos))!=0){
        p[i] <- veb$Precio.Promedio[which(t[i]==veb$Títulos)]
      }else{
        #print("Titulo no encontrado")
        p[i] <- 0
      }
    } 
    
    names(p) <- t
    return(p)
    
  }
  
  
  
}#final funcion pos1

#precios promedio nuevos
Precio_prom_veb <- read.csv("~/Riesgo-de-Mercado/app/data/Precio_prom_veb.txt", encoding="UTF-8", sep="")



#ENERO 2019
ene <- c("01/01/2019","02/01/2019","03/01/2019","04/01/2019","07/01/2019",
         "08/01/2019","09/01/2019","10/01/2019","11/01/2019","14/01/2019",
         "15/01/2019","16/01/2019","17/01/2019","18/01/2019","21/01/2019",
         "22/01/2019","23/01/2019","24/01/2019","25/01/2019","28/01/2019",
         "29/01/2019","30/01/2019","31/01/2019")

#leo caracteristicas
ca <- Carac("C:/Users/Ecuad/Downloads/30-05-2019.xls")
names(ca) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
               "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
               "Pago cupon 2","Cupon")

tit <- levels(as.factor(as.character(ca$Nombre[ca$`Tipo Instrumento`=="VEBONO"])))

#busco precio promedio
pp <- pos1(tit,1,Precio_prom_veb)

pp[which(pp==0)]


#
#p <- Tabla.sven(fv=ene[1],tit[-which(pp==0)],pos1(tit[-which(pp==0)],1,Precio_prom_veb),pa=c(1,1,1,1,1,1),ind=1,C=ca,fe2=1,fe3=0)[[3]]


p2 <- rep(0,length(tit[-which(pp==0)])+1)

for(i in 1:length(ene)){
  print(i)
  p1 <- try(Tabla.sven(fv=ene[i],tit[-which(pp==0)],pos1(tit[-which(pp==0)],1,Precio_prom_veb),pa=c(1,1,1,1,1,1),ind=1,C=ca,fe2=1,fe3=0)[[3]])
  
  if(!is.null(p1)){
    p2 <- cbind.data.frame(p2,p1$Precios)  
  }else{
    p1 <- rep(0,length(tit[-which(pp==0)])+1)
    p2 <- cbind.data.frame(p2,p1) 
  }
  
}

q <- p2[-nrow(p2),-1]
names(q) <- ene
row.names(q) <- tit[-which(pp==0)]
q1 <- t(q)

write.table(q1,"precios_sven_veb_ene_19.txt")

#CREO FUNCION , QUE SERVIRIA DE ENERO HASTA NOVIEMBRE PARTE1
pre_veb_sv <- function(ene,ca){
  tit <- levels(as.factor(as.character(ca$Nombre[ca$`Tipo Instrumento`=="VEBONO"])))
  
  #busco precio promedio
  pp <- pos1(tit,1,Precio_prom_veb)
  
  #
  p2 <- rep(0,length(tit[-which(pp==0)])+1)
  
  for(i in 1:length(ene)){
    print(i)
    p1 <- try(Tabla.sven(fv=ene[i],tit[-which(pp==0)],pos1(tit[-which(pp==0)],1,Precio_prom_veb),pa=c(1,1,1,1,1,1),ind=1,C=ca,fe2=1,fe3=0)[[3]])
    
    if(!is.null(p1)){
      p2 <- cbind.data.frame(p2,p1$Precios)  
    }else{
      p1 <- rep(0,length(tit[-which(pp==0)])+1)
      p2 <- cbind.data.frame(p2,p1) 
    }
    
  }
  
  # q <- p2[-nrow(p2),-1]
  # names(q) <- ene
  # row.names(q) <- tit[-which(pp==0)]
  # q1 <- t(q)
  return(p2)
}


#FEBRERO 2019
feb <- c("01/02/2019","04/02/2019","05/02/2019","06/02/2019","07/02/2019",
         "08/02/2019","11/02/2019","12/02/2019","13/02/2019","14/02/2019",
         "15/02/2019","18/02/2019","19/02/2019","20/02/2019","21/02/2019",
         "22/02/2019","25/02/2019","26/02/2019","27/02/2019","28/02/2019")

#leo caracteristicas
ca <- Carac("C:/Users/Ecuad/Downloads/30-05-2019.xls")
names(ca) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
               "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
               "Pago cupon 2","Cupon")


tit <- levels(as.factor(as.character(ca$Nombre[ca$`Tipo Instrumento`=="VEBONO"])))

#busco precio promedio
pp <- pos1(tit,1,Precio_prom_veb)


q1 <- pre_veb_sv(feb,ca)

p2 <- q1

q <- p2[-nrow(p2),-1]
names(q) <- feb
row.names(q) <- tit[-which(pp==0)]
q1 <- t(q)

write.table(q1,"precios_sven_veb_feb_19.txt")

#MARZO 2019
mar <- c("01/03/2019","04/03/2019","05/03/2019","06/03/2019","07/03/2019",
         "08/03/2019","11/03/2019","12/03/2019","13/03/2019","14/03/2019",
         "15/03/2019","18/03/2019","19/03/2019","20/03/2019","21/03/2019",
         "22/03/2019","25/03/2019","26/03/2019","27/03/2019","28/03/2019",
         "29/03/2019")

#leo caracteristicas
ca <- Carac("C:/Users/Ecuad/Downloads/30-05-2019.xls")
names(ca) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
               "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
               "Pago cupon 2","Cupon")

tit <- levels(as.factor(as.character(ca$Nombre[ca$`Tipo Instrumento`=="VEBONO"])))

#busco precio promedio
pp <- pos1(tit,1,Precio_prom_veb)


q1 <- pre_veb_sv(mar,ca)

p2 <- q1

q <- p2[-nrow(p2),-1]
names(q) <- mar
row.names(q) <- tit[-which(pp==0)]
q1 <- t(q)

write.table(q1,"precios_sven_veb_mar_19.txt")

#ABRIL 2019
abr <- c("01/04/2019","02/04/2019","03/04/2019","04/04/2019","05/04/2019",
         "08/04/2019","09/04/2019","10/04/2019","11/04/2019","12/04/2019",
         "15/04/2019","16/04/2019","17/04/2019","18/04/2019","19/04/2019",
         "22/04/2019","23/04/2019","24/04/2019","25/04/2019","26/04/2019",
         "29/04/2019","30/04/2019")

#leo caracteristicas
ca <- Carac("C:/Users/Ecuad/Downloads/30-05-2019.xls")
names(ca) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
               "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
               "Pago cupon 2","Cupon")


tit <- levels(as.factor(as.character(ca$Nombre[ca$`Tipo Instrumento`=="VEBONO"])))

#busco precio promedio
pp <- pos1(tit,1,Precio_prom_veb)


q1 <- pre_veb_sv(abr,ca)

p2 <- q1

q <- p2[-nrow(p2),-1]
names(q) <- abr
row.names(q) <- tit[-which(pp==0)]
q1 <- t(q)

write.table(q1,"precios_sven_veb_abr_19.txt")

#MAYO 2019
may <- c("01/05/2019","02/05/2019","03/05/2019","06/05/2019","07/05/2019",
         "08/05/2019","09/05/2019","10/05/2019","13/05/2019","14/05/2019",
         "15/05/2019","16/05/2019","17/05/2019","20/05/2019","21/05/2019",
         "22/05/2019","23/05/2019","24/05/2019","27/05/2019","28/05/2019",
         "29/05/2019","30/05/2019","31/05/2019")


#leo caracteristicas
ca <- Carac("C:/Users/Ecuad/Downloads/30-05-2019.xls")
names(ca) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
               "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
               "Pago cupon 2","Cupon")

tit <- levels(as.factor(as.character(ca$Nombre[ca$`Tipo Instrumento`=="VEBONO"])))

#busco precio promedio
pp <- pos1(tit,1,Precio_prom_veb)


q1 <- pre_veb_sv(may,ca)

p2 <- q1

q <- p2[-nrow(p2),-1]
names(q) <- may
row.names(q) <- tit[-which(pp==0)]
q1 <- t(q)

write.table(q1,"precios_sven_veb_may_19.txt")

#JUNIO 2019
jun <- c("03/06/2019","04/06/2019","05/06/2019","06/06/2019","07/06/2019",
         "10/06/2019","11/06/2019","12/06/2019","13/06/2019","14/06/2019",
         "17/06/2019","18/06/2019","19/06/2019","20/06/2019","21/06/2019",
         "24/06/2019","25/06/2019","26/06/2019","27/06/2019","28/06/2019")

#leo caracteristicas
ca <- Carac("C:/Users/Ecuad/Downloads/30-05-2019.xls")
names(ca) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
               "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
               "Pago cupon 2","Cupon")

tit <- levels(as.factor(as.character(ca$Nombre[ca$`Tipo Instrumento`=="VEBONO"])))

#busco precio promedio
pp <- pos1(tit,1,Precio_prom_veb)


q1 <- pre_veb_sv(jun,ca)

p2 <- q1

q <- p2[-nrow(p2),-1]
names(q) <- jun
row.names(q) <- tit[-which(pp==0)]
q1 <- t(q)

write.table(q1,"precios_sven_veb_jun_19.txt")

#JULIO 2019
jul <- c("01/07/2019","02/07/2019","03/07/2019","04/07/2019","05/07/2019",
         "08/07/2019","09/07/2019","10/07/2019","11/07/2019","12/07/2019",
         "15/07/2019","16/07/2019","17/07/2019","18/07/2019","19/07/2019",
         "22/07/2019","23/07/2019","24/07/2019","25/07/2019","26/07/2019",
         "29/07/2019","30/07/2019","31/07/2019")

#leo caracteristicas
ca <- Carac("C:/Users/Ecuad/Downloads/30-05-2019.xls")
names(ca) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
               "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
               "Pago cupon 2","Cupon")


tit <- levels(as.factor(as.character(ca$Nombre[ca$`Tipo Instrumento`=="VEBONO"])))

#busco precio promedio
pp <- pos1(tit,1,Precio_prom_veb)


q1 <- pre_veb_sv(jul,ca)

p2 <- q1

q <- p2[-nrow(p2),-1]
names(q) <- jul
row.names(q) <- tit[-which(pp==0)]
q1 <- t(q)

write.table(q1,"precios_sven_veb_jul_19.txt")

#AGOSTO 2019
ago <- c("01/08/2019","02/08/2019","05/08/2019","06/08/2019","07/08/2019",
         "08/08/2019","09/08/2019","12/08/2019","13/08/2019","14/08/2019",
         "15/08/2019","16/08/2019","19/08/2019","20/08/2019","21/08/2019",
         "22/08/2019","23/08/2019","26/08/2019","27/08/2019","28/08/2019",
         "29/08/2019","30/08/2019")

#leo caracteristicas
ca <- Carac("C:/Users/Ecuad/Downloads/30-08-2019.xls")
names(ca) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
               "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
               "Pago cupon 2","Cupon")


tit <- levels(as.factor(as.character(ca$Nombre[ca$`Tipo Instrumento`=="VEBONO"])))

#busco precio promedio
pp <- pos1(tit,1,Precio_prom_veb)


q1 <- pre_veb_sv(ago,ca)

p2 <- q1

q <- p2[-nrow(p2),-1]
names(q) <- ago
row.names(q) <- tit[-which(pp==0)]
q1 <- t(q)

write.table(q1,"precios_sven_veb_ago_19.txt")

#SEPTIEMBRE 2019
sep <- c("02/09/2019","03/09/2019","04/09/2019","05/09/2019","06/09/2019",
         "09/09/2019","10/09/2019","11/09/2019","12/09/2019","13/09/2019",
         "16/09/2019","17/09/2019","18/09/2019","19/09/2019","20/09/2019",
         "23/09/2019","24/09/2019","25/09/2019","26/09/2019","27/09/2019",
         "30/09/2019")


#leo caracteristicas
ca <- Carac("C:/Users/Ecuad/Downloads/30-09-2019.xls")
names(ca) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
               "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
               "Pago cupon 2","Cupon")


tit <- levels(as.factor(as.character(ca$Nombre[ca$`Tipo Instrumento`=="VEBONO"])))

#busco precio promedio
pp <- pos1(tit,1,Precio_prom_veb)


q1 <- pre_veb_sv(sep,ca)

p2 <- q1

q <- p2[-nrow(p2),-1]
names(q) <- sep
row.names(q) <- tit[-which(pp==0)]
q1 <- t(q)

write.table(q1,"precios_sven_veb_sep_19.txt")

#OCTUBRE 2019
oct <- c("01/10/2019","02/10/2019","03/10/2019","04/10/2019","07/10/2019",
         "08/10/2019","09/10/2019","10/10/2019","11/10/2019","14/10/2019",
         "15/10/2019","16/10/2019","17/10/2019","18/10/2019","21/10/2019",
         "22/10/2019","23/10/2019","24/10/2019","25/10/2019","28/10/2019",
         "29/10/2019","30/10/2019","31/10/2019")

#leo caracteristicas
ca <- Carac("C:/Users/Ecuad/Downloads/11-10-2019.xls")
names(ca) <- c("Tipo Instrumento","Nombre","Sicet","F.Emision",
               "F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1" ,
               "Pago cupon 2","Cupon")

tit <- levels(as.factor(as.character(ca$Nombre[ca$`Tipo Instrumento`=="VEBONO"])))

#busco precio promedio
pp <- pos1(tit,1,Precio_prom_veb)


q1 <- pre_veb_sv(oct,ca)

p2 <- q1

q <- p2[-nrow(p2),-1]
names(q) <- oct
row.names(q) <- tit[-which(pp==0)]
q1 <- t(q)

write.table(q1,"precios_sven_veb_oct_19.txt")


##############
##############
##############
#HISTORICO DIEBOLD - LI
##############
##############
##############

##############
##############
##############
#HISTORICO SPLINES
##############
##############
##############