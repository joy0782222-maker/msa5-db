-- INDEX

-- INDEX 조회
SHOW INDEX employees;

SELECT * FROM employees WHERE `name` = '이미경';

-- INDEX 조회
ALTER TABLE employees
ADD INDEX idx_employees_name (`name`);

-- INDEX 제거
ALTER TABLE employees
DROP INDEX idx_employees_name;

