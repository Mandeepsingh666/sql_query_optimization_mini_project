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

-- 2. List the names of students with id in the range of v2 (id) to v3 (inclusive).
SELECT name FROM Student WHERE id BETWEEN @v2 AND @v3; 




EXPLAIN analyze
SELECT name FROM Student WHERE id BETWEEN @v2 AND @v3 ;
-- Results (actual time=0.051..0.361)
-- -> Filter: (student.id between <cache>((@v2)) and <cache>((@v3)))  (cost=5.44 rows=44) (actual time=0.053..0.394 rows=278 loops=1)
   -- -> Table scan on Student  (cost=5.44 rows=400) (actual time=0.046..0.324 rows=400 loops=1)

-- Creating index on id will reduce run time 
CREATE INDEX id_Index
ON Student (id);

SELECT name FROM Student WHERE id BETWEEN @v2 AND @v3; -- 0.00065 sec / 0.000079 sec
-- note its has drasticaly reduce the run time 

EXPLAIN analyze
SELECT name FROM Student WHERE id BETWEEN @v2 AND @v3 ;

-- Results (for filter rows=278 & actual time=0.022..0.333 and for table actual time=0.019..0.270 & rows=400)
-- the Indexing has reduce the actual run time in half for table and filter
-- Filter: (student.id between <cache>((@v2)) and <cache>((@v3)))  (cost=41.00 rows=278) (actual time=0.022..0.333 rows=278 loops=1)
 --   -> Table scan on Student  (cost=41.00 rows=400) (actual time=0.019..0.270 rows=400 loops=1)





