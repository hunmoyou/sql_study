
-- insert
-- ���̺� ���� Ȯ��
DESC departments;

-- insert�� ù��° ��� (����÷� �����͸� �� ���� ����)
INSERT INTO departments
VALUES(300, '���ߺ�');

SELECT * FROM departments; 
ROLLBACK; --���� ������ �ٽ� �ڷ� �ǵ����� Ű����

-- INSERT�� �ι�° ��� (���� �÷��� �����ϰ� ����, not null Ȯ���ϼ���!)
INSERT INTO departments
    (department_id,  location_id)
VALUES
    (300,  1700);
    
-- �纻 ���̺� ����
-- �纻 ���̺��� ������ �� �׳� �����ϸ� -> ��ȸ�� �����ͱ��� ��� ����
-- WHERE���� false�� (1=2) �����ϸ� -> ���̺��� ������ ����ǰ� �����ʹ� ����x
CREATE TABLE emps AS  --ctas
(SELECT employee_id, first_name, job_id, hire_date
FROM employees WHERE 1 = 2);  

SELECT * FROM emps;
DROP TABLE emps;

-- INSERT (��������)
INSERT INTO emps 
(SELECT employee_id, first_name, job_id, hire_date
FROM employees WHERE department_id = 50);

-----------------------------------------------------------
-- UPDATE 
CREATE TABLE emps AS  
(SELECT * FROM employees);

SELECT * FROM emps;

--UPDATE�� ������ ���� ������ ������ �� �� �����ؾ� �մϴ�.
-- �׷��� ������ ���� ����� ���̺� ��ü�� ����˴ϴ�.
UPDATE emps SET salary = 30000;
ROLLBACK;

UPDATE emps SET salary = 30000
WHERE employee_id = 100;
SELECT * FROM emps;

UPDATE emps SET salary = salary + salary * 0.1
WHERE employee_id = 100;

UPDATE emps
SET phone_number = '010.1234.5678', manager_id = 102
WHERE employee_id = 100;

--UPDATE (��������)
UPDATE emps
    SET (job_id, salary, manager_id) = 
    (
        SELECT job_id, salary, manager_id
        FROM emps
        WHERE employee_id = 100
    )
WHERE employee_id = 101;

SELECT * FROM emps;

-------------------------------------------------

-- DELETE
DELETE FROM emps
WHERE employee_id = 103;
ROLLBACK;

-- DELETE (��������)
DELETE FROM emps
WHERE department_id = (SELECT department_id FROM departments
                        WHERE department_name = 'IT');

