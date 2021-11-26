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

-- 3. List the names of students who have taken course v4 (crsCode).
SELECT name FROM Student WHERE id IN (SELECT studId FROM Transcript WHERE crsCode = @v4); -- 0.0078 sec / 0.000013 sec



-- lets analyse the query 
EXPLAIN analyze
SELECT name FROM Student WHERE id IN (SELECT studId FROM Transcript WHERE crsCode = @v4);

-- -> Inner hash join (student.id = `<subquery2>`.studId)  (cost=414.91 rows=400) (actual time=1.193..1.465 rows=2 loops=1)
   --  -> Table scan on Student  (cost=5.04 rows=400) (actual time=0.007..0.244 rows=400 loops=1)
   -- -> Hash
      --  -> Table scan on <subquery2>  (cost=0.26..2.62 rows=10) (actual time=0.001..0.001 rows=2 loops=1)
         --   -> Materialize with deduplication  (cost=11.51..13.88 rows=10) (actual time=0.134..0.135 rows=2 loops=1)
            --    -> Filter: (transcript.studId is not null)  (cost=10.25 rows=10) (actual time=0.061..0.123 rows=2 loops=1)
              --      -> Filter: (transcript.crsCode = <cache>((@v4)))  (cost=10.25 rows=10) (actual time=0.060..0.121 rows=2 loops=1)
                 --       -> Table scan on Transcript  (cost=10.25 rows=100) (actual time=0.027..0.092 rows=100 loops=1)
                 
                 
-- to optemise this query we will use Common Table Expression(CTE) and replace subquery with CTE

with CTE as (SELECT studId FROM Transcript WHERE crsCode = @v4);

-- new query look like 
SELECT name FROM Student WHERE id IN CTE;
