CREATE TABLE DEPTS AS 
    (SELECT department_id, department_name, manager_id, location_id
    FROM departments);
UPDATE DEPTS
    SET department_name = '개발', manager_id = null, location_id =1800  
    WHERE department_id = 280;

UPDATE DEPTS
    SET department_name = '회계부', location_id =1800  
    WHERE department_id = 290;

INSERT INTO DEPTS
    (department_id, department_name, manager_id, location_id)
    VALUES 
    (300, '재정', 301, 1800);

INSERT INTO DEPTS
    (department_id, department_name, manager_id, location_id)
    VALUES 
    (310, '인사', 302, 1800);
    
INSERT INTO DEPTS
    (department_id, department_name, manager_id, location_id)
    VALUES 
    (320, '영업', 303, 1700);

--문제2-1
UPDATE DEPTS
SET department_name = 'IT bank'
WHERE department_name = 'IT Support';

--문제2-2
UPDATE DEPTS
SET manager_id = 301
WHERE department_id = 290;

--문제2-3
UPDATE DEPTS
SET department_name ='IT Help', manager_id = 303, location_id = 1800
WHERE department_name = 'IT Helpdesk';

--문제2-4 
--회계, 재정, 인사, 영업부의 매니저 아이디를 301로 일괄 변경하세요.
UPDATE DEPTS
SET  manager_id = 301
WHERE department_name IN ('회계부', '재정', '인사', '영업'); 

--문제3-1
DELETE FROM DEPTS
WHERE department_name = '영업';

--문제3-2
DELETE FROM DEPTS
WHERE department_name = 'NOC';


--문제 4-1
DELETE FROM DEPTS
WHERE department_id > 200;
SELECT * FROM DEPTS;

--문제 4-2
UPDATE DEPTS
SET manager_id = 100
WHERE manager_id  IS NOT NULL;

--문제 4-4
MERGE INTO DEPTS a
    USING 
     (SELECT * FROM departments) b
    ON (a.department_id = b.department_id)
WHEN MATCHED THEN
    UPDATE SET
        a.department_name = b.department_name,
        a.manager_id = b.manager_id,
        a.location_id = b.location_id

WHEN NOT MATCHED THEN
    INSERT VALUES
    (b.department_id, b.department_name,
        b.manager_id, b.location_id);

--문제 5-1
CREATE TABLE jobs_it AS
(SELECT * FROM jobs WHERE min_salary > 6000);
SELECT * FROM jobs_it;
--문제 5-2
INSERT INTO jobs_it
    (job_id, job_title, min_salary, max_salary)
    VALUES
    ('IT_DEV', '아이티개발팀', 6000, 20000);

INSERT INTO jobs_it
    (job_id, job_title, min_salary, max_salary)
    VALUES
    ('NET_DEV', '네트워크개발팀', 5000, 20000);

INSERT INTO jobs_it
    (job_id, job_title, min_salary, max_salary)
    VALUES
    ('SEC_DEV', '보안개발팀', 6000, 19000);
    
MERGE INTO jobs_it aa
    USING (SELECT * FROM jobs 
            WHERE min_salary > 6000) j
    ON
        (aa.job_id = j.job_id)
WHEN MATCHED THEN
    UPDATE SET
        aa.min_salary = j.min_salary,
        aa.max_salary = j.max_salary
WHEN NOT MATCHED THEN 
    INSERT VALUES
    (j.job_id, j.job_title, j.min_salary, j.max_salary);