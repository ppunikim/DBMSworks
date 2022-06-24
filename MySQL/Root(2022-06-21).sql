use mydb;
DROP TABLE tbl_ems;

DESCRIBE tbl_users;
DESC tbl_users;

SHOW tables;

SELECT * FROM tbl_users;

use mydb;
CREATE TABLE IF NOT EXISTS tbl_memo (
			m_seq 		BIGINT			PRIMARY KEY AUTO_INCREMENT,	
			m_author	VARCHAR(25)		NOT NULL,
			m_date		VARCHAR(10)		NOT NULL,
			m_time		VARCHAR(10)		NOT NULL,
			m_memo		VARCHAR(400)	NOT NULL,
			m_image		VARCHAR(125)	
);
SELECT * FROM tbl_memo;

SELECT * FROM tbl_memo
WHERE m_seq = 3;
SELECT * FROM tbl_memo
WHERE m_author = 'ppuni@naver.com';

DROP TABLE tbl_memo;