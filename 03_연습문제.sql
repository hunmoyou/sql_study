--1. ��� ����� �����ȣ, �̸�, �Ի���, �޿��� ����ϼ���.
SELECT
employee_id,
first_name, 
hire_date, 
salary
FROM employees;

--2. ��� ����� �̸��� ���� �ٿ� ����ϼ���. �� ��Ī�� name���� �ϼ���.
SELECT
first_name || ' ' || last_name AS name 
FROM employees;
--3. 50�� �μ� ����� ��� ������ ����ϼ���.
SELECT *
FROM employees
WHERE department_id = 50;

--4. 50�� �μ� ����� �̸�, �μ���ȣ, �������̵� ����ϼ���.
SELECT
first_name,
employee_id,
job_id  
FROM employees 
WHERE department_id = 50;

--5. ��� ����� �̸�, �޿� �׸��� 300�޷� �λ�� �޿��� ����ϼ���.
SELECT 
    first_name, salary, salary+300 As pay
FROM employees;

--6. �޿��� 10000���� ū ����� �̸��� �޿��� ����ϼ���.
SELECT
    first_name, salary 
FROM employees 
WHERE salary > 10000;

--7. ���ʽ��� �޴� ����� �̸��� ����, ���ʽ����� ����ϼ���.
SELECT
    first_name, job_id, commission_pct
FROM employees 
WHERE commission_pct IS NOT NULL;

--8. 2003�⵵ �Ի��� ����� �̸��� �Ի��� �׸��� �޿��� ����ϼ���.(BETWEEN ������ ���)
SELECT 
    first_name, hire_date, salary 
FROM employees 
WHERE hire_date BETWEEN '03/01/01' AND '03/12/31';

--9. 2003�⵵ �Ի��� ����� �̸��� �Ի��� �׸��� �޿��� ����ϼ���.(LIKE ������ ���)
SELECT 
    first_name, hire_date, salary 
FROM employees 
WHERE hire_date LIKE '03%';

--10. ��� ����� �̸��� �޿��� �޿��� ���� ������� ���� ��������� ����ϼ���.
SELECT 
    first_name, salary 
FROM employees 
ORDER BY salary DESC;

--11. �� ���Ǹ� 60�� �μ��� ����� ���ؼ��� �����ϼ���. (�÷�: department_id)
SELECT 
    first_name, salary
FROM employees 
WHERE department_id = 60 
ORDER BY salary DESC; 

--12. �������̵� IT_PROG �̰ų�, SA_MAN�� ����� �̸��� �������̵� ����ϼ���.
SELECT 
    first_name, job_id
FROM employees 
WHERE job_id = 'IT_PROG' 
OR job_id='SA_MAN';

--13. Steven King ����� ������ ��Steven King ����� �޿��� 24000�޷� �Դϴ١� �������� ����ϼ���.
SELECT
    first_name || ' ' || last_name || ' ����� �޿��� ' || salary || '�Դϴ�.' As test
FROM employees 
WHERE first_name = 'Steven'
AND last_name = 'King';

--14. �Ŵ���(MAN) ������ �ش��ϴ� ����� �̸��� �������̵� ����ϼ���. (�÷�:job_id)
SELECT
    first_name, job_id
FROM employees
WHERE job_id LIKE '%MAN';

--15. �Ŵ���(MAN) ������ �ش��ϴ� ����� �̸��� �������̵� �������̵� ������� ����ϼ���.
SELECT
    first_name, job_id
FROM employees
WHERE job_id LIKE '%MAN'
ORDER BY job_id;

