-- INSERT
-- DML 중 하나, 신규 데이터 저장을 위해 사용
-- INSERT INTO 테이블명 [(컬럼1, 컬럼2...)]
-- VALUES (값1, 값2...);

INSERT INTO employees (	
	`name`
	,birth
	,gender
	,hire_at
)
VALUES (
	'안유진'
	,'2000-01-01'
	,'F'
	,NOW()
	,DEFAULT /*디폴트 지정가능,일반적으로 컬럼자체 사용*/
)
;

-- 복수 레코드 삽입
INSERT INTO employees (	`name`,birth,gender,hire_at)
VALUES ('안유진','2000-01-01','F',NOW())
	, ('안유유','2001-01-01','F',NOW())
	, ('안진진','2010-01-01','F',NOW())
;


-- SELECT INSERT : 조회된 결과를 가지고 INSERT 실행

-- START TRANSACTION;

INSERT INTO title_emps (
	emp_id
	,title_code
	,start_at
	,end_at
	,created_at
	,updated_at
	,deleted_at
)
SELECT
	emp_id,'t001',NOW(), NULL, NOW(), NOW(), NULL
FROM employees
WHERE
	emp_id > 100000
;
-- COMMIT;
-- ROLLBACK;