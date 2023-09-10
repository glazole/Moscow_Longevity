/* РЕАЛИЗАЦИЯ ЗАПРОСОВ К БД */


/* Создание новой таблицы на основе имеющейся и преобразование в ней поля 
содержащего дату рождения участника в тип даты */

CREATE TABLE mos_long.temp_users AS
SELECT 
NUM_CLIENT,
DATE_REG,
SEX,
CAST(DATE_BIRTH AS DATE) AS DATE_BIRTH,
ADDRESS
FROM mos_long.users

/* Создание нового поля 
содержащего расчет возраста участника */

ALTER TABLE IF EXISTS mos_long.temp_users
ADD COLUMN IF NOT EXISTS AGE bigint;
UPDATE mos_long.temp_users SET AGE = DATE_PART('year', AGE(DATE_BIRTH));
ALTER TABLE IF EXISTS mos_long.temp_users
ADD COLUMN IF NOT EXISTS AGE SET NOT NULL;

/* Средний возраст участников проекта 
и сколько каких участников */

SELECT
SEX,
COUNT(*),
AVG(AGE)
FROM mos_long.temp_users
GROUP BY SEX

/* Средний возраст участников проекта 
и сколько каких участников в процентах */

SELECT
SEX,
ROUND(COUNT(*)*100/(SELECT COUNT(*) FROM mos_long.temp_users),2)AS PERCENTAGE,
AVG(AGE)
FROM mos_long.temp_users
GROUP BY SEX

/* Предпочитаемый тип занятий мужчинами и женщинами, 
и их средний возраст  */

SELECT
ONLINE,
SEX,
ROUND(COUNT(*)*100/(SELECT COUNT(*) FROM mos_long.temp_users MTU
INNER JOIN mos_long.attend ATT ON MTU.NUM_CLIENT = ATT.NUM_CLIENT),2)AS PERCENTAGE,
AVG(AGE)
FROM mos_long.temp_users MTU
INNER JOIN mos_long.attend ATT ON MTU.NUM_CLIENT = ATT.NUM_CLIENT
GROUP BY 
ONLINE,
SEX

/* Занятия онлайн / оффлайн - в процентах  */

SELECT
ONLINE,
ROUND(COUNT(NUM_ZAN)*100/(SELECT COUNT(NUM_ZAN) FROM mos_long.temp_users MTU
INNER JOIN mos_long.attend ATT ON MTU.NUM_CLIENT = ATT.NUM_CLIENT),2)AS PERCENTAGE
FROM mos_long.temp_users MTU
INNER JOIN mos_long.attend ATT ON MTU.NUM_CLIENT = ATT.NUM_CLIENT
GROUP BY
ONLINE

/* Найти группу с самой большой нагрузкой (количество занятий)  */

SELECT
  NUM_GROUP,
  count(NUM_ZAN) AS count
FROM mos_long.temp_users MTU
INNER JOIN mos_long.attend ATT ON MTU.NUM_CLIENT = ATT.NUM_CLIENT
GROUP BY
  NUM_GROUP
ORDER BY
  count DESC
LIMIT 
  1;


