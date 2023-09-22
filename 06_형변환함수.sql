
-- �� ��ȯ �Լ� TO_CHAR, TO_NUMBER, TO_DATE

-- ��¥�� ���ڷ� TO_CHAR(��, ����)
SELECT TO_CHAR(sysdate) FROM dual;
SELECT TO_CHAR(sysdate, 'YYYY-MM-DD DY PM HH:MI:SS') FROM dual;
SELECT TO_CHAR(sysdate, 'YYYY-MM-DD DY HH24:MI:SS') FROM dual;

-- ���Ĺ��ڿ� �Բ� ����ϰ� ���� ���ڸ� ""�� ���� �����մϴ�.
SELECT
    first_name, TO_CHAR(hire_date, 'YYYY"��" MM"��" DD"��"')
FROM employees;

-- ���ڸ� ���ڷ� TO_CHAR(��, ����)
-- ���Ŀ��� ����ϴ� '9'�� ���� ���� 9�� �ƴ϶� �ڸ����� ǥ���ϱ� ���� ��ȣ�Դϴ�.
SELECT TO_CHAR(20000, '99999') FROM dual;
-- �־��� �ڸ����� ���ڸ� ��� ǥ���� �� ��� #���� ǥ��˴ϴ�.
SELECT TO_CHAR(20000, '9999') FROM dual;
SELECT TO_CHAR(20000.29, '99999.9') FROM dual;
SELECT TO_CHAR(20000, '99,999') FROM dual;

SELECT TO_CHAR(salary, 'L99,999') As salary
FROM employees;

-- ���ڸ� ���ڷ� TO_NUMBER(��, ����)
SELECT '2000' + 2000 FROM dual; --�ڵ� �� ��ȯ (���� -> ����)
SELECT TO_NUMBER('2000') + 2000 FROM dual; --����� �� ��ȯ
SELECT '$3,300' + 2000 FROM dual;  --���� (�ڵ� �� ��ȯX)
SELECT TO_NUMBER('$3,300', '$9,999') + 2000 FROM dual;

-- ���ڸ� ��¥�� ��ȯ�ϴ� �Լ� TO_DATE(��, ����) ���� ������ ��ġ�ؾ� �մϴ�.
SELECT TO_DATE('2023-04-13') FROM dual;
SELECT sysdate - TO_DATE('2021-03-26') FROM dual;
SELECT TO_DATE('2020/12/25', 'YY-MM-DD') FROM dual;
-- �־��� ���ڿ��� ��� ��ȯ�ؾ� �Ѵ�.
SELECT TO_DATE('2021-03-31 12:23:50','YY-MM-DD HH:MI:SS') FROM dual;

SELECT
    TO_CHAR(
        TO_DATE('20050102', 'YYYYMMDD'),
        'YYYY"��" MM"��" DD"��"'
        ) AS dateInfo
FROM dual ;

-- NULL ���¸� ��ȯ�ϴ� �Լ� NVL(�÷�, ��ȯ�� Ÿ�ٰ�)
--null�� ������ �ȵ˴ϴ�..
SELECT NULL FROM dual;
SELECT NVL(NULL, 0) FROM dual;

SELECT 
    first_name, 
    NVL(commission_pct, 0) AS comm_pct
FROM employees;

-- NULL ��ȯ �Լ� NVL2(�÷�, null�� �ƴ� ����� ��, null�� ����� ��)
--null�� ������ �ȵ˴ϴ�..
SELECT
    NVL2(NULL, '�ξƴ�', '����')
FROM dual;

SELECT
    first_name,
    NVL2(commission_pct, 'true', 'false')
FROM employees;

SELECT
    first_name,
    commission_pct,
    salary,
    NVL2(
    commission_pct,
    salary + (salary*commission_pct),
    salary
    ) As real_salary  
FROM employees;

-- DECODE(�÷� Ȥ�� ǥ����, �׸�1, ���1, �׸�2, ���2 .......... default)
SELECT 
    DECODE('C', 'A', 'A�Դϴ�.', 'B', 'B�Դϴ�.', 'C', 'C�Դϴ�.', '���� �װ�?')
FROM dual;

SELECT
    job_id,
    salary,
    DECODE(
    job_id,
        'IT_PROG', salary*1.1,
        'FI_MGR', salary*1.2,
        'AD_VP', salary*1.3,
        salary
    ) As result
FROM employees;

-- CASE WHEN THEN END
SELECT
    first_name,
    job_id,
    salary,
    (CASE job_id
        WHEN 'IT_PROG' THEN salary*1.1
        WHEN 'FI_MGR' THEN salary*1.2
        WHEN 'AD_VP' THEN salary*1.3
        WHEN 'FI_ACCOUNT' THEN salary*1.4
        ELSE salary
    END) As result
FROM employees;

/*
���� 1.
�������ڸ� �������� employees���̺��� �Ի�����(hire_date)�� �����ؼ� �ټӳ���� 17�� �̻���
����� ������ ���� ������ ����� ����ϵ��� ������ �ۼ��� ������. 
���� 1) �ټӳ���� ���� ��� ������� ����� �������� �մϴ�
*/
SELECT
    employee_id As �����ȣ,
    CONCAT(first_name, last_name) As �����,
    hire_date As �Ի�����,
   TRUNC ((sysdate-hire_date) / 365)  As �ټӳ�� 
FROM employees
WHERE (sysdate-hire_date)/365 >= 17
ORDER BY �ټӳ�� DESC;

/*
���� 2.
EMPLOYEES ���̺��� manager_id�÷��� Ȯ���Ͽ� first_name, manager_id, ������ ����մϴ�.
100�̶�� �������, 
120�̶�� �����ӡ�
121�̶�� ���븮��
122��� �����塯
�������� ���ӿ��� ���� ����մϴ�.
���� 1) department_id�� 50�� ������� ������θ� ��ȸ�մϴ�
*/


SELECT
    first_name,
    manager_id,
    (
    CASE manager_id
        WHEN 100 THEN '���'
        WHEN 120 THEN '����'
        WHEN 121 THEN '�븮'
        WHEN 122 THEN '����'
        ELSE '�ӿ�'
    END) As ����
FROM employees
WHERE department_id =50;


SELECT 
    first_name,
    manager_id,
    DECODE(
        manager_id,
        100, '���',
        120, '����',
        121, '�븮',
        122, '����',
        '�ӿ�'
    ) As ����
FROM employees
WHERE department_id = 50;

















