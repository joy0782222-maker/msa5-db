-- join
-- 복수의 테이블을 묶어서 하나의 결과 집합으로 출력


-- inner join
-- 복수의 테이블이 공통적으로 만족하는 레코드 출력

-- 전 사원의 사번, 이름, 현재급여
SELECT
	emp.emp_id
	, emp.name
	, sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal. emp_id
		AND sal.end_at IS NULL
;		

-- 재직중 사원 사번, 이름, 생일, 부서명
SELECT
	emp.emp_id
	,emp.`name`
	, emp.birth
	, dep.dept_name
	,emp.fire_at
FROM employees emp
	JOIN department_emps depe
		ON emp.emp_id = depe.emp_id
		AND emp.fire_at IS null
	JOIN departments dep
		ON depe.dept_code = dep.dept_code
			AND depe.end_at IS NULL
;		
SELECT
	emp.emp_id
	,emp.`name`
	, emp.birth
	, dep.dept_name
	,emp.fire_at
FROM employees emp
	JOIN department_emps depe
		ON emp.emp_id = depe.emp_id
	JOIN departments dep
		ON depe.dept_code = dep.dept_code
			AND depe.end_at IS NULL
where emp.fire_at IS null			
;	

-- left join

-- 재직중 전사원 정보. 현재 부서장이면 부서장 정도보 같이
SELECT
	emp.emp_id
	,emp.`name`
	,depm.dept_code
	,dep.dept_name
FROM employees emp
	left JOIN department_managers depm
		ON emp.emp_id = depm.emp_id
			AND emp.fire_at IS NULL
			AND depm.end_at IS NULL
	left JOIN departments dep
		ON dep.dept_code = depm.dept_code		
ORDER BY depm.dept_code IS NULL, depm.dept_code
;		
selecr * FROM department_managers WHERE end_at IS NULL;

SELECT
	emp.emp_id
	,emp.`name`
	,tmp_manager.dept_name
FROM employees emp
	LEFT JOIN (
		select
			depm.emp_id
			,dep.dept_code
			,dep.dept_name
		FROM departments dep
			JOIN department_managers depm
				ON dep.dept_code = depm.dept_code
					AND depm.end_at IS null
	) tmp_manager
		ON emp.emp_id = tmp_manager.emp_id
			AND emp.fire_at IS null
ORDER BY tmp_manager.dept_code desc			
;


-- union
-- 두개이상 쿼리 결과를 합침

-- union : 중복 레코드 제거
-- union all : 중복 레코드 제거안함

SELECT * from employees WHERE emp_id IN (1,3)
UNION all
SELECT * from employees WHERE emp_id IN (1,5)
;


-- self join
-- 같은 테이블 조인

-- 현재 슈퍼바이저 사원 정보
SELECT
	emp.emp_id
	,emp.`name`
	,sup.emp_id
	,sup.`name`
FROM employees emp
	JOIN employees sup
		ON emp.sup_id = sup.emp_id
		AND emp.sup_id IS NOT null
;

