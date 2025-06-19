# clean_check : revisión del proceso de limpieza
# package.install(c(rlang, magrittr, data.table))
# clean_union_all <- read_csv("~/data_analysis/finalproject_1/cleaned_table.csv)
# estrategia <- c(existencia, unicidad, viaje válido)
library(rlang)
library(magrittr)
library(data.table)

pre_tabla <- as.data.table(clean_union_all)

#existencia <- ningún registro es null
# esto confirma que no hay registros NULL 
testing <- lapply(pre_tabla, anyNA)

# unicidad <- la información no está duplicada
# %>% los id de viaje y de estación son únicos
# verificando que no hay id's de viaje duplicados
# si los hay, este codigo entrega una lista = 121 duplicados
id_viajes <- data.frame(table(pre_tabla$ride_id))
viajes_na <- lapply(id_viajes, anyNA)
tabla_repetidos <- pre_tabla[pre_tabla$ride_id %in% id_viajes$Var1[id_viajes$Freq > 1],]

# sin duplicados <- unique se deshace de los id_viajes duplicados
tabla_limpia <- data.table(unique(pre_tabla, by="ride_id"))
id_estaciones_start <- data.table(unique(tabla_limpia, by="start_station_id"))
id_estaciones_end <- data.table(unique(tabla_limpia, by="end_station_id"))
testeo <- id_estaciones_start[id_estaciones_start$start_station_id %in% id_estaciones_end$end_station_id,]
oetset <- id_estaciones_end[id_estaciones_end$end_station_id %in% id_estaciones_start$start_station_id,]

