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
# testing <- lapply(pre_tabla, anyNA)

# unicidad <- la información no está duplicada
# %>% los id de viaje y de estación son únicos
# verificando que no hay id's de viaje duplicados
# si los hay, este codigo entrega una lista = 121 duplicados
# id_viajes <- data.frame(table(pre_tabla$ride_id))
# viajes_na <- lapply(id_viajes, anyNA)
# tabla_repetidos <- pre_tabla[pre_tabla$ride_id %in% id_viajes$Var1[id_viajes$Freq > 1],]

tabla_limpia <- unique(pre_tabla, by="ride_id")

