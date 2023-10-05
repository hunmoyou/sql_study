
/*
���ν����� divisor_proc
���� �ϳ��� ���޹޾� �ش� ���� ����� ������ ����ϴ� ���ν����� �����մϴ�.
*/

/*
 --v_department_id := ROUND(DBMS_RANDOM.VALUE(10,120), -1);
CREATE PROCEDURE divisor_proc
    (p_num IN NUMBER)
IS
    p_nnum NUMBER:= 2;
    p_count NUMBER := 0;
BEGIN
    dbms_output.put_line(p_num || '�� ����� ����');
    WHILE MOD(p_num, p_nnum)
  */      
    
--END;

CREATE PROCEDURE divisor_proc
    (p_num IN NUMBER)
IS 
    v_count NUMBER := 0;
BEGIN
    FOR i IN 1..p_num
    LOOP 
        IF MOD(p_num, i) = 0 THEN
            v_count := v_count +1;
        END IF;
    END LOOP;
    
    dbms_output.put_line('����� ����: ' || v_count);
END;

EXEC divisor_proc(72);

/*
�μ���ȣ, �μ���, �۾� flag(I: insert, U:update, D:delete)�� �Ű������� �޾� 
depts ���̺� 
���� INSERT, UPDATE, DELETE �ϴ� depts_proc �� �̸��� ���ν����� ������.
�׸��� ���������� commit, ���ܶ�� �ѹ� ó���ϵ��� ó���ϼ���.
*/

CREATE OR REPLACE PROCEDURE depts_proc
    (
    p_department_id IN depts.department_id%TYPE,
    p_department_name IN depts.department_name%TYPE,
    p_flag IN VARCHAR2
    )
IS
    v_cnt NUMBER := 0;
BEGIN
    
    SELECT 
        COUNT(*)
    INTO 
        v_cnt
    FROM depts
    WHERE department_id = p_department_id;
    
    IF p_flag = 'I' THEN
        INSERT INTO depts
        (department_id, department_name)
        VALUES(p_department_id, p_department_name);
    ELSIF p_flag = 'U' THEN
        UPDATE depts
        SET department_name = p_department_name
        WHERE department_id = p_department_id;
    ELSIF p_flag = 'D' THEN
        IF v_cnt = 0 THEN
            dbms_output.put_line('�����ϰ��� �ϴ� �μ��� �������� �ʽ��ϴ�.');
            RETURN;
        END IF;
        
        DELETE FROM depts
        WHERE department_id = p_department_id;
    ELSE
        dbms_output.put_line('�ش� flag�� ���� ������ �غ���� �ʾҽ��ϴ�.');   
    END IF;
    
    COMMIT;
    
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line('���ܰ� �߻��߽��ϴ�.');
        dbms_output.put_line('ERROR MSG: ' || SQLERRM);
        ROLLBACK;
END;

EXEC depts_proc(700, '������', 'D');

SELECT * FROM depts;
/*
CREATE PROCEDURE depts_proc
    (
        p_dept_id IN depts.department_id%TYPE,
        p_dept_name IN depts.department_name%TYPE,
        p_dept_flag IN VARCHAR2
    )
IS 

BEGIN
    CASE p_dept_flag := 'I' THEN
    INSERT INTO depts
    VALUES(p_dept_id, p_dept_name);
    CASE p_dept_flag := 'U' THEN
    UPDATE depts
    SET 
    WHERE p_depts_flag := ''
    CASE p_dept_flag := 'D' THEN
    
    END CASE;
END;
*/

/*
employee_id�� �Է¹޾� employees�� �����ϸ�,
�ټӳ���� out�ϴ� ���ν����� �ۼ��ϼ���. (�͸��Ͽ��� ���ν����� ����)
���ٸ� exceptionó���ϼ���
*/

CREATE OR REPLACE PROCEDURE emp_hire_proc
    (
        p_employee_id IN employees.employee_id%TYPE,
        p_year OUT NUMBER
    )
IS
    v_hire_date employees.hire_date%TYPE;
BEGIN
    SELECT
        hire_date
    INTO
        v_hire_date
    FROM employees
    WHERE employee_id = p_employee_id;
    
    p_year := TRUNC((sysdate - v_hire_date) / 365);
    
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line(p_employee_id || '��(��) ���� ������ �Դϴ�.');
    
END;

DECLARE
    v_year NUMBER;
BEGIN
    emp_hire_proc(333, v_year);
    dbms_output.put_line(v_year || '��');
END;

/*
SELECT  hire_date, TRUNC( (sysdate - hire_date ) / 365, 0) 
FROM employees; 

CREATE PROCEDURE emp_proc
    (
       p_emp_hdate IN OUT employees.employee_id%TYPE 
    )
    
IS
    
BEGIN
    
    SELECT
        hire_date, TRUNC( (sysdate - hire_date ) / 365, 0)
    INTO 
        p_emp_hdate        
    FROM employees
    WHERE hire_date = p_emp_hdate;   
    
END;

DECLARE
    
BEGIN
    
END;
*/


/*
���ν����� - new_emp_proc
employees ���̺��� ���� ���̺� emps�� �����մϴ�.
employee_id, last_name, email, hire_date, job_id�� �Է¹޾�
�����ϸ� �̸�, �̸���, �Ի���, ������ update, 
���ٸ� insert�ϴ� merge���� �ۼ��ϼ���

������ �� Ÿ�� ���̺� -> emps
���ս�ų ������ -> ���ν����� ���޹��� employee_id�� dual�� select ������ ��.
���ν����� ���޹޾ƾ� �� ��: ���, last_name, email, hire_date, job_id
*/
CREATE OR REPLACE PROCEDURE new_emp_proc    (
    p_employee_id IN emps.employee_id%TYPE,
    p_last_name IN emps.last_name%TYPE,
    p_email IN emps.email%TYPE,
    p_hire_date IN emps.hire_date%TYPE,
    p_job_id IN emps.job_id%TYPE
)
IS
    
BEGIN
    MERGE INTO emps a -- ������ �� Ÿ�� ���̺� 
    USING 
        (SELECT p_employee_id AS employee_id FROM dual) b
    ON 
        (a.employee_id = b.employee_id) --���޹��� ����� emps�� �����ϴ� ���� ���� �������� ���.
    
    WHEN MATCHED THEN
        UPDATE SET 
            a.last_name = p_last_name,
            a.email = p_email,
            a.hire_date = p_hire_date,
            a.job_id = p_job_id
    
    WHEN NOT MATCHED THEN
        INSERT(a.employee_id, a.last_name, a.email, a.hire_date, a.job_id)
        VALUES(p_employee_id, p_last_name, p_email, p_hire_date, p_job_id);
END;

EXEC new_emp_proc(100, 'kim','kim1234', '2023-04-24', 'test2');
SELECT * FROM emps;










