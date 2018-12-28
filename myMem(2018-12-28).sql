-- 여기는 myMem으로 접속한 화면입니다
CREATE TABLE tbl_primary(
    p_id    NUMBER        PRIMARY KEY, -- 필드
    p_name  nVARCHAR2(50) NOT NULL,-- 필드
    p_tel   nVARCHAR2(20) -- 필드
); -- CREATE를 통해서 만들어지는 것 : DB객체, OBJECT
-- CREATE와 DROP은 DDL
-- DATABASE? 데이터 저장하는 물리적 공간. 오라클에서는 TABLESPACE라고 함
-- 보통 테이블의 PK는 각 데이터(레코드=필드가 모인것)를 식별하는 어떤 요소로서 사용된다
-- 정보를 저장하는 테이블에서는 임의로 코드를 생성해서 데이터를 추가할 때 사용한다

-- 임의의 데이터가 다량으로 추가되는 경우?
-- 코드 개념을 추가하기가 매우 어렵다
-- 이런 테이블에는 임의로 ID칼럼을 추가하고 ID값을 만들어 저장한다
-- MYSQL같은 DB에서는 AUTO INCREMENT라는 옵션 있지만 오라클(11 이하)은 안됨

-- 오라클에 있는 SEQ라는 객체를 활용해서 AUTO INCREMENT효과를 얻을 수 있다
SELECT * FROM tbl_primary;

-- 새로운 SEQUENCE객체 생성
CREATE SEQUENCE PK_SEQ -- 의미 있는 이름으로 짓기
START WITH 1 
INCREMENT BY 1 -- 한번 만들어지면 초기화 안됨. 다시 1부터 만들고 싶으면 SEQ지우고 다른 이름으로 다시 만들 것
-- 1이 아닌 값으로 입력하면 2,4,6.. 3,6,9.. 만들 수 있음
NOMAXVALUE -- 또는 1000
NOMINVALUE; -- 또는 0; 
-- 자바의 i++
--대소문자 섞어쓰면 인식못하는 경우 있음. SEQ는 가급적 대문자 사용

-- FROM DUAL : 오라클에 있는 테스트용(DUMY)테이블 이용해서 간단한 계산식이나 내장함수들의 연습 하고자 할 때 사용한다
-- 다른 DB에서는 SELECT 30*40 해도 알아서 해줌
SELECT 30*40 FROM DUAL;

-- 위에서 생성한 PK_SEQ 테스트 해보자
SELECT PK_SEQ.NEXTVAL FROM DUAL; -- SELECT와 FROM사이 오는 것들은 칼럼, 함수, 계산식. 일종의 변수.
-- SEQ의 NEXTVAL를 호출하면 시퀀스틑 내부적으로 INCREMNET BY에 설정한 만큼 증사키니 후 그 값을 RETURN 함
-- SEQ의 NEXTVAL값을 INSERT할 때 PK로 선언된 ID에 저장하도록 하여 AUTO INCREMENT가 설정된 칼럼을 쓸 때와 같이 사용가능하다

INSERT INTO tbl_primary VALUES(2,'홍길동','0001');
INSERT INTO tbl_primary VALUES(PK_SEQ.NEXTVAL,'이몽룡','0005');

SELECT * FROM tbl_primary;

-- INSERT 실행한 후 현재 ID값을 SEQ를 통해서 확인하는 방법
SELECT PK_SEQ.CURRVAL FROM DUAL;

-- INSERT가 실행되지 않아 오류가 발생하고 현재 ID값을 얻을 수 없을 때 오라클의 SYSTEM DB
SELECT * FROM USER_SEQUENCES
WHERE SEQUENCE_NAME = 'PK_SEQ';

--RANDOM함수 이용해서 PK만드는 방법(중복값 나올 수 있음)
SELECT DBMS_RANDOM.VALUE FROM DUAL;
SELECT ROUND(DBMS_RANDOM.VALUE(100000, 9999999)) FROM DUAL;
-- 난수를 이용해서 PK를 만들면 중복된 값이 나타날 우려가 있고 ID값으로 정렬을 했을 때 의미없는 정렬이 된다

INSERT INTO tbl_primary
VALUES(ROUND(DBMS_RANDOM.VALUE(100,9999)),'성춘향','0007');

SELECT * FROM tbl_primary
ORDER BY p_id;

-- GUID, UUID
SELECT SYS_GUID() FROM DUAL;

-- SYS GUID사용해서 PK선언할 때는 CHAR(32)이상의 값으로 설정
-- SYS GUID사용해서 PK선언할 때는 CHAR(32)에서 오류 발생할 수 있음
-- 그럴때는 CLOB, BLOB로 선언할 것...........가급적이면 사용하지 말것. DB너무 무거워짐
INSERT INTO tbl_primary 
VALUES(SYS_GUID(),'임꺽정','0000');

CREATE SEQUENCE SEQ_TEST
START WITH 1
INCREMENT BY 1
MAXVALUE 10;

SELECT SEQ_TEST.NEXTVAL FROM DUAL; -- PRIMARY KEY나 ID가 아닐 때 다시 1로 돌아가게 하고 싶다면?
DROP SEQUENCE SEQ_TEST;

CREATE SEQUENCE SEQ_TEST
START WITH 1
INCREMENT BY 1
MAXVALUE 10
NOCACHE
CYCLE; -- 대량으로 작업을 할 때는 NOCACHE 쓰지 말 것

SELECT SEQ_TEST.NEXTVAL FROM DUAL ;

--시퀀스 변경. 시퀀스도 다른 객체처럼 ALTER를 사용할 수 있으나 START WITH는 변경할 수 없음
-- START WITH변경하려면 DROP 밖에는 답없음.
ALTER SEQUENCE SEQ_TEST
INCREMENT BY 2
MAXVALUE 20
NOCYCLE;

-- 시퀀스 값을 역순으로 생성하고 싶으면
CREATE SEQUENCE ASC_SEQ
START WITH 9999
INCREMENT BY -1 -- 1씩 줄어듦
MINVALUE 0 -- (NOMINVALUE. -1)
MAXVALUE 10000; -- (NOMAXVALUE). START보다 MAX가 1이라도 더 커야함

CREATE TABLE tbl_mytable(
    p_id    NUMBER          PRIMARY KEY,
    p_name  nVARCHAR2(50)   NOT NULL,
    p_tel   nVARCHAR2(20),
    p_kor   NUMBER(3), -- 점수를 저장하려 만든 칼럼. 저장할 최대값이 예상되는 경우 값의 크기를 지정하는 것이 좋음.
    p_eng   NUMBER(3)
);

CREATE SEQUENCE MY_SEQ
START WITH 1
INCREMENT BY 1
NOCYCLE;


INSERT INTO tbl_mytable VALUES (MY_SEQ.NEXTVAL,'임의의이름?','임의의전화번호?',ROUND(DBMS_RANDOM.VALUE(50,100)),ROUND(DBMS_RANDOM.VALUE(50,100)));
SELECT p_name AS 이름, (p_kor + p_eng) AS 합계 FROM tbl_mytable;