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
FROM employees /*AS*/ emp
WHERE
	emp_id = 10009
;

-- 사원명이 "박보람"인 사람의 정보 조회
SELECT
	*
FROM employees
WHERE
	`name` = "박보람"
;

-- 생일 2000-01-01이후 사원
SELECT
	*
FROM employees
WHERE
	birth >= '2000-01-01'
;

-- 퇴사하지 않은 사원
SELECT
	*
FROM employees
WHERE
	fire_at IS NULL
;

-- 퇴사한 사원
SELECT
	*
FROM employees
WHERE
	fire_at IS NOT NULL
;

-- 1990년생 사원
SELECT
	*
FROM employees
WHERE
	birth >= '1990-01-01'
	AND birth <= '1990-12-31'
;

-- '김철수' or '정유리'
SELECT
	*
FROM employees
WHERE
	`name` = "김철수"
	OR `name` = "정유리"
;

-- 1990년생 or 1991년생
SELECT
	*
FROM employees
WHERE
	(birth >= '1990-01-01'
	AND birth <= '1990-12-31')
	
	OR
	(birth >= '1992-01-01'
	AND birth < '1993-01-01')
;

-- 1990년 이후 정유리 or 김철수
SELECT
	*
FROM employees
WHERE
	birth >= '1990-01-01'
	AND (`name` = "김철수"
	OR `name` = "정유리")
;



-- BETWEEN : 지정한 범위내 데이터 조회
SELECT
	*
FROM employees
WHERE 
-- 	birth >= '1990-01-01'
-- 	AND birth <= '1990-12-31'
	birth BETWEEN '1990-01-01' AND '1990-12-31'
;



-- IN : 다수의 지정값과 일치하는 데이터를 조회

SELECT
	*
FROM employees
WHERE
-- 	`name` = "김철수"
-- 	OR `name` = "정유리"
	`name` IN('박보람', '정유리')
;

-- 사번이 10001, 10005, 10006 사원의 모든 정보
SELECT
	*
FROM employees
WHERE
	emp_id IN(10001, 10005, 10006)
;



-- LIKE : 문자열의 내용 조회
-- % : 글자수와 상관없이 조회

-- 이름이 '우'로 끝나는 사원 조회
SELECT
	*
FROM employees
WHERE
	`name` LIKE '%우%'
;

-- _ :언더바 개수만큼 글자수 허용해 조회
SELECT
	*
FROM employees
WHERE
	`name` LIKE '_우%'
;



-- ORDER BY : 조회한 데이터 정렬
SELECT
	*
FROM employees
ORDER BY `name` /* 기본  오름차순(ASC) 생략가능*/
	,birth DESC
;


-- LIMIT, OFFSET : 출력의 개수를 제한하는 키워드
-- ~까지, ~다음 부터
SELECT
	*
FROM employees
LIMIT 5 OFFSET 5
;

SELECT
	*
FROM employees
LIMIT 5, 3 /* OFFSET, LIMIT*/
;



-- 집계함수
-- SUM 
SELECT
	SUM(salary) SUM_sal
FROM salaries
WHERE
	end_at IS NULL
;

-- MAX 
SELECT
	MAX(salary) max_sal
FROM salaries
WHERE
	end_at IS NULL
;

-- MIN 
SELECT
	MIN(salary) MIN_sal
FROM salaries
WHERE
	end_at IS NULL
;

-- AVG 
SELECT
	AVG(salary) AVG_sal,
	MIN(salary) MIN_sal
FROM salaries
WHERE
	end_at IS NULL
;

-- COUNT 
SELECT
	COUNT(*) cnt
FROM employees
WHERE
	fire_at IS NULL
;

-- 컬럼명 삽입시 해달 컬럼 값이 NULL이 아닌 레코드의 총 수
SELECT
	COUNT(`name`)
FROM employees
WHERE
	fire_at IS NULL
;



-- DISTINCT : 중복 제거
SELECT DISTINCT
	emp_id
	, `name`
FROM employees
ORDER BY `name`
;

-- GROUP BY, HAVING 
SELECT 
	dept_code /* GROUP BY절에서 사용한 컬럼, 집계함수만 사용*/
	, COUNT(*) cnt_emps
FROM department_emps
WHERE
	end_at IS NULL
GROUP BY dept_code
;

-- 직급별 사원수 10000명 이상 직급
SELECT 
	title_code tc
	, COUNT(*) cnt
FROM title_emps 
WHERE
	end_at IS NULL
GROUP BY title_code
HAVING cnt >= 10000
;

