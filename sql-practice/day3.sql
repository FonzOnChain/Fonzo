-- Day 3: Filtering Data with WHERE
-- Purpose: Show only students who scored more than 80 marks

SELECT name, marks
FROM students
WHERE marks > 80
ORDER BY marks DESC;
