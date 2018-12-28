-- 여기는 myMem으로 접속한 화면입니다

SELECT * FROM tbl_iolist ;

-- 거래처 롯데유통의 자료만 확인하고 싶을때
SELECT * FROM tbl_iolist 
WHERE io_dname = '(주)동양엔지니어링(광주남구롯데)';

-- tbl_iolist는 상품이름과 거래처명 거래처대명을 직접 가지고 있기 때문에 
-- 상품이나 거래처명 거래처대표명을 변경, 삭제하려고 하면 다수의 데이터를 변경해야 한다
-- 다수의 데이터를 변경하는 것은 DB사용환경 규칙에서는 바람직하지 않다
-- 현재의 io_list 테이블을 분리작업하여 데이터 변경이 다수 발생하지 않도록 조치를 취해야 한다
-- 제2정규화. 2NF

-- tbl_iolist로부터 거래처명, 거래처대표명을 묶어서 모아보자
SELECT io_dname, io_ceo
FROM tbl_iolist 
ORDER BY io_dname;

SELECT io_dname,io_ceo
FROM tbl_iolist
GROUP BY io_dname, io_ceo
ORDER BY io_dname;

--거래처 테이블 생성
CREATE TABLE tbl_dept(
    d_code	CHAR(4)	PRIMARY KEY,
    d_name	nVARCHAR2(50) NOT NULL,	
    d_ceo	nVARCHAR2(20) NOT NULL,	
    d_tel	nVARCHAR2(20),
    d_addr	nVARCHAR2(50),
    d_fax	nVARCHAR2(20),
    d_sid	CHAR(14)		
);

SELECT COUNT(*) FROM tbl_dept;
SELECT * FROM tbl_dept;

-- io_list 테이블에서 거래처명, 대표자명 제거하고 거래처코드 칼럼으로 대체
-- JOIN해서 잘못 연결된 데이터가 없는가 확인
SELECT I.io_dname, D.d_name, D.d_code
FROM tbl_iolist I, tbl_dept D
WHERE I.io_dname = D.d_name ;

-- io_list에는 있으나 dept테이블에는 없는 것이 있는가
SELECT I.io_dname, D.d_name, D.d_code
FROM tbl_iolist I, tbl_dept D
    LEFT JOIN tbl_dept D
    ON I.io_dname = D.d_name ;
    
--iolist에 dept테이블의 d_code와 연결할 칼럼 추가
ALTER TABLE tbl_iolist ADD io_dcode CHAR(4);
DESC tbl_iolist ;

-- SUB QUERY
SELECT I.io_dname, (SELECT D.d_name FROM tbl_dept D WHERE D.d_name = I.io_dname AND D.d_ceo = I.io_ceo) AS dname
FROM tbl_iolist I
ORDER BY D.d_name;

SELECT d_name,d_ceo, COUNT(*)
FROM tbl_dept
GROUP BY d_name,d_ceo
HAVING COUNT(*) > 1;

-- SUB QUERY 사용햇 dept table에서 d_code를 iolist에 update한다
UPDATE tbl_iolist I
SET io_dcode = 
    (SELECT d_code FROM tbl_dept D 
    WHERE I.io_dname = D.d_name AND I.io_ceo = D.d_ceo);
    
SELECT io_dcode, io_dname, io_ceo FROM tbl_iolist ;

-- e.iolist와 dept테이블을 JOIN해서 거래처명 대표를 같이 조회하는 SQL
SELECT I.io_dcode, D.d_name, D.d_ceo
FROM tbl_iolist I
    LEFT JOIN tbl_dept D
        ON I.io_dcode = D.d_code;
        
-- f.iolist에서 io_dname, io_ceo칼럼을 삭제해도 된다
ALTER TABLE tbl_iolist DROP COLUMN io_ceo ;

DESC tbl_iolist ;