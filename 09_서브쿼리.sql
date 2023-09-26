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
            
-- ANY, SOME: 값을 서브쿼리에 의해 리턴된 각각의 값과 비교합니다.
-- 하나라도 만족하면 됩니다.
SELECT * FROM employees
WHERE salary > SOME (SELECT salary FROM employees
                WHERE first_name = 'David');

-- ALL: 값을 서브쿼리에 의해 리턴된 각각의 값과 모두 비교해서
-- 모두 만족해야 합니다.
SELECT * FROM employees
WHERE salary > ALL (SELECT salary FROM employees
                WHERE first_name = 'David')
                ORDER BY salary ASC;

--EXISTS: 서브쿼리가 하나 이상의 행을 반환하면 참으로 간주.
--job_history에 존재하는 직원이 employees에도 존재한다면 조회에 포함
SELECT * FROM employees e
WHERE EXISTS (SELECT 1 FROM job_history jh 
                WHERE e.employee_id = jh.employee_id);
                
SELECT * FROM employees
WHERE EXISTS (SELECT 1 FROM departments
                WHERE department_id = 10);
                
--------------------------------------------------------------

-- SELECT 절에 서브쿼리를 붙이기.
-- 스칼라 서브쿼리 라고도 칭합니다.
-- 스칼라 서브쿼리: 실행 결과가 단일 값을 반환하는 서브쿼리. 주로 SELECT절이나, WHERE 절에서 사용됨.
SELECT
    e.first_name,
    d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY first_name ASC;

SELECT
    e.first_name,
    (
    SELECT
        department_name
    FROM departments d
    WHERE d.department_id = e.department_id
    ) As department_name
FROM employees e
ORDER BY first_name ASC;

/*
- 스칼라 서브쿼리가 조인보다 좋은 경우
: 함수처럼 한 레코드당 정확히 하나의 값만을 리턴할 때.

- 조인이 스칼라 서브쿼리보다 좋은 경우
: 조회할 데이터가 대용량인 경우, 해당 데이터가
수정, 삭제 등이 빈번한 경우 (sql 가독성이 조인이 좀 더 뛰어납니다.)
*/

-- 각 부서의 매니저 이름 조회
-- LEFT JOIN
SELECT
    d.*,
    e.first_name
FROM departments d
LEFT JOIN employees e
ON d.manager_id = e.employee_id
ORDER BY d.manager_id ASC;

--SELECT절 서브쿼리(스칼라)
SELECT
    d.*,
    (
        SELECT
            first_name
        FROM employees e
        WHERE e.employee_id = d.manager_id
    ) As manager_name
FROM departments d
ORDER BY d.manager_id ASC;

-- 각 부서별 사원 수 뽑기
SELECT 
    d.*,
    (
        SELECT 
            COUNT(*)
        FROM employees e
        WHERE e.department_id = d.department_id
        GROUP BY department_id
    ) As 사원수
FROM departments d;
--------------------------------------------------------

-- 인라인 뷰 (FROM 구문에 서브쿼리가 오는 것.)
-- 특정 테이블 전체가 아닌 SELECT를 통해 일부 데이터를 조회한 것을 가상 테이블로 사용하고 싶을 때.
-- 순번을 정해놓은 조회 자료를 범위를 지정해서 가져오는 경우.

-- salary로 정렬을 진행하면서 바로 ROWNUM을 붙이면
-- ROWNUM이 정렬이 되지 않는 상황이 발생합니다.
-- 이유: ROWNUM이 먼저 붙고 정렬이 진행되기 때문. ORDER BY는 항상 마지막에 진행.
-- 해결: 정렬이 미리 진행된 자료에 ROWNUM을 붙여서 다시 조회하는 것이 좋을 것 같아요.
SELECT 
    ROWNUM As rn, employee_id, first_name, salary
FROM employees
ORDER BY salary DESC;


SELECT ROWNUM As rn, tbl.*
FROM (
        SELECT 
            employee_id, first_name, salary
        FROM employees
        ORDER BY salary DESC
        ) tbl
WHERE rn > 20 AND rn <= 30;

/*
가장 안쪽 SELECT 절에서 필요한 테이블 형식(인라인 뷰)을 생성.
바깥쪽 SELECT 절에서 ROWNUM을 붙여서 다시 조회
가장 바깥쪽 SELECT 절에서는 이미 붙어있는 ROWNUM의 범위를 지정해서 조회.

** SQL의 실행 순서
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
*/

SELECT * FROM  --게시판 페이지 활용
    (
    SELECT ROWNUM As rn, tbl.*
        FROM (
            SELECT 
                employee_id, first_name, salary
            FROM employees
            ORDER BY salary DESC
         ) tbl
    )
WHERE rn > 0 AND rn <= 10;


























