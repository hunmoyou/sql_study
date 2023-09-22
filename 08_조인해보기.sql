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
WHERE e.department_id = d.department_id;





















