# exp_size: total de filas en cada archivo .csv para Preparar
# gráfico de barras con labels para cada valor
# codigo extraido desde https://r-graph-gallery.com/48-grouped-barplot-with-ggplot2.html
# se añade la libreria forcats porque se necesita tratar a los meses como un factor, no vector

library(tidyverse)
library(ggplot2)

# mes <- vector con meses
# fc <- vector con reglas para factor: orden mensual
# totales <- total de filas por mes
meses <- c("Ene", "Feb", "Mar", "Abr", "May", "Jun", 
         "Jul", "Ago", "Sep", "Oct", "Nov", "Dic")
mes_fac <- factor(meses, levels=unique(meses))
totales <- c(144873, 223164,301687,415025,609493,710721,748962,755639,821276,
             616281, 335075,178372)
datos <- data.frame(mes_fac,totales)

# Grouped
ggplot(datos, aes(y=totales, x=mes_fac)) + 
  geom_bar(position="dodge", stat="identity", fill= "aquamarine4") +
  scale_y_continuous(limits = c(0,850000), n.breaks=7) + 
  ggtitle("Total de Viajes Registrados por Mes, año 2024",
          subtitle="Total de filas en cada archivo .csv") +
  xlab("Mes del Año") +
  ylab("Total de Filas") +
  geom_text(label=totales, size=2, vjust = 2, color ="white")+
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust=0.5))

