-- myMem으로 접속한 화면입니다
-- GROUP BY를 이용해서 테이블로부터 중복되지 않은 리스트 추출하기
-- SELECT를 실행 했을 때 같은 값을 가진 리스트가 다수 나타날 때 대표값 1개씩만 추출하고 싶다면 GROUP BY 사용
SELECT io_inout
FROM tbl_iolist;

SELECT io_inout
FROM tbl_iolist
GROUP BY io_inout ;

-- 중복되지 않은 상품 리스트를 추출하는 SQL
SELECT io_cname
FROM tbl_iolist
GROUP BY io_cname ;

SELECT d_name
FROM tbl_dept ;

--  거래처 명 중 중복된 것 묶어서 LIST로 보여줌
SELECT d_name
FROM tbl_dept
GROUP BY d_name ;

SELECT d_name, d_ceo
FROM tbl_dept
GROUP BY d_name, d_ceo ;

SELECT io_cname, COUNT(io_cname)
FROM tbl_iolist
GROUP BY io_cname;