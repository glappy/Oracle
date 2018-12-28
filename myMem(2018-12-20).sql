-- 기존 테이블 삭제
DROP TABLE tbl_iolist ;
DROP TABLE tbl_dept;

-- 엑셀의 매입매출정보를 오라클로 임포트
-- 매입매출DB로부터 제2정규화를 해서 거래처 정보를 분리한다

DROP TABLE tbl_iolist;
CREATE TABLE tbl_iolist(
    io_id	    NUMBER		    PRIMARY KEY,
    io_date	    CHAR(10)    	NOT NULL,
    io_cname	nVARCHAR2(50)	NOT NULL,
    io_dname	nVARCHAR2(50)	NOT NULL,	
    io_dceo	    nVARCHAR2(50),		
    io_inout	nVARCHAR2(5)	NOT NULL,	
    io_quan 	NUMBER,	
    io_price	NUMBER,		
    io_total	NUMBER		
);

--데이터 임포트 확인
SELECT * FROM tbl_iolist;

-- 매입매출 구분해서 임포트 확인
SELECT io_inout, COUNT(*) FROM tbl_iolist
GROUP BY io_inout;

-- 매입매출정보에서 거래처정보를 다른 테이블로 분리해서 제2정규화 과정을 수행
-- 매입매출정보에서 거래처 정보 추출
-- 거래처명과 대표명을 그룹으로 묶어 리스트 추출
SELECT io_dname, io_dceo
FROM tbl_iolist
GROUP BY io_dname, io_dceo
ORDER BY io_dname;

--엑셀에서  정리된 거래처정보를 임포트 하기 위해 테이블 생성
CREATE TABLE tbl_dept(
    d_code CHAR(6) PRIMARY KEY,
    d_name nVARCHAR2(50) NOT NULL,
    d_ceo nVARCHAR2(20)
);

-- 엑셀로부터 거래처정보를 임포트
SELECT COUNT(*) FROM tbl_dept;

-- tbl_iolist에 tbl_dept와 연결할 칼럼 추가하고 tbl_dept로부터 연결작업을 수행
ALTER TABLE tbl_iolist ADD io_dcode CHAR(6);
--추가된 칼럼 확인
DESC tbl_iolist;

-- SUB QUERY
-- DML 내부에 다른 SELECT 문이 있는 SQL을 말한다
SELECT io_dname, io_dceo, io_dcode
FROM tbl_iolist;

--위 SQL에 SUB QUERY를 추가해서 DEPT테이블로부터 IOLIST를 조회
SELECT io_dname, io_dceo,
    (SELECT d_code FROM tbl_dept D
        WHERE D.d_name = tbl_iolist.io_dname AND
              D.d_ceo = tbl_iolist.io_dceo) AS dcode
FROM tbl_iolist ;

-- SUB QUERY 이용해서 TBA_DEPT로부터 TBL_IOLIST에 거래처코드 UPDATE하는 코드
UPDATE tbl_iolist I
SET io_dcode 
    =  (SELECT d_code FROM tbl_dept D
        WHERE D.d_name = I.io_dname AND
              D.d_ceo = I.io_dceo);
              
SELECT io_dcode, io_dname, io_dceo FROM tbl_iolist;              

-- TBL_IOLIST의 IO_DNAME과 IO_dceo 칼럼 삭제
ALTER TABLE tbl_iolist DROP COLUMN io_dname ;
ALTER TABLE tbl_iolist DROP COLUMN io_dceo ;
DESC tbl_iolist;

-- IOLIST와 DEPT테이블을 JOIN해서 조회하는 SQL
SELECT I.io_date, I.io_cname, I.io_dcode, D.d_name, D.d_ceo
FROM tbl_iolist I, tbl_dept D
WHERE I.io_dcode = D.d_code;
--이 JOIN은 EQ JOIN이라고 하며 TBL_IOLIST테이블 인에 TBL_DEPT 테이블에 없는 IO_DCODE가 없다는 보장이 있을 때 완전한 결과를 보여준다
-- 실제 상황에서는 TBL_DEPT에 없는 코드가 TBL_IOLIST에 있을 수 있다

--테스트 데이터를 만들기 위해서 
-- 임의의 데이터에 IO_DCODE를 변경 할 예정

SELECT * FROM tbl_iolist
WHERE io_dcode = 'D00100';

UPDATE tbl_iolist
SET io_dcode = 'D00500'
WHERE io_id = 306;

SELECT I.io_date, I.io_cname, I.io_dcode, D.d_name, D.d_ceo
FROM tbl_iolist I, tbl_dept D
WHERE I.io_dcode = D.d_code
    AND io_id BETWEEN 300 AND 310
ORDER BY I.io_id ;    

--JOIN하지 않은 상태로 매입매출 구분없이 합계 계산
SELECT COUNT(*), SUM(io_total)
FROM tbl_iolist
WHERE io_id BETWEEN 300 AND 310;

-- EQ JOIN으로 매입매출 구분없이 합계 계산
-- 실제 합계 금액, 개수가 차이 남
SELECT COUNT(*), SUM(io_total)
FROM tbl_iolist I, tbl_dept D
WHERE I.io_dcode = D.d_code;
    AND io_id BETWEEN 300 AND 310;
    
-- LEFT JOIN으로 매입매출 구분없이 합계 계산
SELECT COUNT(*), SUM(io_total)
FROM tbl_iolist I
    LEFT JOIN tbl_dept D
        ON I.io_dcode = D.d_code
WHERE io_id BETWEEN 300 AND 310;

-- LEFT JOIN은 왼쪽 테이블의 데이터는 모두 보여주고 왼쪽 테이블의 키와 일치하는 데이터가 오른쪽 테이블에 있으면 보여주고 없으면 NULL로 표시
-- 오른쪽 테이블에 일치하는 데이터 없어서 왼쪽 데이터 일부가 누락되어 통계가 잘못되는 이유를 확인하는 방법이며 실제 상황에서 상당히 유용한 JOIN
SELECT I.io_dcode, D.d_name, D.d_ceo
FROM tbl_iolist I
    LEFT JOIN tbl_dept D
        ON I.io_dcode = D.d_code
WHERE io_id BETWEEN 300 AND 310;

-- IOLIST로부터 거래처정보를 분리. 거래처정보를 GROUP으로 묶어 조회. 엑셀로 복사. CODE값 부여.
-- 테이블 생성. 임포트. IOLIST에 DCODE 칼럼 생성. 거래처정보 테이블에서 IOLIST의 DCODE칼럼에 UPDATE

SELECT io_dname
FROM tbl_iolist
GROUP BY io_dname;