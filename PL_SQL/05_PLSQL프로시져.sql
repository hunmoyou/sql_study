
-- ���ν���(procedure) -> void �޼��� ����
-- Ư���� ������ ó���ϰ� ������� ��ȯ���� �ʴ� �ڵ� ��� (����)
-- ������ ���ν����� ���ؼ� ���� �����ϴ� ����� �ֽ��ϴ�.

CREATE PROCEDURE guguproc
    (p_dan IN NUMBER)  -- �Ű���
IS  
BEGIN
    dbms_output.put_line(p_dan || '��');
    FOR i IN 1..9
    LOOP
       dbms_output.put_line(p_dan || 'x' || i || '=' || p_dan*i); 
    END LOOP;
END;

EXEC guguproc(5);

-- �Ű���(�μ�) ���� ���ν���
CREATE PROCEDURE p_test
IS --�����
    v_msg VARCHAR2(30) := 'Hello Procedure!';
BEGIN --�����
    dbms_output.put_line(v_msg);
END; --�����

EXEC p_test; --���ν��� ȣ�⹮

-- IN �Է°��� ���� �� ���޹޴� ���ν���
CREATE PROCEDURE my_new_job_proc
    (p_job_id IN jobs.job_id%TYPE,
     p_job_title IN jobs.job_title%TYPE,
     p_min_sal IN jobs.min_salary%TYPE,
     p_max_sal IN jobs.max_salary%TYPE   
    )
IS
BEGIN
    INSERT INTO jobs
    VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    COMMIT;
END;

EXEC my_new_job_proc('JOB2', 'test job2', 20000, 30000);

SELECT * FROM jobs;

-- job_id�� Ȯ���ؼ�
-- �̹� �����ϴ� �����Ͷ�� ����, ���ٸ� ���Ӱ� �߰�(job_id�� pk�̱� ����)
CREATE OR REPLACE PROCEDURE my_new_job_proc --���� ���ν��� ������ ����
    (p_job_id IN jobs.job_id%TYPE,
     p_job_title IN jobs.job_title%TYPE,
     p_min_sal IN jobs.min_salary%TYPE,
     p_max_sal IN jobs.max_salary%TYPE   
    )
IS
    v_cnt NUMBER := 0;
BEGIN
    
    -- ������ job_id�� �ִ������� üũ
    -- �̹� �����Ѵٸ� 1, �������� �ʴ´ٸ� 0 -> v_cnt�� ����.
    SELECT 
        COUNT(*)
    INTO
        v_cnt
    FROM jobs
    WHERE job_id = p_job_id;
    
    IF v_cnt = 0 THEN -- ��ȸ ����� �����ٸ� INSERT
        INSERT INTO jobs
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE -- �ִٸ� UPDATE 
        UPDATE jobs
        SET job_title = p_job_title,
        min_salary = p_min_sal,
        max_salary = p_max_sal
        WHERE job_id = p_job_id;
    END IF;
    COMMIT;   
END;

EXEC my_new_job_proc('JOB4', 'test job4', 8000, 10000);
SELECT * FROM jobs;

-- �Ű���(�μ�)�� ����Ʈ ��(�⺻��) ����
CREATE OR REPLACE PROCEDURE my_new_job_proc --���� ���ν��� ������ ����
    (p_job_id IN jobs.job_id%TYPE,
     p_job_title IN jobs.job_title%TYPE,
     p_min_sal IN jobs.min_salary%TYPE := 0,
     p_max_sal IN jobs.max_salary%TYPE := 1000  
    )
IS
    v_cnt NUMBER := 0;
BEGIN
    
    -- ������ job_id�� �ִ������� üũ
    -- �̹� �����Ѵٸ� 1, �������� �ʴ´ٸ� 0 -> v_cnt�� ����.
    SELECT 
        COUNT(*)
    INTO
        v_cnt
    FROM jobs
    WHERE job_id = p_job_id;
    
    IF v_cnt = 0 THEN -- ��ȸ ����� �����ٸ� INSERT
        INSERT INTO jobs
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE -- �ִٸ� UPDATE 
        UPDATE jobs
        SET job_title = p_job_title,
        min_salary = p_min_sal,
        max_salary = p_max_sal
        WHERE job_id = p_job_id;
    END IF;
    COMMIT;   
END;

EXEC my_new_job_proc('JOB5', 'test job5');
SELECT * FROM jobs;

-----------------------------------------------

-- OUT, IN OUT �Ű����� ���
-- OUT ������ ����ϸ� ���ν��� �ٱ������� ���� �����ϴ�.
-- OUT�� �̿��ؼ� ���� ���� �ٱ� �͸� ��Ͽ��� �����ؾ� �մϴ�.

CREATE OR REPLACE PROCEDURE my_new_job_proc --���� ���ν��� ������ ����
    (p_job_id IN jobs.job_id%TYPE,
     p_job_title IN jobs.job_title%TYPE,
     p_min_sal IN jobs.min_salary%TYPE := 0,
     p_max_sal IN jobs.max_salary%TYPE := 1000,
     p_result OUT VARCHAR2 --�ٱ��ʿ��� ����� �ϱ� ���� ����
    )
IS
    v_cnt NUMBER := 0;
    v_result VARCHAR2(100) := '�������� �ʴ� ���̶� INSERT ó�� �Ǿ����ϴ�.';
BEGIN
    
    -- ������ job_id�� �ִ������� üũ
    -- �̹� �����Ѵٸ� 1, �������� �ʴ´ٸ� 0 -> v_cnt�� ����.
    SELECT 
        COUNT(*)
    INTO
        v_cnt
    FROM jobs
    WHERE job_id = p_job_id;
    
    IF v_cnt = 0 THEN -- ��ȸ ����� �����ٸ� INSERT
        INSERT INTO jobs
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE -- ������ �����ϴ� �����Ͷ�� ��ȸ�� ����� ����.
        SELECT
            p_job_id || '�� �ִ� ����: ' || max_salary || ', �ּ� ����: ' || min_salary
        INTO
            v_result --��ȸ ����� ������ ����
        FROM jobs
        WHERE job_id = p_job_id; 
    END IF;
    
    -- OUT �Ű������� ��ȸ ����� �Ҵ�.
    p_result := v_result;
    
    COMMIT;   
END;

DECLARE
    msg VARCHAR2(100);
BEGIN
    my_new_job_proc('JOB2', 'test_job2', 2000, 8000, msg);    
    dbms_output.put_line(msg);
    
    my_new_job_proc('CEO', 'test_ceo', 20000, 80000, msg); 
    dbms_output.put_line(msg);
END;

SELECT * FROM jobs;

---------------------------------------------------

-- IN, OUT ���ÿ� ó��
CREATE OR REPLACE PROCEDURE my_parameter_test_proc
    (
    -- IN: ��ȯ �Ұ�, �޴� �뵵�θ� Ȱ��
    p_var1 IN VARCHAR2,
    -- OUT: �޴� �뵵�� Ȱ�� �Ұ���.
    -- OUT�� �Ǵ� ������ ���ν����� ���� ��, �� �������� �Ҵ��� �ȵ�.
    p_var2 OUT VARCHAR2,
    -- IN, OUT�� �� �� ������.
    p_var3 IN OUT VARCHAR2
    )
IS

BEGIN
    dbms_output.put_line('p_var1: ' || p_var1); -- IN: �翬�� ��µ�
    dbms_output.put_line('p_var2: ' || p_var2); -- OUT: ���� ���޵��� ����
    dbms_output.put_line('p_var3: ' || p_var3); -- IN OUT: IN�� ������ ������ �ִ�.
    
    --p_var1 := '���1'; IN ������ �� �Ҵ� ��ü�� �Ұ���.
    p_var2 := '���2';
    p_var3 := '���3';
    
END;

DECLARE
    v_var1 VARCHAR2(10) := 'value1';
    v_var2 VARCHAR2(10) := 'value2';
    v_var3 VARCHAR2(10) := 'value3';
BEGIN
    my_parameter_test_proc(v_var1, v_var2, v_var3);
    
    dbms_output.put_line('v_var1: ' || v_var1);
    dbms_output.put_line('v_var2: ' || v_var2);
    dbms_output.put_line('v_var3: ' || v_var3);
END;

-- RETURN
CREATE OR REPLACE PROCEDURE my_new_job_proc --���� ���ν��� ������ ����
    (p_job_id IN jobs.job_id%TYPE,    
     p_result OUT VARCHAR2 
    )
IS
    v_cnt NUMBER := 0;
    v_result VARCHAR2(100) := '�������� �ʴ� ���̶� INSERT ó�� �Ǿ����ϴ�.';
BEGIN
    
   
    SELECT 
        COUNT(*)
    INTO
        v_cnt
    FROM jobs
    WHERE job_id = p_job_id;
    
    IF v_cnt = 0 THEN 
        dbms_output.put_line(p_job_id || '�� ���̺� �������� �ʽ��ϴ�.');
    RETURN; --���ν��� ���� ����.
    END IF;
    
        SELECT
            p_job_id || '�� �ִ� ����: ' || max_salary || ', �ּ� ����: ' || min_salary
        INTO
            v_result --��ȸ ����� ������ ����
        FROM jobs
        WHERE job_id = p_job_id;   
    
    -- OUT �Ű������� ��ȸ ����� �Ҵ�.
    p_result := v_result;
    
    COMMIT;   
END;

DECLARE
    msg VARCHAR2(100);
BEGIN
    my_new_job_proc('merong', msg);
    dbms_output.put_line(msg);
END;

--------------------------------------------------

-- ���� ó��
DECLARE
    v_num NUMBER := 0;
BEGIN
    
    v_num := 10 / 0;
    
    /*
    OTHERS �ڸ��� ������ Ÿ���� �ۼ��� �ݴϴ�.
    ACCESS_INTO_NULL -> ��ü �ʱ�ȭ�� �Ǿ� ���� ���� ���¿��� ���.
    NO_DATA_FOUND -> SELECT INTO �� �����Ͱ� �� �ǵ� ���� ��
    ZERO_DIVIDE -> 0���� ���� ��
    VALUE_ERROR -> ��ġ �Ǵ� �� ����
    INVALID_NUMBER -> ���ڸ� ���ڷ� ��ȯ�� �� ������ ���
    */
    
    EXCEPTION
        WHEN ZERO_DIVIDE THEN
            dbms_output.put_line('0���� �����ø� �ȵǿ�!');
            dbms_output.put_line('SPL ERROR CODE: ' || SQLCODE);
            dbms_output.put_line('SPL ERROR MSG: ' || SQLERRM);
        WHEN OTHERS THEN
            -- WHEN���� ������ ���ܰ� �ƴ� �ٸ� ���ܰ� �߻� �� OTHERS ����.
            dbms_output.put_line('�� �� ���� ���� �߻�!');
    
END;
































