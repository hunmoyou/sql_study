/*
# 조인이란?
- 서로 다른 테이블 간에 설정된 관계가 결합하여
 1개 이상의 테이블에서 데이터를 조회하기 위해서 사용합니다.
- SELECT 컬럼리스트 FROM 조인대상이 되는 테이블 (1개 이상)
  WHERE 조인 조건 (오라클 조인 문법)
*/

-- employees 테이블의 부서 id와 일치하는 departments 테이블의 부서 id를
-- 찾아서 SELECT 이하에 있는 컬럼들을 출력하는 쿼리문.
SELECT
    e.first_name, 
    d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id; --오라클 조인 문법

SELECT
    e.first_name, e.last_name, e.hire_date,
    e.salary, e.job_id, d.department_name
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id;  -- ANSI 표준 조인 문법

/*
각각의 테이블에 독립적으로 존재하는 컬럼의 경우에는
테이블 이름을 생략해도 무방합니다. 그러나, 해석의 명확성을 위해
테이블 이름을 작성하셔서 소속을 표현해 주는 것이 바람직합니다.
테이블 이름이 너무 길 시에는 ALIAS를 작성하여 칭합니다.
두 테이블 모두 가지고 있는 컬럼의 경우 반드시 명시해 주셔야 합니다.
*/

-- 3개의 테이블을 이용한 내부 조인(INNER JOIN)
-- 내부 조인: 조인 조건에 일치하는 행만 반환하는 조인. 
-- 조인 조건과 일치하지 않는 데이터는 조회 대상에서 제외
SELECT
    e.first_name, e.last_name, e.department_id, e.job_id,
    d.department_name,
    j.job_title
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id 
AND e.job_id = j.job_id;

SELECT
    e.first_name, e.last_name, e.department_id,
    d.department_name, e.job_id, j.job_title, loc.city
FROM 
    employees e,
    departments d,
    jobs j,
    locations loc
WHERE e.department_id = d.department_id
AND e.job_id = j.job_id --3,4
AND d.location_id = loc.location_id --2
AND loc.state_province = 'California'; --1

/*
1. loc 테이블의 state_province = 'California' 조건에 맞는 값을 대상으로
2. location_id 값과 같은 값을 가지는 데이터를 departments에서 찾아서 조인
3. 위의 조인한 결과와 동일한 department_id를 가진 employees 테이블의 데이터를 찾아 조인
4. 위에 결과와 jobs 테이블을 비교하여 조인하고 최종 결과를 출력.
*/

-- 외부 조인
/*
상호 테이블간에 일치되는 값으로 연결되는 내부 조인과는 다르게
어느 한 테이블에 공통 값이 없더라도 해당 row들이 조회 결과에
모두 포함되는 조인을 말합니다.
*/

SELECT
    e.first_name, 
    d.department_name,
    loc.location_id
FROM employees e, departments d, locations loc
WHERE e.department_id = d.department_id(+)
AND d.location_id = loc.location_id;
/*
employees 테이블에는 존재하고, departments 테이블에는 존재하지 않아도
(+)가 붙지 않은 테이블을 기준으로 하여 departments 테이블이 조인에
참여하라는 의미를 부여하기 위해 기호를 붙입니다.
외부조인을 사용했더라도, 이후에 내부 조인을 사용하면
내부조인을 우선적으로 인식합니다.
*/

-- 외부 조인 진행 시 모든 조건에 (+)를 붙여야 하며
-- 일반 조건에도 (+)를 붙이지 않으면 데이터가 누락되는 현상이 발생.
SELECT 
    e.employee_id, e.first_name,
    e.department_id,
    j.start_date, j.end_date, j.job_id
FROM employees e, job_history j
WHERE e.employee_id = j.employee_id(+)
AND j.department_id(+) = 80;








