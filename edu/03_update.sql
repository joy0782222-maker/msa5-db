-- UPDATE
-- DML 중 하나, 저장되어 있는 기존 데이터를 수정
-- UPDATE 테이블명
-- SET
-- 	컬럼1 = 값1
-- 	[,컬럼2 = 값2...]
-- [WHERE]

-- 100005 사원이름 변경
UPDATE employees
SET 
	`name` = '미어캣'
	,gender = 'F'
WHERE
	emp_id = 100005
;
-- where절 먼저 작성. 실행전 select로 선택사항 맞는지 확인

-- 100005번 사원 생일을 2020-01-01, 마이콜로 변경
UPDATE employees
SET 
	`name` = '마이클'
	,birth = '2020-01-01'
WHERE
	emp_id = 100005
;

