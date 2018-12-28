-- 여기는 user1으로 접속한 화면입니다
-- tbl_addr을 일단 삭제
DROP TABLE tbl_addr;

-- tbl_addr 생성
CREATE TABLE tbl_addr (
    id NUMBER PRIMARY KEY, -- 기본키, PK
    st_name CHAR(50) NOT NULL, -- 이름은 절대 빈칸 금지
    st_age NUMBER(3),
    st_addr VARCHAR2(125)
);

INSERT INTO tbl_addr
VALUES(0,'홍길동',12,'서울시');

INSERT INTO tbl_addr
VALUES(1,'홍길동',12,'서울시');

INSERT INTO tbl_addr
VALUES(2,'이몽룡',16,'남원시');

-- 데이터를 추가하면서 0번 항목과 1번 항목을
-- 잘못 확인하여 같은 데이터인것으로 인식하고
-- INSERT 처리를 해 버렸다.

SELECT * FROM tbl_addr ;
-- SELECT로 데이터를 확인 했더니 두 줄의 데이터가
-- 한사람의 데이터로 중복 된것이 확인 되었다.
-- 다시 원본 문서를 봤더니
-- 두번째 홍길동이 주소가 서울이 아닌 부산인 것으로 확인?榮.
-- 그래서, 두번째 홍길동의 주소를 부산으로 수정하려고 한다.
-- 다시한번 SELECT 해서 홍길동의 데이터를 확인해자.
SELECT * 
FROM tbl_addr
WHERE st_name = '홍길동'; -- st_name칼럼의 값이 홍길동 인경우만 보여라

-- 데이터 변경 실행
UPDATE tbl_addr
SET st_addr = '부산시'
WHERE id = 1;

-- 확인
SELECT *
FROM tbl_addr ;


INSERT INTO tbl_addr
VALUES(3,'성춘향',16,'익산시');
INSERT INTO tbl_addr
VALUES(4,'성춘향',16,'익산시');
-- 실수로 성춘향 데이터를 2번 중복 입력했다
-- 그래서 나중에 입력한 데이터를 삭제하려고 한다
SELECT * FROM tbl_addr ;

-- 성춘향 데이터(들)을 확인해 봐야 한다
SELECT *
FROM tbl_addr
WHERE st_name = '성춘향';

-- 성춘향의 2번째 데이터인 id가 4인 데이터를 삭제
DELETE FROM tbl_addr
WHERE id = 4;

SELECT *
FROM tbl_addr ;

-- DataBase의 Table 생성할때
-- 사용하고자 하는 칼럼중에 UNIQUE 한 항목이 있다면
-- 그 칼럼을 PRIMARY KEY = PK 로 설정하는 것이 좋고
-- 그렇지 않으면 모든 Table에는 id라는 칼럼을 임의 추가해서
-- 해당 칼럼을 PK로 선언해 주는 것이 좋다.


CREATE TABLE tbl_postno (
    postno CHAR(5) PRIMARY KEY, -- 개체 무결성 보장용
    street nVARCHAR2(125) NOT NULL UNIQUE,
    -- 데이터를 비워두거나 이미 같은 값이 입력되어 있으면
    -- 다시 입력되지 않도록 하는 옵션
    addr nVARCHAR2(125)
);