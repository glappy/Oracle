-- 관리자 화면입니다

CREATE USER myuser1 IDENTIFIED BY 1111;
-- TABLESPACE를 SYSTEM테이블 스페이스로 자동지정
-- 실제 환경에서는 매우 위험한 방법

GRANT CREATE TABLE TO myuser1;
GRANT SELECT, UPDATE, INSERT ON [table] TO myuser1 ;

--만들때는 대소문자 관계없으나 데이터사전에서 찾을때는 대문자로 찾을 것
CREATE TABLESPACE mytsA DATAFILE 'D:/bizwork/ordata/mytsA.dbf' 
SIZE 100M AUTOEXTEND ON NEXT 100K;

-- 사용자 등록을 실행한 후 TABLESPACE를 만들지 않고 TABLE등을 생성하면 
-- TABLE들은 SYSTEM TS에 생성되어 나중에 테이블스페이스를 만든 후 옮기려면 많은 문제가 발생한다
-- 사용자를 생성하고 테이블을 만들기 전에 테이블 스페이스를 반드시 생성하고 사용자의 DEFAULT TABLESPACE를 지정해야 한다

ALTER USER myuser1 DEFAULT TABLESPACE mytsA;

CREATE TABLE emp_table(
    empno       CHAR(6)         PRIMARY KEY,
    empname     nVARCHAR2(20)   NOT NULL,
    empbirth    CHAR(8),
    deptno      CHAR(3)         NOT NULL,
    hredate     CHAR(10)        NOT NULL
);

INSERT INTO emp_table VALUES ('170001','홍길동','880212','001','2019-01-01');
INSERT INTO emp_table VALUES ('170002','이몽룡','770215','003','2019-01-02');
INSERT INTO emp_table VALUES ('170003','성춘향','820513','003','2019-01-03');
INSERT INTO emp_table VALUES ('170004','장보고','941102','004','2019-01-04');
INSERT INTO emp_table VALUES ('170005','임꺽정','801212','001','2019-01-05');

SELECT * FROM emp_table ;
DROP TABLE emp_table ;

UPDATE emp_table
SET hredate = '2018-03-01'
WHERE empno = '장보고'; -- 장보고가 두 사람이라면? 두 사람 모두 입사일이 바뀜. 일단 이름을 불러 확인하고 사원번호를 통해 업데이트할 것

SELECT * FROM emp_table
WHERE empname = '장보고';

UPDATE emp_table
SET hredate = '2018-03-01'
WHERE empno = '170004'; -- 테이블을 블록으로 싸서 SUBLIMETEXT에서 작업하면 안전하게 작업할 수 있음