-- 여기는 USER3 접속 화면
DROP TABLE tbl_student;
DROP TABLE tbl_dept;
DROP TABLE tbl_belong;

-- 학생정보 테이블
CREATE TABLE tbl_student (
        ST_NUM	    VARCHAR2(8)	    PRIMARY KEY,
        ST_NAME	    nVARCHAR2(15)	NOT NULL,
        ST_GRADE	NUMBER(1,0)	,
        ST_TEL	    VARCHAR2(5)	,
        ST_ADDR	    nVARCHAR2(255)
);

-- 학과정보 테이블
CREATE TABLE tbl_dept (
        D_CODE	VARCHAR2(5)	    PRIMARY KEY,
        D_NAME	nVARCHAR2(20)	NOT NULL,
        D_PRO	nVARCHAR2(15)	,
        D_CLASS	VARCHAR2(5)	    
);

-- 소속정보 테이블
CREATE TABLE tbl_belong (
        B_SEQ	NUMBER	        PRIMARY KEY,
        B_STNUM	VARCHAR2(8)	    NOT NULL,
        B_DCODE	VARCHAR2(5)	    NOT NULL,
        UNIQUE(B_STNUM, B_DCODE)
);

-- 학생정보 샘플데이터 생성
INSERT INTO tbl_student(st_num, st_name, st_grade) VALUES ('20220001', '햇살', 1);
INSERT INTO tbl_student(st_num, st_name, st_grade) VALUES ('20220002', '구름', 3);
INSERT INTO tbl_student(st_num, st_name, st_grade) VALUES ('20220003', '샛별', 2);

-- 학과 정보샘플 데이터 추가
INSERT INTO tbl_dept(d_code, d_name, d_pro, d_class) VALUES ('D0001', '컴공', '우주', '505');
INSERT INTO tbl_dept(d_code, d_name, d_pro, d_class) VALUES ('D0002', '전자', '우주', '506');
INSERT INTO tbl_dept(d_code, d_name, d_pro, d_class) VALUES ('D0003', '컴공', '우주', '504');

-- 소속정보 샘플 데이터 추가 ( 한 학번을 가진 학생이 복수전공, 부전공 등 할 수 있으므로 그것을 표현함)
INSERT INTO tbl_belong(b_seq, b_stnum, b_dcode) VALUES (1, '20220001','D0001');
INSERT INTO tbl_belong(b_seq, b_stnum, b_dcode) VALUES (2, '20220002','D0001');
INSERT INTO tbl_belong(b_seq, b_stnum, b_dcode) VALUES (3, '20220002','D0002');
INSERT INTO tbl_belong(b_seq, b_stnum, b_dcode) VALUES (4, '20220003','D0001');
INSERT INTO tbl_belong(b_seq, b_stnum, b_dcode) VALUES (5, '20220003','D0002');
INSERT INTO tbl_belong(b_seq, b_stnum, b_dcode) VALUES (6, '20220003','D0003');

/* 테이블에 일련번호 칼럼이 있을 경우
   중복되지 않은 일련번호를 사용하여 PK로 사용한다.
   오라클 이외의 다른 DBMS에서는 AUTO INCREMENT 라는 속성을 사용해
   데이터를 insert할 때 자동으로 칼럼 데이터를 추가한다.
   
   하지만 오라클은 그러한 속성이 없어 상당히 불편하다.
   대신, 오라클에서는 SEQUENCE 라는 특별한 객체가 있어
   그 객체를 사용하여 같은 효과를 발휘한다.
   
   또는 PK에 관련된 칼럼을 문자열 32bite크기로 설정하고
   UUID(프로그래밍 언어와 같이 쓸 때)를 사용하기도 한다.
   프로그래밍 언어(java, c, python: 호스트 언어)
*/

/* seq_belong 이라는 SEQUENCE 객체를 생성하고
   시작값을 1로, 자동증가 옵션을 1로 선택하겠다.
*/
CREATE SEQUENCE seq_belong
INCREMENT BY 1 START WITH 1 ;

SELECT seq_belong.NEXTVAL FROM DUAL;
/* seq_belong 시퀀스의 NEXTVAL 값을 조회(SELECT)하라.
   NEXTVAL은 호출(SELECT) 할 때마다 항상 1 증가된 값을 보여준다.
*/

/* 표준 SQL에서 간단한 사칙연산을 수행하는 방법
SELECT 10 + 20
SELECT 100 * 100
SELECT 100 - 10
SELECT 40 / 2
*/

SELECT 10 + 20      FROM DUAL;
SELECT 100 * 100    FROM DUAL;
SELECT 100 - 10     FROM DUAL;
SELECT 40 / 2       FROM DUAL;
/* 오라클에서는 SELECT 명령문이 FROM 절 없이 수행하는 것이 불가능하다.
   그래서 의미없는(DUAL) table을 사용하여 FROM 절에 붙여준다.
*/

-- SEQUENCE를 사용하여 자동 증가하는 SEQ를 만들고, INSERT에서 사용하기
INSERT INTO tbl_belong(b_seq, b_stnum, b_dcode)
VALUES(seq_belong.NEXTVAL, '20220005', 'D0005');
INSERT INTO tbl_belong(b_seq, b_stnum, b_dcode)
VALUES(seq_belong.NEXTVAL, '20220006', 'D0006');

SELECT * FROM tbl_student;
SELECT * FROM tbl_belong;

/* tbl_student, tbl_dept, tbl_belong 3개의 table LEFT JOIN하여
   학번, 이름, 학과코드, 학과명, 학년을 표시하는  SELECT문 작성
*/
SELECT ST.st_num, ST.st_name, B.b_dcode, D.d_name, ST.st_grade                   -- 테이블로서 보여지는 부분만 적은 것이다.
FROM tbl_student ST                                                             -- 학생테이블에서
    LEFT JOIN tbl_belong B                                                      -- 왜 left join일까? right join은 없을까? 어떤 의미일까?
        ON ST.st_num = B.b_stnum
    LEFT JOIN tbl_dept D
        ON D.d_code = B.b_dcode
ORDER BY st_num;

-- 위 코드와 동일한 코드이지만, 차이점은 밑에 코드에는 null값이 있으면 출력되지 않는다.
SELECT ST.st_num, ST.st_name, D.d_code, D.d_name, ST.st_grade                   
FROM tbl_student ST, tbl_belong B, tbl_dept D
WHERE ST.st_num = B.b_stnum AND B.b_dcode = D.d_code;

-------------------------------------------------------------------------------------------

/* 학생, 학과, 소속 테이블간 FK 설정하기
   1. Forign Key 설정하기에 앞서 참조무결성 관계 조회하기
   다음의 sql 의 결과에 결과가 한 개도 업어야 참조 무결성 관계가 성립된다.
   2. 참조무결성이 성립되지 않은 데이터를 삭제한다.
   밑에 3번 이어서! 보기
*/
SELECT ST.st_num, ST.st_name, B.b_seq, D.d_code, D.d_name, ST.st_grade
FROM tbl_student ST
    LEFT JOIN tbl_belong B
        ON ST.st_num = B.b_stnum
    LEFT JOIN tbl_dept D
        ON D.d_code = B.b_dcode;
WHERE st_num IS NULL OR d_name IS NULL;
-- 위의 sql 결과 참조 무결성이 성립되지 않은 데이터들이 없다.
-- 만약 성립되지 않은 데이터가 있으면 아래 코드를 작성하면 된다.)
/*DELETE FROM tbl_belong
WHERE b_seq IN(10, 6, 2);*/

SELECT b_seq, b_stnum, b_dcode, st_num, d_name
FROM tbl_belong
    LEFT JOIN tbl_student
        ON b_stnum = st_num
    LEFT JOIN tbl_dept
        ON b_dcode = d_code
WHERE st_num IS NULL OR d_name IS NULL;

/* 3. 테이블 간 참조 무결성 제약 조건을 부여한다.
   참조 무결성 제약조건을 테이블에 추가하는데
   이때는 Relation(여기서는 tbl_belong) 테이블에 추가한다.
   
   테이블에 FK를 추가하여 참조 무결성 제약 조건을 부여한다.
*/

ALTER TABLE tbl_belong
ADD CONSTRAINT FK_tbl_student   
FOREIGN KEY (b_stnum)
REFERENCES tbl_student (st_num);

ALTER TABLE tbl_belong
ADD CONSTRAINT FK_tbl_dept  
FOREIGN KEY (b_dcode)
REFERENCES tbl_dept(d_code);

-------------------------------------
-- 위 join 확인하는 방법
SELECT * 
FROM tbl_student;
/*
20220001	햇살	1		
20220002	구름	3		
20220003	샛별	2		
*/
SELECT * 
FROM tbl_dept;
/*
D0001	컴공	우주	505
D0002	전자	우주	506
D0003	컴공	우주	504
*/
SELECT * 
FROM tbl_belong;
/*
1	20220001	D0001
2	20220002	D0001
3	20220002	D0002
4	20220003	D0001
5	20220003	D0002
6	20220003	D0003
*/
-- tbl_student에 아직 추가되지 않은 학번을 belong table에 추가하기
INSERT INTO tbl_belong(b_seq, b_stnum, b_dcode)
VALUES(seq_belong.NEXTVAL, '20220004','D0003');
-- 부모키(parent key not found)가 없어서, 오류가 난다.

-- 186~7 코드가 오류나지 않도록 하는 방법은 
-- 먼저 학생 테이블의 해당 학번에 학생 정보를 추가해두어야 한다.
INSERT INTO tbl_student(st_num, st_name, st_grade) 
VALUES('20220004','김뿌니',1);
-- 이 이후에 187번 코드 실행해보기!


-- 만약 추가한 데이터를 삭제(delete)하면 어떻게 될까?
DELETE FROM tbl_student WHERE st_num = '20220004';
-- 제약조건에 문제(child record found)가 생기는 오류가 발생해 지울 수 없도록 한다. 
-- 이러하면 안전하다.(데이터 무결성 파괴를 막는다.)

/* 만약 child의 데이터를 삭제, 변경 하려면?
   fk의 옵션을 지정하여 parent의 정보가 삭제되면 child의 데이터를 모두 삭제한다.
   parent의 데이터가 변경되면 child  데이터를 변경하도록 설정할 수 있다.
   
   즉, parent의 데이터를 일괄 변경 하거나 table의 구조를 변경하려고 하면
   fk를 먼저 제거하고 실행해야 한다.
   이러한 이유로 인해 데이터를 모두 작성한 후에 join&FK하는 것이 좋다.
*/

-- FK로 설정한 데이터를 삭제하는 코드
ALTER TABLE tbl_belong
DROP CONSTRAINT FK_tbl_student CASCADE;












