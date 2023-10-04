
-- IF 문
DECLARE
    v_num1 NUMBER := 10;
    v_num2 NUMBER := 15;
BEGIN 
    IF 
      v_num1 > v_num2
    THEN
        dbms_output.put_line(v_num1 || '이(가) 큰 수');
    ELSE
        dbms_output.put_line(v_num2 || '이(가) 큰 수');
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
    AND ROWNUM = 1; -- 첫째 값만 구해서 변수에 저장할 예정
    
    dbms_output.put_line('조회된 급여: ' || v_salary);
    
    IF
        v_salary <= 5000
    THEN
        dbms_output.put_line('급여가 좀 낮음');
    ELSIF
        v_salary <= 9000
        THEN
        dbms_output.put_line('급여가 중간임');
    ELSE
        dbms_output.put_line('급여가 높음');
    END IF;
END;


-- CASE문
DECLARE
    v_salary NUMBER := 0;
    v_department_id NUMBER := 0;
BEGIN
    v_department_id := ROUND(DBMS_RANDOM.VALUE(10,110), -1); 

    SELECT
        salary
    INTO  -- salary를 v_salary 안에 집어 넣는다
        v_salary
    FROM employees
    WHERE department_id = v_department_id
    AND ROWNUM = 1; -- 첫번째 값만 구해서 변수에 지정할 예정

    dbms_output.put_line('조회된 급여: ' || v_salary);

    CASE
        WHEN v_salary <= 5000 THEN
            dbms_output.put_line('급여가 좀 낮음');
        WHEN v_salary <= 9000 THEN
            dbms_output.put_line('급여가 좀 중간임');
        ELSE
            dbms_output.put_line('급여가 높음');
    END CASE;
END;

-- 중첩 IF문

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
        dbms_output.put_line('커미션이 0.15 이상임!');
        dbms_output.put_line(v_salary * v_commission);
        END IF;
    ELSE 
        dbms_output.put_line('커미션이 0.15 이하임!');
    END IF;
END;





































