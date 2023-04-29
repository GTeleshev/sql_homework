USE sql_homework;

/* 
1.	Создайте функцию, которая принимает кол-во сек и форматирует их в кол-во дней, часов, минут и секунд.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
*/

DROP PROCEDURE IF EXISTS SecondsConvert;

DELIMITER $$
CREATE PROCEDURE SecondsConvert(Seconds INT)
BEGIN	
	SELECT 
	CONCAT(FLOOR(Seconds /60/60/24), ' Day(s), ', FLOOR(Seconds /60/60 % 24), ' Hour(s), ',
	FLOOR(Seconds /60 % 60), ' Minute(s), ', Seconds % 60, ' Second(s).') AS Conversion;
END $$
DELIMITER ;

CALL SecondsConvert(123456);

/* 
2.	Выведите только четные числа от 1 до 10 включительно.
Пример: 2,4,6,8,10 (можно сделать через шаг +  2: х = 2, х+=2)
*/

DROP PROCEDURE IF EXISTS Even_Numbers;

DELIMITER $$
CREATE PROCEDURE Even_Numbers(n INT)
BEGIN
	DECLARE counter INT DEFAULT 0;
    DECLARE res VARCHAR(255) DEFAULT '';
    WHILE counter <= n DO
		IF counter % 2 = 0 THEN
			SET res = CONCAT(res, ' ', counter);
        END IF;
		SET counter = counter + 1;
	END WHILE;
	SELECT res AS Even_Numbers;
END $$
DELIMITER ;

CALL Even_Numbers(10);