--여기는 관리자 화면입니다
-- TABLESPACE를 생성하자
-- TBALESPACE명 : myTBL1
-- DATEFILE : D:bizwork/ordata/mytbl_1.dbf
CREATE TABLESPACE myTBL1
DATAFILE 'D:/bizwork/ordata/mytbl_1.dbf'
SIZE 100M
AUTOEXTEND ON NEXT 1M;

CREATE USER myMem IDENTIFIED BY 1234 ;
DEFAULT TABLESPACE myTBL1 ;

GRANT DBA to myMem ;