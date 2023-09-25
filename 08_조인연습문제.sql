/*
���� 1.
-EMPLOYEES ���̺��, DEPARTMENTS ���̺��� DEPARTMENT_ID�� ����Ǿ� �ֽ��ϴ�.
-EMPLOYEES, DEPARTMENTS ���̺��� ������� �̿��ؼ�
���� INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER ���� �ϼ���. (�޶����� ���� ���� �ּ����� Ȯ��)
*/
SELECT
 *
FROM employees e
FULL OUTER JOIN departments d 
ON e.department_id = d.department_id;
-- LEFT - 107 right 122 
-- inner 106  full 123



/*
���� 2.
-EMPLOYEES, DEPARTMENTS ���̺��� INNER JOIN�ϼ���
����)employee_id�� 200�� ����� �̸�, department_id�� ����ϼ���
����)�̸� �÷��� first_name�� last_name�� ���ļ� ����մϴ�
*/
SELECT
   CONCAT(first_name,last_name), e.department_id
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE employee_id = 200;
/*
���� 3.
-EMPLOYEES, JOBS���̺��� INNER JOIN�ϼ���
����) ��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ�, �̸� �������� �������� ����
HINT) � �÷����� ���� ����Ǿ� �ִ��� Ȯ��
*/
SELECT
    e.first_name,
    e.department_id,
    j.job_title
FROM
employees e
JOIN jobs j
ON e.job_id = j.job_id
ORDER BY e.first_name ASC;
/*
���� 4.
--JOBS���̺�� JOB_HISTORY���̺��� LEFT_OUTER JOIN �ϼ���.
*/
SELECT
 *
FROM jobs j
LEFT OUTER JOIN job_history jh
ON j.job_id = jh.job_id;
/*
���� 5.
--Steven King�� �μ����� ����ϼ���.
*/
SELECT
 e.first_name || ' ' || e.last_name As full_name,
 d.department_name
FROM
employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE last_name = 'King'
AND first_name = 'Steven';
/*
���� 6.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian Product(Cross join)ó���ϼ���
*/
SELECT *FROM employees e 
CROSS JOIN departments d;

SELECT * FROM employees, departments;

/*
���� 7.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ� SA_MAN ������� �����ȣ, �̸�, 
�޿�, �μ���, �ٹ����� ����ϼ���. (Alias�� ���)
*/
SELECT
    e.employee_id As �����ȣ, 
    e.first_name As �̸�,
    salary As �޿�,
    d.department_name As �μ���,
    loc.city As �ٹ���
FROM employees e
JOIN departments d 
ON e.department_id = d.department_id
JOIN locations loc
ON d.location_id = loc.location_id
WHERE job_id = 'SA_MAN';
/*
���� 8.
-- employees, jobs ���̺��� ���� �����ϰ� job_title�� 'Stock Manager', 'Stock Clerk'�� 
���� ������ ����ϼ���.
*/
SELECT
    *
FROM employees e
JOIN jobs j
ON e.job_id = j.job_id
WHERE job_title = 'Stock Manager' --WHERE job_title IN('Stock Manager', 'Stock Clerk');
OR job_title = 'Stock Clerk';
/*
���� 9.
-- departments ���̺��� ������ ���� �μ��� ã�� ����ϼ���. LEFT OUTER JOIN ���
*/
SELECT
    d.department_name
FROM departments d
LEFT OUTER JOIN employees e
ON d.department_id = e.department_id
WHERE e.employee_id is null;  
/*
���� 10. 
-join�� �̿��ؼ� ����� �̸��� �� ����� �Ŵ��� �̸�?�� ����ϼ���
��Ʈ) EMPLOYEES ���̺�� EMPLOYEES ���̺��� �����ϼ���. 
*/
SELECT
    e1.manager_id, 
    e2.first_name As manager_name
    
FROM employees e1
JOIN employees e2
ON e1.manager_id = e2.employee_id;
/*
���� 11. 
-- EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)��, �Ŵ����� �̸�, �Ŵ����� �޿� ���� ����ϼ���
--�Ŵ��� ���̵� ���� ����� �����ϰ� �޿��� �������� ����ϼ��� 
*/
SELECT
    e1.employee_id,  e1.first_name, e1.manager_id, 
    e2.first_name As manager_name, e2.salary
FROM employees e1
LEFT JOIN employees e2
ON e1.manager_id = e2.employee_id
WHERE e1.manager_id IS NOT NULL
ORDER BY e2.salary DESC;
