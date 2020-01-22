-- 28.Выберите человека (фамилию) или людей (если таких несколько), сыгравшего (или
-- сыгравших) максимальное число ролей в фильмах.

CREATE TEMPORARY TABLE tmp ( role VARCHAR(255) NOT NULL, cout INT(255) NOT NULL);
-- Выборка и подсчет только актеров во временную таблицу
INSERT INTO tmp SELECT Actors.surname, COUNT(*) as cout FROM `Film_actors`, Actors WHERE `Film_actors`.`Actor` IS NOT NULL AND `Film_actors`.`role` = 1 AND `Film_actors`.`Actor` = `Actors`.`act_id` 
GROUP BY `Film_actors`.`Actor`;
SELECT @maxim := MAX(cout) FROM tmp; -- Создание переменной в которой хранится максимальное число ролей у актера
SELECT * FROM tmp WHERE cout = @maxim;
DROP TABLE tmp;

-- or 

CREATE TABLE tmp ( role VARCHAR(255) NOT NULL, cout INT(255) NOT NULL);
-- Выборка и подсчет только актеров во временную таблицу
INSERT INTO tmp SELECT Actors.surname, SUM(CASE WHEN `Film_actors`.`Actor` IS NULL THEN 0 ELSE 1 END) as cout FROM `Film_actors`, Actors 
WHERE `Film_actors`.`role` = 1 AND `Film_actors`.`Actor` = `Actors`.`act_id` 
GROUP BY `Film_actors`.`Actor`;
-- Выборка строки с максимальным значением
SELECT * FROM tmp WHERE cout = (SELECT MAX(tmp.cout) FROM tmp);
-- Удаление таблицы
DROP TABLE tmp;
