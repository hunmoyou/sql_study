CREATE TABLE DEPTS AS 
    (SELECT department_id, department_name, manager_id, location_id
    FROM departments);
UPDATE DEPTS
    SET department_name = '����', manager_id = null, location_id =1800  
    WHERE department_id = 280;

UPDATE DEPTS
    SET department_name = 'ȸ���', location_id =1800  
    WHERE department_id = 290;

INSERT INTO DEPTS
    (department_id, department_name, manager_id, location_id)
    VALUES 
    (300, '����', 301, 1800);

INSERT INTO DEPTS
    (department_id, department_name, manager_id, location_id)
    VALUES 
    (310, '�λ�', 302, 1800);
    
INSERT INTO DEPTS
    (department_id, department_name, manager_id, location_id)
    VALUES 
    (320, '����', 303, 1700);

--����2-1
UPDATE DEPTS
SET department_name = 'IT bank'
WHERE department_name = 'IT Support';

--����2-2
UPDATE DEPTS
SET manager_id = 301
WHERE department_id = 290;

--����2-3
UPDATE DEPTS
SET department_name ='IT Help', manager_id = 303, location_id = 1800
WHERE department_name = 'IT Helpdesk';

--����2-4 
--ȸ��, ����, �λ�, �������� �Ŵ��� ���̵� 301�� �ϰ� �����ϼ���.
UPDATE DEPTS
SET  manager_id = 301
WHERE department_name IN ('ȸ���', '����', '�λ�', '����'); 

--����3-1
DELETE FROM DEPTS
WHERE department_name = '����';

--����3-2
DELETE FROM DEPTS
WHERE department_name = 'NOC';


--���� 4-1
DELETE FROM DEPTS
WHERE department_id > 200;
SELECT * FROM DEPTS;

--���� 4-2
UPDATE DEPTS
SET manager_id = 100
WHERE manager_id  IS NOT NULL;

--���� 4-4
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

--���� 5-1
CREATE TABLE jobs_it AS
(SELECT * FROM jobs WHERE min_salary > 6000);
SELECT * FROM jobs_it;
--���� 5-2
INSERT INTO jobs_it
    (job_id, job_title, min_salary, max_salary)
    VALUES
    ('IT_DEV', '����Ƽ������', 6000, 20000);

INSERT INTO jobs_it
    (job_id, job_title, min_salary, max_salary)
    VALUES
    ('NET_DEV', '��Ʈ��ũ������', 5000, 20000);

INSERT INTO jobs_it
    (job_id, job_title, min_salary, max_salary)
    VALUES
    ('SEC_DEV', '���Ȱ�����', 6000, 19000);
    
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