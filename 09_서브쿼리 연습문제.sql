/*
���� 1.
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� 
(AVG(�÷�) ���)

-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
-EMPLOYEES ���̺��� job_id�� IT_PROG�� ������� ��ձ޿����� ���� ������� 
�����͸� ����ϼ���
*/   
    
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT COUNT(*)
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
       
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees
                WHERE job_id = 'IT_PROG');     

/*
���� 2.
-DEPARTMENTS���̺��� manager_id�� 100�� �μ��� �����ִ� �������
��� ������ ����ϼ���.
*/   
SELECT * FROM employees
WHERE department_id = (SELECT department_id FROM departments
                        WHERE manager_id = 100);

    SELECT *
    FROM departments d
    JOIN employees e
    ON d.department_id = e.department_id
    WHERE d.manager_id = 100; 

    
/*
���� 3.
-EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� 
����ϼ���
-EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
*/
SELECT * FROM employees
WHERE manager_id > (SELECT manager_id FROM employees 
                    WHERE first_name = 'Pat');

SELECT * FROM employees
WHERE manager_id IN (SELECT manager_id FROM employees
                        WHERE first_name = 'James');

/*
���� 4.
-EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� 
�� ��ȣ, �̸��� ����ϼ���
*/
SELECT * FROM
(
    SELECT ROWNUM As rn, tbl.first_name
        FROM
        (
            SELECT * FROM employees
            ORDER BY first_name DESC
         ) tbl
)
WHERE rn > 40 AND rn <= 50; -- =WHERE rn BETEEN 41 AND 50;
/*
���� 5.
-EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� 
�� ��ȣ, ���id, �̸�, ��ȣ, �Ի����� ����ϼ���.
*/
SELECT * FROM
    (
    SELECT ROWNUM As rn, tbl.*
        FROM
        (
            SELECT 
                employee_id, first_name, phone_number, hire_date 
            FROM employees
            ORDER BY hire_date ASC
         ) tbl
    )
WHERE rn  BETWEEN 31 AND 40;

/*
���� 6.
employees���̺� departments���̺��� left �����ϼ���
����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
����) �������̵� ���� �������� ����
*/
SELECT 
    e.employee_id, CONCAT(e.first_name, e.last_name) As full_name,
    d.department_id, d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY employee_id ASC;
/*
���� 7.
���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/

SELECT
    e.employee_id, 
    CONCAT(e.first_name, e.last_name) As full_name,
    e.department_id,
    (
        SELECT
        department_name
        FROM departments d
        WHERE e.department_id = d.department_id
    ) As department_name
FROM employees e
ORDER BY employee_id ASC;

/*
���� 8.
departments���̺� locations���̺��� left �����ϼ���
����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
����) �μ����̵� ���� �������� ����
*/
SELECT
    d.department_id, d.department_name, d.manager_id, d.location_id, 
    loc.street_address, loc.postal_code, loc.city
FROM departments d
LEFT JOIN locations loc
ON d.location_id = loc.location_id
ORDER BY department_id ASC;

/*
���� 9.
���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
SELECT
    d.department_id, d.department_name, d.manager_id, d.location_id,
    (
    SELECT
        loc.street_adress
    FROM locations loc
    WHERE loc.location_id = d.location_id
    ) As street_adress
    (
    SELECT
        loc.postal_code
    FROM locations loc
    WHERE loc.location_id = d.location_id
    ) As postal_code
    (
    SELECT
        loc.city
    FROM locations loc
    WHERE loc.location_id = d.location_id
    ) As city
FROM departments d  -- ����
ORDER BY department_id ASC;


/*
���� 10.
locations���̺� countries ���̺��� left �����ϼ���
����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
����) country_name���� �������� ����
*/
SELECT 
    loc.location_id, loc.street_address, loc.city,
    c.country_id, c.country_name
FROM locations loc
LEFT JOIN countries c
ON loc.country_id = c.country_id
ORDER BY c.country_name ASC;
/*
���� 11.
���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
SELECT
   loc.location_id, loc.street_address, loc.city, loc.country_id,
    (
    SELECT
        country_name
    FROM countries c
    WHERE c.country_id = loc.country_id
    )As country_name
FROM locations loc
ORDER BY country_name ASC;

/*
���� 12. 
employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 
1-10��° �����͸� ����մϴ�.
����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, 
�μ����̵�, �μ��̸� �� ����մϴ�.
����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.
*/
SELECT * FROM
(
    SELECT ROWNUM AS rn, a.*
        FROM
        (
        SELECT 
            e.employee_id, e.first_name, e.phone_number,
            e.hire_date, d.department_id, d.department_name
        FROM employees e LEFT JOIN departments d
        ON e.department_id = d.department_id
        ORDER BY hire_date ASC
        ) a
   ) 
WHERE rn > 0 AND rn <= 10;

SELECT * FROM
(
    SELECT ROWNUM As rn, tbl.*
        FROM
        (
        SELECT
             e.employee_id, e.first_name, e.phone_number, e.hire_date, d.department_id, d.department_name
        FROM employees e
        LEFT JOIN departments d
        ON e.department_id = d.department_id
        ORDER BY hire_date ASC
        ) tbl
    )
WHERE rn BETWEEN 1 AND 10;
/*
���� 13. 
--EMPLOYEES �� DEPARTMENTS ���̺��� JOB_ID�� SA_MAN ����� ������ LAST_NAME, JOB_ID, 
DEPARTMENT_ID,DEPARTMENT_NAME�� ����ϼ���.
*/
SELECT 
    e.last_name, e.job_id, d.department_id, d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE job_id = 'SA_MAN';

SELECT
    tbl.*, d.department_name
FROM
    (
    SELECT 
        last_name, job_id, department_id
    FROM employees 
    WHERE job_id = 'SA_MAN'   
    )tbl
JOIN departments d
ON tbl.department_id = d.department_id;
    
    
/*
���� 14
--DEPARTMENT���̺��� �� �μ��� ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
--�ο��� ���� �������� �����ϼ���.
--����� ���� �μ��� ������� ���� �ʽ��ϴ�.
*/
SELECT 
    d.department_id, d.department_name, d.manager_id,
    a.total
FROM departments d
JOIN
    (
    SELECT 
        department_id, COUNT(*) AS total
    FROM employees 
    GROUP BY department_id
    )a
ON d.department_id = a.department_id
ORDER BY a.total DESC;

SELECT 
     d.department_id, d.department_name, d.manager_id,
     (
        SELECT
            COUNT(*) 
        FROM employees e
        WHERE e.department_id = d.department_id
    ) As total
FROM departments d
WHERE d.manager_id IS NOT NULL
ORDER BY total DESC;

SELECT 
    d.department_id, d.department_name, d.manager_id,
    (
    SELECT
        COUNT(*)
    FROM employees e
    WHERE e.department_id = d.department_id
    ) As �ο���     
    FROM departments d;   
    
    
SELECT
     d.department_id, d.department_name, d.manager_id,
     COUNT(*) As �����
FROM departments d
JOIN employees e
ON d.department_id = e.department_id
GROUP BY  d.department_id, d.department_name, d.manager_id;

/*
���� 15
--�μ��� ���� ���� ���ο�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���.
--�μ��� ����� ������ 0���� ����ϼ���.
*/
SELECT
    d.*, 
    loc.street_address, loc.postal_code,
    NVL(tbl.result, 0) As result
FROM departments d
JOIN locations loc
ON d.location_id = loc.location_id
LEFT JOIN 
    (
    SELECT
        department_id,
        TRUNC(AVG(salary), 0) AS result
    FROM employees
    GROUP BY department_id
    )tbl
ON d.department_id = tbl.department_id;

SELECT 
    d.*,
    loc.street_address, loc.postal_code,
    NVL(
        (   
        SELECT TRUNC(AVG(e.salary), 0)
        FROM employees e
        WHERE e.department_id = d.department_id
    ),
    0) As �μ�����ձ޿�
FROM departments d
JOIN locations loc
ON d.department_id = loc.department_id;
/*
���� 16
-���� 15 ����� ���� DEPARTMENT_ID�������� �������� �����ؼ� 
ROWNUM�� �ٿ� 1-10 ������ ������ ����ϼ���.
*/
SELECT * FROM
    (
        SELECT ROWNUM AS rn, tbl2.*
        FROM
        (
        SELECT
            d.*, 
            loc.street_address, loc.postal_code,
            NVL(tbl.result, 0) As result
        FROM departments d
        JOIN locations loc
        ON d.location_id = loc.location_id
        LEFT JOIN 
            (
            SELECT
                department_id,
                TRUNC(AVG(salary), 0) AS result
            FROM employees
            GROUP BY department_id
            )tbl
        ON d.department_id = tbl.department_id
        ORDER BY d.department_id DESC
        )tbl2
    )
    WHERE rn > 0 AND rn <= 10;