-- selfit 6월 15일
SELECT sc_num, sc_label, sc_division, sc_day, sc_part
FROM tbl_sch;

-- projection: 일부 칼럼만 한정해 데이터를 보고자 할 때
SELECT sc_num, sc_label, sc_division
FROM tbl_sch;

-- selection: WHERE 조건을 부여해 튜플 갯수 제한하기
-- 튜플: 출력되는 데이터
SELECT sc_num, sc_label, sc_division
FROM tbl_sch
WHERE sc_num = '01-001';
-- cardinality: 


SELECT sc_num, sc_label, sc_division
FROM tbl_sch
GROUP BY sc_num, sc_label, sc_division;

-- 위 코드에서 오름차순 한 것
SELECT sc_num, sc_label, sc_division
FROM tbl_sch
GROUP BY sc_num, sc_label, sc_division
ORDER BY sc_num;

SELECT sc_num, sc_label, sc_division
FROM tbl_sch
WHERE SUBSTR(sc_num,1,2) = '01'
GROUP BY sc_num, sc_label, sc_division
ORDER BY sc_num;

SELECT * FROM view_workout;

