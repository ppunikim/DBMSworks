USE mydb;

TRUNCATE TABLE tbl_address;

SELECT * FROM tbl_address;

SELECT COUNT(*) FROM tbl_address;

-- 검색조건이 ''일 경우, LIKE 연산자는 조건이 없는것으로 인정한다.
SELECT * FROM tbl_address
WHERE a_name LIKE '';
-- 전체 데이터 불러오기
SELECT * FROM tbl_address
WHERE a_name LIKE CONCAT('%','','%'); 


