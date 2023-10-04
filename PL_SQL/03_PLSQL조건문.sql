
-- IF ��
DECLARE
    v_num1 NUMBER := 10;
    v_num2 NUMBER := 15;
BEGIN 
    IF 
      v_num1 > v_num2
    THEN
        dbms_output.put_line(v_num1 || '��(��) ū ��');
    ELSE
        dbms_output.put_line(v_num2 || '��(��) ū ��');
    END IF;

END;

-- ELSIF
DECLARE
    v_salary NUMBER := 0;
    v_department_id NUMBER := 0;
BEGIN
    v_department_id := ROUND(DBMS_RANDOM.VALUE(10,120), -1);
    
    SELECT 
        salary
    INTO 
        v_salary
    FROM employees
    WHERE department_id = v_department_id
    AND ROWNUM = 1; -- ù° ���� ���ؼ� ������ ������ ����
    
    dbms_output.put_line('��ȸ�� �޿�: ' || v_salary);
    
    IF
        v_salary <= 5000
    THEN
        dbms_output.put_line('�޿��� �� ����');
    ELSIF
        v_salary <= 9000
        THEN
        dbms_output.put_line('�޿��� �߰���');
    ELSE
        dbms_output.put_line('�޿��� ����');
    END IF;
END;


-- CASE��
DECLARE
    v_salary NUMBER := 0;
    v_department_id NUMBER := 0;
BEGIN
    v_department_id := ROUND(DBMS_RANDOM.VALUE(10,110), -1); 

    SELECT
        salary
    INTO  -- salary�� v_salary �ȿ� ���� �ִ´�
        v_salary
    FROM employees
    WHERE department_id = v_department_id
    AND ROWNUM = 1; -- ù��° ���� ���ؼ� ������ ������ ����

    dbms_output.put_line('��ȸ�� �޿�: ' || v_salary);

    CASE
        WHEN v_salary <= 5000 THEN
            dbms_output.put_line('�޿��� �� ����');
        WHEN v_salary <= 9000 THEN
            dbms_output.put_line('�޿��� �� �߰���');
        ELSE
            dbms_output.put_line('�޿��� ����');
    END CASE;
END;

-- ��ø IF��

DECLARE
     v_salary NUMBER := 0;
     v_department_id NUMBER := 0;
     v_commission NUMBER := 0;
BEGIN
    v_department_id := ROUND(DBMS_RANDOM.VALUE(10,120), -1);
    
    SELECT 
        salary 
    INTO 
        v_salary, v_commission
    FROM employees
    WHERE department_id = v_department_id
    AND ROWNUM = 1;
    
    IF v_commission > 0 THEN
        IF v_commission > 0.15 THEN
        dbms_output.put_line('Ŀ�̼��� 0.15 �̻���!');
        dbms_output.put_line(v_salary * v_commission);
        END IF;
    ELSE 
        dbms_output.put_line('Ŀ�̼��� 0.15 ������!');
    END IF;
END;





































