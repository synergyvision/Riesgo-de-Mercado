shinyServer(function(input, output) {

  source(paste(getwd(),"Modulos","Curva_rend_ind.R",sep = "/"),local = TRUE)
 
  #fechas
  #Svensson
  #output$p1<-renderPrint({paste(substr(input$n1,9,10),substr(input$n1,6,7),substr(input$n1,1,4),sep = "/")})
  #Nelson y Siegel
  #output$p2<-renderPrint({paste(substr(input$n2,9,10),substr(input$n2,6,7),substr(input$n2,1,4),sep = "/")})
  #Diebold-Li
  output$p3<-renderPrint({paste(substr(input$n3,9,10),substr(input$n3,6,7),substr(input$n3,1,4),sep = "/")})
  #Splines
  output$p4<-renderPrint({paste(substr(input$n4,9,10),substr(input$n4,6,7),substr(input$n4,1,4),sep = "/")})
  #Comparativo
  output$p5<-renderPrint({paste(substr(input$n5,9,10),substr(input$n5,6,7),substr(input$n5,1,4),sep = "/")})
  
  #titulos
  #tif
  output$q1<-renderPrint({c(input$t1,input$t2,input$t3,input$t4)})
  #output$q1_ns<-renderPrint({c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns)})
  #output$q1_ns<-renderPrint({input$fred})
  
  output$q1_dl <- renderPrint({dl1()})
  output$q1_sp <- renderPrint({c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp)})
  output$q1_comp <- renderPrint({c(input$t1_comp,input$t2_comp,input$t3_comp,input$t4_comp)})
  
  #vebonos

  #output$q2_ns<-renderPrint({c(input$v1_ns,input$v2_ns,input$v3_ns,input$v4_ns)})
  output$q2_dl<-renderPrint({dl2()})
  output$q2_sp<-renderPrint({c(input$v1_sp,input$v2_sp,input$v3_sp,input$v4_sp)})
  output$q2_comp<-renderPrint({c(input$v1_comp,input$v2_comp,input$v3_comp,input$v4_comp)})
  
  #titulos nuevos
  #funcion auxiliar - lee caracteristicas y me da los nombres
  nombres_ns_tif <- reactive({
    ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
    if(class(ca)=="try-error"){
      v <- print("El archivo no se encuentra, descargar y recargar página!")
      return(as.data.frame(v))
    }else{
      nombres <- as.character(ca[,2])
      a <- which(substr(nombres,1,3)=="TIF")
      return(nombres[a])
    }    
  })
  
  output$tit_new_ns_tif <- renderUI({ 
    selectInput("tit_ns_tif", "Seleccionar títulos", nombres_ns_tif(),multiple = TRUE)
  })
  
  output$t_ns_tif <- renderPrint(input$tit_ns_tif)
  #variable auxiliar muy util
  #tif
  # ns1 <- reactive({
  #   if(is.null(data_tit_tif_ns())){
  #     #input$t1_ns1
  #     c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns)
  #   }else{
  #     a <- data_tit_tif_ns() 
  #     as.character(a[,1])
  #   }
  # })
  
  #prueba
  #funcion auxiliar nombres tif
  # carac_tif <- function(tit){
  #   data <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
  #   
  #   if(tit=="TIF"){
  #     a <- which(substr(data[,2],1,3)=="TIF")
  #     data1 <- data[a,]
  #     data1[,5] <- as.Date(data1[,5],format="%d/%m/%Y")
  #     data1 <- data1[order(data1[,5]),]
  #     return(as.character(data1[,2]))
  #     
  #   }else if(tit=="VEBONO"){
  #     a1 <- which(substr(data[,2],1,3)=="VEB")
  #     return(as.character(data[a1,2]))
  #   }
  #   
  # }
  # 
  # output$freddy <- renderUI({ 
  #   selectInput("t1_ns1", "Seleccionar títulos", choices = carac_tif("TIF") ,multiple = TRUE)
  # })
  
  #veb
  # ns2 <- reactive({
  #   if(is.null(data_tit_veb_ns())){
  #     #input$t1_ns2
  #     c(input$v1_ns,input$v2_ns,input$v3_ns,input$v4_ns)
  #     
  #   }else{
  #     a <- data_tit_veb_ns() 
  #     as.character(a[,1])
  #   }
  # })
  
  #variable que muestra selccion ya sea de los tit disponibles
  #o del txt q se ingrese 
  # output$q1_ns1 <- renderPrint(
  #   ns1()
  #   )
  
  #
  # output$q1_ns2 <- renderPrint(
  #   ns2()
  # )
  
  #titulos
  # data_tit_tif_ns <- reactive({
  #   # input$file1 will be NULL initially. After the user selects
  #   # and uploads a file, it will be a data frame with 'name',
  #   # 'size', 'type', and 'datapath' columns. The 'datapath'
  #   # column will contain the local filenames where the data can
  #   # be found.
  #   
  #   inFile <- input$data_tit_tif
  #   
  #   if (is.null(inFile))
  #     return(NULL)
  #   
  #   read.table(inFile$datapath, header = input$header_tit_tif,
  #              sep = input$sep_tit_tif, quote = input$quote_tit_tif)
  #   
  # })
  
  #veb
  # data_tit_veb_ns <- reactive({
  #   # input$file1 will be NULL initially. After the user selects
  #   # and uploads a file, it will be a data frame with 'name',
  #   # 'size', 'type', and 'datapath' columns. The 'datapath'
  #   # column will contain the local filenames where the data can
  #   # be found.
  #   
  #   inFile <- input$data_tit_veb
  #   
  #   if (is.null(inFile))
  #     return(NULL)
  #   
  #   read.table(inFile$datapath, header = input$header_tit_veb,
  #              sep = input$sep_tit_veb, quote = input$quote_tit_veb)
  #   
  # })
  
  
  ###############################################################################
  ###############################################################################
  #################################    Datos    #################################
  ###############################################################################
  ###############################################################################
  #tif
  #output$datatable_tit_tif<-renderDataTable({
  #   if(is.null(data_tit_tif_ns())){return()}
  #   #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
  #   #datatable(data_pos())
  #   data_tit_tif_ns()
  # })
  
  #veb
  # output$datatable_tit_veb<-renderDataTable({
  #   if(is.null(data_tit_veb_ns())){return()}
  #   #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
  #   #datatable(data_pos())
  #   data_tit_veb_ns()
  # })
  
  #SVENSSON
  #SVENSSON
  #SVENSSON
  #data tif
  # data_tif_sv <- reactive({
  #   
  #   inFile <- input$data_tit_tif_sv
  #   
  #   if (is.null(inFile))
  #     return(NULL)
  #   
  #   read.table(inFile$datapath, header = input$header_tit_tif_sv,
  #              sep = input$sep_tit_tif_sv, quote = input$quote_tit_tif_sv)
  #   
  # })
  
  #muestro data
  # output$datatable_tit_tif_sv<-renderDataTable({
  #   if(is.null(data_tif_sv())){return()}
  #   #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
  #   #datatable(data_pos())
  #   data_tif_sv()
  # })
  # 
  
  #funcion auxiliar
  # sv1 <- reactive({
  #   if(is.null(data_tif_sv())){
  #     #input$t_sv1
  #     c(input$t1,input$t2,input$t3,input$t4)
  #   }else{
  #     a <- data_tif_sv() 
  #     as.character(a[,1])
  #   }
  # })
  
  # output$q_sv1 <- renderPrint(
  #   sv1()
  # )
  
  #data veb
  # data_veb_sv <- reactive({
  #   
  #   inFile <- input$data_tit_veb_sv
  #   
  #   if (is.null(inFile))
  #     return(NULL)
  #   
  #   read.table(inFile$datapath, header = input$header_tit_veb_sv,
  #              sep = input$sep_tit_veb_sv, quote = input$quote_tit_veb_sv)
  #   
  # })
  
  #muestro data
  # output$datatable_tit_veb_sv<-renderDataTable({
  #   if(is.null(data_veb_sv())){return()}
  #   #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
  #   #datatable(data_pos())
  #   data_veb_sv()
  # })
  
  
  
  
  #veb
  # sv2 <- reactive({
  #   if(is.null(data_veb_sv())){
  #     #input$t_sv1
  #     c(input$v1,input$v2,input$v3,input$v4)
  #   }else{
  #     a <- data_veb_sv() 
  #     as.character(a[,1])
  #   }
  # })
  
  output$q2<-renderPrint({  
    sv2()
  })
  
  
  #DIEBOLD-LI
  #DIEBOLD-LI
  #DIEBOLD-LI
  #data tif
  data_tif_dl <- reactive({
    
    inFile <- input$data_tit_tif_dl
    
    if (is.null(inFile))
      return(NULL)
    
    read.table(inFile$datapath, header = input$header_tit_tif_dl,
               sep = input$sep_tit_tif_dl, quote = input$quote_tit_tif_dl)
    
  })
  
  #muestro data
  output$datatable_tit_tif_dl<-renderDataTable({
    if(is.null(data_tif_dl())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    #datatable(data_pos())
    data_tif_dl()
  })
  
  
  #funcion auxiliar
  dl1 <- reactive({
    if(is.null(data_tif_dl())){
      #input$t_sv1
      c(input$t1_dl,input$t2_dl,input$t3_dl,input$t4_dl)
    }else{
      a <- data_tif_dl() 
      as.character(a[,1])
    }
  })
  
  output$q1_dl <- renderPrint(
    dl1()
  )
  
  
  #data veb
  data_veb_dl <- reactive({
    
    inFile <- input$data_tit_veb_dl
    
    if (is.null(inFile))
      return(NULL)
    
    read.table(inFile$datapath, header = input$header_tit_veb_dl,
               sep = input$sep_tit_veb_dl, quote = input$quote_tit_veb_dl)
    
  })
  
  #muestro data
  output$datatable_tit_veb_dl<-renderDataTable({
    if(is.null(data_veb_dl())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    #datatable(data_pos())
    data_veb_dl()
  })
  
  
  #funcion auxiliar
  dl2 <- reactive({
    if(is.null(data_veb_dl())){
      #input$t_sv1
      c(input$v1_dl,input$v2_dl,input$v3_dl,input$v4_dl)
    }else{
      a <- data_veb_dl() 
      as.character(a[,1])
    }
  })
  
  output$q2_dl <- renderPrint(
    dl2()
  )
  
  
  #SPLINES
  #SPLINES
  #SPLINES
  #data tif
  data_tif_sp <- reactive({
    
    inFile <- input$data_tit_tif_sp
    
    if (is.null(inFile))
      return(NULL)
    
    read.table(inFile$datapath, header = input$header_tit_tif_sp,
               sep = input$sep_tit_tif_sp, quote = input$quote_tit_tif_sp)
    
  })
  
  #muestro data
  output$datatable_tit_tif_sp<-renderDataTable({
    if(is.null(data_tif_sp())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    #datatable(data_pos())
    data_tif_sp()
  })
  
  
  #funcion auxiliar
  sp1 <- reactive({
    if(is.null(data_tif_sp())){
      #input$t_sv1
      c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp)
    }else{
      a <- data_tif_sp() 
      as.character(a[,1])
    }
  })
  
  output$q1_sp <- renderPrint(
    sp1()
  )
  
  #data veb
  data_veb_sp <- reactive({
    
    inFile <- input$data_tit_veb_sp
    
    if (is.null(inFile))
      return(NULL)
    
    read.table(inFile$datapath, header = input$header_tit_veb_sp,
               sep = input$sep_tit_veb_sp, quote = input$quote_tit_veb_sp)
    
  })
  
  #muestro data
  output$datatable_tit_veb_sp<-renderDataTable({
    if(is.null(data_veb_sp())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    #datatable(data_pos())
    data_veb_sp()
  })
  
  
  #funcion auxiliar
  sp2 <- reactive({
    if(is.null(data_veb_sp())){
      #input$t_sv1
      c(input$v1_sp,input$v2_sp,input$v3_sp,input$v4_sp)
    }else{
      a <- data_veb_sp() 
      as.character(a[,1])
    }
  })
  
  output$q2_sp <- renderPrint(
    sp2()
  )
  
  #COMPARATIVO
  #COMPARATIVO
  #COMPARATIVO
  #data tif
  data_tif_comp <- reactive({
    
    inFile <- input$data_tit_tif_comp
    
    if (is.null(inFile))
      return(NULL)
    
    read.table(inFile$datapath, header = input$header_tit_tif_comp,
               sep = input$sep_tit_tif_comp, quote = input$quote_tit_tif_comp)
    
  })
  
  #muestro data
  output$datatable_tit_tif_comp<-renderDataTable({
    if(is.null(data_tif_comp())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    #datatable(data_pos())
    data_tif_comp()
  })
  
  
  #funcion auxiliar
  comp1 <- reactive({
    if(is.null(data_tif_comp())){
      #input$t_sv1
      c(input$t1_comp,input$t2_comp,input$t3_comp,input$t4_comp)
    }else{
      a <- data_tif_comp() 
      as.character(a[,1])
    }
  })
  
  output$q1_comp <- renderPrint(
    comp1()
  )
  
  #data veb
  data_veb_comp <- reactive({

    inFile <- input$data_tit_veb_comp

    if (is.null(inFile))
      return(NULL)

    read.table(inFile$datapath, header = input$header_tit_veb_comp,
               sep = input$sep_tit_veb_comp, quote = input$quote_tit_veb_comp)

  })

  #muestro data
  output$datatable_tit_veb_comp<-renderDataTable({
    if(is.null(data_veb_comp())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    #datatable(data_pos())
    data_veb_comp()
  })


  #funcion auxiliar
  comp2 <- reactive({
    if(is.null(data_veb_comp())){
      #input$t_sv1
      c(input$v1_comp,input$v2_comp,input$v3_comp,input$v4_comp)
    }else{
      a <- data_veb_comp()
      as.character(a[,1])
    }
  })

  output$q2_comp <- renderPrint(
    comp2()
  )


  
  #precios
  #tf <- reactive({pos1(c(input$t1,input$t2,input$t3,input$t4),0)})
  #tf <- reactive({pos1(sv1(),0)})
  
  
  #tf_ns <- reactive({pos1(c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),0)})
  # tf_ns <- reactive({
  #   # a <- pos1(ns1(),0)
  #   # if(length(which(a==0))==0){
  #   #   return(a)
  #   # }else{
  #   #   return("existen precios nulos")
  #   # }
  #   
  #   pos1(ns1(),0)
  #   })
  # 
  
  #tf_dl <- reactive({pos(c(input$t1_dl,input$t2_dl,input$t3_dl,input$t4_dl),0)})
  tf_dl <- reactive({pos1(dl1(),0)})
  
  #tf_sp <- reactive({pos(c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),0)})
  tf_sp <- reactive({pos1(sp1(),0)})
  
  #tv <- reactive({pos(c(input$v1,input$v2,input$v3,input$v4),1)})
  #tv <- reactive({pos1(sv2(),1)})
  
  #tv_ns <- reactive({pos1(c(input$v1_ns,input$v2_ns,input$v3_ns,input$v4_ns),1)})
  #tv_ns <- reactive({pos1(ns2(),1)})
  
  
  #tv_dl <- reactive({pos(c(input$v1_dl,input$v2_dl,input$v3_dl,input$v4_dl),1)})
  tv_dl <- reactive({pos1(dl2(),1)})
  
  #tv_sp <- reactive({pos(c(input$v1_sp,input$v2_sp,input$v3_sp,input$v4_sp),1)})
  tv_sp <- reactive({pos1(sp2(),1)})
  
  #output$pre1 <-renderPrint({tf()})
  #output$pre1_ns <-renderPrint({tf_ns()})
  
  #advertencia TIF
  # output$ad_pns_tif <- renderPrint({
  #   if(length(tf_ns())==1 & sum(tf_ns()==0)>=1){ return("No hay instrumentos seleccionados")}else{
  # 
  #   p <- tf_ns()
  # 
  #   if(length(which(p==0))!=0){
  #     return("Existen precios promedios nulos")
  #   }else{
  #     return("Precios promedio diferentes de cero")
  #   }
  # 
  #   }# final if inicial
  # 
  # })
  # 
  #ad - VEB
  # output$ad_pns_veb <- renderPrint({
  #   if(length(tv_ns())==1 & sum(tv_ns()==0)>=1){ return("No hay instrumentos seleccionados")}else{
  #     
  #     p <- tv_ns()
  #     
  #     if(length(which(p==0))!=0){
  #       return("Existen precios promedios nulos")
  #     }else{
  #       return("Precios promedio diferentes de cero")
  #     }
  #     
  #   }# final if inicial
  #   
  # })
  
  #funcion auxiliar
  #tif
  # ad_ns_t1 <- reactive({
  #   p <- tf_ns()
  #   a <- which(p==0)
  #   
  #   if(length(a)!=0){
  #   return(names(p)[a])
  #   }else{
  #     return(NULL)
  #   }
  #   
  # })
  
  #veb
  # ad_ns_t2 <- reactive({
  #   p <- tv_ns()
  #   a <- which(p==0)
  #   
  #   if(length(a)!=0){
  #     return(names(p)[a])
  #   }else{
  #     return(NULL)
  #   }
  #   
  # })
  #instrumentos a seleccionar
  #TIF
  output$ad_ns_tif <- renderUI({ 
    selectInput("ad_ns1", "Seleccionar títulos para modificar su precio promedio", ad_ns_t1(),multiple = TRUE)
  })
  
  #ingreso nuevo precio promedio
  output$Pp_ns1 <- renderPrint({input$pp_ns1})
  
  #variable nueva creada a partir de precios nulos
  #tif
  # output$np_ns1 <- renderPrint({
  #   if(is.null(ad_ns_t1())){ return("No hay precios promedios nulos")}
  #   #obtengo nombres de los instrumentos con precio 0
  #   a <- ad_ns_t1()
  #   
  #   b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  #   names(b) <- c("Títulos","Precio promedio")
  #   b[,1] <-  a
  #   
  #   
  #   c <- as.numeric(unlist(strsplit(input$vec1_ns,",")))
  #   if(length(c)>nrow(b)){
  #     return("Existen más precios de lo necesario, revisar precios ingresados")
  #   }else{
  #   
  #   b[,2] <- c
  #   
  #   #write.table(b,paste(getwd(),"data","pp_ns1.txt",sep = "/"),row.names = FALSE)
  #   
  #   b
  #   }
  # 
  # })
  
  #variable nueva creada a partir de precios nulos
  #VEB
  # output$np_ns2 <- renderPrint({
  #   if(is.null(ad_ns_t2())){ return("No hay precios promedios nulos")}
  #   #obtengo nombres de los instrumentos con precio 0
  #   a <- ad_ns_t2()
  #   
  #   b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  #   names(b) <- c("Títulos","Precio promedio")
  #   b[,1] <-  a
  #   
  #   
  #   c <- as.numeric(unlist(strsplit(input$vec2_ns,",")))
  #   if(length(c)>nrow(b)){
  #     return("Existen más precios de lo necesario, revisar precios ingresados")
  #   }else{
  #     
  #     b[,2] <- c
  #     
  #     #write.table(b,paste(getwd(),"data","pp_ns1.txt",sep = "/"),row.names = FALSE)
  #     
  #     b
  #   }
  #   
  # })
  
  #Salida
  # output$salida <-renderPrint({
  #   x <- as.numeric(unlist(strsplit(input$vec1_ns,",")))
  #  print(x)
  # })
  
  #variable auxiliar
  #tif
  # dat <- reactive({
  #   if(is.null(ad_ns_t1())){ return("Seleccionar instrumento")}
  #   #obtengo nombres de los instrumentos con precio 0
  #   a <- ad_ns_t1()
  #   
  #   b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  #   names(b) <- c("Títulos","Precio promedio")
  #   b[,1] <-  a
  #   
  #   
  #   c <- as.numeric(unlist(strsplit(input$vec1_ns,",")))
  #   if(length(c)>nrow(b)){
  #     return("Existen más precios de lo necesario, revisar precios ingresados")
  #   }else{
  #     
  #     b[,2] <- c
  #     
  #   }
  #     b
  # })
  
  #veb
  # dat1 <- reactive({
  #   if(is.null(ad_ns_t2())){ return("Seleccionar instrumento")}
  #   #obtengo nombres de los instrumentos con precio 0
  #   a <- ad_ns_t2()
  #   
  #   b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  #   names(b) <- c("Títulos","Precio promedio")
  #   b[,1] <-  a
  #   
  #   
  #   c <- as.numeric(unlist(strsplit(input$vec2_ns,",")))
  #   if(length(c)>nrow(b)){
  #     return("Existen más precios de lo necesario, revisar precios ingresados")
  #   }else{
  #     
  #     b[,2] <- c
  #   }
  #   b
  # })
  
  
  #sal
  #tif
  # output$sal1_ns <-renderPrint({
  #   a <- try(TF_NS())
  #   if(class(a)!="try-error"){return(a)}else{"Existen más precios de lo necesario, revisar precios ingresados"}
  #   
  # })
  
  #veb
  # output$sal2_ns <-renderPrint({
  #   a <- try(TV_NS())
  #   if(class(a)!="try-error"){return(a)}else{"Existen más precios de lo necesario, revisar precios ingresados"}
  #   
  # })
  
  #variable que utilizare para buscar precios promedio
  #tif
  # tf_ns1 <- reactive({
  #   a <- tf_ns()
  #   
  #   if(length(which(a==0))==0){
  #     return(a)
  #   }else{
  #     #a <- tf_ns()
  #     b <-dat()
  #     
  # 
  #     #return(b)
  #     #nombres de variables con precios nulos
  #     if(is.null(ad_ns_t1())){ return("Seleccionar instrumento")}
  #     
  #     n <- ad_ns_t1()
  #     
  #     ind <- c()
  #     for(i in 1:length(n)){
  #       ind[i] <- which(n[i]==names(a))
  #     }
  #     
  #     #asigno nuevos precios
  #     # for(i in 1:length(ind)){
  #     # a[ind[i]] <- b[i,2]
  #     # }
  #     a[ind] <- b[,2]
  #     return(a)
  #   
  #     
  #     
  #   }
  # })
  
  #veb
  # tv_ns1 <- reactive({
  #   a <- tv_ns()
  #   
  #   if(length(which(a==0))==0){
  #     return(a)
  #   }else{
  #     #a <- tf_ns()
  #     b <-dat1()
  #     #return(b)
  #     #nombres de variables con precios nulos
  #     if(is.null(ad_ns_t2())){ return("Seleccionar instrumento")}
  #     
  #     n <- ad_ns_t2()
  #     
  #     ind <- c()
  #     for(i in 1:length(n)){
  #       ind[i] <- which(n[i]==names(a))
  #     }
  #     
  #     #asigno nuevos precios
  #     # for(i in 1:length(ind)){
  #     # a[ind[i]] <- b[i,2]
  #     # }
  #     a[ind] <- b[,2]
  #     return(a)
  #   }
  #   
  #   
  # })
  
  #NUEVA VARIABLE
  #TIF
  # TF_NS <- reactive({
  #   a <- tf_ns()
  #   
  #   if(length(which(a==0))!=0){
  #     #return("Existen precios prom nulos")
  #     return(tf_ns1())
  #   }else{
  #     #return("precios bien")
  #     return(a)
  #   }
  #   
  #   
  # })
  
  #VEB
  # TV_NS <- reactive({
  #   a <- tv_ns()
  #   
  #   if(length(which(a==0))!=0){
  #     #return("Existen precios prom nulos")
  #     return(tv_ns1())
  #   }else{
  #     #return("precios bien")
  #     return(a)
  #   }
  #   
  #   
  # })
  
  
  #SVENSSON #SVENSSON
  #SVENSSON #SVENSSON
  #SVENSSON #SVENSSON
  #advertencia TIF
  # output$ad_psv_tif <- renderPrint({
  #   if(length(tf())==1 & sum(tf()==0)>=1){ return("No hay instrumentos seleccionados")}else{
  #     
  #     p <- tf()
  #     
  #     if(length(which(p==0))!=0){
  #       return("Existen precios promedios nulos")
  #     }else{
  #       return("Precios promedio diferentes de cero")
  #     }
  #     
  #   }# final if inicial
  #   
  # })
  
  #variable auxiliar
  #tif
  # ad_sv_t1 <- reactive({
  #   p <- tf()
  #   a <- which(p==0)
  #   
  #   if(length(a)!=0){
  #     return(names(p)[a])
  #   }else{
  #     return(NULL)
  #   }
  #   
  # })
  
  
  #variable nueva creada a partir de precios nulos
  #tif
  # output$np_sv1 <- renderPrint({
  #   if(is.null(ad_sv_t1())){ return("No hay precios promedios nulos")}
  #   #obtengo nombres de los instrumentos con precio 0
  #   a <- ad_sv_t1()
  #   
  #   b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  #   names(b) <- c("Títulos","Precio promedio")
  #   b[,1] <-  a
  #   
  #   
  #   c <- as.numeric(unlist(strsplit(input$vec1_sv,",")))
  #   if(length(c)>nrow(b)){
  #     return("Existen más precios de lo necesario, revisar precios ingresados")
  #   }else{
  #     
  #     b[,2] <- c
  # 
  #     b
  #   }
  #   
  # })
  
  #sal
  #tif
  # output$sal1_sv <-renderPrint({
  #   a <- try(TF())
  #   if(class(a)!="try-error"){return(a)}else{"Existen más precios de lo necesario, revisar precios ingresados"}
  #   
  # })
  
  #NUEVA VARIABLE
  #TIF
  # TF <- reactive({
  #   a <- tf()
  #   
  #   if(length(which(a==0))!=0){
  #     #return("Existen precios prom nulos")
  #     return(tf_1())
  #   }else{
  #     #return("precios bien")
  #     return(a)
  #   }
  #   
  # })
  
  #variable que utilizare para buscar precios promedio
  #tif
  # tf_1 <- reactive({
  #   a <- tf()
  #   
  #   if(length(which(a==0))==0){
  #     return(a)
  #   }else{
  #     b <-dat1_sv()
  #     #nombres de variables con precios nulos
  #     if(is.null(ad_sv_t1())){ return("Seleccionar instrumento")}
  #     
  #     n <- ad_sv_t1()
  #     
  #     ind <- c()
  #     for(i in 1:length(n)){
  #       ind[i] <- which(n[i]==names(a))
  #     }
  #     
  #     a[ind] <- b[,2]
  #     return(a)
  #   }
  #   
  #   
  # })
  
  #tif
  # dat1_sv <- reactive({
  #   if(is.null(ad_sv_t1())){ return("Seleccionar instrumento")}
  #   #obtengo nombres de los instrumentos con precio 0
  #   a <- ad_sv_t1()
  #   
  #   b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  #   names(b) <- c("Títulos","Precio promedio")
  #   b[,1] <-  a
  #   
  #   
  #   c <- as.numeric(unlist(strsplit(input$vec1_sv,",")))
  #   if(length(c)>nrow(b)){
  #     return("Existen más precios de lo necesario, revisar precios ingresados")
  #   }else{
  #     
  #     b[,2] <- c
  #   }
  #   b
  # })
  
  #VEBONOS
  #ad - VEB
  # output$ad_psv_veb <- renderPrint({
  #   if(length(tv())==1 & sum(tv()==0)>=1){ return("No hay instrumentos seleccionados")}else{
  #     
  #     p <- tv()
  #     
  #     if(length(which(p==0))!=0){
  #       return("Existen precios promedios nulos")
  #     }else{
  #       return("Precios promedio diferentes de cero")
  #     }
  #     
  #   }# final if inicial
  #   
  # })
  
  #VEB
  # output$np_sv2 <- renderPrint({
  #   if(is.null(ad_sv_t2())){ return("No hay precios promedios nulos")}
  #   #obtengo nombres de los instrumentos con precio 0
  #   a <- ad_sv_t2()
  #   
  #   b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  #   names(b) <- c("Títulos","Precio promedio")
  #   b[,1] <-  a
  #   
  #   
  #   c <- as.numeric(unlist(strsplit(input$vec2_sv,",")))
  #   if(length(c)>nrow(b)){
  #     return("Existen más precios de lo necesario, revisar precios ingresados")
  #   }else{
  #     
  #     b[,2] <- c
  #     b
  #   }
  #   
  # })
  
  #veb
  # ad_sv_t2 <- reactive({
  #   p <- tv()
  #   a <- which(p==0)
  #   
  #   if(length(a)!=0){
  #     return(names(p)[a])
  #   }else{
  #     return(NULL)
  #   }
  #   
  # })
  
  #veb
  # output$sal2_sv <-renderPrint({
  #   a <- try(TV())
  #   if(class(a)!="try-error"){return(a)}else{"Existen más precios de lo necesario, revisar precios ingresados"}
  #   
  # })
  
  #VEB
  # TV <- reactive({
  #   a <- tv()
  #   
  #   if(length(which(a==0))!=0){
  #     #return("Existen precios prom nulos")
  #     return(tv_1())
  #   }else{
  #     #return("precios bien")
  #     return(a)
  #   }
  #   
  #   
  # })
  
  #veb
  # tv_1 <- reactive({
  #   a <- tv()
  #   
  #   if(length(which(a==0))==0){
  #     return(a)
  #   }else{
  #     #a <- tf_ns()
  #     b <-dat2_sv()
  #     #return(b)
  #     #nombres de variables con precios nulos
  #     if(is.null(ad_sv_t2())){ return("Seleccionar instrumento")}
  #     
  #     n <- ad_sv_t2()
  #     
  #     ind <- c()
  #     for(i in 1:length(n)){
  #       ind[i] <- which(n[i]==names(a))
  #     }
  #     
  #     a[ind] <- b[,2]
  #     return(a)
  #   }
  #   
  #   
  # })
  
  #veb
  # dat2_sv <- reactive({
  #   if(is.null(ad_sv_t2())){ return("Seleccionar instrumento")}
  #   #obtengo nombres de los instrumentos con precio 0
  #   a <- ad_sv_t2()
  #   
  #   b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
  #   names(b) <- c("Títulos","Precio promedio")
  #   b[,1] <-  a
  #   
  #   
  #   c <- as.numeric(unlist(strsplit(input$vec2_sv,",")))
  #   if(length(c)>nrow(b)){
  #     return("Existen más precios de lo necesario, revisar precios ingresados")
  #   }else{
  #     
  #     b[,2] <- c
  #   }
  #   b
  # })
  
  
  #COMPARATIVO #COMPARATIVO
  #COMPARATIVO #COMPARATIVO
  #COMPARATIVO #COMPARATIVO
  #TIF
  #advertencia TIF
  output$ad_pnsc_tif <- renderPrint({
    if(length(tf_comp())==1 & sum(tf_comp()==0)>=1){ return("No hay instrumentos seleccionados")}else{
      
      p <- tf_comp()
      
      if(length(which(p==0))!=0){
        return("Existen precios promedios nulos")
      }else{
        return("Precios promedio diferentes de cero")
      }
      
    }# final if inicial
    
  })
  
  #tif
  output$np_nsc1 <- renderPrint({
    if(is.null(ad_nsc_t1())){ return("No hay precios promedios nulos")}
    #obtengo nombres de los instrumentos con precio 0
    a <- ad_nsc_t1()
    
    b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
    names(b) <- c("Títulos","Precio promedio")
    b[,1] <-  a
    
    
    c <- as.numeric(unlist(strsplit(input$vec1_nsc,",")))
    if(length(c)>nrow(b)){
      return("Existen más precios de lo necesario, revisar precios ingresados")
    }else{
      
      b[,2] <- c

      b
    }
    
  })
  
  #tif
  ad_nsc_t1 <- reactive({
    p <- tf_comp()
    a <- which(p==0)
    
    if(length(a)!=0){
      return(names(p)[a])
    }else{
      return(NULL)
    }
    
  })
  
  #tif
  output$sal1_nsc <-renderPrint({
    a <- try(TF_NSC())
    if(class(a)!="try-error"){return(a)}else{"Existen más precios de lo necesario, revisar precios ingresados"}
    
  })
  
  #TIF
  TF_NSC <- reactive({
    a <- tf_comp()
    
    if(length(which(a==0))!=0){
      #return("Existen precios prom nulos")
      return(tf_nsc1())
    }else{
      #return("precios bien")
      return(a)
    }
    
    
  })
  
  #
  tf_nsc1 <- reactive({
    a <- tf_comp()
    
    if(length(which(a==0))==0){
      return(a)
    }else{
      #a <- tf_ns()
      b <-dat_nsc1()
      #return(b)
      #nombres de variables con precios nulos
      if(is.null(ad_nsc_t1())){ return("Seleccionar instrumento")}
      
      n <- ad_nsc_t1()
      
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
  
  #tif
  dat_nsc1 <- reactive({
    if(is.null(ad_nsc_t1())){ return("Seleccionar instrumento")}
    #obtengo nombres de los instrumentos con precio 0
    a <- ad_nsc_t1()
    
    b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
    names(b) <- c("Títulos","Precio promedio")
    b[,1] <-  a
    
    
    c <- as.numeric(unlist(strsplit(input$vec1_nsc,",")))
    if(length(c)>nrow(b)){
      return("Existen más precios de lo necesario, revisar precios ingresados")
    }else{
      
      b[,2] <- c
    }
    b
  })
  
  #VEBONOS
  #VEBONOS
  #VEBONOS
  #ad - VEB
  output$ad_pnsc_veb <- renderPrint({
    if(length(tv_comp())==1 & sum(tv_comp()==0)>=1){ return("No hay instrumentos seleccionados")}else{
      
      p <- tv_comp()
      
      if(length(which(p==0))!=0){
        return("Existen precios promedios nulos")
      }else{
        return("Precios promedio diferentes de cero")
      }
      
    }# final if inicial
    
  })
  
  #VEB
  output$np_nsc2 <- renderPrint({
    if(is.null(ad_nsc_t2())){ return("No hay precios promedios nulos")}
    #obtengo nombres de los instrumentos con precio 0
    a <- ad_nsc_t2()
    
    b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
    names(b) <- c("Títulos","Precio promedio")
    b[,1] <-  a
    
    
    c <- as.numeric(unlist(strsplit(input$vec2_nsc,",")))
    if(length(c)>nrow(b)){
      return("Existen más precios de lo necesario, revisar precios ingresados")
    }else{
      
      b[,2] <- c
      
      b
    }
    
  })
  
  #veb
  ad_nsc_t2 <- reactive({
    p <- tv_comp()
    a <- which(p==0)
    
    if(length(a)!=0){
      return(names(p)[a])
    }else{
      return(NULL)
    }
    
  })
  
  #
  output$sal2_nsc <-renderPrint({
    a <- try(TV_NSC())
    if(class(a)!="try-error"){return(a)}else{"Existen más precios de lo necesario, revisar precios ingresados"}
    
  })
  
  #VEB
  TV_NSC <- reactive({
    a <- tv_comp()
    
    if(length(which(a==0))!=0){
      #return("Existen precios prom nulos")
      return(tv_nsc1())
    }else{
      #return("precios bien")
      return(a)
    }
    
    
  })
 
  #veb
  tv_nsc1 <- reactive({
    a <- tv_comp()
    
    if(length(which(a==0))==0){
      return(a)
    }else{
      #a <- tf_ns()
      b <-dat_nsc2()
      #return(b)
      #nombres de variables con precios nulos
      if(is.null(ad_nsc_t2())){ return("Seleccionar instrumento")}
      
      n <- ad_nsc_t2()
      
      ind <- c()
      for(i in 1:length(n)){
        ind[i] <- which(n[i]==names(a))
      }
    
      a[ind] <- b[,2]
      return(a)
    }
    
    
  })
  
  
  #veb
  dat_nsc2 <- reactive({
    if(is.null(ad_nsc_t2())){ return("Seleccionar instrumento")}
    #obtengo nombres de los instrumentos con precio 0
    a <- ad_nsc_t2()
    
    b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
    names(b) <- c("Títulos","Precio promedio")
    b[,1] <-  a
    
    
    c <- as.numeric(unlist(strsplit(input$vec2_nsc,",")))
    if(length(c)>nrow(b)){
      return("Existen más precios de lo necesario, revisar precios ingresados")
    }else{
      
      b[,2] <- c
    }
    b
  })
  
  #SVENSSON SVENSSON 
  #SVENSSON SVENSSON 
  #SVENSSON SVENSSON 
  #advertencia TIF
  output$ad_psvc_tif <- renderPrint({
    if(length(tf_comp())==1 & sum(tf_comp()==0)>=1){ return("No hay instrumentos seleccionados")}else{
      
      p <- tf_comp()
      
      if(length(which(p==0))!=0){
        return("Existen precios promedios nulos")
      }else{
        return("Precios promedio diferentes de cero")
      }
      
    }# final if inicial
    
  })
  
  #tif
  output$np_svc1 <- renderPrint({
    if(is.null(ad_svc_t1())){ return("No hay precios promedios nulos")}
    #obtengo nombres de los instrumentos con precio 0
    a <- ad_svc_t1()
    
    b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
    names(b) <- c("Títulos","Precio promedio")
    b[,1] <-  a
    
    
    c <- as.numeric(unlist(strsplit(input$vec1_svc,",")))
    if(length(c)>nrow(b)){
      return("Existen más precios de lo necesario, revisar precios ingresados")
    }else{
      
      b[,2] <- c
      
      b
    }
    
  })
  
  #tif
  ad_svc_t1 <- reactive({
    p <- tf_comp()
    a <- which(p==0)
    
    if(length(a)!=0){
      return(names(p)[a])
    }else{
      return(NULL)
    }
    
  })
  
  #tif
  output$sal1_svc <-renderPrint({
    a <- try(TF_SV())
    if(class(a)!="try-error"){return(a)}else{"Existen más precios de lo necesario, revisar precios ingresados"}
    
  })
  
  #TIF
  TF_SV <- reactive({
    a <- tf_comp()
    
    if(length(which(a==0))!=0){
      #return("Existen precios prom nulos")
      return(tf_c1())
    }else{
      #return("precios bien")
      return(a)
    }
    
  })
  
  #tif
  tf_c1 <- reactive({
    a <- tf_comp()
    
    if(length(which(a==0))==0){
      return(a)
    }else{
      b <-dat1_svc()
      #nombres de variables con precios nulos
      if(is.null(ad_svc_t1())){ return("Seleccionar instrumento")}
      
      n <- ad_svc_t1()
      
      ind <- c()
      for(i in 1:length(n)){
        ind[i] <- which(n[i]==names(a))
      }
      
      a[ind] <- b[,2]
      return(a)
    }
    
    
  })
  
  #tif
  dat1_svc <- reactive({
    if(is.null(ad_svc_t1())){ return("Seleccionar instrumento")}
    #obtengo nombres de los instrumentos con precio 0
    a <- ad_svc_t1()
    
    b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
    names(b) <- c("Títulos","Precio promedio")
    b[,1] <-  a
    
    
    c <- as.numeric(unlist(strsplit(input$vec1_svc,",")))
    if(length(c)>nrow(b)){
      return("Existen más precios de lo necesario, revisar precios ingresados")
    }else{
      
      b[,2] <- c
    }
    b
  })
  
  #ad - VEB
  output$ad_psvc_veb <- renderPrint({
    if(length(tv_comp())==1 & sum(tv_comp()==0)>=1){ return("No hay instrumentos seleccionados")}else{
      
      p <- tv_comp()
      
      if(length(which(p==0))!=0){
        return("Existen precios promedios nulos")
      }else{
        return("Precios promedio diferentes de cero")
      }
      
    }# final if inicial
    
  })
  
  #VEB
  output$np_svc2 <- renderPrint({
    if(is.null(ad_svc_t2())){ return("No hay precios promedios nulos")}
    #obtengo nombres de los instrumentos con precio 0
    a <- ad_svc_t2()
    
    b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
    names(b) <- c("Títulos","Precio promedio")
    b[,1] <-  a
    
    
    c <- as.numeric(unlist(strsplit(input$vec2_svc,",")))
    if(length(c)>nrow(b)){
      return("Existen más precios de lo necesario, revisar precios ingresados")
    }else{
      
      b[,2] <- c
      b
    }
    
  })
  
  #veb
  ad_svc_t2 <- reactive({
    p <- tv_comp()
    a <- which(p==0)
    
    if(length(a)!=0){
      return(names(p)[a])
    }else{
      return(NULL)
    }
    
  })
  
  #veb
  output$sal2_svc <-renderPrint({
    a <- try(TV_SV())
    if(class(a)!="try-error"){return(a)}else{"Existen más precios de lo necesario, revisar precios ingresados"}
    
  })
  
  #VEB
  TV_SV <- reactive({
    a <- tv_comp()
    
    if(length(which(a==0))!=0){
      #return("Existen precios prom nulos")
      return(tv_c1())
    }else{
      #return("precios bien")
      return(a)
    }
    
    
  })
  
  #veb
  tv_c1 <- reactive({
    a <- tv_comp()
    
    if(length(which(a==0))==0){
      return(a)
    }else{
      #a <- tf_ns()
      b <-dat2_svc()
      #return(b)
      #nombres de variables con precios nulos
      if(is.null(ad_svc_t2())){ return("Seleccionar instrumento")}
      
      n <- ad_svc_t2()
      
      ind <- c()
      for(i in 1:length(n)){
        ind[i] <- which(n[i]==names(a))
      }
      
      a[ind] <- b[,2]
      return(a)
    }
    
    
  })
  
  #veb
  dat2_svc <- reactive({
    if(is.null(ad_svc_t2())){ return("Seleccionar instrumento")}
    #obtengo nombres de los instrumentos con precio 0
    a <- ad_svc_t2()
    
    b <- as.data.frame(matrix(0,nrow = length(a),ncol = 2))
    names(b) <- c("Títulos","Precio promedio")
    b[,1] <-  a
    
    
    c <- as.numeric(unlist(strsplit(input$vec2_svc,",")))
    if(length(c)>nrow(b)){
      return("Existen más precios de lo necesario, revisar precios ingresados")
    }else{
      
      b[,2] <- c
    }
    b
  })
  
  
  ##
  #output$pre2 <-renderPrint({tv()})
  #output$pre2_ns <-renderPrint({tv_ns()})
  
  output$pre1_dl <-renderPrint({tf_dl()})
  output$pre1_sp <-renderPrint({tf_sp()})
  
  output$pre2_dl <-renderPrint({tv_dl()})
  output$pre2_sp <-renderPrint({tv_sp()})
  
  #comparativo
  #Nelson y Siegel - Svensson
  tf_comp <- reactive({pos1(comp1(),0)})
  tv_comp <- reactive({pos1(comp2(),1)})
  
  output$pre_comp_tif_ns <- renderPrint({tf_comp()})
  output$pre_comp_tif_sven <- renderPrint({tf_comp()})
  output$pre_comp_veb_ns <- renderPrint({tv_comp()})
  output$pre_comp_veb_sven <- renderPrint({tv_comp()})
  
  #output$pre1_ns_comp <-renderPrint({tf_ns_comp()})
  #output$pre2_ns_comp <-renderPrint({tv_ns_comp()})
  
  #Svensson
  #tf_comp <- reactive({pos(c(input$t1_comp,input$t2_comp,input$t3_comp,input$t4_comp),0)})
  #tv_comp <- reactive({pos(c(input$v1_comp,input$v2_comp,input$v3_comp,input$v4_comp),1)})
  
  
  #output$pre1_comp <-renderPrint({tf_comp()})
  #output$pre2_comp <-renderPrint({tv_comp()})
  
  #parametros
  #output$pa_tif <- renderPrint({print(paste0("$$\\beta_{0}$$"))})
  #output$pa_tif <- renderPrint({pa_sven})
  # output$formula <- renderPrint({
  #   return(paste0("Use this formula: $$\beta_{0}", 1,"$$"))
  # })
  # output$ex1 <- renderPrint({
  #  #withMathJax(helpText('$$\\beta_{0} \\quad \\beta_{1}  \\quad \\beta_{2} \\quad \\beta_{3} \\quad \\tau_{1} \\quad\\tau_{2} $$'))
  #   withMathJax(print(pa_ns))
  #   })
  #output$pa_tif_ns <- renderPrint({(pa_ns)})
  output$pa_tif_ns_el <- renderPrint({(pa_ns)})
  #output$pa_veb <- renderPrint({pa1_sven})
  #output$pa_veb_ns <- renderPrint({pa1_ns})
  
  #parametros elegir
  #NELSON Y SIEGEL
  #tif
  #individuales
  output$num_ns_b0_tif<-renderPrint({input$ns_b0_tif})
  output$num_ns_b1_tif<-renderPrint({input$ns_b1_tif})
  output$num_ns_b2_tif<-renderPrint({input$ns_b2_tif})
  output$num_ns_t_tif<-renderPrint({input$ns_t_tif})
  
  #conjunto
  #output$new_ns_tif <- renderPrint({(data.frame('B0'=input$ns_b0_tif,'B1'=input$ns_b1_tif,'B2'=input$ns_b2_tif,'T'=input$ns_t_tif,row.names = " " ))})
  
  #verificacion
  #output$ver_ns_tif <- renderPrint({data.frame('Condición_1'=input$ns_b0_tif>0,'Condición_2'=input$ns_b0_tif+input$ns_b1_tif>0,'Condición_3'=input$ns_t_tif>0,row.names = " " )})
  
  #Comparacion
  output$num_ns_b0_tif_comp <-renderPrint({input$ns_b0_tif_comp})
  output$num_ns_b1_tif_comp <-renderPrint({input$ns_b1_tif_comp})
  output$num_ns_b2_tif_comp <-renderPrint({input$ns_b2_tif_comp})
  output$num_ns_t_tif_comp <-renderPrint({input$ns_t_tif_comp})
  
  #conjunto
  output$new_ns_tif_comp <- renderPrint({
    #take dependency
    input$boton5
    
    #
    isolate(data.frame('B0'=input$ns_b0_tif_comp,'B1'=input$ns_b1_tif_comp,'B2'=input$ns_b2_tif_comp,'T'=input$ns_t_tif_comp,row.names = " " ))
    
    })
  
  #verificacion
  output$ver_ns_tif_comp <- renderPrint({
    #take dependency
    input$boton5
    
    #
    isolate(
    data.frame('Condición_1'=input$ns_b0_tif_comp>0,'Condición_2'=input$ns_b0_tif_comp+input$ns_b1_tif_comp>0,'Condición_3'=input$ns_t_tif_comp>0,row.names = " " )
    )
    
    })
  
  
  #veb
  #individuales
  output$num_ns_b0_veb<-renderPrint({input$ns_b0_veb})
  output$num_ns_b1_veb<-renderPrint({input$ns_b1_veb})
  output$num_ns_b2_veb<-renderPrint({input$ns_b2_veb})
  output$num_ns_t_veb<-renderPrint({input$ns_t_veb})
  
  #conjunto
  #output$new_ns_veb <- renderPrint({(data.frame('B0'=input$ns_b0_veb,'B1'=input$ns_b1_veb,'B2'=input$ns_b2_veb,'T'=input$ns_t_veb,row.names = " " ))})
  
  #verificacion
  #output$ver_ns_veb <- renderPrint({data.frame('Condición_1'=input$ns_b0_veb>0,'Condición_2'=input$ns_b0_veb+input$ns_b1_veb>0,'Condición_3'=input$ns_t_veb>0,row.names = " " )})
  
  #comparativo
  output$num_ns_b0_veb_comp<-renderPrint({input$ns_b0_veb_comp})
  output$num_ns_b1_veb_comp<-renderPrint({input$ns_b1_veb_comp})
  output$num_ns_b2_veb_comp<-renderPrint({input$ns_b2_veb_comp})
  output$num_ns_t_veb_comp<-renderPrint({input$ns_t_veb_comp})
  
  #conjunto
  output$new_ns_veb_comp <- renderPrint({
    #take dependency
    input$boton7
    
    #
    isolate(data.frame('B0'=input$ns_b0_veb_comp,'B1'=input$ns_b1_veb_comp,'B2'=input$ns_b2_veb_comp,'T'=input$ns_t_veb_comp,row.names = " " ))
    
    })
  
  #verificacion
  output$ver_ns_veb_comp <- renderPrint({
    #take dependency
    input$boton7
    
    #
    isolate(
    data.frame('Condición_1'=input$ns_b0_veb_comp>0,'Condición_2'=input$ns_b0_veb_comp+input$ns_b1_veb_comp>0,'Condición_3'=input$ns_t_veb_comp>0,row.names = " " )
    )
    })
  
  
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
  #output$new_sven_tif <- renderPrint({(data.frame('B0'=input$sven_b0_tif,'B1'=input$sven_b1_tif,'B2'=input$sven_b2_tif,'B3'=input$sven_b3_tif,'T1'=input$sven_t1_tif,'T2'=input$sven_t2_tif,row.names = " " ))})
  
  #verificacion
  #output$ver_sven_tif <- renderPrint({data.frame('Condición_1'=input$sven_b0_tif>0,'Condición_2'=input$sven_b0_tif+input$sven_b1_tif>0,'Condición_3'=input$sven_t1_tif>0,'Condición_4'=input$sven_t2_tif>0,row.names = " " )})
  
  #comparativo
  output$num_sven_b0_tif_comp<-renderPrint({input$sven_b0_tif_comp})
  output$num_sven_b1_tif_comp<-renderPrint({input$sven_b1_tif_comp})
  output$num_sven_b2_tif_comp<-renderPrint({input$sven_b2_tif_comp})
  output$num_sven_b3_tif_comp<-renderPrint({input$sven_b3_tif_comp})
  output$num_sven_t1_tif_comp<-renderPrint({input$sven_t1_tif_comp})
  output$num_sven_t2_tif_comp<-renderPrint({input$sven_t2_tif_comp})
  
  #conjunto
  output$new_sven_tif_comp <- renderPrint({
    #take dependency
    input$boton6
    
    #
    isolate(data.frame('B0'=input$sven_b0_tif_comp,'B1'=input$sven_b1_tif_comp,'B2'=input$sven_b2_tif_comp,'B3'=input$sven_b3_tif_comp,'T1'=input$sven_t1_tif_comp,'T2'=input$sven_t2_tif_comp,row.names = " " ))
    
    })
  
  #verificacion
  output$ver_sven_tif_comp <- renderPrint({
    #take dependency
    input$boton6
    
    #
    isolate(
    data.frame('Condición_1'=input$sven_b0_tif_comp>0,'Condición_2'=input$sven_b0_tif_comp+input$sven_b1_tif_comp>0,'Condición_3'=input$sven_t1_tif_comp>0,'Condición_4'=input$sven_t2_tif_comp>0,row.names = " " )
    )
    
    })
  
  
  
  
  #veb
  output$num_sven_b0_veb<-renderPrint({input$sven_b0_veb})
  output$num_sven_b1_veb<-renderPrint({input$sven_b1_veb})
  output$num_sven_b2_veb<-renderPrint({input$sven_b2_veb})
  output$num_sven_b3_veb<-renderPrint({input$sven_b3_veb})
  output$num_sven_t1_veb<-renderPrint({input$sven_t1_veb})
  output$num_sven_t2_veb<-renderPrint({input$sven_t2_veb})
  
  #conjunto
  #output$new_sven_veb <- renderPrint({(data.frame('B0'=input$sven_b0_veb,'B1'=input$sven_b1_veb,'B2'=input$sven_b2_veb,'B3'=input$sven_b3_veb,'T1'=input$sven_t1_veb,'T2'=input$sven_t2_veb,row.names = " " ))})
  
  #verificacion
  #output$ver_sven_veb <- renderPrint({data.frame('Condición_1'=input$sven_b0_veb>0,'Condición_2'=input$sven_b0_veb+input$sven_b1_veb>0,'Condición_3'=input$sven_t1_veb>0,'Condición_4'=input$sven_t2_veb>0,row.names = " " )})
  
  #comparativo
  output$num_sven_b0_veb_comp<-renderPrint({input$sven_b0_veb_comp})
  output$num_sven_b1_veb_comp<-renderPrint({input$sven_b1_veb_comp})
  output$num_sven_b2_veb_comp<-renderPrint({input$sven_b2_veb_comp})
  output$num_sven_b3_veb_comp<-renderPrint({input$sven_b3_veb_comp})
  output$num_sven_t1_veb_comp<-renderPrint({input$sven_t1_veb_comp})
  output$num_sven_t2_veb_comp<-renderPrint({input$sven_t2_veb_comp})
  
  #conjunto
  output$new_sven_veb_comp <- renderPrint({
    #take dependency
    input$boton8
    
    #
    isolate(data.frame('B0'=input$sven_b0_veb_comp,'B1'=input$sven_b1_veb_comp,'B2'=input$sven_b2_veb_comp,'B3'=input$sven_b3_veb_comp,'T1'=input$sven_t1_veb_comp,'T2'=input$sven_t2_veb_comp,row.names = " " ))
    
    })
  
  #verificacion
  output$ver_sven_veb_comp <- renderPrint({
    #take dependency
    input$boton8
    
    #
    isolate(
    data.frame('Condición_1'=input$sven_b0_veb_comp>0,'Condición_2'=input$sven_b0_veb_comp+input$sven_b1_veb_comp>0,'Condición_3'=input$sven_t1_veb_comp>0,'Condición_4'=input$sven_t2_veb_comp>0,row.names = " " )
    )
    
    })
  
  
  #muestro caracteristicas
  #output$Ca <- renderDataTable({C})
  # output$Ca <- renderDataTable({
  #   ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
  #   if(class(ca)=="try-error"){
  #     v <- print("El archivo no se encuentra, descargar y recargar página!")
  #     return(as.data.frame(v))
  #   }else{
  #     return(ca)
  #   }
  # })
  
  #output$Ca_ns <- renderDataTable({C})
  # output$Ca_ns <- renderDataTable({
  #   ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
  #   if(class(ca)=="try-error"){
  #     v <- print("El archivo no se encuentra, descargar y recargar página!")
  #     return(as.data.frame(v))
  #   }else{
  #     return(ca)
  #   }
  # })
  output$Ca_dl <- renderDataTable({
    ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
    if(class(ca)=="try-error"){
      v <- print("El archivo no se encuentra, descargar y recargar página!")
      return(as.data.frame(v))
    }else{
      return(ca)
    }
  })
  #output$Ca_sp <- renderDataTable({C})
  output$Ca_sp <- renderDataTable({
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    })
  
  # output$Ca1 <- renderDataTable({
  #   ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
  #   if(class(ca)=="try-error"){
  #     v <- print("El archivo no se encuentra, descargar y recargar página!")
  #     return(as.data.frame(v))
  #   }else{
  #     return(ca)
  #   }
  # })
  
  
  # output$Ca1_ns <- renderDataTable({
  #   ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
  #   if(class(ca)=="try-error"){
  #     v <- print("El archivo no se encuentra, descargar y recargar página!")
  #     return(as.data.frame(v))
  #   }else{
  #     return(ca)
  #   }
  #   })
  output$Ca1_dl <- renderDataTable({
    ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
    if(class(ca)=="try-error"){
      v <- print("El archivo no se encuentra, descargar y recargar página!")
      return(as.data.frame(v))
    }else{
      return(ca)
    }
  })
  output$Ca1_sp <- renderDataTable({
    ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
    if(class(ca)=="try-error"){
      v <- print("El archivo no se encuentra, descargar y recargar página!")
      return(as.data.frame(v))
    }else{
      return(ca)
    }
  })
  output$Ca_comp <- renderDataTable({
    ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
    if(class(ca)=="try-error"){
      v <- print("El archivo no se encuentra, descargar y recargar página!")
      return(as.data.frame(v))
    }else{
      return(ca)
    }
  })
  output$Ca1_comp <- renderDataTable({
    ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
    if(class(ca)=="try-error"){
      v <- print("El archivo no se encuentra, descargar y recargar página!")
      return(as.data.frame(v))
    }else{
      return(ca)
    }
  })
  

  
  #precios estimados iniciales
  # output$p_est_tif <- renderDataTable({
  #   if(length(sv1())!=0){
  #   a <- try(Tabla.sven(fv = input$n1 ,tit = sv1(),pr =TF() ,pa = pa_sven,ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]] )
  #   if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  #   
  #   }else{}
  #   })
  #output$p_est_tif_ns <- renderDataTable({Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = pa_ns,ind = 0,C = C,fe2=0,fe3=0)[[1]] })
  # output$p_est_tif_ns <- renderDataTable({
  #   #if(length(c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns))!=0){
  #   if(length(ns1())!=0){
  #   a <- try(Tabla.ns(fv = input$n2 ,tit = ns1(),pr =TF_NS() ,pa = pa_ns,ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")) ,fe2=0,fe3=0)[[1]] )
  #   if(class(a)!="try-error"){datatable(a, options = list(paging = FALSE))}else{}
  #   
  #   }else{}
  #   })
  #output$p_est_tif_ns_el <- renderDataTable({Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = c(input$ns_b0_tif,input$ns_b1_tif,input$ns_b2_tif,input$ns_t_tif),ind = 0,C = C,fe2=0,fe3=0)[[1]] })
  # output$p_est_tif_ns_el <- renderDataTable({
  #   if(length(ns1())!=0){
  #   a <- try(Tabla.ns(fv = input$n2 ,tit = ns1(),pr =TF_NS() ,pa = c(input$ns_b0_tif,input$ns_b1_tif,input$ns_b2_tif,input$ns_t_tif),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]] )
  #   if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  #   }else{}
  #     })
  
  
  #comparativo
  output$p_est_tif_ns_el_comp <- renderDataTable({
    #take dependency
    input$boton5
    
    #
    isolate(    
      a <- try(Tabla.ns(fv = input$n5 ,tit = comp1(),pr =TF_NSC() ,pa = c(input$ns_b0_tif_comp,input$ns_b1_tif_comp,input$ns_b2_tif_comp,input$ns_t_tif_comp),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]] )
    )
      if(class(a)!="try-error"){
      datatable(a, options = list(paging = FALSE))
      }else{}
    
    
    })
  
  
  # output$p_est_veb <- renderDataTable({
  #   if((length(sv2()))!=0){
  #   a <- try(Tabla.sven(fv = input$n1 ,tit = sv2(),pr =TV() ,pa = pa1_sven,ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]] )
  #   if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  #   
  #   }else{}
  #   })
  
  # output$p_est_veb_ns <- renderDataTable({
  #   if(length(ns2())!=0){
  #   a <- try(Tabla.ns(fv = input$n2 ,tit = ns2(),pr =TV_NS() ,pa = pa1_ns,ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]])
  #   if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  #   }else{}
  #   })
  # output$p_est_veb_ns_el <- renderDataTable({
  #   if(length(ns2())!=0){
  #   a <- try(Tabla.ns(fv = input$n2 ,tit = ns2(),pr =TV_NS() ,pa =c(input$ns_b0_veb,input$ns_b1_veb,input$ns_b2_veb,input$ns_t_veb) ,ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]])
  #   if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  #   }else{}
  #     })
  
  #comparativo
  output$p_est_veb_ns_el_comp <- renderDataTable({
    #take dependency
    input$boton7
    
    #
    isolate(
    a <- try(Tabla.ns(fv = input$n5 ,tit = comp2(),pr =TV_NSC() ,pa =c(input$ns_b0_veb_comp,input$ns_b1_veb_comp,input$ns_b2_veb_comp,input$ns_t_veb_comp) ,ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]])
    )
    
    if(class(a)!="try-error"){
      datatable(a, options = list(paging = FALSE))
    }else{}
    
    })
  
  
  #precios estimados optimizados
  #paquete alabama
  # output$p_est_tif_opt <- renderDataTable({
  #   if(input$opt_tif_sven==1){
  #   withProgress(message = 'Calculando parámetros optimizados', value = 0, {
  #     incProgress(1/2, detail = "Realizando iteraciones")
  #   a <- try(Tabla.sven(fv = input$n1 ,tit = sv1(),pr =TF() ,pa = c(1,1,1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_tif_sven,fe3=0)[[1]] )
  #   if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  #   
  #   })
  #   }else{
  #     Aviso <- "No se optimizará, revisar los precios de la sección parámetros iniciales"
  #     return(as.data.frame(Aviso))
  #   }
  #   })
  
  # output$p_est_tif_opt_ns <- renderDataTable({
  #   if(input$opt_tif_ns==1){
  #   withProgress(message = 'Calculando precios teóricos...', value = 0, {
  #     incProgress(1/2, detail = "Realizando iteraciones")
  #   #Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = c(1,1,1,1),ind = 0,C = C,fe2=input$opt_tif_ns,fe3=0)[[1]] 
  #   a <- try(Tabla.ns(fv = input$n2 ,tit = ns1(),pr =TF_NS() ,pa = c(1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")) ,fe2=input$opt_tif_ns,fe3=0)[[1]] )
  #   if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  #   
  #   })
  #   }else{
  #     Aviso <- "No se optimizará, revisar precios sección parámetros iniciales"
  #     return(as.data.frame(Aviso))
  #   }
  #   })
  
  # output$p_est_tif_opt_sven_el <- renderDataTable({
  #   if(length(sv1())!=0){
  #   a <- try(Tabla.sven(fv = input$n1 ,tit = sv1(),pr =TF() ,pa = c(input$sven_b0_tif,input$sven_b1_tif,input$sven_b2_tif,input$sven_b3_tif,input$sven_t1_tif,input$sven_t2_tif),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]])
  #   if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  #   
  #   }else{}
  #   })
  
  #comparacion
  output$p_est_tif_opt_comp <- renderDataTable({
    if(input$opt_tif_sven_comp==1){
    withProgress(message = 'Calculando parámetros optimizados', value = 0, {
      incProgress(1/2, detail = "Realizando iteraciones")
    a <- try(Tabla.sven(fv = input$n5 ,tit = comp1(),pr =TF_SV() ,pa = c(1,1,1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_tif_sven_comp,fe3=0)[[1]])
    if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
    
    #incProgress(1/2, detail = "Fin")
     })
    }else{
      Aviso <- "No se optimizará, revisar los precios de la sección parámetros iniciales"
      return(as.data.frame(Aviso))
    }
    
    })
  
  output$p_est_tif_opt_ns_comp <- renderDataTable({
    if(input$opt_tif_ns_comp==1){
    withProgress(message = 'Calculando parámetros optimizados', value = 0, {
      incProgress(1/2, detail = "Realizando iteraciones")
    a <- try(Tabla.ns(fv = input$n5 ,tit = comp1(),pr =TF_NSC() ,pa = c(1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_tif_ns_comp,fe3=0)[[1]] )
    if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
    
    #incProgress(1/2, detail = "Fin")
    })
    }else{
      Aviso <- "No se optimizará, revisar los precios de la sección parámetros iniciales"
      return(as.data.frame(Aviso))
    }
    })
  
  #
  output$p_est_tif_opt_sven_el_comp <- renderDataTable({
    #take dependency
    input$boton6
    
    #
    isolate(
    a <- try(Tabla.sven(fv = input$n5 ,tit = comp1(),pr =TF_SV() ,pa = c(input$sven_b0_tif_comp,input$sven_b1_tif_comp,input$sven_b2_tif_comp,input$sven_b3_tif_comp,input$sven_t1_tif_comp,input$sven_t2_tif_comp),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]]) 
    )
    if(class(a)!="try-error"){
      datatable(a, options = list(paging = FALSE))
    }else{}
    })
  
  
  # output$p_est_veb_opt <- renderDataTable({
  #   if(input$opt_veb_sven==1){
  #   withProgress(message = 'Calculando parámetros optimizados', value = 0, {
  #     incProgress(1/2, detail = "Realizando iteraciones")
  #   a <- try(Tabla.sven(fv = input$n1 ,tit = sv2(),pr =TV() ,pa = c(1,1,1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_veb_sven,fe3=0)[[1]])
  #   if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  #   
  #   })
  #   }else{
  #     Aviso <- "No se optimizará, revisar los precios de la sección parámetros iniciales"
  #     return(as.data.frame(Aviso))
  #     }
  #   })
  
  # output$p_est_veb_opt_ns <- renderDataTable({
  #   if(input$opt_veb_ns==1){
  #   withProgress(message = 'Calculando parámetros optimizados', value = 0, {
  #     incProgress(1/2, detail = "Realizando iteraciones")
  #   a <- try(Tabla.ns(fv = input$n2 ,tit = ns2(),pr =TV_NS() ,pa = c(1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_veb_ns,fe3=0)[[1]] )
  #   if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  #   })
  #   }else{
  #     Aviso <- "No se optimizará, revisar los precios de la sección parámetros iniciales"
  #     return(as.data.frame(Aviso))
  #   }
  #   })
  
  # output$p_est_veb_opt_sven_el <- renderDataTable({
  #   if(length(sv2())!=0){
  #   a <- try(Tabla.sven(fv = input$n1 ,tit = sv2(),pr =TV() ,pa = c(input$sven_b0_veb,input$sven_b1_veb,input$sven_b2_veb,input$sven_b3_veb,input$sven_t1_veb,input$sven_t2_veb),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]])
  #   if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
  #   
  #   }else{}
  #   })
  
  #comparacion
  output$p_est_veb_opt_comp <- renderDataTable({
    if(input$opt_veb_sven_comp==1){
    withProgress(message = 'Calculando precios teóricos...', value = 0, {
      incProgress(1/2, detail = "Realizando iteraciones")
      a <- try(Tabla.sven(fv = input$n5 ,tit = comp2(),pr =TV_SV() ,pa = c(1,1,1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_veb_sven_comp,fe3=0)[[1]])
      if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
      
    })
    }else{
      Aviso <- "No se optimizará, revisar los precios de la sección parámetros iniciales"
      return(as.data.frame(Aviso))
    }
    })
  
  output$p_est_veb_opt_sven_el_comp <- renderDataTable({
    #take dependency
    input$boton8
    
    #
    isolate(
    a <- try(Tabla.sven(fv = input$n5 ,tit = comp2(),pr =TV_SV() ,pa = c(input$sven_b0_veb_comp,input$sven_b1_veb_comp,input$sven_b2_veb_comp,input$sven_b3_veb_comp,input$sven_t1_veb_comp,input$sven_t2_veb_comp),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=0,fe3=0)[[1]])
    )
    
    if(class(a)!="try-error"){
      datatable(a, options = list(paging = FALSE))
    }else{}
    })
  
  #
  output$p_est_veb_opt_ns_comp <- renderDataTable({
    if(input$opt_veb_ns_comp==1){
    withProgress(message = 'Calculando precios...', value = 0, {
      incProgress(1/2, detail = "Realizando iteraciones")
      a <- try(Tabla.ns(fv = input$n5 ,tit = comp2(),pr =TV_NSC() ,pa = c(1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_veb_ns_comp,fe3=0)[[1]] )
      if(class(a)!="try-error"){return(datatable(a, options = list(paging = FALSE)))}else{}
      #incProgress(1/2, detail = "Fin")
      })
    }else{
    Aviso <- "No se optimizará, revisar los precios de la sección parámetros iniciales"
    return(as.data.frame(Aviso))
    }
      
    })
  
  
  #precios DL
  #extraigo spline
  #parametro de suavizamiento de splines para DL
  #TIF
  output$spar_tif_dl <- renderPrint({input$parametro_tif_dl})
  
  #cantidad de dias DL TIF
  output$dias_tif_dl <- renderPrint({input$d_tif_dl})
  
  #cantidad de dias DL VEBONOS
  output$dias_veb_dl <- renderPrint({input$d_veb_dl})
  
  #defino funcion auxliliar que hace el llamado a la funcion tabla.Splines
  #una sola vez
  tabla_sp_dl_tif <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    Tabla.splines(data = dat,tipo = "TIF",fe=input$n3,num =input$d_tif_dl,par = input$parametro_tif_dl,tit=dl1(),car,pr=tf_dl())
    })
  
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
  
  output$spline_tif <- renderPrint({
    #agrego dependencia 
    input$boton9
    
    #
    isolate(
    a <- try(dl_spline_tif())
    )
    if(class(a)!="try-error"){
      a
    }else{
      #b <- 
      return("Poca cantidad de observaciones, favor seleccionar una cantidad mayor")
    }
    
    })
  
  output$p_est_dl_tif <- renderDataTable({
    #agrego dependencia 
    input$boton9
    
    #
    withProgress(message = 'Calculando precios teóricos', value = 0, {
      incProgress(1/2, detail = "Realizando iteraciones")
      car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    a <- isolate(try(precio.dl(tit = dl1(),fv = input$n3 ,C = car,pa = c(1,1,1,1),spline1 = dl_spline_tif(),pr=tf_dl())[[1]]))
    
    if(class(a)!="try-error"){
      isolate(datatable(a, options = list(paging = FALSE)))
    }else{}
    
    })
    })
  
  #comparativo
  output$spar_tif_dl_comp <- renderPrint({input$parametro_tif_dl_comp})
  
  #numero de observaciones tif
  output$dias_tif_dl_comp<- renderPrint({input$d_tif_dl_comp})
  
  
  #creo funcion para acelerar calculo en seccion comparativo DL 
  tabla_sp_dl_tif_comp  <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    Tabla.splines(data = dat,tipo = "TIF",fe=input$n5,num=input$d_tif_dl_comp,par = input$parametro_tif_dl_comp,tit=comp1(),car,pr=tf_comp())
  })
  
  dl_spline_tif_comp <- reactive({
    withProgress(message = 'Calculando spline a utilizar...', value = 0, {
      # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
      # dat[,3] <- as.Date(as.character(dat[,3]))
      # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
      # Tabla.splines(data = dat,tipo = "TIF",fe=input$n5,num =40,par = input$parametro_tif_dl_comp,tit=c(input$t1_comp,input$t2_comp,input$t3_comp,input$t4_comp),car,pr=tf_comp())[[4]] 
      tabla_sp_dl_tif_comp()[[4]] 
      #incProgress(1/2, detail = "Fin")
    })
    })
  
  output$spline_tif_comp_out <- renderPrint({
    a <- try(dl_spline_tif_comp())
    if(class(a)!="try-error"){
      a
    }else{
      return("Poca cantidad de observaciones, favor seleccionar una cantidad mayor")
    }
      
    })
  
  output$p_est_dl_tif_comp <- renderDataTable({
    withProgress(message = 'Calculando precios teóricos...', value = 0, {
      incProgress(1/2, detail = "Realizando iteraciones")
      a <- try(precio.dl(tit = comp1(),fv = input$n5 ,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")) ,pa = c(1,1,1,1),spline1 = dl_spline_tif_comp(),pr=tf_comp())[[1]])
      if(class(a)!="try-error"){
        datatable(a, options = list(paging = FALSE))
      }else{}
      
      })
    })
  
  
  #Vebonos
  output$spar_veb_dl <- renderPrint({input$parametro_veb_dl})
  
  #defino funcion auxliliar que hace el llamado a la funcion tabla.Splines
  #una sola vez
  tabla_sp_dl_veb <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n3,num =input$d_veb_dl,par = input$parametro_veb_dl,tit=dl2(),car,pr=tv_dl())
  })
  
  
  dl_spline_veb <- reactive({
    withProgress(message = 'Calculando spline a utilizar...', value = 0, {
      # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
      # dat[,3] <- as.Date(as.character(dat[,3]))
      # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
      # Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n3,num =40,par = input$parametro_veb_dl,tit=c(input$v1_dl,input$v2_dl,input$v3_dl,input$v4_dl),car,pr=tv_dl())[[4]] 
      tabla_sp_dl_veb()[[4]] 
    })
    })
  
  output$spline_veb <- renderPrint({
    #agrego dependencia 
    input$boton10
    
    #
    a <- isolate(try(dl_spline_veb()))
    if(class(a)!="try-error"){
      return(a)
    }else{
      return("Poca cantidad de observaciones, favor seleccionar una cantidad mayor")
    }
    
    })
  
  output$p_est_dl_veb <- renderDataTable({
    #agrego dependencia 
    input$boton10
    
    withProgress(message = 'Calculando precios teóricos...', value = 0, {
      incProgress(1/2, detail = "Realizando iteraciones")
      car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    a <- isolate(try(precio.dl(tit = dl2(),fv = input$n3 ,C = car ,pa = c(1,1,1,1),spline1 = dl_spline_veb(),pr=tv_dl())[[1]]))
    
    if(class(a)!="try-error"){
      isolate(datatable(a, options = list(paging = FALSE)))
    }else{}
    })
    })
  
  #Comparativo
  output$spar_veb_dl_comp <- renderPrint({input$parametro_veb_dl_comp})
  
  #numero de observaciones veb
  output$dias_veb_dl_comp <- renderPrint({input$d_veb_dl_comp})
  
  
  #
  #creo funcion que me calcula una sola llamada de la funcion de splines
  tabla_sp_dl_veb_comp <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num =input$d_veb_dl_comp,par = input$parametro_veb_dl_comp,tit=comp2(),car,pr=tv_comp())
    
  })
  
  
  
  dl_spline_veb_comp <- reactive({
    withProgress(message = 'Calculando spline a utilizar...', value = 0, {
    #   dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    #   dat[,3] <- as.Date(as.character(dat[,3]))
    #   car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num =40,par = input$parametro_veb_dl_comp,tit=c(input$v1_comp,input$v2_comp,input$v3_comp,input$v4_comp),car,pr=tv_comp())[[4]] 
      tabla_sp_dl_veb_comp()[[4]]
    })
      })
  
  output$spline_veb_comp_out <- renderPrint({
    a <- try(dl_spline_veb_comp())
    if(class(a)!="try-error"){
      a
    }else{
      return("Poca cantidad de observaciones, favor seleccionar una cantidad mayor")
    }
    
    })
  
  output$p_est_dl_veb_comp <- renderDataTable({
    withProgress(message = 'Calculando precios teóricos', value = 0, {
      incProgress(1/2, detail = "Realizando iteraciones")
      a <- try(precio.dl(tit = comp2(),fv = input$n5 ,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")) ,pa = c(1,1,1,1),spline1 = dl_spline_veb_comp(),pr=tv_comp())[[1]])
      if(class(a)!="try-error"){
        datatable(a, options = list(paging = FALSE))
        }else{}
      
      })
    })
  
  
  #grafico 
  #extraigo puntos con los q se hace la curva, para DL
  #tif
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
  
  #comparativo
  pto_sp_tif_dl_comp <- reactive({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # 
    # a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n5,num = 40,par = input$parametro_tif_dl_comp,tit=c(input$t1_comp,input$t2_comp,input$t3_comp,input$t4_comp),car,pr=tf_comp())[[2]]
    a <- tabla_sp_dl_tif_comp()[[2]]
    # a1 <- cbind.data.frame(a$Plazo,a$Rendimiento)
    # names(a1) <- c("Plazo","Rendimiento")
    return(a)
  })
  
  
  #veb
  pto_sp_veb_dl <- reactive({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # a <- Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n3,num = 40,par = input$parametro_veb_dl,tit=c(input$v1_dl,input$v2_dl,input$v3_dl,input$v4_dl),car,pr=tv_dl())[[2]]
    a <- tabla_sp_dl_veb()[[2]]
    
    
    # a1 <- cbind.data.frame(a$Plazo,a$Rendimiento)
    # names(a1) <- c("Plazo","Rendimiento")
    return(a)
  })
  
  #comparativo
  pto_sp_veb_dl_comp <- reactive({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # a <- Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num = 40,par = input$parametro_veb_dl_comp,tit=c(input$v1_comp,input$v2_comp,input$v3_comp,input$v4_comp),car,pr=tv_comp())[[2]]
    a <- tabla_sp_dl_veb_comp()[[2]]
    # a1 <- cbind.data.frame(a$Plazo,a$Rendimiento)
    # names(a1) <- c("Plazo","Rendimiento")
    return(a)
  })
  
  
  #Splines para Diebold-Li
  #tif
  output$c_tif_splines_dl <- renderRbokeh({
    #agrego dependencia 
    input$boton9
    
    #
    withProgress(message = 'Graficando curva de rendimiento...', value = 0, {
      incProgress(1/2, detail = "Calculando alturas")
      # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
      # dat[,3] <- as.Date(as.character(dat[,3]))
      # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
      #y <-predict(Tabla.splines(data = dat,tipo = "TIF",fe=input$n3,num = 40,par = input$parametro_tif_dl,tit=c(input$t1_dl,input$t2_dl,input$t3_dl,input$t4_dl),car,pr=tf_dl())[[4]],seq(0.1,20,0.1)*365)$y
      y <-isolate(try(predict(tabla_sp_dl_tif()[[4]],seq(0.9,20,0.1)*365)$y))
      
      if(class(y)!="try-error"){
      
      incProgress(1/2, detail = "Ajustando spline")
        isolate(
    figure(width = 1000,height = 400) %>%
      ly_points(pto_sp_tif_dl()[,4],pto_sp_tif_dl()[,7],pto_sp_tif_dl(),hover=list("Nombre"=pto_sp_tif_dl()[,1],"Fecha de operación"=pto_sp_tif_dl()[,2])) %>%
      ly_points(x=cbind.data.frame(x=seq(0.9,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.9,20,0.1)*365,y)[,2],color="green",hover=list("Plazo"=cbind.data.frame(x=seq(0.9,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.9,20,0.1)*365,y)[,2]),size=4) %>%
      # theme_title(text_color="green",text_align="center",text_font_style="italic")%>%
      x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
      )
      }else{}
    
    
    })
  })
  
  #comparativo
  output$c_tif_splines_dl_comp <- renderRbokeh({
    withProgress(message = 'Graficando curva de rendimiento...', value = 0, {
      incProgress(1/2, detail = "Calculando alturas")
      # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
      # dat[,3] <- as.Date(as.character(dat[,3]))
      # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    #y <-predict(Tabla.splines(data = dat,tipo = "TIF",fe=input$n5,num = 40,par = input$parametro_tif_dl_comp,tit=c(input$t1_comp,input$t2_comp,input$t3_comp,input$t4_comp),car,pr=tf_comp())[[4]],seq(0.1,20,0.1)*365)$y
     a <- try(tabla_sp_dl_tif_comp()[[4]])
      
     if(class(a)!="try-error"){
       y <-predict(a,seq(0.1,20,0.1)*365)$y
      incProgress(1/2, detail = "ajustando spline")
    figure(width = 1000,height = 400) %>%
      ly_points(pto_sp_tif_dl_comp()[,4],pto_sp_tif_dl_comp()[,7],pto_sp_tif_dl_comp(),hover=list("Nombre"=pto_sp_tif_dl_comp()[,1],"Fecha de operación"=pto_sp_tif_dl_comp()[,2])) %>%
      ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="green",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
      # theme_title(text_color="green",text_align="center",text_font_style="italic")%>%
      x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
     }else{}
    
    })
  })
  
  #vebonos
  output$c_veb_splines_dl <- renderRbokeh({
    #agrego dependencia 
    input$boton10
    
    withProgress(message = 'Graficando curva de rendimiento...', value = 0, {
      incProgress(1/2, detail = "Calculando alturas")
    #   dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    #   dat[,3] <- as.Date(as.character(dat[,3]))
    #   car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # y <-predict(Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n3,num = 40,par = input$parametro_veb_dl,tit=c(input$v1_dl,input$v2_dl,input$v3_dl,input$v4_dl),car,pr=tv_dl())[[4]],seq(0.1,20,0.1)*365)$y
      y <-isolate(try(predict(tabla_sp_dl_veb()[[4]],seq(0.1,20,0.1)*365)$y))
      
      if(class(y)!="try-error"){
      
      incProgress(1/2, detail = "Ajustando spline")
    
        isolate(
    figure(width = 1000,height = 400) %>%
      ly_points(pto_sp_veb_dl()[,4],pto_sp_veb_dl()[,7],pto_sp_veb_dl(),hover=list("Nombre"=pto_sp_veb_dl()[,1],"Fecha de operación"=pto_sp_veb_dl()[,2])) %>%
      ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="brown",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
      # theme_title(text_color="green",text_align="center",text_font_style="italic")%>%
      x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
        )
      }else{}
    
    
    })
  })
  
  #comparativo
  output$c_veb_splines_dl_comp <- renderRbokeh({
    withProgress(message = 'Graficando curva de rendimiento...', value = 0, {
      incProgress(1/2, detail = "Calculando alturas")
    #   dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    #   dat[,3] <- as.Date(as.character(dat[,3]))
    #   car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # y <-predict(Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num = 40,par = input$parametro_veb_dl_comp,tit=c(input$v1_comp,input$v2_comp,input$v3_comp,input$v4_comp),car,pr=tv_comp())[[4]],seq(0.1,20,0.1)*365)$y
    a <- try(tabla_sp_dl_veb_comp()[[4]])
      
    if(class(a)!="try-error"){
      y <-predict(a,seq(0.1,20,0.1)*365)$y
    incProgress(1/2, detail = "ajustando spline")
    figure(width = 1000,height = 400) %>%
      ly_points(pto_sp_veb_dl_comp()[,4],pto_sp_veb_dl_comp()[,7],pto_sp_veb_dl_comp(),hover=list("Nombre"=pto_sp_veb_dl_comp()[,1],"Fecha de operación"=pto_sp_veb_dl_comp()[,2])) %>%
      ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="brown",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
      # theme_title(text_color="green",text_align="center",text_font_style="italic")%>%
      x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
    
    }else{}
    
    })
  })
  
  #Grafico 3D!
  #tif
  output$curva_tif_dl <- renderPlotly({ 
    #agrego dependencia 
    input$boton9
    
    #
    #defino eje maduracion
    X1 <- seq(1,20,0.1)
    
    #defino tiempos
    Y1 <- seq(1,50,1)
    
    #
    var_par <- as.data.frame(matrix(0,length(Y1),4))
    
    #defino variable spline
    a <- isolate(try(dl_spline_tif()))
    
    if(class(a)!="try-error"){
      isolate(
    #guardo parametros segun cada tiempo
    for(i in 1:length(Y1)){
      #var_par[i,] <- par_dl(t[i],spline1,pa=c(1,1,1,1))
      var_par[i,] <- par_dl(Y1,a,pa=c(1,1,1,1))
      
    }
      )
    #calculo nuevos rendimientos a partir de los nuevos parametros
    new_rend <- as.data.frame(matrix(0,length(X1),length(Y1)))
    
    isolate(
    for(i in 1:length(Y1)){
      
      new_rend[,i] <- diebold_li(as.numeric(var_par[i,]),X1)
      #new_rend[,i] <- nelson_siegel(as.numeric(var_par[i,]),X)
    }
    )
    
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
  
  #comparativo
  output$curva_tif_dl_comp <- renderPlotly({ 
    #defino eje maduracion
    X1 <- seq(1,20,0.1)
    
    #defino tiempos
    Y1 <- seq(1,50,1)
    
    #
    var_par <- as.data.frame(matrix(0,length(Y1),4))
    
    #calculo spline
    a <- try(dl_spline_tif_comp())
    
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
  
  #vebonos
  output$curva_veb_dl <- renderPlotly({ 
    #agrego dependencia 
    input$boton10
    
    #
    #defino eje maduracion
    X1 <- seq(1,20,0.1)
    
    #defino tiempos
    Y1 <- seq(1,50,1)
    
    #
    var_par <- as.data.frame(matrix(0,length(Y1),4))
    
    #defino spline
    a <- isolate(try(dl_spline_veb()))
    
    if(class(a)!="try-error"){
      isolate(
    #guardo parametros segun cada tiempo
    for(i in 1:length(Y1)){
      #var_par[i,] <- par_dl(t[i],spline1,pa=c(1,1,1,1))
      var_par[i,] <- par_dl(Y1,a,pa=c(1,1,1,1))
      
    }
      )
    #calculo nuevos rendimientos a partir de los nuevos parametros
    new_rend <- as.data.frame(matrix(0,length(X1),length(Y1)))
    
    isolate(
    for(i in 1:length(Y1)){
      
      new_rend[,i] <- diebold_li(as.numeric(var_par[i,]),X1)
      #new_rend[,i] <- nelson_siegel(as.numeric(var_par[i,]),X)
    }
    )
    
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
  
  #Comparativo
  output$curva_veb_dl_comp <- renderPlotly({ 
    #defino eje maduracion
    X1 <- seq(1,20,0.1)
    
    #defino tiempos
    Y1 <- seq(1,50,1)
    
    #
    var_par <- as.data.frame(matrix(0,length(Y1),4))
    
    #calculo spline
    a <- try(dl_spline_veb_comp())
    
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
  
  #parametros optimizados
  # output$par_tif_ns_op <- renderPrint({a <- Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = pa_ns,ind = 0,C = C,fe2=input$opt_tif_ns,fe3=0)
  # a[[2]]
  # })
  
  #graficos
  #output$c_tif_ns <- renderPlot({plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=pa_ns)*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Iniciales")})
  #NELSON Y SIEGEL
  #TIF 
  #  output$c_tif_ns <- renderPlot({
  #   ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=nelson_siegel(t=seq(0.1,20,0.1),pa=pa_ns)*100),aes(x=x,y=y))+
  #     geom_line(color="blue")+xlab("Maduración (años)")+
  #     ylab("Rendimiento (%)")+theme_gray()+
  #     ggtitle("Curva de rendimiento Nelson y Siegel Parámetros Iniciales TIF")+
  #     theme(plot.title = element_text(hjust = 0.5))
  #   
  # })
   #
   # output$c_tif_ns1_new <- renderPlot({
   #   ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=nelson_siegel(t=seq(0.1,20,0.1),pa=c(input$ns_b0_tif,input$ns_b1_tif,input$ns_b2_tif,input$ns_t_tif))*100),aes(x=x,y=y))+
   #     geom_line(color="brown")+xlab("Maduración (años)")+
   #     ylab("Rendimiento (%)")+theme_gray()+
   #     ggtitle("Curva de rendimiento Nelson y Siegel Parámetros elegidos TIF")+
   #     theme(plot.title = element_text(hjust = 0.5))
   # })
   #comparativo
   output$c_tif_ns1_new_comp <- renderPlot({
     #take dependency
     input$boton5
     
     #
     isolate(
     
     ggplot(cbind.data.frame(x=seq(0.9,20,0.1),y=nelson_siegel(t=seq(0.9,20,0.1),pa=c(input$ns_b0_tif_comp,input$ns_b1_tif_comp,input$ns_b2_tif_comp,input$ns_t_tif_comp))*100),aes(x=x,y=y))+
       geom_line(color="red")+xlab("Maduración (años)")+
       ylab("Rendimiento (%)")+theme_gray()+
       ggtitle("Curva de rendimiento Nelson y Siegel Parámetros elegidos TIF")+
       theme(plot.title = element_text(hjust = 0.5))
     
     )
   })
   
   
   #
   # output$c_veb_ns1_new <- renderPlot({
   #   ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=nelson_siegel(t=seq(0.1,20,0.1),pa=c(input$ns_b0_veb,input$ns_b1_veb,input$ns_b2_veb,input$ns_t_veb))*100),aes(x=x,y=y))+
   #     geom_line(color="brown")+xlab("Maduración (años)")+
   #     ylab("Rendimiento (%)")+theme_gray()+
   #     ggtitle("Curva de rendimiento Nelson y Siegel Parámetros elegidos VEBONO")+
   #     theme(plot.title = element_text(hjust = 0.5))
   # })
   
   #comparativo
   output$c_veb_ns1_new_comp <- renderPlot({
     #take dependency
     input$boton7
     
     #
     isolate(
     ggplot(cbind.data.frame(x=seq(0.9,20,0.1),y=nelson_siegel(t=seq(0.9,20,0.1),pa=c(input$ns_b0_veb_comp,input$ns_b1_veb_comp,input$ns_b2_veb_comp,input$ns_t_veb_comp))*100),aes(x=x,y=y))+
       geom_line(color="brown")+xlab("Maduración (años)")+
       ylab("Rendimiento (%)")+theme_gray()+
       ggtitle("Curva de rendimiento Nelson y Siegel Parámetros elegidos VEBONO")+
       theme(plot.title = element_text(hjust = 0.5))
     )
   })
   
   
  #
  # output$c_veb_ns <- renderPlot({
  #   ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=nelson_siegel(t=seq(0.1,20,0.1),pa=pa1_ns)*100),aes(x=x,y=y))+
  #     geom_line(color="blue")+xlab("Maduración (años)")+
  #     ylab("Rendimiento (%)")+theme_gray()+
  #     ggtitle("Curva de rendimiento Nelson y Siegel Parámetros Iniciales VEBONOS")+
  #     theme(plot.title = element_text(hjust = 0.5))
  #   
  # })
  
  #SVENSSON
  # output$c_tif_sven <- renderPlot({
  #   ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=sven(t=seq(0.1,20,0.1),pa=pa_sven)*100),aes(x=x,y=y))+
  #     geom_line(color="blue")+xlab("Maduración (años)")+
  #     ylab("Rendimiento (%)")+theme_gray()+
  #     ggtitle("Curva de rendimiento Svensson Parámetros Iniciales TIF")+
  #     theme(plot.title = element_text(hjust = 0.5))
  #   
  # })
  #
  # output$c_veb_sven <- renderPlot({
  #   ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=sven(t=seq(0.1,20,0.1),pa=pa1_sven)*100),aes(x=x,y=y))+
  #     geom_line(color="blue")+xlab("Maduración (años)")+
  #     ylab("Rendimiento (%)")+theme_gray()+
  #     ggtitle("Curva de rendimiento Svensson Parámetros Iniciales VEBONOS")+
  #     theme(plot.title = element_text(hjust = 0.5))
  #   
  # })
  
  #
  # output$c_tif_sven_new <- renderPlot({
  #   ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=sven(t=seq(0.1,20,0.1),pa=c(input$sven_b0_tif,input$sven_b1_tif,input$sven_b2_tif,input$sven_b3_tif,input$sven_t1_tif,input$sven_t2_tif))*100),aes(x=x,y=y))+
  #     geom_line(color="brown")+xlab("Maduración (años)")+
  #     ylab("Rendimiento (%)")+theme_gray()+
  #     ggtitle("Curva de rendimiento Nelson y Siegel Parámetros elegidos TIF")+
  #     theme(plot.title = element_text(hjust = 0.5))
  # })
  
  #comparativo
  output$c_tif_sven_new_comp <- renderPlot({
    #take dependency
    input$boton6
    
    #
    isolate(
    ggplot(cbind.data.frame(x=seq(0.9,20,0.1),y=sven(t=seq(0.9,20,0.1),pa=c(input$sven_b0_tif_comp,input$sven_b1_tif_comp,input$sven_b2_tif_comp,input$sven_b3_tif_comp,input$sven_t1_tif_comp,input$sven_t2_tif_comp))*100),aes(x=x,y=y))+
      geom_line(color="brown")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de rendimiento Nelson y Siegel Parámetros elegidos TIF")+
      theme(plot.title = element_text(hjust = 0.5))
    )
  })
  
  #
  # output$c_veb_sven_new <- renderPlot({
  #   ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=sven(t=seq(0.1,20,0.1),pa=c(input$sven_b0_veb,input$sven_b1_veb,input$sven_b2_veb,input$sven_b3_veb,input$sven_t1_veb,input$sven_t2_veb))*100),aes(x=x,y=y))+
  #     geom_line(color="brown")+xlab("Maduración (años)")+
  #     ylab("Rendimiento (%)")+theme_gray()+
  #     ggtitle("Curva de rendimiento Svensson Parámetros elegidos VEBONOS")+
  #     theme(plot.title = element_text(hjust = 0.5))
  # })
  
  #comparativo
  output$c_veb_sven_new_comp <- renderPlot({
    #take dependency
    input$boton8
    
    #
    isolate(
    ggplot(cbind.data.frame(x=seq(0.9,20,0.1),y=sven(t=seq(0.9,20,0.1),pa=c(input$sven_b0_veb_comp,input$sven_b1_veb_comp,input$sven_b2_veb_comp,input$sven_b3_veb_comp,input$sven_t1_veb_comp,input$sven_t2_veb_comp))*100),aes(x=x,y=y))+
      geom_line(color="brown")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de rendimiento Svensson Parámetros elegidos VEBONOS")+
      theme(plot.title = element_text(hjust = 0.5))
    )
  })
  
  #caso Nelson y Siegel
  #gra_tif_ns <- reactive({Tabla.ns(fv = input$n2 ,tit = c(input$t1_ns,input$t2_ns,input$t3_ns,input$t4_ns),pr =tf_ns() ,pa = c(1,1,1,1),ind = 0,C = C,fe2=input$opt_tif_ns,fe3=0)[[2]] })
  # gra_tif_ns <- reactive({
  #   a <- try(Tabla.ns(fv = input$n2 ,tit = ns1(),pr =TF_NS() ,pa = c(1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_tif_ns,fe3=0)[[2]])
  #   if(class(a)!="try-error"){return(a)}else{}
  #   })
  
  # gra_veb_ns <- reactive({
  #   a <- try(Tabla.ns(fv = input$n2 ,tit = ns2(),pr =TV_NS() ,pa = c(1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_veb_ns,fe3=0)[[2]])
  #   if(class(a)!="try-error"){return(a)}else{}
  #   })
  

  # output$par_tif_ns_op<-renderPrint({if(input$opt_tif_ns==1){gra_tif_ns()
  # }else{}})
  
  #comparativo
  gra_tif_ns_comp <- reactive({
    a <- try(Tabla.ns(fv = input$n5 ,tit = comp1(),pr =TF_NSC() ,pa = c(1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_tif_ns_comp,fe3=0)[[2]])
    if(class(a)!="try-error"){return(a)}else{}
    
    })
  
  
  output$par_tif_ns_op_comp<-renderPrint({if(input$opt_tif_ns_comp==1){gra_tif_ns_comp()
  }else{}})
  
  
  # output$c_tif_ns_op <- renderPlot({if(input$opt_tif_ns==1){
  #   #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
  #   ggplot(cbind.data.frame(x=seq(0.1,20,0.1),y=nelson_siegel(t=seq(0.1,20,0.1),pa=gra_tif_ns())*100),aes(x=x,y=y))+
  #     geom_line(color="green")+xlab("Maduración (años)")+
  #     ylab("Rendimiento (%)")+theme_gray()+
  #     ggtitle("Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")+
  #     theme(plot.title = element_text(hjust = 0.5))
  #   }else{}})
  # output$c_tif_ns_op <- renderPlot({if(input$opt_tif_ns==1){
  #   a <- try(cbind.data.frame(x=seq(0.1,20,0.1),y=nelson_siegel(t=seq(0.1,20,0.1),pa=gra_tif_ns())*100))
  #   if(class(a)!="try-error"){
  #     #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
  #     ggplot(a,aes(x=x,y=y))+
  #       geom_line(color="green")+xlab("Maduración (años)")+
  #       ylab("Rendimiento (%)")+theme_gray()+
  #       ggtitle("Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")+
  #       theme(plot.title = element_text(hjust = 0.5))
  #   }else{}
  # }else{}})
  
  #comparativo
  output$c_tif_ns_op_comp <- renderPlot({if(input$opt_tif_ns_comp==1){
    #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
    ggplot(cbind.data.frame(x=seq(0.9,20,0.1),y=nelson_siegel(t=seq(0.9,20,0.1),pa=gra_tif_ns_comp())*100),aes(x=x,y=y))+
      geom_line(color="blue")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")+
      theme(plot.title = element_text(hjust = 0.5))
  }else{}})
  
  
  #
  # output$par_veb_ns_op<-renderPrint({if(input$opt_veb_ns==1){gra_veb_ns()
  # }else{}})

  # output$c_veb_ns_op <- renderPlot({if(input$opt_veb_ns==1){
  #   #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
  #   a <- try(cbind.data.frame(x=seq(0.1,20,0.1),y=nelson_siegel(t=seq(0.1,20,0.1),pa=gra_tif_ns())*100))
  #   if(class(a)!="try-error"){
  #     ggplot(a,aes(x=x,y=y))+
  #       geom_line(color="green")+xlab("Maduración (años)")+
  #       ylab("Rendimiento (%)")+theme_gray()+
  #       ggtitle("Curva de redimientos Nelson y Siegel Parametros Optimizados VEBONOS")+
  #       theme(plot.title = element_text(hjust = 0.5))
  #   }else{}
  # }else{}})
  
  #comparativo
  gra_veb_ns_comp <- reactive({
    a <- try(Tabla.ns(fv = input$n5 ,tit = comp2(),pr =TV_NSC() ,pa = c(1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_veb_ns_comp,fe3=0)[[2]] )
    if(class(a)!="try-error"){return(a)}else{}
    
    })
  
  
  output$par_veb_ns_op_comp<-renderPrint({if(input$opt_veb_ns_comp==1){gra_veb_ns_comp()
  }else{}})
  
  output$c_veb_ns_op_comp <- renderPlot({if(input$opt_veb_ns_comp==1){
    #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
    ggplot(cbind.data.frame(x=seq(0.9,20,0.1),y=nelson_siegel(t=seq(0.9,20,0.1),pa=gra_veb_ns_comp())*100),aes(x=x,y=y))+
      geom_line(color="green")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de redimientos Nelson y Siegel Parametros Optimizados VEBONOS")+
      theme(plot.title = element_text(hjust = 0.5))
  }else{}})
  
  #caso Svensson
  # gra_tif_sven <- reactive({
  #   a <- try(Tabla.sven(fv = input$n1 ,tit = sv1(),pr =TF() ,pa = c(1,1,1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_tif_sven,fe3=0)[[2]])
  #   if(class(a)!="try-error"){return(a)}else{}
  #   
  #   })
  # gra_veb_sven <- reactive({
  #   a <- try(Tabla.sven(fv = input$n1 ,tit = sv2(),pr =TV() ,pa = c(1,1,1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_veb_sven,fe3=0)[[2]])
  #   if(class(a)!="try-error"){return(a)}else{}
  #   
  #   })
  
  #tif
  # output$par_tif_sven_op<-renderPrint({if(input$opt_tif_sven==1){gra_tif_sven()
  # }else{}})
  
  #
  # output$c_tif_sven_op <- renderPlot({if(input$opt_tif_sven==1){
  #   #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
  #   a <- try(cbind.data.frame(x=seq(0.1,20,0.1),y=sven(t=seq(0.1,20,0.1),pa=gra_tif_sven())*100))
  #   
  #   if(class(a)!="try-error"){
  #   ggplot(a,aes(x=x,y=y))+
  #     geom_line(color="green")+xlab("Maduración (años)")+
  #     ylab("Rendimiento (%)")+theme_gray()+
  #     ggtitle("Curva de redimientos Svensson Parametros Optimizados TIF")+
  #     theme(plot.title = element_text(hjust = 0.5))
  #   }else{}
  # }else{}})
  
  #comparativo
  gra_tif_sven_comp <- reactive({
    a <- try(Tabla.sven(fv = input$n5 ,tit = comp1(),pr =TF_SV() ,pa = c(1,1,1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_tif_sven_comp,fe3=0)[[2]])
    if(class(a)!="try-error"){return(a)}else{}
    
    })
  gra_veb_sven_comp <- reactive({
    a <- try(Tabla.sven(fv = input$n5 ,tit = comp2(),pr =TV_SV() ,pa = c(1,1,1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=input$opt_veb_sven_comp,fe3=0)[[2]])
    if(class(a)!="try-error"){return(a)}else{}
    
    })
  
  #tif
  output$par_tif_sven_op_comp<-renderPrint({if(input$opt_tif_sven_comp==1){gra_tif_sven_comp()
  }else{}})
  
  #
  output$c_tif_sven_op_comp <- renderPlot({if(input$opt_tif_sven_comp==1){
    #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
    ggplot(cbind.data.frame(x=seq(0.9,20,0.1),y=sven(t=seq(0.9,20,0.1),pa=gra_tif_sven_comp())*100),aes(x=x,y=y))+
      geom_line(color="green")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de redimientos Svensson Parametros Optimizados TIF")+
      theme(plot.title = element_text(hjust = 0.5))
  }else{}})
  
  #veb
  # output$par_veb_sven_op<-renderPrint({if(input$opt_veb_sven==1){gra_veb_sven()
  # }else{}})
  
  #
  # output$c_veb_sven_op <- renderPlot({if(input$opt_veb_sven==1){
  #   #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
  #   a <- try(cbind.data.frame(x=seq(0.1,20,0.1),y=sven(t=seq(0.1,20,0.1),pa=gra_veb_sven())*100))
  #   
  #   if(class(a)!="try-error"){
  #   ggplot(a,aes(x=x,y=y))+
  #     geom_line(color="green")+xlab("Maduración (años)")+
  #     ylab("Rendimiento (%)")+theme_gray()+
  #     ggtitle("Curva de redimientos Svensson Parametros Optimizados VEBONOS")+
  #     theme(plot.title = element_text(hjust = 0.5))
  #   }else{}
  # }else{}})
  
  #comparativo
  output$par_veb_sven_op_comp<-renderPrint({if(input$opt_veb_sven_comp==1){gra_veb_sven_comp()
  }else{}})
  
  #
  output$c_veb_sven_op_comp <- renderPlot({if(input$opt_veb_sven_comp==1){
    #plot(seq(1,20,1),nelson_siegel(t=seq(1,20,1),pa=gra())*100,type = "l",col="blue",xlab = "Maduración (años)",ylab="Rendimiento (%)",main = "Curva de redimientos Nelson y Siegel Parametros Optimizados TIF")
    ggplot(cbind.data.frame(x=seq(0.9,20,0.1),y=sven(t=seq(0.9,20,0.1),pa=gra_veb_sven_comp())*100),aes(x=x,y=y))+
      geom_line(color="green")+xlab("Maduración (años)")+
      ylab("Rendimiento (%)")+theme_gray()+
      ggtitle("Curva de redimientos Svensson Parametros Optimizados VEBONOS")+
      theme(plot.title = element_text(hjust = 0.5))
  }else{}})
  
  #SPLINES
  #tif
  output$dias_tif <- renderPrint({input$d_tif})
  output$spar_tif <- renderPrint({input$parametro_tif})
  
  #comparativo
  output$dias_tif_comp <- renderPrint({input$d_tif_comp})
  output$spar_tif_comp <- renderPrint({input$parametro_tif_comp})
  
  #veb
  output$dias_veb <- renderPrint({input$d_veb})
  output$spar_veb <- renderPrint({input$parametro_veb})
  
  #comparativo
  output$dias_veb_comp <- renderPrint({input$d_veb_comp})
  output$spar_veb_comp <- renderPrint({input$parametro_veb_comp})
  
  
  #precios
  #output$pre_sp_tif <- renderDataTable({Tabla.splines(data = data_splines,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),C_splines,pr=tf_sp())[[5]] })
  output$pre_sp_tif <- renderDataTable({
    #Tabla.splines(data = data_splines,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),C_splines,pr=tf_sp())[[5]] 
    #  dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    #  dat[,3] <- as.Date(as.character(dat[,3]))
    #  car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # # #print(str(data_splines))
    # #print(str(dat))
     #Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())[[5]]
    #agrego dependencia 
    input$boton11
    
    #
    a <- isolate(try(tabla_sp_tif()))
    if(class(a)!="try-error"){
      isolate(datatable(a[[5]], options = list(paging = FALSE)))
    }else{}
     # 
    
    })
  
  #output$pre_sp <- renderPrint({precio_diario_sp(fe=input$n4,num=input$d_tif,par =input$parametro_tif ,datatif =datatif ,tit =tf_sp() ,C=C_splines,letra=c(97,1.34)) })
  output$pre_sp_veb <- renderDataTable({
    #Tabla.splines(data = data_splines,tipo = "VEBONO",fe=input$n4,num = input$d_veb,par = input$parametro_veb,tit=c(input$v1_sp,input$v2_sp,input$v3_sp,input$v4_sp),C_splines,pr=tv_sp())[[5]] 
     # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
     # dat[,3] <- as.Date(as.character(dat[,3]))
     # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
     # 
     # Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n4,num = input$d_veb,par = input$parametro_veb,tit=c(input$v1_sp,input$v2_sp,input$v3_sp,input$v4_sp),car,pr=tv_sp())[[5]] 
     # 
    #pongo dependencia
    input$boton13
    
    #
    #isolate({
    a <- isolate(try(tabla_sp_veb()))
    
    if(class(a)!="try-error"){
      isolate(datatable(a[[5]], options = list(paging = FALSE)))
    }else{}
    
    #}) #final isolate
      
    })
  
  #comparativo
  #tif
  output$pre_sp_tif_comp <- renderDataTable({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # Tabla.splines(data = dat,tipo = "TIF",fe=input$n5,num = input$d_tif_comp,par = input$parametro_tif_comp,tit=c(input$t1_comp,input$t2_comp,input$t3_comp,input$t4_comp),car,pr=tf_comp())[[5]] 
    a <- try(tabla_sp_tif_comp()[[5]])
    if(class(a)!="try-error"){
      datatable(a, options = list(paging = FALSE))
      }else{}
      
    })

  #veb
  output$pre_sp_veb_comp <- renderDataTable({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num = input$d_veb_comp,par = input$parametro_veb_comp,tit=c(input$v1_comp,input$v2_comp,input$v3_comp,input$v4_comp),car,pr=tv_comp())[[5]] 
    a <- try(tabla_sp_veb_comp()[[5]])
    if(class(a)!="try-error"){
      datatable(a, options = list(paging = FALSE))
      }else{}
    
    })
  
  
  
  #curva de rendimiento
  #tif
  output$c_tif_splines <- renderRbokeh({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # 
    # y <-predict(Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())[[4]],seq(0.1,20,0.1)*365)$y
    #agrego dependencia 
    input$boton11
    
    a <- isolate(try(tabla_sp_tif()))
    
    if(class(a)!="try-error"){
    y <-predict(a[[4]],seq(0.1,20,0.1)*365)$y
    
    # f <- ggplot(cbind.data.frame(x=seq(1,20,0.1)*365,y),aes(x=x,y=y))+
    #   geom_line(color="black")+
    #   geom_point(data = pto_sp_tif(),aes(x=pto_sp_tif()[,1],y=pto_sp_tif()[,2]),color="blue",size=3)+
    #   xlab("Maduración (días)")+
    #   ylab("Rendimiento (%)")+theme_gray()+
    #   ggtitle("Curva de redimientos Splines TIF ")+
    #   theme(plot.title = element_text(hjust = 0.5))
    #   
    # 
    # ggplotly(f) 
    
    #letra <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())[[3]]
    letra <- a[[3]]
    letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    
    # names(letra1)=names(pto_sp_tif())
    # 
    # figure(width = 1000,height = 400) %>%
    #   ly_points(c(letra[,7],pto_sp_tif()[,4]),c(letra[,15],pto_sp_tif()[,7]),rbind.data.frame(letra1,pto_sp_tif()),hover=list("Nombre"=c(as.character(letra[,2]),as.character(pto_sp_tif()[,1])),"Fecha de operación"=c(letra[,3],pto_sp_tif()[,2]))) %>%
     
      names(letra1)=names(a[[2]])
     
      isolate(
      figure(width = 1000,height = 400) %>%
      ly_points(c(letra[,7],a[[2]][,4]),c(letra[,15],a[[2]][,7]),rbind.data.frame(letra1,a[[2]]),hover=list("Nombre"=c(as.character(letra[,2]),as.character(a[[2]][,1])),"Fecha de operación"=c(letra[,3],a[[2]][,2]))) %>%
      ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="blue",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
      # theme_title(text_color="green",text_align="center",text_font_style="italic")%>%
      x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)")
      )
    }else{}
  })

  #comparativo
  output$c_tif_splines_comp <- renderRbokeh({
    #y <-predict(tabla_sp_tif_comp()[[4]],seq(0.1,20,0.1)*365)$y
    
    
    #figure(width = 1000,height = 400) %>%
     # ly_points(pto_sp_tif_comp()[,4],pto_sp_tif_comp()[,7],pto_sp_tif_comp(),hover=list("Nombre"=pto_sp_tif_comp()[,1],"Fecha de operación"=pto_sp_tif_comp()[,2])) %>%
      #ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="blue",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
      # theme_title(text_color="green",text_align="center",text_font_style="italic")%>%
      #x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
    
    a <- try(tabla_sp_tif_comp())
    
    if(class(a)!="try-error"){
    y <-predict(a[[4]],seq(0.1,20,0.1)*365)$y
    
    
    #letra <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())[[3]]
    letra <- a[[3]]
    letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    
    # names(letra1)=names(pto_sp_tif())
    # 
    # figure(width = 1000,height = 400) %>%
    #   ly_points(c(letra[,7],pto_sp_tif()[,4]),c(letra[,15],pto_sp_tif()[,7]),rbind.data.frame(letra1,pto_sp_tif()),hover=list("Nombre"=c(as.character(letra[,2]),as.character(pto_sp_tif()[,1])),"Fecha de operación"=c(letra[,3],pto_sp_tif()[,2]))) %>%
    
    names(letra1)=names(a[[2]])
    
    figure(width = 1000,height = 400) %>%
      ly_points(c(letra[,7],a[[2]][,4]),c(letra[,15],a[[2]][,7]),rbind.data.frame(letra1,a[[2]]),hover=list("Nombre"=c(as.character(letra[,2]),as.character(a[[2]][,1])),"Fecha de operación"=c(letra[,3],a[[2]][,2]))) %>%
      ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="blue",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
      # theme_title(text_color="green",text_align="center",text_font_style="italic")%>%
      x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
    
    }else{}
    
  })
  
  #veb
  output$c_veb_splines <- renderRbokeh({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # 
    # y <-predict(Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n4,num = input$d_veb,par = input$parametro_veb,tit=c(input$v1_sp,input$v2_sp,input$v3_sp,input$v4_sp),car,pr=tv_sp())[[4]],seq(0.1,20,0.1)*365)$y
    #pongo dependencia
    input$boton13
    
    #
    #isolate({
    
    a <- isolate(try(tabla_sp_veb()))
    
    if(class(a)!="try-error"){
    y <-predict(a[[4]],seq(0.1,20,0.1)*365)$y
    
    
    # f <- ggplot(cbind.data.frame(x=seq(1,20,0.1)*365,y),aes(x=x,y=y))+
    #   geom_line(color="black")+
    #   geom_point(data = pto_sp_veb(),aes(x=pto_sp_veb()[,1],y=pto_sp_veb()[,2]),color="blue",size=3)+
    #   xlab("Maduración (días)")+
    #   ylab("Rendimiento (%)")+theme_gray()+
    #   ggtitle("Curva de redimientos Splines VEBONO ")+
    #   theme(plot.title = element_text(hjust = 0.5))
    # 
    # 
    # ggplotly(f) 
    # %>%
    #   add_markers(text= ~  pto_sp_tif()[,1],hoverinfo = "text")
    # figure(width = 1000,height = 400) %>%
    #   ly_points(pto_sp_veb()[,4],pto_sp_veb()[,7],pto_sp_veb(),hover=list("Nombre"=pto_sp_veb()[,1],"Fecha de operación"=pto_sp_veb()[,2])) %>%
    #   ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="blue",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
    #   # theme_title(text_color="green",text_align="center",text_font_style="italic")%>%
    #   x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
    # 
    
    letra <- a[[3]]
    #condicional letra
    if(is.null(names(letra))){
      #print(letra)
      letra0 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
      letra0[,2] <- as.Date(letra0[,2])
      letra0[,3] <- as.Date(letra0[,3])
      cand <- a[[2]]
      
      names(letra0)=names(cand)
      
      letra1 <- rbind.data.frame(letra0,cand,make.row.names = FALSE)
    }else{
      letra[,6] <- as.Date(letra[,6])
      letra0 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      cand <- a[[2]]
      
      names(letra0)=names(cand)
      
      letra1 <- rbind.data.frame(letra0,cand,make.row.names = FALSE)

    }
    
    #letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    
    # names(letra1)=names(pto_sp_tif())
    # 
    # figure(width = 1000,height = 400) %>%
    #   ly_points(c(letra[,7],pto_sp_tif()[,4]),c(letra[,15],pto_sp_tif()[,7]),rbind.data.frame(letra1,pto_sp_tif()),hover=list("Nombre"=c(as.character(letra[,2]),as.character(pto_sp_tif()[,1])),"Fecha de operación"=c(letra[,3],pto_sp_tif()[,2]))) %>%
    
    #names(letra1)=names(a[[2]])
    
    isolate(
    figure(width = 1000,height = 400) %>%
      ly_points(c(letra[,7],a[[2]][,4]),c(letra[,15],a[[2]][,7]),rbind.data.frame(letra1,a[[2]]),hover=list("Nombre"=c(as.character(letra[,2]),as.character(a[[2]][,1])),"Fecha de operación"=c(letra[,3],a[[2]][,2]))) %>%
      ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="blue",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
      # theme_title(text_color="green",text_align="center",text_font_style="italic")%>%
      x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
    )
    
    }else{}
    
   # }) #final isolate
    
  })
  
  #comparativo
  output$c_veb_splines_comp <- renderRbokeh({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # y <-predict(Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num = input$d_veb_comp,par = input$parametro_veb_comp,tit=c(input$v1_comp,input$v2_comp,input$v3_comp,input$v4_comp),car,pr=tv_comp())[[4]],seq(0.1,20,0.1)*365)$y
    a <- try(tabla_sp_veb_comp())
    
    if(class(a)!="try-error"){
    y <-predict(a[[4]],seq(0.1,20,0.1)*365)$y
    
    
    #letra <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())[[3]]
    letra <- a[[3]]
    letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    
    # names(letra1)=names(pto_sp_tif())
    # 
    # figure(width = 1000,height = 400) %>%
    #   ly_points(c(letra[,7],pto_sp_tif()[,4]),c(letra[,15],pto_sp_tif()[,7]),rbind.data.frame(letra1,pto_sp_tif()),hover=list("Nombre"=c(as.character(letra[,2]),as.character(pto_sp_tif()[,1])),"Fecha de operación"=c(letra[,3],pto_sp_tif()[,2]))) %>%
    
    names(letra1)=names(a[[2]])
    
    figure(width = 1000,height = 400) %>%
      ly_points(c(letra[,7],a[[2]][,4]),c(letra[,15],a[[2]][,7]),rbind.data.frame(letra1,a[[2]]),hover=list("Nombre"=c(as.character(letra[,2]),as.character(a[[2]][,1])),"Fecha de operación"=c(letra[,3],a[[2]][,2]))) %>%
      ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="blue",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
      # theme_title(text_color="green",text_align="center",text_font_style="italic")%>%
      x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)")  
    
    }else{}
  })
  
  #titulos candidatos
  #funcion que calcula una sola vez valores de funcion "Tabla Spline"
  #TIF
  tabla_sp_tif <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=sp1(),car,pr=tf_sp())
    return(a)
  })
  
  #VEBONOS
  tabla_sp_veb <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    a <- Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n4,num = input$d_veb,par = input$parametro_veb,tit=sp2(),car,pr=tv_sp())
    return(a)
  })
  
  
  #tif
  output$tit_cand_tif <- renderDataTable({
    #Tabla.splines(data = data_splines,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),C_splines,pr=tf_sp())[[2]]
     # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
     # dat[,3] <- as.Date(as.character(dat[,3]))
     # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    #return(car)
     # #print(str(data_splines))
    # #print(str(dat))
     #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())
    #agrego dependencia 
    input$boton11 
    
    #
    a <- isolate(try(tabla_sp_tif()))
     
     if(class(a)!="try-error"){
     letra <- a[[3]]
     letra[,6] <- as.Date(letra[,6])
     letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
     cand <- a[[2]]
     
     
     names(letra1)=names(cand)
     
     a1 <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
     return(a1)
     }else{
       Aviso <- "Poca cantidad de observaciones, favor seleccionar mas días"
       return(as.data.frame(Aviso))
     }
     #Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())[[2]]
    
     })
  
  #comparativo
  #creo funcion para llamar una sola vez a la funcion splines
  tabla_sp_tif_comp <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    Tabla.splines(data = dat,tipo = "TIF",fe=input$n5,num = input$d_tif_comp,par = input$parametro_tif_comp,tit=comp1(),car,pr=tf_comp())
  })
  
  
  output$tit_cand_tif_comp <- renderDataTable({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # Tabla.splines(data = dat,tipo = "TIF",fe=input$n5,num = input$d_tif_comp,par = input$parametro_tif_comp,tit=c(input$t1_comp,input$t2_comp,input$t3_comp,input$t4_comp),car,pr=tf_comp())[[2]] 
    a <- try(tabla_sp_tif_comp())
    
    if(class(a)!="try-error"){
    
    letra <- a[[3]]
    letra[,6] <- as.Date(letra[,6])
    letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    cand <- a[[2]]
    
    
    names(letra1)=names(cand)
    
    a1 <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
    return(a1)
    }else{
      Aviso <- "Poca cantidad de observaciones, favor seleccionar mas días"
      return(as.data.frame(Aviso))
    }
  
    })
  
  
  #veb
  output$tit_cand_veb <- renderDataTable({
    #Tabla.splines(data = data_splines,tipo = "VEBONO",fe=input$n4,num = input$d_veb,par = input$parametro_veb,tit=c(input$v1_sp,input$v2_sp,input$v3_sp,input$v4_sp),C_splines,pr=tv_sp())[[2]] 
     # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
     # dat[,3] <- as.Date(as.character(dat[,3]))
     # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
     # 
     # Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n4,num = input$d_veb,par = input$parametro_veb,tit=c(input$v1_sp,input$v2_sp,input$v3_sp,input$v4_sp),car,pr=tv_sp())[[2]] 
     # 
    #pongo dependencia
    input$boton13
    
    #
    #isolate({
    a <- isolate(try(tabla_sp_veb()))
    
    if(class(a)!="try-error"){
      
    letra <- a[[3]]
    #condicional letra
    if(is.null(names(letra))){
      #print(letra)
      letra1 <- data.frame("LETRA","2019-01-01","2019-01-01",letra[1],99,0,letra[2],"Corto Plazo","C1")
      letra1[,2] <- as.Date(letra1[,2])
      letra1[,3] <- as.Date(letra1[,3])
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a1 <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      return(a1)
    }else{
      letra[,6] <- as.Date(letra[,6])
      letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a1 <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      return(a1)
      
      }
    
    
    }else{
      Aviso <- "Poca cantidad de observaciones, favor seleccionar mas días"
      return(as.data.frame(Aviso))
    }
    #}) #final isolate
    
    })
  
  #comparativo
  #creo funcion auxiliar para llamar una sola vez a funcion splines
  tabla_sp_veb_comp <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num = input$d_veb_comp,par = input$parametro_veb_comp,tit=comp2(),car,pr=tv_comp()) 
  })
  
  output$tit_cand_veb_comp <- renderDataTable({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num = input$d_veb_comp,par = input$parametro_veb_comp,tit=c(input$v1_comp,input$v2_comp,input$v3_comp,input$v4_comp),car,pr=tv_comp())[[2]] 
    #tabla_sp_veb_comp()[[2]]
    
    a <- try(tabla_sp_veb_comp())
    
    if(class(a)!="try-error"){
    letra <- a[[3]]
    letra[,6] <- as.Date(letra[,6])
    letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    cand <- a[[2]]
    
    
    names(letra1)=names(cand)
    
    a1 <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
    return(a1)
    
    }else{
      Aviso <- "Poca cantidad de observaciones, favor seleccionar mas días"
      return(as.data.frame(Aviso))
    }
    
    })
  
  
  
  #extraigo puntos con los q se hace la curva
  #tif
  pto_sp_tif <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    
    a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())[[2]]
    
    #a <- Tabla.splines(data = data_splines,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),C_splines,pr=tf_sp())[[2]]
    # a1 <- cbind.data.frame(a$Plazo,a$Rendimiento)
    # names(a1) <- c("Plazo","Rendimiento")
    return(a)
    })
  
  #comparativo
  pto_sp_tif_comp <- reactive({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n5,num = input$d_tif_comp,par = input$parametro_tif_comp,tit=c(input$t1_comp,input$t2_comp,input$t3_comp,input$t4_comp),car,pr=tf_comp())[[2]]
    a <- tabla_sp_tif_comp()[[2]]
    # a1 <- cbind.data.frame(a$Plazo,a$Rendimiento)
    # names(a1) <- c("Plazo","Rendimiento")
    return(a)
  })
  
  #veb
  pto_sp_veb <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    a <- Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n4,num = input$d_veb,par = input$parametro_veb,tit=c(input$v1_sp,input$v2_sp,input$v3_sp,input$v4_sp),car,pr=tv_sp())[[2]]
    # a1 <- cbind.data.frame(a$Plazo,a$Rendimiento)
    # names(a1) <- c("Plazo","Rendimiento")
    return(a)
  })
  
  #comparativo
  pto_sp_veb_comp <- reactive({
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # a <- Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num = input$d_veb_comp,par = input$parametro_veb_comp,tit=c(input$v1_comp,input$v2_comp,input$v3_comp,input$v4_comp),car,pr=tv_comp())[[2]]
    a <- tabla_sp_veb_comp()[[2]]
    # a1 <- cbind.data.frame(a$Plazo,a$Rendimiento)
    # names(a1) <- c("Plazo","Rendimiento")
    return(a)
  })
  
  
  #output$datos <- renderPrint({pto_sp_tif()})
  
  #COMPARATIVO DE PRECIOS
  #tif
  gra_tif_ns_comp_i <- reactive({
    #Tabla.ns(fv = input$n5 ,tit = comp1(),pr =tf_comp() ,pa = c(1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=1,fe3=0)[[2]] 
    Tabla.ns(fv = input$n5 ,tit = comp1(),pr =TF_NSC() ,pa = c(1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=1,fe3=0)[[2]] 
    })
  
  gra_tif_sven_comp_i <- reactive({
    #Tabla.sven(fv = input$n5 ,tit = comp1(),pr =tf_comp() ,pa = c(1,1,1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=1,fe3=0)[[2]] 
    Tabla.sven(fv = input$n5 ,tit = comp1(),pr =TF_SV() ,pa = c(1,1,1,1,1,1),ind = 0,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=1,fe3=0)[[2]] 
    })
  
  
  precios_tif <- reactive({
    #ojo con los dos primeros
    withProgress(message = 'Calculando precios...', value = 0, {
      incProgress(1/5, detail = "Metodología Nelson y Siegel")
      dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
      dat[,3] <- as.Date(as.character(dat[,3]))
      car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    #a <-   Tabla.ns(fv = input$n5 ,tit = comp1(),pr =tf_comp() ,pa = gra_tif_ns_comp_i(),ind = 0,C = car,fe2=0,fe3=0)[[3]]
    a <-   Tabla.ns(fv = input$n5 ,tit = comp1(),pr =TF_NSC() ,pa = gra_tif_ns_comp_i(),ind = 0,C = car,fe2=0,fe3=0)[[3]]
    incProgress(1/5, detail = "Metodología Svensson")
    #b <-   Tabla.sven(fv = input$n5 ,tit = comp1(),pr =tf_comp() ,pa = gra_tif_sven_comp_i() ,ind = 0,C = car,fe2=0,fe3=0)[[3]]
    b <-   Tabla.sven(fv = input$n5 ,tit = comp1(),pr =TF_SV() ,pa = gra_tif_sven_comp_i() ,ind = 0,C = car,fe2=0,fe3=0)[[3]]
    #
    incProgress(1/5, detail = "Metodología Diebold-Li")
    c <-   precio.dl(tit = comp1(),fv = input$n5 ,C = car ,pa = c(1,1,1,1),spline1 = dl_spline_tif_comp(),pr=tf_comp())[[2]]
    incProgress(1/5, detail = "Metodología Splines")
    d <-   Tabla.splines(data = dat,tipo = "TIF",fe=input$n5,num = input$d_tif_comp,par = input$parametro_tif_comp,tit=comp1(),car,pr=tf_comp())[[1]]
    
    })
    
    #f <- cbind.data.frame(c(tf_comp(),0),a[,2],b[,2],c[,2],d[,2])
    #podria servir TF_NSC tambien
    f <- cbind.data.frame(c(TF_SV(),0),a[,2],b[,2],c[,2],d[,2])
    names(f) <- c("Precio Promedio","Nelson y Siegel","Svensson","Diebold-Li","Splines")
    #row.names(f)[length(f[,1])] <- "SRC"
    row.names(f)[dim(f)[1]] <- "SRC"
    
    #modifico ultima fila de c y d con el fin de calcular el SRC
    a1 <- Tabla.ns(fv = input$n5 ,tit = comp1(),pr =TF_NSC() ,pa = gra_tif_ns_comp_i(),ind = 0,C = car,fe2=0,fe3=0)[[1]]
    pond <- as.numeric(sub(",",".",a1[12,]))
    
    #SRC DL
    a2 <- sum(((c[1:(nrow(f)-1),2]-f[1:(nrow(f)-1),1])*pond)^2)
    f[nrow(f),4] <- a2
    
    #SRC SP
    a3 <- sum(((d[1:(nrow(f)-1),2]-f[1:(nrow(f)-1),1])*pond)^2)
    f[nrow(f),5] <- a3
    
    return(f)
    
  })
  
  output$comparativo_precios_tif <- renderDataTable({
    a <- try(precios_tif())
    if(class(a)!="try-error"){
      a
    }else{}
    })
  
  
  #veb
  gra_veb_ns_comp_i <- reactive({
    #Tabla.ns(fv = input$n5 ,tit = comp2(),pr =tv_comp() ,pa = c(1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=1,fe3=0)[[2]] 
    Tabla.ns(fv = input$n5 ,tit = comp2(),pr =TV_NSC() ,pa = c(1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=1,fe3=0)[[2]] 
    })
  
  gra_veb_sven_comp_i <- reactive({
    #Tabla.sven(fv = input$n5 ,tit = comp2(),pr =tv_comp() ,pa = c(1,1,1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=1,fe3=0)[[2]] 
    Tabla.sven(fv = input$n5 ,tit = comp2(),pr =TV_SV() ,pa = c(1,1,1,1,1,1),ind = 1,C = Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")),fe2=1,fe3=0)[[2]] 
    })
  
  
  precios_veb <- reactive({
    #ojo con los dos primeros
    withProgress(message = 'Calculando precios...', value = 0, {
      incProgress(1/5, detail = "Metodología Nelson y Siegel")
      dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
      dat[,3] <- as.Date(as.character(dat[,3]))
      car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
     #a <-   Tabla.ns(fv = input$n5 ,tit = comp2(),pr =tv_comp() ,pa = gra_veb_ns_comp_i(),ind = 1,C = car,fe2=0,fe3=0)[[3]]
     a <-   Tabla.ns(fv = input$n5 ,tit = comp2(),pr =TV_NSC() ,pa = gra_veb_ns_comp_i(),ind = 1,C = car,fe2=0,fe3=0)[[3]]
     incProgress(1/5, detail = "Metodología Svensson")
     #b <-   Tabla.sven(fv = input$n5 ,tit = comp2(),pr =tv_comp() ,pa = gra_veb_sven_comp_i() ,ind = 1,C = car,fe2=0,fe3=0)[[3]]
     b <-   Tabla.sven(fv = input$n5 ,tit = comp2(),pr =TV_SV() ,pa = gra_veb_sven_comp_i() ,ind = 1,C = car,fe2=0,fe3=0)[[3]]
     #
     incProgress(1/5, detail = "Metodología Diebold-Li")
     c <-   precio.dl(tit = comp2(),fv = input$n5 ,C = car ,pa = c(1,1,1,1),spline1 = dl_spline_veb_comp(),pr=tv_comp())[[2]]
     incProgress(1/5, detail = "Metodología Splines")
      d <-   Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num = input$d_veb_comp,par = input$parametro_veb_comp,tit=comp2(),car,pr=tv_comp())[[1]]
    
    })
     
    #podria servir TV_NSC tambien
     #f <- cbind.data.frame(c(tv_comp(),0),a[,2],b[,2],c[,2],d[,2])
    f <- cbind.data.frame(c(TV_SV(),0),a[,2],b[,2],c[,2],d[,2])
    names(f) <- c("Precio Promedio","Nelson y Siegel","Svensson","Diebold-Li","Splines")
     #row.names(f)[length(f[,1])] <- "SRC"
     row.names(f)[dim(f)[1]] <- "SRC"
    
     
     #modifico ultima fila de c y d con el fin de calcular el SRC
     a1 <- Tabla.ns(fv = input$n5 ,tit = comp2(),pr =TV_NSC() ,pa = gra_veb_ns_comp_i(),ind = 1,C = car,fe2=0,fe3=0)[[1]]
     pond <- as.numeric(sub(",",".",a1[12,]))
     
     #SRC DL
     a2 <- sum(((c[1:(nrow(f)-1),2]-f[1:(nrow(f)-1),1])*pond)^2)
     f[nrow(f),4] <- a2
     
     #SRC SP
     a3 <- sum(((d[1:(nrow(f)-1),2]-f[1:(nrow(f)-1),1])*pond)^2)
     f[nrow(f),5] <- a3
     
     return(f)
    
  })
  
  output$comparativo_precios_veb <- renderDataTable({
    a <- try(precios_veb())
    if(class(a)!="try-error"){
      a
    }else{}
    })
  
  #Graficas comparativos
  #tif
  spline_tif_comp <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    Tabla.splines(data = dat,tipo = "TIF",fe=input$n5,num =input$d_tif_comp,par = input$parametro_tif_comp,tit=comp1(),car,pr=tf_comp())[[4]] 
    })
  
  dl_spline_tif_comp_i <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    Tabla.splines(data = dat,tipo = "TIF",fe=input$n5,num =input$d_tif_comp,par = input$parametro_tif_dl_comp,tit=comp1(),car,pr=tf_comp())[[4]] 
    })
  
  

  dl_tif <- reactive({
  #defino eje maduracion
  X1 <- seq(0.1,20,0.1)
  
  #defino tiempos
  Y1 <- seq(1,50,1)
  
  #
  var_par <- as.data.frame(matrix(0,length(Y1),4))
  
  #guardo parametros segun cada tiempo
  for(i in 1:length(Y1)){
    #var_par[i,] <- par_dl(t[i],spline1,pa=c(1,1,1,1))
    var_par[i,] <- par_dl(Y1,dl_spline_tif_comp_i(),pa=c(1,1,1,1))
    
  }
  
  return(var_par[dim(var_par)[1],])
  })
  
  
  #TIF
  output$curva_comp_tif <- renderPlotly({ 
    #data
    x <- seq(1,20,0.1)
    withProgress(message = 'Calculando alturas...', value = 0, {
    #y_ns <- c(0.0097,nelson_siegel(x[2:length(x)],pa=gra_tif_ns_comp_i()))*100
    incProgress(1/5, detail = "Metodología Nelson y Siegel")
    y_ns <- try(nelson_siegel(x,pa=gra_tif_ns_comp_i())*100)
    incProgress(1/5, detail = "Metodología Svensson")
    y_sven <- try(sven(x,pa=gra_tif_sven_comp_i())*100)
    incProgress(1/5, detail = "Metodología Diebold-Li")
    y_dl <- try(diebold_li(pa=as.numeric(dl_tif()),x)*100)
    incProgress(1/5, detail = "Metodología Splines")
    y_sp <- try(predict(spline_tif_comp(),x*365)$y)
  
    })
    
    if(class(y_ns)!="try-error" & class(y_sven)!="try-error" & class(y_dl)!="try-error" & class(y_sp)!="try-error"){
    #dataframe
    data <- data.frame(x,y_ns,y_sven,y_dl,y_sp)
    
    #curva 
    #defino nombres de ejes
    f <- list(
      family = "Courier New, monospace",
      size = 18,
      color = "#7f7f7f"
    )
    x1 <- list(
      title = "Maduración (días)",
      titlefont = f
    )
    y1 <- list(
      title = "Rendimientos (%)",
      titlefont = f
    )
    
    #
    plot_ly(data, x = ~x, y = ~y_ns, name = 'Nelson y Siegel', type = 'scatter', mode = 'lines') %>% 
    add_trace(y = ~y_sven, name = 'Svensson', mode = 'lines') %>% 
    add_trace(y = ~y_dl, name = 'Diebold-Li', mode = 'lines') %>% 
    add_trace(y = ~y_sp, name = 'Splines', mode = 'lines') %>%
     layout(title = "Curvas de Rendimientos TIF",xaxis = x1, yaxis = y1)
      
    }else{}
    
    })
  
  #VEBONOS
  
  spline_veb_comp <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num =input$d_veb_comp,par = input$parametro_veb_comp,tit=comp2(),car,pr=tv_comp())[[4]]
    #tabla_sp_dl_veb_comp()[[4]]
    })
  
  dl_spline_veb_comp_i <- reactive({
    dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    Tabla.splines(data = dat,tipo = "VEBONO",fe=input$n5,num =input$d_veb_dl_comp,par = input$parametro_veb_dl_comp,tit=comp2(),car,pr=tv_comp())[[4]]
    })
  
  
  
  dl_veb <- reactive({
    #defino eje maduracion
    X1 <- seq(0.1,20,0.1)
    
    #defino tiempos
    Y1 <- seq(1,50,1)
    
    #
    var_par <- as.data.frame(matrix(0,length(Y1),4))
    
    #guardo parametros segun cada tiempo
    for(i in 1:length(Y1)){
      #var_par[i,] <- par_dl(t[i],spline1,pa=c(1,1,1,1))
      var_par[i,] <- par_dl(Y1,dl_spline_veb_comp_i(),pa=c(1,1,1,1))
      
    }
    
    return(var_par[dim(var_par)[1],])
  })
  
  
  #TIF
  output$curva_comp_veb <- renderPlotly({ 
    #data
    x <- seq(1,20,0.1)
    withProgress(message = 'Calculando alturas...', value = 0, {
      incProgress(1/5, detail = "Metodología Nelson y Siegel")  
    y_ns <- try(nelson_siegel(x,pa=gra_veb_ns_comp_i())*100)
    incProgress(1/5, detail = "Metodología Svensson")
    y_sven <- try(sven(x,pa=gra_veb_sven_comp_i())*100)
    incProgress(1/5, detail = "Metodología Diebold-Li")
    y_dl <- try(diebold_li(pa=as.numeric(dl_veb()),x)*100)
    incProgress(1/5, detail = "Metodología Splines")
    y_sp <- try(predict(spline_veb_comp(),x*365)$y)
    })
    
    
    if(class(y_ns)!="try-error" & class(y_sven)!="try-error" & class(y_dl)!="try-error" & class(y_sp)!="try-error"){
    #dataframe
    data <- data.frame(x,y_ns,y_sven,y_dl,y_sp)
    
    #curva 
    #defino nombres de ejes
    f <- list(
      family = "Courier New, monospace",
      size = 18,
      color = "#7f7f7f"
    )
    x1 <- list(
      title = "Maduración (días)",
      titlefont = f
    )
    y1 <- list(
      title = "Rendimientos (%)",
      titlefont = f
    )
    
    #
    plot_ly(data, x = ~x, y = ~y_ns, name = 'Nelson y Siegel', type = 'scatter', mode = 'lines') %>%
      add_trace(y = ~y_sven, name = 'Svensson', mode = 'lines') %>% 
      add_trace(y = ~y_dl, name = 'Diebold-Li', mode = 'lines') %>% 
      add_trace(y = ~y_sp, name = 'Splines', mode = 'lines') %>%
      layout(title = "Curvas de Rendimientos VEBONO",xaxis = x1, yaxis = y1)
    
    }else{}
    
  })
  
  # Reporte código genérico
  
  output$report <- downloadHandler(
    filename = "reporte1.pdf",
    content = function(file) {
      tempReport <- file.path(tempdir(), "reporte1.Rmd")
      #tempReport <- file.path(getwd(), "reporte1.Rmd")
      
      file.copy("reporte1.Rmd", tempReport, overwrite = TRUE)
      
      # Configuración de parámetros pasados a documento Rmd
      params <- list(fecha = input$n5,
                    titulos = comp1(),
                    pre_prom = tf_comp(),
                    par_ns_t = gra_tif_ns_comp_i(),
                    par_sven_t= gra_tif_sven_comp_i(),
                    par_dl_t=dl_tif(),
                    par_sp_t=spline_tif_comp(),
                    comp_pre_t=precios_tif()
                    
                    
                     # data2 = data()$corriente,
                     # data3 = data()$corriente.rem,
                     # dist1 = input$distVarA,
                     # dist2 = input$distVarC,
                     # dist3 = input$distVarCR,
                     # pconf = input$porVar,
                     # reali = input$reali,
                     # revi = input$revi
                     )
      
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempReport, output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
      )
    })
  
  #reporte vebonos
  output$report1 <- downloadHandler(
    filename = "reporte2.pdf",
    content = function(file) {
      tempReport <- file.path(tempdir(), "reporte2.Rmd")
      #tempReport <- file.path(getwd(), "reporte1.Rmd")
      
      file.copy("reporte2.Rmd", tempReport, overwrite = TRUE)
      
      # Configuración de parámetros pasados a documento Rmd
      params <- list(fecha = input$n5,
                     titulos = comp2(),
                     pre_prom = tv_comp(),
                     par_ns_v = gra_veb_ns_comp_i(),
                     par_sven_v= gra_veb_sven_comp_i(),
                     par_dl_v=dl_veb(),
                     par_sp_v=spline_veb_comp(),
                     comp_pre_v=precios_veb()
                     
                     
                     # data2 = data()$corriente,
                     # data3 = data()$corriente.rem,
                     # dist1 = input$distVarA,
                     # dist2 = input$distVarC,
                     # dist3 = input$distVarCR,
                     # pconf = input$porVar,
                     # reali = input$reali,
                     # revi = input$revi
      )
      
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempReport, output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
      )
    })
  
  #descarga BCV
  
  
  # datasetInput <- reactive({
  #   switch(input$dataset,
  #          "0-22" = ruta_bcv("0-22"),
  #          "Caracteristicas" = ruta_bcv("caracteristicas"))
  # })
  
  #output$desc <- renderPrint({ input$dataset })
  
    # Downloadable csv of selected dataset ----
  # output$downloadData <- downloadHandler(
  #   filename = function() {
  #     paste(input$dataset, ".xls", sep = "")
  #   },
  #   content = function(file) {
  #     file<-paste(getwd(),"data",paste(input$dataset, ".xls", sep = ""),sep="/")
  #     #antes en method estaba libcurl
  #     download.file(url=datasetInput(),destfile=file,method = "internal",mode="wb")
  #     #GET(datasetInput(), write_disk(file, overwrite=TRUE))
  #     #write.xlsx(datasetInput(), file, row.names = FALSE)
  #   }
  # )
  
  #leo caracteristica guardada en carpeta data
  # output$Ca_leida <- renderDataTable({
  #   ca <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
  #   if(class(ca)=="try-error"){
  #     Aviso <- print("El archivo no se encuentra, descargar y recargar página!")
  #     #return(datatable(Aviso, options = list(paging = FALSE)))
  #     return(as.data.frame(Aviso))
  #   }else{
  #   #return(datatable(ca, options = list(paging = FALSE)))
  #     return(ca)
  #   }
  #   })
  # 
  #leo documento 022
  # output$docbcv <- renderDataTable({
  #   ca <- try(Preciosbcv(paste(getwd(),"data","0-22.xls",sep = "/")))
  #   ca1 <- try(Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/")))
  #   
  #   if(class(ca)=="try-error" | class(ca1)=="try-error" ){
  #     Aviso <- print("El archivo no se encuentra, descargar y recargar página!")
  #     return(as.data.frame(Aviso))
  #   }else{
  #     #condicional cuando no hay obs
  #     if(is.null(dim(ca))){
  #       Aviso <- "No existen operaciones para el mes actual"
  #       return(as.data.frame(Aviso))
  #     }else{
  #     
  #     ca2 <- formatop(ca1,ca)
  #     #convierto fecha de op y venc en fechas
  #     ca2$`Fecha op` <- as.Date(as.character(ca2$`Fecha op`),format="%d/%m/%Y")
  #     ca2$F.Vencimiento <- as.Date(as.character(ca2$F.Vencimiento),format="%d/%m/%Y")
  # 
  #     #este data frame es el que utiliza la metodologia Spline para los calculos
  #     ca3 <- dplyr::arrange(ca2,(`Fecha op`))
  # 
  #     #guardo historico_actualizado
  #     hist <- read.csv(paste(getwd(),"data","Historico.txt",sep = "/"),sep="")
  #     hist[,3] <- as.Date(as.character(hist[,3]))
  #     hist[,6] <- as.Date(as.character(hist[,6]))
  # 
  # 
  #     names(ca3)=names(hist)
  #    #print(str(ca3))
  #    #print(str(hist))
  # 
  #     hist_act <- rbind.data.frame(hist,ca3)
  # 
  # 
  #     write.table(hist_act,paste(getwd(),"data","Historico_act.txt",sep = "/"),row.names = FALSE)
  # 
  #     return(ca3)
  #     }#final condicional no hay operaciones
  #   }
  # })
  # 
  
  # output$pre_prom_tif <- renderPrint({
  #           #leo el historico actualizado
  #           hist <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
  #           
  #           #como primer enfoque busco todos los tif y veb
  #           #luego se puede buscar solamente los tit seleccionados
  #           #no seria muy dificil este cambio
  #           hist_19 <- pre_prom(hist,"2019")
  #           hist_18 <- pre_prom(hist,"2018")
  #           hist_17 <- pre_prom(hist,"2017")
  #           hist_16 <- pre_prom(hist,"2016")
  #           
  #           #para buscar tif uso hist_18 u otro año y uso el segundo 
  #           #elemento de la lista
  #           #busco tif de mi cartera en historico 2018
  #           tif_19 <- comp(tit,hist_19[[2]])
  #           
  #           #los tif que no encuentro en 2018 los busco en 2017
  #           if(length(tif_19[[2]])!=0){
  #             tif_18 <- comp(tif_19[[2]],hist_18[[2]])
  #           }else{
  #             print("Todos los instrumentos estan")
  #           }
  #           
  #           ##tif_18 <- comp(tit,hist_18[[2]])
  #           
  #           #los tif que no encuentro en 2018 los busco en 2017
  #           if(length(tif_18[[2]])!=0){
  #             tif_17 <- comp(tif_18[[2]],hist_17[[2]])
  #           }else{
  #             print("Todos los instrumentos estan")
  #           }
  #           
  #           #los tif que no encuentro en 2017 los busco en 2016
  #           if(length(tif_17[[2]])!=0){
  #             tif_16 <- comp(tif_17[[2]],hist_16[[2]])
  #           }else{
  #             print("Todos los instrumentos estan")
  #           }
  #           
  #           #precios promedio que salen
  #           #TIF <- rbind.data.frame(tif_18[[1]],tif_17[[1]],tif_16[[1]])
  #           TIF <- rbind.data.frame(tif_19[[1]],tif_18[[1]],tif_17[[1]],tif_16[[1]])
  #           
  #           names(TIF) <- c("Títulos","Precio Promedio","Año")
  #           write.table(TIF,paste(getwd(),"data","Precio_prom_tif.txt",sep = "/"),row.names = FALSE)
  #           
  #           
  #           #titulos tif que no salen
  #           no_tif <- as.data.frame(tif_16[[2]])
  #           names(no_tif) <- "Títulos faltantes"
  #           write.table(no_tif,paste(getwd(),"data","Tif_faltantes.txt",sep = "/"),row.names = FALSE)
  #           
  #           
  #           #return(TIF)
  #           print("Titulos en historico")
  #           print(TIF)
  #           
  #           print("Titulos que no salen")
  #           print(no_tif)
  # 
  #           
  #           
  #                         })
    
    
  # output$pre_prom_veb <- renderPrint({
  #   #leo el historico actualizado
  #   hist <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
  #   
  #   #como primer enfoque busco todos los tif y veb
  #   #luego se puede buscar solamente los tit seleccionados
  #   #no seria muy dificil este cambio
  #   hist_19 <- pre_prom(hist,"2019")
  #   hist_18 <- pre_prom(hist,"2018")
  #   hist_17 <- pre_prom(hist,"2017")
  #   hist_16 <- pre_prom(hist,"2016")
  #   
  #   #para buscar tif uso hist_18 u otro año y uso el tercer 
  #   #elemento de la lista
  #   #busco veb de mi cartera en historico 2018
  #   veb_19 <- comp(tit1,hist_19[[3]])
  #   #veb_18 <- comp(tit1,hist_18[[3]])
  #   
  #   #los tif que no encuentro en 2019 los busco en 2018
  #   if(length(veb_19[[2]])!=0){
  #     veb_18 <- comp(veb_19[[2]],hist_18[[3]])
  #   }else{
  #     print("Todos los instrumentos estan")
  #   }
  #   
  #   #los tif que no encuentro en 2018 los busco en 2017
  #   if(length(veb_18[[2]])!=0){
  #     veb_17 <- comp(veb_18[[2]],hist_17[[3]])
  #   }else{
  #     print("Todos los instrumentos estan")
  #   }
  #   
  #   #los tif que no encuentro en 2017 los busco en 2016
  #   if(length(veb_17[[2]])!=0){
  #     veb_16 <- comp(veb_17[[2]],hist_16[[3]])
  #   }else{
  #     print("Todos los instrumentos estan")
  #   }
  #   
  #   #precios promedio que salen
  #   #VEB <- rbind.data.frame(veb_18[[1]],veb_17[[1]],veb_16[[1]])
  #   VEB <- rbind.data.frame(veb_19[[1]],veb_18[[1]],veb_17[[1]],veb_16[[1]])
  #   
  #   names(VEB) <- c("Títulos","Precio Promedio","Año")
  #   write.table(VEB,paste(getwd(),"data","Precio_prom_veb.txt",sep = "/"),row.names = FALSE)
  #   
  #   
  #   #titulos tif que no salen
  #   no_veb <- as.data.frame(veb_16[[2]])
  #   names(no_veb) <- "Títulos faltantes"
  #   write.table(no_veb,paste(getwd(),"data","Veb_faltantes.txt",sep = "/"),row.names = FALSE)
  #   
  #   
  #   #return(TIF)
  #   print("Titulos en historico")
  #   print(VEB)
  #   
  #   print("Titulos que no salen")
  #   print(no_veb)
  #   
  #   
  #   
  # })
  
  #opcion eliminar SPLINES
  # output$tabla_elim_tif <- renderDataTable({
  #   if(input$elim_tif==1){
  #       
  # 
  #   }else{
  #     Aviso <- "No se eliminarán observaciones iniciales"
  #     return(as.data.frame(Aviso))
  #   }
  # })
  
  #calculo candidatos a elimnar
  #TIF
  obs_elim_tif <- reactive({
    #Tabla.splines(data = data_splines,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),C_splines,pr=tf_sp())[[2]]
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # #return(car)
    # #print(str(data_splines))
    # #print(str(dat))
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())[[2]]
    
     #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())
    #agrego dependencia 
    #input$boton12 
    
    a <- (try(tabla_sp_tif()))
     
     if(class(a)!="try-error"){
     letra <- a[[3]]
     cand <- a[[2]]
     
     a1 <- c(as.character(letra[,2]),as.character(cand[,1]))
     return(as.character(a1))
     }else{}
    #return(as.character(a[,1]))
  })
  
  #TIF-COMP
  obs_elim_tif_comp <- reactive({
    #Tabla.splines(data = data_splines,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),C_splines,pr=tf_sp())[[2]]
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # #return(car)
    # #print(str(data_splines))
    # #print(str(dat))
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())[[2]]
    
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())
    a <- try(tabla_sp_tif_comp())
    
    if(class(a)!="try-error"){
    letra <- a[[3]]
    cand <- a[[2]]
    
    a1 <- c(as.character(letra[,2]),as.character(cand[,1]))
    return(as.character(a1))
    #return(as.character(a[,1]))
    }else{}
    
  })
  
  #VEBONO
  obs_elim_veb <- reactive({
    a <- try(tabla_sp_veb())
    
    if(class(a)!="try-error"){
    letra <- a[[3]]
    cand <- a[[2]]
    
    a1 <- c(as.character(letra[,2]),as.character(cand[,1]))
    return(as.character(a1))
    }else{}
    
  })

  #VEBONO-COMP
  obs_elim_veb_comp <- reactive({
    #Tabla.splines(data = data_splines,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),C_splines,pr=tf_sp())[[2]]
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # #return(car)
    # #print(str(data_splines))
    # #print(str(dat))
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())[[2]]
    
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())
    a <- try(tabla_sp_veb_comp())
    
    if(class(a)!="try-error"){
    letra <- a[[3]]
    cand <- a[[2]]
    
    a1 <- c(as.character(letra[,2]),as.character(cand[,1]))
    return(as.character(a1))
    #return(as.character(a[,1]))
    }else{}
    
  })
  
  #hago el imputselect interactivo
  #TIF
  output$selectUI_tif <- renderUI({ 

    selectInput("obs_tif", "Seleccionar títulos", obs_elim_tif(),multiple = TRUE)
    
     })
  
  #TIF - COMPARATIVO
  output$selectUI_tif_comp <- renderUI({ 
    selectInput("obs_tif_comp", "Seleccionar títulos", obs_elim_tif_comp(),multiple = TRUE)
  })
  
  
  #VEBONO
  output$selectUI_veb <- renderUI({ 
    selectInput("obs_veb", "Seleccionar títulos", obs_elim_veb(),multiple = TRUE)
  })
  
  #VEBONO - COMPARATIVO
  output$selectUI_veb_comp <- renderUI({ 
    selectInput("obs_veb_comp", "Seleccionar títulos", obs_elim_veb_comp(),multiple = TRUE)
  })
  
  #imprimo titulos seleccionados a eliminar
  #TIF
  output$obs_elim_tif <- renderPrint(input$obs_tif)
  
  #TIF-COMP
  output$obs_elim_tif_comp <- renderPrint(input$obs_tif_comp)
  
  
  #VEBONO
  output$obs_elim_veb <- renderPrint(input$obs_veb)
  
  #VEBONO-COMP
  output$obs_elim_veb_comp <- renderPrint(input$obs_veb_comp)
  
  #muestro nuevos candidatos
  #TIF
  output$tit_cand_tif_new <- renderDataTable({
    #Tabla.splines(data = data_splines,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),C_splines,pr=tf_sp())[[2]]
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # #return(car)
    # #print(str(data_splines))
    # #print(str(dat))
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())[[2]]
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())
    #agrego dependencia 
    input$boton12
    
    #
    isolate({ 
    a <- try(tabla_sp_tif())
    
    if(class(a)!="try-error"){
      
     
    letra <- (a[[3]])
    letra[,6] <- (as.Date(letra[,6]))
    letra1 <- (data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1"))
    cand <- (a[[2]])
    
    
    names(letra1)=names(cand)
    
    a <- (rbind.data.frame(letra1,cand,make.row.names = FALSE))
    
    
    if(length(input$obs_tif)==0){
      Aviso <- "No se ha seleccionado nada"
      return(as.data.frame(Aviso))
      
    }else{
      
    b <- c()
      
      
    for(i in 1:length(input$obs_tif)){
    b[i] <- (which(input$obs_tif[i]==as.character(a[,1])))
    }
      
    
    #a <- (a[-b,])
    #return(a)
     
      return( (a[-b,]) )
      
    }
    
    
    
    }else{}
    
    }) #final isolate
  })
  
  #TIF - COMP
  
  output$tit_cand_tif_new_comp <- renderDataTable({
    a <- try(tabla_sp_tif_comp())
    
    if(class(a)!="try-error"){
    letra <- a[[3]]
    letra[,6] <- as.Date(letra[,6])
    letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    cand <- a[[2]]
    
    
    names(letra1)=names(cand)
    
    a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
    
    if(length(input$obs_tif_comp)==0){
      Aviso <- "No se ha seleccionado nada"
      return(as.data.frame(Aviso))
      
    }else{
      
      b <- c()
      for(i in 1:length(input$obs_tif_comp)){
        b[i] <- which(input$obs_tif_comp[i]==as.character(a[,1]))
      }
      a <- a[-b,]
      return(a)
      
    }
    
    }else{}
    
  })
  
  
  #VEBONOS
  output$tit_cand_veb_new <- renderDataTable({
    #pongo dependencia
    input$boton14
    
    #
    isolate({
    
    a <- try(tabla_sp_veb())
    
    if(class(a)!="try-error"){
    letra <- a[[3]]
    letra[,6] <- as.Date(letra[,6])
    letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    cand <- a[[2]]
    
    
    names(letra1)=names(cand)
    
    a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
    
    if(length(input$obs_veb)==0){
      Aviso <- "No se ha seleccionado nada"
      return(as.data.frame(Aviso))
      
    }else{
      
      b <- c()
      for(i in 1:length(input$obs_veb)){
        b[i] <- which(input$obs_veb[i]==as.character(a[,1]))
      }
      #a <- a[-b,]
      return(a[-b,])
      
    }
    
    }else{}
    
    }) #final isolate
    
  })
  
  #VEBONOS-COMP
  output$tit_cand_veb_new_comp <- renderDataTable({
    a <- try(tabla_sp_veb_comp())
    
    if(class(a)!="try-error"){
    letra <- a[[3]]
    letra[,6] <- as.Date(letra[,6])
    letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    cand <- a[[2]]
    
    
    names(letra1)=names(cand)
    
    a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
    
    if(length(input$obs_veb_comp)==0){
      Aviso <- "No se ha seleccionado nada"
      return(as.data.frame(Aviso))
      
    }else{
      
      b <- c()
      for(i in 1:length(input$obs_veb_comp)){
        b[i] <- which(input$obs_veb_comp[i]==as.character(a[,1]))
      }
      a <- a[-b,]
      return(a)
      
    }
    
    }else{}
    
  })
  
  #calculo nuevos precios
  #TIF
  output$precios_tif_nuevos <- renderDataTable({
    #agrego dependencia 
    input$boton12
    
    #
    isolate({
    #Tabla.splines(data = data_splines,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),C_splines,pr=tf_sp())[[2]]
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
     car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # #return(car)
    # #print(str(data_splines))
    # #print(str(dat))
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())[[2]]
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())
    a <- (try(tabla_sp_tif()))
    
    if(class(a)!="try-error"){
    letra <- a[[3]]
    letra[,6] <- as.Date(letra[,6])
    letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    cand <- a[[2]]
    
    
    names(letra1)=names(cand)
    
    a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
    
    if(length(input$obs_tif)==0){
      Aviso <- "No se ha eliminado nada, ver tabla anterior"
      return(as.data.frame(Aviso))
      
    }else{
      
      b <- c()
      for(i in 1:length(input$obs_tif)){
        b[i] <- which(input$obs_tif[i]==as.character(a[,1]))
      }
      a <- a[-b,]
      
      
      #calculo spline
      spline <- smooth.spline(a[,4],a[,7],spar = input$parametro_tif)
      
      #calculo precios
      pre <- precio(tit = sp1(),spline1 = spline,fv =input$n4 ,C = car)
      
      pre1 <- cbind.data.frame("Títulos"=sp1(),"Precios"=pre)
      
      return(datatable(pre1, options = list(paging = FALSE)))
    }
    
    }else{}
    
    })
  
  })
  
  #TIF-COMP
  output$precios_tif_nuevos_comp <- renderDataTable({
    #Tabla.splines(data = data_splines,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),C_splines,pr=tf_sp())[[2]]
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # #return(car)
    # #print(str(data_splines))
    # #print(str(dat))
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())[[2]]
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())
    a <- try(tabla_sp_tif_comp())
    
    if(class(a)!="try-error"){
    letra <- a[[3]]
    letra[,6] <- as.Date(letra[,6])
    letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    cand <- a[[2]]
    
    
    names(letra1)=names(cand)
    
    a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
    
    if(length(input$obs_tif_comp)==0){
      Aviso <- "No se ha eliminado nada, ver tabla anterior"
      return(as.data.frame(Aviso))
      
    }else{
      
      b <- c()
      for(i in 1:length(input$obs_tif_comp)){
        b[i] <- which(input$obs_tif_comp[i]==as.character(a[,1]))
      }
      a <- a[-b,]
      
      
      #calculo spline
      spline <- smooth.spline(a[,4],a[,7],spar = input$parametro_tif_comp)
      
      #calculo precios
      pre <- precio(tit = comp1(),spline1 = spline,fv =input$n5 ,C = car)
      
      pre1 <- cbind.data.frame("Títulos"=comp1(),"Precios"=pre)
      
      return(datatable(pre1, options = list(paging = FALSE)))
    }
    
    }else{}
    
  })
  
  
  #VEBONOS
  output$precios_veb_nuevos <- renderDataTable({
    #pongo dependencia
    input$boton14
    
    #
    isolate({
    
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    a <- try(tabla_sp_veb())
    
    if(class(a)!="try-error"){
    letra <- a[[3]]
    letra[,6] <- as.Date(letra[,6])
    letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    cand <- a[[2]]
    
    
    names(letra1)=names(cand)
    
    a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
    
    if(length(input$obs_veb)==0){
      Aviso <- "No se ha eliminado nada, ver tabla anterior"
      return(as.data.frame(Aviso))
      
    }else{
      
      b <- c()
      for(i in 1:length(input$obs_veb)){
        b[i] <- which(input$obs_veb[i]==as.character(a[,1]))
      }
      a <- a[-b,]
      
      
      #calculo spline
      spline <- smooth.spline(a[,4],a[,7],spar = input$parametro_veb)
      
      #calculo precios
      pre <- precio(tit = sp2(),spline1 = spline,fv =input$n4 ,C = car)
      
      pre1 <- cbind.data.frame("Títulos"=sp2(),"Precios"=pre)
      
      return(datatable(pre1, options = list(paging = FALSE)))
    }
    
    }else{}
    
    }) #final isolate
  })
  
  #VEBONO-COMP
  output$precios_veb_nuevos_comp <- renderDataTable({
    #Tabla.splines(data = data_splines,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),C_splines,pr=tf_sp())[[2]]
    # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
    # dat[,3] <- as.Date(as.character(dat[,3]))
    car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
    # #return(car)
    # #print(str(data_splines))
    # #print(str(dat))
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())[[2]]
    #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())
    a <- try(tabla_sp_veb_comp())
    
    if(class(a)!="try-error"){
    letra <- a[[3]]
    letra[,6] <- as.Date(letra[,6])
    letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
    cand <- a[[2]]
    
    
    names(letra1)=names(cand)
    
    a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
    
    if(length(input$obs_veb_comp)==0){
      Aviso <- "No se ha eliminado nada, ver tabla anterior"
      return(as.data.frame(Aviso))
      
    }else{
      
      b <- c()
      for(i in 1:length(input$obs_veb_comp)){
        b[i] <- which(input$obs_veb_comp[i]==as.character(a[,1]))
      }
      a <- a[-b,]
      
      
      #calculo spline
      spline <- smooth.spline(a[,4],a[,7],spar = input$parametro_veb_comp)
      
      #calculo precios
      pre <- precio(tit = comp2(),spline1 = spline,fv =input$n5 ,C = car)
      
      pre1 <- cbind.data.frame("Títulos"=comp2(),"Precios"=pre)
      
      return(datatable(pre1, options = list(paging = FALSE)))
    }
    
    }else{}
    
  })
  
  
  #nueva curva TIF
  #renderRbokeh
  output$c_tif_splines_new <- renderRbokeh({
    #agrego dependencia 
    input$boton12
    
    #
    isolate({
     withProgress(message = 'Graficando curva de rendimiento...', value = 0, {
       incProgress(1/2, detail = "Calculando alturas")
       # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
       # dat[,3] <- as.Date(as.character(dat[,3]))
       # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
       # 
       #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())[[2]]
       #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())
       a <- (try(tabla_sp_tif()))
       
       if(class(a)!="try-error"){
       letra <- a[[3]]
       letra[,6] <- as.Date(letra[,6])
       letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
       cand <- a[[2]]
       
       
       names(letra1)=names(cand)
       
       a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
       
       
       if(length(input$obs_tif)==0){
         figure(width = 1000,height = 400) 
       }else{
         
         b <- c()
         for(i in 1:length(input$obs_tif)){
           b[i] <- which(input$obs_tif[i]==as.character(a[,1]))
         }
         a <- a[-b,]
       }
         
         #calculo spline
         spline <- smooth.spline(a[,4],a[,7],spar = input$parametro_tif)
         
       y <-predict(spline,seq(0.1,20,0.1)*365)$y
       incProgress(1/2, detail = "Ajustando spline")
       
    #   plot(seq(0.1,20,0.1)*365,y)
    #   figure(width = 1000,height = 400) %>%
    #     ly_points(pto_sp_tif_dl()[,4],pto_sp_tif_dl()[,7],pto_sp_tif_dl(),hover=list("Nombre"=pto_sp_tif_dl()[,1],"Fecha de operación"=pto_sp_tif_dl()[,2])) %>%
    #     ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="green",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
    #     x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
         
       
       figure(width = 1000,height = 400) %>%
           ly_points(a[,4],a[,7],a,hover=list("Nombre"=a[,1],"Fecha de operación"=a[,2])) %>%
           ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="green",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
           x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)")
       
         }else{}
         
       })
      
    })#final isolate
  })
  
  #TIF-COMP
  output$c_tif_splines_new_comp <- renderRbokeh({
    withProgress(message = 'Graficando curva de rendimiento...', value = 0, {
      incProgress(1/2, detail = "Calculando alturas")
      # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
      # dat[,3] <- as.Date(as.character(dat[,3]))
      # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
      # 
      #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())[[2]]
      #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())
      a <- try(tabla_sp_tif_comp())
      
      if(class(a)!="try-error"){
      letra <- a[[3]]
      letra[,6] <- as.Date(letra[,6])
      letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      cand <- a[[2]]
      
      
      names(letra1)=names(cand)
      
      a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      
      
      if(length(input$obs_tif_comp)==0){
        figure(width = 1000,height = 400) 
      }else{
        
        b <- c()
        for(i in 1:length(input$obs_tif_comp)){
          b[i] <- which(input$obs_tif_comp[i]==as.character(a[,1]))
        }
        a <- a[-b,]
      }
      
      #calculo spline
      spline <- smooth.spline(a[,4],a[,7],spar = input$parametro_tif_comp)
      
      y <-predict(spline,seq(0.1,20,0.1)*365)$y
      incProgress(1/2, detail = "Ajustando spline")
      
      #   plot(seq(0.1,20,0.1)*365,y)
      #   figure(width = 1000,height = 400) %>%
      #     ly_points(pto_sp_tif_dl()[,4],pto_sp_tif_dl()[,7],pto_sp_tif_dl(),hover=list("Nombre"=pto_sp_tif_dl()[,1],"Fecha de operación"=pto_sp_tif_dl()[,2])) %>%
      #     ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="green",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
      #     x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
      figure(width = 1000,height = 400) %>%
        ly_points(a[,4],a[,7],a,hover=list("Nombre"=a[,1],"Fecha de operación"=a[,2])) %>%
        ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="green",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
        x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)")
      
      }else{}
    })
    
  
  })
  
  #VEBONOS
  output$c_veb_splines_new <- renderRbokeh({
    #pongo dependencia
    input$boton14
    
    #
    isolate({
    withProgress(message = 'Graficando curva de rendimiento...', value = 0, {
      incProgress(1/2, detail = "Calculando alturas")
      a <- try(tabla_sp_veb())
      
      if(class(a)!="try-error"){
      letra <- a[[3]]
      letra[,6] <- as.Date(letra[,6])
      letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      cand <- a[[2]]
      
      names(letra1)=names(cand)
      
      a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      
      
      if(length(input$obs_veb)==0){
        figure(width = 1000,height = 400) 
      }else{
        
        b <- c()
        for(i in 1:length(input$obs_veb)){
          b[i] <- which(input$obs_veb[i]==as.character(a[,1]))
        }
        a <- a[-b,]
      }
      
      #calculo spline
      spline <- smooth.spline(a[,4],a[,7],spar = input$parametro_veb)
      
      y <-predict(spline,seq(0.1,20,0.1)*365)$y
      incProgress(1/2, detail = "Ajustando spline")
      
      figure(width = 1000,height = 400) %>%
        ly_points(a[,4],a[,7],a,hover=list("Nombre"=a[,1],"Fecha de operación"=a[,2])) %>%
        ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="green",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
        x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)")
      
      }else{}
      
    })
    }) #final isolate
  })
  
  #VEBONO_COMP
  
  output$c_veb_splines_new_comp <- renderRbokeh({
    withProgress(message = 'Graficando curva de rendimiento...', value = 0, {
      incProgress(1/2, detail = "Calculando alturas")
      # dat <- read.csv(paste(getwd(),"data","Historico_act.txt",sep = "/"),sep="")
      # dat[,3] <- as.Date(as.character(dat[,3]))
      # car <- Carac(paste(getwd(),"data","Caracteristicas.xls",sep = "/"))
      # 
      #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())[[2]]
      #a <- Tabla.splines(data = dat,tipo = "TIF",fe=input$n4,num = input$d_tif,par = input$parametro_tif,tit=c(input$t1_sp,input$t2_sp,input$t3_sp,input$t4_sp),car,pr=tf_sp())
      a <- try(tabla_sp_veb_comp())
      
      if(class(a)!="try-error"){
      letra <- a[[3]]
      letra[,6] <- as.Date(letra[,6])
      letra1 <- data.frame(letra[,c(2,3,6,7,12,13,15)],"Corto Plazo","C1")
      cand <- a[[2]]
      
      
      names(letra1)=names(cand)
      
      a <- rbind.data.frame(letra1,cand,make.row.names = FALSE)
      
      
      if(length(input$obs_veb_comp)==0){
        figure(width = 1000,height = 400) 
      }else{
        
        b <- c()
        for(i in 1:length(input$obs_veb_comp)){
          b[i] <- which(input$obs_veb_comp[i]==as.character(a[,1]))
        }
        a <- a[-b,]
      }
      
      #calculo spline
      spline <- smooth.spline(a[,4],a[,7],spar = input$parametro_veb_comp)
      
      y <-predict(spline,seq(0.1,20,0.1)*365)$y
      incProgress(1/2, detail = "Ajustando spline")
      
      #   plot(seq(0.1,20,0.1)*365,y)
      #   figure(width = 1000,height = 400) %>%
      #     ly_points(pto_sp_tif_dl()[,4],pto_sp_tif_dl()[,7],pto_sp_tif_dl(),hover=list("Nombre"=pto_sp_tif_dl()[,1],"Fecha de operación"=pto_sp_tif_dl()[,2])) %>%
      #     ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="green",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
      #     x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)") 
      figure(width = 1000,height = 400) %>%
        ly_points(a[,4],a[,7],a,hover=list("Nombre"=a[,1],"Fecha de operación"=a[,2])) %>%
        ly_points(x=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],y=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2],color="green",hover=list("Plazo"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,1],"Rendimiento"=cbind.data.frame(x=seq(0.1,20,0.1)*365,y)[,2]),size=4) %>%
        x_axis("Plazo (días)") %>% y_axis("Rendimiento (%)")
   
      }else{}
       })
    
    
  })
  
  ##############
  ##############
  ##############
  #VALUE AT RISK 
  ##############
  ##############
  #funcion que lee los datos iniciales para asi determinar
  #las posibles fechas para el VaR
  data1 <- reactive({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file_data
    
    if (is.null(inFile))
      return(NULL)
    
    # read.table(inFile$datapath, header = input$header,
    #            sep = input$sep, quote = input$quote)
    a <- read.delim2(inFile$datapath, header = input$header,
              sep = input$sep, quote = input$quote)
    
    #ordeno la data de fecha mas reciente a fecha mas antigua
    a[,1] <- as.Date(a[,1])
    a <- a[order(a[,1],decreasing = TRUE),]
    
    #seleciono 252 obs
    a <- a[1:252,]
    
    return(a)
    
  })
  
  #variable que uso para el calculo
  #una vez seleccionada la fecha procedo a tomar solo la data
  #necesaria de la data completa
  data <- reactive({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file_data
    
    if (is.null(inFile))
      return(NULL)
    
    # read.table(inFile$datapath, header = input$header,
    #            sep = input$sep, quote = input$quote)
    a <- read.delim2(inFile$datapath, header = input$header,
                     sep = input$sep, quote = input$quote)
    
    #ordeno la data de fecha mas reciente a fecha mas antigua
    a[,1] <- as.Date(a[,1])
    a <- a[order(a[,1],decreasing = TRUE),]
    
    #seleciono 252 obs segun fecha seleccionada
    
    a <- a[which(input$date_var==a[,1]):(251+which(input$date_var==a[,1])),]
    
    return(a)
    
  })
  
  ###############################################################################
  ###############################################################################
  #################################    Datos    #################################
  ###############################################################################
  ###############################################################################
  
  output$datatable<-renderDataTable({
    if(is.null(data())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    datatable(data())
    })
  
  #data nueva
  output$datatable1<-renderDataTable({
    if(is.null(data())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    datatable(data())
  })
  
 #POSICIONES
  
  data_pos <- reactive({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file_data_pos
    
    if (is.null(inFile))
      return(NULL)
    
    read.table(inFile$datapath, header = input$header_pos,
               sep = input$sep_pos, quote = input$quote_pos)
  
  })
  
  ###############################################################################
  ###############################################################################
  #################################    Datos    #################################
  ###############################################################################
  ###############################################################################
  
  output$datatable_pos<-renderDataTable({
    if(is.null(data_pos())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    #datatable(data_pos())
    data_pos()
  })
  
  
  #MUESTRO FECHAS DISPONIBLES PARA CALCULAR VAR
  #funcion auxiliar
  fe_var <- reactive({
    inFile <- input$file_data
    
    if (is.null(inFile))
      return(NULL)
    A <- read.delim2(inFile$datapath, header = input$header,
                     sep = input$sep, quote = input$quote)
    A[,1] <- as.Date(A[,1])
    A <- A[order(A[,1],decreasing = TRUE),]
    obs <- nrow(A)-252
    fechas <- A[1:obs,1]
    return(fechas)
  })
  
  #output
  output$fechas_var <- renderUI({ 
    selectInput("date_var", "Seleccionar fecha", fe_var(),multiple = FALSE)
  })
  
  #fecha elegida
  output$fecha_elegida <- renderPrint({input$date_var})
  
  
   #DISTRIBUCION
  #CALCULO RENDIMIENTOS
  
  output$dat_rend<-renderDataTable({
    if(is.null(data())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    data1 <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]
    
    
    for(i in 1:(ncol(data())-1)){
      data1[,i] <- diff(log(data()[,i+1]))
    }
    
    #datatable(head(data1))
    datatable(data1)
  })
  
  #muestro posibles elecciones de titulos
  output$instrumento <- renderUI({ 
    selectInput("inst", "Seleccionar títulos",choices =  names(data())[-1] )
  })
  
  #eleccion
  output$elec <- renderPrint({input$inst})
  
  #advertencia titulos con problemas
  output$advertencia_dist_varp_el <- renderPrint({
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    if(sum(a)>=1){
      print("Existen problemas con los rendimientos de los títulos")
      print(names(rend)[which(a==1)])
      print("los mismos se excluirán del estudio")
    }else{
      print("No hay problemas con los rendimientos")
    }
    
  })
  
  
  #VaR portafolio - eleccion distribucion
  #creo variable auxiliar
  opcion <- reactive({
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #titulos donde hay problema
    b <- which(a==1)
    
    if(sum(a)>=1){
      # print("Existen problemas con los rendimientos de los títulos")
      # print(names(rend)[which(a==1)])
      # print("los mismos se excluirán del estudio")
        rend <- rend[,-b]
      return(names(rend))
    }else{
      #print("No hay problemas con los rendimientos")
      return(names(rend))
    }
    
  })
  
  output$instrumento_varp <- renderUI({ 
    #selectInput("inst_varp", "Seleccionar títulos",choices =  names(data())[-1] )
    selectInput("inst_varp", "Seleccionar títulos",choices =  opcion() )
    })
  
  #eleccion
  output$elec_varp <- renderPrint({input$inst_varp})
  
  #muestro resultados de ajuste
  output$result <- renderTable({
    if(is.null(data())){return()}
    n <- which(input$inst==names(data()))
    dat <- data()[,n]
    dat1 <- diff(log(dat))
    dat2 <- useFitdist(dat1)
    dat2$res.matrix
    #AHORRO.BA <-uFitdifflog(data()$ahorro)
    #AHORRO.BA$res.matrix
  },
  rownames = TRUE, striped = TRUE,
  hover = TRUE, bordered = TRUE
  )
  
  #resultados ajuste distribucion VaR portafolio
  output$result_varp <- renderTable({
    if(is.null(data())){return()}
    n <- which(input$inst_varp==names(data()))
    dat <- data()[,n]
    dat1 <- diff(log(dat))
    dat2 <- useFitdist(dat1)
    dat2$res.matrix
  },
  rownames = TRUE, striped = TRUE,
  hover = TRUE, bordered = TRUE
  )
  
  #muestro valores de los paramentros ajustados
  #defino funciones auxiliares
  #Calcula el log() diff() y useFitdist()
  uFitdifflog<-function(data) {
    useFitdist(diff(log(data)))
  }
  ##Funciones para calcular parámetros de las distribuciones
  ##Normal
  mediaNormal <- function(data)
  { uFitdifflog(data)$fit.list$Normal$estimate[1] }
  sdNormal <- function(data)
  { uFitdifflog(data)$fit.list$Normal$estimate[2] }
  ##Esponencial
  lambdaExponential <- function(data)
  { uFitdifflog(data)$fit.list$Exponential$estimate[1]}
  ##Logistica
  s1Logistic <- function(data)
  { uFitdifflog(data)$fit.list$Logistic$estimate[1] }
  s2Logistic <- function(data)
  { uFitdifflog(data)$fit.list$Logistic$estimate[2] }
  ##Cauchy
  muCauchy <- function(data)
  { uFitdifflog(data)$fit.list$Cauchy$estimate[1] }
  thetaCauchy <- function(data)
  { uFitdifflog(data)$fit.list$Cauchy$estimate[2] }
  ##Beta
  s1Beta <- function(data)
  { uFitdifflog(data)$fit.list$Beta$estimate[1] }
  s2Beta <- function(data)
  { uFitdifflog(data)$fit.list$Beta$estimate[2] }
  ##Chi Cuadrado
  dfChisquare <- function(data)
  { uFitdifflog(data)$fit.list$`Chi-square`$estimate[1] }
  ##Uniforme
  minUniform <- function(data)
  { uFitdifflog(data)$fit.list$Uniform$estimate[1] }
  maxUniform <- function(data)
  { uFitdifflog(data)$fit.list$Uniform$estimate[2] }
  ##Gamma
  mGamma <- function(data)
  { uFitdifflog(data)$fit.list$Gamma$estimate[1] }
  lambdaGamma <- function(data)
  { uFitdifflog(data)$fit.list$Gamma$estimate[2] }
  ##Lognormal
  mediaLognormal <- function(data)
  { uFitdifflog(data)$fit.list$Lognormal$estimate[1] }
  sdLognormal <- function(data)
  { uFitdifflog(data)$fit.list$Lognormal$estimate[2] }
  ##Weibull
  s1Weibull <- function(data)
  { uFitdifflog(data)$fit.list$Weibull$estimate[1] }
  s2Weibull <- function(data)
  { uFitdifflog(data)$fit.list$Weibull$estimate[2] }
  ##Fisher
  df1F <- function(data)
  { uFitdifflog(data)$fit.list$F$estimate[1] }
  df2F <- function(data)
  { uFitdifflog(data)$fit.list$F$estimate[2] }
  ##T-student
  dfStudent <- function(data)
  { uFitdifflog(data)$fit.list$Student$estimate[1] }
  ##Gompertz
  s1Gompertz <- function(data)
  { uFitdifflog(data)$fit.list$Gompertz$estimate[1] }
  s2Gompertz <- function(data)
  { uFitdifflog(data)$fit.list$Gompertz$estimate[2] }
  
  
  #Nombre de parámetros con valores de dichos parámetros
  distParams<-function(condition, data) {
    v<-switch(condition,
              "Normal"=c(NLABEL1,mediaNormal(data),NLABEL2,sdNormal(data)),
              "Exponential"=c(ELABEL1,lambdaExponential(data), NULL, NULL),
              "Cauchy"=c(CLABEL1,muCauchy(data),CLABEL2,thetaCauchy(data)),
              "Logistic"=c(LLABEL1,s1Logistic(data),LLABEL2,s2Logistic(data)),
              "Beta"=c(BLABEL1,s1Beta(data),BLABEL2,s2Beta(data)),
              "Chi-square"=c(CCLABEL,dfChisquare(data), NULL, NULL),
              "Uniform"=c(ULABEL1,minUniform(data),ULABEL2,maxUniform(data)),
              "Gamma"=c(GLABEL1,mGamma(data),GLABEL2,lambdaGamma(data)),
              "Lognormal"=c(LNLABEL1,mediaLognormal(data),LNLABEL2,sdLognormal(data)),
              "Weibull"=c(WLABEL1,s1Weibull(data),WLABEL2,s2Weibull(data)),
              "F"=c(FLABEL1,df1F(data),FLABEL2,df2F(data)),
              "Student"=c(TLABEL1,dfStudent(data), NULL, NULL),
              "Gompertz"=c(GOLABEL1,s1Gompertz(data),GOLABEL2,s2Gompertz(data))
    )
  }
  
  #Caja con parámetros de distribución
  distBox<-function(label1, out1, label2, out2) {
    box( width = 12, status ="success",
         h5(label1), out1,
         h5(label2), out2
    )
  }
  
  Distrib<- reactive ({
    n <- which(input$inst==names(data()))
    dat <- data()[,n]
    #dat1 <- diff(log(dat))
    v<-distParams(input$distsA, dat)
    distBox(v[1],v[2],v[3],v[4])
  })
  
  output$parametros_dist<-renderUI({
    if(is.null(data())){return()}
    Distrib()
  })
  
  #var de portafolio
  Distrib_varp<- reactive ({
    n <- which(input$inst_varp==names(data()))
    dat <- data()[,n]
    v<-distParams(input$distsA_varp, dat)
    distBox(v[1],v[2],v[3],v[4])
  })
  
  output$parametros_dist_varp<-renderUI({
    if(is.null(data())){return()}
    Distrib_varp()
  })
  
  #calculo VaR
  #defino funcion auxiliar
  ##Función para mostrar el VAR y VART en riesgo
  VarR<-function(p,data,condition) {
    switch(condition,
           "Normal"    =c(VARINNOR_TEXT,
                          varnormal(p, as.numeric(data$fit.list$Normal$estimate[1]),as.numeric(data$fit.list$Normal$estimate[2])),
                          VARTINNOR_TEXT,
                          esnormal(p, as.numeric(data$fit.list$Normal$estimate[1]),as.numeric(data$fit.list$Normal$estimate[2])) ) ,
           "Exponential" =c(VARINEXP_TEXT,
                            varexponential(p, as.numeric(data$fit.list$Exponential$estimate[1])),
                            VARTINEXP_TEXT,
                            esexponential(p, as.numeric(data$fit.list$Exponential$estimate[1])) ),
           "Cauchy"    =c(VARINCAU_TEXT,
                          varCauchy(p, as.numeric(data$fit.list$Cauchy$estimate[1]),as.numeric(data$fit.list$Cauchy$estimate[2])),
                          VARTINCAU_TEXT,
                          esCauchy(p, as.numeric(data$fit.list$Cauchy$estimate[1]),as.numeric(data$fit.list$Cauchy$estimate[2])) ),
           "Logistic"  =c(VARINLOG_TEXT,
                          varlogistic(p, as.numeric(data$fit.list$Logistic$estimate[1]),as.numeric(data$fit.list$Logistic$estimate[2])),
                          VARTINLOG_TEXT,
                          eslogistic(p, as.numeric(data$fit.list$Logistic$estimate[1]),as.numeric(data$fit.list$Logistic$estimate[2])) ),
           "Beta"      =c(VARINBET_TEXT,
                          NULL,
                          VARTINBET_TEXT,
                          NULL ),
           "Chi-square"=c(VARINCHC_TEXT,
                          NULL,
                          VARTINCHC_TEXT,
                          NULL),
           "Uniform"   =c(VARINUNF_TEXT,
                          varuniform(p, as.numeric(data$fit.list$Uniform$estimate[1]), as.numeric(data$fit.list$Uniform$estimate[2])),
                          VARTINUNF_TEXT,
                          esuniform(p, as.numeric(data$fit.list$Uniform$estimate[1]), as.numeric(data$fit.list$Uniform$estimate[2])) ),
           "Gamma"     =c(VARINGAM_TEXT,
                          varGamma(p, as.numeric(data$fit.list$Gamma$estimate[1]), as.numeric(data$fit.list$Gamma$estimate[2])),
                          VARTINGAM_TEXT,
                          esGamma(p, as.numeric(data$fit.list$Gamma$estimate[1]), as.numeric(data$fit.list$Gamma$estimate[2])) ),
           "Lognormal" =c(VARINLGN_TEXT,
                          varlognorm(p, as.numeric(data$fit.list$Lognormal$estimate[1]), as.numeric(data$fit.list$Lognormal$estimate[2])),
                          VARTINLGN_TEXT,
                          eslognorm(p, as.numeric(data$fit.list$Lognormal$estimate[1]), as.numeric(data$fit.list$Lognormal$estimate[2])) ),
           "Weibull"   =c(VARINWEI_TEXT,
                          varWeibull(p, as.numeric(data$fit.list$Weibull$estimate[1]),as.numeric(data$fit.list$Weibull$estimate[2])),
                          VARTINWEI_TEXT,
                          esWeibull(p, as.numeric(data$fit.list$Weibull$estimate[1]),as.numeric(data$fit.list$Weibull$estimate[2])) ),
           "F"         =c(VARINF_TEXT,
                          varF(p, as.numeric(data$fit.list$F$estimate[1]), as.numeric(data$fit.list$F$estimate[2])),
                          VARTINF_TEXT,
                          esF(p, as.numeric(data$fit.list$F$estimate[1]), as.numeric(data$fit.list$F$estimate[2])) ),
           "Student"   =c(VARINTST_TEXT,
                          varT(p, as.numeric(data$fit.list$Student$estimate[1])),
                          VARTINTST_TEXT,
                          esT(p, as.numeric(data$fit.list$Student$estimate[1])) ),
           "Gompertz"  =c(VARINGOM_TEXT,
                          NULL,
                          VARTINGOM_TEXT,
                          NULL)
    )
  }
  
  #datos VaR
  # output$datos_var <- renderTable({
  #   if(is.null(data())){return()}
  #   n <- which(input$inst==names(data()))
  #   dat <- data()[,n]
  #   dat1 <- as.numeric(diff(log(dat)))
  #   dat2 <- useFitdist(dat1)
  #   #dat2$res.matrix
  #   #data.frame(mu=as.numeric(dat2$fit.list$Normal$estimate[1]),sd=as.numeric(dat2$fit.list$Normal$estimate[2]))
  #   #varnormal(as.numeric(input$porVar0), as.numeric(dat2$fit.list$Normal$estimate[1]),as.numeric(dat2$fit.list$Normal$estimate[2]))
  #   varnormal(as.numeric(sub(",",".",input$porVar)), as.numeric(dat2$fit.list$Normal$estimate[1]),as.numeric(dat2$fit.list$Normal$estimate[2]))
  #   #c(class(input$porVar0),class(as.numeric(input$porVar0)),input$porVar0,as.numeric(sub(",",".",input$porVar0)))
  #   })
  
  #output del VaR
  output$VaR_inicial<-renderUI({
    if(is.null(data())){return()}
    n <- which(input$inst==names(data()))
    dat <- data()[,n]
    dat1 <- diff(log(dat))
    dat2 <- useFitdist(dat1)
    v<-VarR(p = as.numeric(sub(",",".",input$porVar)),data = dat2,condition = input$distsA)
    box( width=12, status="success",
         withMathJax(v[1]), br(),
         withMathJax( sprintf("$$VaR_p(X) = %0.05s$$", v[2] ) ), br(),
         withMathJax(v[3]), br(),
         withMathJax( sprintf("$$TVaR_p(X) = %0.05s$$", v[4] ) )
    )
  })
  
  #tabla dinamica que me guarda la distribucion de cada instrumento
  #creo funcion auxiliar
  varp_dist <- function(data,ind,dist){
    
    # n <- which(input$inst_varp==names(data()))
    # a[,(n-1)] <- input$distsA_varp
    # a
    n <- which(ind==names(data))
    data[,n] <- dist
    return(data)
    
  }
  
  distribuciones <- reactive({
    #a <- as.data.frame(matrix(NA,nrow = 1,ncol = (ncol(data())-1)))
    a <- as.data.frame(matrix("Nada",nrow = 1,ncol = length(opcion())))
    
    names(a) <- opcion()
    rownames(a) <- "Distribuciones"
    a <- varp_dist(data = a ,ind =input$inst_varp  ,dist =input$distsA_varp )
    #write.table(a,paste(getwd(),"data","distribuciones.txt",sep = "/"),row.names = FALSE)
    
    #a
   if(input$seleccion_varp==1){
    #write.table(a,paste(getwd(),"data","distribuciones.txt",sep = "/"),row.names = FALSE)
    b <- read.csv(paste(getwd(),"data","distribuciones.txt",sep = "/"),sep="")
    c <- varp_dist(data = b ,ind =input$inst_varp ,dist =input$distsA_varp )
    #c
    
    #actualizo
    write.table(c,paste(getwd(),"data","distribuciones.txt",sep = "/"),row.names = FALSE)
    c
   }else{
     write.table(a,paste(getwd(),"data","distribuciones.txt",sep = "/"),row.names = FALSE)
     a
   }
    
    
    })

  
  output$dist_varp <- renderTable({
    if(is.null(data())){return()}
    distribuciones()
    # a <- as.data.frame(matrix(NA,nrow = 1,ncol = (ncol(data())-1)))
    # names(a) <- names(data())[-1]
    # rownames(a) <- "Distribuciones"
    # 
    # b <- varp_dist(data = a ,ind =input$inst_varp  ,dist =input$distsA_varp )
    # b
    
  })
  
  #ELIJO DISTRIBUCIONES MEDIANTE UN ARCHIVO
  output$dist_elegir <- renderTable({
   # if(is.null(data())){return()}
  #  distribuciones()
  if(input$seleccion_dist==0){
    return()
  }else if(input$seleccion_dist==1){
    #as.data.frame(rep(1,10))
    b <- read.csv(paste(getwd(),"data","distribuciones2.txt",sep = "/"),sep="")
    b
  }
    
  })
  
  #seccion VaR Parametrico Normal
  output$rend_varn<-renderDataTable({
    if(is.null(data())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    data1 <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]
    
    
    for(i in 1:(ncol(data())-1)){
      data1[,i] <- diff(log(data()[,i+1]))
    }
    
    #datatable(head(data1))
    datatable(data1)
  })
  
  
  #parametros u y sigma de cada titulo
  output$parametros_varn<-renderDataTable({
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo problemas con rend
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      #creo data frame para distribuciones
      data1 <- as.data.frame(matrix(0,nrow = 2,ncol = ncol(rend) ))
      names(data1) <- names(data())[-c(1,(b+1))]
      rownames(data1) <- c("Media","Desviación estandar")
      
      for(i in 1:ncol(data1)){
        data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[1]
        data1[2,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
        
      }
      return(data1)
 
    }
    
    #creo data frame para distribuciones
    data1 <- as.data.frame(matrix(0,nrow = 2,ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]
    rownames(data1) <- c("Media","Desviación estandar")
    
    for(i in 1:ncol(data1)){
    #   if(anyNA(rend[,i])){
    #     a <- which(is.na(rend[,i])|is.infinite(rend[,i]))
    #     data1[1,i] <- as.numeric(fitdistr(rend[-a,i],"normal")$estimate)[1]
    #     data1[2,i] <- as.numeric(fitdistr(rend[-a,i],"normal")$estimate)[2]
    #   }else{
    # data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[1]
    # data1[2,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
    #   }
       data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[1]
       data1[2,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      
    }
    data1
  })
  
  #elijo % del VaR
  output$porcentaje_varn <- renderPrint({
    print(as.numeric(sub(",",".",input$porVarn)))
  })
  
  
  #creo tabla para VaR individuales metodo parametrico
  output$tabla_varn<-renderDataTable({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
  
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      #creo estructura de tabla
      tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 4))
      names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
      rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")
      
      data1 <- as.data.frame(matrix(0,nrow = 1,ncol = ncol(rend)))
      names(data1) <- names(data())[-c(1,(b+1))]
      
      
      for(i in 1:ncol(data1)){
        data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      }
      
      #relleno desviaciones estandar
      tabla[,1] <- c(as.numeric(data1),NA)
      
      # #relleno valor nominal
      tabla[,2] <- c(data_pos()[-b,2],sum(data_pos()[-b,2]))
      
      # #relleno Vares individuales
      tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
      tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
      
      #relleno VaR en porcentaje
      tabla[,4] <- tabla[,3]*100/tabla[nrow(tabla),3]
      tabla[nrow(tabla),4] <- sum(tabla[1:((nrow(tabla))-1),4])
      
      return(datatable(tabla, options = list(paging = FALSE)))
      
    }
    
    #creo estructura de tabla
    tabla <- as.data.frame(matrix(0,nrow = (ncol(data())),ncol = 4))
    names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
    rownames(tabla) <- c(names(data())[-1],"Totales")
    
    data1 <- as.data.frame(matrix(0,nrow = 1,ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]
    
    
    for(i in 1:ncol(data1)){
      # if(anyNA(rend[,i])){
      #   a <- which(is.na(rend[,i])|is.infinite(rend[,i]))
      #   data1[1,i] <- as.numeric(fitdistr(rend[-a,i],"normal")$estimate)[2]
      # }else{
      #   data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      # }
      data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      
    }
    
    #relleno desviaciones estandar
     tabla[,1] <- c(as.numeric(data1),NA)
  
    # #relleno valor nominal
     tabla[,2] <- c(data_pos()[,2],sum(data_pos()[,2]))
    
    # #relleno Vares individuales
     tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
     tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
    
    #relleno VaR en porcentaje
     tabla[,4] <- tabla[,3]*100/tabla[nrow(tabla),3]
     tabla[nrow(tabla),4] <- sum(tabla[1:((nrow(tabla))-1),4])
     
     datatable(tabla, options = list(paging = FALSE))
  })
  
  #calculo VaR normal Portafolio
  output$varn_portafolio <- renderPrint({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      #creo estructura de tabla
      tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 4))
      names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
      rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")
      
      data1 <- as.data.frame(matrix(0,nrow = 1,ncol = ncol(rend)))
      names(data1) <- names(data())[-c(1,(b+1))]
      
      
      for(i in 1:ncol(data1)){
        data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      }
      
      #relleno desviaciones estandar
      tabla[,1] <- c(as.numeric(data1),NA)
      
      # #relleno valor nominal
      tabla[,2] <- c(data_pos()[-b,2],sum(data_pos()[-b,2]))
      
      # #relleno Vares individuales
      tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
      tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
      
      
      #calculo matriz de correlaciones (diagonal de 1's)
      S<- cor(rend)
      
      #VaR
      var_ind <- tabla[1:(nrow(tabla)-1),3]
      #var_ind%*%S
      VaR <- sqrt(var_ind%*%S%*%as.matrix(var_ind))
      return(VaR)
 
      
    }#final if problemas de rend
    
    #creo estructura de tabla
    tabla <- as.data.frame(matrix(0,nrow = (ncol(data())),ncol = 3))
    names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual")
    rownames(tabla) <- c(names(data())[-1],"Totales")
    
    
    data1 <- as.data.frame(matrix(0,nrow = 1,ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]
    
    
    for(i in 1:ncol(data1)){
     data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
    }
    
    #relleno desviaciones estandar
    tabla[,1] <- c(as.numeric(data1),NA)
    
    # #relleno valor nominal
    tabla[,2] <- c(data_pos()[,2],sum(data_pos()[,2]))
    
    # #relleno Vares individuales
    tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
    tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
    
    #calculo matriz de correlaciones (diagonal de 1's)
    S<- cor(rend)
    
    #VaR
     var_ind <- tabla[1:(nrow(tabla)-1),3]
     #var_ind%*%S
     VaR <- sqrt(var_ind%*%S%*%as.matrix(var_ind))
     VaR

    
    
  })
  
  #advertencia por problemas en rend
  output$advertencia_varn <-renderPrint({
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
         a[i] <- 1
      }
    }
    
    if(sum(a)>=1){
      print("Existen problemas con los rendimientos de los títulos")
      print(names(rend)[which(a==1)])
      print("los mismos se excluirán del estudio")
    }else{
    print("No hay problemas con los rendimientos")
    }
    
  })
  
  #GRAFICOS
  #VALOR NOMINAL
  output$grafico_vnominal <- renderPlotly({ 
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      #creo estructura de tabla
      tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 4))
      names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
      rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")
      
      data1 <- as.data.frame(matrix(0,nrow = 1,ncol = ncol(rend)))
      names(data1) <- names(data())[-c(1,(b+1))]
      
      
      for(i in 1:ncol(data1)){
        data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      }
      
      #relleno desviaciones estandar
      tabla[,1] <- c(as.numeric(data1),NA)
      
      # #relleno valor nominal
      tabla[,2] <- c(data_pos()[-b,2],sum(data_pos()[-b,2]))
      
      # #relleno Vares individuales
      tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
      tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
      
      #relleno VaR en porcentaje
      tabla[,4] <- tabla[,3]*100/tabla[nrow(tabla),3]
      tabla[nrow(tabla),4] <- sum(tabla[1:((nrow(tabla))-1),4])
      
      #return(tabla)
      
    }else{
    
    # #creo estructura de tabla
    tabla <- as.data.frame(matrix(0,nrow = (ncol(data())),ncol = 4))
    names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
    rownames(tabla) <- c(names(data())[-1],"Totales")

    data1 <- as.data.frame(matrix(0,nrow = 1,ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]


    for(i in 1:ncol(data1)){
      # if(anyNA(rend[,i])){
      #   a <- which(is.na(rend[,i])|is.infinite(rend[,i]))
      #   data1[1,i] <- as.numeric(fitdistr(rend[-a,i],"normal")$estimate)[2]
      # }else{
      #   data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      # }
      data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]

    }

    #relleno desviaciones estandar
    tabla[,1] <- c(as.numeric(data1),NA)

    # #relleno valor nominal
    tabla[,2] <- c(data_pos()[,2],sum(data_pos()[,2]))

    # #relleno Vares individuales
    tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
    tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])

    #relleno VaR en porcentaje
    tabla[,4] <- tabla[,3]*100/tabla[nrow(tabla),3]
    tabla[nrow(tabla),4] <- sum(tabla[1:((nrow(tabla))-1),4])

    }
    
    pie <- cbind.data.frame(rownames(tabla)[-nrow(tabla)],tabla[1:(nrow(tabla)-1),2])
    names(pie) <- c("Titulo","nominal")
    
    p <- plot_ly(pie, labels = ~Titulo, values = ~nominal, type = 'pie') %>%
      layout(title = 'Valor nominal',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    
    
    p
    
    
    })
  
  #VARES INDIVIDUALES
  output$grafico_vind <- renderPlotly({ 
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      #creo estructura de tabla
      tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 4))
      names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
      rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")
      
      data1 <- as.data.frame(matrix(0,nrow = 1,ncol = ncol(rend)))
      names(data1) <- names(data())[-c(1,(b+1))]
      
      
      for(i in 1:ncol(data1)){
        data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      }
      
      #relleno desviaciones estandar
      tabla[,1] <- c(as.numeric(data1),NA)
      
      # #relleno valor nominal
      tabla[,2] <- c(data_pos()[-b,2],sum(data_pos()[-b,2]))
      
      # #relleno Vares individuales
      tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
      tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
      
      #relleno VaR en porcentaje
      tabla[,4] <- tabla[,3]*100/tabla[nrow(tabla),3]
      tabla[nrow(tabla),4] <- sum(tabla[1:((nrow(tabla))-1),4])
      
      #return(tabla)
      
    }else{
    
    # #creo estructura de tabla
    tabla <- as.data.frame(matrix(0,nrow = (ncol(data())),ncol = 4))
    names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
    rownames(tabla) <- c(names(data())[-1],"Totales")
    
    data1 <- as.data.frame(matrix(0,nrow = 1,ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]
    
    
    for(i in 1:ncol(data1)){
      # if(anyNA(rend[,i])){
      #   a <- which(is.na(rend[,i])|is.infinite(rend[,i]))
      #   data1[1,i] <- as.numeric(fitdistr(rend[-a,i],"normal")$estimate)[2]
      # }else{
      #   data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      # }
      data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      
    }
    
    #relleno desviaciones estandar
    tabla[,1] <- c(as.numeric(data1),NA)
    
    # #relleno valor nominal
    tabla[,2] <- c(data_pos()[,2],sum(data_pos()[,2]))
    
    # #relleno Vares individuales
    tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
    tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
    
    #relleno VaR en porcentaje
    tabla[,4] <- tabla[,3]*100/tabla[nrow(tabla),3]
    tabla[nrow(tabla),4] <- sum(tabla[1:((nrow(tabla))-1),4])
    
    }
    
    
    pie <- cbind.data.frame(rownames(tabla)[-nrow(tabla)],tabla[1:(nrow(tabla)-1),3])
    names(pie) <- c("Titulo","ind")
    
    p <- plot_ly(pie, labels = ~Titulo, values = ~ind, type = 'pie') %>%
      layout(title = 'VaRes Individuales',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    
    
    p
    
    
  })
    
  #COMPARATIVO VAR INDIVIDUAL VS VAR PORTAFOLIO
  output$grafico_vcomp <- renderPlotly({ 
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      #creo estructura de tabla
      tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 4))
      names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
      rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")
      
      data1 <- as.data.frame(matrix(0,nrow = 1,ncol = ncol(rend)))
      names(data1) <- names(data())[-c(1,(b+1))]
      
      
      for(i in 1:ncol(data1)){
        data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      }
      
      #relleno desviaciones estandar
      tabla[,1] <- c(as.numeric(data1),NA)
      
      # #relleno valor nominal
      tabla[,2] <- c(data_pos()[-b,2],sum(data_pos()[-b,2]))
      
      # #relleno Vares individuales
      tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
      tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
      
      #relleno VaR en porcentaje
      tabla[,4] <- tabla[,3]*100/tabla[nrow(tabla),3]
      tabla[nrow(tabla),4] <- sum(tabla[1:((nrow(tabla))-1),4])
      
      #return(tabla)
      
    }else{
      
      # #creo estructura de tabla
      tabla <- as.data.frame(matrix(0,nrow = (ncol(data())),ncol = 4))
      names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
      rownames(tabla) <- c(names(data())[-1],"Totales")
      
      data1 <- as.data.frame(matrix(0,nrow = 1,ncol = (ncol(data())-1)))
      names(data1) <- names(data())[-1]
      
      
      for(i in 1:ncol(data1)){
        # if(anyNA(rend[,i])){
        #   a <- which(is.na(rend[,i])|is.infinite(rend[,i]))
        #   data1[1,i] <- as.numeric(fitdistr(rend[-a,i],"normal")$estimate)[2]
        # }else{
        #   data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
        # }
        data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
        
      }
      
      #relleno desviaciones estandar
      tabla[,1] <- c(as.numeric(data1),NA)
      
      # #relleno valor nominal
      tabla[,2] <- c(data_pos()[,2],sum(data_pos()[,2]))
      
      # #relleno Vares individuales
      tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",as.numeric(sub(",",".",input$porVarn)))),0,1))
      tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
      
      #relleno VaR en porcentaje
      tabla[,4] <- tabla[,3]*100/tabla[nrow(tabla),3]
      tabla[nrow(tabla),4] <- sum(tabla[1:((nrow(tabla))-1),4])
      
    }
    
    #CALCULO VAR
    #calculo matriz de correlaciones (diagonal de 1's)
    S<- cor(rend)
    
    #VaR
    var_ind <- tabla[1:(nrow(tabla)-1),3]
    #var_ind%*%S
    VaR <- sqrt(var_ind%*%S%*%as.matrix(var_ind))
    
    
    p <- plot_ly(marker = list(color = 'royalblue1',
                               line = list(color = 'rgb(8,48,107)',
                                           width = 3))) %>%
      add_bars(
        x = c("Individual"),
        y = c(sum(tabla[,3])),
        width = 0.3,
        marker = list(
          color = 'royalblue1'
        ),
        name = 'Suma VaRes individuales'
      ) %>%
      add_bars(
        x = c("Portafolio"),
        y = c(VaR),
        width = 0.3,
        marker = list(
          color = 'mediumseagreen'
        ),
        name = 'VaR Portafolio'
      )
    
    p
    
    
  })
  
  #AVISO DATOS VAR
  output$aviso_datos_var <- renderPrint({
    if(is.null(data())|is.null(data_pos())){return()}
    
    a <- data()
    b <- data_pos() 
    
    if(sum(names(a)[-1]==as.character(b[,1]))==nrow(b)){
      print("Coincidencia en nombres")
    }else{
      print("Problemas coincidencias nombres, revisar data")
    }
    
    
  })
  
  #ADVERTENCIA VAR SIMULACION HISTORICA
  output$advertencia_varsh <-renderPrint({
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    if(sum(a)>=1){
      print("Existen problemas con los rendimientos de los títulos")
      print(names(rend)[which(a==1)])
      print("los mismos se excluirán del estudio")
    }else{
      print("No hay problemas con los rendimientos")
    }
    
  })
  
  
  #GRAFICO DE PESOS
  output$grafico_pesos <- renderPlotly({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a1 <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a1[i] <- 1
      }
    }
    

    #cuando hay problemas con rend
    #titulos donde hay problema
    b1 <- which(a1==1)
    if(sum(a1)>=1){
      a <- data_pos()[-b1,]
      b <- sum(a[,2])
      
      a$pesos <- a[,2]/b
      
      pie <- cbind.data.frame(as.character(a[,1]),a[,3])
      names(pie) <- c("Titulo","Pesos")
      
      p <- plot_ly(pie, labels = ~Titulo, values = ~Pesos, type = 'pie') %>%
        layout(title = 'Pesos según valor nominal',
               xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
               yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
      
      
      p
      
      
    }else{
      
      a <- data_pos()
      b <- sum(a[,2])
      
      a$pesos <- a[,2]/b
      
      pie <- cbind.data.frame(as.character(a[,1]),a[,3])
      names(pie) <- c("Titulo","Pesos")
      
      p <- plot_ly(pie, labels = ~Titulo, values = ~Pesos, type = 'pie') %>%
        layout(title = 'Pesos según valor nominal',
               xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
               yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
      
      
      p
    }
    
    
    
    
  })
  
  #POSICION TOTAL
  output$suma_posvarsh <- renderPrint({
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a1 <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a1[i] <- 1
      }
    }
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b1 <- which(a1==1)
    if(sum(a1)>=1){
      a <- data_pos()[-b1,]
      sum(a[,2])
      
      
    }else{
      sum(data_pos()[,2])
     
    }
    

    
  })
  
  #SUMA DE PESOS
  output$suma_pesos <- renderPrint({
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a1 <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a1[i] <- 1
      }
    }
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b1 <- which(a1==1)
    if(sum(a1)>=1){
      a <- data_pos()[-b1,]
      a$pesos <- a[,2]/sum(a[,2])
      sum(a[,3])
      
    }else{
      a <- data_pos()
      a$pesos <- a[,2]/sum(a[,2])
      sum(a[,3])
      
    }
    
   
  })
  
  
  #ESCENARIOS VAR SIMULACION HISTORICA
  output$escenarios_varsh <- renderDataTable({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #calculo pesos
    p <- data_pos()
    p$pesos <- p[,2]/sum(p[,2])
    

    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo pesos
      p <- p[-b,]
      p[,3] <- p[,2]/sum(p[,2])

      esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
      if(sum(p[,3])==1){
        #calculo escenarios
        for(i in 1:nrow(rend)){
          esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        }
        esc
      }else{return()}
      
    }else{
      esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
      if(sum(p[,3])==1){
        #calculo escenarios
        for(i in 1:nrow(rend)){
          esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        }
        esc
      }else{return()}
      
    }
    
    
  })
  
  
  #PORCENTAJE VAR SIMULACION HISTORICA
  output$porcentaje_varsh <- renderPrint({
    print(as.numeric(sub(",",".",input$porVarsh)))
  })
  
  
  #UBICACION
  output$ubicacion_varsh <- renderPrint({
    round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))
  })
  
  #VAR SIMULACION HISTORICA
  output$varsh <- renderPrint({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #calculo pesos
    p <- data_pos()
    p$pesos <- p[,2]/sum(p[,2])
    

    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo pesos
      p <- p[-b,]
      p[,3] <- p[,2]/sum(p[,2])
      
      esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
      if(sum(p[,3])==1){
        #calculo escenarios
        for(i in 1:nrow(rend)){
          esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        }
        
        #Ordeno data
        esc1 <- esc[,ncol(esc)]
        esc1 <- esc1[order(esc1)]
        
        VaRsh <- sum(p[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        VaRsh
        }else{return()}
      
    }else{
      esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
      if(sum(p[,3])==1){
        #calculo escenarios
        for(i in 1:nrow(rend)){
          esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        }
        #esc[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh)))),ncol(esc)]
        esc1 <- esc[,ncol(esc)]
        esc1 <- esc1[order(esc1)]
        
        VaRsh <- sum(data_pos()[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        VaRsh        
        
      }else{return()}
      
    }
    
    
    
    
  })
  
  #HISTOGRAMA VAR SIMULACION HISTORICA
  output$grafico_hist_sh <- renderPlotly({ 
    
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #calculo pesos
    p <- data_pos()
    p$pesos <- p[,2]/sum(p[,2])
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo pesos
      p <- p[-b,]
      p[,3] <- p[,2]/sum(p[,2])
      
      esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
      if(sum(p[,3])==1){
        #calculo escenarios
        for(i in 1:nrow(rend)){
          esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        }
        
        #Ordeno data
        esc1 <- esc[,ncol(esc)]
        esc1 <- esc1[order(esc1)]
        
        vc <- esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        
        p2 <- plot_ly(cbind.data.frame(seq(1,length(esc1)),esc1), x = ~esc1) %>% add_histogram(name="Histograma")  %>%
          add_segments(x=vc, y=0, xend=vc, yend=mean(hist(esc1)$counts), line=list(color="red", width = 4),name="Valor Corte") %>%
          layout(title = 'Histograma de Escenarios',
                 xaxis = list(title=" "))
        p2
        
      }else{return()}
      
    }else{
      esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
      if(sum(p[,3])==1){
        #calculo escenarios
        for(i in 1:nrow(rend)){
          esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        }
        #esc[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh)))),ncol(esc)]
        esc1 <- esc[,ncol(esc)]
        esc1 <- esc1[order(esc1)]
        
        vc <- esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        
        p2 <- plot_ly(cbind.data.frame(seq(1,length(esc1)),esc1), x = ~esc1) %>% add_histogram(name="Histograma")  %>%
          add_segments(x=vc, y=0, xend=vc, yend=mean(hist(esc1)$counts), line=list(color="red", width = 4),name="Valor Corte") %>%
          layout(title = 'Histograma de Escenarios',
                 xaxis = list(title=" "))
        p2
        
      }else{return()}
      
    }
    
    
  })
  
  
  #GRAFICO COMPARACION VAR SH VS VAR NORMAL VS MONTE CARLO
  output$grafico_var_comp <- renderPlotly({ 
    #calculo Var Monte Carlo Normal
    varmc <- varmc_por_n1()[[1]]
    
    #calculo Var Monte Carlo Normal
    varmc_el <- varmc_por_el1()[[1]]
    
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #calculo pesos
    p <- data_pos()
    p$pesos <- p[,2]/sum(p[,2])
    
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #creo estructura de tabla
      tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 4))
      names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
      rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")
      
      data1 <- as.data.frame(matrix(0,nrow = 1,ncol = ncol(rend)))
      names(data1) <- names(data())[-c(1,(b+1))]
      
      
      for(i in 1:ncol(data1)){
        data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      }
      
      #relleno desviaciones estandar
      tabla[,1] <- c(as.numeric(data1),NA)
      
      # #relleno valor nominal
      tabla[,2] <- c(data_pos()[-b,2],sum(data_pos()[-b,2]))
      
      # #relleno Vares individuales
      tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
      tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
      
      
      #calculo matriz de correlaciones (diagonal de 1's)
      S<- cor(rend)
      
      #CALCULO VAR NORMAL
      var_ind <- tabla[1:(nrow(tabla)-1),3]
      #var_ind%*%S
      VaR_n <- sqrt(var_ind%*%S%*%as.matrix(var_ind))

      
      #CALCULO VAR SH
      #actualizo pesos
      p <- p[-b,]
      p[,3] <- p[,2]/sum(p[,2])
      
      esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
      if(sum(p[,3])==1){
        #calculo escenarios
        for(i in 1:nrow(rend)){
          esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        }
        
        #Ordeno data
        esc1 <- esc[,ncol(esc)]
        esc1 <- esc1[order(esc1)]
        
        VaRsh <- sum(p[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
  
      }else{return()}#final if suma de pesos
      
      
      
      p1 <- plot_ly(marker = list(color = 'royalblue1',
                                 line = list(color = 'rgb(8,48,107)',
                                             width = 3))) %>%
        add_bars(
          x = c("Normal"),
          y = VaR_n,
          width = 0.3,
          marker = list(
            color = 'royalblue1'
          ),
          name = 'VaR Delta-Normal'
        ) %>%
        add_bars(
          x = c("Simulación Histórica"),
          y = VaRsh,
          width = 0.3,
          marker = list(
            color = 'mediumseagreen'
          ),
          name = 'VaR Simulación Histórica'
        ) %>%
        add_bars(
          x = c("SMC Normal"),
          y = varmc,
          width = 0.3,
          marker = list(
            color = 'purple'
          ),
          name = 'VaR SMC Normal'
        ) %>%
        add_bars(
          x = c("SMC Mejor Distribución"),
          y = varmc_el,
          width = 0.3,
          marker = list(
            color = 'orange'
          ),
          name = 'VaR SMC Mejor Distribución'
        )
      
      p1
      
      
    }else{#final if problemas de rend
    
    #creo estructura de tabla
    tabla <- as.data.frame(matrix(0,nrow = (ncol(data())),ncol = 3))
    names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual")
    rownames(tabla) <- c(names(data())[-1],"Totales")
    
    
    data1 <- as.data.frame(matrix(0,nrow = 1,ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]
    
    
    for(i in 1:ncol(data1)){
      data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
    }
    
    #relleno desviaciones estandar
    tabla[,1] <- c(as.numeric(data1),NA)
    
    # #relleno valor nominal
    tabla[,2] <- c(data_pos()[,2],sum(data_pos()[,2]))
    
    # #relleno Vares individuales
    tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
    tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
    
    #calculo matriz de correlaciones (diagonal de 1's)
    S<- cor(rend)
    
    #CALCULO VAR NORMAL
    var_ind <- tabla[1:(nrow(tabla)-1),3]
    #var_ind%*%S
    VaR_n <- sqrt(var_ind%*%S%*%as.matrix(var_ind))
    
    
    #CALCULO VAR SH
    esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
    if(sum(p[,3])==1){
      #calculo escenarios
      for(i in 1:nrow(rend)){
        esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
      }
      #esc[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh)))),ncol(esc)]
      esc1 <- esc[,ncol(esc)]
      esc1 <- esc1[order(esc1)]
      
      VaRsh <- sum(data_pos()[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
              
      
    }else{return()}
    
    p1 <- plot_ly(marker = list(color = 'royalblue1',
                                line = list(color = 'rgb(8,48,107)',
                                            width = 3))) %>%
      add_bars(
        x = c("Normal"),
        y = VaR_n,
        width = 0.3,
        marker = list(
          color = 'royalblue1'
        ),
        name = 'VaR Delta-Normal'
      ) %>%
      add_bars(
        x = c("Simulación Histórica"),
        y = VaRsh,
        width = 0.3,
        marker = list(
          color = 'mediumseagreen'
        ),
        name = 'VaR Simulación Histórica'
      ) %>%
      add_bars(
        x = c("SMC Normal"),
        y = varmc,
        width = 0.3,
        marker = list(
          color = 'purple'
        ),
        name = 'VaR SMC Normal'
      ) %>%
      add_bars(
        x = c("SMC Mejor Distribución"),
        y = varmc_el,
        width = 0.3,
        marker = list(
          color = 'orange'
        ),
        name = 'VaR SMC Mejor Distribución'
      )
    
    p1
    
    
    
    }
    
  })
  
  
  #CALCULO VARES INDIVIDUALES SIMULACION HISTORICA
  output$varind_sh <- renderDataTable({ 
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #leo posiciones
    p <- data_pos()
    #p$pesos <- p[,2]/sum(p[,2])
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo posiciones
      p <- p[-b,]
      #p[,3] <- p[,2]/sum(p[,2])
      
      ma <- as.data.frame(matrix(0,nrow = nrow(rend),ncol = ncol(rend)))
      names(ma) <- paste(names(rend),"esc",sep = "_")
  
 
        #calculo escenarios
        for(i in 1:ncol(ma)){
          ma[,i] <- (1+as.numeric(rend[,i]))*(p[i,2])
        }
      
         #esc <- cbind.data.frame(rend,ma)
     
         #creo estructura para guardar Vares individuales
         var_ind <- cbind.data.frame("Títulos"=c(as.character(p[,1]),"Totales"),"Valor Nominal"=c(p[,2],sum(p[,2])),"Vares individuales"=rep(0,1+nrow(p)))
         
         for(i in 1:ncol(rend)){
           ma1 <- ma[order(ma[,i]),i]
           var_ind[i,3] <- (p[i,2])-ma1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        
         }
         
         var_ind[nrow(var_ind),3] <- sum(var_ind[1:(nrow(var_ind)-1),3])
         
         datatable(var_ind, options = list(paging = FALSE))
        # #Ordeno data
        # esc1 <- esc[,ncol(esc)]
        # esc1 <- esc1[order(esc1)]
        
        #VaRsh <- sum(p[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        #VaRsh
        
        
        
        
      #}else{return()}
      
    }else{
      ma <- as.data.frame(matrix(0,nrow = nrow(rend),ncol = ncol(rend)))
      names(ma) <- paste(names(rend),"esc",sep = "_")
      
      
      
      #calculo escenarios
      for(i in 1:ncol(ma)){
        ma[,i] <- (1+as.numeric(rend[,i]))*(p[i,2])
      }
      
      #esc <- cbind.data.frame(rend,ma)
      
      #creo estructura para guardar Vares individuales
      var_ind <- cbind.data.frame("Títulos"=c(as.character(p[,1]),"Totales"),"Valor Nominal"=c(p[,2],sum(p[,2])),"Vares individuales"=rep(0,1+nrow(p)))
      
      for(i in 1:ncol(rend)){
        ma1 <- ma[order(ma[,i]),i]
        var_ind[i,3] <- (p[i,2])-ma1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        
      }
      
      var_ind[nrow(var_ind),3] <- sum(var_ind[1:(nrow(var_ind)-1),3])
      datatable(var_ind, options = list(paging = FALSE))
        #if(sum(p[,3])==1){
        #calculo escenarios
        # for(i in 1:nrow(rend)){
        #   esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        # }
        # #esc[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh)))),ncol(esc)]
        # esc1 <- esc[,ncol(esc)]
        # esc1 <- esc1[order(esc1)]
        # 
        # VaRsh <- sum(data_pos()[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        # VaRsh        
        
     # }else{return()}
      
    }
    
    
    
  })
  
  #GRAFICO VAR INDIVIDUALES SIMULACION HISTORICA 
  output$grafico_vind_sh <- renderPlotly({ 
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #leo posiciones
    p <- data_pos()
    #p$pesos <- p[,2]/sum(p[,2])
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo posiciones
      p <- p[-b,]
      #p[,3] <- p[,2]/sum(p[,2])
      
      ma <- as.data.frame(matrix(0,nrow = nrow(rend),ncol = ncol(rend)))
      names(ma) <- paste(names(rend),"esc",sep = "_")
      
      
      #calculo escenarios
      for(i in 1:ncol(ma)){
        ma[,i] <- (1+as.numeric(rend[,i]))*(p[i,2])
      }
      
      #esc <- cbind.data.frame(rend,ma)
      
      #creo estructura para guardar Vares individuales
      var_ind <- cbind.data.frame("Títulos"=c(as.character(p[,1]),"Totales"),"Valor Nominal"=c(p[,2],sum(p[,2])),"Vares individuales"=rep(0,1+nrow(p)))
      
      for(i in 1:ncol(rend)){
        ma1 <- ma[order(ma[,i]),i]
        var_ind[i,3] <- (p[i,2])-ma1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        
      }
      
      var_ind[nrow(var_ind),3] <- sum(var_ind[1:(nrow(var_ind)-1),3])
      
      #grafico
      pie <- cbind.data.frame(var_ind[1:(nrow(var_ind)-1),1],var_ind[1:(nrow(var_ind)-1),3])
      names(pie) <- c("Titulo","ind")
      
      p <- plot_ly(pie, labels = ~Titulo, values = ~ind, type = 'pie') %>%
        layout(title = 'VaRes Individuales')
      
      
      p
      
      
      
      
      #}else{return()}
      
    }else{
      ma <- as.data.frame(matrix(0,nrow = nrow(rend),ncol = ncol(rend)))
      names(ma) <- paste(names(rend),"esc",sep = "_")
      
      
      
      #calculo escenarios
      for(i in 1:ncol(ma)){
        ma[,i] <- (1+as.numeric(rend[,i]))*(p[i,2])
      }
      
      #esc <- cbind.data.frame(rend,ma)
      
      #creo estructura para guardar Vares individuales
      var_ind <- cbind.data.frame("Títulos"=c(as.character(p[,1]),"Totales"),"Valor Nominal"=c(p[,2],sum(p[,2])),"Vares individuales"=rep(0,1+nrow(p)))
      
      for(i in 1:ncol(rend)){
        ma1 <- ma[order(ma[,i]),i]
        var_ind[i,3] <- (p[i,2])-ma1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        
      }
      
      var_ind[nrow(var_ind),3] <- sum(var_ind[1:(nrow(var_ind)-1),3])
      
      #grafico
      pie <- cbind.data.frame(var_ind[1:(nrow(var_ind)-1),1],var_ind[1:(nrow(var_ind)-1),3])
      names(pie) <- c("Titulo","ind")
      
      p <- plot_ly(pie, labels = ~Titulo, values = ~ind, type = 'pie') %>%
        layout(title = 'VaRes Individuales')
      
      p
      
      
      
    }
    
  })
  
  #GRAFICO COMPARATIVO SUMA VARES INDIVIDUALES VS VAR PORTAFOLIO SH
  output$grafico_comp_sh <- renderPlotly({ 
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #leo posiciones
    p <- data_pos()
    p$pesos <- p[,2]/sum(p[,2])
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo posiciones
      p <- p[-b,]
      p[,3] <- p[,2]/sum(p[,2])
      
      ma <- as.data.frame(matrix(0,nrow = nrow(rend),ncol = ncol(rend)))
      names(ma) <- paste(names(rend),"esc",sep = "_")
      
      
      #calculo escenarios
      for(i in 1:ncol(ma)){
        ma[,i] <- (1+as.numeric(rend[,i]))*(p[i,2])
      }
      
      #esc <- cbind.data.frame(rend,ma)
      
      #creo estructura para guardar Vares individuales
      var_ind <- cbind.data.frame("Títulos"=c(as.character(p[,1]),"Totales"),"Valor Nominal"=c(p[,2],sum(p[,2])),"Vares individuales"=rep(0,1+nrow(p)))
      
      for(i in 1:ncol(rend)){
        ma1 <- ma[order(ma[,i]),i]
        var_ind[i,3] <- (p[i,2])-ma1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        
      }
      
      var_ind[nrow(var_ind),3] <- sum(var_ind[1:(nrow(var_ind)-1),3])
      
      #calculo VaR portafolio
      esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
      if(sum(p[,3])==1){
        #calculo escenarios
        for(i in 1:nrow(rend)){
          esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        }
        
        #Ordeno data
        esc1 <- esc[,ncol(esc)]
        esc1 <- esc1[order(esc1)]
        
        VaRsh <- sum(p[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        VaRsh
      
      #grafico
      p <- plot_ly(marker = list(color = 'royalblue1',
                                 line = list(color = 'rgb(8,48,107)',
                                             width = 3))) %>%
        add_bars(
          x = c("Individual"),
          y = var_ind[nrow(var_ind),3],
          width = 0.3,
          marker = list(
            color = 'royalblue1'
          ),
          name = 'Suma VaRes individuales'
        ) %>%
        add_bars(
          x = c("Portafolio"),
          y = VaRsh,
          width = 0.3,
          marker = list(
            color = 'mediumseagreen'
          ),
          name = 'VaR Portafolio'
        )
      
      p
      
      
      
      
      }else{return()}
      
    }else{
      ma <- as.data.frame(matrix(0,nrow = nrow(rend),ncol = ncol(rend)))
      names(ma) <- paste(names(rend),"esc",sep = "_")
      
      
      
      #calculo escenarios
      for(i in 1:ncol(ma)){
        ma[,i] <- (1+as.numeric(rend[,i]))*(p[i,2])
      }
      
      #esc <- cbind.data.frame(rend,ma)
      
      #creo estructura para guardar Vares individuales
      var_ind <- cbind.data.frame("Títulos"=c(as.character(p[,1]),"Totales"),"Valor Nominal"=c(p[,2],sum(p[,2])),"Vares individuales"=rep(0,1+nrow(p)))
      
      for(i in 1:ncol(rend)){
        ma1 <- ma[order(ma[,i]),i]
        var_ind[i,3] <- (p[i,2])-ma1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        
      }
      
      var_ind[nrow(var_ind),3] <- sum(var_ind[1:(nrow(var_ind)-1),3])
      
      #calculo VaR portafolio
      esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
      if(sum(p[,3])==1){
        #calculo escenarios
        for(i in 1:nrow(rend)){
          esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        }
        
        #Ordeno data
        esc1 <- esc[,ncol(esc)]
        esc1 <- esc1[order(esc1)]
        
        VaRsh <- sum(p[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        VaRsh
        
        #grafico
        p <- plot_ly(marker = list(color = 'royalblue1',
                                   line = list(color = 'rgb(8,48,107)',
                                               width = 3))) %>%
          add_bars(
            x = c("Individual"),
            y = var_ind[nrow(var_ind),3],
            width = 0.3,
            marker = list(
              color = 'royalblue1'
            ),
            name = 'Suma VaRes individuales'
          ) %>%
          add_bars(
            x = c("Portafolio"),
            y = VaRsh,
            width = 0.3,
            marker = list(
              color = 'mediumseagreen'
            ),
            name = 'VaR Portafolio'
          )
        
        p
     
      }else{return()}
      
      
    }
    
  })
  
  ##################
  ##VAR MONTECARLO##
  ##################
  #ASUMO NORMALIDAD
  #RENDIMIENTOS
  output$rend_varmc_n<-renderDataTable({
    if(is.null(data())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    data1 <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]
    
    
    for(i in 1:(ncol(data())-1)){
      data1[,i] <- diff(log(data()[,i+1]))
    }
    
    #datatable(head(data1))
    datatable(data1)
  })
  
  #ADVERTENCIA
  output$advertencia_varmc_n <-renderPrint({
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    if(sum(a)>=1){
      print("Existen problemas con los rendimientos de los títulos")
      print(names(rend)[which(a==1)])
      print("los mismos se excluirán del estudio")
    }else{
      print("No hay problemas con los rendimientos")
    }
    
  })
  
  #PARAMETROS SELECCIONADOS
  output$parametros_varmc_n<-renderDataTable({
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo problemas con rend
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      #creo data frame para distribuciones
      data1 <- as.data.frame(matrix(0,nrow = 2,ncol = ncol(rend) ))
      names(data1) <- names(data())[-c(1,(b+1))]
      rownames(data1) <- c("Media","Desviación estandar")
      
      for(i in 1:ncol(data1)){
        data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[1]
        data1[2,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
        
      }
      return(data1)
      
    }
    
    #creo data frame para distribuciones
    data1 <- as.data.frame(matrix(0,nrow = 2,ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]
    rownames(data1) <- c("Media","Desviación estandar")
    
    for(i in 1:ncol(data1)){
      data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[1]
      data1[2,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      
    }
    data1
  })
  
  #% VAR
  output$porcentaje_varmc_n <- renderPrint({
    print(as.numeric(sub(",",".",input$porVarmc_n)))
  })
  
  #CREO FUNCION REACTIVA QUE ME CALCULA EL VAR INDIVIDUAL MONTE CARLO
  varmc_ind_n <- reactive({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #leo posiciones
    p <- data_pos()
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo posiciones
      p <- p[-b,]
      
      #creo vector de vares individuales
      var_n <- rep(0,ncol(rend))
      
      for(i in 1:ncol(rend)){
        #Calculo numeros aleatorios
        n_norm <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
        
        #calculo incrementos 
        pre_inc <- p[i,2]*n_norm
        
        #precio
        pre <- p[i,2]+pre_inc
        
        #valor corte
        #ordeno precios
        pre1 <- pre[order(pre)]
        vc <- pre1[length(n_norm)*(1-as.numeric(sub(",",".",input$porVarmc_n)))]
        
        #VaR
        var_n[i] <- p[i,2]-vc
        
      }#final for vares individuales
      
      #creo estructura de tabla
      tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 3))
      names(tabla) <- c("Valor Nominal","VaR Individual","VaR Porcentaje")
      rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")
      
      #relleno valor nominal
      tabla[,1] <- c(p[,2],sum(p[,2]))
      
      #relleno Vares individuales
      tabla[,2] <- c(var_n,sum(var_n))
      
      #relleno VaR en porcentaje
      tabla[,3] <- tabla[,2]*100/tabla[nrow(tabla),2]
      tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
      
      return(tabla)
      
    }
    
    #creo vector de vares individuales
    var_n <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      #Calculo numeros aleatorios
      n_norm <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
      
      #calculo incrementos 
      pre_inc <- p[i,2]*n_norm
      
      #precio
      pre <- p[i,2]+pre_inc
      
      #valor corte
      #ordeno precios
      pre1 <- pre[order(pre)]
      #vc <- pre1[length(n_norm)*5/100]
      vc <- pre1[length(n_norm)*(1-as.numeric(sub(",",".",input$porVarmc_n)))]
      
      
      #VaR
      var_n[i] <- p[i,2]-vc
      
    }#final for vares individuales
    
    #creo estructura de tabla
    tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 3))
    names(tabla) <- c("Valor Nominal","VaR Individual","VaR Porcentaje")
    rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")
    
    #relleno valor nominal
    tabla[,1] <- c(p[,2],sum(p[,2]))
    
    
    #relleno Vares individuales
    tabla[,2] <- c(var_n,sum(var_n))
    
    #relleno VaR en porcentaje
    tabla[,3] <- tabla[,2]*100/tabla[nrow(tabla),2]
    tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
    
    return(tabla)
    
  })
  
  
  #CALCULO VARES INDIVIDUALES MC
  output$tabla_varmc_n <-renderDataTable({
    datatable(varmc_ind_n(), options = list(paging = FALSE))
  })
  
  #CREO FUNCION REACTIVA QUE ME CALCULA EL VAR DE PORTAFOLIO MONTE CARLO
  varmc_por_n <- reactive({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #leo posiciones
    p <- data_pos()
    p$pesos <- p[,2]/sum(p[,2])
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo posiciones
      p <- p[-b,]
      p[,3] <- p[,2]/sum(p[,2])
      
      #creo matriz donde guardare simulaciones de cada instrumento
      mat <- as.data.frame(matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend)+2)))
      names(mat) <- c(names(rend),"incremento","escenario")
      
      #relleno matriz de simulaciones
      withProgress(message = 'Calculando números aleatorios', value = 0, {
        incProgress(1/3, detail = "Realizando iteraciones")
      for(i in 1:ncol(rend)){
        mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
      }
      })
      
      #calculo columna "incremento precio"
      withProgress(message = 'Calculando variaciones de precio', value = 0, {
        incProgress(1/2, detail = "Realizando iteraciones")
      for(i in 1:nrow(mat)){
        mat$incremento[i] <- sum(p[,2])*sum(as.numeric(p[,3])*as.numeric(mat[i,1:ncol(rend)]))
      }
      })
      #calculo columna "escenario"
      withProgress(message = 'Calculando simulaciones', value = 0, {
        incProgress(2/3, detail = "Realizando iteraciones")
      for(i in 1:nrow(mat)){
        mat$escenario[i] <- sum(p[,2])+mat$incremento[i]
      }
      })
      #ordeno columna "escenarios"
      mat1 <- mat$escenario
      mat1 <- mat1[order(mat1)]
      
      #calculo valor de corte y VaR Monte Carlo
      #vc <- (mat1[length(mat1)*5/100])
      vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_n)))])
      var_sm <- sum(p[,2])-vc
      
      lista <- list(var_sm,mat1,vc)
      
      return(lista)
      
      
      
    }#final if
    
    #creo matriz donde guardare simulaciones de cada instrumento
    mat <- as.data.frame(matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend)+2)))
    names(mat) <- c(names(rend),"incremento","escenario")
    
    #relleno matriz de simulaciones
    for(i in 1:ncol(rend)){
      mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
    }
    
    #calculo columna "incremento precio"
    for(i in 1:nrow(mat)){
      mat$incremento[i] <- sum(p[,2])*sum(as.numeric(p[,3])*as.numeric(mat[i,1:ncol(rend)]))
    }
    
    #calculo columna "escenario"
    for(i in 1:nrow(mat)){
      mat$escenario[i] <- sum(p[,2])+mat$incremento[i]
    }
    
    #ordeno columna "escenarios"
    mat1 <- mat$escenario
    mat1 <- mat1[order(mat1)]
    
    #calculo valor de corte y VaR Monte Carlo
    #vc <- (mat1[length(mat1)*5/100])
    vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_n)))])
    var_sm <- sum(p[,2])-vc
    #return(var_sm)
    lista <- list(var_sm,mat1,vc)
    
    return(lista)
    
  })
  
  #CALCULO VAR PORTAFOLIO MC
  output$varmc_portafolio_n<-renderPrint({
    varmc_por_n()[[1]]
  })
  
  
  #ELEGIR CANTIDAD DE SIMULACIONES
  output$simulaciones_varmc_n <- renderPrint({
    input$sim_varmc_n
  })
  
 
  
  #GRAFICO VARES INDIVIDUALES SIMULACION MONTE CARLO
  output$grafico_vind_mcn <- renderPlotly({ 
    if(is.null(data())){return()}
    
    #obtengo tabla con vares individuales
    tabla <- varmc_ind_n()

      #grafico
      pie <- cbind.data.frame(rownames(tabla)[-nrow(tabla)],tabla[1:(nrow(tabla)-1),2])
      names(pie) <- c("Titulo","ind")
      
      p <- plot_ly(pie, labels = ~Titulo, values = ~ind, type = 'pie') %>%
        layout(title = 'VaRes Individuales')

      p
  })
  
  #GRAFICO COMPARATIVO VARES INDIVIDUALES VS VAR PORTAFOLIO SIMULACION MONTE CARLO
  output$grafico_comp_mcn <- renderPlotly({ 
    if(is.null(data())){return()}
    
    #obtengo vares individuales 
     varind <- varmc_ind_n()
     
     #obtengo var portafolio
     varpor <- varmc_por_n1()[[1]]
    
    
        #grafico
        p <- plot_ly(marker = list(color = 'royalblue1',
                                   line = list(color = 'rgb(8,48,107)',
                                               width = 3))) %>%
          add_bars(
            x = c("Individual"),
            y = varind[nrow(varind),2],
            width = 0.3,
            marker = list(
              color = 'royalblue1'
            ),
            name = 'Suma VaRes individuales'
          ) %>%
          add_bars(
            x = c("Portafolio"),
            y = varpor,
            width = 0.3,
            marker = list(
              color = 'mediumseagreen'
            ),
            name = 'VaR Portafolio'
          )
        
        p
   
  })
  
  #GRAFICO HISTOGRAMA DE ESCENARIOS VAR SMC DIST NORMAL
  output$grafico_hist_smcn <- renderPlotly({ 

    if(is.null(data())){return()}
    #obtengo data escenarios
    mat1 <- varmc_por_n1()[[2]]
    
    #calculo valor de corte y VaR Monte Carlo
    #vc <- (mat1[length(mat1)*5/100])
    vc <- varmc_por_n1()[[3]]
    #var_sm <- sum(p[,2])-vc
    #return(var_sm)
    
        
    p2 <- plot_ly(cbind.data.frame(seq(1,length(mat1)),mat1), x = ~mat1) %>% add_histogram(name="Histograma")  %>%
      add_segments(x=vc, y=0, xend=vc, yend=mean(hist(mat1)$counts), line=list(color="red", width = 4),name="Valor Corte") %>%
      layout(title = 'Histograma de Escenarios',
             xaxis = list(title=" "))
    
    p2
    
    
  })
  
   #ELEGIR DISTRIBUCION
  #RENDIMIENTOS ELEGIR DISTRIBUCION VAR MC
  output$rend_varmc_el<-renderDataTable({
    if(is.null(data())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    data1 <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]
    
    
    for(i in 1:(ncol(data())-1)){
      data1[,i] <- diff(log(data()[,i+1]))
    }
    
    #datatable(head(data1))
    datatable(data1)
  })
  
  
  #ADVERTENCIAS ELEGIR DISTRIBUCION VAR MC
  output$advertencia_varmc_el <-renderPrint({
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    if(sum(a)>=1){
      print("Existen problemas con los rendimientos de los títulos")
      print(names(rend)[which(a==1)])
      print("los mismos se excluirán del estudio")
    }else{
      print("No hay problemas con los rendimientos")
    }
    
  })
  
  #TABLA DISTRIBUCIONES ELEGIR DISTRIBUCION VAR MC
  output$dist_varmc_el <- renderDataTable({
    #leo el historico actualizado
   # hist <- read.csv(paste(getwd(),"data","distribuciones.txt",sep = "/"),sep="")
   #  hist 
    #distribuciones()
    if(input$seleccion_dist==0){
      distribuciones()
    }else if(input$seleccion_dist==1){
      #as.data.frame(rep(1,10))
      b <- read.csv(paste(getwd(),"data","distribuciones2.txt",sep = "/"),sep="")
      b
    }
  })
  
  
  # % VAR ELEGIR DISTRIBUCION VAR MC
  output$porcentaje_varmc_el <- renderPrint({
    print(as.numeric(sub(",",".",input$porVarmc_el)))
  })
  
  #NUMERO DE SIMULACIONES ELEGIR DISTRIBUCION VAR MC
  output$simulaciones_varmc_el <- renderPrint({
    input$sim_varmc_el
  })
  
  #VARES INDIVIDUALES ELEGIR DISTRIBUCION VAR MC
  varmc_ind_el <- reactive({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #leo posiciones
    p <- data_pos()
    
    #leo tabla de distribuciones
    if(input$seleccion_dist==0){
      dist <- distribuciones()
    }else if(input$seleccion_dist==1){
      dist <- read.csv(paste(getwd(),"data","distribuciones2.txt",sep = "/"),sep="")
    }
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo posiciones
      p <- p[-b,]
      
      #creo vector de vares individuales
      var_n <- rep(0,ncol(rend))
      
      #return(as.character(dist[,2])=="Normal")
      
      
      for(i in 1:ncol(rend)){
        #Calculo numeros aleatorios
        #n_norm <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
        if(as.character(dist[,i])=="Normal"){
          #n_rand <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="nor") #normal   
          #realizo simulacion
          n_rand <- rlmomco(input$sim_varmc_el,b1) 
        }else if(as.character(dist[,i])=="Exponential"){
          #n_rand <- rexp(n = input$sim_varmc_n,rate = as.numeric(fitdistr(rend[,i],"exponential")$estimate))
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="exp") #normal   
          #realizo simulacion
          n_rand <- rlmomco(input$sim_varmc_el,b1)
        }else if(as.character(dist[,i])=="Cauchy"){
          #n_rand <- rcauchy(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[2])
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="cau") #normal   
          #realizo simulacion
          n_rand <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Logistic"){
          #n_rand <- rlogis(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"logistic")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"logistic")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="glo") #normal
            #realizo simulacion
            n_rand <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Beta"){
          #
        }else if(as.character(dist[,i])=="Chi-square"){
          #
        }else if(as.character(dist[,i])=="Uniform"){
          #
        }else if(as.character(dist[,i])=="Gamma"){
          #n_rand <- rgamma(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[1],rate = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[2])
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="gam") #normal   
          #realizo simulacion
          n_rand <- rlmomco(input$sim_varmc_el,b1)
        }else if(as.character(dist[,i])=="Lognormal"){
          n_rand <- rlnorm(n = input$sim_varmc_el,meanlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[1],sdlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[2])
        }else if(as.character(dist[,i])=="Weibull"){
          #n_rand <- rweibull(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[1],scale = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[2])
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="wei") #normal   
          #realizo simulacion
          n_rand <- rlmomco(input$sim_varmc_el,b1)
        }else if(as.character(dist[,i])=="F"){
          #
        }else if(as.character(dist[,i])=="Student"){
          #
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="st3") #normal   
          #realizo simulacion
          n_rand <- rlmomco(input$sim_varmc_el,b1)
        }else if(as.character(dist[,i])=="Gompertz"){
          #
        }else{
          n_rand <- 0
        }
        
        
        #calculo incrementos 
        pre_inc <- p[i,2]*n_rand
        
        #precio
        pre <- p[i,2]+pre_inc
        
        #valor corte
        #ordeno precios
        pre1 <- pre[order(pre)]
        #vc <- pre1[length(n_norm)*5/100]
        vc <- pre1[input$sim_varmc_el*(1-as.numeric(sub(",",".",input$porVarmc_el)))]
        
        
        #VaR
        var_n[i] <- p[i,2]-vc
        
      }#final for vares individuales
      
      #creo estructura de tabla
      tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 3))
      names(tabla) <- c("Valor Nominal","VaR Individual","VaR Porcentaje")
      rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")
      
      #relleno valor nominal
      tabla[,1] <- c(p[,2],sum(p[,2]))
      
      
      #relleno Vares individuales
      tabla[,2] <- c(var_n,sum(var_n))
      
      #relleno VaR en porcentaje
      tabla[,3] <- tabla[,2]*100/tabla[nrow(tabla),2]
      tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
      
      return(tabla)
      
      
    }
    
    #creo vector de vares individuales
    var_n <- rep(0,ncol(rend))
    
    #leo tabla de distribuciones
    #dist <- distribuciones()
    
    #return(as.character(dist[,2])=="Normal")
    
    for(i in 1:ncol(rend)){
      #Calculo numeros aleatorios
      #n_norm <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
      if(as.character(dist[,i])=="Normal"){
        #n_rand <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="nor") #normal   
        #realizo simulacion
        n_rand <- rlmomco(input$sim_varmc_el,b1) 
      }else if(as.character(dist[,i])=="Exponential"){
        #n_rand <- rexp(n = input$sim_varmc_n,rate = as.numeric(fitdistr(rend[,i],"exponential")$estimate))
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="exp") #normal   
        #realizo simulacion
        n_rand <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="Cauchy"){
        #n_rand <- rcauchy(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[2])
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="cau") #normal   
        #realizo simulacion
        n_rand <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="Logistic"){
        #n_rand <- rlogis(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"logistic")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"logistic")$estimate)[2])
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="glo") #normal   
        #realizo simulacion
        n_rand <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="Beta"){
        #
      }else if(as.character(dist[,i])=="Chi-square"){
        #
      }else if(as.character(dist[,i])=="Uniform"){
        #
      }else if(as.character(dist[,i])=="Gamma"){
        #n_rand <- rgamma(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[1],rate = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[2])
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="gam") #normal   
        #realizo simulacion
        n_rand <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="Lognormal"){
        n_rand <- rlnorm(n = input$sim_varmc_el,meanlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[1],sdlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[2])
      }else if(as.character(dist[,i])=="Weibull"){
        #n_rand <- rweibull(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[1],scale = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[2])
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="wei") #normal   
        #realizo simulacion
        n_rand <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="F"){
        #
      }else if(as.character(dist[,i])=="Student"){
        #
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="st3") #normal   
        #realizo simulacion
        n_rand <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="Gompertz"){
        #
      }else{
        n_rand <- 0
      }
      
      
      
      #calculo incrementos 
      pre_inc <- p[i,2]*n_rand
      
      #precio
      pre <- p[i,2]+pre_inc
      
      #valor corte
      #ordeno precios
      pre1 <- pre[order(pre)]
      #vc <- pre1[length(n_norm)*5/100]
      vc <- pre1[input$sim_varmc_el*(1-as.numeric(sub(",",".",input$porVarmc_el)))]
      
      
      #VaR
      var_n[i] <- p[i,2]-vc
      
    }#final for vares individuales
    
    #creo estructura de tabla
    tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 3))
    names(tabla) <- c("Valor Nominal","VaR Individual","VaR Porcentaje")
    rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")
    
    #relleno valor nominal
    tabla[,1] <- c(p[,2],sum(p[,2]))
    
    
    #relleno Vares individuales
    tabla[,2] <- c(var_n,sum(var_n))
    
    #relleno VaR en porcentaje
    tabla[,3] <- tabla[,2]*100/tabla[nrow(tabla),2]
    tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
    
    return(tabla)
    
  })
  
  
  
  output$tabla_varmc_el <- renderDataTable({
    datatable(varmc_ind_el(), options = list(paging = FALSE))
  })
  
  #VAR PORTAFOLIO ELEGIR DISTRIBUCION VAR MC
  #CREO FUNCION REACTIVA QUE ME CALCULA EL VAR DE PORTAFOLIO MONTE CARLO
  varmc_por_el <- reactive({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #leo posiciones
    p <- data_pos()
    p$pesos <- p[,2]/sum(p[,2])
    
    #leo distribuciones
    if(input$seleccion_dist==0){
      dist <- distribuciones()
    }else if(input$seleccion_dist==1){
      dist <- read.csv(paste(getwd(),"data","distribuciones2.txt",sep = "/"),sep="")
    }
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo posiciones
      p <- p[-b,]
      p[,3] <- p[,2]/sum(p[,2])
      
      #creo matriz donde guardare simulaciones de cada instrumento
      mat <- as.data.frame(matrix(0,nrow = input$sim_varmc_el,ncol = (ncol(rend)+2)))
      names(mat) <- c(names(rend),"incremento","escenario")
      
      
      #relleno matriz de simulaciones
      withProgress(message = 'Calculando números aleatorios', value = 0, {
        incProgress(1/3, detail = "Realizando iteraciones")
        for(i in 1:ncol(rend)){
          #mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
          if(as.character(dist[,i])=="Normal"){
            #n_rand <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="nor") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1) 
          }else if(as.character(dist[,i])=="Exponential"){
            #n_rand <- rexp(n = input$sim_varmc_n,rate = as.numeric(fitdistr(rend[,i],"exponential")$estimate))
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="exp") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Cauchy"){
            #n_rand <- rcauchy(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="cau") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Logistic"){
            #n_rand <- rlogis(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"logistic")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"logistic")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="glo") #normal
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Beta"){
            #
          }else if(as.character(dist[,i])=="Chi-square"){
            #
          }else if(as.character(dist[,i])=="Uniform"){
            #
          }else if(as.character(dist[,i])=="Gamma"){
            #n_rand <- rgamma(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[1],rate = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="gam") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Lognormal"){
            mat[,i] <- rlnorm(n = input$sim_varmc_el,meanlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[1],sdlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[2])
          }else if(as.character(dist[,i])=="Weibull"){
            #n_rand <- rweibull(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[1],scale = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="wei") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="F"){
            #
          }else if(as.character(dist[,i])=="Student"){
            #
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="st3") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Gompertz"){
            #
          }else{
            mat[,i] <- rep(0,input$sim_varmc_el)
          }
          
          
          }
      })
      
      #calculo columna "incremento precio"
      withProgress(message = 'Calculando variaciones de precio', value = 0, {
        incProgress(1/2, detail = "Realizando iteraciones")
        for(i in 1:nrow(mat)){
          mat$incremento[i] <- sum(p[,2])*sum(as.numeric(p[,3])*as.numeric(mat[i,1:ncol(rend)]))
          }
      })
      #calculo columna "escenario"
      withProgress(message = 'Calculando simulaciones', value = 0, {
        incProgress(2/3, detail = "Realizando iteraciones")
        for(i in 1:nrow(mat)){
          mat$escenario[i] <- sum(p[,2])+mat$incremento[i]
        }
      })
      #ordeno columna "escenarios"
      mat1 <- mat$escenario
      mat1 <- mat1[order(mat1)]
      
      #calculo valor de corte y VaR Monte Carlo
      #vc <- (mat1[length(mat1)*5/100])
      vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_el)))])
      var_sm <- sum(p[,2])-vc
      
      lista <- list(var_sm,mat1,vc)
      
      return(lista)
      
      
      
    }#final if
    
    #creo matriz donde guardare simulaciones de cada instrumento
    mat <- as.data.frame(matrix(0,nrow = input$sim_varmc_el,ncol = (ncol(rend)+2)))
    names(mat) <- c(names(rend),"incremento","escenario")
    
    #relleno matriz de simulaciones
    for(i in 1:ncol(rend)){
      #mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
      if(as.character(dist[,i])=="Normal"){
        #n_rand <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="nor") #normal   
        #realizo simulacion
        mat[,i] <- rlmomco(input$sim_varmc_el,b1) 
      }else if(as.character(dist[,i])=="Exponential"){
        #n_rand <- rexp(n = input$sim_varmc_n,rate = as.numeric(fitdistr(rend[,i],"exponential")$estimate))
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="exp") #normal   
        #realizo simulacion
        mat[,i] <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="Cauchy"){
        #n_rand <- rcauchy(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[2])
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="cau") #normal   
        #realizo simulacion
        mat[,i] <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="Logistic"){
        #n_rand <- rlogis(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"logistic")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"logistic")$estimate)[2])
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="glo") #normal
        #realizo simulacion
        mat[,i] <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="Beta"){
        #
      }else if(as.character(dist[,i])=="Chi-square"){
        #
      }else if(as.character(dist[,i])=="Uniform"){
        #
      }else if(as.character(dist[,i])=="Gamma"){
        #n_rand <- rgamma(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[1],rate = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[2])
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="gam") #normal   
        #realizo simulacion
        mat[,i] <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="Lognormal"){
        mat[,i] <- rlnorm(n = input$sim_varmc_el,meanlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[1],sdlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[2])
      }else if(as.character(dist[,i])=="Weibull"){
        #n_rand <- rweibull(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[1],scale = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[2])
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="wei") #normal   
        #realizo simulacion
        mat[,i] <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="F"){
        #
      }else if(as.character(dist[,i])=="Student"){
        #
        #calculo momentos
        a1 <- lmom.ub(rend[,i])
        #convierto valor anterior en parametros
        b1 <- lmom2par(a1,type="st3") #normal   
        #realizo simulacion
        mat[,i] <- rlmomco(input$sim_varmc_el,b1)
      }else if(as.character(dist[,i])=="Gompertz"){
        #
      }else{
        mat[,i] <- rep(0,input$sim_varmc_el)
      }
      }
    
    #calculo columna "incremento precio"
    for(i in 1:nrow(mat)){
      mat$incremento[i] <- sum(p[,2])*sum(as.numeric(p[,3])*as.numeric(mat[i,1:ncol(rend)]))
    }
    
    #calculo columna "escenario"
    for(i in 1:nrow(mat)){
      mat$escenario[i] <- sum(p[,2])+mat$incremento[i]
    }
    
    #ordeno columna "escenarios"
    mat1 <- mat$escenario
    mat1 <- mat1[order(mat1)]
    
    #calculo valor de corte y VaR Monte Carlo
    #vc <- (mat1[length(mat1)*5/100])
    vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_el)))])
    var_sm <- sum(p[,2])-vc
    #return(var_sm)
    lista <- list(var_sm,mat1,vc)
    
    return(lista)
    
  })
  
  #CALCULO VAR PORTAFOLIO MC
  output$varmc_portafolio_el<-renderPrint({
    varmc_por_el()[[1]]
  })

  ###############
  #CALCULO VAR MONTECARLO PORTAFOLIO USANDO MATRIZ DE CORRELACION
  #SECCION ELEGIR DISTRIBUCION
  #CREO FUNCION AUXILIAR
  varmc_por_el1 <- reactive({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #leo posiciones
    p <- data_pos()
    #p$pesos <- p[,2]/sum(p[,2])
    
    #leo distribuciones
    if(input$seleccion_dist==0){
      dist <- distribuciones()
    }else if(input$seleccion_dist==1){
      dist <- read.csv(paste(getwd(),"data","distribuciones2.txt",sep = "/"),sep="")
    }
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo posiciones
      p <- p[-b,]
      #p[,3] <- p[,2]/sum(p[,2])
      
      #creo matriz donde guardare simulaciones de cada instrumento
      #mat <- as.data.frame(matrix(0,nrow = input$sim_varmc_el,ncol = (ncol(rend)+2)))
      #names(mat) <- c(names(rend),"incremento","escenario")
      mat <- (matrix(0,nrow = input$sim_varmc_el,ncol = (ncol(rend))))
      names(mat) <- c(names(rend))
      
      
      #relleno matriz de simulaciones
      withProgress(message = 'Calculando números aleatorios', value = 0, {
        incProgress(1/3, detail = "Realizando iteraciones")
        for(i in 1:ncol(rend)){
          #mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
          if(as.character(dist[,i])=="Normal"){
            #n_rand <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="nor") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1) 
          }else if(as.character(dist[,i])=="Exponential"){
            #n_rand <- rexp(n = input$sim_varmc_n,rate = as.numeric(fitdistr(rend[,i],"exponential")$estimate))
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="exp") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Cauchy"){
            #n_rand <- rcauchy(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="cau") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Logistic"){
            #n_rand <- rlogis(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"logistic")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"logistic")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="glo") #normal
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Beta"){
            #
          }else if(as.character(dist[,i])=="Chi-square"){
            #
          }else if(as.character(dist[,i])=="Uniform"){
            #
          }else if(as.character(dist[,i])=="Gamma"){
            #n_rand <- rgamma(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[1],rate = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="gam") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Lognormal"){
            mat[,i] <- rlnorm(n = input$sim_varmc_el,meanlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[1],sdlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[2])
          }else if(as.character(dist[,i])=="Weibull"){
            #n_rand <- rweibull(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[1],scale = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="wei") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="F"){
            #
          }else if(as.character(dist[,i])=="Student"){
            #
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="st3") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Gompertz"){
            #
          }else{
            mat[,i] <- rep(0,input$sim_varmc_el)
          }
          
          
        }
      })
      
      #CALCULO MATRIZ DE CHOLESKY
      cholesky <- t(chol(cor(rend,use="complete.obs")))
      
      #5) REALIZO PRODUCTO DE MATRIZ DE N ALEATORIOS*MAT CHOLESKY
      mrs <- mat%*%t(cholesky)
      
      #6) calculo "incremento de precio"
      mrs1 <- mrs%*%p[,2]
      
      #7) calculo "precio" (siempre positivo)
      mrs2 <- sum(p[,2])+mrs1
      
      
      #10) CALCULO CUANTIL, QUE ES EL VAR
      #quantile(gop2,  probs = c(0.05),type = 1)
      #ordeno columna "escenarios"
      mat1 <- mrs2[order(mrs2)]
      
      #calculo valor de corte y VaR Monte Carlo
      #vc <- (mat1[length(mat1)*5/100])
      vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_el)))])
      var_sm <- sum(p[,2])-vc
      
      lista <- list(var_sm,mat1,vc)
      
      return(lista)
      
      
      
    }#final if
    
    #creo matriz donde guardare simulaciones de cada instrumento
    #mat <- as.data.frame(matrix(0,nrow = input$sim_varmc_el,ncol = (ncol(rend)+2)))
    #names(mat) <- c(names(rend),"incremento","escenario")
    mat <- (matrix(0,nrow = input$sim_varmc_el,ncol = (ncol(rend))))
    names(mat) <- c(names(rend))
    
    
    #relleno matriz de simulaciones
    withProgress(message = 'Calculando números aleatorios', value = 0, {
      incProgress(1/3, detail = "Realizando iteraciones")
      for(i in 1:ncol(rend)){
        #mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
        if(as.character(dist[,i])=="Normal"){
          #n_rand <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="nor") #normal   
          #realizo simulacion
          mat[,i] <- rlmomco(input$sim_varmc_el,b1) 
        }else if(as.character(dist[,i])=="Exponential"){
          #n_rand <- rexp(n = input$sim_varmc_n,rate = as.numeric(fitdistr(rend[,i],"exponential")$estimate))
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="exp") #normal   
          #realizo simulacion
          mat[,i] <- rlmomco(input$sim_varmc_el,b1)
        }else if(as.character(dist[,i])=="Cauchy"){
          #n_rand <- rcauchy(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[2])
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="cau") #normal   
          #realizo simulacion
          mat[,i] <- rlmomco(input$sim_varmc_el,b1)
        }else if(as.character(dist[,i])=="Logistic"){
          #n_rand <- rlogis(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"logistic")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"logistic")$estimate)[2])
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="glo") #normal
          #realizo simulacion
          mat[,i] <- rlmomco(input$sim_varmc_el,b1)
        }else if(as.character(dist[,i])=="Beta"){
          #
        }else if(as.character(dist[,i])=="Chi-square"){
          #
        }else if(as.character(dist[,i])=="Uniform"){
          #
        }else if(as.character(dist[,i])=="Gamma"){
          #n_rand <- rgamma(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[1],rate = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[2])
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="gam") #normal   
          #realizo simulacion
          mat[,i] <- rlmomco(input$sim_varmc_el,b1)
        }else if(as.character(dist[,i])=="Lognormal"){
          mat[,i] <- rlnorm(n = input$sim_varmc_el,meanlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[1],sdlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[2])
        }else if(as.character(dist[,i])=="Weibull"){
          #n_rand <- rweibull(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[1],scale = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[2])
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="wei") #normal   
          #realizo simulacion
          mat[,i] <- rlmomco(input$sim_varmc_el,b1)
        }else if(as.character(dist[,i])=="F"){
          #
        }else if(as.character(dist[,i])=="Student"){
          #
          #calculo momentos
          a1 <- lmom.ub(rend[,i])
          #convierto valor anterior en parametros
          b1 <- lmom2par(a1,type="st3") #normal   
          #realizo simulacion
          mat[,i] <- rlmomco(input$sim_varmc_el,b1)
        }else if(as.character(dist[,i])=="Gompertz"){
          #
        }else{
          mat[,i] <- rep(0,input$sim_varmc_el)
        }
        
        
      }
    })
    
    #CALCULO MATRIZ DE CHOLESKY
    cholesky <- t(chol(cor(rend,use="complete.obs")))
    
    #5) REALIZO PRODUCTO DE MATRIZ DE N ALEATORIOS*MAT CHOLESKY
    mrs <- mat%*%t(cholesky)
    
    #6) calculo "incremento de precio"
    mrs1 <- mrs%*%p[,2]
    
    #7) calculo "precio" (siempre positivo)
    mrs2 <- sum(p[,2])+mrs1
    
    
    #10) CALCULO CUANTIL, QUE ES EL VAR
    #quantile(gop2,  probs = c(0.05),type = 1)
    #ordeno columna "escenarios"
    mat1 <- mrs2[order(mrs2)]
    
    #calculo valor de corte y VaR Monte Carlo
    #vc <- (mat1[length(mat1)*5/100])
    vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_el)))])
    var_sm <- sum(p[,2])-vc
    
    lista <- list(var_sm,mat1,vc)
    
    return(lista)
  })
  
  #CALCULO VAR PORTAFOLIO MC USANDO MATRIZ DE CORRELACIONES
  #SECCION ELEGIR DISTRIBUCION
  output$varmc_portafolio_el1<-renderPrint({
    varmc_por_el1()[[1]]
  })
  
  ###############
  #CALCULO VAR MONTECARLO PORTAFOLIO USANDO MATRIZ DE CORRELACION
  #SECCION  DISTRIBUCION NORMAL
  #CREO FUNCION AUXILIAR
  varmc_por_n1 <- reactive({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #leo posiciones
    p <- data_pos()
    #p$pesos <- p[,2]/sum(p[,2])
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo posiciones
      p <- p[-b,]
      #p[,3] <- p[,2]/sum(p[,2])
      
      #creo matriz donde guardare simulaciones de cada instrumento
      mat <- (matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend))))
      names(mat) <- c(names(rend))
      
      #relleno matriz de simulaciones
      withProgress(message = 'Calculando números aleatorios', value = 0, {
        incProgress(1/3, detail = "Realizando iteraciones")
        for(i in 1:ncol(rend)){
          mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
        }
      })
      
      #2) CALCULO MATRIZ DE CHOLESKY
      cholesky <- t(chol(cor(rend,use="complete.obs")))
      
      #5) REALIZO PRODUCTO DE ESC*MAT CHOLESKY
      mrs <- mat%*%t(cholesky)
      
      # #6) CALCULO PRECIO SIMULADO DE CADA DIA
      # psim <- (matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend))))
      # names(psim) <- c(names(rend))
      # 
      # #relleno matriz de precios simulados
      # for(i in 1:ncol(rend)){
      #   psim[,i] <-  data()[nrow(data()),i+1]*exp(mrs[,i])
      # }
      # 
      # #7) CALCULO PRECIO REAL
      # preal <- (matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend))))
      # names(preal) <- c(names(rend))
      # 
      # #relleno matriz de precios simulados
      # for(i in 1:ncol(rend)){
      #   preal[,i] <-  p[i,2]*psim[,i]/100
      # }
      # 
      # #8) CALCULO GANANCIA O PERDIDA
      # gop <- (matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend))))
      # names(gop) <- c(names(rend))
      # 
      # #relleno matriz de precios simulados
      # for(i in 1:ncol(rend)){
      #   gop[,i] <-  preal[,i]-(data()[nrow(data()),i+1]/100*p[i,2])
      # }
      # 
      # #9) CALCULO GOP DE CADA DIA
      # gop2 <- rowSums(gop)
      # 
      
      #6) calculo "incremento de precio"
      mrs1 <- mrs%*%(p[,2])
      
      #7) calculo "precio" (siempre positivo)
      mrs2 <- sum(p[,2])+mrs1
      
      
      #10) CALCULO CUANTIL, QUE ES EL VAR
      mat1 <- mrs2[order(mrs2)]
      
      
      vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_n)))])
      var_sm <- sum(p[,2])-vc
      
      lista <- list(var_sm,mat1,vc)
      
      return(lista)
      
      
      
    }#final if
    
    #creo matriz donde guardare simulaciones de cada instrumento
    mat <- (matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend))))
    names(mat) <- c(names(rend))
    
    #relleno matriz de simulaciones
    withProgress(message = 'Calculando números aleatorios', value = 0, {
      incProgress(1/3, detail = "Realizando iteraciones")
      for(i in 1:ncol(rend)){
        mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
      }
    })
    
    #2) CALCULO MATRIZ DE CHOLESKY
    cholesky <- t(chol(cor(rend,use="complete.obs")))
    
    #5) REALIZO PRODUCTO DE ESC*MAT CHOLESKY
    mrs <- mat%*%t(cholesky)
    
    # #6) CALCULO PRECIO SIMULADO DE CADA DIA
    # psim <- (matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend))))
    # names(psim) <- c(names(rend))
    # 
    # #relleno matriz de precios simulados
    # for(i in 1:ncol(rend)){
    #   psim[,i] <-  data()[nrow(data()),i+1]*exp(mrs[,i])
    # }
    # 
    # #7) CALCULO PRECIO REAL
    # preal <- (matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend))))
    # names(preal) <- c(names(rend))
    # 
    # #relleno matriz de precios simulados
    # for(i in 1:ncol(rend)){
    #   preal[,i] <-  p[i,2]*psim[,i]/100
    # }
    # 
    # #8) CALCULO GANANCIA O PERDIDA
    # gop <- (matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend))))
    # names(gop) <- c(names(rend))
    # 
    # #relleno matriz de precios simulados
    # for(i in 1:ncol(rend)){
    #   gop[,i] <-  preal[,i]-(data()[nrow(data()),i+1]/100*p[i,2])
    # }
    # 
    # #9) CALCULO GOP DE CADA DIA
    # gop2 <- rowSums(gop)
    # 
    
    #6) calculo "incremento de precio"
    mrs1 <- mrs%*%(p[,2])
    
    #7) calculo "precio" (siempre positivo)
    mrs2 <- sum(p[,2])+mrs1
    
    
    #10) CALCULO CUANTIL, QUE ES EL VAR
    mat1 <- mrs2[order(mrs2)]
    
    
    vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_n)))])
    var_sm <- sum(p[,2])-vc
    
    lista <- list(var_sm,mat1,vc)
    
    return(lista)
  })
  
  
  #CALCULO VAR PORTAFOLIO MC USANDO MATRIZ DE CORRELACIONES
  #SECCION DISTRIBUCION NORMAL
  output$varmc_portafolio_n1<-renderPrint({
    varmc_por_n1()[[1]]
  })
  
  #GRAFICOS SECCION VAR MONTECARLO ELEGIR DISTRIBUCION
  #GRAFICO HISTOGRAMA DE ESCENARIOS VAR SMC DIST ELEGIDA
  output$grafico_hist_smc_el <- renderPlotly({ 
    
    if(is.null(data())){return()}
    #obtengo data escenarios
    mat1 <- (varmc_por_el1()[[2]])
    
    #calculo valor de corte y VaR Monte Carlo
    #vc <- (mat1[length(mat1)*5/100])
    vc <- (varmc_por_el1()[[3]])
    #var_sm <- sum(p[,2])-vc
    #return(var_sm)
    
    
    p2 <- plot_ly(cbind.data.frame(seq(1,length(mat1)),mat1), x = ~mat1) %>% add_histogram(name="Histograma")  %>%
      add_segments(x=vc, y=0, xend=vc, yend=mean(hist(mat1)$counts), line=list(color="red", width = 4),name="Valor Corte") %>%
      layout(title = 'Histograma de Escenarios',
             xaxis = list(title=" "))
    
    p2
    
    
  })
  
  #GRAFICO VARES INDIVIDUALES SIMULACION MONTE CARLO
  output$grafico_vind_mc_el <- renderPlotly({ 
    if(is.null(data())){return()}
    
    #obtengo tabla con vares individuales
    tabla <- varmc_ind_el()
    
    #grafico
    pie <- cbind.data.frame(rownames(tabla)[-nrow(tabla)],tabla[1:(nrow(tabla)-1),2])
    names(pie) <- c("Titulo","ind")
    
    p <- plot_ly(pie, labels = ~Titulo, values = ~ind, type = 'pie') %>%
      layout(title = 'VaRes Individuales')
    
    p
  })
  
  #GRAFICO COMPARATIVO VARES INDIVIDUALES VS VAR PORTAFOLIO SIMULACION MONTE CARLO
  output$grafico_comp_mc_el <- renderPlotly({ 
    if(is.null(data())){return()}
    
    #obtengo vares individuales 
    varind <- varmc_ind_el()
    
    #obtengo var portafolio
    varpor <- varmc_por_el1()[[1]]
    
    
    #grafico
    p <- plot_ly(marker = list(color = 'royalblue1',
                               line = list(color = 'rgb(8,48,107)',
                                           width = 3))) %>%
      add_bars(
        x = c("Individual"),
        y = varind[nrow(varind),2],
        width = 0.3,
        marker = list(
          color = 'royalblue1'
        ),
        name = 'Suma VaRes individuales'
      ) %>%
      add_bars(
        x = c("Portafolio"),
        y = varpor,
        width = 0.3,
        marker = list(
          color = 'mediumseagreen'
        ),
        name = 'VaR Portafolio'
      )
    
    p
    
  })
  
  #FUNCIONES AUXILIARES REPORTE VAR
  #VAR PARAMETRICO
  #vares normales individuales
  var_normal_ind<-reactive({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]

    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }

    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))

    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }

    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      #creo estructura de tabla
      tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 4))
      names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
      rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")

      data1 <- as.data.frame(matrix(0,nrow = 1,ncol = ncol(rend)))
      names(data1) <- names(data())[-c(1,(b+1))]


      for(i in 1:ncol(data1)){
        data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      }

      #relleno desviaciones estandar
      tabla[,1] <- c(as.numeric(data1),NA)

      # #relleno valor nominal
      tabla[,2] <- c(data_pos()[-b,2],sum(data_pos()[-b,2]))

      # #relleno Vares individuales
      tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
      tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])

      #relleno VaR en porcentaje
      tabla[,4] <- tabla[,3]*100/tabla[nrow(tabla),3]
      tabla[nrow(tabla),4] <- sum(tabla[1:((nrow(tabla))-1),4])

      return(tabla)

    }

    #creo estructura de tabla
    tabla <- as.data.frame(matrix(0,nrow = (ncol(data())),ncol = 4))
    names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
    rownames(tabla) <- c(names(data())[-1],"Totales")

    data1 <- as.data.frame(matrix(0,nrow = 1,ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]


    for(i in 1:ncol(data1)){
      # if(anyNA(rend[,i])){
      #   a <- which(is.na(rend[,i])|is.infinite(rend[,i]))
      #   data1[1,i] <- as.numeric(fitdistr(rend[-a,i],"normal")$estimate)[2]
      # }else{
      #   data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      # }
      data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]

    }

    #relleno desviaciones estandar
    tabla[,1] <- c(as.numeric(data1),NA)

    # #relleno valor nominal
    tabla[,2] <- c(data_pos()[,2],sum(data_pos()[,2]))

    # #relleno Vares individuales
    tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
    tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])

    #relleno VaR en porcentaje
    tabla[,4] <- tabla[,3]*100/tabla[nrow(tabla),3]
    tabla[nrow(tabla),4] <- sum(tabla[1:((nrow(tabla))-1),4])

    tabla
  })

  #var normal Portafolio
  #calculo VaR normal Portafolio
  var_normal_por <- reactive({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      #creo estructura de tabla
      tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 4))
      names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
      rownames(tabla) <- c(names(data())[-c(1,(b+1))],"Totales")
      
      data1 <- as.data.frame(matrix(0,nrow = 1,ncol = ncol(rend)))
      names(data1) <- names(data())[-c(1,(b+1))]
      
      
      for(i in 1:ncol(data1)){
        data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
      }
      
      #relleno desviaciones estandar
      tabla[,1] <- c(as.numeric(data1),NA)
      
      # #relleno valor nominal
      tabla[,2] <- c(data_pos()[-b,2],sum(data_pos()[-b,2]))
      
      # #relleno Vares individuales
      tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
      tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
      
      
      #calculo matriz de correlaciones (diagonal de 1's)
      S<- cor(rend)
      
      #VaR
      var_ind <- tabla[1:(nrow(tabla)-1),3]
      #var_ind%*%S
      VaR <- sqrt(var_ind%*%S%*%as.matrix(var_ind))
      return(VaR)
      
      
    }#final if problemas de rend
    
    #creo estructura de tabla
    tabla <- as.data.frame(matrix(0,nrow = (ncol(data())),ncol = 3))
    names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual")
    rownames(tabla) <- c(names(data())[-1],"Totales")
    
    
    data1 <- as.data.frame(matrix(0,nrow = 1,ncol = (ncol(data())-1)))
    names(data1) <- names(data())[-1]
    
    
    for(i in 1:ncol(data1)){
      data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
    }
    
    #relleno desviaciones estandar
    tabla[,1] <- c(as.numeric(data1),NA)
    
    # #relleno valor nominal
    tabla[,2] <- c(data_pos()[,2],sum(data_pos()[,2]))
    
    # #relleno Vares individuales
    tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
    tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
    
    #calculo matriz de correlaciones (diagonal de 1's)
    S<- cor(rend)
    
    #VaR
    var_ind <- tabla[1:(nrow(tabla)-1),3]
    #var_ind%*%S
    VaR <- sqrt(var_ind%*%S%*%as.matrix(var_ind))
    return(VaR)
    
    
    
  })
  
  #VAR SIMULACION HISTORICA
  #CALCULO VARES INDIVIDUALES SIMULACION HISTORICA
  var_historico_ind <- reactive({ 
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #leo posiciones
    p <- data_pos()
    #p$pesos <- p[,2]/sum(p[,2])
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo posiciones
      p <- p[-b,]
      #p[,3] <- p[,2]/sum(p[,2])
      
      ma <- as.data.frame(matrix(0,nrow = nrow(rend),ncol = ncol(rend)))
      names(ma) <- paste(names(rend),"esc",sep = "_")
      
      
      #calculo escenarios
      for(i in 1:ncol(ma)){
        ma[,i] <- (1+as.numeric(rend[,i]))*(p[i,2])
      }
      
      #esc <- cbind.data.frame(rend,ma)
      
      #creo estructura para guardar Vares individuales
      var_ind <- cbind.data.frame("Títulos"=c(as.character(p[,1]),"Totales"),"Valor Nominal"=c(p[,2],sum(p[,2])),"Vares individuales"=rep(0,1+nrow(p)))
      
      for(i in 1:ncol(rend)){
        ma1 <- ma[order(ma[,i]),i]
        var_ind[i,3] <- (p[i,2])-ma1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        
      }
      
      var_ind[nrow(var_ind),3] <- sum(var_ind[1:(nrow(var_ind)-1),3])
      var_ind
      # #Ordeno data
      # esc1 <- esc[,ncol(esc)]
      # esc1 <- esc1[order(esc1)]
      
      #VaRsh <- sum(p[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
      #VaRsh
      
      
      
      
      #}else{return()}
      
    }else{
      ma <- as.data.frame(matrix(0,nrow = nrow(rend),ncol = ncol(rend)))
      names(ma) <- paste(names(rend),"esc",sep = "_")
      
      
      
      #calculo escenarios
      for(i in 1:ncol(ma)){
        ma[,i] <- (1+as.numeric(rend[,i]))*(p[i,2])
      }
      
      #esc <- cbind.data.frame(rend,ma)
      
      #creo estructura para guardar Vares individuales
      var_ind <- cbind.data.frame("Títulos"=c(as.character(p[,1]),"Totales"),"Valor Nominal"=c(p[,2],sum(p[,2])),"Vares individuales"=rep(0,1+nrow(p)))
      
      for(i in 1:ncol(rend)){
        ma1 <- ma[order(ma[,i]),i]
        var_ind[i,3] <- (p[i,2])-ma1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        
      }
      
      var_ind[nrow(var_ind),3] <- sum(var_ind[1:(nrow(var_ind)-1),3])
      var_ind
      #if(sum(p[,3])==1){
      #calculo escenarios
      # for(i in 1:nrow(rend)){
      #   esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
      # }
      # #esc[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh)))),ncol(esc)]
      # esc1 <- esc[,ncol(esc)]
      # esc1 <- esc1[order(esc1)]
      # 
      # VaRsh <- sum(data_pos()[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
      # VaRsh        
      
      # }else{return()}
      
    }
    
    
    
  })
  
  #VaR historico Portafolio
  var_historico_por <- reactive({
    #calculo sd
    if(is.null(data())){return()}
    rend <- as.data.frame(matrix(0,nrow = (nrow(data())-1),ncol = (ncol(data())-1)))
    names(rend) <- names(data())[-1]
    
    for(i in 1:(ncol(data())-1)){
      rend[,i] <- diff(log(data()[,i+1]))
    }
    
    #veo si hay valores NA o inf en la data
    a <- rep(0,ncol(rend))
    
    for(i in 1:ncol(rend)){
      if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
        a[i] <- 1
      }
    }
    
    #calculo pesos
    p <- data_pos()
    p$pesos <- p[,2]/sum(p[,2])
    
    
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
      rend <- rend[,-b]
      
      #actualizo pesos
      p <- p[-b,]
      p[,3] <- p[,2]/sum(p[,2])
      
      esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
      if(sum(p[,3])==1){
        #calculo escenarios
        for(i in 1:nrow(rend)){
          esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        }
        
        #Ordeno data
        esc1 <- esc[,ncol(esc)]
        esc1 <- esc1[order(esc1)]
        
        VaRsh <- sum(p[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        VaRsh
      }else{return()}
      
    }else{
      esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
      if(sum(p[,3])==1){
        #calculo escenarios
        for(i in 1:nrow(rend)){
          esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
        }
        #esc[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh)))),ncol(esc)]
        esc1 <- esc[,ncol(esc)]
        esc1 <- esc1[order(esc1)]
        
        VaRsh <- sum(data_pos()[,2])-esc1[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
        VaRsh        
        
      }else{return()}
      
    }
    
    
    
    
  })
  
  
  #REPORTE VAR
  output$reporte_var <- downloadHandler(
    filename = "reporte_var.pdf",
    content = function(file) {
      tempReport <- file.path(tempdir(), "reporte_var.Rmd")
      #tempReport <- file.path(getwd(), "reporte1.Rmd")
      
      file.copy("reporte_var.Rmd", tempReport, overwrite = TRUE)
      
      # Configuración de parámetros pasados a documento Rmd
      # params <- list(titulos = c(input$t1_comp,input$t2_comp,input$t3_comp,input$t4_comp),
      #                pre_prom = tf_comp(),
      #                par_ns_t = gra_tif_ns_comp_i(),
      #                par_sven_t= gra_tif_sven_comp_i(),
      #                par_dl_t=dl_tif(),
      #                par_sp_t=spline_tif_comp(),
      #                comp_pre_t=precios_tif()
      # 
      # )
      
      params <- list(fecha = input$date_var,tabla_nominal = data_pos() ,
                     var_par_ind = var_normal_ind(), var_par_por = var_normal_por(),
                     var_hist_ind = var_historico_ind(),var_hist_por = var_historico_por(),
                     var_sm_ind_n = varmc_ind_n(), var_sm_por_n = varmc_por_n1()[[1]],
                     var_sm_ind_el = varmc_ind_el(),var_sm_por_el = varmc_por_el1()[[1]])
      
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempReport, output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
      )
    })
  
  #HISTORICOS
  #FECHAS DISPONIBLES
  output$fechas_disponibles_par <- renderText({
    paste(as.character(min(fe_var()))," al ",as.character(max(fe_var())))
  })
  
  output$fechas_disponibles_hist <- renderText({
    paste(as.character(min(fe_var()))," al ",as.character(max(fe_var())))
  })
  
  output$fechas_disponibles_smc1 <- renderText({
    paste(as.character(min(fe_var()))," al ",as.character(max(fe_var())))
  })
  
  output$fechas_disponibles_smc2 <- renderText({
    paste(as.character(min(fe_var()))," al ",as.character(max(fe_var())))
  })
  
  #VAR PARAMETRICO
  #MUESTRO FECHAS DISPONIBLES
  output$dateRangeText_par  <- renderText({
          paste(as.character(input$dateRange_par), collapse = " y ")
  })
  
  #FUNCION AUXILIAR DATA VAR PARAMETRICO
  data_var <- reactive({
    inFile <- input$file_data
    
    if (is.null(inFile))
      return(NULL)
    
    # read.table(inFile$datapath, header = input$header,
    #            sep = input$sep, quote = input$quote)
    a <- read.delim2(inFile$datapath, header = input$header,
                     sep = input$sep, quote = input$quote)
    
    #ordeno la data de fecha mas reciente a fecha mas antigua
    a[,1] <- as.Date(a[,1])
    a <- a[order(a[,1],decreasing = TRUE),]
    
    #seleciono 252 obs segun fecha seleccionada
    
    #a <- a[which(input$dateRange_par==a[,1]):(251+which(input$date_var==a[,1])),]
    
    return(a)
    
  })
  
  #FUNCION AUXILIAR QUE ME CALCULA FECHAS VARES PARAMETRICOS DIARIOS 
  fecha_par <- reactive({
    data <- data_var()
    
    #creo secuencia de fecha
    fe <- seq(input$dateRange_par[1],input$dateRange_par[2], "days")
    fe <- fe[order(fe,decreasing = TRUE)]
    fe1 <- rep(0,length(fe))
    
    
    for(i in 1:length(fe)){
      if(length(which(as.character(fe[i])==data[,1]))!=0){
        fe1[i] <- 1
      }
    }
    
    #veo que fechas si estan
    a <- which(fe1==1)
    
    #creo vector de fechas que si salen
    fe2 <- fe[a]
    
    # #creo estructura del VaR
    # var <- cbind.data.frame(fe2,rep(0,length(fe2)))
    # names(var) <- c("Fechas","VaR")
    # 
    # #relleno vares
    # for(i in 1:length(fe2)){
    #   var[i,2] <- funcion(fe2[i])
    # }
    
    return(fe2)
    
  })
  
  #FUNCION AUXILIAR QUE CALCULAR VAR PAR PARA UNA FECHA DADA
  #QUE VARIA SEGUN FECHAS SELECCIONADAS
  var_parametrico <- reactive({
    #LEO FECHAS A CALCULAR
    #if(is.null(fecha_par())){return()}
    fe <- fecha_par()
    
    #CREO ESTRUCTURA PARA GUARDAR LOS VARES
    var <- cbind.data.frame(fe,rep(0,length(fe)))
    names(var) <- c("Fechas","VaRes")
    
    #CREO FOR PARA CALCULAR TODOS LOS VARES PEDIDOS
    #ES POSIBLE QUE SE DEMORE UN TIEMPO
    for(j in 1:length(fe)){
    # 
    #j <- 1
    # #ACTUALIZO DATA CON LA QUE TRABAJARE
     data0 <- data_var()
     
    # #SELECCIONO 252 OBS SEGUN FECHA SELECCIONADA
     data <- data0[which(fe[j]==data0[,1]):(251+which(fe[j]==data0[,1])),]
     
    #calculo sd
     if(is.null(data)){return()}
     rend <- as.data.frame(matrix(0,nrow = (nrow(data)-1),ncol = (ncol(data)-1)))
     names(rend) <- names(data)[-1]
     
     for(i in 1:(ncol(data)-1)){
       rend[,i] <- diff(log(data[,i+1]))
     }
     
    #veo si hay valores NA o inf en la data
     a <- rep(0,ncol(rend))
     
     for(i in 1:ncol(rend)){
       if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
         a[i] <- 1
       }
     }
     
    #cuando hay problemas con rend
    #titulos donde hay problema
    b <- which(a==1)
    if(sum(a)>=1){
       rend <- rend[,-b]
      #creo estructura de tabla
       tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 4))
       names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
       rownames(tabla) <- c(names(data)[-c(1,(b+1))],"Totales")
     
       data1 <- as.data.frame(matrix(0,nrow = 1,ncol = ncol(rend)))
       names(data1) <- names(data)[-c(1,(b+1))]
     
     
       for(i in 1:ncol(data1)){
         data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
       }
     
       #relleno desviaciones estandar
       tabla[,1] <- c(as.numeric(data1),NA)
     
        #relleno valor nominal
       tabla[,2] <- c(data_pos()[-b,2],sum(data_pos()[-b,2]))
     
       #relleno Vares individuales
       tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
       tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
     
      #calculo matriz de correlaciones (diagonal de 1's)
       S<- cor(rend)
     
       #VaR
       var_ind <- tabla[1:(nrow(tabla)-1),3]
       #var_ind%*%S
       VaR <- sqrt(var_ind%*%S%*%as.matrix(var_ind))
       var[j,2] <- as.numeric(VaR)
    #  # return(VaR)
    # 
    # 
    #  var[j,2] <- tabla[nrow(tabla),3]
      #return(var)
     }else{#final if problemas de rend
     
     #creo estructura de tabla
       tabla <- as.data.frame(matrix(0,nrow = (ncol(rend)+1),ncol = 4))
       names(tabla) <- c("Desviación Estandar","Valor Nominal","VaR Individual","VaR Porcentaje")
       rownames(tabla) <- c(names(data)[-c(1,(b+1))],"Totales")
    
     data1 <- as.data.frame(matrix(0,nrow = 1,ncol = (ncol(data)-1)))
     names(data1) <- names(data)[-1]
     
     
     for(i in 1:ncol(data1)){
       data1[1,i] <- as.numeric(fitdistr(rend[,i],"normal")$estimate)[2]
     }
     
     #relleno desviaciones estandar
     tabla[,1] <- c(as.numeric(data1),NA)
     
     #relleno valor nominal
     tabla[,2] <- c(data_pos()[,2],sum(data_pos()[,2]))
     
     #relleno Vares individuales
     tabla[,3] <- c(tabla[,1]*tabla[,2]*qnorm(as.numeric(sub(",",".",input$porVarn)),0,1))
     tabla[nrow(tabla),3] <- sum(tabla[1:((nrow(tabla))-1),3])
     
     #calculo matriz de correlaciones (diagonal de 1's)
     S<- cor(rend)
     
     #VaR
     var_ind <- tabla[1:(nrow(tabla)-1),3]
     #var_ind%*%S
     VaR <- sqrt(var_ind%*%S%*%as.matrix(var_ind))
    # #return(VaR)
     var[j,2] <- as.numeric(VaR)
    # var[j,2] <- tabla[nrow(tabla),3]
     #return(var)
     }
     }

    return(var)
    
  })
  
  #GENERO OUTPUT
  output$historico_par <- renderDataTable({
    a <- try(var_parametrico())
    
    if(class(a)!="try-error"){
      write.table(a,paste(getwd(),"data","Historico_var_par.txt",sep = "/"),row.names = FALSE)
      a
    }else{}
  })
  
  #EXPORTO DATA
  output$data_var_par <-  downloadHandler(
    filename = function() {
      paste("Var_parametrico", ".txt", sep = "")
    },
    content = function(file) {
      write.table(var_parametrico(), file, row.names = FALSE)
    }
  )
  
  #VAR HISTORICO
  output$dateRangeText_hist  <- renderText({
    paste(as.character(input$dateRange_hist), collapse = " y ")
  })
  
  #FUNCION AUXILIAR QUE ME CALCULA FECHAS VARES HISTORICOS DIARIOS 
  fecha_hist <- reactive({
    data <- data_var()
    
    #creo secuencia de fecha
    fe <- seq(input$dateRange_hist[1],input$dateRange_hist[2], "days")
    fe <- fe[order(fe,decreasing = TRUE)]
    fe1 <- rep(0,length(fe))
    
    
    for(i in 1:length(fe)){
      if(length(which(as.character(fe[i])==data[,1]))!=0){
        fe1[i] <- 1
      }
    }
    
    #veo que fechas si estan
    a <- which(fe1==1)
    
    #creo vector de fechas que si salen
    fe2 <- fe[a]
    
    return(fe2)
    
  })
  
  #FUNCION AUXILIAR QUE CALCULAR VAR PAR PARA UNA FECHA DADA
  #QUE VARIA SEGUN FECHAS SELECCIONADAS
  var_historico <- reactive({
    #LEO FECHAS A CALCULAR
    #if(is.null(fecha_par())){return()}
    fe <- fecha_hist()
    
    #CREO ESTRUCTURA PARA GUARDAR LOS VARES
    var <- cbind.data.frame(fe,rep(0,length(fe)))
    names(var) <- c("Fechas","VaRes")
    
    #CREO FOR PARA CALCULAR TODOS LOS VARES PEDIDOS
    #ES POSIBLE QUE SE DEMORE UN TIEMPO
    for(j in 1:length(fe)){
      # 
      #j <- 1
      # #ACTUALIZO DATA CON LA QUE TRABAJARE
      data0 <- data_var()
      
      # #SELECCIONO 252 OBS SEGUN FECHA SELECCIONADA
      data <- data0[which(fe[j]==data0[,1]):(251+which(fe[j]==data0[,1])),]
      
      #calculo sd
      if(is.null(data)){return()}
      rend <- as.data.frame(matrix(0,nrow = (nrow(data)-1),ncol = (ncol(data)-1)))
      names(rend) <- names(data)[-1]
      
      for(i in 1:(ncol(data)-1)){
        rend[,i] <- diff(log(data[,i+1]))
      }
      
      #veo si hay valores NA o inf en la data
      a <- rep(0,ncol(rend))
      
      for(i in 1:ncol(rend)){
        if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
          a[i] <- 1
        }
      }
      
      #calculo pesos
      p <- data_pos()
      p$pesos <- p[,2]/sum(p[,2])
      
      
      #cuando hay problemas con rend
      #titulos donde hay problema
      b <- which(a==1)
      if(sum(a)>=1){
        rend <- rend[,-b]
        
        #actualizo pesos
        p <- p[-b,]
        p[,3] <- p[,2]/sum(p[,2])
        
        esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
        if(sum(p[,3])==1){
          #calculo escenarios
          for(i in 1:nrow(rend)){
            esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
          }
          
          #Ordeno data
          esc1 <- esc[,ncol(esc)]
          esc1 <- esc1[order(esc1)]
          
          VaRsh <- sum(p[,2])-esc1[round((nrow(data)-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
          var[j,2] <- VaRsh
        }else{return()}
        
      }else{
        esc <- cbind.data.frame(rend,'Escenarios'=rep(0,nrow(rend)))
        if(sum(p[,3])==1){
          #calculo escenarios
          for(i in 1:nrow(rend)){
            esc[i,ncol(esc)] <- sum((1+as.numeric(rend[i,]))*p[,3])*sum(p[,2])
          }
          #esc[round((nrow(data())-1)*(1-as.numeric(sub(",",".",input$porVarsh)))),ncol(esc)]
          esc1 <- esc[,ncol(esc)]
          esc1 <- esc1[order(esc1)]
          
          VaRsh <- sum(data_pos()[,2])-esc1[round((nrow(data)-1)*(1-as.numeric(sub(",",".",input$porVarsh))))]
          var[j,2] <- VaRsh       
          
        }else{return()}
        
      }
    }#final for Vares
      
    return(var)
    
  })
  
  #GENERO OUTPUT
  output$historico_hist <- renderDataTable({
    a <- try(var_historico())
    
    if(class(a)!="try-error"){
    write.table(a,paste(getwd(),"data","Historico_var_sh.txt",sep = "/"),row.names = FALSE)
    a
    }else{}
  })
  
  #DESCARGAR DATA
  output$data_var_hist <-  downloadHandler(
    filename = function() {
      paste("Var_historico", ".txt", sep = "")
    },
    content = function(file) {
      write.table(var_historico(), file, row.names = FALSE)
    }
  )
  
  #VAR SMC NORMAL
  output$dateRangeText_smc1  <- renderText({
    paste(as.character(input$dateRange_smc1), collapse = " y ")
  })
  
  #FUNCION AUXILIAR QUE ME CALCULA FECHAS VARES HISTORICOS DIARIOS 
  fecha_smc1 <- reactive({
    data <- data_var()
    
    #creo secuencia de fecha
    fe <- seq(input$dateRange_smc1[1],input$dateRange_smc1[2], "days")
    fe <- fe[order(fe,decreasing = TRUE)]
    fe1 <- rep(0,length(fe))
    
    
    for(i in 1:length(fe)){
      if(length(which(as.character(fe[i])==data[,1]))!=0){
        fe1[i] <- 1
      }
    }
    
    #veo que fechas si estan
    a <- which(fe1==1)
    
    #creo vector de fechas que si salen
    fe2 <- fe[a]
    
    return(fe2)
    
  })
  
  #FUNCION AUXILIAR QUE CALCULAR VAR PAR PARA UNA FECHA DADA
  #QUE VARIA SEGUN FECHAS SELECCIONADAS
  var_smc1 <- reactive({
    #LEO FECHAS A CALCULAR
    #if(is.null(fecha_par())){return()}
    fe <- fecha_smc1()
    
    #CREO ESTRUCTURA PARA GUARDAR LOS VARES
    var <- cbind.data.frame(fe,rep(0,length(fe)))
    names(var) <- c("Fechas","VaRes")
    
    #CREO FOR PARA CALCULAR TODOS LOS VARES PEDIDOS
    #ES POSIBLE QUE SE DEMORE UN TIEMPO
    for(j in 1:length(fe)){
      # 
      #j <- 1
      # #ACTUALIZO DATA CON LA QUE TRABAJARE
      data0 <- data_var()
      
      # #SELECCIONO 252 OBS SEGUN FECHA SELECCIONADA
      data <- data0[which(fe[j]==data0[,1]):(251+which(fe[j]==data0[,1])),]
      
      #--#
      #calculo sd
      if(is.null(data)){return()}
      rend <- as.data.frame(matrix(0,nrow = (nrow(data)-1),ncol = (ncol(data)-1)))
      names(rend) <- names(data)[-1]
      
      for(i in 1:(ncol(data)-1)){
        rend[,i] <- diff(log(data[,i+1]))
      }
      
      #veo si hay valores NA o inf en la data
      a <- rep(0,ncol(rend))
      
      for(i in 1:ncol(rend)){
        if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
          a[i] <- 1
        }
      }
      
      #leo posiciones
      p <- data_pos()
      #p$pesos <- p[,2]/sum(p[,2])
      
      
      #cuando hay problemas con rend
      #titulos donde hay problema
      b <- which(a==1)
      if(sum(a)>=1){
        rend <- rend[,-b]
        
        #actualizo posiciones
        p <- p[-b,]
        #p[,3] <- p[,2]/sum(p[,2])
        
        #creo matriz donde guardare simulaciones de cada instrumento
        mat <- (matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend))))
        names(mat) <- c(names(rend))
        
        #relleno matriz de simulaciones
        withProgress(message = 'Calculando números aleatorios', value = 0, {
          incProgress(1/3, detail = "Realizando iteraciones")
          for(i in 1:ncol(rend)){
            mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
          }
        })
        
        #2) CALCULO MATRIZ DE CHOLESKY
        cholesky <- t(chol(cor(rend,use="complete.obs")))
        
        #5) REALIZO PRODUCTO DE ESC*MAT CHOLESKY
        mrs <- mat%*%t(cholesky)
        
        #6) calculo "incremento de precio"
        mrs1 <- mrs%*%(p[,2])
        
        #7) calculo "precio" (siempre positivo)
        mrs2 <- sum(p[,2])+mrs1
        
        
        #10) CALCULO CUANTIL, QUE ES EL VAR
        mat1 <- mrs2[order(mrs2)]
        
        
        vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_n)))])
        var_sm <- sum(p[,2])-vc
        
        #lista <- list(var_sm,mat1,vc)
        
        #return(lista)
        var[j,2] <- var_sm
        
        
      }#final if
      
      #creo matriz donde guardare simulaciones de cada instrumento
      mat <- (matrix(0,nrow = input$sim_varmc_n,ncol = (ncol(rend))))
      names(mat) <- c(names(rend))
      
      #relleno matriz de simulaciones
      withProgress(message = 'Calculando números aleatorios', value = 0, {
        incProgress(1/3, detail = "Realizando iteraciones")
        for(i in 1:ncol(rend)){
          mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
        }
      })
      
      #2) CALCULO MATRIZ DE CHOLESKY
      cholesky <- t(chol(cor(rend,use="complete.obs")))
      
      #5) REALIZO PRODUCTO DE ESC*MAT CHOLESKY
      mrs <- mat%*%t(cholesky)
      
      #6) calculo "incremento de precio"
      mrs1 <- mrs%*%(p[,2])
      
      #7) calculo "precio" (siempre positivo)
      mrs2 <- sum(p[,2])+mrs1
      
      
      #10) CALCULO CUANTIL, QUE ES EL VAR
      mat1 <- mrs2[order(mrs2)]
      
      
      vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_n)))])
      var_sm <- sum(p[,2])-vc
      
      #lista <- list(var_sm,mat1,vc)
      var[j,2] <- var_sm
      
      #--#
      
    }#final for Vares
    
    return(var)
    
  })
  
  #GENERO OUTPUT
  output$historico_smc1 <- renderDataTable({
    a <- try(var_smc1())
    
    if(class(a)!="try-error"){
    write.table(a,paste(getwd(),"data","Historico_var_smcn.txt",sep = "/"),row.names = FALSE)
    a
    }else{}
  })
  
  #DESCARGO DATA
  output$data_var_smc1 <- downloadHandler(
    filename = function() {
      paste("Var_smc_normal", ".txt", sep = "")
    },
    content = function(file) {
      write.table(var_smc1(), file, row.names = FALSE)
    }
  )
  
  #VAR SMC MEJOR DISTRIBUCION
  output$dateRangeText_smc2  <- renderText({
    paste(as.character(input$dateRange_smc2), collapse = " y ")
  })
  
  #FUNCION AUXILIAR QUE ME CALCULA FECHAS VARES HISTORICOS DIARIOS 
  fecha_smc2 <- reactive({
    data <- data_var()
    
    #creo secuencia de fecha
    fe <- seq(input$dateRange_smc2[1],input$dateRange_smc2[2], "days")
    fe <- fe[order(fe,decreasing = TRUE)]
    fe1 <- rep(0,length(fe))
    
    
    for(i in 1:length(fe)){
      if(length(which(as.character(fe[i])==data[,1]))!=0){
        fe1[i] <- 1
      }
    }
    
    #veo que fechas si estan
    a <- which(fe1==1)
    
    #creo vector de fechas que si salen
    fe2 <- fe[a]
    
    return(fe2)
  })
  
  #FUNCION AUXILIAR QUE CALCULAR VAR PAR PARA UNA FECHA DADA
  #QUE VARIA SEGUN FECHAS SELECCIONADAS
  var_smc2 <- reactive({
    #LEO FECHAS A CALCULAR
    #if(is.null(fecha_par())){return()}
    fe <- fecha_smc2()
    
    #CREO ESTRUCTURA PARA GUARDAR LOS VARES
    var <- cbind.data.frame(fe,rep(0,length(fe)))
    names(var) <- c("Fechas","VaRes")
    
    
    #CREO FOR PARA CALCULAR TODOS LOS VARES PEDIDOS
    #ES POSIBLE QUE SE DEMORE UN TIEMPO
    for(j in 1:length(fe)){
      # 
      #j <- 1
      # #ACTUALIZO DATA CON LA QUE TRABAJARE
      data0 <- data_var()
      
      # #SELECCIONO 252 OBS SEGUN FECHA SELECCIONADA
      data <- data0[which(fe[j]==data0[,1]):(251+which(fe[j]==data0[,1])),]
      
      #--#
      #calculo sd
      if(is.null(data)){return()}
      rend <- as.data.frame(matrix(0,nrow = (nrow(data)-1),ncol = (ncol(data)-1)))
      names(rend) <- names(data)[-1]
      
      for(i in 1:(ncol(data)-1)){
        rend[,i] <- diff(log(data[,i+1]))
      }
      
      #veo si hay valores NA o inf en la data
      a <- rep(0,ncol(rend))
      
      for(i in 1:ncol(rend)){
        if(anyNA(rend[,i])|sum(is.infinite(rend[,i]))>=1){
          a[i] <- 1
        }
      }
      
      #leo posiciones
      p <- data_pos()
      #p$pesos <- p[,2]/sum(p[,2])
      
      #leo distribuciones
      if(input$seleccion_dist==0){
        dist <- distribuciones()
      }else if(input$seleccion_dist==1){
        #dist <- read.csv(paste(getwd(),"data","distribuciones2.txt",sep = "/"),sep="")
        dist <- read.csv(paste(getwd(),"data","distribuciones3.txt",sep = "/"),sep="")
        }
      
      #cuando hay problemas con rend
      #titulos donde hay problema
      b <- which(a==1)
      if(sum(a)>=1){
        rend <- rend[,-b]
        
        #actualizo posiciones
        p <- p[-b,]
        #p[,3] <- p[,2]/sum(p[,2])
        
        #actualizo distribuciones
        dist <- dist[,-b]
        
        #creo matriz donde guardare simulaciones de cada instrumento
        #mat <- as.data.frame(matrix(0,nrow = input$sim_varmc_el,ncol = (ncol(rend)+2)))
        #names(mat) <- c(names(rend),"incremento","escenario")
        mat <- (matrix(0,nrow = input$sim_varmc_el,ncol = (ncol(rend))))
        names(mat) <- c(names(rend))
         
         
        #relleno matriz de simulaciones
        withProgress(message = 'Calculando números aleatorios', value = 0, {
          incProgress(1/3, detail = "Realizando iteraciones")
          for(i in 1:ncol(rend)){
            #mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
            if(as.character(dist[,i])=="Normal"){
              #n_rand <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
              #calculo momentos
              a1 <- lmom.ub(rend[,i])
              #convierto valor anterior en parametros
              b1 <- lmom2par(a1,type="nor") #normal
              #realizo simulacion
              mat[,i] <- rlmomco(input$sim_varmc_el,b1)
            }else if(as.character(dist[,i])=="Exponential"){
              #n_rand <- rexp(n = input$sim_varmc_n,rate = as.numeric(fitdistr(rend[,i],"exponential")$estimate))
              #calculo momentos
              a1 <- lmom.ub(rend[,i])
              #convierto valor anterior en parametros
              b1 <- lmom2par(a1,type="exp") #normal
              #realizo simulacion
              mat[,i] <- rlmomco(input$sim_varmc_el,b1)
            }else if(as.character(dist[,i])=="Cauchy"){
              #n_rand <- rcauchy(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[2])
              #calculo momentos
              a1 <- lmom.ub(rend[,i])
              #convierto valor anterior en parametros
              b1 <- lmom2par(a1,type="cau") #normal
              #realizo simulacion
              mat[,i] <- rlmomco(input$sim_varmc_el,b1)
            }else if(as.character(dist[,i])=="Logistic"){
              #n_rand <- rlogis(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"logistic")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"logistic")$estimate)[2])
              #calculo momentos
              a1 <- lmom.ub(rend[,i])
              #convierto valor anterior en parametros
              b1 <- lmom2par(a1,type="glo") #normal
              #realizo simulacion
              mat[,i] <- rlmomco(input$sim_varmc_el,b1)
            }else if(as.character(dist[,i])=="Beta"){
              #
            }else if(as.character(dist[,i])=="Chi-square"){
              #
            }else if(as.character(dist[,i])=="Uniform"){
              #
            }else if(as.character(dist[,i])=="Gamma"){
              #n_rand <- rgamma(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[1],rate = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[2])
              #calculo momentos
              a1 <- lmom.ub(rend[,i])
              #convierto valor anterior en parametros
              b1 <- lmom2par(a1,type="gam") #normal
              #realizo simulacion
              mat[,i] <- rlmomco(input$sim_varmc_el,b1)
            }else if(as.character(dist[,i])=="Lognormal"){
              mat[,i] <- rlnorm(n = input$sim_varmc_el,meanlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[1],sdlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[2])
            }else if(as.character(dist[,i])=="Weibull"){
              #n_rand <- rweibull(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[1],scale = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[2])
              #calculo momentos
              a1 <- lmom.ub(rend[,i])
              #convierto valor anterior en parametros
              b1 <- lmom2par(a1,type="wei") #normal
              #realizo simulacion
              mat[,i] <- rlmomco(input$sim_varmc_el,b1)
            }else if(as.character(dist[,i])=="F"){
              #
            }else if(as.character(dist[,i])=="Student"){
              #
              #calculo momentos
              a1 <- lmom.ub(rend[,i])
              #convierto valor anterior en parametros
              b1 <- lmom2par(a1,type="st3") #normal
              #realizo simulacion
              mat[,i] <- rlmomco(input$sim_varmc_el,b1)
            }else if(as.character(dist[,i])=="Gompertz"){
              #
            }else{
              mat[,i] <- rep(0,input$sim_varmc_el)
            }


          }
        })

        #CALCULO MATRIZ DE CHOLESKY
        cholesky <- t(chol(cor(rend,use="complete.obs")))

        #5) REALIZO PRODUCTO DE MATRIZ DE N ALEATORIOS*MAT CHOLESKY
        mrs <- mat%*%t(cholesky)

        #6) calculo "incremento de precio"
        mrs1 <- mrs%*%p[,2]

        #7) calculo "precio" (siempre positivo)
        mrs2 <- sum(p[,2])+mrs1


        #10) CALCULO CUANTIL, QUE ES EL VAR
        #quantile(gop2,  probs = c(0.05),type = 1)
        #ordeno columna "escenarios"
        mat1 <- mrs2[order(mrs2)]

        #calculo valor de corte y VaR Monte Carlo
         #vc <- (mat1[length(mat1)*5/100])
         vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_el)))])
         var_sm <- sum(p[,2])-vc
         
        var[j,2] <- var_sm
  
        #return(as.data.frame(var_sm))
        
      }else{#final if
      
      #creo matriz donde guardare simulaciones de cada instrumento
      #mat <- as.data.frame(matrix(0,nrow = input$sim_varmc_el,ncol = (ncol(rend)+2)))
      #names(mat) <- c(names(rend),"incremento","escenario")
      mat <- (matrix(0,nrow = input$sim_varmc_el,ncol = (ncol(rend))))
      names(mat) <- c(names(rend))
      
      
      #relleno matriz de simulaciones
      withProgress(message = 'Calculando números aleatorios', value = 0, {
        incProgress(1/3, detail = "Realizando iteraciones")
        for(i in 1:ncol(rend)){
          #mat[,i] <-  rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
          if(as.character(dist[,i])=="Normal"){
            #n_rand <- rnorm(n = input$sim_varmc_n,mean = as.numeric(fitdistr(rend[,i],"normal")$estimate)[1],sd = as.numeric(fitdistr(rend[,i],"normal")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="nor") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1) 
          }else if(as.character(dist[,i])=="Exponential"){
            #n_rand <- rexp(n = input$sim_varmc_n,rate = as.numeric(fitdistr(rend[,i],"exponential")$estimate))
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="exp") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Cauchy"){
            #n_rand <- rcauchy(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"cauchy")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="cau") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Logistic"){
            #n_rand <- rlogis(n = input$sim_varmc_n,location = as.numeric(fitdistr(rend[,i],"logistic")$estimate)[1],scale =as.numeric(fitdistr(rend[,i],"logistic")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="glo") #normal
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Beta"){
            #
          }else if(as.character(dist[,i])=="Chi-square"){
            #
          }else if(as.character(dist[,i])=="Uniform"){
            #
          }else if(as.character(dist[,i])=="Gamma"){
            #n_rand <- rgamma(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[1],rate = as.numeric(fitdistr(rend[,i],"Gamma")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="gam") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Lognormal"){
            mat[,i] <- rlnorm(n = input$sim_varmc_el,meanlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[1],sdlog = as.numeric(fitdistr(rend[,i],"Lognormal")$estimate)[2])
          }else if(as.character(dist[,i])=="Weibull"){
            #n_rand <- rweibull(n = input$sim_varmc_n,shape = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[1],scale = as.numeric(fitdistr(rend[,i],"Weibull")$estimate)[2])
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="wei") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="F"){
            #
          }else if(as.character(dist[,i])=="Student"){
            #
            #calculo momentos
            a1 <- lmom.ub(rend[,i])
            #convierto valor anterior en parametros
            b1 <- lmom2par(a1,type="st3") #normal   
            #realizo simulacion
            mat[,i] <- rlmomco(input$sim_varmc_el,b1)
          }else if(as.character(dist[,i])=="Gompertz"){
            #
          }else{
            mat[,i] <- rep(0,input$sim_varmc_el)
          }
          
          
        }
      })
      
      #CALCULO MATRIZ DE CHOLESKY
      cholesky <- t(chol(cor(rend,use="complete.obs")))
      
      #5) REALIZO PRODUCTO DE MATRIZ DE N ALEATORIOS*MAT CHOLESKY
      mrs <- mat%*%t(cholesky)
      
      #6) calculo "incremento de precio"
      mrs1 <- mrs%*%p[,2]
      
      #7) calculo "precio" (siempre positivo)
      mrs2 <- sum(p[,2])+mrs1
      
      
      #10) CALCULO CUANTIL, QUE ES EL VAR
      #quantile(gop2,  probs = c(0.05),type = 1)
      #ordeno columna "escenarios"
      mat1 <- mrs2[order(mrs2)]
      
      #calculo valor de corte y VaR Monte Carlo
      #vc <- (mat1[length(mat1)*5/100])
      vc <- (mat1[length(mat1)*(1-as.numeric(sub(",",".",input$porVarmc_el)))])
      var_sm <- sum(p[,2])-vc
      
      var[j,2] <- var_sm
      
      }
      
      
    }#final for Vares
    
    return(var)
    
  })
  
  #GENERO OUTPUT
  output$historico_smc2 <- renderDataTable({
    a <- try(var_smc2())
    
    if(class(a)!="try-error"){
    write.table(a,paste(getwd(),"data","Historico_var_smcmd.txt",sep = "/"),row.names = FALSE)
    a
    }else{}
  })
  
  #DESCARGO DATA
  output$data_var_smc2 <- downloadHandler(
    filename = function() {
      paste("Var_smc_md", ".txt", sep = "")
    },
    content = function(file) {
      write.table(var_smc2(), file, row.names = FALSE)
    }
  )
  
  ###############################################################################
  ###############################################################################
  #################################    BACKTESTING    ###########################
  ###############################################################################
  ###############################################################################
  
  
  data_back <- reactive({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file_data_back
    
    if (is.null(inFile))
      return(NULL)
    
    # read.table(inFile$datapath, header = input$header,
    #            sep = input$sep, quote = input$quote)
    a <- read.delim2(inFile$datapath, header = input$header_back,
                     sep = input$sep_back, quote = input$quote_back)
    
    return(a)
    
  })
  
  
  output$datatable_back<-renderDataTable({
    if(is.null(data_back())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    datatable(data_back())
  })
  
  #PORCENTAJE DEL VAR
  output$back_porcentaje <- renderPrint({as.numeric(sub(",",".",input$porback))})
  
  
  #funcion auxiliar Backtesting
  source(paste(getwd(),"Scripts auxiliares","kup1.R",sep = "/"))
  
  #muestro resultado Backtesting
  output$result_back <- renderPrint({
    data <- data_back()
    
    if(length(data[,1])!=0){
    
    #convierto a fecha
    data[,1] <- as.Date(as.character(data[,1]),format="%d/%m/%Y")
    #convierto en numero
    data[,2] <- as.numeric(as.character(data[,2]))
    data[,3] <- as.numeric(as.character(data[,3]))
    
    #diseño data frame para usarlo en kup1
    #numero de observaciones
    data$obs <- seq(1,nrow(data))
    
    #VaR -
    data$var_menos <- rep(0,nrow(data))
    for(i in 1:(nrow(data)-1)){
    data$var_menos[i] <- data[i+1,3]-data[i+1,2]
    }
    
    
    #VaR +
    data$var_mas <- rep(0,nrow(data))
    for(i in 1:(nrow(data)-1)){
      data$var_mas[i] <- data[i+1,3]+data[i+1,2]
    }
    
    #ordeno data
    data <- data[,c(4,1,2,5,3,6)]
    #names(data) <- c("obs","fecha","var","var_menos","posicion","var_mas")
    names(data) <- c("V1","V2","V3","V4","V5","V6")
    
    
    #uso funcion kup1
    #a <- kup1(data,0.05)
    a <- kup1(data,(1-as.numeric(sub(",",".",input$porback))))
    #return(a)
    }else{}
  })
  
  #GRAFICO BACKTESTING
  output$grafico_back <- renderPlotly({
    if(is.null(data_back())){return()}
    data <- data_back()
    
    if(length(data[,1])!=0){
      
      #convierto a fecha
      data[,1] <- as.Date(as.character(data[,1]),format="%d/%m/%Y")
      #convierto en numero
      data[,2] <- as.numeric(as.character(data[,2]))
      data[,3] <- as.numeric(as.character(data[,3]))
      
      #diseño data frame para usarlo en kup1
      #numero de observaciones
      data$obs <- seq(1,nrow(data))
      
      #VaR -
      data$var_menos <- rep(0,nrow(data))
      for(i in 1:(nrow(data)-1)){
        data$var_menos[i] <- data[i+1,3]-data[i+1,2]
      }
      
      
      #VaR +
      data$var_mas <- rep(0,nrow(data))
      for(i in 1:(nrow(data)-1)){
        data$var_mas[i] <- data[i+1,3]+data[i+1,2]
      }
      
      #ordeno data
      data <- data[,c(4,1,2,5,3,6)]
      #names(data) <- c("obs","fecha","var","var_menos","posicion","var_mas")
      names(data) <- c("V1","V2","V3","V4","V5","V6")
      
      
      #uso funcion kup1
      #a <- kup1(data,0.05)
      a <- kup1(data,(1-as.numeric(sub(",",".",input$porback))))
      #return(a)
    }else{}
    
    par <- a[[2]]
    #df2 <- data.frame(supp=rep(c("VC", "OJ"), each=3),
    #                                     dose=rep(c("D0.5", "D1", "D2"),2),
    #                                     len=c(6.8, 15, 33, 4.2, 10, 29.5))
    df2 <- data.frame(Valores=rep(c("Estadísticos", "Valores críticos"), each=3),
                                         Test=rep(c("Test Kupiec", "Test de Haas", "Test mixto"),2),
                                         Valor=c(as.numeric(par[1,]),as.numeric(par[2,])))
    
    p <- ggplot(data=df2, aes(x=Test, y=Valor, fill=Valores)) +
           geom_bar(stat="identity")+scale_fill_brewer(palette="Paired")
    
    p
  })
  
  #funcion auxiliar para reporte
  back <- reactive({
    data <- data_back()
    
    if(length(data[,1])!=0){
      
      #convierto a fecha
      data[,1] <- as.Date(as.character(data[,1]),format="%d/%m/%Y")
      #convierto en numero
      data[,2] <- as.numeric(as.character(data[,2]))
      data[,3] <- as.numeric(as.character(data[,3]))
      
      #diseño data frame para usarlo en kup1
      #numero de observaciones
      data$obs <- seq(1,nrow(data))
      
      #VaR -
      data$var_menos <- rep(0,nrow(data))
      for(i in 1:(nrow(data)-1)){
        data$var_menos[i] <- data[i+1,3]-data[i+1,2]
      }
      
      
      #VaR +
      data$var_mas <- rep(0,nrow(data))
      for(i in 1:(nrow(data)-1)){
        data$var_mas[i] <- data[i+1,3]+data[i+1,2]
      }
      
      #ordeno data
      data <- data[,c(4,1,2,5,3,6)]
      #names(data) <- c("obs","fecha","var","var_menos","posicion","var_mas")
      names(data) <- c("V1","V2","V3","V4","V5","V6")
      
      
      #uso funcion kup1
      #kup1(data,0.05)
      kup1(data,(1-as.numeric(sub(",",".",input$porback))))
      
    }else{}
  
  })
  ###############################################################################
  ###############################################################################
  #################################    BACKTESTING    ###########################
  ###############################################################################
  ###############################################################################
  
  
  data_back <- reactive({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file_data_back
    
    if (is.null(inFile))
      return(NULL)
    
    # read.table(inFile$datapath, header = input$header,
    #            sep = input$sep, quote = input$quote)
    a <- read.delim2(inFile$datapath, header = input$header_back,
                     sep = input$sep_back, quote = input$quote_back)
    
    return(a)
    
  })
  
  
  output$datatable_back<-renderDataTable({
    if(is.null(data_back())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    datatable(data_back())
  })
  
  # REPORTE BACKTESTING 
  
  output$report_back <- downloadHandler(
    filename = "reporte_back.pdf",
    content = function(file) {
      tempReport <- file.path(tempdir(), "reporte_back.Rmd")
      #tempReport <- file.path(getwd(), "reporte1.Rmd")
      
      file.copy("reporte_back.Rmd", tempReport, overwrite = TRUE)
      
      # Configuración de parámetros pasados a documento Rmd
      params <- list(resultados = back()
                     
                     
                     # data2 = data()$corriente,
                     # data3 = data()$corriente.rem,
                     # dist1 = input$distVarA,
                     # dist2 = input$distVarC,
                     # dist3 = input$distVarCR,
                     # pconf = input$porVar,
                     # reali = input$reali,
                     # revi = input$revi
      )
      
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempReport, output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
      )
    })
  
  
  ###############################################################################
  ###############################################################################
  #################################    VALORACION    ############################
  ###############################################################################
  ###############################################################################
  
  
  data_val <- reactive({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file_data_val
    
    if (is.null(inFile))
      return(NULL)
    
    # read.table(inFile$datapath, header = input$header,
    #            sep = input$sep, quote = input$quote)
    a <- read.delim2(inFile$datapath, header = input$header_val,
                     sep = input$sep_val, quote = input$quote_val)
    
    return(a)
    
  })
  
  
  output$datatable_val<-renderDataTable({
    if(is.null(data_val())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    datatable(data_val())
  })
  
  #DATA PRECIOS PARA VALORACION ESTRESADA
  data_val_estres <- reactive({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file_data_val_estres
    
    if (is.null(inFile))
      return(NULL)
    
    # read.table(inFile$datapath, header = input$header,
    #            sep = input$sep, quote = input$quote)
    a <- read.delim2(inFile$datapath, header = input$header_val_estres,
                     sep = input$sep_val_estres, quote = input$quote_val_estres)
    
    return(a)
    
  })
  
  
  output$datatable_val_estres<-renderDataTable({
    if(is.null(data_val_estres())){return()}
    #datatable(data()) %>% formatCurrency(1:3, 'Bs. ', mark = '.', dec.mark = ',')
    datatable(data_val_estres())
  })
  
  #advertencia
  output$datatable_val_estres_ad <- renderPrint({
    if(is.null(data_val()) | is.null(data_val_estres()) ){return()}
    #cargo historico
    a <- data_val_estres()
    #data val
    b <- data_val()
    
    d <- names(a)[-1]==as.character(b[,1])
    
    if(sum(d)==nrow(b)){
      print("Coincidencia en instrumentos")
    }else{
      print("No existe coincidencia en instrumentos")
    }
    
    
  })
  
  #resultados valoracion
  output$result_val <- renderDataTable({
    if(is.null(data_val())){return()}
    a <- data_val()
    #convierto en numero diferentes columnas
    #valor nominal
    a[,3] <- as.numeric(as.character(a[,3]))
    #precio hoy
    a[,4] <- as.numeric(as.character(a[,4]))
    #precio mercado
    a[,5] <- as.numeric(as.character(a[,5]))
    #calculo mtm
    a$mtm <- a[,3]*a[,5]/100
    #calculo utilidad o perdida
    a$ut_per <- a$mtm*((a[,5]-a[,4])/100)
    
    datatable(a, options = list(paging = FALSE))
  })
  
  #GRAFICO
  output$grafico_val1 <- renderPlotly({
    if(is.null(data_val())){return()}
    a <- data_val()
    #convierto en numero diferentes columnas
    #valor nominal
    a[,3] <- as.numeric(as.character(a[,3]))
    #precio hoy
    a[,4] <- as.numeric(as.character(a[,4]))
    #precio mercado
    a[,5] <- as.numeric(as.character(a[,5]))
    #calculo mtm
    a$mtm <- a[,3]*a[,5]/100
    #calculo utilidad o perdida
    a$ut_per <- a$mtm*((a[,5]-a[,4])/100)
    
    #grafico
    b <- cbind.data.frame(as.character(a[,1]),a$ut_per)
    names(b) <- c("titulo","ut_per")
    
    
    p <- ggplot(b, aes(reorder(titulo,ut_per), ut_per, fill = titulo)) +
      geom_bar(position="stack", stat="identity",show.legend = FALSE) + coord_flip() +
      labs(x = "Títulos",y = "Utilidad o pérdida")+
      theme(axis.text.y=element_text(angle=0, hjust=1,size = 6))
    
    #plot_ly(p)
    p
  })
  
  #resultados portafolio
  output$result_val_port <- renderDataTable({
    if(is.null(data_val())){return()}
    a <- data_val()
    #valor nominal
    a[,3] <- as.numeric(as.character(a[,3]))
    #precio hoy
    a[,4] <- as.numeric(as.character(a[,4]))
    #precio mercado
    a[,5] <- as.numeric(as.character(a[,5]))
    #calculo mtm
    a$mtm <- a[,3]*a[,5]/100
    #calculo utilidad o perdida
    a$ut_per <- a$mtm*((a[,5]-a[,4])/100)
    
    #resumen
    #determino cuantos tipos de instrumentos hay
    #a$tit <- substr(a[,1],1,3)
    #a$tit <- as.factor(a$tit)
    a[,2] <- as.factor(a[,2])
    
    #cant <- length(levels(a$tit))
    cant <- length(levels(a[,2]))
    le <- as.character(levels(a[,2]))
    
    b <- as.data.frame(matrix(0,nrow = cant,ncol = 3))
    names(b) <- c("Valor Nominal","Promedio Precio Mercado","UTD/PER")
    #extraigo tipos de titulos
    #supongo que solo hay un solo tipo de instrumento
    #d <- substr(as.character(a[1,1]),1,3)
    row.names(b) <- as.character(levels(a[,2]))
    
    #length(levels(data_valoracion_1$tit))
    for(i in 1:cant){
    #suma valor nominal
    b[i,1] <- sum(a[which(le[i]==a[,2]),3])
    #precio promedio ponderado
    b[i,2] <- sum((a[which(le[i]==a[,2]),3])*(a[which(le[i]==a[,2]),5]))/sum(a[which(le[i]==a[,2]),3])
    #utilidad o perdida
    b[i,3] <- sum(a$ut_per[which(le[i]==a[,2])])
    }
    #
    b1 <- rbind.data.frame(b,c(sum(b[,1]),(sum(b[,1]*b[,2])/sum(b[,1])),sum(b[,3])))
    row.names(b1)[nrow(b1)] <- "TOTALES" 
    b1
    #return(a)
  })
  
  #resultados valoracion estresada
  output$result_val_estres <- renderDataTable({
    if(is.null(data_val()) | is.null(data_val_estres()) ){return()}
    a <- data_val()
    a[,3] <- as.numeric(as.character(a[,3]))
    #a[,5] <- as.numeric(as.character(a[,5]))
    a[,4] <- as.numeric(as.character(a[,4]))
    a[,5] <- as.numeric(as.character(a[,5]))
    
    #calculo desviacion estandar de historico de tit
    #data <- read.delim2(paste(getwd(),"data","tif.txt",sep = "/"))
    data <- data_val_estres()
    a$sd <-rep(0,nrow(a))
    
    for(i in 1:nrow(a)){
      #a$sd[i] <- sd(data[,i+1],na.rm = TRUE)
      a$sd[i] <- sd(as.numeric(sub(",",".",as.character(data[((nrow(data)-40):nrow(data)),i+1]))),na.rm = TRUE)
      #a$sd[i] <- as.numeric(sub(",",".",as.character(data[nrow(data),i+1])))
    }
    
    a$precio_estres <- a[,5]-a$sd
    a$mtm <- a[,3]*a$precio_estres/100
    #a$ut_per <- a$mtm-(a[,3]*a$precio_estres/100)
    a$ut_per1 <- a$mtm*((a[,5]-a[,4])/100)
    a$ut_per2 <- a$mtm*((a$precio_estres-a[,5])/100)
    datatable(a, options = list(paging = FALSE))
  })
  
  #grafico estres
  output$grafico_val2 <- renderPlotly({
    if(is.null(data_val()) | is.null(data_val_estres()) ){return()}
    a <- data_val()
    a[,3] <- as.numeric(as.character(a[,3]))
    #a[,5] <- as.numeric(as.character(a[,5]))
    a[,4] <- as.numeric(as.character(a[,4]))
    a[,5] <- as.numeric(as.character(a[,5]))
    
    #calculo desviacion estandar de historico de tit
    #data <- read.delim2(paste(getwd(),"data","tif.txt",sep = "/"))
    data <- data_val_estres()
    a$sd <-rep(0,nrow(a))
    
    for(i in 1:nrow(a)){
      #a$sd[i] <- sd(data[,i+1],na.rm = TRUE)
      a$sd[i] <- sd(as.numeric(sub(",",".",as.character(data[((nrow(data)-40):nrow(data)),i+1]))),na.rm = TRUE)
      #a$sd[i] <- as.numeric(sub(",",".",as.character(data[nrow(data),i+1])))
    }
    
    a$precio_estres <- a[,5]-a$sd
    a$mtm <- a[,3]*a$precio_estres/100
    #a$ut_per <- a$mtm-(a[,3]*a$precio_estres/100)
    a$ut_per1 <- a$mtm*((a[,5]-a[,4])/100)
    a$ut_per2 <- a$mtm*((a$precio_estres-a[,5])/100)
    
    #grafico
    b <- cbind.data.frame(as.character(a[,1]),a$ut_per2)
    names(b) <- c("titulo","ut_per")
    
    
    p <- ggplot(b, aes(reorder(titulo,ut_per), ut_per, fill = titulo)) +
      geom_bar(position="stack", stat="identity",show.legend = FALSE) + coord_flip() +
      labs(x = "Títulos",y = "Utilidad o pérdida")+
      theme(axis.text.y=element_text(angle=0, hjust=1,size = 6))
    
    #plot_ly(p)
    p
  })
  
  
  
  #resultados prueba estres portafolio
  output$result_val_estres_port <- renderDataTable({
    if(is.null(data_val()) | is.null(data_val_estres()) ){return()}
    a <- data_val()
    a[,3] <- as.numeric(as.character(a[,3]))
    #a[,5] <- as.numeric(as.character(a[,5]))
    a[,4] <- as.numeric(as.character(a[,4]))
    a[,5] <- as.numeric(as.character(a[,5]))
    
    #calculo desviacion estandar de historico de tit
    #data <- read.delim2(paste(getwd(),"data","tif.txt",sep = "/"))
    data <- data_val_estres()
    a$sd <-rep(0,nrow(a))
    
    for(i in 1:nrow(a)){
      #a$sd[i] <- sd(data[,i+1],na.rm = TRUE)
      a$sd[i] <- sd(as.numeric(sub(",",".",as.character(data[((nrow(data)-40):nrow(data)),i+1]))),na.rm = TRUE)
      
    }
    
    a$precio_estres <- a[,5]-a$sd
    a$mtm <- a[,3]*a$precio_estres/100
    #a$ut_per <- a$mtm-(a[,3]*a$precio_estres/100)
    a$ut_per1 <- a$mtm*((a[,5]-a[,4])/100)
    a$ut_per2 <- a$mtm*((a$precio_estres-a[,5])/100)
    a
    
    #a partir de aqui hacer resumen
    #determino cuantos tipos de instrumentos hay
    #a$tit <- substr(a[,1],1,3)
    #a$tit <- as.factor(a$tit)
    a[,2] <- as.factor(a[,2])
    
    #cant <- length(levels(a$tit))
    cant <- length(levels(a[,2]))
    le <- as.character(levels(a[,2]))
    
    b <- as.data.frame(matrix(0,nrow = cant,ncol = 4))
    names(b) <- c("Valor Nominal","Promedio Precio Mercado","UTD/PER","UTD/PER-ESTRÉS")
    #extraigo tipos de titulos
    #supongo que solo hay un solo tipo de instrumento
    #d <- substr(as.character(a[1,1]),1,3)
    row.names(b) <- as.character(levels(a[,2]))
    
    #length(levels(data_valoracion_1$tit))
    for(i in 1:cant){
      #suma valor nominal
      b[i,1] <- sum(a[which(le[i]==a[,2]),3])
      #precio promedio ponderado
      b[i,2] <- sum((a[which(le[i]==a[,2]),3])*(a[which(le[i]==a[,2]),5]))/sum(a[which(le[i]==a[,2]),3])
      #utilidad o perdida
      b[i,3] <- sum(a$ut_per1[which(le[i]==a[,2])])
      #utilidad o perdida estres
      b[i,4] <- sum(a$ut_per2[which(le[i]==a[,2])])

    }
    #
    b1 <- rbind.data.frame(b,c(sum(b[,1]),(sum(b[,1]*b[,2])/sum(b[,1])),sum(b[,3]),sum(b[,4])))
    row.names(b1)[nrow(b1)] <- "TOTALES" 
    b1
  })
  
  #VARIABLES AUXILIAR
  #resultados valoracion
  val1 <- reactive({
    if(is.null(data_val())){return()}
    a <- data_val()
    #convierto en numero diferentes columnas
    #valor nominal
    a[,3] <- as.numeric(as.character(a[,3]))
    #precio hoy
    a[,4] <- as.numeric(as.character(a[,4]))
    #precio mercado
    a[,5] <- as.numeric(as.character(a[,5]))
    #calculo mtm
    a$mtm <- a[,3]*a[,5]/100
    #calculo utilidad o perdida
    a$ut_per <- a$mtm*((a[,5]-a[,4])/100)
    a
  })
  
  #
  val2 <- reactive({
    if(is.null(data_val())){return()}
    a <- data_val()
    #valor nominal
    a[,3] <- as.numeric(as.character(a[,3]))
    #precio hoy
    a[,4] <- as.numeric(as.character(a[,4]))
    #precio mercado
    a[,5] <- as.numeric(as.character(a[,5]))
    #calculo mtm
    a$mtm <- a[,3]*a[,5]/100
    #calculo utilidad o perdida
    a$ut_per <- a$mtm*((a[,5]-a[,4])/100)
    
    #resumen
    #determino cuantos tipos de instrumentos hay
    #a$tit <- substr(a[,1],1,3)
    #a$tit <- as.factor(a$tit)
    a[,2] <- as.factor(a[,2])
    
    #cant <- length(levels(a$tit))
    cant <- length(levels(a[,2]))
    le <- as.character(levels(a[,2]))
    
    b <- as.data.frame(matrix(0,nrow = cant,ncol = 3))
    names(b) <- c("Valor Nominal","Promedio Precio Mercado","UTD/PER")
    #extraigo tipos de titulos
    #supongo que solo hay un solo tipo de instrumento
    #d <- substr(as.character(a[1,1]),1,3)
    row.names(b) <- as.character(levels(a[,2]))
    
    #length(levels(data_valoracion_1$tit))
    for(i in 1:cant){
      #suma valor nominal
      b[i,1] <- sum(a[which(le[i]==a[,2]),3])
      #precio promedio ponderado
      b[i,2] <- sum((a[which(le[i]==a[,2]),3])*(a[which(le[i]==a[,2]),5]))/sum(a[which(le[i]==a[,2]),3])
      #utilidad o perdida
      b[i,3] <- sum(a$ut_per[which(le[i]==a[,2])])
    }
    #
    b1 <- rbind.data.frame(b,c(sum(b[,1]),(sum(b[,1]*b[,2])/sum(b[,1])),sum(b[,3])))
    row.names(b1)[nrow(b1)] <- "TOTALES" 
    b1
    
  })
  
  # REPORTE VALORACION 1
  output$report_val1 <- downloadHandler(
    filename = "reporte_val1.pdf",
    content = function(file) {
      tempReport <- file.path(tempdir(), "reporte_val1.Rmd")
      #tempReport <- file.path(getwd(), "reporte1.Rmd")
      
      file.copy("reporte_val1.Rmd", tempReport, overwrite = TRUE)
      
      # Configuración de parámetros pasados a documento Rmd
      params <- list(valind = val1(),valpor = val2()
                     
                     
                     # data2 = data()$corriente,
                     # data3 = data()$corriente.rem,
                     # dist1 = input$distVarA,
                     # dist2 = input$distVarC,
                     # dist3 = input$distVarCR,
                     # pconf = input$porVar,
                     # reali = input$reali,
                     # revi = input$revi
      )
      
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempReport, output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
      )
    })
  
  #VARIABLES AUXILIARES VALORACION ESTRES
  val1_e <- reactive({
    if(is.null(data_val()) | is.null(data_val_estres()) ){return()}
    a <- data_val()
    a[,3] <- as.numeric(as.character(a[,3]))
    #a[,5] <- as.numeric(as.character(a[,5]))
    a[,4] <- as.numeric(as.character(a[,4]))
    a[,5] <- as.numeric(as.character(a[,5]))
    
    #calculo desviacion estandar de historico de tit
    #data <- read.delim2(paste(getwd(),"data","tif.txt",sep = "/"))
    data <- data_val_estres()
    a$sd <-rep(0,nrow(a))
    
    for(i in 1:nrow(a)){
      #a$sd[i] <- sd(data[,i+1],na.rm = TRUE)
      a$sd[i] <- sd(as.numeric(sub(",",".",as.character(data[((nrow(data)-40):nrow(data)),i+1]))),na.rm = TRUE)
      
    }
    
    a$precio_estres <- a[,5]-a$sd
    a$mtm <- a[,3]*a$precio_estres/100
    #a$ut_per <- a$mtm-(a[,3]*a$precio_estres/100)
    a$ut_per1 <- a$mtm*((a[,5]-a[,4])/100)
    a$ut_per2 <- a$mtm*((a$precio_estres-a[,5])/100)
    a
    
  })
  
  #
  val2_e <- reactive({
    if(is.null(data_val()) | is.null(data_val_estres()) ){return()}
    a <- data_val()
    a[,3] <- as.numeric(as.character(a[,3]))
    #a[,5] <- as.numeric(as.character(a[,5]))
    a[,4] <- as.numeric(as.character(a[,4]))
    a[,5] <- as.numeric(as.character(a[,5]))
    
    #calculo desviacion estandar de historico de tit
    #data <- read.delim2(paste(getwd(),"data","tif.txt",sep = "/"))
    data <- data_val_estres()
    a$sd <-rep(0,nrow(a))
    
    for(i in 1:nrow(a)){
      #a$sd[i] <- sd(data[,i+1],na.rm = TRUE)
      a$sd[i] <- sd(as.numeric(sub(",",".",as.character(data[((nrow(data)-40):nrow(data)),i+1]))),na.rm = TRUE)
      
    }
    
    a$precio_estres <- a[,5]-a$sd
    a$mtm <- a[,3]*a$precio_estres/100
    #a$ut_per <- a$mtm-(a[,3]*a$precio_estres/100)
    a$ut_per1 <- a$mtm*((a[,5]-a[,4])/100)
    a$ut_per2 <- a$mtm*((a$precio_estres-a[,5])/100)
    a
    
    #a partir de aqui hacer resumen
    #determino cuantos tipos de instrumentos hay
    #a$tit <- substr(a[,1],1,3)
    #a$tit <- as.factor(a$tit)
    a[,2] <- as.factor(a[,2])
    
    #cant <- length(levels(a$tit))
    cant <- length(levels(a[,2]))
    le <- as.character(levels(a[,2]))
    
    b <- as.data.frame(matrix(0,nrow = cant,ncol = 4))
    names(b) <- c("Valor Nominal","Promedio Precio Mercado","UTD/PER","UTD/PER-ESTRÉS")
    #extraigo tipos de titulos
    #supongo que solo hay un solo tipo de instrumento
    #d <- substr(as.character(a[1,1]),1,3)
    row.names(b) <- as.character(levels(a[,2]))
    
    #length(levels(data_valoracion_1$tit))
    for(i in 1:cant){
      #suma valor nominal
      b[i,1] <- sum(a[which(le[i]==a[,2]),3])
      #precio promedio ponderado
      b[i,2] <- sum((a[which(le[i]==a[,2]),3])*(a[which(le[i]==a[,2]),5]))/sum(a[which(le[i]==a[,2]),3])
      #utilidad o perdida
      b[i,3] <- sum(a$ut_per1[which(le[i]==a[,2])])
      #utilidad o perdida estres
      b[i,4] <- sum(a$ut_per2[which(le[i]==a[,2])])
      
    }
    #
    b1 <- rbind.data.frame(b,c(sum(b[,1]),(sum(b[,1]*b[,2])/sum(b[,1])),sum(b[,3]),sum(b[,4])))
    row.names(b1)[nrow(b1)] <- "TOTALES" 
    b1
    
  })
  
  
  # REPORTE VALORACION 2
  output$report_val2 <- downloadHandler(
    filename = "reporte_val2.pdf",
    content = function(file) {
      tempReport <- file.path(tempdir(), "reporte_val2.Rmd")
      #tempReport <- file.path(getwd(), "reporte1.Rmd")
      
      file.copy("reporte_val2.Rmd", tempReport, overwrite = TRUE)
      
      # Configuración de parámetros pasados a documento Rmd
      params <- list(valinde = val1_e(),valpore = val2_e()
                     
                     
                     # data2 = data()$corriente,
                     # data3 = data()$corriente.rem,
                     # dist1 = input$distVarA,
                     # dist2 = input$distVarC,
                     # dist3 = input$distVarCR,
                     # pconf = input$porVar,
                     # reali = input$reali,
                     # revi = input$revi
      )
      
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempReport, output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
      )
    })
  
  # Almacenar Variables Reactivas
  # RV <- reactiveValues()
  # 
  # set.seed(122)
  # histdata <- rnorm(500)
  # 
  # output$plot1 <- renderPlot({
  #   data <- histdata[seq_len(input$slider)]
  #   hist(data)
  # })
 
})
