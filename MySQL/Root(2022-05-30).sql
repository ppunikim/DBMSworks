-- 여기는 root 화면
-- root는 oracle의 sys와 같은 역할
/*
mySQL은 사용자와 DB(Data 저장소)의 관계가 연결된 것이 아니다.
오라클에서는 사용자에게 defalt Table Space 지정하여
login(접속)을 하면 자동으로 기본 DB가 연결된다.

사용자는 단순히 DB서버에 접속하는 권한을 부여받을 뿐이고
어떤 DB를 사용할 것인지 처음시작할 때 연결을 해줘야 한다.
*/

-- DB 저장소 생성
CREATE DATABASE myDB;

-- 일반 사용자 생성
/* mySQL은 전통적으로 root 사용자로 접속하여 DB관리한다.
   최근 추세는 root 사용자는 DB, USER생성만을 담당하고
   DB 관리는 일반 사용자 등 생성하여 실행하도록 권장한다.
   mySQL은 사용자를 생성할 때 어떤 방법으로 접속할 것인지 명시해야 한다.
   
   ppunikim 사용자는 localhost에서만 mySQL에 접속할 수 있다.
*/
CREATE USER 'ppunikim'@'localhost' identified BY '!Korea8080';
-- 데이터 지우는 용도.
DROP USER 'ppunikim'@'localhost'; 


-- 내접속에서 권한을 주는 것이 아니라 여기서 주는 것이다.
/* mySQL은 사용자를 등록하면
   그 사용자는 DBA 권한을 기본적으로 가진다.
   mySQL은 실무에서 가장 많이 사용하는 버전이 5.7.x이다.
   5.7버젼은 사용자 등록과 동시에 DB관련된 명령을 대부분 사용가능.
   우리가 사용하고있는 8.x 버젼은 사용자 권한이 좀 더 엄격해졌다.
   
   새로 등록한 사용자에게 DB에 접근할 수 있는 권한 부여하기
   ppunikim@localhost 사용자에게 mydb Schema에 접근하여
   모든 DML 명령을 수행할 수 있는 권한을 부여하겠다.
*/
GRANT ALL PRIVILEGES ON mydb.* TO 'ppunikim'@'localhost';

-- user1은 모든 DB Scheme(*.*)에 접속할 수 있다.
CREATE USER 'user1'@'127.0.0.1' IDENTIFIED BY '!Korea8080';
GRANT ALL PRIVILEGES ON *.* TO 'user1'@'127.0.0.1';

-- 어디에서나 접속할 수 있도록 범위를 지정하지 않은 사용자 등록.
CREATE USER 'user2'@'*' IDENTIFIED BY '!Korea8080';





