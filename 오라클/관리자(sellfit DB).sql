--여기는 관리자 페이지

CREATE TABLESPACE sellfit
DATAFILE 'C:/oraclexe/data/sellfit.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

CREATE USER logintest IDENTIFIED BY 1234
DEFAULT TABLESPACE sellfit;

GRANT DBA TO logintest;