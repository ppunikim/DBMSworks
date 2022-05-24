-- 여기는 user3 화면
-- data를 만드려면 sheet를 만들어야 하는데 이것은 table모양이다.
-- 학생 Entity 설계를 기준으로 tbl_student table설계하기
CREATE TABLE tbl_student (
    st_num VARCHAR(8) PRIMARY KEY,
    st_name nVARCHAR2(15)  NOT NULL,
    st_grade NUMBER(1) DEFAULT NULL,
    st_tel VARCHAR2(5),
    st_addr nVARCHAR2(255)
);
-- DEFAULT NULL은 쓰나 마나인 것이다.

INSERT INTO tbl_student(st_num, st_name)
VALUES('20220001', '김햇살');

-- table 삭제하는 것.
DROP TABLE tbl_student;

-- 학과 테이블
/* 학과 코드는 PK로 선언하고
   학과 이름은 NULL이거나 중복되지 않도록 설정
*/
CREATE TABLE tbl_dept (
    d_code VARCHAR2(5) PRIMARY KEY, 
    d_name nVARCHAR2(20) NOT NULL UNIQUE,
    d_pro nVARCHAR2(15),
    d_class VARCHAR2(5)
);
-- table 삭제
DROP TABLE tbl_dept;

-- 학생의 학과 소속 정보 Relation을 table로 생성
-- Relation을 table로 설계할 때 가장 유의해야 할 부분
/* Entity table의 칼럼과 DOMAIN(type 과 길이)을 
   반드시 일치시켜야 한다.
주의사항 : 복수의 칼럼이 UNIQUE, NOT NULL로 선언되있다.
            이러한 경우, 복수의 칼럼을 묶어 PK로 선언하기도 한다. -> 복수키, 슈퍼키
           이 TABLE에 INSERT 수행할 때는 데이터 검증이 잘 되어
           잘못된 데이터가 추가되는 것을 방지할 수 있다.
           하지만,
           UPDATE나 DELETE를 수행할 때는 복수의 칼럼으로 조건절을 
           수행해야 한다. 이 때 칼럼을 누락시키거나,
           잘못된 값으로 조건을 수행하여 데이터 무결성이 파괴될 수 있다.
           
   이러할 경우에는 실제 데이터와 관계 없는 단일 칼럼을 추가하고
   그것을 PK로 설정하는 설계를 할 필요가 있다.
*/
CREATE TABLE tbl_belong (
    b_seq NUMBER PRIMARY KEY, -- 별도 칼럼을 만들어 PK로 추가하기
    b_stnum VARCHAR2(8) NOT NULL,
    b_dcode VARCHAR2(5) NOT NULL,
    UNIQUE(b_stnum, b_dcode)  -- 두개 동시에 unique를 묶음으로써 중복방지하기
);
DROP TABLE tbl_belong;

-- 여기에서부터는 데이터 확인, 추가하는 것이다.
SELECT * FROM tbl_student;

-- 전체 칼럼에 데이터를 포함하여 INSERT하기
INSERT INTO tbl_dept(d_code, d_name, d_pro, d_class)
VALUES('D0001', '전자공학과', '둘리', '505');
INSERT INTO tbl_dept(d_code, d_name, d_pro, d_class)
VALUES('D0002', '컴퓨터공학과', '또치', '506');

/* 전체 칼럼에 데이터를 포함(INSERT)할 때는 칼럼 리스트를 생략할 수 있다.
   이렇게 설계하면 좋지 않다. 
   그 이유는 table을 재설계할 때 내가 원하는 데이터가 
   원하는 장소에 붙어있지 않을 수 있기 때문이다.
*/
INSERT INTO tbl_dept
VALUES('D0003', '정보통신공학과', '도우너', '507');

-- 학번 1번학생의 소속 학과 (D0001)을 등록
INSERT INTO tbl_belong(b_seq, b_stnum, b_dcode)
VALUES(2, '20220001', 'D0001');

-- 학생들의 소속학과(코드)를 확인하는 JOIN문
SELECT ST.st_num, ST.st_name, B.b_dcode, ST.st_grade
FROM tbl_student ST -- 겹치는 이름의 칼럼을 대비해 RES를 지정해준다.
    LEFT JOIN tbl_belong B  -- 노란글씨는 자바에서 VO클래스라고 생각하면 된다.
        ON ST.st_num = B.b_stnum;

INSERT INTO tbl_student(st_num, st_name)        VALUES ('20220001','햇살');
INSERT INTO tbl_belong(b_seq, b_stnum, b_dcode) VALUES (1, '20220001','D0001');
INSERT INTO tbl_dept(d_code, d_name)            VALUES ('D0001','전자공학과');

-- table 3개를 join해서 내가 필요한 데이터를 보는 방법이다.
SELECT ST.st_num, ST.st_name, B.b_dcode, D.d_name, D.d_pro,
                  ST.st_grade, D.d_class
FROM tbl_student ST 
    LEFT JOIN tbl_belong B  
        ON ST.st_num = B.b_stnum
    LEFT JOIN tbl_dept D
        ON B.b_dcode = D.d_code;















