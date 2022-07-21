-- 여기는 새로운 사용자인 Sunshine db 위치이다.

USE schoolDB;
CREATE TABLE tbl_student (
	st_num		VARCHAR(5)		PRIMARY KEY,
	st_name		NVARCHAR(20)	NOT NULL,
	st_dept		NVARCHAR(20),
	st_grade	INT,
	st_tel		VARCHAR(15)		NOT NULL,
	st_addr		VARCHAR(125)		
);

SELECT COUNT(*) FROM tbl_student;


CREATE TABLE tbl_subject (
sb_code	VARCHAR(5)	NOT NULL	PRIMARY KEY,
sb_name	VARCHAR(25)	NOT NULL	
);

INSERT INTO tbl_subject (sb_code, sb_name)
VALUES 
('SB001','국어'), 
('SB002','데이터베이스'),
('SB003','미술'),
('SB004','소프트웨어공학'),
('SB005','수학'),
('SB006','영어'),
('SB007','음악');
SELECT * FROM tbl_subject; 

-- 성적이 저장될 파일이다. 학생정보와 과목정보가 연동돼 점수 관리
-- 학번+과목코드가 동시에 같은코드 중복되지 않도록 마지막에 UNIQUE 설정 한다.
CREATE TABLE tbl_score (
	sc_seq 		BIGINT PRIMARY KEY AUTO_INCREMENT,
	sc_stnum	VARCHAR(5)	NOT NULL,
	sc_sbcode	VARCHAR(5)	NOT NULL,	
	sc_score	INT,
	UNIQUE(sc_stnum, sc_sbcode)
);
 SELECT COUNT(*) FROM tbl_score;
 SELECT * FROM tbl_score;
 
-- selection : 조건에 맞는 데이터만 추출해서 가져오기 

-- Q. tbl_score데이터에서 점수 70점 이하인 데이터만 추출해 학번순 리스트 나열
SELECT * 
FROM tbl_score
WHERE sc_score <= 70
ORDER BY sc_stnum;

-- projection :  Q. 전체 데이터 중 학생번호, 점수만 표시되도록 
SELECT sc_stnum AS 학생번호, sc_score AS 점수
FROM tbl_score;

-- selection과 projection을 같이 적용한 코드
-- Q. 50 <= 점수 <= 70 데이터 과목 코드와 점수만 보여지도록
SELECT sc_sbcode AS 과목코드, sc_score AS 점수
FROM tbl_score
WHERE sc_score >= 50 AND sc_score <= 70
ORDER BY sc_stnum;

SELECT sc_sbcode AS 과목코드, sc_score AS 점수
FROM tbl_score
WHERE sc_score BETWEEN 50 AND 70
ORDER BY sc_stnum;
-- 위 두 식은 같은 의미다. 사이 점수를 구하는 것은 BETWEEN을 사용하면 된다.

/* Q. 점수가 50이상, 70이하 데이터를 tbl_subject table과 연결해 
	  과목코드, 과목명, 점수 보이도록 만들기  */
SELECT SC.sc_sbcode AS 과목코드, SB.sb_name AS 과목명, SC.sc_score AS 점수
FROM tbl_score SC
	LEFT JOIN tbl_subject SB
		ON sc_sbcode = sb_code
WHERE sc_score BETWEEN 50 AND 70;

/* Q. 위 코드에서 tbl_student도 같이 join해라. 그리고 학번순으로 정렬해라 */
SELECT ST.st_num AS 학번, ST.st_name AS 학생이름,
	   SC.sc_sbcode AS 과목코드, SB.sb_name AS 과목명, SC.sc_score AS 점수
FROM tbl_student ST
	LEFT JOIN tbl_score SC
		ON ST.st_num = SC.sc_stnum
	LEFT JOIN tbl_subject SB
		ON SC.sc_sbcode = SB.sb_code
WHERE sc_score >= 50 AND sc_score <= 70;

-- Q. tbl_score 테이블에 데이터를 참고하여 과목별 총점을 구해라.
-- GROUP BY, SUM, AVG 등을 사용해 selection을 만든 것
SELECT sc_sbcode AS 과목코드, SUM(sc_score) AS 총점, AVG(sc_score) AS 평균
FROM tbl_score
GROUP BY sc_sbcode;

-- Q. 과목명도 함께 projecion해보기.
SELECT SB.sb_name AS 과목명, SC.sc_sbcode AS 과목코드, 
	   SUM(sc_score) AS 총점, AVG(sc_score) AS 평균
FROM tbl_score SC
	LEFT JOIN tbl_subject SB
		ON sc_sbcode = sb_code
GROUP BY sc_sbcode, sb_name
ORDER BY sc_sbcode;

-- Q. 학생별로 총점 구하기
SELECT SB.sb_code AS 과목코드, ST.st_name AS 이름, ST.st_num AS 학번, 
	   SUM(SC.sc_score) AS 총점, AVG(SC.sc_score) AS 평균
FROM tbl_score SC
	LEFT JOIN tbl_student ST
		ON sc_stnum = st_num
	LEFT JOIN tbl_subject SB
		ON sc_sbcode = sb_code
GROUP BY st_name;

-- pivot, 보기위한 용도로 만든 데이터 : SB002 과목 점수만 
	--  만약 이 코드들이 참이면,이거실행,false면 이거실행
    --  (-) (-----------------) (------) (-)
SELECT sc_stnum, st_name,
	SUM(IF( sc_sbcode = 'SB001',sc_score,'')) AS 국어,
    SUM(IF( sc_sbcode = 'SB002',sc_score,'')) AS DB,
    SUM(IF( sc_sbcode = 'SB003',sc_score,'')) AS 미술,
    SUM(IF( sc_sbcode = 'SB004',sc_score,'')) AS SW,
    SUM(IF( sc_sbcode = 'SB005',sc_score,'')) AS 수학,
    SUM(IF( sc_sbcode = 'SB006',sc_score,'')) AS ENG,
    SUM(IF( sc_sbcode = 'SB006',sc_score,'')) AS 음악
FROM tbl_score
	LEFT JOIN tbl_student
		ON sc_stnum = st_num
GROUP BY sc_stnum;
    /* oracle에서는 이 코드를 표준 SQL 명령문인,
       SUM( CASE WHEN sc_sbcode = 'SB001' THEN sc_score ELSE 0 END)
       라고 적어야 실행 가능하다.
    */
/* 제2정규화 돼있는 데이터를 view할때 PIVOT으로 데이터를
   펼쳐보는 것이 편할때가 있다. 
   제2정규화가 된 데이터는 기준이 되는 키값을 중심으로 ROW방향으로
   저장돼 있어, 보고서로 만들 땐, PIVOT 해 Column방향으로 펼치는 것이 
   가장 좋다. */



