--myMem으로 접속한 화면
-- TBL_IOLIST에서 상품정보테이블을 분리해서 제2정규화 수행
-- TBL_IOLIST 개수를 확인
SELECT COUNT(*) FROM tbl_iolist ;

-- 전체 데이터가 아닌 조건에 맞는 데이터만 제한해서 확인할 때는 WHERE절에서 칼럼 = 조건 형식을 이용
-- 특정 조건을 설정하기 보단 개수를 제한해서 보고 싶을때 오라클 전용 SQL 키워드 중 ROWNUM이라는 칼럼을 사용
-- ROWNUM은 저장된 데이터의 열의 순번을 가상으로 표시하는 오라클 DUMMY칼럼
SELECT ROWNUM io_date, io_cname, io_dcode 
FROM tbl_iolist ;

-- ROWNUM을 이용하면 데이터리스트 중 일부를 조회할 수 있다
SELECT ROWNUM, io_date, io_cname
FROM tbl_iolist 
WHERE ROWNUM <= 10;

-- ROWNUM을 이용해서 10번째부터 20번째까지 조회하고 싶으면..
SELECT ROWNUM, io_date, io_cname
FROM tbl_iolist
WHERE ROWNUM BETWEEN 10 AND 20;

-- MYSQL
-- SELECT * FROM tbl_iolist LIMIT 10;

SELECT * FROM tbl_iolist WHERE ROWNUM < 10;

-- 상품정보를 상품테이블로 분리하기 위해서 상품이름 리스트 만든다
SELECT io_cname
FROM tbl_iolist
GROUP BY io_cname ;

SELECT io_cname, io_inout, io_price
FROM tbl_iolist
WHERE ROWNUM <10;

-- 현재 조회된 데이터에서 io_inout이 '매입'이면 io_price는 '매입단가'일 것이고 '매출'이면 '매출단가'일 것으로 생각
-- io_inout에 따라 단가를 다르게 표시해 보자
SELECT io_cname, io_inout, -- 뺄것
    DECODE(io_inout,'매입',io_price) 매입단가,
    DECODE(io_inout,'매출',io_price) 매출단가
FROM tbl_iolist
WHERE ROWNUM < 10;

SELECT io_cname, io_inout,
    AVG(DECODE(io_inout,'매입',io_price)) 매입단가,
    AVG(DECODE(io_inout,'매출',io_price)) 매출단가
FROM tbl_iolist
GROUP BY io_cname,io_inout;

SELECT io_cname, -- 뺄 것
    DECODE(io_inout,'매입',io_price) 매입단가,
    DECODE(io_inout,'매출',io_price) 매출단가
FROM tbl_iolist
GROUP BY io_cname,io_inout, DECODE(io_inout, '매입',io_price),DECODE(io_inout,'매출',io_price)
ORDER BY io_cname;

-- 상품테이블 생성
CREATE TABLE tbl_product(
    p_code  	CHAR(9)		PRIMARY KEY,
    p_name	    nVARCHAR2(50)	NOT NULL,	
    p_iprice	NUMBER,
    p_oprice	NUMBER		
);

SELECT COUNT(*) FROM tbl_product ;
DROP TABLE tbl_product ;

--상품정보 테이블을 생성하고 데이터를 만들었으니 매입매출정보에서 상품코드 칼럼 생성하고 상품코드 칼럼 데이터를 업데이트 하고 상품명 칼럼을 삭제한다
ALTER TABLE tbl_iolist ADD io_pcode CHAR(9) ;
-- 서브쿼리 이용해서 iolist와 product table간의 관계를 보자
SELECT I.io_cname, 
    (SELECT P.p_name FROM tbl_product P 
        WHERE P.p_name = I.io_cname),
        (SELECT P.p_code FROM tbl_product P 
        WHERE P.p_name = I.io_cname)
FROM tbl_iolist I;


-- PRODUCT TABLE에서 상품코드 조회해서 IOLIST TABLE의 IO_PCODE칼럼에 UPDATE 하자
UPDATE tbl_iolist
SET io_pcode =
    (SELECT p_code FROM tbl_product  P
        WHERE P.p_name = I.io_cname);
        
-- UPDATE후에 JOIN으로 검증        
SELECT I.io_pcode, P.p_code, I.io_cname, P.p_name
FROM tbl_iolist I
     LEFT JOIN tbl_product P
            ON I.io_pcode = P.p_code
ORDER BY I.io_pcode ;            

--상품명 칼럼을 삭제
ALTER TABLE tbl_iolist DROP COLUMN io_cname ;
DESC tbl_iolist ;

SELECT * FROM tbl_iolist
WHERE ROWNUM < 10;

--TBL_IOLIST는 제2정규화가 완료되었다
--매입매출명세를 보면서 상품명과 거래처명을 같이 확인하고 싶다
--매입매출명세와 상품명 같이 보기
SELECT I.io_date, I.io_pcode, P.p_name, I.io_inout, 
        I.io_price, I.io_quan, I.io_price*I.io_quan AS 합계
FROM tbl_iolist I
    LEFT JOIN tbl_product P
        ON I.io_pcode = P.P_code;
        
-- 매입매출명세와 거래처 정보 같이 보고 싶을때
SELECT I.io_date, I.io_dcode, I.io_inout, 
        I.io_price, I.io_quan, I.io_price*I.io_quan AS 합계
FROM tbl_iolist I
    LEFT JOIN tbl_dept D
        ON I.io_dcode = D.d_code;

--매입매출명세를 보면서 상품정보, 거래처정보를 같이 보고 싶다
SELECT I.io_date, I.io_pcode, P.p_name, I.io_inout, 
        I.io_price, P.p_iprice, P.p_oprice, I.io_quan, I.io_price*I.io_quan AS 합계
FROM tbl_iolist I
    LEFT JOIN tbl_product P
        ON I.io_pcode = P.p_code
        
    LEFT JOIN tbl_dept D
        ON I.io_dcode = D.d_code ;
        
-- 매입매출명세와 상품정보, 거래처정보를 JOIN해서 조회했더니 쿼리가 너무 복잡하다
-- 자주 사용할 것 같다면?
-- SQL을 VIEW로 생성해준다
CREATE VIEW io_dept_product_view
AS 
SELECT I.io_date, I.io_pcode, P.p_name, I.io_inout, I.io_dcode,
        I.io_price, P.p_iprice, P.p_oprice, I.io_quan, I.io_price*I.io_quan AS 합계
FROM tbl_iolist I
    LEFT JOIN tbl_product P
        ON I.io_pcode = P.p_code
        
    LEFT JOIN tbl_dept D
        ON I.io_dcode = D.d_code ;
        
SELECT * FROM io_dept_product_view ;        

SELECT io_inout, COUNT(*), SUM(io_total)
FROM tbl_iolist 
WHERE io_date BETWEEN '2018-03-01' AND '2018-03-31'
    AND io_inout = '매입'
GROUP BY io_inout ;

SELECT io_inout, COUNT(*), SUM(io_total)
FROM tbl_iolist 
WHERE io_inout = '매입' AND io_date BETWEEN '2018-03-01' AND '2018-03-31'
GROUP BY io_inout ;