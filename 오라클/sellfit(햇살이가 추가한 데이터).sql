-- 상세페이지 ( dayHealth) 저장하는 코드 만들기

DROP TABLE tbl_dayhealth;
CREATE TABLE tbl_dayhealth (
 			my_seq          NUMBER          PRIMARY KEY,
 			my_username		nVARCHAR2(50)   ,
            my_list         nVARCHAR2(50)   ,
 			my_date			VARCHAR2(15)	NOT NULL,
			my_weight		VARCHAR2(15)	NOT NULL,
			my_rep			VARCHAR2(15)	NOT NULL
);
SELECT * FROM tbl_dayhealth;

--시작값을 1로 시작하고 1씩 자동증가되는 SEQ생성하기
CREATE SEQUENCE seq_dayhealth
INCREMENT BY 1 START WITH 1;

DROP SEQUENCE seq_dayhealth;
--두개 모두 create하기!! 꼭
-- 이것은 마이페이지와 상세페이지 연결하는 테이블이다.

SELECT * FROM tbl_dayhealth
WHERE my_username ='ppuni';

INSERT INTO tbl_dayhealth(my_seq, my_username, my_list,my_date,my_weight,my_rep)
VALUES (532401,'ppuni','브이 스쿼트','2022-06-16','15322','10000');







commit;