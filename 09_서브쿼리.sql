/*
# 서브쿼리 
: SQL 문장 안에 또다른 SQL을 포함하는 방식.
  여러 개의 질의를 동시에 처리할 수 있습니다.
WHERE, SELECT, FROM 절에 작성이 가능합니다.
- 서브쿼리의 사용방법은 () 안에 명시함.
 서브쿼리절의 리턴행이 1줄 이하여야 합니다.
- 서브쿼리 절에는 비교할 대상이 하나 반드시 들어가야 합니다.
- 해석할 때는 서브쿼리절 부터 먼저 해석하면 됩니다.
*/

-- 'Nancy'의 급여보다 급여가 많은 사람을 검색하는 문장.
SELECT first_name FROM employees
WHERE salary > (SELECT salary FROM employees
                WHERE first_name = 'Nancy');
                
-- employee_id가 103번인 사람의 job_id와 동일한 job_id를 가진 사람을 조회.
SELECT * FROM employees 
WHERE job_id = (SELECT job_id FROM employees
                WHERE employee_id = 103);

-- 다음 문장은 서브쿼리가 리턴하는 행이 여러 개라서 단일행 연산자를 사용할 수 없습니다.
-- 단일 행 연산자: 주로 비교 연산자(=, >, <, >=, <=, <>)를 사용하는 경우 하나의 행만 반환해야 합니다.
-- 이런 경우에는 다중행 연산자를 사용해야 합니다.
SELECT * FROM employees 
WHERE job_id = (SELECT job_id FROM employees
                WHERE job_id= 'IT_PROG'); --에러

-- 다중 행 연산자 (IN, ANY, ALL)
-- IN: 조회된 목록의 어떤 값과 같은 지를 확인합니다.
SELECT * FROM employees 
WHERE job_id IN (SELECT job_id FROM employees
                WHERE job_id= 'IT_PROG');
                
-- first_name이 David인 사람들의 급여와 같은 급여를 받는 사람을 조회.
SELECT * FROM employees
WHERE salary IN (SELECT salary FROM employees
                WHERE first_name = 'David');
                




