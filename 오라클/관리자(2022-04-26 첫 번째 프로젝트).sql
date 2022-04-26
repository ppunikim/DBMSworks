-- C:\oraclexe\data
/*
    관리자로 접속하여 할일
    1. TableSpace생성
    2. User Acount 생성 및 TableSpace 연결
    3. User 에게 권한 부여
    
    관리자로 접속하여 '생성'을 할 땐
    CREATE라는 keyword를 사용한다.
    '삭제'를 할 때는 
    DROP이라는 keyword를 사용한다.
*/

/*
    1. TableSpace 생성
        오라클은 물리적 저장공간을 TableSpace라는 이름으로 관리한다.
        오라클 DBMS를 사용하여 데이터를 관리하기 위해서는
        제일 먼저 TableSpace를 생성해야 한다.
        
        오라클 DBMS를 설치하면 System이 관리하는 TableSpace가 기본으로 생성된다.
        System TableSpace에는 중요한 데이터들이 저장되므로, 
        가급적 일반적인 , 대량의 DB를 저장하지 않는것이 좋다.
        
        때문에 프로젝트별로 TableSpace를 만드는 것이 좋다.
*/

-- 테이블 만드는 방법으로, 만드려면 커서 갖다대고 ctrl+enter
CREATE TABLESPACE firstDB
DATAFILE 'C:/oraclexe/data/first.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1k;

-- 기존의 생성한 TableSpace를 완전히 삭제하기
DROP TABLESPACE firstDB
INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;

/*
    2. 사용자 생성과 TableSpace 연결
*/
CREATE USER user1 IDENTIFIED BY 12341234
DEFAULT TABLESPACE firstDB;
-- 1,2는 관리자 권한이다.




/*
    사용자를 생성하면서 DEFAULT TABLESPACE 를 연결하지 않았을 경우
    생성된 사용자 정보에 TABLESPACE 추가하기.
    단, **생성된 사용자 권한으로 추가된 데이터가 없어야 한다.
*/
ALTER USER user1 DEFAULT TABLESPACE firstDB;

-- 사용자 삭제하는 명령(가급적 사용말자)
DROP USER user1 CASCADE;

/*
    오라클에서 새로운 사용자를 생성하면 생성된 사용자는 아무런 권한이 없다.
    심지어 DBMS에 접속할 수 있는 권한마저 없다.
    따라서 생성된 사용자에게는 적절한 수준의 권한을 부여해야 한다.
    GRANT 부여, REVOKE 뺏기
*/

-- 접속(login, logon) 권한 부여 , 원래는 함부로 하면 안된다. 
-- 이걸 하면 SELECT, INSERT 가능해진다.
GRANT CREATE SESSION TO user1 ;

-- TABLE 생성할 수 있는 권한 부여
GRANT CREATE TABLE TO user1;

-- TableSpace 에 접근할 수 있는 권한 부여
GRANT UNLIMITED TABLESPACE TO user1;

-- user1의 접속 권한 회수
REVOKE CREATE SESSION FROM user1;


/*
DBMS에서 사용하는 SQL(Structed Query Language)명령들
    
## DDL(Data Definition Lang' : 데이터 정의어)
이것은 DBA 권한을 가진 사람들이 쓰는 명령어이다.
CREATE로 시작하는 명령
    객체의 생성 명령들.
    CREATE TABLESPACE
    CREATE USER
    CREATE TABLE

DROP으로 시작하는 명령(잘 못 수행하면 dB를 완전 복구 불가능하게 만든다. 주의해서 사용하기)
    객체의 제거명령들

ALTER 로 시작하는 명령
    객체의 상태, 구조등을 변경하는 명령




## DCL(Data Control Lang' : 데이터 제어어)
GRANT
    사용자에게 권한을 부여하는 명령
REVOKE
    사용자에게 권한을 회수하는 명령
    
COMMIT, ROLLBACK(데이터를 잘못 삭제했을 때 되돌리는 것, 함부로 사용하면 안된다.)




## DML(Data Manipulation Lang' , Data Management Lang' : 데이터 조작어, 관리어)
생성된 table에 대한 데이터 조작
    C (Create) : Table에 데이터 추가 : INSERT
    R (READ) : Table에 저장된 데이터를 가져오기, 읽어오기 : SELECT 
    U (Update) : Table에 저장된 데이터의 내용을 변경하기 : UPDATE 
    D (Delate) : Table에 저장된 데이터를 삭제하는 명령 : DELETE
*/

/*
개발&학습자 입장에서 사용자에게 권한 부여하기
사용자에게 부여하는 권한은 조목조목 부여하는 것이 원칙이다.
실무에서는 회사의 정책(policy)에 따라 적절한 권한을 관리해야 한다.
권한이 잘 못 부여되면 dB에 저장된 data의 손상을 가할 수 있고,
손상된 data는 신뢰성을 잃게된다.

손상된 data가 저장된 데이터베이스 시스템은 '무결성이 파괴되었다.'라고 표현한다.

"여기에서는 학습의 편의성"을 위하여 사용자에게 최고권한을 부여할 것이다.

DBA 권한은 SYSDBA 보다 약간의 제약이 있는 권한이다.
오라클 DBMS의 중요한 정보 접근을 제외하고 모든것을 다 할 수 있다.
심지어 다른 사용자의 tableSpace에도 접근할 수 있다.
*/

GRANT DBA TO user1;


