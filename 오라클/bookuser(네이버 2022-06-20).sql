-- 네이버 유저화면(이미지 데이터 추가하기)

SELECT 3,4,5,6,7 FROM DUAL
UNION ALL
SELECT 5,7,8,8,9 FROM DUAL
UNION ALL
SELECT 10,11,12,13,14 FROM DUAL;

INSERT INTO tbl_images( i_seq, i_bseq, i_originalName, i_imageName )
SELECT seq_image.NEXTVAL, SUB.* FROM
(
    SELECT 1,'flower1.jpg','uuid-image1.jpg' FROM DUAL
    UNION ALL
    SELECT 1,'flower1.jpg','uuid-image2.jpg' FROM DUAL
    UNION ALL
    SELECT 1,'flower1.jpg','uuid-image3.jpg' FROM DUAL
) SUB;

SELECT * FROM tbl_images;