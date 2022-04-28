--  C:\oraclexe\data
-- 여기는 관리자 파일 이다.

/*
오라클 DBMS에 Data를 저장하고 관리하기 위한 절차

관리자로 접속하여 
1. TableSpace 생성
2. 사용자 생성 및 TableSpace 연결
3. 사용자에게 권한 부여


dB에서 생성(CREATE)이란 물리적인 것이다.
*/
CREATE TABLESPACE school
DATAFILE 'C:/oraclexe/data/school.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

-- 생성된 사용자와 데이터 연결
CREATE USER user2 IDENTIFIED BY 12341234
DEFAULT TABLESPACE school;

-- 연결된 데이터를 가지는 사용자에게 권한 부여
GRANT DBA TO user2;

-- 접속하는 것 만들기(왼쪽 초록플러스 눌러서 내가 지정한 사용자로 만들기)
