-- 1
SELECT st1.name_station AS station1,
	   st2.name_station AS station2,
	   s.date_start, s.time_start
FROM schedule s
INNER JOIN route r ON s.id_route = r.id
INNER JOIN station st1 ON r.id_start_station = st1.id
INNER JOIN station st2 ON r.id_finish_station = st2.id
WHERE st1.city = 'Moscow' AND st2.city = 'Kazan' 
      AND s.date_start = '2023-06-07';

-- 2
SELECT time_start FROM schedule s
INNER JOIN train t ON s.id_train = t.id
INNER JOIN route r ON s.id_route = r.id
INNER JOIN station st ON r.id_start_station = st.id
WHERE t.name_train = 'K01' AND st.city = 'Kazan';

-- 3
SELECT t.price FROM ticket t
INNER JOIN schedule s ON t.id_schedule = s.id
INNER JOIN route r ON s.id_route = r.id
INNER JOIN station st1 ON r.id_start_station = st1.id
INNER JOIN station st2 ON r.id_finish_station = st2.id
WHERE st1.city = 'Moscow' AND st2.city = 'Kazan' 
      AND s.date_start = '2023-06-07' AND t.status = 'free';