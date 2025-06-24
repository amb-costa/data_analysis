# clean_check : revisión del proceso de limpieza
# install.packages(c(rlang, magrittr, data.table, purrr))
# clean_union_all <- read_csv("~/data_analysis/finalproject_1/cleaned_table.csv)
# estrategia <- c(existencia, unicidad, viaje válido)

install.packages("operators")
library(rlang)
library(magrittr)
library(data.table)
library(operators)

pre_tabla <- as.data.table(clean_union_all)

# existencia <- ningún registro es null
# esto confirma que no hay registros NULL 
# sapply > lapply para efectos de espacio con prints
# testing_l <- lapply(pre_tabla, anyNA)
testing_s <- sapply(pre_tabla, anyNA)
testing_sfalse <- isTRUE(testing_s)

# schema_tabla <- vector con el datatype esperado para cada campo
# ride_id CHARACTER
# member_casual CHARACTER
# rideable_type CHARACTER
# ride_duration INTEGER
# start_day_week CHARACTER
# start_day_month INTEGER
# start_month INTEGER 
# start_time DATE
# start_station_id CHARACTER
# start_station_name CHARACTER
# start_lat NUMERIC
# start_lng NUMERIC
# end_day_week CHARACTER
# end_day_month INTEGER
# end_month INTEGER 
# end_time DATE
# end_station_id CHARACTER
# end_station_name CHARACTER
# end_lat NUMERIC
# end_lng NUMERIC
# schema_comp <- comparación: las dos tablas NO SON IGUALES
# schema_diff <- datatypes a corregir con CAST
schema_tabla <- data.table(c("character", "character", "character", "integer", 
               "character", "integer","integer", "date", "character", 
               "character", "numeric", "numeric", "character", "integer", 
               "integer", "date", "character", "character", "numeric", "numeric"))
pre_schema <- data.table(sapply(pre_tabla, class))
schema_comp <- identical(schema_tabla,pre_schema)
schema_diff <- schema_tabla[!(schema_tabla$V1 %in% pre_schema$V1)]

# unicidad <- la información no está duplicada %>% id viaje/estación únicos
# id_viajes <- table() añade Freq para ride_id
# tabla_repetidos <- filtro con 121 DUPLICADOS
id_viajes <- data.frame(table(pre_tabla$ride_id))
viajes_na <- lapply(id_viajes, anyNA)
tabla_repetidos <- pre_tabla[pre_tabla$ride_id %in% id_viajes$Var1[id_viajes$Freq > 1],]

# sin duplicados <- unique se deshace de los id_viajes duplicados
tabla_limpia <- data.table(unique(pre_tabla, by="ride_id"))

# unicidad <- las id de estaciones tienen station_id únicos
# lo importante son las id, porque se pueden repetir nombres y coordenadas
# puede que existan dos estaciones de tipos distintos en la misma cuadra
id_estaciones_start <- data.table(unique(tabla_limpia, by="start_station_id"))
id_estaciones_end <- data.table(unique(tabla_limpia, by="end_station_id"))
id_estaciones <- merge (id_estaciones_start, id_estaciones_end, all=TRUE)
start_notin_end<- id_estaciones[id_estaciones$start_station_id %!in% id_estaciones$end_station_id,]
end_notin_start <-  id_estaciones[id_estaciones$end_station_id %!in% id_estaciones$start_station_id,]

id_inicio <- tabla_limpia[,.(id_estacion=start_station_id, nombre_estacion=start_station_name,
                             lat_estacion=start_lat, lng_estacion=start_lng)]
id_fin <- tabla_limpia[,.(id_estacion=end_station_id, nombre_estacion=end_station_name,
                             lat_estacion=end_lat, lng_estacion=end_lng)]
id_estacion1 <- id_inicio[id_inicio$id_estacion %in% id_fin$id_estacion,]
id_estacion2 <- id_fin[id_fin$id_estacion %in% id_inicio$id_estacion,]
id_estaciones <-cbind(id_estacion1, id_estacion2)
inicio_notin_fin <- id_inicio[id_inicio$id_estacion %!in% id_fin$id_estacion,]
fin_notin_inicio <- id_fin[id_fin$id_estacion %!in% id_inicio$id_estacion,]
# cruce de informacion <- todas las id de estaciones tienen los mismos datos en nombre y coord

