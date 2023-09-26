/*
# �������� 
: SQL ���� �ȿ� �Ǵٸ� SQL�� �����ϴ� ���.
  ���� ���� ���Ǹ� ���ÿ� ó���� �� �ֽ��ϴ�.
WHERE, SELECT, FROM ���� �ۼ��� �����մϴ�.
- ���������� ������� () �ȿ� �����.
 ������������ �������� 1�� ���Ͽ��� �մϴ�.
- �������� ������ ���� ����� �ϳ� �ݵ�� ���� �մϴ�.
- �ؼ��� ���� ���������� ���� ���� �ؼ��ϸ� �˴ϴ�.
*/

-- 'Nancy'�� �޿����� �޿��� ���� ����� �˻��ϴ� ����.
SELECT first_name FROM employees
WHERE salary > (SELECT salary FROM employees
                WHERE first_name = 'Nancy');
                
-- employee_id�� 103���� ����� job_id�� ������ job_id�� ���� ����� ��ȸ.
SELECT * FROM employees 
WHERE job_id = (SELECT job_id FROM employees
                WHERE employee_id = 103);

-- ���� ������ ���������� �����ϴ� ���� ���� ���� ������ �����ڸ� ����� �� �����ϴ�.
-- ���� �� ������: �ַ� �� ������(=, >, <, >=, <=, <>)�� ����ϴ� ��� �ϳ��� �ุ ��ȯ�ؾ� �մϴ�.
-- �̷� ��쿡�� ������ �����ڸ� ����ؾ� �մϴ�.
SELECT * FROM employees 
WHERE job_id = (SELECT job_id FROM employees
                WHERE job_id= 'IT_PROG'); --����

-- ���� �� ������ (IN, ANY, ALL)
-- IN: ��ȸ�� ����� � ���� ���� ���� Ȯ���մϴ�.
SELECT * FROM employees 
WHERE job_id IN (SELECT job_id FROM employees
                WHERE job_id= 'IT_PROG');
                
-- first_name�� David�� ������� �޿��� ���� �޿��� �޴� ����� ��ȸ.
SELECT * FROM employees
WHERE salary IN (SELECT salary FROM employees
                WHERE first_name = 'David');
            
-- ANY, SOME: ���� ���������� ���� ���ϵ� ������ ���� ���մϴ�.
-- �ϳ��� �����ϸ� �˴ϴ�.
SELECT * FROM employees
WHERE salary > SOME (SELECT salary FROM employees
                WHERE first_name = 'David');

-- ALL: ���� ���������� ���� ���ϵ� ������ ���� ��� ���ؼ�
-- ��� �����ؾ� �մϴ�.
SELECT * FROM employees
WHERE salary > ALL (SELECT salary FROM employees
                WHERE first_name = 'David')
                ORDER BY salary ASC;

--EXISTS: ���������� �ϳ� �̻��� ���� ��ȯ�ϸ� ������ ����.
--job_history�� �����ϴ� ������ employees���� �����Ѵٸ� ��ȸ�� ����
SELECT * FROM employees e
WHERE EXISTS (SELECT 1 FROM job_history jh 
                WHERE e.employee_id = jh.employee_id);
                
SELECT * FROM employees
WHERE EXISTS (SELECT 1 FROM departments
                WHERE department_id = 10);
                
--------------------------------------------------------------

-- SELECT ���� ���������� ���̱�.
-- ��Į�� �������� ��� Ī�մϴ�.
-- ��Į�� ��������: ���� ����� ���� ���� ��ȯ�ϴ� ��������. �ַ� SELECT���̳�, WHERE ������ ����.
SELECT
    e.first_name,
    d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY first_name ASC;

SELECT
    e.first_name,
    (
    SELECT
        department_name
    FROM departments d
    WHERE d.department_id = e.department_id
    ) As department_name
FROM employees e
ORDER BY first_name ASC;

/*
- ��Į�� ���������� ���κ��� ���� ���
: �Լ�ó�� �� ���ڵ�� ��Ȯ�� �ϳ��� ������ ������ ��.

- ������ ��Į�� ������������ ���� ���
: ��ȸ�� �����Ͱ� ��뷮�� ���, �ش� �����Ͱ�
����, ���� ���� ����� ��� (sql �������� ������ �� �� �پ�ϴ�.)
*/

-- �� �μ��� �Ŵ��� �̸� ��ȸ
-- LEFT JOIN
SELECT
    d.*,
    e.first_name
FROM departments d
LEFT JOIN employees e
ON d.manager_id = e.employee_id
ORDER BY d.manager_id ASC;

--SELECT�� ��������(��Į��)
SELECT
    d.*,
    (
        SELECT
            first_name
        FROM employees e
        WHERE e.employee_id = d.manager_id
    ) As manager_name
FROM departments d
ORDER BY d.manager_id ASC;

-- �� �μ��� ��� �� �̱�
SELECT 
    d.*,
    (
        SELECT 
            COUNT(*)
        FROM employees e
        WHERE e.department_id = d.department_id
        GROUP BY department_id
    ) As �����
FROM departments d;
--------------------------------------------------------

-- �ζ��� �� (FROM ������ ���������� ���� ��.)
-- Ư�� ���̺� ��ü�� �ƴ� SELECT�� ���� �Ϻ� �����͸� ��ȸ�� ���� ���� ���̺�� ����ϰ� ���� ��.
-- ������ ���س��� ��ȸ �ڷḦ ������ �����ؼ� �������� ���.

-- salary�� ������ �����ϸ鼭 �ٷ� ROWNUM�� ���̸�
-- ROWNUM�� ������ ���� �ʴ� ��Ȳ�� �߻��մϴ�.
-- ����: ROWNUM�� ���� �ٰ� ������ ����Ǳ� ����. ORDER BY�� �׻� �������� ����.
-- �ذ�: ������ �̸� ����� �ڷῡ ROWNUM�� �ٿ��� �ٽ� ��ȸ�ϴ� ���� ���� �� ���ƿ�.
SELECT 
    ROWNUM As rn, employee_id, first_name, salary
FROM employees
ORDER BY salary DESC;


SELECT ROWNUM As rn, tbl.*
FROM (
        SELECT 
            employee_id, first_name, salary
        FROM employees
        ORDER BY salary DESC
        ) tbl
WHERE rn > 20 AND rn <= 30;

/*
���� ���� SELECT ������ �ʿ��� ���̺� ����(�ζ��� ��)�� ����.
�ٱ��� SELECT ������ ROWNUM�� �ٿ��� �ٽ� ��ȸ
���� �ٱ��� SELECT �������� �̹� �پ��ִ� ROWNUM�� ������ �����ؼ� ��ȸ.

** SQL�� ���� ����
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
*/

SELECT * FROM  --�Խ��� ������ Ȱ��
    (
    SELECT ROWNUM As rn, tbl.*
        FROM (
            SELECT 
                employee_id, first_name, salary
            FROM employees
            ORDER BY salary DESC
         ) tbl
    )
WHERE rn > 0 AND rn <= 10;


























