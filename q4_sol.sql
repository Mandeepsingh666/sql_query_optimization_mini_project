USE springboardopt;

-- -------------------------------------
SET @v1 = 1612521;
SET @v2 = 1145072;
SET @v3 = 1828467;
SET @v4 = 'MGT382';
SET @v5 = 'Amber Hill';
SET @v6 = 'MGT';
SET @v7 = 'EE';			  
SET @v8 = 'MAT';

-- 4. List the names of students who have taken a course taught by professor v5 (name).
SELECT name FROM Student,
	(SELECT studId FROM Transcript,
		(SELECT crsCode, semester FROM Professor
			JOIN Teaching
			WHERE Professor.name = @v5 AND Professor.id = Teaching.profId) as alias1
	WHERE Transcript.crsCode = alias1.crsCode AND Transcript.semester = alias1.semester) as alias2
WHERE Student.id = alias2.studId;


-- i will write this query differntly 
SELECT 
    name
FROM
    Student AS s
        JOIN
    Transcript AS t ON s.id = t.studId
WHERE
    crsCode IN (SELECT 
            crsCode
        FROM
            Professor AS p
                JOIN
            Course AS c USING (deptId)
        WHERE
            name = @v5);
            
-- create CTE
with CTE as (SELECT 
            crsCode
        FROM
            Professor AS p
                JOIN
            Course AS c USING (deptId)
        WHERE
            name = @v5)
    -- then i  will replace subquery with CTE        
SELECT 
    name
FROM
    Student AS s
        JOIN
    Transcript AS t ON s.id = t.studId
WHERE
    crsCode IN CTE;
    
    