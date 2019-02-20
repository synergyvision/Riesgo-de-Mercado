#PRUEBA FUNCIONES NELSON Y SIEGEL CON ISIN
#NELSON Y SIEGEL
#source('~/.Trash/Riesgo-de-Mercado/app/funciones.R')
nelson_siegel <- function(pa,t){
  r=pa[1]+((pa[2]+pa[3])*(1-exp((-t)/(pa[4])))/(t/pa[4]))-
    pa[3]*exp(-t/pa[4])
  return(r)
}

#
precio.ns=function(tit,fv,C,pa){
  #creo variable vacia
  Pr=c()
  
  #uso traductor
  tit <- traductor(tit,C)
  
  for(j in 1:length(tit)){
    #verifico en que posicion de la variable c se encuentra el i-esimo titulo
    #(n=which(C$Nombre==tit[j]))
    (n=which(C$Sicet==tit[j]))
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
      (pa1=c(nelson_siegel(pa,f1[1]),nelson_siegel(pa,f1[2])))
      
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
        pa1[i]=nelson_siegel(pa,f1[i])
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

#
find_pre <- function(pre,Tabla,fv,i){
  
  #vt1=seq(100,Tabla[6,which(Tabla[9,]<0)],by=0.01)
  vt1=seq(100,pre,by=0.01)
  vt1 <- vt1[length(vt1):1]
  
  j <- 1
  vt2 <- as.numeric(gsub("[,]",".",Tabla[9,j]))
  while(vt2<0){
    vt2 <- bond.yield(as.Date(fv,format="%d/%m/%Y"),as.Date(Tabla[4,i],"%d/%m/%Y"),as.numeric(gsub("[,]",".",Tabla[5,i])), 4,vt1[j],convention = c("ACT/360"),4)
    j <- j+1
  }
  
  #consigo precio de manera que el rend no es negativo
  return(vt1[j])
  
} #final funcion find_pre

#
Tabla.ns=function(fv,tit,pr,pa,ind,C,fe2,fe3){
  #variable que me permite señalar error
  cond <- 0
  #Creo data frame donde guardare calculo
  Tabla=as.data.frame(matrix(0,14,length(tit)))
  colnames(Tabla)=tit
  rownames(Tabla)=c("ISIN","Fecha de Liquidación",
                    "Fecha de emisión","Fecha de Vencimiento","Tasa de Cupón",
                    "Precio Prom","Fecha último Pago","Fecha próximo pago",
                    "RDTO al VMTO","Duración","Inverso de la duración",
                    "Ponderación","Precio Modelo Nelson y Siegel Ajustado",
                    "Residuos al cuadrado")
  
  #USO TRADUCTOR
  tit1 <- traductor(tit,C)
  
  #relleno ISIN
  #for(i in 1:ncol(Tabla)){
    #Tabla[1,i]=as.character(C$Sicet[which(names(Tabla)[i]==C$Nombre)])
    Tabla[1,]=as.character(tit1)
    #}
  
  #relleno fecha Liquidación
  for(i in 1:ncol(Tabla)){
    Tabla[2,i]=paste(substr(fv,9,10),substr(fv,6,7),substr(fv,1,4),sep = "/")
  }
  
  #relleno fecha Emision
  for(i in 1:ncol(Tabla)){
    Tabla[3,i]=as.character(C$F.Emision[which(tit1[i]==C$Sicet)])
  }
  
  #relleno fecha Vencimiento
  for(i in 1:ncol(Tabla)){
    Tabla[4,i]=as.character(C$F.Vencimiento[which(tit1[i]==C$Sicet)])
  }
  
  #relleno cupón
  for(i in 1:ncol(Tabla)){
    Tabla[5,i]=C$Cupon[which(tit1[i]==C$Sicet)]/100
  }
  
  #relleno fecha ultimo pago
  for(i in 1:ncol(Tabla)){
    Tabla[7,i]=as.character(C$`Pago cupon 1`[which(tit1[i]==C$Sicet)])
  }
  
  #relleno proximo pago
  for(i in 1:ncol(Tabla)){
    Tabla[8,i]=as.character(C$`Pago cupon 2`[which(tit1[i]==C$Sicet)])
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
      #print("Existe rendimiento negativo")
      #print("En las posiciones")
      #print(which(Tabla[9,]<0))
      
      #pido ingresar nuevos valores para las posiciones indicadas
      #print("Favor Ingresar los")
      #print(length(which(Tabla[9,]<0)))
      #print("precios promedio nuevos")
      
      rendneg <- which(Tabla[9,]<0)
      
      vt <- c()
      for(i in 1:length(which(Tabla[9,]<0))){
        #vt[i] <- as.numeric(readline(prompt="Ej: 101.05,  "))
        vt[i] <- find_pre(as.numeric(gsub("[,]",".",Tabla[6,rendneg[i]])),Tabla,fv,rendneg[i])
      }
      
      #sustituyo precios promedio
      Tabla[6,which(Tabla[9,]<0)]=vt
      
      #calculo nuevos rendimientos
      #rendimiento
      for(i in 1:ncol(Tabla)){
        Tabla[9,i]=bond.yield(as.Date(fv,format="%d/%m/%Y"),as.Date(Tabla[4,i],"%d/%m/%Y"),as.numeric(gsub("[,]",".",Tabla[5,i])), 4,as.numeric(gsub("[,]",".",Tabla[6,i])),convention = c("ACT/360"),4)
      }
      #muestro tabla
      # View(Tabla)
      
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
    Tabla[13,]=precio.ns(tit,fv,C,pa)
    
    #relleno residuos al cuadrado
    
    for(i in 1:ncol(Tabla)){
      Tabla[14,i]=(((as.numeric(gsub("[,]",".",Tabla[13,i])))-(as.numeric(gsub("[,]",".",Tabla[6,i]))))*(as.numeric(gsub("[,]",".",Tabla[12,i]))))^2
    }
    
    #SRC
    print("EL SRC inicial es")
    print(sum(as.numeric(gsub("[,]",".",Tabla[14,]))))
    
    #guardo src inicial
    q <- sum(as.numeric(gsub("[,]",".",Tabla[14,])))
    
    #View(Tabla)
    Tablainitif<<-Tabla
    
    #SOLVER
    #precio prom obs
    pp=(as.numeric(gsub("[,]",".",Tabla[6,])))
    w=(as.numeric(gsub("[,]",".",Tabla[12,])))
    
    #prueba paquete alabama
    mifuncion<- function(x){
      pa=c(x[1],x[2],x[3],x[4])
      p=precio.ns(tit,fv,C,pa) 
      x=sum(((p-pp)*w)^2)
      return(x)
    }
    
    #restricciones
    res <- function(x) {
      h <- rep(NA, 1)
      h[1] <- x[1] # B0 > 0
      h[2] <- x[1]+x[2] # B0 + B1 > 0
      h[3] <- x[4] # lambda1 > 0
      h[4] <- check_rn(nelson_siegel(pa = c(x[1],x[2],x[3],x[4]),t = seq(0.1,20,0.1) ))
      #h[4] <- x[2]+0.01
      #h[4] <- x[2] #ojo
      h
    }
    
    #fe2 <- readline(prompt="Desea optimizar?   (1) Si, (0) No    ")
    if(fe2==1){
      # print("Por favor, seleccionar el paquete a usar: ")
      #fe3 <- readline(prompt="Seleccionar (1) para Nloptr, (0) para Alabama   ")
      
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
        Tabla[13,]=precio.ns(tit,fv,C,ala1$par)
        
        #calculo nuevo src
        for(i in 1:ncol(Tabla)){
          Tabla[14,i]=(((as.numeric(gsub("[,]",".",Tabla[13,i])))-(as.numeric(gsub("[,]",".",Tabla[6,i]))))*(as.numeric(gsub("[,]",".",Tabla[12,i]))))^2
        }
        
        #veo si son iguales, en caso de ser cierto optimizo por otro metodo
        q1 <- sum(as.numeric(gsub("[,]",".",Tabla[14,])))
        
        if(q==q1){
          print("Optimizaci?n fallida..")
          print("Optimizando por un m?todo diferente")
          ala1=nloptr::auglag(pa, fn=mifuncion, hin=res)
          ala<<-ala1
          Tabla[13,]=precio.ns(tit,fv,C,ala1$par)
        }
        #SRC Nuevo
        print("El nuevo valor del SRC es")
        print(sum(as.numeric(gsub("[,]",".",Tabla[14,]))))
        
        
      }#final if nloptr
      
      if(fe3==0){
        print("Optimizando mediante paquete alabama...")
        ala1=try(alabama::auglag(pa, fn=mifuncion, hin=res)) #mejor igual al solver
        
        if(class(ala1)[1]=="try-error"){
          #print("Existe un problema al optimizar")
          ff <- print("Existe un problema al optimizar")
          #Tabla[13,]=precio.ns(tit,fv,C,pa)
          
          #return(as.data.frame(ff))
          #break
          ala1 <- c()
          ala1$par <- pa
          cond <- 1
        }
        
        ala<<-ala1
        Tabla[13,]=precio.ns(tit,fv,C,ala1$par)
        
        #calculo nuevo src
        for(i in 1:ncol(Tabla)){
          Tabla[14,i]=(((as.numeric(gsub("[,]",".",Tabla[13,i])))-(as.numeric(gsub("[,]",".",Tabla[6,i]))))*(as.numeric(gsub("[,]",".",Tabla[12,i]))))^2
        }
        
        #veo si son iguales, en caso de ser cierto optimizo por otro metodo
        q1 <- sum(as.numeric(gsub("[,]",".",Tabla[14,])))
        
        if(q==q1){
          print("Optimizaci?n fallida..")
          # print("Optimizando por un m?todo diferente")
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
      ala1 <- c()
      ala1$par <- pa
      Tabla[13,]=precio.ns(tit,fv,C,ala1$par)
    }
    
    #relleno residuos al cuadrado
    
    for(i in 1:ncol(Tabla)){
      Tabla[14,i]=(((as.numeric(gsub("[,]",".",Tabla[13,i])))-(as.numeric(gsub("[,]",".",Tabla[6,i]))))*(as.numeric(gsub("[,]",".",Tabla[12,i]))))^2
    }
    
    #creo vector de precios para exportar
    precios <- cbind.data.frame(c(tit,"SRC"),c(precio.ns(tit,fv,C,ala1$par),sum(as.numeric(gsub("[,]",".",Tabla[14,])))))
    names(precios) <- c("Títulos","Precios")
    
    
    #if para exportar resultados
    if(fe2==1){
      if(cond==1){
        Tabla <- as.data.frame(print("Problemas al optimizar"))
        names(Tabla) <- "Aviso"
        Tabla1 <- list(Tabla,NULL,NULL)
      }else{
        Tabla1 <- list(Tabla,ala$par,precios)
      }
      
    }else if(fe2==0){
      Tabla1 <- list(Tabla,pa,precios)
    }
    
    return(Tabla1)
  } #final if ind -tif
  
  #CASO VEBONOS
  if(ind==1){
    #rendimiento
    for(i in 1:ncol(Tabla)){
      Tabla[9,i]=bond.yield(as.Date(fv,format="%d/%m/%Y"),as.Date(Tabla[4,i],"%d/%m/%Y"),as.numeric(gsub("[,]",".",Tabla[5,i])), 4,as.numeric(gsub("[,]",".",Tabla[6,i])),convention = c("ACT/360"),4)
    }
    
    #verifico si rendimiento es negativo
    
    while(length(which(Tabla[9,]<0))!=0){
      #print("Existe rendimiento negativo")
      #print("En las posiciones")
      #print(which(Tabla[9,]<0))
      
      #pido ingresar nuevos valores para las posiciones indicadas
      #print("Favor Ingresar los")
      #print(length(which(Tabla[9,]<0)))
      #print("precios promedio nuevos")
      
      rendneg <- which(Tabla[9,]<0)
      
      vt <- c()
      for(i in 1:length(which(Tabla[9,]<0))){
        #vt[i] <- as.numeric(readline(prompt="Ej: 101.05,  "))
        vt[i] <- find_pre(as.numeric(gsub("[,]",".",Tabla[6,rendneg[i]])),Tabla,fv,rendneg[i])
      }
      
      #sustituyo precios promedio
      Tabla[6,which(Tabla[9,]<0)]=vt
      
      #calculo nuevos rendimientos
      #rendimiento
      for(i in 1:ncol(Tabla)){
        Tabla[9,i]=bond.yield(as.Date(fv,format="%d/%m/%Y"),as.Date(Tabla[4,i],"%d/%m/%Y"),as.numeric(gsub("[,]",".",Tabla[5,i])), 4,as.numeric(gsub("[,]",".",Tabla[6,i])),convention = c("ACT/360"),4)
      }
      #muestro tabla
      # View(Tabla)
      
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
    Tabla[13,]=precio.ns(tit,fv,C,pa)
    
    #relleno residuos al cuadrado
    
    for(i in 1:ncol(Tabla)){
      Tabla[14,i]=(((as.numeric(gsub("[,]",".",Tabla[13,i])))-(as.numeric(gsub("[,]",".",Tabla[6,i]))))*(as.numeric(gsub("[,]",".",Tabla[12,i]))))^2
    }
    
    #SRC
    print("EL SRC inicial es")
    print(sum(as.numeric(gsub("[,]",".",Tabla[14,]))))
    
    #guardo src inicial
    q <- sum(as.numeric(gsub("[,]",".",Tabla[14,])))
    
    #View(Tabla)
    
    TablainiVeb<<-Tabla
    
    #SOLVER
    #precio prom obs
    pp=(as.numeric(gsub("[,]",".",Tabla[6,])))
    w=(as.numeric(gsub("[,]",".",Tabla[12,])))
    
    #prueba paquete alabama
    mifuncion<- function(x){
      pa=c(x[1],x[2],x[3],x[4])
      p=precio.ns(tit,fv,C,pa) 
      x=sum(((p-pp)*w)^2)
      return(x)
    }
    
    #restricciones
    res <- function(x) {
      h <- rep(NA, 1)
      h[1] <- x[1]
      h[2] <- x[1]+x[2]
      h[3] <- x[4]
      h[4] <- check_rn(nelson_siegel(pa = c(x[1],x[2],x[3],x[4]),t = seq(0.1,20,0.1) ))
      #h[4] <- x[2]+0.01
      #h[4] <- x[2]
      h
    }
    
    #fe2 <- readline(prompt="Desea optimizar?   (1) Si, (0) No    ")
    if(fe2==1){
      
      # print("Por favor seleccionar un paquete para optimizar")
      #fe3 <- readline(prompt="Seleccionar (1) para el paquete Nloptr, (0) para alabama    ")
      
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
        Tabla[13,]=precio.ns(tit,fv,C,ala1$par)
        
        #calculo nuevo src
        for(i in 1:ncol(Tabla)){
          Tabla[14,i]=(((as.numeric(gsub("[,]",".",Tabla[13,i])))-(as.numeric(gsub("[,]",".",Tabla[6,i]))))*(as.numeric(gsub("[,]",".",Tabla[12,i]))))^2
        }
        
        #veo si son iguales, en caso de ser cierto optimizo por otro metodo
        q1 <- sum(as.numeric(gsub("[,]",".",Tabla[14,])))
        
        if(q==q1){
          print("Optimizaci?n fallida..")
          print("Optimizando por un m?todo diferente")
          ala1=nloptr::auglag(pa, fn=mifuncion, hin=res)
          ala<<-ala1
          Tabla[13,]=precio.ns(tit,fv,C,ala1$par)
        }
        #SRC Nuevo
        print("El nuevo valor del SRC es")
        print(sum(as.numeric(gsub("[,]",".",Tabla[14,]))))
        
      }#final if nloptr
      
      if(fe3==0){
        print("Optimizando mediante paquete alabama...")
        ala1=try(alabama::auglag(pa, fn=mifuncion, hin=res)) #mejor igual al solver
        
        if(class(ala1)[1]=="try-error"){
          #print("Existe un problema al optimizar")
          ff <- print("Existe un problema al optimizar")
          #Tabla[13,]=precio.ns(tit,fv,C,pa)
          
          #return(as.data.frame(ff))
          #break
          ala1 <- c()
          ala1$par <- pa
          
        }
        
        ala<<-ala1
        Tabla[13,]=precio.ns(tit,fv,C,ala1$par)
        
        #calculo nuevo src
        for(i in 1:ncol(Tabla)){
          Tabla[14,i]=(((as.numeric(gsub("[,]",".",Tabla[13,i])))-(as.numeric(gsub("[,]",".",Tabla[6,i]))))*(as.numeric(gsub("[,]",".",Tabla[12,i]))))^2
        }
        
        #veo si son iguales, en caso de ser cierto optimizo por otro metodo
        q1 <- sum(as.numeric(gsub("[,]",".",Tabla[14,])))
        
        if(q==q1){
          print("Optimización fallida..")
          # print("Optimizando por un m?todo diferente")
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
      ala1 <- c()
      ala1$par <- pa
      Tabla[13,]=precio.ns(tit,fv,C,ala1$par)
    }
    
    #relleno residuos al cuadrado
    
    for(i in 1:ncol(Tabla)){
      Tabla[14,i]=(((as.numeric(gsub("[,]",".",Tabla[13,i])))-(as.numeric(gsub("[,]",".",Tabla[6,i]))))*(as.numeric(gsub("[,]",".",Tabla[12,i]))))^2
    }
    
    #creo vector de precios para exportar
    precios <- cbind.data.frame(c(tit,"SRC"),c(precio.ns(tit,fv,C,ala1$par),sum(as.numeric(gsub("[,]",".",Tabla[14,])))))
    names(precios) <- c("Títulos","Precios")
    
    #if para exportar resultados
    if(fe2==1){
      if(cond==1){
        Tabla <- as.data.frame(print("Problemas al optimizar"))
        names(Tabla) <- "Aviso"
        Tabla1 <- list(Tabla,Tabla,Tabla)
      }else{
        Tabla1 <- list(Tabla,ala$par,precios)
      }
    }else if(fe2==0){
      Tabla1 <- list(Tabla,pa,precios)
    }
    
    return(Tabla1)
    
  }#final if ind vebono
  
  
  
}#Final funcion 

#
check_rn <- function(fre){
  if (length(which(fre<0))==0){
    return(1)
  }else{
    return(-1)
  }
}

#cargo imputs
pa_ns <-c(0.133799434790145,-0.01,-0.307885339616438,0.545398124008073)
Ca <- Carac(paste(getwd(),"app","data","Caracteristicas.xls",sep = "/"))
fv <- as.Date("2018-02-13")
tit <- c("TIF082019","TIF102020","TIF042019")
pr <- c(0,0,118.6156375)

precio <- Tabla.ns(fv = fv ,tit =tit,pr =pr ,pa = pa_ns,ind = 0,C = Ca ,fe2=0,fe3=0)[[1]] 

#prueba funcion precio.sven

precio.ns(tit=tit,fv=fv,C=Ca,pa=pa_ns)


#FUNCION TRADUCTOR
traductor <- function(tit,Ca){
  #busco isin instrumento a partir del nombre corto
  a <- c()
  for(i in 1:length(tit)){
    #
    if(length(which(tit[i]==Ca[,2]))==1){
    a[i] <- which(tit[i]==Ca[,2])
    }else if(length(which(tit[i]==Ca[,2]))==0){
      return("No existe título")
    }else{
      #debe existir dos casos 
      #antes de esto ya se debe saber que existen tit duplicados
      #y en caso de existir un duplicado colocar mismo nombre uno con a 
      #y otro con b, ejem: VEBONO032034a , y VEBONO032034b
      #esto con el fin de trabajar con imput nombre corto
      #pero internamente buscar pos ISIN!
      print("Existe título duplicado")
      b <- which(tit[i]==Ca[,2])
      
      return(Ca[b,3])
    }
  }
  return(Ca[a,3])
  
  
}

traductor(tit = tit,Ca = Ca)

#CASO VEBONOS DOS NOMBRE CORTO IGUALES!
#TITULO PROBLEMATICO VEBONO032034
veb <- c("VEBONO102029","VEBONO012025","VEBONO022025")

traductor(tit = veb, Ca)

#problema!
veb_prob <- c("VEBONO032034")
traductor(veb_prob,Ca)

#titulo que no esta
veb_no_existe <- "VEB092020"
traductor(veb_no_existe,Ca)


#PRUEBA FUNCION NUEVA
#CASO TITULOS EXISTEN
precio.ns(tit=tit,fv=fv,C=Ca,pa=pa_ns)

#CASO DUPLICADOS
#DEVUELVE DOS PRECIOS UNO PARA CADA INSTRUMENTO
precio.ns(tit=veb_prob,fv=fv,C=Ca,pa=pa_ns)

#CASO NO EXISTE DA PROBLEMAS PUES NO HAY Q BUSCAR

#CASO FUNCION MAYOR
precio <- Tabla.ns(fv = fv ,tit =tit,pr =pr ,pa = pa_ns,ind = 0,C = Ca ,fe2=0,fe3=0)[[1]] 

#PRUEBA DUPLICADOS CARACTERISTICAS
anyDuplicated(Ca[,2])

as.character(Ca[anyDuplicated(Ca[,2]),2])
#SOLO EXISTE EL VEBONO034034 DUPLICADO


#FUNCION CARACTERISTICA
Carac=function(ruta){
  c=read_excel(ruta, sheet = "DPN",range = "A7:O90",col_names = TRUE)
  c1=c[,c(3,5,6,8,10,11,13,15)]
  c2=c1[-which(is.na(c1[,1])),]
  c3=cbind(as.character(rep("TIF",1,length(c2[,1]))),c2)
  c3[,1]=as.character(c3[,1])
  c3[which(c3[,5]!="Tasa Fija"),1]="VEBONO"
  names(c3)=c("Tipo Instrumento","Sicet","F.Emision","F.Vencimiento","Tipo tasa","Inicio","Pago cupon 1","Pago cupon 2","Cupon")
  
  #tranformo formato fecha
  c3[,3]=format(c3[,3],"%d/%m/%Y")
  c3[,4]=format(c3[,4],"%d/%m/%Y")
  c3[,7]=format(c3[,7],"%d/%m/%Y")
  c3[,8]=format(c3[,8],"%d/%m/%Y")
  
  #agrego columna Nombre TIf o Vebono + fecha venc
  c4=c3[,1]
  
  Nombre=c()
  for(i in 1:length(c4)){
    Nombre[i]=paste(c4[i],paste(substr(c3[i,4],4,5),substr(c3[i,4],7,10),sep = ""),sep = "")
  }
  
  c3=cbind(c3[,1],Nombre,c3[,2:ncol(c3)])
  names(c3)[1]="Tipo Instrumento"
  
  
  #pestaña DPN-TICC
  #d=read.xlsx(ruta, sheetName = "DPN - TICC",startRow = 7,colIndex = 1:14,header = TRUE)
  d <- try(read_excel(ruta,sheet = "DPN - TICC",range = "A7:N13",col_names = TRUE),silent = TRUE)
  #Añado nuevo titulo VF
  #v=try(read.xlsx(ruta, sheetName = "VF",startRow = 7,colIndex = 1:14,header = TRUE),silent = TRUE)
  v=try(read_excel(ruta, sheet = "VF",range = "A7:N30" ,col_names = TRUE),silent = TRUE)
  #
  #vb=try(read.xlsx(ruta, sheetName = "VB",startRow = 7,colIndex = 1:15,header = TRUE),silent = TRUE)
  vb=try(read_excel(ruta, sheet = "VB",range = "A7:O50",col_names = TRUE),silent = TRUE)
  #
  #cf=try(read.xlsx(ruta, sheetName = "CF",startRow = 7,colIndex = 1:14,header = TRUE),silent = TRUE)
  cf=try(read_excel(ruta, sheet = "CF",range = "A7:N30",col_names = TRUE),silent = TRUE)
  #
  #cb=try(read.xlsx(ruta, sheetName = "CB",startRow = 7,colIndex = 1:14,header = TRUE),silent = TRUE)
  cb=try(read_excel(ruta, sheet = "CB",range = "A7:N20",col_names = TRUE),silent = TRUE)
  
  
  #if pestaña dpn - ticc
  if(class(d)[1]=="try-error"){
    d3=c()
  }else{
    d=d[-which(is.na(d[,2])),c(3,4,5,7,9,10,12,14)]
    d <- as.data.frame(d)
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
    
  }
  
  
  #if peta?a VF
  if(class(v)[1]=="try-error"){
    print("No hay pesta?a VF")
    w3=c()
  }else{
    #leo VF
    v=v[-which(is.na(v[,2])),c(3,4,5,7,9,10,12,14)]
    v<-as.data.frame(v)
    #cambio formato fechas
    v[,2]=format(v[,2],"%d/%m/%Y")
    v[,3]=format(v[,3],"%d/%m/%Y")
    v[,6]=format(v[,6],"%d/%m/%Y")
    v[,7]=format(v[,7],"%d/%m/%Y")
    
    w1=rep("Valores Fin.",1,nrow(v))
    
    w2=c()
    for(i in 1:length(w1)){
      w2[i]=paste(w1[i],paste(substr(v[i,3],4,5),substr(v[i,3],7,10),sep = ""),sep = "")
    }
    
    w3=cbind(w1,w2,v)
    names(w3)=names(c3)
    
  }#final if VF
  
  #if Pesta?a VB
  if(class(vb)[1]=="try-error"){
    print("No hay pesta?a VB")
    #CARACTERISTICAS DEFINITIVA
    #C3=rbind(c3,d3) 
    
    #En caso que no lea bien un numero
    #C3$Cupon=as.numeric(sub(",",".",C3$Cupon))
    
    #return(C3)  
    v3=c()
  }else{
    #leo Vb   
    vb=vb[,-4]
    vb=vb[-which(is.na(vb[,2])),c(3,4,5,7,9,10,12,14)]
    vb <- as.data.frame(vb)
    #cambio formato fechas
    vb[,2]=format(vb[,2],"%d/%m/%Y")
    vb[,3]=format(vb[,3],"%d/%m/%Y")
    vb[,6]=format(vb[,6],"%d/%m/%Y")
    vb[,7]=format(vb[,7],"%d/%m/%Y")
    
    v1=rep("Valores Bol.",1,nrow(vb))
    
    v2=c()
    for(i in 1:length(v1)){
      v2[i]=paste(v1[i],paste(substr(vb[i,3],4,5),substr(vb[i,3],7,10),sep = ""),sep = "")
    }
    
    v3=cbind(v1,v2,vb)
    names(v3)=names(c3) 
    
  }#final if VB
  
  
  if(class(cf)[1]=="try-error"){
    print("No hay pesta?a CF")
    #CARACTERISTICAS DEFINITIVA
    #C3=rbind(c3,d3) 
    
    #En caso que no lea bien un numero
    #C3$Cupon=as.numeric(sub(",",".",C3$Cupon))
    
    #return(C3)  
    x3=c()
  }else{
    #leo cf
    cf=cf[-which(is.na(cf[,2])),c(3,4,5,7,9,10,12,14)]
    cf <- as.data.frame(cf)
    #cambio formato fechas
    cf[,2]=format(cf[,2],"%d/%m/%Y")
    cf[,3]=format(cf[,3],"%d/%m/%Y")
    cf[,6]=format(cf[,6],"%d/%m/%Y")
    cf[,7]=format(cf[,7],"%d/%m/%Y")
    
    x1=rep("Certificado Part. Simon Bolivar",1,nrow(cf))
    
    x2=c()
    for(i in 1:length(x1)){
      x2[i]=paste(x1[i],paste(substr(cf[i,3],4,5),substr(cf[i,3],7,10),sep = ""),sep = "")
    }
    
    x3=cbind(x1,x2,cf)
    names(x3)=names(c3) 
    
  }#final if CF
  
  
  if(class(cb)[1]=="try-error"){
    print("No hay pesta?a CB")
    #CARACTERISTICAS DEFINITIVA
    #C3=rbind(c3,d3) 
    
    #En caso que no lea bien un numero
    #C3$Cupon=as.numeric(sub(",",".",C3$Cupon))
    
    #return(C3)  
    y3=c()
  }else{
    
    #leo cb
    cb=cb[-which(is.na(cb[,2])),c(3,4,5,7,9,10,12,14)]
    cb <- as.data.frame(cb)
    #cambio formato fechas
    cb[,2]=format(cb[,2],"%d/%m/%Y")
    cb[,3]=format(cb[,3],"%d/%m/%Y")
    cb[,6]=format(cb[,6],"%d/%m/%Y")
    cb[,7]=format(cb[,7],"%d/%m/%Y")
    
    y1=rep("Certificado Part. Bandes",1,nrow(cb))
    
    y2=c()
    for(i in 1:length(y1)){
      y2[i]=paste(y1[i],paste(substr(cb[i,3],4,5),substr(cb[i,3],7,10),sep = ""),sep = "")
    }
    
    y3=cbind(y1,y2,cb)
    names(y3)=names(c3) 
  }#final if CB
  
  #CARACTERISTICAS DEFINITIVA
  #if de pesta?as
  if(length(c3)==1|length(d3)==1|length(v3)==1|length(w3)==1|length(x3)==1|length(y3)==1){
    print("No hay una pesta?a!") 
    ve=c(length(c3),length(d3),length(v3),length(w3),length(x3),length(y3))
    #h1=which(ve==1)
    
    if(ve[2]==1){
      print("Falta pesta?a DPN-TICC")
      C3=rbind(c3,v3,w3,x3,y3)
      return(C3)
    }
    if(ve[3]==1){
      print("Falta pesta?a VB")
      C3=rbind(c3,d3,w3,x3,y3)
      return(C3)
    }
    if(ve[4]==1){
      print("Falta pesta?a VF")
      C3=rbind(c3,d3,v3,x3,y3)
      return(C3)
    }
    if(ve[5]==1){
      print("Falta pesta?a CF")
      C3=rbind(c3,d3,v3,w3,y3)
      return(C3)
    }
    if(ve[6]==1){
      print("Falta pesta?a CB")
      C3=rbind(c3,d3,v3,w3,x3)
      return(C3)
    }
    
  }else{
    print("Existen todas las pesta?as!")   
    C3=rbind(c3,d3,v3,w3,x3,y3) 
    #En caso que no lea bien un numero
    C3$Cupon=as.numeric(sub(",",".",C3$Cupon))
    
    #VERIFICO SI HAY DUPLICADOS Y AGREGO NOMBRES DIFERENTES
    if(anyDuplicated(C3$Nombre)){
      print("título duplicado")
      print(as.character(C3$Nombre[anyDuplicated(C3$Nombre)]))
      aa <- which(as.character(C3$Nombre[anyDuplicated(C3$Nombre)])==C3$Nombre)
      C3$Nombre <- as.character(C3$Nombre)
      C3$Nombre[aa[1]] <- paste0(C3$Nombre[aa[1]],"a")
      C3$Nombre[aa[2]] <- paste0(C3$Nombre[aa[2]],"b")
      C3$Nombre <- as.factor(C3$Nombre)
      
      }
    
    return(C3)}#final if pesta?as
  
}#final funcion Caracteristicas

#PRUEBO
Ca <- Carac(paste(getwd(),"app","data","Caracteristicas.xls",sep = "/"))

#pruebo busqueda vebonos con problemas
traductor("VEBONO032034",Ca)
traductor("VEBONO032034a",Ca)
traductor("VEBONO032034b",Ca)


#SVENSSON



