-- 6월 9일 sellfit 과제 시작

 drop table tbl_sch;
 
 -- 운동 스케줄
 create table tbl_sch(
    sc_ID      VARCHAR2(4)        PRIMARY KEY ,
    sc_num	VARCHAR2(6)	NOT NULL,
    sc_label   nVARCHAR2(20)      NOT NULL,
    sc_division   nVARCHAR2(20)   NOT NULL,   
    sc_day   VARCHAR2(10)         NOT NULL,
    sc_part   nVARCHAR2(30)       NOT NULL
 );  
 
 SELECT
     * FROM tbl_sch;
 
 -- 운동종목
 DROP TABLE tbl_list;
 CREATE TABLE tbl_list(
    list_id VARCHAR2(5)          PRIMARY KEY,
    list_name nVARCHAR2(125)     NOT NULL  
 );
SELECT
     * FROM tbl_list;
 
--  운동 스케줄 and 종목  Relation (이름 바꿈)
DROP TABLE tbl_sch_list;
CREATE TABLE tbl_sch_list(
    sl_id	VARCHAR2(5)		PRIMARY KEY,
    sl_scid	VARCHAR2(4)	NOT NULL,	
    sl_listid	VARCHAR2(5)		NOT NULL	,
    sl_listname	nVARCHAR2(125)	NOT NULL,		
    sl_set	NUMBER			NOT NULL,
    sl_weight	VARCHAR2(10)		NOT NULL,	
    sl_rep	VARCHAR2(10)		NOT NULL	
 );
SELECT * FROM tbl_sch_list;

 
 -- 갯수 맞는지 확인하는 방법.
 SELECT COUNT(*) FROM tbl_sch;
 SELECT COUNT(*) FROM tbl_list;
 SELECT COUNT(*) FROM tbl_sch_list;
 
 -- 보기용도인 VIEW이다. 안경쓴 모습으로 돼있다.
DROP VIEW view_WorkOut;
 
CREATE VIEW view_WorkOut
AS (
SELECT sl_id,sl_scid, 
        sc_num, sc_label, sc_division, sc_day, sc_part,
            sl_listid, list_name,
            sl_set, sl_weight, sl_rep
FROM tbl_sch_list
    LEFT JOIN tbl_sch
        ON sc_id = sl_scid
    LEFT JOIN tbl_list
        ON list_id = sl_listid
 );

SELECT * FROM view_WorkOut
ORDER BY sc_num, sc_day;
 
SELECT sc_num, sc_label
FROM view_workout
GROUP BY sc_num, sc_label
ORDER BY sc_num;

SELECT sc_label
FROM view_workout
GROUP BY sc_label;

SELECT sc_label, sc_part
FROM view_workout
WHERE sc_label='초급';
 
-- view 여기까지.

-- 운동 스케줄에서 등급 ID + Label + Division이를 묶어 한 개씩만 보고 싶을 때
SELECT sc_num, sc_label, sc_division
FROM tbl_sch
GROUP BY sc_num, sc_label, sc_division
ORDER BY sc_num;


SELECT * FROM view_workout
WHERE sl_scid = 'D001';


 
 
 
 
 --  운동설명
 drop table tbl_exP;
 CREATE TABLE tbl_exp (
    ex_listid   VARCHAR2(5)   NOT NULL   PRIMARY KEY   ,         
    ex_list   nVARCHAR2(125)   NOT NULL         ,      
    ex_content    nVARCHAR2(1000)                  
 );
 
  
  drop TABLE TBL_GUID;
 CREATE TABLE tbl_guid(
    gd_listID VARCHAR2(5)   NOT NULl,
    gd_list   nVARCHAR2(125)         ,
    gd_seq   nVARCHAR2(2)   NOT NULL   ,   
    gd_content   nVARCHAR2(1000),
    primary key(GD_LISTID, GD_SEQ)
            

 );
 
 
  
 CREATE TABLE tbl_Breath(
    br_id   VARCHAR2(5)   NOT NULL,
    br_list   nVARCHAR2(20) NOT NULL,   
    br_seq    NUMBER   NOT NULL,      
    br_contenth   nVARCHAR2(200),
    PRIMARY KEY (br_id, br_seq)
 );
 
 
 SELECT * fROM tbl_breath;
 
 DROP TABLE tbl_Breath ;
 
 DROP TABLE tbl_img;
 CREATE TABLE tbl_img(
    img_listid   VARCHAR2(5)   NOT NULL   PRIMARY KEY,    
    img_list   nVARCHAR2(125),
    img_link    varchar2(255)

 );
 
 

 create TABLE tbl_user(
    USERNAME   VARCHAR2(10)    ,
    PASSWORD   VARCHAR2(128),   
    NAME   NVARCHAR2(20),
    EMAIL   VARCHAR2(125),
    ROLE   VARCHAR2(10) ,
    gender NVARCHAR2(20)    
 );
 
 SELECT * FROM tbl_user;
 
 
 
 
 
 
 
 
 
 
 -- notion(게시판)을 위해 sequence만들어주기
DROP TABLE tbl_notion;
CREATE TABLE tbl_notion (
	 		
	 		no_seq		NUMBER			PRIMARY KEY,
			no_date		VARCHAR2(10)	NOT NULL,
			no_time		VARCHAR2(10)	NOT NULL,
			no_writer	VARCHAR2(125)	NOT NULL,
			no_subject	nVARCHAR2(125)	NOT NULL,	
			no_content	nVARCHAR2(1000)	NOT NULL
);

SELECT * FROM tbl_notion;


--시작값을 1로 시작하고 1씩 자동증가되는 SEQ생성하기
CREATE SEQUENCE seq_notion
INCREMENT BY 1 START WITH 1;

DROP SEQUENCE seq_notion;

SELECT seq_notion.NEXTVAL FROM DUAL;
INSERT INTO tbl_notion(no_seq, no_date, no_time, no_writer, no_subject, no_content)
VALUES(seq_notion.nextval, '2022-06-14','18:14:00','sunny','게시판 글쓰기','안녕');

 

commit;