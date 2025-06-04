# clean_table.R = dataframe general con valores para filas validas, invalidas y totales
# se puede editar para otros contextos que no sean tablas
# kableExtra <- permite crear tablas, DEBE instalarse primero

library(kableExtra)

mes <- c("Ene", "Feb", "Mar", "Abr", "May", "Jun", 
           "Jul", "Ago", "Sep", "Oct", "Nov", "Dic")
totales <- c(144873, 223164, 301687, 415025, 609493, 710721,
             748962, 755639, 821276, 616281, 335075, 178372)
validos <- c(112242, 183258, 228106, 294803, 437644, 492377,
             538936, 539158, 535011, 447745, 245255, 130336)
invalidos <- c(32631, 39906, 73581, 120222, 171849, 218344,
               210026, 216481, 286265, 168536, 89820, 48036)
datos_tablas <- data.frame(mes, totales, validos, invalidos)

datos_tablas %>%
  kbl(caption = "Número de filas válidas en archivos .csv, referentes a meses del año 2024")%>%
  kable_material()


