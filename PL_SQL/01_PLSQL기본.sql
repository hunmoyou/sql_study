
/*
# PL/SQL
- 오라클에서 제공하는 SQL 프로그래밍 기능이다.
- 일반적인 프로그래밍과는 차이가 있지만, 오라클 내부에서 적절한 처리를 위해
 적용해 줄 수 있는 절차지향적 코드 작성 방식입니다.
- 쿼리문의 집합으로 어떠한 동작을 일괄 처리하기 위한 용도로 사용합니다.
*/

SET SERVEROUTPUT ON; --출력문 활성화

DECLARE  -- 변수를 선언하는 구간(선언부)

    emp_num NUMBER;
    
BEGIN -- 코드를 실행하는 시작 구간 (실행부)
    
    emp_num := 10;  -- 오라클 대입연산자 := 
     DBMS_OUTPUT.put_line(emp_num);
     DBMS_OUTPUT.put_line('Hello pl/sql~!');
     DBMS_OUTPUT.put_line('강희수가 누구야');
     DBMS_OUTPUT.put_line('강희수는 나쁜 사람이었어');
     
END; -- PL/SQL이 끝나는 구간 (종료부)

-- 연산자
-- 일반 SQL 문의 모든 연산자의 사용이 가능하고,
-- **는 제곱을 의미합니다.

DECLARE
    A NUMBER := 2**2*3**2; 
BEGIN
     DBMS_OUTPUT.put_line('A: ' || TO_CHAR(A));
END;



/*
- DML문
DDL문은 사용이 불가능하고, 일반적으로 SQL문의 SELECT 등을 사용하는데, 
특이한 점은 SELECT절 아래에 INTO절을 사용해서 변수에 할당할 수 있습니다.
*/

DECLARE
    v_emp_name VARCHAR2(50); --사원명 변수 (문자열 변수는 길이제약 필요)
    v_dep_name VARCHAR2(50); --부서명 변수
BEGIN
    SELECT 
        e.first_name,
        d.department_name
    INTO
        v_emp_name, -- 조회 결과를 변수에 대입
        v_dep_name
    FROM employees e 
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    WHERE employee_id = 100;
    
    DBMS_OUTPUT.put_line(v_emp_name || '-' || v_dep_name);
    
END;

-- 해당 테이블과 같은 타입의 컬럼 변수를 선언하려면
-- 테이블명.컬럼명%TYPE을 사용함으로써 타입을 일일히 확인해야 하는 번거로움을 방지할 수 있다.

DECLARE
    v_emp_name employees.first_name%TYPE;
    v_dep_name departments.department_name%TYPE;
BEGIN
    SELECT 
        e.first_name,
        d.department_name
    INTO
        v_emp_name, v_dep_name -- 조회 결과를 변수에 대입
    FROM employees e 
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    WHERE employee_id = 100;
    
    DBMS_OUTPUT.put_line(v_emp_name || '-' || v_dep_name);
    
END;






















