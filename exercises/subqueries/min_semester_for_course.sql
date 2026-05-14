-- Завдання:
--      Для кожного курсу знайти мінімальний семестр, в якому він може читатись
--      Очікувані колонки результату:
--          - ідентифікатор курсу (course_id)
--          - назва курсу (name)
--          - мінімальний рік (min_year)
--      Результат відсортувати за:
--          - мінімальним роком (зростання), потім за назвою курсу

-- Рішення:
WITH RECURSIVE course_hierarchy AS (
    SELECT
        c.course_id,
        c.name,
        1 AS min_year
    FROM course c
    LEFT JOIN course_prerequisite cp ON c.course_id = cp.course_id
    WHERE cp.prerequisite_course_id IS NULL

    UNION ALL

    SELECT
        c.course_id,
        c.name,
        ch.min_year + 1 AS min_year
    FROM course_prerequisite cp
    JOIN course_hierarchy ch ON cp.prerequisite_course_id = ch.course_id
    JOIN course c ON cp.course_id = c.course_id
)
SELECT
    course_id,
    name,
    MAX(min_year) AS min_year
FROM course_hierarchy
GROUP BY course_id, name
ORDER BY min_year ASC, name ASC;