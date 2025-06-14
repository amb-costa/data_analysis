-- query para dialecto duckdb
-- este query debiera funcionar con todos los archivos .csv
-- es necesario reemplazar el directorio de la tabla inicial

-- un viaje es valido cuando dura entre 1 y 1439 minutos (24hr)
-- tambien tiene station_id para estaciones de inicio y fin
-- clean LEFT JOIN clean_station AS inicio/fin ON station_id
-- clean : tabla con expansion para fecha - hora + duracion de viaje
-- la fecha se desglosa en dia de la semana, dia del mes, mes
-- se separa la hora del tiempo inicial, se mide la duracion del viaje en minutos
-- clean_station : subquery para tabla con ids de estacion unicos, con nombre y coordenadas

WITH clean_station AS(
SELECT 
  station_id AS clean_id, 
  MAX(station_name) AS clean_name, 
  MAX(station_lat) AS clean_lat, 
  MAX(station_lng) AS clean_lng
FROM (
  SELECT 
    start_station_id AS station_id, 
    start_station_name AS station_name, 
    ROUND(AVG(CAST(start_lat AS FLOAT)),3) AS station_lat, 
    ROUND(AVG(CAST(start_lng AS FLOAT)),3) AS station_lng
  FROM "2024MM_csv_file" 
  WHERE start_station_id IS NOT NULL AND start_station_name IS NOT NULL
  GROUP BY start_station_id, start_station_name
  UNION ALL
  SELECT 
    end_station_id AS station_id, 
    end_station_name AS station_name, 
    ROUND(AVG(CAST(end_lat AS FLOAT)),3) AS station_lat, 
    ROUND(AVG(CAST(end_lng AS FLOAT)),3) AS station_lng
  FROM "2024MM_csv_file"
  WHERE end_station_id IS NOT NULL AND end_station_name IS NOT NULL
  GROUP BY end_station_id, end_station_name)
GROUP BY station_id)
SELECT 
  clean.ride_id, 
  clean.member_casual, 
  clean.rideable_type,
  date_diff('minute',CAST(clean.started_at AS TIMESTAMP),CAST(clean.ended_at AS TIMESTAMP)) AS ride_duration,
  dayname(CAST(clean.started_at AS TIMESTAMP)) AS start_day_week,
  dayofmonth(CAST(clean.started_at AS TIMESTAMP)) AS start_day_month, 
	month(CAST(clean.started_at AS TIMESTAMP)) AS start_month, 
	strftime(CAST(clean.started_at AS TIMESTAMP), '%X') AS start_time, 
  clean.start_station_id, 
  inicio.clean_name AS start_station_name, 
  inicio.clean_lat AS start_lat, 
  inicio.clean_lng AS start_lng, 
  dayname(CAST(clean.ended_at AS TIMESTAMP)) AS end_day_week,
  dayofmonth(CAST(clean.ended_at AS TIMESTAMP)) AS end_day_month, 
	month(CAST(clean.ended_at AS TIMESTAMP)) AS end_month, 
	strftime(CAST(clean.ended_at AS TIMESTAMP), '%X') AS end_time, 
  clean.end_station_id, 
  fin.clean_name AS end_station_name, 
  fin.clean_lat AS end_lat, 
  fin.clean_lng AS end_lng
FROM "2024MM_csv_file" AS clean
LEFT JOIN clean_station AS inicio ON (clean.start_station_id = inicio.clean_id)
LEFT JOIN clean_station AS fin ON (clean.end_station_id = fin.clean_id)
WHERE (date_diff('minute',CAST(clean.started_at AS TIMESTAMP),CAST(clean.ended_at AS TIMESTAMP)) BETWEEN 1 AND 1439) AND clean.start_station_id IS NOT NULL AND clean.end_station_id IS NOT NULL