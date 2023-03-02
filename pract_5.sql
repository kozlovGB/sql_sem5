CREATE DATABASE sem5;
USE sem5;
-- Машины
DROP TABLE IF EXISTS cars;
CREATE TABLE cars (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	carname VARCHAR(45),
	cost INT
);

-- Наполнение данными
INSERT INTO cars (carname, cost)
VALUES
	('Audi', 52642 ),
	('Mercedes', 57127 ),
	('Skoda', 9000 ),
	('Volvo',  29000 ),
	('Bentley',  350000 ),
	('Citroen', 21000 ),
	('Hummer', 41400 ),
	('Volkswagen', 21600 );
    
-- 1.	Создайте представление, в которое попадут автомобили стоимостью  до 25 000 долларов

CREATE VIEW Cheapcars AS
SELECT id, carname, cost
FROM cars
WHERE cost <= 25000;

SELECT * FROM Cheapcars;


-- Изменить в существующем представлении порог для стоимости: 
-- пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW) 

ALTER VIEW Cheapcars AS
SELECT id, carname, cost
FROM cars
WHERE cost <= 30000;

SELECT * FROM Cheapcars;

-- Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”
DROP VIEW IF EXISTS SkodaAudi;

CREATE VIEW SkodaAudi AS
SELECT id, carname, cost
FROM cars
WHERE carname = "Skoda" OR carname = "Audi";

SELECT * FROM SkodaAudi;

/*Добавьте новый столбец под названием «время до следующей станции». 
Чтобы получить это значение, мы вычитаем время станций для пар смежных станций. 
Мы можем вычислить это значение без использования оконной функции SQL, но это может быть
очень сложно. Проще это сделать с помощью оконной функции LEAD . 
Эта функция сравнивает значения из одной строки со следующей строкой, чтобы получить 
результат. В этом случае функция сравнивает значения в столбце «время» для станции 
со станцией сразу после нее.
*/

CREATE TABLE train (
	train_id INT, 
	station VARCHAR(45),
	station_time TIME
);

INSERT INTO train (train_id, station, station_time)
VALUES
	(110, 'San Francisco', '10:00:00' ),
	(110, 'Radwood City', '10:54:00'),
	(110, 'Palo Alto', '11:02:00'),
	(110,  'San Jose', '12:35:00'),
	(120,  'San Francisco','11:00:00'),
	(120, 'Palo Alto','12:49:00'),
	(120, 'San Jose','13:30:00') ;
    
SELECT train_id, station, station_time,
CAST(LEAD(station_time) OVER (PARTITION BY train_id ORDER BY train_id) - station_time AS TIME) AS 'время до следующей станции'
FROM train;


