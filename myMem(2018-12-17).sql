-- 여기는 myMem 사용자 화면입니다
CREATE TABLE tbl_iolist(
    id      	NUMBER		PRIMARY KEY,
    io_date 	CHAR(10)	NOT NULL,
    io_cname	nVARCHAR2(30)	NOT NULL,	
    io_dname	nVARCHAR2(50)	NOT NULL,	
    io_ceo	    nVARCHAR2(30),
    io_inout	nVARCHAR2(5),
    io_quan	    NUMBER,
    io_price	NUMBER,
    io_total	NUMBER
);

SELECT COUNT(*) 
FROM tbl_iolist ;

SELECT COUNT(*), SUM(io_total)
FROM tbl_iolist 
WHERE io_inout = '매입';
-- 매입과 매출을 구분해서 개수와 합계를 확인해야 데이터 사용 가치가 있다
-- 매입과 매출을 구분하고 한꺼번에 확인


-- 일자별로 구분하여 매입과 매출의 개수와 총합계
SELECT io_date, io_inout, COUNT(io_total), SUM(io_total)
FROM tbl_iolist
GROUP BY io_date, io_inout
ORDER BY io_date;

-- 문자열 함수 몇가지
SELECT 'KOREA' FROM DUAL ;
SELECT 'Republic of Korea' FROM DUAL ;

-- 문자열을 대,소문자로
SELECT UPPER('korea') FROM DUAL ;
SELECT LOWER('KOREA') FROM DUAL ;

-- 단어의 첫글자를 대문자로 변경
SELECT INITCAP('republic of korea') FROM DUAL ;

SELECT LENGTH('republic of korea') FROM DUAL ;
--LENGTH함수를 사용할 때 간혹 한글개수를 *2의 값으로 표시하는 경우가 있다
-- 이때 한글의 정확한 개수를 알고자 할 때는 '' 문자열 앞에 N을 붙여준다

SELECT LENGTH(N'대한민국') FROM DUAL ;
--데이터의 저장용량을 BYTE단위로 보여준다
SELECT LENGTHB('대한민국')FROM DUAL ;
--OF가 REPUBLIC OF KOREA문자열 중 몇번째 위치에 있나?
SELECT INSTR ('Republic of Korea', 'of') FROM DUAL ;
-- 앞의 문자열을 4째 자리부터 3글자
-- 오라클은 첫글자 위치를 0아닌 1부터 시작한다
SELECT SUBSTR('Republic of Korea',4,3) FROM DUAL ;

--표준 SQL에서 왼쪽부터 3번째 위치의 글자(오라클에서는 안됨)
--SELECT LEFT('Republic',3) FROM DUAL ;
-- 3번째부터 2글자
--SELECT MID('Republic',3,2) FROM DUAL ;

--KOREA문자열을 포함하여 총 20개 문자열을 생성하되 빈 곳은 *로 채울 것
SELECT LPAD('KOREA',20,'*') FROM DUAL ;
-- 숫자1을 문자열로 바꾸고 총 5개 문자열로 생성하되 빈곳은 0으로 채울 것
SELECT LPAD(1,5,'0') FROM DUAL ;

SELECT RPAD(1,5,'0'),LPAD(1,5,'0') FROM DUAL ;
INSERT test(t_num) VALUE(LPAD(1,3,'0') ;

--공백을 제거
SELECT LTRIM('  KOREA   대한민국  ') FROM DUAL ;
SELECT RTRIM('  KOREA   대한민국  ') FROM DUAL ;

SELECT TRIM ('     KOREA     ') FROM DUAL ;
--TRIM함수의 특이한 사용
-- 문자열의 앞뒤에 붙은 A문자들을 모두 삭제하라
SELECT TRIM('a' FROM 'aaabbbKOREAnnnaaa') FROM DUAL ;

-- 일자별로 거래 구분에 따른 개수와 합계를 확인하고자 할 때
-- 그 중에 2018-03-01~2018-03-31까지 데이터로 한정하려면
SELECT io_date, io_inout, COUNT(io_total), SUM(io_total)
FROM tbl_iolist
WHERE io_date BETWEEN '2018-03-01' AND '2018-03-31'
GROUP BY io_date, io_inout
ORDER BY io_date;

-- 월별, 연별로 계산하고 싶다면?
CREATE VIEW 월별통계
AS
SELECT SUBSTR(io_date,1,7) AS 월별, 
       io_inout, COUNT(io_total)AS 개수, SUM(io_total)AS 합계
FROM tbl_iolist
GROUP BY SUBSTR(io_date,1,7),io_inout
ORDER BY SUBSTR(io_date,1,7) ;

SELECT * FROM 월별통계 ;
WHERE 월별 BETWEEN '2018-03' AND '2018-06' ;

CREATE VIEW 거래처통계
AS
SELECT io_dname AS 거래처, 
       io_inout, COUNT(io_total)AS 개수, SUM(io_total)AS 합계
FROM tbl_iolist
GROUP BY io_dname, io_inout
ORDER BY io_inout ;

SELECT * FROM 거래처통계;

-- ERP 상에서 '월별'이라고 하면 '년-월'을 말한다
CREATE VIEW 상품통계
AS
SELECT io_cname AS 상품명, SUBSTR(io_date,1,7) AS 월별,
        io_inout, COUNT(io_total) AS 개수, SUM(io_total) AS 합계
FROM tbl_iolist
GROUP BY io_cname, SUBSTR(io_date,1,7), io_inout
ORDER BY io_cname;

SELECT * FROM 상품통계;
DROP VIEW 상품통계;

--상품중 '링키바'의 매입매출리스트 확인
SELECT io_cname, SUBSTR(io_date,1,7), COUNT(*), SUM(io_total)
FROM tbl_iolist
WHERE io_cname = ' 링 키 바'
GROUP BY io_cname, SUBSTR(io_date,1,7)
ORDER BY io_cname;