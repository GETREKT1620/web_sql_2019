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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Actors`
--

INSERT INTO `Actors` (`act_id`, `firstname`, `surname`, `date`) VALUES
(1, 'Ivan', 'Dulin', '1976-11-13'),
(2, 'Sergey', 'Svetlakov', '1986-11-12'),
(3, 'Чувак', 'Чувачело', '1990-11-04'),
(4, 'Брюс', 'Вылез', '1965-09-03');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Actors`
--
ALTER TABLE `Actors`
  ADD PRIMARY KEY (`act_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `Actors`
--
ALTER TABLE `Actors`
  MODIFY `act_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

--
-- Структура таблицы `C_role`
--

CREATE TABLE `C_role` (
  `role_id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `C_role`
--

INSERT INTO `C_role` (`role_id`, `name`) VALUES
(1, 'Актер'),
(2, 'Режиссер');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `C_role`
--
ALTER TABLE `C_role`
  ADD PRIMARY KEY (`role_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `C_role`
--
ALTER TABLE `C_role`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

--
-- Структура таблицы `Cinema`
--

CREATE TABLE `Cinema` (
  `name` varchar(11) NOT NULL,
  `address` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Cinema`
--

INSERT INTO `Cinema` (`name`, `address`) VALUES
('Восход', 'Восточная'),
('Заря', 'Северная'),
('Звезда', 'Южная');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Cinema`
--
ALTER TABLE `Cinema`
  ADD PRIMARY KEY (`name`);
COMMIT;

CREATE TABLE `Film` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `genre` varchar(255) NOT NULL,
  `length` time(6) NOT NULL,
  `country` varchar(255) NOT NULL,
  `age` int(255) NOT NULL,
  `company` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Film`
--

INSERT INTO `Film` (`id`, `name`, `genre`, `length`, `country`, `age`, `company`) VALUES
(1, 'Terminator', 'Action', '02:00:00.000000', 'USA', 16, 'USAMARINCORP'),
(2, 'Snatch', 'Comedy', '01:54:00.000000', 'USA', 18, 'WeedCorp'),
(3, 'Taxi', 'Comedy', '02:22:00.000000', 'France', 12, 'FrancePD');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Film`
--
ALTER TABLE `Film`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `Film`
--
ALTER TABLE `Film`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

--
-- Структура таблицы `Film_actors`
--

CREATE TABLE `Film_actors` (
  `Film` int(11) NOT NULL,
  `Actor` int(255) NOT NULL,
  `role` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Film_actors`
--

INSERT INTO `Film_actors` (`Film`, `Actor`, `role`) VALUES
(2, 1, 1),
(3, 1, 1),
(1, 4, 1),
(1, 3, 2),
(3, 2, 1),
(3, 3, 1);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Film_actors`
--
ALTER TABLE `Film_actors`
  ADD KEY `role` (`role`),
  ADD KEY `Film` (`Film`),
  ADD KEY `Actor` (`Actor`);

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `Film_actors`
--
ALTER TABLE `Film_actors`
  ADD CONSTRAINT `Film_actors_ibfk_1` FOREIGN KEY (`role`) REFERENCES `C_role` (`role_id`),
  ADD CONSTRAINT `Film_actors_ibfk_2` FOREIGN KEY (`Film`) REFERENCES `Film` (`id`),
  ADD CONSTRAINT `Film_actors_ibfk_3` FOREIGN KEY (`Actor`) REFERENCES `Actors` (`act_id`);
COMMIT;

--
-- Структура таблицы `schedule`
--

CREATE TABLE `schedule` (
  `id` int(11) NOT NULL,
  `hall` int(255) NOT NULL,
  `date` datetime(6) NOT NULL,
  `film_id` int(11) NOT NULL,
  `Zone` varchar(255) NOT NULL,
  `price` int(255) NOT NULL,
  `cinema` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `schedule`
--

INSERT INTO `schedule` (`id`, `hall`, `date`, `film_id`, `Zone`, `price`, `cinema`) VALUES
(1, 2, '2019-12-30 00:00:00.000000', 2, 'VIP', 310, 'Восход'),
(2, 2, '2019-12-24 00:00:00.000000', 1, 'VIP', 200, 'Заря'),
(3, 5, '2019-12-11 00:00:00.000000', 3, 'Regular', 228, 'Звезда'),
(4, 1, '2020-01-01 00:00:00.000000', 2, 'VIP', 301, 'Восход');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `film` (`film_id`),
  ADD KEY `Cinema` (`cinema`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `schedule`
--
ALTER TABLE `schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`film_id`) REFERENCES `Film` (`id`),
  ADD CONSTRAINT `schedule_ibfk_2` FOREIGN KEY (`cinema`) REFERENCES `Cinema` (`name`);
COMMIT;