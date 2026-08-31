-- Day 2: Finding Top Students
-- Purpose: Show top 3 students by marks from 'students' table

SELECT name, marks
FROM students
ORDER BY marks DESC
LIMIT 3;
