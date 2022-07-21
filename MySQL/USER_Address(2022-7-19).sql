use mydb;

CREATE TABLE tbl_address (
	a_seq BIGINT AUTO_INCREMENT PRIMARY KEY,
    a_name VARCHAR(20) NOT NULL,
    a_tel VARCHAR(30),
    a_address VARCHAR(125)
);

DROP TABLE tbl_address;
SHOW TABLES;
SELECT * FROM tbl_address;
-------------------------------------
-- 7월 19일 배운 내용

-- DROP 후 다시 create하는 명령어이다.
TRUNCATE TABLE tbl_address;
SELECT COUNT( * ) FROM tbl_address;

SELECT * FROM tbl_address
WHERE a_name = ' 학생이름';

DELETE FROM tbl_address
WHERE a_seq = 50;

DELETE FROM tbl_address
WHERE a_seq = 189;

SELECT * FROM tbl_address
WHERE a_name = '야유신';


-- a_name 칼럼 즁간에 '유'자가 포함된 데이터
SELECT*  FROM tbl_address
WHERE a_name LIKE '%유%';

SELECT * FROM tbl_address
WHERE a_name LIKE '%유';

-- SELECT *  FROM tbl_address
-- WHERE a_name LIKE CONCAT('%','${a_name},'%');

SELECT * FROM tbl_address
LIMIT 10;

-- offset : 앞에서 ~개 건너뛰고 구현하기(pagenation)구현 쉬움
SELECT * FROM tbl_address
LIMIT 10 OFFSET 10;

/* LIMIT 와 OFFSET 은 SELECT 명령문의 어떠한 절보다 먼저 실행된다.
   그러한 이유로, 밑 코드는 전체 데이터 중 앞에서 10개 데이터를 추출하고
   추출된 데이터 중 WHERE절을 실행해 조건에 맞는 데이터를 찾는다.
*/
SELECT * FROM 
(
SELECT * FROM tbl_address
WHERE a_name LIKE '%유%'
)
AS SUB
LIMIT 10 OFFSET 10;

/* 검색 기능과 pagenation 기능을 동시에 구현하기 위해서는
   subQuery 를 사용한다. 내부 select 에서 조건에 맞는 데이터를 추출하고
   바깥쪽의 select에서 limit offset을 설정한다.
*/

SELECT * FROM tbl_address;
