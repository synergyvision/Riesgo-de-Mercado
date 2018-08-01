#funcion Precios
#ojo modificar linea 20 - colocar nueva ruta
Preciosbcv=function(ca,dh,ar){
      b5=array()
      print(ca)
      print(ar)
 
      for(i in dh){
           nn=0
              if(i<10){ #IF MENOR A 10   
                    m1=paste("022 0",i,sep="")
                    m2=paste(m1,ca,sep = "-")
                    fe.=paste(ca,"2017",sep="/")
                    #fe=paste(i,"01/2017",sep = "/")
                    fe=paste(i,fe.,sep = "/")
                    fe1=paste(0,fe,sep = "")
                    #m2=paste(m1,"02",sep = "-")
                    #fe=paste(i,"02/2017",sep = "/")
                    #print(m2)
                    #b=try(read.xlsx("C:/Users/ftapia/Documents/DESCARGAS R/0-22-Enero.xls", sheetName = m2,startRow = 10,colIndex = 1:9,header = TRUE),silent = T)
                    ar1=paste("C:/Users/ftapia/Documents/DESCARGAS R",ar,sep = "/")
                    #ar1=paste("T:/Riesgos/Intercambio/Coordinacion de Riesgo de Mercado, Liquidez y Tasas de Interes/RIESGO DE MERCADO/Curvas/Curvas R-EXCEL",ar,sep = "/")
                    b=try(read.xlsx(ar1, sheetName = m2,startRow = 10,colIndex = 1:9,header = TRUE),silent = T)
                    #b=try(read.xlsx("C:/Users/ftapia/Documents/DESCARGAS R/0-22.xls", sheetName = m2,startRow = 10,colIndex = 1:9,header = TRUE),silent = T)
                    
                          if(class(b)=="try-error"){ #IF ESPACIO
                            print("hay un espacio" )
                            m3=paste(m2,"",sep = " ")
                            #b=try(read.xlsx("C:/Users/ftapia/Documents/DESCARGAS R/0-22-Enero.xls", sheetName = m3,startRow = 10,colIndex = 1:9,header = TRUE),silent = T)
                            ar1=paste("C:/Users/ftapia/Documents/DESCARGAS R",ar,sep = "/")
                            b=try(read.xlsx(ar1, sheetName = m3,startRow = 10,colIndex = 1:9,header = TRUE),silent = T)
                            #b=try(read.xlsx("C:/Users/ftapia/Documents/DESCARGAS R/0-22.xls", sheetName = m3,startRow = 10,colIndex = 1:9,header = TRUE),silent = T)
                            
                                  #if 
                                  if(class(b)=="try-error"){
                                    print("el doc 0-22 no corresponde con el mes ingresado o existe un problema con el nombre de la pestaña" )
                                    print("Favor Revisar el dia")
                                    print(i)
                                  }
                                  
                            
                                  #if(length(b$Instrumento.)!=1){
                                  if(is.na(b$X.En.BolÃ.vares.[1])!=T){ 
                                    
                                    b1=b[-which(is.na(b$Instrumento.)),]
                                    
                                    #filtro para cuando no haya TICC
                                    if(length(which(is.na(b1$Prom.)))!=0){
                                      b2=b1[-which(is.na(b1$Prom.)),]
                                      #s1=b2$Instrumento.[10]
                                      #final data.frame dia 23-02 
                                      b3=b2[-which(b2$Instrumento.=="Instrumento "),]
                                      b3.=rep(fe1,length(b3$Instrumento.))
                                      b4=cbind(b3.,b3)
                                      b5=rbind(b5,b4)
                                      #b5=rbind(b4,t(data.frame(rep(0,1,10))))
                                      b5$CupÃ³n....[which(substr(b5$Instrumento.,1,3)=="LTB")]=0
                                      b5=faux(b5)
                                    }
                                    
                                    if(length(which(is.na(b1$Prom.)))==0){
                                      b3.=rep(fe1,length(b1$Instrumento.))
                                      b4=cbind(b3.,b1)
                                      b5=rbind(b5,b4)
                                      b5$CupÃ³n....[which(substr(b5$Instrumento.,1,3)=="LTB")]=0
                                      b5=faux(b5)
                                    }
                                     nn=nn+1
                                  }
                            
                                  #if(length(b$Instrumento.)==1){
                                  if(is.na(b$X.En.BolÃ.vares.[1])==T){ 
                                    
                                    #caso en que no hay operaciones
                                    print("No hubo operacion el dia ")
                                    print(i)
                                
                                  }
                            
                          }#final if espacio
                    #caso normal
                    
                    #if(length(b$Instrumento.)!=1){
                    if(is.na(b$X.En.BolÃ.vares.[1])!=T & nn==0){  
                     
                    b1=b[-which(is.na(b$Instrumento.)),]
                      
                          #filtro para cuando no haya TICC
                          if(length(which(is.na(b1$Prom.)))!=0){
                            b2=b1[-which(is.na(b1$Prom.)),]
                            #s1=b2$Instrumento.[10]
                            #final data.frame dia 23-02 
                            b3=b2[-which(b2$Instrumento.=="Instrumento "),]
                            b3.=rep(fe1,length(b3$Instrumento.))
                            b4=cbind(b3.,b3)
                            b5=rbind(b5,b4)
                            #b5=rbind(b4,t(data.frame(rep(0,1,10))))
                            b5$CupÃ³n....[which(substr(b5$Instrumento.,1,3)=="LTB")]=0
                            b5=faux(b5)
                          }
                          
                          if(length(which(is.na(b1$Prom.)))==0){
                            b3.=rep(fe1,length(b1$Instrumento.))
                            b4=cbind(b3.,b1)
                            b5=rbind(b5,b4)
                            b5$CupÃ³n....[which(substr(b5$Instrumento.,1,3)=="LTB")]=0
                            b5=faux(b5)
                          }
                    }
                    
                    #if(length(b$Instrumento.)==1){
                      if(is.na(b$X.En.BolÃ.vares.[1])==T){ 
                      #caso en que no hay operaciones
                      print("No hubo operacion el dia ")
                      print(i)
                    }
                   
              }#final if < 10
    
            if(i>=10){ #IF MAYOR A 10    
              m1=paste("022 ",i,sep="")
              m2=paste(m1,ca,sep = "-")
              fe.=paste(ca,"2017",sep="/")
              #fe=paste(i,"01/2017",sep = "/")
              fe=paste(i,fe.,sep = "/")
              #m2=paste(m1,"02",sep = "-")
              #fe=paste(i,"02/2017",sep = "/")
              #print(m2)
              #b=try(read.xlsx("C:/Users/ftapia/Documents/DESCARGAS R/0-22-Enero.xls", sheetName = m2,startRow = 10,colIndex = 1:9,header = TRUE),silent = T)
              #print(class(b))
              ar1=paste("C:/Users/ftapia/Documents/DESCARGAS R",ar,sep = "/")
              b=try(read.xlsx(ar1, sheetName = m2,startRow = 10,colIndex = 1:9,header = TRUE),silent = T)
              #b=try(read.xlsx("C:/Users/ftapia/Documents/DESCARGAS R/0-22.xls", sheetName = m2,startRow = 10,colIndex = 1:9,header = TRUE),silent = T)
              
              if(class(b)=="try-error"){ #IF ESPACIO
                        print("hay un espacio" )
                        m3=paste(m2,"",sep = " ")
                        #b=try(read.xlsx("C:/Users/ftapia/Documents/DESCARGAS R/0-22-Enero.xls", sheetName = m3,startRow = 10,colIndex = 1:9,header = TRUE),silent = T)
                        ar1=paste("C:/Users/ftapia/Documents/DESCARGAS R",ar,sep = "/")
                        b=try(read.xlsx(ar1, sheetName = m3,startRow = 10,colIndex = 1:9,header = TRUE),silent = T)
                        #b=try(read.xlsx("C:/Users/ftapia/Documents/DESCARGAS R/0-22.xls", sheetName = m3,startRow = 10,colIndex = 1:9,header = TRUE),silent = T)
                        #if 
                              if(class(b)=="try-error"){
                                print("el doc 0-22 no corresponde con el mes ingresado o existe un problema con el nombre de la pestaña" )
                                print("Favor Revisar el dia")
                                print(i)
                                }
                              
                              #if(length(b$Instrumento.)!=1){
                                if(is.na(b$X.En.BolÃ.vares.[1])!=T){  
                                
                                  b1=b[-which(is.na(b$Instrumento.)),]
                                
                                #filtro para cuando no haya TICC
                                if(length(which(is.na(b1$Prom.)))!=0){
                                  b2=b1[-which(is.na(b1$Prom.)),]
                                  #s1=b2$Instrumento.[10]
                                  #final data.frame dia 23-02 
                                  b3=b2[-which(b2$Instrumento.=="Instrumento "),]
                                  b3.=rep(fe,length(b3$Instrumento.))
                                  b4=cbind(b3.,b3)
                                  b5=rbind(b5,b4)
                                  #b5=rbind(b4,t(data.frame(rep(0,1,10))))
                                  b5$CupÃ³n....[which(substr(b5$Instrumento.,1,3)=="LTB")]=0
                                  b5=faux(b5)
                                }
                                
                                if(length(which(is.na(b1$Prom.)))==0){
                                  b3.=rep(fe,length(b1$Instrumento.))
                                  b4=cbind(b3.,b1)
                                  b5=rbind(b5,b4)
                                  b5$CupÃ³n....[which(substr(b5$Instrumento.,1,3)=="LTB")]=0
                                  b5=faux(b5)
                                }
                                  nn=nn+1
                              }
                              
                              #if(length(b$Instrumento.)==1){
                              if(is.na(b$X.En.BolÃ.vares.[1])==T){ 
                               #caso en que no hay operaciones
                                print("No hubo operacion el dia ")
                                print(i)
                              }
                
              }#final if espacio
              
                       #CASO NORMAL
                          #if(length(b$Instrumento.)!=1){
                                  if(is.na(b$X.En.BolÃ.vares.[1])!=T & nn==0){ 
                                   
                                    b1=b[-which(is.na(b$Instrumento.)),]
                                    
                                        #filtro para cuando no haya TICC
                                        if(length(which(is.na(b1$Prom.)))!=0){
                                          b2=b1[-which(is.na(b1$Prom.)),]
                                          #s1=b2$Instrumento.[10]
                                          #final data.frame dia 23-02 
                                          b3=b2[-which(b2$Instrumento.=="Instrumento "),]
                                          b3.=rep(fe,length(b3$Instrumento.))
                                          b4=cbind(b3.,b3)
                                          b5=rbind(b5,b4)
                                          #b5=rbind(b4,t(data.frame(rep(0,1,10))))
                                          b5$CupÃ³n....[which(substr(b5$Instrumento.,1,3)=="LTB")]=0
                                          b5=faux(b5)
                                        }
                                        
                                        if(length(which(is.na(b1$Prom.)))==0){
                                          b3.=rep(fe,length(b1$Instrumento.))
                                          b4=cbind(b3.,b1)
                                          b5=rbind(b5,b4)
                                          b5$CupÃ³n....[which(substr(b5$Instrumento.,1,3)=="LTB")]=0
                                          b5=faux(b5)
                                        }
                                    
                                  }
                                  
                                  #if(length(b$Instrumento.)==1){
                                  if(is.na(b$X.En.BolÃ.vares.[1])==T){
                                    #caso en que no hay operaciones
                                    print("No hubo operacion el dia ")
                                    print(i)
                                  }
                    
              }#final if > 10
            
    }#final for
 
  if(nrow(b5)!=1){
  b6=b5[-1,]
  
  #b6$CupÃ³n....[which(substr(b6$Instrumento.,1,3)=="LTB")]=0

  #b6$X.En.BolÃ.vares.=as.numeric(b6$X.En.BolÃ.vares.)
  #sustituyo "," por punto para luego convertir el valor en numero
  #b6$X.En.dias.=as.numeric(sub(",",".",b6$X.En.dias.))
  #b6$X.Operac.=as.numeric(sub(",",".",b6$X.Operac.))
  #b6$MÃ.nimo=as.numeric(sub(",",".",b6$MÃ.nimo))
  #b6$MÃ.ximo=as.numeric(sub(",",".",b6$MÃ.ximo))
  #b6$Prom.=as.numeric(sub(",",".",b6$Prom.))
  b6=faux(b6)
  
  return(b6)}else{
    print("No hay documento disponible")
  } 
}#final funcion

#funcion auxiliar
faux=function(b6){
  b6$X.En.BolÃ.vares.=as.numeric(sub(",",".",b6$X.En.BolÃ.vares.))
  b6$X.En.dias.=as.numeric(sub(",",".",b6$X.En.dias.))
  b6$X.Operac.=as.numeric(sub(",",".",b6$X.Operac.))
  b6$MÃ.nimo=as.numeric(sub(",",".",b6$MÃ.nimo))
  b6$MÃ.ximo=as.numeric(sub(",",".",b6$MÃ.ximo))
  b6$Prom.=as.numeric(sub(",",".",b6$Prom.))
  b6$CupÃ³n....=as.numeric(sub(",",".",b6$CupÃ³n....))
  return(b6)
}


#funcion Carateristicas
Carac=function(ruta){
  #c=read.xlsx("C:/Users/ftapia/Documents/DESCARGAS R/Caracteristicas.xls", sheetName = "DPN",startRow = 7,colIndex = 1:15,header = TRUE)
  #c=read.xlsx("C:/Users/Nancy/Desktop/Modelos Aleatorios/prueba 190717/Caracteristicas.xls", sheetName = "DPN",startRow = 7,colIndex = 1:15,header = TRUE)
  c=read.xlsx(ruta, sheetName = "DPN",startRow = 7,colIndex = 1:15,header = TRUE)
  c1=c[,c(3,5,6,8,10,11,13,15)]
  c2=c1[-which(is.na(c1$X...)),]
  c3=cbind(as.character(rep("TIF",1,length(c2$X...))),c2)
  c3$`as.character(rep("TIF", 1, length(c2$X...)))`=as.character(c3$`as.character(rep("TIF", 1, length(c2$X...)))`)
  c3$`as.character(rep("TIF", 1, length(c2$X...)))`[which(c3$Referencia...b_..!="Tasa Fija")]="VEBONO"
  names(c3)=c("Tipo Instrumento","Sicet","F.Emision","F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1","Pago cupon 2","Cupon")
  
  #tranformo formato fecha
  c3$F.Emision=format(c3$F.Emision,"%d/%m/%Y")
  c3$F.Vencimiento=format(c3$F.Vencimiento,"%d/%m/%Y")
  c3$`Pago cupon 1`=format(c3$`Pago cupon 1`,"%d/%m/%Y")
  c3$`Pago cupon 2`=format(c3$`Pago cupon 2`,"%d/%m/%Y")
  
  #agrego columna Nombre TIf o Vebono + fecha venc
  c4=c3$`Tipo Instrumento`
  
  Nombre=c()
  for(i in 1:length(c4)){
    Nombre[i]=paste(c4[i],paste(substr(c3$F.Vencimiento[i],4,5),substr(c3$F.Vencimiento[i],7,10),sep = ""),sep = "")
  }
  
  c3=cbind(c3$`Tipo Instrumento`,Nombre,c3[,2:ncol(c3)])
  names(c3)[1]="Tipo Instrumento"
  
  #pestaña DPN-TICC
  #d=read.xlsx("C:/Users/Nancy/Desktop/Modelos Aleatorios/prueba 190717/Caracteristicas.xls", sheetName = "DPN - TICC",startRow = 7,colIndex = 1:14,header = TRUE)
  d=read.xlsx(ruta, sheetName = "DPN - TICC",startRow = 7,colIndex = 1:14,header = TRUE)
  
  #d=read.xlsx("C:/Users/ftapia/Documents/DESCARGAS R/Caracteristicas.xls", sheetName = "DPN - TICC",startRow = 7,colIndex = 1:14,header = TRUE)
  
  d=d[-which(is.na(d[,2])),c(3,4,5,7,9,10,12,14)]
  #cambio formato fechas
  d[,2]=format(d[,2],"%d/%m/%Y")
  d[,3]=format(d[,3],"%d/%m/%Y")
  d[,6]=format(d[,6],"%d/%m/%Y")
  d[,7]=format(d[,7],"%d/%m/%Y")
  
  d1=rep("TICC",1,nrow(d))
  
  d2=c()
  for(i in 1:length(d1)){
    d2[i]=paste(d1[i],paste(substr(d[i,3],4,5),substr(d[i,3],7,10),sep = ""),sep = "")
  }
  
  d3=cbind(d1,d2,d)
  names(d3)=names(c3) 

  #Añado nuevo titulo VF
  #v=read.xlsx("C:/Users/ftapia/Documents/DESCARGAS R/Caracteristicas.xls", sheetName = "VF",startRow = 7,colIndex = 1:14,header = TRUE)
  v=read.xlsx(ruta, sheetName = "VF",startRow = 7,colIndex = 1:14,header = TRUE)
  v=v[-which(is.na(v[,2])),c(3,4,5,7,9,10,12,14)]
  #cambio formato fechas
  v[,2]=format(v[,2],"%d/%m/%Y")
  v[,3]=format(v[,3],"%d/%m/%Y")
  v[,6]=format(v[,6],"%d/%m/%Y")
  v[,7]=format(v[,7],"%d/%m/%Y")
  
  v1=rep("Valores Fin.",1,nrow(v))
  
  v2=c()
  for(i in 1:length(v1)){
    v2[i]=paste(v1[i],paste(substr(v[i,3],4,5),substr(v[i,3],7,10),sep = ""),sep = "")
  }
  
  v3=cbind(v1,v2,v)
  names(v3)=names(c3) 
  
  
  
  #CARACTERISTICAS DEFINITIVA
  C3=rbind(c3,d3,v3) 
  
  #En caso que no lea bien un numero
  C3$Cupon=as.numeric(sub(",",".",C3$Cupon))
  
  return(C3)
} #final funcion Caracteristicas

#Funcion Formato

formatop=function(C3,b3){
  
  #en caso de Haber letras pongo cupon 0
  if(length(which(substr(b3$Instrumento.,1,3)=="LTB"))!=0){
  b3$CupÃ³n....[which(substr(b3$Instrumento.,1,3)=="LTB")]=0
  }
  
  #traigo la fecha de vencimiento
  b3$Vencimiento=as.character(b3$Vencimiento)
  
  for(i in 1:length(b3$b3.)){
    if(substr(b3$Instrumento.[i],1,3)!="LTB"){
    #which(as.character(b3$Instrumento.[i])==as.character(c3$Sicet))
    b3$Vencimiento[i]=C3$F.Vencimiento[which(as.character(b3$Instrumento.[i])==as.character(C3$Sicet))]
    }else{ 
      b3$Vencimiento[i]=as.character(format(as.Date("1900-01-01")+as.numeric(b3$Vencimiento[i])-2,"%d/%m/%Y"))
      }
    }
  
  #traigo si es TIF , VEBONO o TICC
  b3.=cbind(as.character(rep("TIF",1,length(b3$b3.))),b3)
  b3.$`as.character(rep("TIF", 1, length(b3$b3.)))`=as.character(b3.$`as.character(rep("TIF", 1, length(b3$b3.)))`)
  
  for(i in 1:length(b3.$b3.)){
    if(substr(b3$Instrumento.[i],1,3)!="LTB"){
    b3.$`as.character(rep("TIF", 1, length(b3$b3.)))`[i]=as.character(C3$`Tipo Instrumento`[which(as.character(b3.$Instrumento.[i])==as.character(C3$Sicet))])
    }else{
      b3.$`as.character(rep("TIF", 1, length(b3$b3.)))`[i]="LETRA"
      
    }
  }
  
  #fuente
  p=as.character(rep("022 BCV",1,length(b3.$b3.)))
  
  B3=cbind(b3.[,c(1,2)],p,b3.[,3:ncol(b3.)])
  
  #traigo columna Nombre de las caracteristicas
  nom=c()
  
  for(i in 1:nrow(B3)){
    if(substr(b3$Instrumento.[i],1,3)!="LTB"){
    nom[i]=as.character(C3$Nombre[which(as.character(B3$Instrumento.[i])==C3$Sicet)])
    }else{
      n1=substr(b3.$Vencimiento[i],4,5)
      n2=substr(b3.$Vencimiento[i],7,10)
      
      nom[i]=paste("LTB",n1,n2,sep="")
    }
     }
  
  #frecuencia y rendimiento
  fre=rep(0,1,length(b3.$b3.))
  rend=rep(0,1,length(b3.$b3.))
  
  B3=cbind(B3[,1],nom,B3[,2:ncol(B3)],fre,rend)
  names(B3)=c("Tipo Instrumento","Nombre","Fecha op","Fuente","Sicet","F.Vencimiento","Plazo","Op","Monto","Pre min","Pre max","Pre prom","Cupon","Frecuencia","Rendimiento")
  
  #añado criterio de que si en caraceristica dice 91 dias es freq=4 si es 182 freq=2
  for(i in 1:length(B3$`Tipo Instrumento`)){
    if(substr(B3$Sicet[i],1,3)!="LTB"){
    if(substr(as.character(C3$Inicio[which(as.character(B3$Sicet[i])==C3$Sicet)]),6,8)=="91 "){
      B3$Frecuencia[i]=4
    }
    if(substr(as.character(C3$Inicio[which(as.character(B3$Sicet[i])==C3$Sicet)]),6,8)=="180" |substr(as.character(C3$Inicio[which(as.character(B3$Sicet[i])==C3$Sicet)]),6,8)=="182"){
      B3$Frecuencia[i]=2
    }
    }
  }
  
  #añado rendimiento que es la formula RENDTO de excel con base 0
  for(i in 1:nrow(B3)){
    if(substr(B3$Sicet[i],1,3)!="LTB"){
  #B3$Rendimiento=bond.yields(as.Date(B3$`Fecha op`,"%d/%m/%Y"),as.Date(B3$F.Vencimiento,"%d/%m/%Y"),(B3$Cupon/100), B3$Frecuencia,B3$`Pre prom`,convention = c("30/360"),B3$Frecuencia)*100
      B3$Rendimiento[i]=bond.yield(as.Date(B3$`Fecha op`[i],"%d/%m/%Y"),as.Date(B3$F.Vencimiento[i],"%d/%m/%Y"),(B3$Cupon[i]/100), B3$Frecuencia[i],B3$`Pre prom`[i],convention = c("ACT/360"),B3$Frecuencia[i])*100
    }
    if(substr(B3$Sicet[i],1,3)=="LTB"){
      #B3$Rendimiento=bond.yields(as.Date(B3$`Fecha op`,"%d/%m/%Y"),as.Date(B3$F.Vencimiento,"%d/%m/%Y"),(B3$Cupon/100), B3$Frecuencia,B3$`Pre prom`,convention = c("30/360"),B3$Frecuencia)*100
      B3$Rendimiento[i]=bond.yield(as.Date(B3$`Fecha op`[i],"%d/%m/%Y"),as.Date(B3$F.Vencimiento[i],"%d/%m/%Y"),0, 0.001,B3$`Pre prom`[i],convention = c("ACT/360"),0)*100
    }
  }
  
  return(B3)
}#final funcion formato precios 022

#FUNCION CRITERIO
crit=function(CRF){
  names(CRF)=c("Nombre.corto","Fechaop","Fuente","ISIN","Vencimiento","Plazo","Operac.","Nominal","Mínimo","Máximo","Prom.","Cupón","Frecuencia","Rendimiento")
  #ordeno el dat frame segun el codigo sicet
  crf1=sort.data.frame(CRF,~ISIN)
  
  #cambio formato fecha de operacion
  crf1$Fechaop=as.Date(crf1$Fechaop,format="%d/%m/%Y")
  
  #observo cuantos titulos hay
  (a=length(levels(crf1$ISIN)))
  (a1=levels(crf1$ISIN))
  
  #a6=data.frame(t(rep(0,ncol(crf1))))
  #names(a6)=names(crf1)
  a6=c()
  
  #ordeno segun titulo, y por fecha de operacion
  for(i in 1:a){
    a2=which(crf1$ISIN==a1[i])
    #print(a2)
    #a5=sort.data.frame(crf1[a2,],~-Fechaop)
    a5.=sort(crf1$Fechaop[a2],decreasing = TRUE)
    #
    ind=c()
    for(j in 1:length(a5.)){
      ind=c(ind,which(a5.[j]==crf1$Fechaop[a2]))
    }
    #
    a5=crf1[a2[ind],]
    #print(a5)
    #a6=rbind(a6,a5)
    a6=rbind.data.frame(a6,a5)
  }
  
  #a6=a6[-1,]
  
  #FILTRO 1
  #elimino operaciones con un monto menor a 10.000.000
  if(length(which(a6$Nominal<10000000))!=0){
  (b=which(a6$Nominal<10000000))
  a7=a6[-b,]
  }else{a7=a6}
  
  #FILTRO 2
  #extraigo aquellos titulos que tengan una sola operacion 
  (g=levels(as.factor(a7$ISIN)))
  x=0
  for(i in 1:length(g)){
    g1=length(which(g[i]==a7$ISIN))
    if(g1==1){
      x=c(x,i)
    }
  }
  (x=x[-1])
  
  if(length(x)!=0){
  
  (g2=g[x])
  x1=0
  
  for(i in 1:length(g2)){
    x1=c(x1,which(g2[i]==a7$ISIN))
  }
  (x1=x1[-1])
  
  d=a7[x1,]
  
  #nueva data sin titulos anteriores (los que tienen una sola operacion)
  a8=a7[-x1,]}else{a8=a7}
  
  #FILTRO 3 verificacio de si titulo tienen igual fecha SUBASTA predomina
  (c=levels(as.factor(a8$Fuente)))
  (z=levels(as.factor(a8$ISIN)))
  z3=c()
  
  for(i in 1:length(z)){
    #
    if(length(which(z[i]==a8$ISIN))!=0){
    z1=which(z[i]==a8$ISIN)
    #comparo fechas 
    if(a8$Fechaop[z1[1]]>a8$Fechaop[z1[2]]){
      #print('caso mayor que')
      #si una es mayor que la otra tomo la mas grande
      #print(z1[1])
      z3=c(z3,z1[1])
    }
    #si no se cumple es que son iguales, asi que elijo la de subasta!
    if(a8$Fechaop[z1[1]]==a8$Fechaop[z1[2]]){
      #print('caso igualdad')
      z2=which(a8$Fuente[z1]==c[2])
      #print(z1[z2])
      z3=c(z3,z1[z2])
    }
  }
  } #fin
  #de esta manera obtengo z3 que son los titulos que considerare, luego de 
  #los 3 filtros anteriores  
  
  #data frame final
  d=rbind(d,a8[z3,])
  
  #asigno a data inicial CRF una columna de ceros
  CRFF=cbind(CRF,Decision=rep(0,nrow(CRF)))
  
  s1=c()
  for (i in 1:length(d$Plazo)){
    s=which(d$Plazo[i]==CRFF$Plazo & d$Rendimiento[i]==CRFF$Rendimiento)
    s1=c(s1,s)
  }
  
  CRFF$Decision[s1]=1
  
  for(i in 1:nrow(CRFF)){
    if(CRFF$Rendimiento[i]<0){
      CRFF$Decision[i]=0
    }
  }
  
  return(CRFF)
  
}#final funcion criterio

#funcion precios
precio=function(tit,spline1,fv,C){
  
  Pr=c()
  #print(fv)
  for(j in 1:length(tit)){
    
    # print(j)
    
    (n=which(C$Nombre==tit[j]))
    (n1=as.Date(C$`Pago cupon 1`[n],format="%d/%m/%Y"))
    
    if(as.numeric(n1-fv)<0){
      (n1=as.Date(C$`Pago cupon 2`[n],format="%d/%m/%Y"))
    }
    
    #
    
    (n2=as.Date(C$F.Vencimiento[n],format="%d/%m/%Y"))
    (n3=as.numeric(n2-n1))
    
    #creo vector del tamaño de 1 + division de n3/91
    #print("Le quedan")
    #print(1+(n3/91))
    #print("cupones por pagar")
    
    
    n4=n1
    #n4[1]=as.Date(n1,format="%d/%m/%Y")
    
    n5=rep(91,(n3/91))
    for(i in 1:(n3/91)){
      n4=unique(c(n4,n4+n5[i]))
    }
    
    #vector de fechas de los flujos
    #(n4=unique(n4))
    
    #valores a predecir mediante el Spline
    (n5=as.numeric(n4-fv))
    
    n6=predict(spline1,n5)
    (n6=n6$y/100)
    
    #calculo exponencial
    (n7=exp(-(n5/365)*n6))
    
    #cupon 
    (n8=rep(C$Cupon[n]/4,(n3/91)))
    
    (n9=c(n8,C$Cupon[n]/4+100))
    
    #(n9=unique(n9))
    
    #PRECIO ESTIMADO
    (n10=sum(n7*n9))
    
    Pr[j]=n10
    
    
  } 
  
  return(Pr)
  
}#final funcion precios estimados


