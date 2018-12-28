-- 여기는 MYIOUSER화면입니다

CREATE TABLE tbl_iolist(
    io_id	    NUMBER	    PRIMARY KEY,
    io_date	    CHAR(10)	NOT NULL,
    io_pname	nVARCHAR2(50)	NOT NULL,
    io_dname	nVARCHAR2(50)	NOT NULL,
    io_ceo  	nVARCHAR2(50),
    io_inout	nVARCHAR2(7),
    io_quan	    NUMBER,
    io_price	NUMBER,	
    io_total	NUMBER		
);

DROP TABLE tbl_iolist ;

SELECT * FROM tbl_iolist ;

SELECT io_dname AS 거래처명, io_ceo AS 대표자명 FROM tbl_iolist
GROUP BY io_dname, io_ceo;

CREATE TABLE tbl_dept(
    d_code	CHAR(5)		    PRIMARY KEY,
    d_name	nVARCHAR2(50)	NOT NULL,	
    d_ceo	nVARCHAR2(50)
);

SELECT * FROM tbl_dept;

DESC tbl_dept;

ALTER TABLE tbl_dept MODIFY d_name NULL ;

ALTER TABLE tbl_dept MODIFY d_name NOT NULL ;

-- 이 SQL문으로 확인한 LIST는 모든 상품매입매출 목록이 나와서 잘못된 데이터가 있는지 확인하기 어렵다
-- 만약 이 SQL문을 실행 했을 때 일부 데이터가 IOLIST에는 있으나 DEPT에는 없으면 D.D_NAME과 D.D_CEO는 NULL값으로 나타날 것
-- 이 성질을 이용하여 D.D_NAME이나 D.D_CEO가 NULL인 것만 찾아보면 쉽게 확인이 가능하다
SELECT I.io_dname, D.d_name, I.io_ceo, D.d_ceo
FROM tbl_iolist I, tbl_dept D
WHERE I.io_dname = D.d_name AND I.io_ceo = D.d_ceo;

SELECT I.io_dname, D.d_name, I.io_ceo, D.d_ceo
FROM tbl_iolist I
    LEFT JOIN tbl_dept D
        ON I.io_dname = D.d_name AND I.io_ceo = D.d_ceo
WHERE D.d_name IS NULL OR D.d_ceo IS NULL;
-- 위 SQL을 실행 했을 때 LIST가 하나도 없어야 정상

SELECT io_dname
FROM tbl_iolist
WHERE io_dname IS NULL;
-- 거래처명이 누락된 것이 있는가

SELECT io_dname FROM tbl_iolist
WHERE io_dname IS NOT NULL ;
-- 거래처명을 가진 항목이 있는가?

SELECT io_price FROM tbl_iolist
WHERE io_price = 0;

SELECT io_price FROM tbl_iolist
WHERE io_price IS NULL;

SELECT I.io_dname, I.io_ceo, D.d_code
FROM tbl_iolist I, tbl_dept D ;

SELECT I.io_dname, I.io_ceo,
    (SELECT D.d_code FROM tbl_dept D
        WHERE I.io_dname = D.d_name AND I.io_ceo = D.d_ceo)
FROM tbl_iolist I;

ALTER TABLE tbl_iolist ADD io_dcode CHAR(5);

-- 거래처정보테이블에서 상품매입매출 테이블에 있는 거래처명과 대표자명이 일치하는 데이터를 찾아서 거래처코드를 상품매입매출에 UDPATE
UPDATE tbl_iolist I
SET io_dcode = (
    SELECT D.d_code FROM tbl_dept D
        WHERE I.io_dname = D.d_name AND I.io_ceo = D.d_ceo);
        
SELECT io_dcode, io_dname, io_ceo
FROM tbl_iolist 
ORDER BY io_dcode;