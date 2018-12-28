-- 여기는 myMem으로 접속한 화면입니다

DROP TABLE tbl_score;
CREATE TABLE tbl_score(
    g_id	    NUMBER		    PRIMARY KEY,
    g_stname	nVARCHAR2(50)	NOT NULL,
    g_subject	nVARCHAR2(10)	NOT NULL,
    g_score	    NUMBER		
);

SELECT COUNT(*) FROM tbl_score;

SELECT g_stname AS 이름, SUM(g_score) AS 합계
FROM tbl_score
GROUP BY g_stname
ORDER BY g_stname;
-- SUM으로는 문자열을 더할 수 없음. 숫자형 칼럼만 매개변수로 사용. SUM(g_stname) - X

SELECT SUM(g_score) AS intSum
FROM tbl_score;
-- 함수() = METHOD()
-- 키워드 = 명령어
-- SQL에서 함수()는 거의 모두 매개변수(칼럼명)를 필요로 한다

-- 학생별로 점수를 한줄에 나열하는 SQL 작성
-- 이름   국어  영어  수학
-- 학생별로 그룹 지을 것
SELECT g_stname
FROM tbl_score
GROUP BY g_stname;

-- ※ ORACLE 전용함수
-- 국어, 영어 같은 칼럼들은 현재 TBL_SCORE에 없음
-- 점수를 계산해서 변수(칼럼)에 저장해야 한다는 소리
-- 점수를 계산하는 코드를 오라클의 함수로 작성한다

SELECT g_subject, DECODE(g_subject, '국어', 100, 0) AS 국어
FROM tbl_score
WHERE ROWNUM<10;
-- IF와 같음. g_subject에 있는 값이 '국어'이면 100으로 표시하고 아니면 0으로 표시하라

SELECT g_subject, DECODE(g_subject, '국어', g_score, 0) AS 국어,
    DECODE(g_subject, '수학', g_score, 0) AS 수학,
    DECODE(g_subject, '영어', g_score, 0) AS 영어,
    DECODE(g_subject, '과학', g_score, 0) AS 과학,
    DECODE(g_subject, '미술', g_score, 0) AS 미술,
    DECODE(g_subject, '국사', g_score, 0) AS 국사
FROM tbl_score
WHERE ROWNUM<20;

SELECT g_subject, SUM(DECODE(g_subject, '국어', g_score, 0)) AS 국어,
    SUM(DECODE(g_subject, '수학', g_score, 0)) AS 수학,
    SUM(DECODE(g_subject, '영어', g_score, 0)) AS 영어,
    SUM(DECODE(g_subject, '과학', g_score, 0)) AS 과학,
    SUM(DECODE(g_subject, '미술', g_score, 0)) AS 미술,
    SUM(DECODE(g_subject, '국사', g_score, 0)) AS 국사
FROM tbl_score 
WHERE ROWNUM<20
GROUP BY g_subject;

CREATE VIEW 성적일람표
AS
SELECT g_stname,
    SUM(DECODE(g_subject, '국어', g_score, 0)) AS 국어,
    SUM(DECODE(g_subject, '수학', g_score, 0)) AS 수학,
    SUM(DECODE(g_subject, '영어', g_score, 0)) AS 영어,
    SUM(DECODE(g_subject, '과학', g_score, 0)) AS 과학,
    SUM(DECODE(g_subject, '미술', g_score, 0)) AS 미술,
    SUM(DECODE(g_subject, '국사', g_score, 0)) AS 국사
FROM tbl_score 
GROUP BY g_stname
ORDER BY g_stname;
-- 칼럼과 관련해서 ALTER TABLE은 쓰지 말것. 데이터가 많아질 경우 엄청난 시간과 힘이 낭비됨
-- 현재 이상태로 테이블 구조 변경 않고도 INSERT로 추가할 수 있음

SELECT * FROM 성적일람표;

SELECT * FROM tbl_iolist
WHERE ROWNUM<10;

SELECT *
FROM tbl_iolist I
    LEFT JOIN tbl_dept D
        ON I.io_dcode = D.d_code;
        
-- 거래처별로 거래금액이 얼마인지 알고 싶을때?
SELECT I.io_dcode, D.d_name, D.d_ceo,
    SUM(I.io_price*I.io_quan) 거래금액
FROM tbl_iolist I
    LEFT JOIN tbl_dept D
        ON I.io_dcode = D.d_code
GROUP BY I.io_dcode, D.d_name, D.d_ceo;
-- 단순히 거래처별로 거래금액 합산한 결과(매입이 얼마, 매출이 얼마?)

SELECT I.io_dcode, D.d_name, D.d_ceo,
    SUM(DECODE(I.io_inout,'매입',I.io_price*I.io_quan,0)) 매입금액,
    SUM(DECODE(I.io_inout,'매출',I.io_price*I.io_quan,0)) 매출금액
FROM tbl_iolist I
    LEFT JOIN tbl_dept D
        ON I.io_dcode = D.d_code
GROUP BY I.io_dcode, D.d_name, D.d_ceo;

-- 제2정규화
SELECT g_stname
FROM tbl_score
GROUP BY g_stname
ORDER BY g_stname;

CREATE TABLE tbl_student(
    st_num	CHAR(5)		PRIMARY KEY,
    st_name	nVARCHAR2(50)	NOT NULL
    
);

SELECT * FROM tbl_student;

DROP TABLE tbl_student;

SELECT SC.g_stname, ST.st_name
FROM tbl_score SC
    LEFT JOIN tbl_student ST
        ON SC.g_stname = ST.st_name;

ALTER TABLE tbl_score ADD g_stnum CHAR(5);

SELECT* FROM tbl_score;

UPDATE tbl_score SC
SET SC.g_stnum =(
        SELECT ST.st_num FROM tbl_student ST
        WHERE SC.g_stname= ST.st_name);
    
-- 업데이트 후 검증
SELECT SC.g_stnum, ST.st_name, SC.g_stnum, ST.st_name
FROM tbl_score SC
    LEFT JOIN tbl_student ST
        ON SC.g_stnum = ST.st_num
WHERE ST.st_name IS NULL;

-- TBL_SCORE로부터 학생이름 칼럼 삭제
ALTER TABLE tbl_score DROP COLUMN g_stname;

--삭제 후 검증
SELECT SC.g_stnum, ST.st_name
FROM tbl_score SC
    LEFT JOIN tbl_student ST
    ON  SC.g_stnum = ST.st_num;


CREATE TABLE tbl_subject(
    sb_code	CHAR(5)		PRIMARY KEY,
    sb_name	nVARCHAR2(2)	NOT NULL	
);

INSERT INTO tbl_subject VALUES('B0001','국어');
INSERT INTO tbl_subject VALUES('B0002','영어');
INSERT INTO tbl_subject VALUES('B0003','수학');
INSERT INTO tbl_subject VALUES('B0004','과학');
INSERT INTO tbl_subject VALUES('B0005','국사');
INSERT INTO tbl_subject VALUES('B0006','미술');

SELECT * FROM tbl_subject;
--과목명을 정규화하기 위해 과목코드 칼럼을 추가하겠다
ALTER TABLE tbl_score ADD g_sbcode CHAR(5);

UPDATE tbl_score SC
SET g_sbcode = (
    SELECT sb_code FROM tbl_subject SB
    WHERE SC.g_subject = SB.sb_name
);
-- 데이터 변경하는 경우 항상 작업 전 제대로 된 코드인지 확인

--업데이트 후 검증
SELECT SC.g_sbcode, SB.sb_code, SC.g_subject, SB.sb_name
FROM tbl_score SC
    LEFT JOIN tbl_subject SB
        ON SC.g_sbcode = SB.sb_code
WHERE SB.sb_name IS NULL;