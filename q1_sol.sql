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

-- 1. List the name of the student with id equal to v1 (id).

SELECT name FROM Student WHERE id = @v1;  -- 0.0024 sec / 0.000021 sec


EXPLAIN analyze
SELECT name FROM Student WHERE id = @v1;
-- RESULTS (take away point is its going through all the rows (rows=400)
-- -> Filter: (student.id = <cache>((@v1)))  (cost=41.00 rows=40) (actual time=0.163..0.434 rows=1 loops=1)
    -- -> Table scan on Student  (cost=41.00 rows=400) (actual time=0.082..0.386 rows=400 loops=1)

-- TO Optimization this query we can create index on id that will lowers its look up time
CREATE INDEX id_Index
ON Student (id); -- 0.0015 sec / 0.000012 sec




-- now we run again 
SELECT name FROM Student WHERE id = @v1; -- 0.00071 sec / 0.000034 sec

-- note it has  DRASTICALY reduce the run time 

-- WE analyse the query again 
EXPLAIN analyze
SELECT name FROM Student WHERE id = @v1;
-- results (take away point is that its going through only 1 row (rows=1) )
-- '-> Index lookup on Student using id_Index (id=(@v1))  (cost=0.35 rows=1) (actual time=0.031..0.034 rows=1 loops=1)\n'



