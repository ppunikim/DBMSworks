-- 여기는 user2 화면 이다.
/*
처음으로 데이터 저장하기 위해 할 일
1. 등록된 사용자로 접속하기
2. 테이블 생성
*/


-- UNIQUE : 중복된 데이터는 입력x 무시함. 
CREATE TABLE tbl_student (
	st_num	     VARCHAR2(5)    PRIMARY KEY,
	st_name    nVARCHAR2(20)	NOT NULL,
	st_tel     	VARCHAR(15)  	UNIQUE NOT NULL,
	st_addr	  nVARCHAR2(125)	NULL,
	st_dept	    nVARCHAR2(5)	NULL,
	st_grade       NUMBER(1)	NULL
);
-- 이렇게 하는것이 table을 만드는 명령문이다. (Data Definition Lang.)


-- 아예 테이블 전체를 삭제하는 것이다. 아주 위험한 친구이다.
-- DROP TABLE tbl_student;


-- tbl_student table에 데이터 추가하기
-- 생성된 테이블에 데이터를추가하는 행위를 Data Create라고 한다.
-- 지정해준 3개의 데이터는 not null이기 때문에 꼭 써준 것이다.
INSERT INTO tbl_student( st_num, st_name, st_tel, st_dept )
VALUES ( '00001', '홍길동', '010-111-1111' ,'전자과' );
INSERT INTO tbl_student( st_num, st_name, st_tel, st_dept )
VALUES ( '00002', '둘리', '010-222-1111' ,'전자과' );
INSERT INTO tbl_student( st_num, st_name, st_tel, st_dept )
VALUES ( '00003', '또치', '010-333-1111' ,'컴공과' );


-- 저장된 데이터의 조회(읽기, Quary)
/* projection : 보고싶은 컬럼만 보기(* 는제외)
SELECT * : 모든 컬럼을 다 표시해달라.
SELECT st_num , st_name : 여러 걸럼 중 st_num, st_name 컬럼만 표시해 달라.
*/
SELECT * 
FROM tbl_student;

SELECT st_num, st_name , st_dept 
FROM tbl_student;

-- 내가 원하는 순서의 컬럼대로 보여줘., 이것이 * 보다 속도 빨라서 실무상 좋다.
SELECT st_num , st_dept, st_tel, st_addr, st_grade, st_name
FROM tbl_student;

-- tbl_student 에 저장된 data 중 이름이 '둘리' 인 데이터만 SELECTION 해달라.
-- SELECT 문에 WHERE 붙으면, WHERE 절이라고 한다. 이것은 구문으로, 명령문이다.
SELECT * 
FROM tbl_student
WHERE st_name = '둘리';
/*
SELECT 명령 수행
Projection : 데이터를 조회할 때 보고자 하는 column만 표시하는 것
Selection : 데이터를 조회할 때 WHERE 조건절을 붙여 필요한 데이터 리스트만 보는 것.

Projection을 하면 실제 칼럼보다 적은 양의 칼럼을 보여준다.
Selection을 하면 실제 데이터 리스트보다 적은 양의 리스트를 보여준다.
*/


-- 전체 data를 조건없이 보여주되, 이름(st_column)을 가나다순(오름차순)으로 정렬(Sort)하여 보여라.
SELECT *
FROM tbl_student
ORDER BY st_name;
-- 역순(내림차순)정렬(Sort)이다.
SELECT *
FROM tbl_student
ORDER BY st_name DESC;

INSERT INTO tbl_student(st_num, st_name, st_tel, st_dept)
VALUES('00004', '도우너', '010-444-4444', '컴공과');
INSERT INTO tbl_student(st_num, st_name, st_tel, st_dept)
VALUES('00005', '마이클', '010-555-5555', '정보통신과');
INSERT INTO tbl_student(st_num, st_name, st_tel, st_dept)
VALUES('00006', '희동', '010-666-6666', '정보통신과');

-- 학과가 컴공인 데이터만 selection 해서 이름순으로 정렬해라
SELECT *
FROM tbl_student
WHERE st_dept = '컴공과'
ORDER BY st_name;

-- 전자과 학생들을 이름 역순으로 정렬해라.
SELECT *
FROM tbl_student
WHERE st_dept = '전자과'
ORDER BY st_name DESC;

-- 전체 데이터를 먼저 학과순으로 정렬, 그 후 이름순으로 정렬하기.
SELECT *
FROM tbl_student
ORDER BY st_dept, st_name;

-- 전체 데이터 갯수가 몇개냐?
SELECT COUNT (st_dept)
FROM tbl_student;
-- 위의 것과 같은 출력값이지만, 성능이 떨어진다.
SELECT COUNT (*)
FROM tbl_student;

-- Q.학과별 학생이 몇명인지 알고싶다.
SELECT st_dept, COUNT (st_dept) AS 학생수 --3 : 묶인 그룹에 포함된 데이터가 몇개?
FROM tbl_student --1 : 먼저 데이터 가져오기
GROUP BY st_dept; --2 : 학과가 같은 데이터끼리 묶고

-- Q.전체 데이터 중 컴공과 학생이 몇명인가?
SELECT COUNT(st_dept) AS 학생수
FROM tbl_student
WHERE st_dept = '컴공과';

-- 여러줄의 명령문을 올리려면 박싱하면 되지만, 한 개만 올리려면 그 줄 어디든지 ctrl + enter 하면 된다.


/*
    도구에 데이터를 추가, 수정, 삭제명령을 수행한 경우
    Oracle DBMS에 요청을 한 상태가 된다.
    하지만 Oracle DBMS에서는 아직 스토리지의 DBF 파일에 저장하지 않는 상태이다.
    이 상태로 도구를 종료해버리면 
    Oracle DBMS는 어떤 문제가 발생하여 종료된 것으로 생각하고, 데이터를 지워버린다.
    도구를 사용하여 접속했을 경우 도구를 종료하기 전에 반드시 COMMIT 해줘야 한다.
*/
COMMIT;

SELECT * FROM tbl_student;

INSERT INTO tbl_student ( st_num, st_name, st_tel )
VALUES('00007', '짱구', '010-777-7777');

-- 데이터를 추가, 수정, 삭제하고 "아직 commit 되지 않은 상태"에서 추가, 수정, 삭제를 취소하는 명령이다.
--  다른 사람이 데이터를 추가하고있던 중이었으면, 사라지니까 함부로 쓰면 안되는 명령이다.
ROLLBACK; 

DELETE
FROM tbl_student;

SELECT * FROM tbl_student;

/*
DCL(Data Controll Lang.) 
사용자에게 권한을 부여(GRANT)하거나 회수(REVOKE)하는 명령이 있고,
데이터를 COMMIT, 또는 ROLLBACK 하는 명령이 있다.
*/
