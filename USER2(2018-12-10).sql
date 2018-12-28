-- 이화면은 USER2로 접속한 화면입니다.
-- 현재 USER2에게는 CRUD 권한 부여된 상태
CREATE TABLE tbl_test (
    st_name CHAR(50),
    st_addr nVARCHAR2(125)
);

SELECT * FROM tbl_test ;