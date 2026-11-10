-- SubQuery
-- 2테이블에서 사용하면 느림 join추천


-- WHERE

-- 단일행 서브쿼리
-- 서브쿼리 단일행 비교연산자와 함께 사용할때 
-- 반드시 서브쿼리 결과가 1건 이하여아햔다
-- 2건 이상일 경우 오류 발생

-- D001 부서장 사번,이름
SELECT
	emp.emp_id
	,emp.`name`
FROM employees emp
WHERE 
	emp.emp_id = (
	SELECT
		emp_id
	FROM department_managers depm
	WHERE
		depm.dept_code = 'D001'
		AND depm.end_at IS null
	)
;

-- D001의 현재 부서장 사번
SELECT
	emp_id
FROM department_managers
WHERE
	dept_code = 'D001'
	AND end_at IS NULL
;

	
-- 다중행 서브쿼리
-- 서브쿼리의 결과가 2건 이상 반환할 경우 
-- 반드시 다중행 비교연산자(IN, ALL, ANY, SOME, EXISTS) 이용

-- 현재 부서장 사번, 이름
SELECT
	emp.emp_id
	,emp.`name`
FROM employees emp
WHERE
	emp.emp_id IN (
		SELECT
			depm.emp_id 
		FROM department_managers depm
		WHERE
			depm.end_at IS NULL
		)
;


-- 다중열 서브쿼리

-- 현재 'D002' 부서장이 해당 부서에 소속된 날짜
SELECT
	depe.start_at
from department_emps depe
WHERE 
	(depe.emp_id, depe.dept_code) IN (
	SELECT
	depm.emp_id
	,depm.dept_code
from department_managers depm
WHERE 
	depm.dept_code = 'D002'
	AND depm.end_at IS NULL
	)
;


-- 연관 서브쿼리
-- 서브쿼리 내 메인쿼리의 컬럼이 사용된 서브쿼리

-- 부서장직 경력이 있는 샤원의 정보
SELECT
	emp.*
FROM employees emp
WHERE
	emp.emp_id IN(
	SELECT
		depm.emp_id
	FROM department_managers depm
	where
	depm.emp_id = emp.emp_id
	)
;


-- SELECT

-- 사원 별 역대 전체금여 평균
SELECT
	emp.emp_id
	,(
		SELECT
		AVG(sal.salary)
FROM salaries sal
WHERE
	sal.emp_id = emp.emp_id
	) avg_sal
FROM employees emp
;


-- FROM
SELECT
	tmp.*
FROM (
	select
		emp.emp_id
		,emp.`name`
		FROM employees emp
		where
			fire_at IS NOT null
) tmp
;


-- insert
INSERT INTO employees (
	employees.emp_id
	,employees.`name`
	,employees.birth
	,employees.gender
	,employees.hire_at
)
VALUES (
	(SELECT MAX(emp.emp_id) + 1 FROM employees emp)
	,'둘리'
	,'1980-01-01'
	,'M'
	,NOW()
)
;


-- update

-- 퇴사한 사원의 직급 종료일을 퇴사일로 갱신
UPDATE title_emps
SET
	title_emps.end_at = (
	SELECT employees.fire_at
	FROM employees
	where
		employees.emp_id = 100017
	)
WHERE
	title_emps.emp_id = 100017
	AND title_emps.end_at IS NULL
;