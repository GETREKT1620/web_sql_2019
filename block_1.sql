-- 10.Описание репертуаров кинотеатров. Включает в себя кинотеатры, фильмы, людей,
-- участвующих в фильмах, расписание кинотеатров. Кинотеатры описываются
-- названием и адресом. Фильмы состоят из: названия, жанра14, продолжительности,
-- страны или стран происхождения, кинокомпании, задействованных актёров с
-- указанием ролей и других участников съёмок с указанием выполняемых задач15
-- ,
-- минимального допустимого возраста. Люди, участвующие в фильмах,
-- характеризуются: фамилией, именем, датой рождения, множеством фильмов, в
-- которых принимали участие, с указанием выполняемых задач (например,
-- режиссёр) или ролей. Расписание кинотеатров состоит из указания зала, даты и
-- времени начала, указания фильма, стоимостей билетов в зависимости от зон.
-- a. Каждый человек в одном и том же фильме участвовал только один раз
-- (играл в одной роли или решал одну задачу).

-- Таблица актеров
CREATE TABLE `Actors` (
  `act_id` int(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `date` date NOT NULL
)

INSERT INTO `Actors` (`act_id`, `firstname`, `surname`, `date`) VALUES
(1, 'Ivan', 'Dulin', '1976-11-13'),
(2, 'Sergey', 'Svetlakov', '1986-11-12'),
(3, 'Чувак', 'Чувачело', '1990-11-04'),
(4, 'Брюс', 'Вылез', '1965-09-03');

ALTER TABLE `Actors` 
  ADD PRIMARY KEY (`act_id`); -- Уникальный ID актера

ALTER TABLE `Actors` 
  MODIFY `act_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

-- Таблица кинотеатров
CREATE TABLE `Cinema` (
  `name` varchar(11) NOT NULL,
  `address` varchar(11) NOT NULL
)

INSERT INTO `Cinema` (`name`, `address`) VALUES
('Восход', 'Восточная'),
('Заря', 'Северная'),
('Звезда', 'Южная');

ALTER TABLE `Cinema`
  ADD PRIMARY KEY (`name`); -- Уникальное имя кинотеатра
COMMIT;

-- Таблица возможных ролей 
CREATE TABLE `C_role` (
  `role_id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL
)

INSERT INTO `C_role` (`role_id`, `name`) VALUES
(1, 'Актер'),
(2, 'Режиссер');

ALTER TABLE `C_role`
  ADD PRIMARY KEY (`role_id`); -- Уникальный ID роли

ALTER TABLE `C_role`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

-- Таблица фильмов
CREATE TABLE `Film` (
  `name` varchar(255) NOT NULL,
  `genre` varchar(255) NOT NULL,
  `length` time(6) NOT NULL,
  `country` varchar(255) NOT NULL,
  `age` int(255) NOT NULL,
  `company` varchar(255) NOT NULL
)

INSERT INTO `Film` (`name`, `genre`, `length`, `country`, `age`, `company`) VALUES
('Avengers', 'Fantasy', '02:00:00.000000', 'USA', 16, 'WeedCorp'),
('Snatch', 'Comedy', '02:02:00.000000', 'USA', 18, 'CocaineSmashers'),
('TAXI', 'Comedy', '02:03:00.000000', 'France', 14, 'WeedCorp'),
('Terminator', 'Action', '01:54:00.000000', 'USA', 16, 'DolbitDigital');

ALTER TABLE `Film` -- Уникальное название фильма
  ADD PRIMARY KEY (`name`);
COMMIT;

-- Таблица расписания фильмов для кинотеатров
CREATE TABLE `schedule` (
  `id` int(11) NOT NULL,
  `hall` int(255) NOT NULL,
  `date` datetime(6) NOT NULL,
  `film` varchar(255) NOT NULL,
  `Zone` varchar(255) NOT NULL, -- Что-то типа такого?
  `price` int(255) NOT NULL,
  `cinema` varchar(255) NOT NULL
)

INSERT INTO `schedule` (`id`, `hall`, `date`, `film`, `Zone`, `price`, `cinema`) VALUES
(1, 3, '2019-11-13 00:00:00.000000', 'Snatch', 'VIP', 200, 'Звезда'),
(2, 2, '2019-11-28 00:00:00.000000', 'Terminator', 'VIP', 300, 'Восход'),
(3, 6, '2019-11-30 00:00:00.000000', 'Terminator', 'REGULAR', 310, 'Заря'),
(4, 1, '2019-11-27 00:00:00.000000', 'Avengers', 'VIP', 228, 'Восход'),
(5, 4, '2019-12-02 00:00:00.000000', 'Terminator', 'REGULAR', 200, 'Звезда'),
(6, 2, '2019-12-24 00:00:00.000000', 'Terminator', 'REGULAR', 300, 'Восход'),
(7, 1, '2019-12-25 00:00:00.000000', 'Terminator', 'VIP', 310, 'Восход'),
(8, 1, '2019-12-18 00:00:00.000000', 'Terminator', 'REGULAR', 228, 'Заря');

ALTER TABLE `schedule`
  ADD PRIMARY KEY (`id`), -- Уникальный id
  ADD KEY `film` (`film`),  -- Внешний ключ для связки с таблицей фильмов
  ADD KEY `Cinema` (`cinema`); -- Внешний ключ для связки с таблицей кинотеатров

ALTER TABLE `schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `schedule`
  ADD CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`film`) REFERENCES `Film` (`name`), -- Связка с таблицей фильмов
  ADD CONSTRAINT `schedule_ibfk_2` FOREIGN KEY (`cinema`) REFERENCES `Cinema` (`name`); -- Связка с таблицей кинотеатров
COMMIT;

-- Создание дополнительной таблицы для реализации связи многие ко многим (Фильм - актер - роль)
CREATE TABLE `Film_actors` (
  `Film` varchar(255) NOT NULL,
  `Actor` int(255) NOT NULL,
  `role` int(255) NOT NULL
)

ALTER TABLE `Film_actors`
  ADD KEY `role` (`role`), -- Внешний ключ для связки с таблицей ролей
  ADD KEY `Film` (`Film`), -- Внешний ключ для связки с таблицей фильмов
  ADD KEY `Actor` (`Actor`); -- Внешний ключ для связки с таблицей актеров

ALTER TABLE `Film_actors`
  ADD CONSTRAINT `Film_actors_ibfk_1` FOREIGN KEY (`role`) REFERENCES `C_role` (`role_id`), -- Связка с таблицей ролей
  ADD CONSTRAINT `Film_actors_ibfk_2` FOREIGN KEY (`Film`) REFERENCES `Film` (`name`), -- Связка с таблицей фильмов 
  ADD CONSTRAINT `Film_actors_ibfk_3` FOREIGN KEY (`Actor`) REFERENCES `Actors` (`act_id`); -- Связка с таблицей актеров
COMMIT;

-- заполнение по внешним ключам таблицы:
INSERT INTO `Film_actors` (`Film`, `Actor`, `role`) VALUES
('Avengers', 1, 1),
('Avengers', 2, 2),
('Snatch', 2, 1),
('TAXI', 4, 1),
('Snatch', 3, 1),
('Terminator', 3, 1),
('Terminator', 2, 1);






