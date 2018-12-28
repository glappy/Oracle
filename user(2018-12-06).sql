-- 여기는 user1 입니다
SELECT 30*40 FROM DUAL;
SELECT '대한민국만세' FROM DUAL;

-- 현재는 DB 저장소가 없는 상태
-- DB에서 어떤 일을 수행하기 전에 가장먼저
-- 저장소를 생성해야 한다.
-- 저장소중에서 표준 DB의 대표 저장소인 TABLE을 생성
CREATE TABLE tbl_addr (
    name CHAR(50), -- 50글자 범위의 문자를 저장
    age NUMBER(10,1), -- 정수부 10개, 소수부 1개 
    addr CHAR(50)
);
DROP TABLE tbl_addr ;

CREATE TABLE tbl_addr (
    name VARCHAR2(50), -- 50글자 범위의 문자를 저장
        -- 만약 글자수가 50글자가 안되면
        -- 남은 공간은 압축해서 저장
    age NUMBER, -- 정수 38자리
    addr VARCHAR2(125)
);

-- TABLE을 설계할때
-- 검색하는 KEY로 사용될 가능성이 많은 항목(column)은
-- 공간 낭비를 감안하고라도 CHAR 형으로 선언 하는 것이
-- 효율적이다.
-- 숫자가 저장되는 부분
-- NUMBER라는 키워드 만으로 설정이 가능하지만
-- 가급적 최대자릿수를 고려하여 값을 지정해주는 것이
-- 좋다
CREATE TABLE tbl_addr (
    st_name CHAR(10) NOT NULL,
    st_age NUMBER(3),
    st_addr VARCHAR2(255)
);
-- 제약조건 1 
--  NOT NUL : 해당 칼럼에 데이터가 없으면
--  그 줄(ROW)의 데이터는 추가하 하지 마라

-- 데이터 추가 테스트
-- CRUD 중의 C(Create)
-- 이미 생성된 TABLE에 데이터를 1줄 추가하는 것
INSERT INTO tbl_addr
VALUES ('홍길동',12,'서울시 영등포구') ;

-- 추가된 데이터 확인 테스트
-- CRUD 중의 R(Read)
-- TABLE 에 저장된 데이터를 확인
SELECT st_name,st_age,st_addr
FROM tbl_addr ;

INSERT INTO tbl_addr
VALUES('이몽룡',16,'전라북도 남원시');

SELECT st_name, st_age, st_addr
FROM tbl_addr;

SELECT st_name
FROM tbl_addr;

SELECT st_age
FROM tbl_addr;

SELECT st_addr
FROM tbl_addr ;

SELECT st_addr, st_name
FROM tbl_addr ;

SELECT * 
FROM tbl_addr ;

UPDATE tbl_addr SET st_name = '성춘향';
DELETE FROM tbl_addr ;

SELECT *
FROM tbl_addr ;

DROP TABLE tbl_addr ;

CREATE TABLE tbl_addr (
    id NUMBER PRIMARY KEY,
    st_name CHAR(50) NOT NULL,
    st_age NUMBER(3),
    st_addr VARCHAR2(255)
);
INSERT INTO tbl_addr VALUES (0,'홍길동',12,'서율시');
INSERT INTO tbl_addr VALUES (1,'이몽룡',12,'남원시');
INSERT INTO tbl_addr VALUES (2,'홍길동',12,'광주시');
INSERT INTO tbl_addr VALUES (3,'성춘향',12,'익산시');
INSERT INTO tbl_addr VALUES (4,'월매',12,'남원');

SELECT *
FROM tbl_addr ;