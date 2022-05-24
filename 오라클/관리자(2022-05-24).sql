-- 여기는 관리자(2022-05-24)

-- 1. tablespace생성하기
/*이름: secondDB
  데이터파일(물리적 저장소) : C:/oraclexe/data/iolist.dbf
  초기 크기 : 1MB
  용량이 부족할 경우: 자동 증가 1KB씩
*/
CREATE TABLESPACE iolist
DATAFILE 'C:/oraclexe/data/iolist.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1k;

-- tablespace삭제하기(삭제하려면 모든 컨텐츠, 데이터 파일, 연관 파일 모두 삭제해야 한다.)
DROP TABLESPACE iolist
INCLUDING CONTENTS AND DATAFILES 
CASCADE CONSTRAINTS;

-- 사용자 계정 완전 삭제하기.(tablespace를 했으면 반드시 해줘야 한다.)
DROP USER user3 CASCADE;

-- 물리적인 데이터베이스 : 스키마 라고 한다.

-- 2. 사용자 생성
/* username : user3, password: 12341234
   Default tablespace : 이 사용자 계정으로 데이터를 추가하면
   iolist에 저장하라는 이야기이다.
*/
CREATE USER user3 IDENTIFIED BY 12341234
DEFAULT TABLESPACE iolist;

--사용자 등록을 했으나 현재는 아무런 일도 할 수 없는 상태이다.
-- 3. 사용자에게 DB연결, 조회, 추가, 삭제, 변경등을 할 수 있는 권한 부여
/* 원칙은 권한을 세세하게 부여하여 불필요한 권한을 갖지 않도록 해야하지만 
   학습상 불편함이 있어서 여기에서는 DBA권한을 부여 할 것이다.
*/
GRANT DBA TO user3;   -- 권한 부여
REVOKE DBA FROM user3; -- 권한 회수

-- 1번부터 3번까지 해야 데이터에 접속할 수 있다. 기본단계이다.












