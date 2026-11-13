-- 개념적 설계


-- 테이블 생성

CREATE database test;
USE test;


-- 유저 테이블
-- pk, 생년월일, 전화번호, 성별, 이름, 프로필, 주소, 이메일, PW, 가입일자, 탈퇴일, 작성일, 수정일, 삭제일
CREATE TABLE users (
	id 				BIGINT		 PRIMARY KEY AUTO_INCREMENT
	,email 			VARCHAR(100) NOT NULL
	,`password` 	VARCHAR(255) NOT NULL
	,user_name 		VARCHAR(30)	 NOT NULL
	,birth 			DATE 			 NOT NULL
	,phone 			CHAR(13)		 NOT NULL COMMENT '\'010-0000-0000\', 하이픈 포함 13자리'
	,gender 			CHAR(1)		 NOT NULL COMMENT '\M\',\'F\''
	,addr_number 	CHAR(5)
	,addr1 			VARCHAR(50)
	,addr2 			VARCHAR(50)
	,`profile` 		VARCHAR(100)
	,hired_at 		DATE 			 NOT NULL DEFAULT (CURRENT_DATE())
	,withdrawn_at  DATE 			 NULL
	,created_at		DATETIME 	 NOT NULL DEFAULT CURRENT_TIMESTAMP
	,updated_at 	DATETIME 	 NOT NULL DEFAULT CURRENT_TIMESTAMP
	,deleted_at 	DATETIME 	 NULL
	
	-- 이름 별도 지정
	,CONSTRAINT uk_users_email UNIQUE (email)
);


-- 게시글 테이블
-- 제목, 본문, 이미지, 작성자, 게시글 삭제일, 작성일, 수정일, 삭제일
CREATE TABLE posts (
	id 			 		BIGINT 		 PRIMARY KEY AUTO_INCREMENT
	,user_id		 		BIGINT 		 NOT NULL
	,title		 		VARCHAR(100) NOT NULL
	,content		 		MEDIUMTEXT 	 NOT NULL
	,image 		  		VARCHAR(100) NULL
	,post_deleted_at  DATE 			 NULL
	,created_at			DATETIME 	 NOT NULL DEFAULT CURRENT_TIMESTAMP
	,updated_at 		DATETIME 	 NOT NULL DEFAULT CURRENT_TIMESTAMP
	,deleted_at			DATETIME 	 NULL
	
	,CONSTRAINT fk_posts_user_id
    FOREIGN KEY (user_id)
    REFERENCES users(id)
);


-- 테이블 수정

-- 컬럼 추가
-- ALTER TABLE [테이블명] ADD COLUMN [컬럼명] [타입] [제약조건] [AFTER 기존컬럼명];
ALTER TABLE users
ADD COLUMN 
	birth_year	 CHAR(4) NOT NULL
	,birth_month CHAR(2) NOT NULL COMMENT '\'MM\'양식'
	,birth_day	 CHAR(2) NOT NULL;

-- 컬럼 수정
-- ALTER TABLE [테이블명] MODIFY COLUMN [컬럼명] [타입] [제약조건];
ALTER TABLE users
MODIFY COLUMN birth_month CHAR(2) COMMENT '\'MM\'양식';

-- 컬럼 삭제
-- ALTER TABLE [테이블명] DROP COLUMN [컬럼명];
ALTER TABLE users
DROP COLUMN birth_month;


-- posts 테이블에 fk 제약조건(CONSTRAINT) 추가
ALTER TABLE posts
ADD CONSTRAINT fk_posts_user_id
FOREIGN KEY (user_id) REFERENCES users(id);

-- 제약조건(CONSTRAINT) 제거
ALTER TABLE posts
DROP CONSTRAINT fk_posts_user_id;

ALTER TABLE posts
DROP INDEX fk_posts_user_id;


-- AUTO_INCREMENT 값 변경
ALTER TABLE users AUTO_INCREMENT = 1;


-- TRUNCATE 문 : 테이블의 모든 데이터를 깨끗하게 제거하는 문
TRUNCATE TABLE users;


-- 테이블 삭제
DROP TABLE posts, users;