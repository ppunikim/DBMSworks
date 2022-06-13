-- 6월 9일 sellfit 과제 시작

 drop table tbl_sch;
 
 -- 운동 스케줄
 create table tbl_sch(
    sc_ID      VARCHAR2(4) NOT NULL PRIMARY KEY ,
    sc_label   nVARCHAR2(20)      ,
    sc_division   nVARCHAR2(20)   ,   
    sc_day   VARCHAR2(10)      ,
    sc_part   nVARCHAR2(20)      
 );  
 
 SELECT
     * FROM tbl_sch;
 
 -- 운동종목
 DROP TABLE tbl_list;
 CREATE TABLE tbl_list(
    list_id VARCHAR2(5)    NOT NULL    PRIMARY KEY,
    list_name nVARCHAR2(125)      
 );

--  운동 스케줄 and 종목  Relation 
DROP TABLE tbl_sch_list;
CREATE TABLE tbl_sch_list(
    sl_listid   VARCHAR2(5)   NOT NULL   PRIMARY KEY,
    sl_scid    VARCHAR2(4)   NOT NULL   ,
    si_scpnid VARCHAR2(5) NOT NULL,
    sl_list   nVARCHAR2(125)      ,
    sl_set   number(4)      ,
    sl_weight   VARCHAR2(10),      
    sl_rep   nVARCHAR2(10)      
 );
 
 
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
 

commit;