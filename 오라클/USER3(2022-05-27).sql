-- user3 화면
SELECT * FROM tbl_user;


UPDATE tbl_student 
SET st_tel = '111'
WHERE st_num = '20220001';
UPDATE tbl_student 
SET st_tel = '222'
WHERE st_num = '20220002';
UPDATE tbl_student 
SET st_tel = '333'
WHERE st_num = '20220003';

COMMIT;




