-- 여기는 myuser로 접속한 화면입니다
-- 
CREATE TABLE tbl_iolist(
    id      	NUMBER	PRIMARY KEY,
    io_date	    CHAR(10)	NOT NULL,
    io_cname	nVARCHAR2(50)	NOT NULL,
    io_dname	nVARCHAR2(30)	NOT NULL,
    io_dceo	    nVARCHAR2(10),
    io_inout	nVARCHAR2(5),
    io_quan	    NUMBER,
    io_price	NUMBER,	
    io_total	NUMBER	
);
SELECT * 
FROM tbl_iolist ;
SELECT COUNT(*) 
FROM tbl_ioList ;

DELETE FROM tbl_iOlist ;

SELECT io_date, io_cname, io_dname, io_inout, io_total 
FROM tbl_ioList 
WHERE io_date>='2018-02-01' AND io_date<='2018-02-28'
--AND io_inout = '매입' 
ORDER BY io_date;

SELECT COUNT(*) ,SUM(io_total) 
FROM tbl_iolist ;
-- 통계함수를 이용해서 개수와 합계 구하기
SELECT COUNT (io_total) AS 개수, SUM(io_total) AS 합계
FROM tbl_iolist;

-- 통계함수 이용해서 개수와 합계 구하되, 매입합계와 매출합계 따로 계산하기
-- 매입,매출을 구분하는 칼럼 : io_inout
SELECT io_inout, COUNT(io_total), SUM(io_total)
FROM tbl_iolist
GROUP BY io_inout ;

-- 개수와 합계계산
-- 조건 : 날짜별로 조건 부여해서 개수와 합계계산
-- 날짜 구분하는 칼럼 : io_date
SELECT io_date, COUNT(*), SUM(io_total)
FROM tbl_iolist
GROUP BY io_date
ORDER BY io_date ;

-- 조건 : 날짜별로 묶고 매입, 매출로 구분하여 개수와 합계 계산
SELECT io_date, io_inout, COUNT(*), SUM(io_total)
FROM tbl_iolist
GROUP BY io_date, io_inout
ORDER BY io_date;

SELECT io_inout, io_date, COUNT(*), SUM(io_total)
FROM tbl_iolist
GROUP BY io_inout, io_date
ORDER BY io_date;

SELECT io_inout, io_date, COUNT(*), SUM(io_total)
FROM tbl_iolist
WHERE io_date BETWEEN '2018-03-01' AND '2018-03-31'
GROUP BY io_inout, io_date
ORDER BY io_date;

-- 합계금액100만원 이상인 항목
SELECT io_inout, io_date, COUNT(*), SUM(io_total)
FROM tbl_iolist
WHERE io_date BETWEEN '2018-03-01' AND '2018-03-31'
GROUP BY io_inout, io_date
HAVING SUM(io_total) >= 500000
ORDER BY io_date;
-- 통계함수를 사용하는 경우
-- 통계함수 결과에 따라 추출하는 리스트를 제한하고 싶을 때(필요한 범위 값만 보기)
-- WHERE에 조건을 부여하면 안된다
-- HAVING이라는 절을 사용해야 한다

SELECT io_inout, io_date, COUNT(*), SUM(io_total)
FROM tbl_iolist
GROUP BY io_inout, io_date
HAVING SUM(io_total) >= 500000 AND io_date BETWEEN '2018-03-01' AND '2018-03-31'
ORDER BY io_date;
-- HAVING절은 모든 통계를 계산한 후 조건으로 제한하기 때문에 모든 데이터에 카운트와 썸을 계산하고 비로소 날짜 범위를 제한한다
-- DB SELECT에서 최악의 시간 소요가 된다