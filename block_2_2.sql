-- 29.Выберите для каждой кинокомпании (название) количество снятых ею фильмов.
SELECT Film.company, COUNT(*) FROM `Film` WHERE Film.company IS NOT NULL GROUP BY Film.company

-- or

SELECT Film.company, SUM(CASE WHEN Film.company is NULL THEN 0 ELSE 1 END) as cout FROM `Film` GROUP BY Film.company
