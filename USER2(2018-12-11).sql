-- 여기는 user2 화면입니다
CREATE TABLE tbl_users (
    str_userid CHAR(12) PRIMARY KEY,
    str_name nVARCHAR2(50) NOT NULL,
    str_tel nVARCHAR2(15),
    str_addr nVARCHAR2(50)
);

INSERT INTO tbl_users
VALUES('001','홍길동','010-111-0001','서울시');
INSERT INTO tbl_users
VALUES('002','이몽룡','010-111-0002','서울시');
INSERT INTO tbl_users
VALUES('003','성춘향','010-111-0003','서울시');
INSERT INTO tbl_users
VALUES('004','장녹수','010-111-0004','서울시');
INSERT INTO tbl_users
VALUES('005','임꺽정','010-111-0005','서울시');

-- 현재 작성된 tbl_users 테이블에 str_userid를 12자리로 
-- 설정을 했는데, 입력을 하다 보니 너무 많이 자리를 차지한다.
-- 그래서 현재 입력중인 id 개수인 3개로 크기를 바꿔 보려고한다.
-- 이미 생성된 테이블의 칼럼 형식을 변경
-- DDL 명령중 ALTER 명령을 사용한다.
ALTER TABLE tbl_users MODIFY str_userid CHAR(6);
ALTER TABLE tbl_users MODIFY str_name nVARCHAR2(5);
-- CHAR 형 데이터는 보이는 데이터와 달리 실제 크기만큼
-- 공백등으로 이미 채워져 있어서 크기를 줄이기가 안된다.
-- (n)VARCHAR2 형 데이터는 보이는 데이터중 
-- 가장 길이가 긴 데이터 만큼은 크기를 줄일 수 있다.

-- INSERT를 실행할때 전체칼럼이 아닌 특정칼럼만 값이 있는경우
 INSERT INTO tbl_users(str_userid, str_name)
 VALUES('006','트럼프');

-- INSERT를 실행할때 데이터의 위치(순서)를 바꾸자 할때는
-- TABLE(칼럼리스트)의 칼럼리스트의 순서를 바꾸면 된다.
INSERT INTO tbl_users(str_name,str_userid)
 VALUES('오바마','007');

SELECT str_userid, str_name, str_tel, str_addr
FROM tbl_users;

SELECT * FROM tbl_users;

-- SELECT를 실행할때 특정한 칼럼들만 나열해서 보고자 할때
-- 칼럼리스트 : Projection
SELECT str_name, str_tel
FROM tbl_users ;

SELECT str_tel, str_name
FROM tbl_users;

SELECT * 
FROM tbl_users
WHERE str_name = '홍길동' ;

SELECT *
FROM tbl_users
WHERE str_addr = '서울시' ;

SELECT *
FROM tbl_users
WHERE str_addr = '서울시' AND str_name = '홍길동';

-- tbl_users 테이블에서 id가 003부터 006까지 데이타만
SELECT *
FROM tbl_users
WHERE str_userid >= '003' AND str_userid <= '006';

SELECT *
FROM tbl_users
WHERE str_userid BETWEEN '003' AND '006'  ;

SELECT * FROM tbl_users;

-- SQL의 통계함수
-- 현재 tbl_users에 저장된 데이터 개수가 몇개냐?
-- SUM, COUNT, AVG, MIN, MAX
-- 칼럼을 감싸는 함수
SELECT COUNT(*) FROM tbl_users;
SELECT MIN(str_userid) FROM tbl_users;
SELECT MAX(str_userid) FROM tbl_users;

SELECT COUNT(*) ,
    MIN(str_userid),
    MAX(str_userid)
FROM tbl_users;    

SELECT COUNT(*) AS 개수,
    MIN(str_userid) AS 작은값,
    MAX(str_userid) AS 큰값
FROM tbl_users;   