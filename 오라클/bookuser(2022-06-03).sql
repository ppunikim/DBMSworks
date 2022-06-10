-- 여기는 bookuser 화면이다.

CREATE TABLE tbl_books (

    isbn        VARCHAR2(13)        PRIMARY KEY,
    title       nVARCHAR2(50)       NOT NULL,
    author      nVARCHAR2(50)       NOT NULL,
    publisher   nVARCHAR2(50)       NOT NULL,
    price       number              ,
    discount    number              ,
    description nVARCHAR2(2000)     ,
    pubdate     VARCHAR2(10)        ,
    link        VARCHAR2(125)       ,
    image       VARCHAR2(125)       
);

SELECT *
FROM tbl_books;

INSERT INTO tbl_books(isbn, title, author, publisher, price )
VALUES('934798579','고민의 답','글배우','햇살책방',13000);

commit;

DROP table tbl_books;
DESC tbl_books;
