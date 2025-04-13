-- 1. Уникальные названия всех книг, опубликованных после 1990 года. Вывести только названия.
-- 1.1 Запрос с использованием даты таблицы
SELECT DISTINCT title 
FROM book 
WHERE year_publish > '1990-01-01';
-- 1.2. Запрос с использованием функции EXTRACT для извлечения года из даты в таблице
SELECT DISTINCT title 
FROM book 
WHERE extract(year from year_publish) > 1990;

-- 2. Для каждого автора найти сумму напечатанных страниц. Вывести полное имя автора и сумму страниц.
SELECT a.full_name, COALESCE(SUM(b.pages), 0) AS sum_pages 
FROM author AS a
LEFT JOIN book AS b ON a.id_author = b.id_author
GROUP BY a.full_name;

-- 3. Подсчитать количество книг авторов каждого века. Вывести век и количество книг.
SELECT a.century, COUNT(b.id_book) AS count_books 
FROM author AS a
JOIN book AS b ON a.id_author = b.id_author
GROUP BY a.century
ORDER BY a.century ASC;

-- 4. Вывести авторов, у которых нет ни одной книги.
-- 4.1. Запрос с использованием LEFT JOIN
SELECT a.full_name 
FROM author AS a
LEFT JOIN book AS b ON a.id_author = b.id_author
WHERE b.id_book IS NULL;
-- 4.2. Запрос с использованием подзапроса
SELECT full_name 
FROM author 
WHERE id_author NOT IN (
    SELECT id_author 
    FROM book
);
