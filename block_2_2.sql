-- 29.Выберите для каждой кинокомпании (название) количество снятых ею фильмов.
SELECT Film.company, COUNT(*) FROM `Film` WHERE Film.company IS NOT NULL GROUP BY Film.company