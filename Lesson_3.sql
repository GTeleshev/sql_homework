USE sql_homework;

DROP TABLE IF EXISTS salespeople;

CREATE TABLE salespeople (
	snum INT, 
	sname VARCHAR(40),
	city VARCHAR(40),
    comm DOUBLE
);

INSERT INTO salespeople (snum, sname, city, comm) VALUES
(1001, 'Peel', 'London', .12),
(1002, 'Serres', 'San Jose', .13),
(1004, 'Motika', 'London', .11),
(1007, 'Rifkin', 'Barcelona', .15),
(1003, 'Axelrod', 'New York', .10)
;

SELECT * FROM salespeople;

DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
	cnum INT, 
	cname VARCHAR(40),
	city VARCHAR(40),
    rating INT,
    snum INT
);

INSERT INTO customers (cnum, cname, city, rating, snum) VALUES
(2001, 'Hoffman', 'London', 100, 1001),
(2002, 'Giovanni', 'Rome', 200, 1003),
(2003, 'Liu', 'San Jose', 200, 1002),
(2004, 'Grass', 'Berlin', 300, 1002),
(2006, 'Clemens', 'London', 100, 1001),
(2008, 'Cisneros', 'San Jose', 300, 1007),
(2007, 'Pereira', 'Rome', 100, 1004);

SELECT * FROM customers;

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
	onum INT, 
	amt DOUBLE,
	odate VARCHAR(10),
    cnum INT,
    snum INT
);

INSERT INTO orders (onum, amt, odate, cnum, snum) VALUES
(3001, 18.69, '10/03/1990', 2008, 1007),
(3003, 767.19, '10/03/1990', 2001, 1001),
(3002, 1900.10, '10/03/1990', 2007, 1004),
(3005, 5160.45, '10/03/1990', 2003, 1002),
(3006, 1098.16, '10/03/1990', 2008, 1007),
(3009, 1713.23, '10/04/1990', 2002, 1003),
(3007, 75.75, '10/04/1990', 2004, 1002),
(3008, 4723.00, '10/05/1990', 2006, 1001),
(3010, 1309.95, '10/06/1990', 2004, 1002),
(3011, 9891.88, '10/06/1990', 2006, 1001);

SELECT * FROM orders;
-- 1.	 Напишите запрос, который вывел бы таблицу со столбцами в следующем порядке: city, sname, snum, comm. 
-- (к первой или второй таблице, используя SELECT)

SELECT city, sname, snum, comm FROM salespeople;

-- 2. Напишите команду SELECT, которая вывела бы оценку(rating), сопровождаемую именем каждого заказчика 
-- в городе San Jose. (“заказчики”)

SELECT rating AS 'Рейтинг', cname AS "Заказчик", city AS 'Город' FROM customers WHERE city = 'San Jose';

-- 3.	 Напишите запрос, который вывел бы значения snum всех продавцов из таблицы заказов без каких бы то ни было повторений. 
-- (уникальные значения в  “snum“ “Продавцы”)

SELECT DISTINCT snum FROM orders;

-- 4*. 	Напишите запрос, который бы выбирал заказчиков, чьи имена начинаются с буквы G. 
-- Используется оператор "LIKE": (“заказчики”) https://dev.mysql.com/doc/refman/8.0/en/string-comparison-functions.html

SELECT cname FROM customers WHERE cname LIKE 'G%';

-- 5. 	Напишите запрос, который может дать вам все заказы со значениями суммы выше чем $1,000. (“Заказы”, “amt”  - сумма)

SELECT * FROM orders WHERE amt > 1000;

-- 6.	Напишите запрос который выбрал бы наименьшую сумму заказа.
-- (Из поля “amt” - сумма в таблице “Заказы” выбрать наименьшее значение)

SELECT *, MIN(amt) FROM orders;

-- 7. 	Напишите запрос к таблице “Заказчики”, который может показать всех заказчиков, 
-- у которых рейтинг больше 100 и они находятся не в Риме.

SELECT cname, rating, city 
    FROM customers 
    WHERE rating > 100 AND city <> 'Rome';

-- таблица из классной работы

DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	firstname VARCHAR(45),
	lastname VARCHAR(45),
	post VARCHAR(100),
	seniority INT, 
	salary INT, 
	age INT
);

-- Наполнение данными
INSERT INTO staff (firstname, lastname, post, seniority, salary, age)
VALUES
('Вася', 'Петров', 'Начальник', '40', 100000, 60),
('Петр', 'Власов', 'Начальник', '8', 70000, 30),
('Катя', 'Катина', 'Инженер', '2', 70000, 25),
('Саша', 'Сасин', 'Инженер', '12', 50000, 35),
('Иван', 'Иванов', 'Рабочий', '40', 30000, 59),
('Петр', 'Петров', 'Рабочий', '20', 25000, 40),
('Сидр', 'Сидоров', 'Рабочий', '10', 20000, 35),
('Антон', 'Антонов', 'Рабочий', '8', 19000, 28),
('Юрий', 'Юрков', 'Рабочий', '5', 15000, 25),
('Максим', 'Максимов', 'Рабочий', '2', 11000, 22),
('Юрий', 'Галкин', 'Рабочий', '3', 12000, 24),
('Людмила', 'Маркина', 'Уборщик', '10', 10000, 49);

SELECT * FROM staff;

-- Отсортируйте поле “зарплата” в порядке убывания и возрастания

SELECT * from staff ORDER BY salary;
SELECT * from staff ORDER BY salary DESC;


-- ** Отсортируйте по возрастанию поле “Зарплата” и выведите 5 строк с наибольшей заработной платой (возможен подзапрос)

SELECT salary from staff ORDER BY salary LIMIT 5;

-- Выполните группировку всех сотрудников по специальности , суммарная зарплата которых превышает 100000

SELECT post, SUM(salary) AS 'salary_sum' FROM staff GROUP BY post HAVING salary_sum > 100000;
