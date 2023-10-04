
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