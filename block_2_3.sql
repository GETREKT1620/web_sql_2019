-- 30.Выберите все кинотеатры, показывающие в текущем месяце фильм «Терминатор».
--  SELECT schedule.cinema FROM `schedule` WHERE `schedule`.`film` = "Terminator" and `schedule`.`date` BETWEEN  '2019-11-1' AND '2019-11-31' 
-- V.2.0
SELECT DISTINCT schedule.cinema FROM `schedule` WHERE `schedule`.`film_id` = "1" and MONTH(`schedule`.`date`) = MONTH(NOW()) AND YEAR(`schedule`.`date`) = YEAR(NOW())

