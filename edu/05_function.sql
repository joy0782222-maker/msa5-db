-- Function(내장 함수)

-- 데이터 타입 면환
-- CAST = 표준 방식
-- CONVERT = DBMS별 확장 방식

SELECT
	CAST(1234 AS CHAR(6))
	,CONVERT(1234, CHAR(6))
;

SELECT
	CONVERT(emp_id, CHAR(20))
FROM employees
WHERE emp_id = 100005
;


-- 제어흐름 함수
-- IF(수식, 참, 거짓)
SELECT 
	`name`
	,gender
	,IF(gender = 'M','남자','여자') ko_gender
FROM employees
;


-- IFNULL(수식1, 수식2)
-- 수식1이 null이면 수식2를 반환, or 수식1 반환
SELECT
	IFNULL(fire_at, '재직중') 현재
	FROM employees
	;
	
	
-- NULLIF(수식1, 수식2)
-- 수식1,2 비교해 같으면 null, 다르면 수식1
SELECT
	NULLIF(gender,'M')
FROM employees
;


-- CASE ~ WHEN ~ ELSE ~ END
SELECT
	CASE gender
		WHEN 'M' THEN '남자'
		WHEN 'F' THEN '여자'
		ELSE '기타'
	END ko_gender
FROM employees
;

SELECT CONCAT(
    LEFT('홍길동', 1));

-- 문자열 함슈
-- 문자열 연결
SELECT CONCAT('아아','아아ㅏㅇ');
SELECT CONCAT(`name`,' ',gender) FROM employees;


-- 구분자로 문자열 연결
SELECT CONCAT_WS(', ','자바', 'JS', 'HTML');


-- 숫자에 자릿수(,)및 소수점 자리수 표시
SELECT FORMAT(salary, 0) FROM salaries;


-- 문자열 자르기
SELECT LEFT('123456', 2), RIGHT('123456', 2);

-- 문자열 삽입
SELECT LPAD('123', 6, '0'), RPAD('123', 6, '***');

-- 문자열 공백제거
SELECT 
	'    test '
	, TRIM('    test ')
	, LTRIM('    test ')
	, RTRIM('    test ')
;


-- 김*김
SELECT CONCAT(
    LEFT(name, 1),
    CASE
        WHEN CHAR_LENGTH(name) = 1 THEN '*'
        WHEN CHAR_LENGTH(name) = 2 THEN '*'
        ELSE REPEAT('*', CHAR_LENGTH(name) - 2)
    END,
    CASE
        WHEN CHAR_LENGTH(name) >= 2 THEN RIGHT(name, 1)
        ELSE ''
    END
)
FROM employees;


-- deading, trailing, both
SELECT TRIM(BOTH 'a' FROM 'abcdefa');

-- 문자열 시작위치에서 길이만큼 자름
SELECT SUBSTRING('123456', 3, 2);
SELECT SUBSTR(str,pos)

-- 왼쪽부터 구분자가 n번째만큼 나오면 후 생략
SELECT SUBSTRING_INDEX('abc_test_123.txt', '_', 2) txt;

-- 영어 대/소문자 변경
SELECT UPPER('asdASD'), lower('asdASD');


-- 수학함수
-- 올림, 반올림, 버림
SELECT CEIL(3.14), ROUND(3.14), FLOOR(3.14);

-- 절대값
SELECT ABS(-1), ABS(1);

-- 소수점 기준 특정 자리수까지 
SELECT TRUNCATE(1.19, 1);
-- SELECT TRUNCATE 테이블명
-- 데이터 싹 날라가고 복구안됨 주의


-- 날짜/시간
-- (YYYY-MM-DD hh:mi:ss)
SELECT NOW();

-- (YYYY-MM-DD)
SELECT DATE('2026-11-09 16:05:39');
SELECT DATE(created_at) FROM employees;

-- 날짜 기간에 따라 날짜/시간 반환 
-- YEAR, MONTH, DAY, HOUR, MINUTE, SECOND, MICROSECOND
SELECT ADDDATE(NOW(), INTERVAL 1 YEAR);
SELECT ADDDATE(NOW(), INTERVAL -1 YEAR);

SELECT SUBDATE(NOW(), INTERVAL -1 YEAR);

SELECT ADDTIME(NOW(), '01:30:00');


-- 순차함수
-- RANK() OVER(ORDER BY 컬럼 ASC/DESC)
-- 지정 컬림 기준 순위 매김. 동일한 값 동일 순위
SELECT 
	emp_id
	,salary
	,RANK() OVER(ORDER BY salary DESC) `rank`
FROM salaries
WHERE
	end_at IS NULL
;

-- ROW_NUMMER() OVER(ORDER BY salart DESC)
-- 레코드에 순위 매김
-- 동일한 값이 있어도 각 행에 고유 넘버
SELECT 
	emp_id
	,salary
	,ROW_NUMBER() OVER(ORDER BY salary DESC, start_at) `rank`
FROM salaries
WHERE
	end_at IS NULL
	AND salary >= 80000000
;