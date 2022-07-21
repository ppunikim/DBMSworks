-- 여기는 ROOT 화면
CREATE DATABASE schoolDB;
USE schoolDB;

GRANT ALL PRIVILEGES ON *.* TO ppunikim@'localhost';

-- 권한 부여 후 적용시키는 코드이다.
FLUSH PRIVILEGES;

CREATE TABLE tbl_student (
	st_num		VARCHAR(5)		PRIMARY KEY,
	st_name		NVARCHAR(20)	NOT NULL,
	st_dept		NVARCHAR(20),
	st_grade	INT,
	st_tel		VARCHAR(15)		NOT NULL,
	st_addr		VARCHAR(125)		
);

DROP TABLE tbl_student;


-- 사용자 등록하는 방법은 아래와 같다.
CREATE USER sunshine@'localhost' IDENTIFIED BY '!Korea8080';
-- 사용자 등록에서,   (--------) 이 부분에 '%'로 접속하면 원격 접속이 가능하다.
-- 하지만, 그렇게 되면 DB 보안에 매우 취약하므로 가급적 'localhost'로 적어라.
GRANT ALL PRIVILEGES ON schoolDB.* TO sunshine@'localhost'; -- 이것은 접근 권한 부여
-- 여기까지가 사용자 등록하는 방법이다.
