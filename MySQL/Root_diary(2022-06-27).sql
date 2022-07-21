USE mydb;
CREATE TABLE IF NOT EXISTS tbl_diary (
			d_seq 		BIGINT			PRIMARY KEY AUTO_INCREMENT,	
			d_author	VARCHAR(25)		NOT NULL,
			d_date		VARCHAR(10)		NOT NULL,
			d_time		VARCHAR(10)		NOT NULL,
			d_weather	VARCHAR(8),
			d_title		VARCHAR(60)		NOT NULL,
			d_content	VARCHAR(400)	NOT NULL,
			d_good1		VARCHAR(60),
			d_good2		VARCHAR(60),
			d_good3		VARCHAR(60),
			d_advice 	VARCHAR(100)
		);
        
SELECT * FROM tbl_diary;
