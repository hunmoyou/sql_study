-- ����Ŭ�� �� �� �ּ��Դϴ�.

/*
���� �� �ּ��Դϴ�.
ȣȣȣ~
*/

-- select [�÷���( � �� ����)] FROM [���̺� �̸�]

SELECT
    *
FROM
    employees;
SELECT employee_id, first_name, last_name
FROM employees;

SELECT email, phone_number, hire_date
From employees;

-- �÷��� ��ȸ�ϴ� ��ġ���� * / + - ������ �����մϴ�.
SELECT 
    employee_id,
    first_name,
    last_name,
    salary,
    salary + salary*0.1 As ������
From employees;

-- NULL ���� Ȯ�� (���� 0�̳� �����̶��� �ٸ� �����Դϴ�.)
SELECT department_id, commission_pct
FROM employees;

-- alias (�÷���, ���̺���� �̸��� �����ؼ� ��ȸ�մϴ�.)
SELECT
    first_name AS �̸�,
    last_name As ��,
    salary As �޿�
From employees;

/*
����Ŭ�� Ȭ����ǥ�� ���ڸ� ǥ���ϰ�, ���ڿ� �ȿ� Ȭ����ǥ��
ǥ���ϰ� �ʹٸ� ''�� �� �� �������� ���ø� �˴ϴ�.
������ �����ϰ� �ʹٸ� || �� ����մϴ�.
*/
SELECT
    first_name ||' '|| last_name || '''s salary is $' || salary
    As �޿�����
From employees;

-- DISTINCT (�ߺ� ���� ����)
SELECT department_id FROM employees;
SELECT DISTINCT department_id FROM employees; 

-- ROWNUM, ROWID
--(**�ο��: ������ ���� ��ȯ�Ǵ� �� ��ȣ�� ���)
--(�ο���̵�: �����ͺ��̽� ���� ���� �ּҸ� ��ȯ)
SELECT ROWNUM, ROWID, employee_id
FROM employees;














    