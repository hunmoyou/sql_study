
-- �׷� �Լ� AVG, MAX, MIN, SUM, COUNT

SELECT
    AVG(salary),
    MAX(salary),
    MIN(salary),
    SUM(salary),
    COUNT(salary)
FROM employees;

SELECT COUNT(*) FROM employees; -- �� �� �������� ��
SELECT COUNT(first_name) FROM employees;
SELECT COUNT(commission_pct) FROM employees; --null�� count�� �ȵȴٰ� ���߽��ϴ� �и���!
SELECT COUNT(manager_id) FROM employees; --null�� �ƴ� ���� ��

-- �μ����� �׷�ȭ, �׷� �Լ��� ���
SELECT
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id;

-- ������ ��
-- �׷� �Լ��� �Ϲ� �÷��� ���ÿ� �׳� ����� ���� �����ϴ�.
SELECT
    department_id,
    AVG(salary)
FROM employees; -- ����

--GROUP BY ���� ����� �� GROUP���� ������ ������ �ٸ� �÷��� ��ȸ�� �� �����ϴ�.
SELECT
    job_id,
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id; --����

--GROUP BY�� 2�� �̻� ���
SELECT
    job_id,
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id;

--GROUP BY�� ���� �׷�ȭ �� �� ������ �� ��� HAVING�� ���.
SELECT
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 100000;

SELECT
    job_id,
    COUNT(*)
FROM employees
GROUP BY job_id
HAVING COUNT(*) >= 5;

-- �μ� ���̵� 50�̻��� �͵��� �׷�ȭ ��Ű��, �׷� ���� ����� 5000 �̻� ��ȸ.
SELECT
    department_id,
    AVG(salary) As ���
FROM employees
WHERE department_id >=50
GROUP BY department_id
HAVING AVG(salary) >= 5000
ORDER BY department_id DESC;

/*
���� 1-1.
��� ���̺��� JOB_ID�� ��� ���� ���ϼ���.
*/
SELECT 
    job_id,
    COUNT(*) As �����
FROM employees
GROUP BY job_id;


/*
���� 1-2
��� ���̺��� JOB_ID�� ������ ����� ���ϼ���. ������ ��� ������ �������� �����ϼ���.
*/
SELECT 
    job_id,
    AVG(salary) As ��տ���   
FROM employees
GROUP BY job_id
ORDER BY AVG(salary)DESC;
/*
���� 2.
��� ���̺��� �Ի� �⵵ �� ��� ���� ���ϼ���.
(TO_CHAR() �Լ��� ����ؼ� ������ ��ȯ�մϴ�. �׸��� �װ��� �׷�ȭ �մϴ�.)
*/
SELECT
    TO_CHAR(hire_date, 'yy') As �Ի�⵵,
    COUNT(*) As �����
FROM employees
GROUP BY TO_CHAR(hire_date, 'yy')
ORDER BY �Ի�⵵ ASC; 

/*
���� 3.
�޿��� 5000 �̻��� ������� �μ��� ��� �޿��� ����ϼ���. 
�� �μ� ��� �޿��� 7000�̻��� �μ��� ����ϼ���.
*/

SELECT
    department_id,
    AVG(salary)
FROM employees
    WHERE salary>5000
    GROUP BY department_id
    HAVING AVG(salary) >= 7000;


/*
���� 4.
��� ���̺��� commission_pct(Ŀ�̼�) �÷��� null�� �ƴ� �������
department_id(�μ���) salary(����)�� ���, �հ�, count�� ���մϴ�.
���� 1) ������ ����� Ŀ�̼��� �����Ų �����Դϴ�.
���� 2) ����� �Ҽ� 2° �ڸ����� ���� �ϼ���.
*/
SELECT
    department_id,
    TRUNC(AVG(salary+(salary*commission_pct)), 2) As avg_salary,
    SUM(salary+(salary*commission_pct)) As sum,
    COUNT(*)
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id;























