-- 여기는 네이버 
SELECT * FROM tbl_users;
DROP TABLE tbl_users;

DROP TABLE tbl_buybooks;
DESC tbl_books;
DESC tbl_users;
CREATE TABLE tbl_buybooks (
    b_isbn          VARCHAR2(13) NOT NULL,
    b_username      VARCHAR2(20) NOT NULL,
    b_date          VARCHAR2(10),
    PRIMARY KEY(b_isbn, b_username)
);

DESC tbl_buybooks;
ALTER TABLE tbl_buybooks
ADD CONSTRAINT fk_book_user
FOREIGN KEY(b_isbn) REFERENCES tbl_books(isbn);

ALTER TABLE tbl_buybooks
ADD CONSTRAINT fk_buyer_user
FOREIGN KEY(b_username) REFERENCES tbl_users(username);

SELECT * FROM tbl_buybooks;