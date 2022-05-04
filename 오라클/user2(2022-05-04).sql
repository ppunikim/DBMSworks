-- 여기는 user2 접속화면
SELECT * FROM tbl_student;

-- 성적 테이블 재설계
-- 기존 성적 테이블 제거
-- DROP TABLE tbl_score;

-- 재 설계된 성적 테이블 생성하기
CREATE TABLE tbl_score(
sc_stnum	VARCHAR2(5)	NOT NULL,
sc_subject	nVARCHAR2(15)	NOT NULL,	
sc_score	NUMBER,		
sc_seq	NUMBER		PRIMARY KEY
);

-- 생성된 테이블 구조 확인
DESC tbl_score;

-- 데이터 import

-- import 후 데이터 수량 확인해, 모두 잘 import 됐는지 확인.
SELECT COUNT(*) FROM tbl_score;

/*
tbl_score 테이블은 제1정규화가 완료되어 재 설계되고
데이터를 import한 상태가 되었다.
*/

-- 학번 별로 전체 총점과 평균을 구해보자.
-- DB에서 합계와 평균을 계산하는 함수
-- 합계는 SUM(숫자컬럼), 평균은 AVG(숫자칼럼)
-- 소수점 이하 관리하는 함수 : ROUND(값, 자리수)
-- AVG()함수로 구한 결과를 소수점 2째에서 반올림해 1째자리까지만 구하기 -> ROUND(AVG(sc_score),1)
SELECT sc_stnum, SUM(sc_score) AS 총점, ROUND(AVG(sc_score),1) AS 평균
FROM tbl_score
GROUP BY sc_stnum;

-- ROUND(AVG(sc_score),0) 빈칸으로 놔두면 0이 생략되있는 것이다. -> 소수부분에서 반올림해 정수만 표현
SELECT sc_stnum, SUM(sc_score) AS 총점, ROUND(AVG(sc_score)) AS 평균
FROM tbl_score
GROUP BY sc_stnum;

-- 전체 학생의 과목별 총점과 평균 구하기
-- 과목명(sc_subject) 별로 그룹을 묶고 그룹 내 총점과 평균 계산
SELECT sc_subject, SUM(sc_score) AS 총점 , ROUND(AVG(sc_score)) AS 평균
FROM tbl_score
GROUP BY sc_subject;

/* 
학생별 총점과 평균을 구하고
평균 순으로 높은 점수부터 낮은 점수까지 보이기
*/
SELECT sc_stnum , SUM(sc_score) AS 총점 , ROUND(AVG(sc_score),1) 평균
FROM tbl_score 
GROUP BY sc_stnum
ORDER BY ROUND(AVG(sc_score)) DESC;

/* 
전체 학생의 과목별 총점과 평균을 보이고
평균 순으로 낮은 점수부터 높은 점수 순으로 보이기
*/
SELECT sc_stnum, SUM(sc_score) 총점, ROUND(AVG(sc_score),1) AS 평균
FROM tbl_score
GROUP BY sc_stnum
ORDER BY 평균 ASC;

/*
DBMS 의 표준 통계함수
GROUP BY 로 공통 항목을 묶고, 
    공통 항목 내에서 개수(COUNT), 합계(SUM), 평균(AVG), 최대값(MAX), 최소값(MIN) 등을
    계산하는 함수
    
SELECT 와 GROUP BY 는 같이 움직여야 한다.
    
통계 함수로 묶지 않은 column은 반드시 GROUP BY에 명시해야 한다.
*/

-- 과목별 총점과 평균을 계산하고 
--      평균이 76점 이상인 과목만 보고싶다. 

SELECT sc_subject, SUM(sc_score) AS 총점 , ROUND(AVG(sc_score),2) AS 평균
FROM tbl_score
GROUP BY sc_subject
HAVING ROUND(AVG(sc_score),2) > 75;
-- 통계함수로 계산된 결과에 대한 조건 부여(HAVING)

-- 음악, 국어 과목의 총점과 평균 계산
SELECT sc_subject, SUM(sc_score) AS 총점, ROUND(AVG(sc_score),2) 평균
FROM tbl_score
GROUP BY sc_subject
HAVING sc_subject IN('음악' , '국어');

SELECT sc_subject, SUM(sc_score) AS 총점, ROUND(AVG(sc_score),2) 평균
FROM tbl_score
GROUP BY sc_subject
HAVING sc_subject = '음악' OR sc_subject = '국어';

-- 통계함수를 통해 데이터를 낸다면, 조건에 맞는 데이터 추출 후 통계를 내도록 한다.
SELECT sc_subject AS 총점 , ROUND(AVG(sc_score),2) 평균
FROM tbl_score
WHERE sc_subject  IN('음악', '국어') 
GROUP BY sc_subject;

/*
통계함수와 GROUP BY 를 사용하여 통계 연산을 수행할 때 주의사항
: 통계 연산 결과에 조건을 부여하여 데이터를 보고자 한다면
    WHERE 절이나 HAVING 절에 조건을 부여할 수는 있다.
    통계 연산이 수행된 결과에 대해 조건을 부여할 때는, 
    어쩔 수 없이 HAVING절에서 조건을 부여해야할 것이다.
    하지만,
    연산 결과가 아닌, 어떤 조건에 일치하는 데이터들에게만 
    통계 연산을 수행하고자 할 땐, WHERE절에 조건을 부여할 수 없는지
    반드시 고민해야 한다.
    그 이유는 데이터 도출 시간이 확연히 다르다.
    (통계 함수와 GROUP BY 를 통한 통계 계산은 SQL 조회 명령에서    
    많이 느린 연산이다.)
*/









