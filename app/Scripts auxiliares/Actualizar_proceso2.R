#PROCESO PARA ACTUALIZAR HISTORICO 0-22
#USO PAQUETE CRON Y EJECUTO DIARIAMENTE SCRIPT "Actualizar_proceso1.R"
#cargo librería
library(cronR)

#ruta del script a ejecutar
f <- paste(getwd(),'app/Scripts auxiliares/Actualizar_proceso1.R',sep="/")

#asigino script a ejecutar
cmd <- cron_rscript(f)


#cron_add(command = cmd, frequency = '*/15 * * * *',
#         id = 'proceso', description = 'My process 1', at = '11:42')

cron_add(command = cmd, frequency = 'daily',
         id = 'proceso', description = 'My process 1', at = '16:00')

cron_njobs()
cron_ls()


#cron_clear(ask=FALSE)
#cron_ls()

