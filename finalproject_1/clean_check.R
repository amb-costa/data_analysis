
# clean_union_all <- read_csv(" ~/data_analysis/finalproject_1/cleaned_table.csv)
library(rlang)
install.packages("dplyr")

cleaned_table <- setDT(clean_union_all)
testing <- sapply(cleaned_table, anyNA)

# verificando que no hay id's de viaje duplicados
# si los hay, este codigo entrega una lista = 121 duplicados
tested <- table(cleaned_table$ride_id)
notrepeating <- data.table(table(cleaned_table$ride_id))
repeating <- notrepeating[notrepeating$Freq > 1,]
repeated <- cleaned_table[cleaned_table$ride_id %in% notrepeating$Var1[notrepeating$Freq > 1],]

repetidos  <- cleaned_table %<%
  distinct()

ans <- cleaned_table[cleaned_table$ride_id[ride_id$Freq > 1, ]]
head(ans)