USE sql_homework;

DROP TABLE IF EXISTS AUTO;

CREATE TABLE  AUTO 
(       
	REGNUM VARCHAR(10) PRIMARY KEY, 
	MARK VARCHAR(10), 
	COLOR VARCHAR(15),
	RELEASEDT DATE, 
	PHONENUM VARCHAR(15)
);

DROP TABLE IF EXISTS CITY;

CREATE TABLE  CITY 
(	
    CITYCODE INT PRIMARY KEY,
	CITYNAME VARCHAR(50), 
	PEOPLES INT 
);

DROP TABLE IF EXISTS MAN;

CREATE TABLE  MAN 
(	
	PHONENUM VARCHAR(15) PRIMARY KEY , 
	FIRSTNAME VARCHAR(50),
	LASTNAME VARCHAR(50),  
	CITYCODE INT, 
	YEAROLD INT	 
);


 -- AUTO
INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES
(111114,'LADA', 'КРАСНЫЙ', date'2008-01-01', '9152222221'),
(111115,'VOLVO', 'КРАСНЫЙ', date'2013-01-01', '9173333334'),
(111116,'BMW', 'СИНИЙ', date'2015-01-01', '9173333334'),
(111121,'AUDI', 'СИНИЙ', date'2009-01-01', '9173333332'),
(111122,'AUDI', 'СИНИЙ', date'2011-01-01', '9213333336'),
(111113,'BMW', 'ЗЕЛЕНЫЙ', date'2007-01-01', '9214444444'),
(111126,'LADA', 'ЗЕЛЕНЫЙ', date'2005-01-01', null),
(111117,'BMW', 'СИНИЙ', date'2005-01-01', null),
(111119,'LADA', 'СИНИЙ', date'2017-01-01', 9213333331);

 -- CITY
INSERT INTO CITY (CITYCODE,CITYNAME,PEOPLES)
VALUES
(1,'Москва', 10000000),
(2,'Владимир', 500000),
(3, 'Орел', 300000),
(4,'Курск', 200000),
(5, 'Казань', 2000000),
(7, 'Котлас', 110000),
(8, 'Мурманск', 400000),
(9, 'Ярославль', 500000);

-- MAN
INSERT INTO MAN (PHONENUM,FIRSTNAME,LASTNAME,CITYCODE,YEAROLD)
VALUES
('9152222221','Андрей','Николаев', 1, 22),
('9152222222','Максим','Москитов', 1, 31),
('9153333333','Олег','Денисов', 3, 34),
('9173333334','Алиса','Никина', 4, 31),
('9173333335','Таня','Иванова', 4, 31),
('9213333336','Алексей','Иванов', 7, 25),
('9213333331','Андрей','Некрасов', 2, 27),
('9213333332','Миша','Рогозин', 2, 21),
('9214444444','Алексей','Галкин', 1, 38);

SELECT * FROM auto;

-- 1.Вывести на экран, сколько машин каждого цвета  для машин марок BMW и LADA

SELECT mark, color FROM auto;

SELECT mark, color, count(color) as color_count
FROM auto
GROUP BY mark, color;

-- 2.Вывести на экран марку авто(количество) и количество авто не этой марки.
-- 100 машин, их них 20 - BMW и 80 машин другой марки ,  
-- AUDI - 30 и 70 машин другой марки, LADA - 15, 85 авто другой марки

SELECT	
    mark AS m, 
    count(mark) AS "Равно", 
    ((SELECT count(*) from auto) - count(mark)) AS "Не равно"
FROM auto
GROUP BY mark;

DROP TABLE IF EXISTS test_a;
DROP TABLE IF EXISTS test_b;

create table test_a (id INT, test varchar(10));
create table test_b (id INT);

insert into test_a(id, test) values
(10, 'A'),
(20, 'A'),
(30, 'F'),
(40, 'D'),
(50, 'C');

insert into test_b(id) values
(10),
(30),
(50);

SELECT * FROM test_a;
SELECT * FROM test_b;

-- Напишите запрос, который вернет строки из таблицы test_a, id 
-- которых нет в таблице test_b, НЕ используя ключевого слова NOT.

SELECT test_a.id, test_a.test
FROM test_a LEFT JOIN test_b ON test_a.id = test_b.id
WHERE test_b.id IS NULL
ORDER by test_a.id

