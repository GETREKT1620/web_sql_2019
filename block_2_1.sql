-- 28.Выберите человека (фамилию) или людей (если таких несколько), сыгравшего (или
-- сыгравших) максимальное число ролей в фильмах.

CREATE TEMPORARY TABLE tmp ( role VARCHAR(255) NOT NULL, cout INT(255) NOT NULL);
-- Выборка и подсчет только актеров во временную таблицу
INSERT INTO tmp SELECT Actors.surname, COUNT(*) as cout FROM `Film_actors`, Actors WHERE `Film_actors`.`Actor` IS NOT NULL AND `Film_actors`.`role` = 1 AND `Film_actors`.`Actor` = `Actors`.`act_id` 
GROUP BY `Film_actors`.`Actor`;
SELECT @maxim := MAX(cout) FROM tmp; -- Создание переменной в которой хранится максимальное число ролей у актера
SELECT * FROM tmp WHERE cout = @maxim;
DROP TABLE tmp;