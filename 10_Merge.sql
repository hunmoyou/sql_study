
--MERGE: ���̺� ����

/*
UPDATE�� INSERT�� �� �濡 ó��.

�� ���̺� �ش��ϴ� �����Ͱ� �ִٸ� UPDATE��,
������ INSERT�� ó���ض�.
*/

CREATE TABLE emps_it AS (SELECT * FROM employees WHERE 1=2);

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
    VALUES
    (106, '���', '��', 'CHOONSIK', sysdate, 'IT_PROG');
SELECT * FROM emps_it;

SELECT * FROM employees
WHERE job_id = 'IT_PROG';

MERGE INTO emps_it a  --(������ �� Ÿ�� ���̺�)
    USING  --���ս�ų ������
        (SELECT * FROM employees
        WHERE job_id = 'IT_PROG') b --�����ϰ��� �ϴ� �����͸� ���������� ǥ��.
    ON  --���ս�ų �������� ���� ����
        (a.employee_id = b.employee_id)
WHEN MATCHED THEN  --������ ��ġ�ϴ� ��쿡�� Ÿ�� ���̺� �̷��� �����ض�.
    UPDATE SET 
     a.phone_number = b.phone_number,
     a.hire_date = b.hire_date,
     a.salary = b.salary,
     a.commission_pct = b.commission_pct,
     a.manager_id = b.manager_id,
     a.department_id = b.department_id
     
      /*
        DELETE�� �ܵ����� �� ���� �����ϴ�.
        UPDATE ���Ŀ� DELETE �ۼ��� �����մϴ�.
        UPDATE �� ����� DELETE �ϵ��� ����Ǿ� �ֱ� ������
        ������ ��� �÷����� ������ ������ �ϴ� UPDATE�� �����ϰ�
        DELETE�� WHERE���� �Ʊ� ������ ������ ���� �����ؼ� �����մϴ�.
        */
        DELETE
            WHERE a.employee_id = b.employee_id
            
        

WHEN NOT MATCHED THEN 
    INSERT /*�Ӽ�(�÷�)*/VALUES
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);

-------------------------------------------------------------

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(102, '����', '��', 'LEXPARK', '01/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(101, '�ϳ�', '��', 'NINA', '20/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(103, '���', '��', 'HMSON', '20/04/06', 'AD_VP');

/*
employees ���̺��� �Ź� ����ϰ� �����Ǵ� ���̺��̶�� ��������.
������ �����ʹ� email, phone, salary, comm_pct, man_id, dept_id��
������Ʈ �ϵ��� ó��
���� ���Ե� �����ʹ� �״�� �߰�.
*/

MERGE INTO emps_it a
    USING
        (SELECT * FROM employees) b
    ON
        (a.employee_id = b.employee_id)
WHEN MATCHED THEN
    UPDATE SET
         a.email = b.email,
         a.phone_number = b.phone_number,
         a.salary = b.salary,
         a.commission_pct = b.commission_pct,
         a.manager_id = b.manager_id,
         a.department_id = b.department_id

WHEN NOT MATCHED THEN
    INSERT VALUES
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);

SELECT * FROM emps_it
ORDER BY employee_id ASC;

ROLLBACK;















