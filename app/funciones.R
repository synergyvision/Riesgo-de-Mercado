#funciones y paquetes necesarios
source('C:/Users/Freddy Tapia/Desktop/Svensson/orden data frame.R')
source('C:/Users/Freddy Tapia/Desktop/Svensson/fprecios022T.R')

#cargo librerias a usar
library(jrvFinance)
library(xlsx)
library(nloptr)
library(alabama)
options(OutDec = ",")

#DEFINO OTRAS FUNCIONES
#funcion rend cero cupon
#funcion que calcula el rendimiento cero cupon 
#mediante la met Svensson, para unos parametros dados
#y un tiempo t especifico que se deriva de la fecha de pago de cupon
#ARGUMENTOS
#pa: vector de 6 parametros B0, B1, B2, B3, T1 y T2
#los cuales estan sujetos a ciertas restricciones
#B0 > 0
#B0 + B1 > 0
#T1 > 0, T2 > 0
#t: tiempo 
sven=function(pa,t){
  r=pa[1]+((pa[2]+pa[3])*(1-exp((-t)/(pa[5])))/(t/pa[5]))-
    pa[3]*exp(-t/pa[5])+(pa[4]*(1-exp((-t)/(pa[6])))/(t/pa[6]))-
    pa[4]*exp(-t/pa[6])
  return(r)
}

#funcion precios estimados
#Calcula el precio de los titulos considerados mediante 
#la metodologia de Svensson
#ARGUMENTOS
#tit: t�???tulo o t�???tulos a considerar, debe ser el nombre corto
#ej: TIF082018 (OJO, mejor considerar el ISIN)
#fv: fecha de valoración, ej: "11/08/2017"
#C: documento de las caracteristicas, que previamente ya ha sido
#leido mediante la funcion "Carac"
#pa: parametros Svensson
precio.sven=function(tit,fv,C,pa){
  #creo variable vacia
  Pr=c()
  
  for(j in 1:length(tit)){
    #verifico en que posicion de la variable c se encuentra el i-esimo titulo
    (n=which(C$Nombre==tit[j]))
    #Extraigo la proxima fecha de pago de cupon (pago cupon 1, fecha inicial
    #cuando el  titulo debe pagar cupon)
    (n1=as.Date(C$`Pago cupon 1`[n],format="%d/%m/%Y"))
    
    #verifico si esta fecha es menor que la fecha de valoracion,
    #de ser asi tomo la fecha de cupon 2 (fecha final cuando el titulo debe 
    #pagar cupon)
    if(as.numeric(n1-fv)<0){
      (n1=as.Date(C$`Pago cupon 2`[n],format="%d/%m/%Y"))
    }
    
    #extraigo la fecha de vencimiento del i-esimo titulo
    (n2=as.Date(C$F.Vencimiento[n],format="%d/%m/%Y"))
    
    #creo variable para determinar diferencia entre fecha de vencimiento y
    #la fecha cupon
    (n3=as.numeric(n2-n1))
    
    #si este valor es cero, entonces en este
    #caso queda 1 solo cupon
    if(n3==0){
      #print("Al titulo")
      #print(tit[j])
      #print("Le queda un cupon por pagar")
      #reasigno variable
      (n4=n1)
      #creo vector de fechas
      (n6=c(fv,n4))
      
      #valor t años
      #creo vector de tiempos
      (f1=c(0.000000001,(as.numeric(n6[2]-n6[1])/360)+0.000000001))
      
      #rendimiento cero cupon
      #calculo rendimientos cero cupon, para cada tiempo del vector creado
      #anteriormente
      (pa1=c(sven(pa,f1[1]),sven(pa,f1[2])))
      
      #exp del producto
      (ep=exp(-pa1*f1))
      
      #cupon
      cu=c(0,100+C$Cupon[n]/4)
      
      #precio
      #calculo precio usando una suma producto
      (Pr[j]=sum(cu*ep))
      #return(Pr)
    }else{ #final if 1 cupon
      #reasigno variable
      n4=n1
      
      #creo variable,  que me determina cuantos cupones le queda por pagar al
      #i-esimo titulo
      n5=rep(91,(n3/91))
      #creo vector de fechas
      for(i in 1:(n3/91)){
        n4=unique(c(n4,n4+n5[i]))
      }
      
      #depuro vector de fechas
      (n5=unique(c(fv,n4)))
      
      #valor t años
      #creo vector de tiempos
      ti=0.000000001
      (f1=rep(0,length(n5)))
      f1[1]=ti
      
      for(i in 2:length(n5)){
        f1[i]=(as.numeric(n5[i]-n5[i-1])/360)+f1[i-1]
      }
      
      #calculo rend cero cupon
      (pa1=rep(0,length(n5)))
      
      for(i in 1:length(n5)){
        pa1[i]=sven(pa,f1[i])
      }
      
      #exponencial del producto
      (ep=exp(-pa1*f1))
      
      
      #cupon 
      (cu=rep(0,length(n5)))
      for(i in 2:(length(n5)-1)){
        cu[i]=C$Cupon[n]/4
      }
      cu[length(n5)]=C$Cupon[n]/4+100
      
      
      #PRECIO ESTIMADO
      (n10=sum(cu*ep))
      
      Pr[j]=n10
    } 
    
  }#final for 
  
  #retorno precios
  return(Pr)
  
}#final funcion precios estimados


#Funcion que calcula precios de los titulos considerados
#y exporta una tabla con los resultados, donde es posible 
#optimizar los precios dados inicialmente, de tal manera
#que se asemejen los más posible a los precios promedio ingresados
#ARGUMENTOS
#fv: fecha de valoración, ej: "11/08/2017"
#tit: t�???tulo o t�???tulos a considerar, debe ser el nombre corto
#ej: TIF082018 (OJO, mejor considerar el ISIN)
#pr: vector de precios promedios
#pa: parametros Svensson
#ind: 0 = Tif o 1 = veb
#C: documento de las caracteristicas, que previamente ya ha sido
#leido mediante la funcion "Carac"
Tabla.sven=function(fv,tit,pr,pa,ind,C){
  #Creo data frame donde guardare calculo
  Tabla=as.data.frame(matrix(0,14,length(tit)))
  colnames(Tabla)=tit
  rownames(Tabla)=c("ISIN","Fecha de Liquidación",
                    "Fecha de emisión","Fecha de Vencimiento","Tasa de Cupón",
                    "Precio Prom","Fecha último Pago","Fecha próximo pago",
                    "RDTO al VMTO","Duración","Inverso de la duración",
                    "Ponderación","Precio Modelo Svensson Ajustado",
                    "Residuos al cuadrado")
  
  #relleno ISIN
  for(i in 1:ncol(Tabla)){
    Tabla[1,i]=as.character(C$Sicet[which(names(Tabla)[i]==C$Nombre)])
  }
  
  #relleno fecha Liquidación
  for(i in 1:ncol(Tabla)){
    Tabla[2,i]=fv
  }
  
  #relleno fecha Emision
  for(i in 1:ncol(Tabla)){
    Tabla[3,i]=as.character(C$F.Emision[which(names(Tabla)[i]==C$Nombre)])
  }
  
  #relleno fecha Vencimiento
  for(i in 1:ncol(Tabla)){
    Tabla[4,i]=as.character(C$F.Vencimiento[which(names(Tabla)[i]==C$Nombre)])
  }
  
  #relleno cupón
  for(i in 1:ncol(Tabla)){
    Tabla[5,i]=C$Cupon[which(names(Tabla)[i]==C$Nombre)]/100
  }
  
  #relleno fecha ultimo pago
  for(i in 1:ncol(Tabla)){
    Tabla[7,i]=as.character(C$`Pago cupon 1`[which(names(Tabla)[i]==C$Nombre)])
  }
  
  #relleno proximo pago
  for(i in 1:ncol(Tabla)){
    Tabla[8,i]=as.character(C$`Pago cupon 2`[which(names(Tabla)[i]==C$Nombre)])
  }
  
  #añado precios promedios
  Tabla[6,]=pr
  
  if(ind==0){
    #añado rendimiento al vencimiento y duracion
    
    #rendimiento
    for(i in 1:ncol(Tabla)){
      Tabla[9,i]=bond.yield(as.Date(fv,format="%d/%m/%Y"),as.Date(Tabla[4,i],"%d/%m/%Y"),as.numeric(gsub("[,]",".",Tabla[5,i])), 4,as.numeric(gsub("[,]",".",Tabla[6,i])),convention = c("ACT/360"),4)
    }
    
    #verifico si rendimiento es negativo
    
    while(length(which(Tabla[9,]<0))!=0){
      print("Existe rendimiento negativo")
      print("En las posiciones")
      print(which(Tabla[9,]<0))
      
      #pido ingresar nuevos valores para las posiciones indicadas
      print("Favor Ingresar los")
      print(length(which(Tabla[9,]<0)))
      print("precios promedio nuevos")
      vt=c()
      for(i in 1:length(which(Tabla[9,]<0))){
        vt[i] <- as.numeric(readline(prompt="Ej: 101.05,  "))
      }
      
      #sustituyo precios promedio
      Tabla[6,which(Tabla[9,]<0)]=vt
      
      #calculo de nuevo los rendimientos
      for(i in 1:ncol(Tabla)){
        Tabla[9,i]=bond.yield(as.Date(fv,format="%d/%m/%Y"),as.Date(Tabla[4,i],"%d/%m/%Y"),as.numeric(gsub("[,]",".",Tabla[5,i])), 4,as.numeric(gsub("[,]",".",Tabla[6,i])),convention = c("ACT/360"),4)
      }
      
    }#final if rend negativo
    
    
    
    #duracion
    for(i in 1:ncol(Tabla)){
      Tabla[10,i]=bond.duration(as.Date(fv,format="%d/%m/%Y"),as.Date(Tabla[4,i],"%d/%m/%Y"),as.numeric(gsub("[,]",".",Tabla[5,i])), 4,as.numeric(gsub("[,]",".",Tabla[9,i])),convention = c("ACT/360"),4)
    }
    
    #añado inverso duracion
    Tabla[11,]=1/(as.numeric(gsub("[,]",".",Tabla[10,])))
    
    #añado ponderacion
    for(i in 1:ncol(Tabla)){
      Tabla[12,i]=(as.numeric(gsub("[,]",".",Tabla[11,i])))/sum((as.numeric(gsub("[,]",".",Tabla[11,]))))
    }
    
    print("Muestro tabla preliminar")
    
    #CALCULO PRECIOS ESTIMADOS
    fv=as.Date(fv,format="%d/%m/%Y")
    
    #relleno precios
    Tabla[13,]=precio.sven(tit,fv,C,pa)
    
    #relleno residuos al cuadrado
    
    for(i in 1:ncol(Tabla)){
      Tabla[14,i]=(((as.numeric(gsub("[,]",".",Tabla[13,i])))-(as.numeric(gsub("[,]",".",Tabla[6,i]))))*(as.numeric(gsub("[,]",".",Tabla[12,i]))))^2
    }
    
    #SRC
    print("EL SRC inicial es")
    print(sum(as.numeric(gsub("[,]",".",Tabla[14,]))))
    
    #guardo src inicial
    q <- sum(as.numeric(gsub("[,]",".",Tabla[14,])))
    
    View(Tabla)
    Tablainitif<<-Tabla
    
    #SOLVER
    #precio prom obs
    pp=(as.numeric(gsub("[,]",".",Tabla[6,])))
    w=(as.numeric(gsub("[,]",".",Tabla[12,])))
    
    #prueba paquete alabama
    mifuncion<- function(x){
      pa=c(x[1],x[2],x[3],x[4],x[5],x[6])
      p=precio.sven(tit,fv,C,pa) 
      x=sum(((p-pp)*w)^2)
      return(x)
    }
    
    #restricciones
    res <- function(x) {
      h <- rep(NA, 1)
      h[1] <- x[1]
      h[2] <- x[1]+x[2]
      h[3] <- x[5]
      h[4] <- x[6]
      h[5] <- x[2]+0.01
      h
    }
    
    fe2 <- readline(prompt="Desea optimizar?   (1) Si, (0) No    ")
    if(fe2==1){
      print("Por favor, seleccionar el paquete a usar: ")
      fe3 <- readline(prompt="Seleccionar (1) para Nloptr, (0) para Alabama   ")
      
      if(fe3==1){
        #Broyden–Fletcher–Goldfarb–Shanno-metodo cuasi Newton
        #funcion paquete nloptr resultados mejor q el solver da mejor ajuste
        print("Optimizando mediante paquete Nloptr...")
        ala1=nloptr::auglag(pa, fn=mifuncion, hin=res,localsolver="LBFGS") #mejor igual al solver
        
        mes="NLOPT_FAILURE: Generic failure code."
        if(ala1$message==mes){
          print("Fallo en el metodo de Newton")
          print("optimizando mediante un metodo diferente...")
          ala1=nloptr::auglag(pa, fn=mifuncion, hin=res)
        }
        
        ala<<-ala1
        Tabla[13,]=precio.sven(tit,fv,C,ala1$par)
        
        #calculo nuevo src
        for(i in 1:ncol(Tabla)){
          Tabla[14,i]=(((as.numeric(gsub("[,]",".",Tabla[13,i])))-(as.numeric(gsub("[,]",".",Tabla[6,i]))))*(as.numeric(gsub("[,]",".",Tabla[12,i]))))^2
        }
        
        #veo si son iguales, en caso de ser cierto optimizo por otro metodo
        q1 <- sum(as.numeric(gsub("[,]",".",Tabla[14,])))
        
        if(q==q1){
          print("OPtimizaci�n fallida..")
          print("Optimizando por un m�todo diferente")
          ala1=nloptr::auglag(pa, fn=mifuncion, hin=res)
          ala<<-ala1
          Tabla[13,]=precio.sven(tit,fv,C,ala1$par)
        }
        #SRC Nuevo
        print("El nuevo valor del SRC es")
        print(sum(as.numeric(gsub("[,]",".",Tabla[14,]))))
        
        
      }#final if nloptr
      
      if(fe3==0){
        print("Optimizando mediante paquete alabama...")
        ala1=alabama::auglag(pa, fn=mifuncion, hin=res) #mejor igual al solver
        
        ala<<-ala1
        Tabla[13,]=precio.sven(tit,fv,C,ala1$par)
        
        #calculo nuevo src
        for(i in 1:ncol(Tabla)){
          Tabla[14,i]=(((as.numeric(gsub("[,]",".",Tabla[13,i])))-(as.numeric(gsub("[,]",".",Tabla[6,i]))))*(as.numeric(gsub("[,]",".",Tabla[12,i]))))^2
        }
        
        #veo si son iguales, en caso de ser cierto optimizo por otro metodo
        q1 <- sum(as.numeric(gsub("[,]",".",Tabla[14,])))
        
        if(q==q1){
          print("Optimizaci�n fallida..")
          # print("Optimizando por un m�todo diferente")
          # ala1=alabama::auglag(pa, fn=mifuncion, hin=res)
          # ala<<-ala1
          # Tabla[13,]=precio.sven(tit,fv,C,ala1$par)
        }
        
        #SRC Nuevo
        print("El nuevo valor del SRC es")
        print(sum(as.numeric(gsub("[,]",".",Tabla[14,]))))
        
        
      }#final if alabama
      
      
      
    }#final if si
    if(fe2==0){
      print("No se  optimizará, se mantendrán los mismos precios")
      #sustituyo precios estimados mas ajustados
      Tabla[13,]=precio.sven(tit,fv,C,pa)
    }
    
    #relleno residuos al cuadrado
    
    for(i in 1:ncol(Tabla)){
      Tabla[14,i]=(((as.numeric(gsub("[,]",".",Tabla[13,i])))-(as.numeric(gsub("[,]",".",Tabla[6,i]))))*(as.numeric(gsub("[,]",".",Tabla[12,i]))))^2
    }
    
    
    
    return(Tabla)
  } #final if ind -tif
  
  #CASO VEBONOS
  if(ind==1){
    #rendimiento
    for(i in 1:ncol(Tabla)){
      Tabla[9,i]=bond.yield(as.Date(fv,format="%d/%m/%Y"),as.Date(Tabla[4,i],"%d/%m/%Y"),as.numeric(gsub("[,]",".",Tabla[5,i])), 4,as.numeric(gsub("[,]",".",Tabla[6,i])),convention = c("ACT/360"),4)
    }
    
    #verifico si rendimiento es negativo
    
    while(length(which(Tabla[9,]<0))!=0){
      print("Existe rendimiento negativo")
      print("En las posiciones")
      print(which(Tabla[9,]<0))
      
      #pido ingresar nuevos valores para las posiciones indicadas
      print("Favor Ingresar los")
      print(length(which(Tabla[9,]<0)))
      print("precios promedio nuevos")
      vt=c()
      for(i in 1:length(which(Tabla[9,]<0))){
        vt[i] <- as.numeric(readline(prompt="Ej: 101.05,  "))
      }
      
      #sustituyo precios promedio
      Tabla[6,which(Tabla[9,]<0)]=vt
      
      #calculo nuevos rendimientos
      #rendimiento
      for(i in 1:ncol(Tabla)){
        Tabla[9,i]=bond.yield(as.Date(fv,format="%d/%m/%Y"),as.Date(Tabla[4,i],"%d/%m/%Y"),as.numeric(gsub("[,]",".",Tabla[5,i])), 4,as.numeric(gsub("[,]",".",Tabla[6,i])),convention = c("ACT/360"),4)
      }
      #muestro tabla
      View(Tabla)
      
    }#final if rend negativo
    
    
    #duracion
    for(i in 1:ncol(Tabla)){
      Tabla[10,i]=bond.duration(as.Date(fv,format="%d/%m/%Y"),as.Date(Tabla[4,i],"%d/%m/%Y"),as.numeric(gsub("[,]",".",Tabla[5,i])), 4,as.numeric(gsub("[,]",".",Tabla[9,i])),convention = c("ACT/360"),4)
    }
    
    #añado inverso duracion
    Tabla[11,]=1/(as.numeric(gsub("[,]",".",Tabla[10,])))
    
    #añado ponderacion
    for(i in 1:ncol(Tabla)){
      Tabla[12,i]=(as.numeric(gsub("[,]",".",Tabla[11,i])))/sum((as.numeric(gsub("[,]",".",Tabla[11,]))))
    }
    
    print("Muestro tabla preliminar")
    
    #CALCULO PRECIOS ESTIMADOS
    fv=as.Date(fv,format="%d/%m/%Y")
    
    #relleno precios
    Tabla[13,]=precio.sven(tit,fv,C,pa)
    
    #relleno residuos al cuadrado
    
    for(i in 1:ncol(Tabla)){
      Tabla[14,i]=(((as.numeric(gsub("[,]",".",Tabla[13,i])))-(as.numeric(gsub("[,]",".",Tabla[6,i]))))*(as.numeric(gsub("[,]",".",Tabla[12,i]))))^2
    }
    
    #SRC
    print("EL SRC inicial es")
    print(sum(as.numeric(gsub("[,]",".",Tabla[14,]))))
    
    #guardo src inicial
    q <- sum(as.numeric(gsub("[,]",".",Tabla[14,])))
    
    View(Tabla)
    
    TablainiVeb<<-Tabla
    
    #SOLVER
    #precio prom obs
    pp=(as.numeric(gsub("[,]",".",Tabla[6,])))
    w=(as.numeric(gsub("[,]",".",Tabla[12,])))
    
    #prueba paquete alabama
    mifuncion<- function(x){
      pa=c(x[1],x[2],x[3],x[4],x[5],x[6])
      p=precio.sven(tit,fv,C,pa) 
      x=sum(((p-pp)*w)^2)
      return(x)
    }
    
    #restricciones
    res <- function(x) {
      h <- rep(NA, 1)
      h[1] <- x[1]
      h[2] <- x[1]+x[2]
      h[3] <- x[5]
      h[4] <- x[6]
      h
    }
    
    fe2 <- readline(prompt="Desea optimizar?   (1) Si, (0) No    ")
    if(fe2==1){
      
      print("Por favor seleccionar un paquete para optimizar")
      fe3 <- readline(prompt="Seleccionar (1) para el paquete Nloptr, (0) para alabama    ")
      
      if(fe3==1){
        #Broyden–Fletcher–Goldfarb–Shanno-metodo cuasi Newton
        #funcion paquete nloptr resultados mejor q el solver da mejor ajuste
        print("Optimizando mediante paquete Nloptr...")
        ala1=nloptr::auglag(pa, fn=mifuncion, hin=res,localsolver="LBFGS") #mejor igual al solver
        
        mes="NLOPT_FAILURE: Generic failure code."
        if(ala1$message==mes){
          print("Fallo en el metodo de Newton")
          print("optimizando mediante un metodo diferente...")
          ala1=nloptr::auglag(pa, fn=mifuncion, hin=res)
        }
        
        ala<<-ala1
        Tabla[13,]=precio.sven(tit,fv,C,ala1$par)
        
        #calculo nuevo src
        for(i in 1:ncol(Tabla)){
          Tabla[14,i]=(((as.numeric(gsub("[,]",".",Tabla[13,i])))-(as.numeric(gsub("[,]",".",Tabla[6,i]))))*(as.numeric(gsub("[,]",".",Tabla[12,i]))))^2
        }
        
        #veo si son iguales, en caso de ser cierto optimizo por otro metodo
        q1 <- sum(as.numeric(gsub("[,]",".",Tabla[14,])))
        
        if(q==q1){
          print("OPtimizaci�n fallida..")
          print("Optimizando por un m�todo diferente")
          ala1=nloptr::auglag(pa, fn=mifuncion, hin=res)
          ala<<-ala1
          Tabla[13,]=precio.sven(tit,fv,C,ala1$par)
        }
        #SRC Nuevo
        print("El nuevo valor del SRC es")
        print(sum(as.numeric(gsub("[,]",".",Tabla[14,]))))
        
      }#final if nloptr
      
      if(fe3==0){
        print("Optimizando mediante paquete alabama...")
        ala1=alabama::auglag(pa, fn=mifuncion, hin=res) #mejor igual al solver
        
        ala<<-ala1
        Tabla[13,]=precio.sven(tit,fv,C,ala1$par)
        
        #calculo nuevo src
        for(i in 1:ncol(Tabla)){
          Tabla[14,i]=(((as.numeric(gsub("[,]",".",Tabla[13,i])))-(as.numeric(gsub("[,]",".",Tabla[6,i]))))*(as.numeric(gsub("[,]",".",Tabla[12,i]))))^2
        }
        
        #veo si son iguales, en caso de ser cierto optimizo por otro metodo
        q1 <- sum(as.numeric(gsub("[,]",".",Tabla[14,])))
        
        if(q==q1){
          print("Optimizaci�n fallida..")
          # print("Optimizando por un m�todo diferente")
          # ala1=alabama::auglag(pa, fn=mifuncion, hin=res)
          # ala<<-ala1
          # Tabla[13,]=precio.sven(tit,fv,C,ala1$par)
        }
        #SRC Nuevo
        print("El nuevo valor del SRC es")
        print(sum(as.numeric(gsub("[,]",".",Tabla[14,]))))
        
        
      }#final if alabama
      
      
      ala<<-ala1
    }#final if pregunta optimizar si
    
    if(fe2==0){
      print("No se optimizara")
      Tabla[13,]=precio.sven(tit,fv,C,pa)
    }
    
    #relleno residuos al cuadrado
    
    for(i in 1:ncol(Tabla)){
      Tabla[14,i]=(((as.numeric(gsub("[,]",".",Tabla[13,i])))-(as.numeric(gsub("[,]",".",Tabla[6,i]))))*(as.numeric(gsub("[,]",".",Tabla[12,i]))))^2
    }
    
    return(Tabla)
    
  }#final if ind vebono
  
  
  
}#Final funcion excel-sven

##################