USE sql_homework;

DROP TABLE IF EXISTS Cars;

CREATE TABLE Cars (
	Id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(40),
    Cost Int
);

INSERT INTO Cars (Name, Cost) VALUES 
("Audi", 52642),
("Mercedes", 57127),
("Skoda", 9000),
("Volvo", 29000),
("Bentley", 350000),
("Citroen", 21000),
("Hummer", 41400),
("Volkswagen", 21600);

-- 1.	Создайте представление, в которое попадут автомобили стоимостью  до 25 000 долларов

DROP VIEW  IF EXISTS BelowThreshold;
CREATE VIEW BelowThreshold AS
SELECT *
FROM Cars
WHERE Cost < 25000;

SELECT * FROM BelowThreshold;

-- 2.	Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW) 

ALTER VIEW BelowThreshold AS 
SELECT *
FROM Cars
WHERE Cost < 30000;

SELECT * FROM BelowThreshold;

-- 3. 	Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди

DROP VIEW IF EXISTS SelectedCars;
CREATE VIEW SelectedCars AS
SELECT *
FROM Cars
WHERE Name IN ("Skoda", "Audi");

SELECT * FROM SelectedCars;

-- Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.

DROP TABLE IF EXISTS GroupsT;
DROP TABLE IF EXISTS Analysis;
DROP TABLE IF EXISTS Orders;


CREATE TABLE GroupsT(
	gr_id INT PRIMARY KEY AUTO_INCREMENT,
	gr_name VARCHAR(40),
	gr_temp INT);

CREATE TABLE Analysis(
	an_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	an_name VARCHAR(40),
	an_cost INT,
	an_price INT,
    an_group INT,
	FOREIGN KEY (an_group) REFERENCES GroupsT(gr_id) ON DELETE CASCADE);

CREATE TABLE Orders(
	ord_id INT PRIMARY KEY AUTO_INCREMENT,
	ord_datetime DATETIME,
    ord_an INT,
	FOREIGN KEY(ord_an) REFERENCES Analysis(an_id) ON DELETE CASCADE);

INSERT INTO GroupsT (gr_name, gr_temp)
VALUES 
('test1', 20),
('test2', 20),
('test3', 20);

INSERT INTO Analysis (an_name, an_cost, an_price, an_group)
VALUES
('testan1',100,110,1),
('testan2',120,130,2),
('testan3',140,150,3),
('testan4',160,170,1);

INSERT INTO Orders (ord_datetime, ord_an)
VALUES
('20200201',2),
('20200203',1),
('20200205',2),
('20200207',2),
('20200209',2),
('20200211',3),
('20200213',2),
('20200215',1),
('20200217',3),
('20200219',4),
('20200221',1),
('20200223',2),
('20200225',2);

-- Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.

DROP VIEW IF EXISTS Orders_by_date;

CREATE VIEW Orders_by_date AS 
SELECT DISTINCT Analysis.an_name, Analysis.an_price FROM Analysis
INNER JOIN Orders ON Analysis.an_id = Orders.ord_an
WHERE Orders.ord_datetime BETWEEN '2020-02-05 00:00:00' AND '2020-02-12 00:00:00';

SELECT * FROM Orders_by_date;

/*Добавьте новый столбец под названием «время до следующей станции». 
Чтобы получить это значение, мы вычитаем время станций для пар смежных станций. 
Мы можем вычислить это значение без использования оконной функции SQL, 
но это может быть очень сложно. Проще это сделать с помощью оконной функции LEAD. 
Эта функция сравнивает значения из одной строки со следующей строкой, 
чтобы получить результат. В этом случае функция сравнивает значения 
в столбце «время» для станции со станцией сразу после нее.
*/

DROP TABLE IF EXISTS Trains;
CREATE TABLE Trains (
	train_id INT,
    station VARCHAR(20),
    station_time TIME
);

INSERT INTO Trains (train_id, station, station_time) VALUES
(110, "San Francisco", "10:00"),
(110, "Redwood City", "10:54"),
(110, "Palo Alto", "11:02"),
(110, "San Jose", "12:35"),
(120, "San Francisco", "11:00"),
(120, "Palo Alto", "12:49"),
(120, "San Jose", "13:30");

SELECT * FROM Trains;
DROP VIEW IF EXISTS TrainsView;
CREATE VIEW TrainsView AS
SELECT 
	train_id,
    station,
    station_time,    
    TIMEDIFF(LEAD(station_time) OVER (PARTITION BY train_id), station_time) AS time_to_next_station
FROM Trains;
SELECT * FROM TrainsView;