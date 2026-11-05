-- SELECT 문
-- DML 중 하나로, 저장되어 있는 데이터를 조회하기 위해 사용하는 쿼리


-- SELECT 절 : 조회한 데이터 중 특정 컬럼만 출력
SELECT
	emp_id
	, `name` -- ``으로 감싸 컬럼으로 인식
-- 	, gender --del v2.0
	, birth -- ADD v2.0
FROM employees
;


-- Asterrisk (*) : 모든 컬럼 조회
select
	*
from employees
;


-- WHERE 절 : 필터링. 특정 컬럼의 값이 조건에 일치한 데이터만 조회
-- 사번이 10009번 사원의 모든정보
SELECT
	*
FROM employees AS emp
WHERE
	emp_id = 10009
;

-- 사원명이 "박보람"인 사람의 정보 조회
SELECT
	*
FROM employees
WHERE
	'name' = "박보람"
;

-- 생일 2000-01-01이후 사원
SELECT
	*
FROM employees
WHERE
	birth >= '2000-01-01'
;

-- 퇴사한 사원
SELECT
	*
FROM employees
WHERE
	fire_at IS NULL
;

-- 퇴사하지 않은 사원
SELECT
	*
FROM employees
WHERE
	fire_at IS NOT NULL
;
