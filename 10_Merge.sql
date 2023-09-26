
--MERGE: 테이블 병합

/*
UPDATE와 INSERT를 한 방에 처리.

한 테이블에 해당하는 데이터가 있다면 UPDATE를,
없으면 INSERT로 처리해라.
*/

CREATE TABLE emps_it AS (SELECT * FROM employees WHERE 1=2);

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
    VALUES
    (106, '춘식', '김', 'CHOONSIK', sysdate, 'IT_PROG');
SELECT * FROM emps_it;

SELECT * FROM employees
WHERE job_id = 'IT_PROG';

MERGE INTO emps_it a  --(머지를 할 타겟 테이블)
    USING  --병합시킬 데이터
        (SELECT * FROM employees
        WHERE job_id = 'IT_PROG') b --병합하고자 하는 데이터를 서브쿼리로 표현.
    ON  --병합시킬 데이터의 연결 조건
        (a.employee_id = b.employee_id)
WHEN MATCHED THEN  --조건이 일치하는 경우에는 타겟 테이블에 이렇게 실행해라.
    UPDATE SET 
     a.phone_number = b.phone_number,
     a.hire_date = b.hire_date,
     a.salary = b.salary,
     a.commission_pct = b.commission_pct,
     a.manager_id = b.manager_id,
     a.department_id = b.department_id
     
      /*
        DELETE만 단독으로 쓸 수는 없습니다.
        UPDATE 이후에 DELETE 작성이 가능합니다.
        UPDATE 된 대상을 DELETE 하도록 설계되어 있기 때문에
        삭제할 대상 컬럼들을 동일한 값으로 일단 UPDATE를 진행하고
        DELETE의 WHERE절에 아까 지정한 동일한 값을 지정해서 삭제합니다.
        */
        DELETE
            WHERE a.employee_id = b.employee_id
            
        

WHEN NOT MATCHED THEN 
    INSERT /*속성(컬럼)*/VALUES
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);

-------------------------------------------------------------

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(102, '렉스', '박', 'LEXPARK', '01/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(101, '니나', '최', 'NINA', '20/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(103, '흥민', '손', 'HMSON', '20/04/06', 'AD_VP');

/*
employees 테이블을 매번 빈번하게 수정되는 테이블이라고 가정하자.
기존의 데이터는 email, phone, salary, comm_pct, man_id, dept_id을
업데이트 하도록 처리
새로 유입된 데이터는 그대로 추가.
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















