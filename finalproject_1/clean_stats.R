# clean_stats: grafico para resumir el proceso de limpieza
# formato grafico de barras apilado: el area dentro de las barras representa la proporcion entre viajes validos e invalidos
# codigo extraido desde https://r-graph-gallery.com/48-grouped-barplot-with-ggplot2.html
# se añade la libreria forcats porque se necesita tratar a los meses como un factor, no vector

library(tidyverse)
library(ggplot2)

# se genera set de datos
meses <- c(rep("Enero",2), rep("Febrero",2), rep("Marzo",2), rep("Abril",2), rep("Mayo",2), rep("Junio",2), 
         rep("Julio",2), rep("Agosto",2), rep("Septiembre",2), rep("Octubre",2), rep("Noviembre",2), rep("Diciembre",2))
fc <- c("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio",
        "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre")
mes_fac <- factor(meses, levels=fc)
condicion <- rep(c("Valido", "Invalido"), 12)
valores <- c(c(112242,32631), c(183258,39906), c(228106, 73581), c(294803, 120222), c(437644, 171849), c(492377, 218344),
           c(538936,210026), c(539158,216481), c(535011,286265), c(447745, 168536), c(245255,89820), c(130336, 48036))
datos <- data.frame(mes,condicion,valores)

# Grouped
ggplot(datos, aes(fill=condicion, y=valores, x=mes_fac)) + 
  geom_bar(position="stack", stat="identity") +
  ggtitle("Total de viajes por mes, año 2024")

