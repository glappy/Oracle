-- 여기는 user2의 화면입니다
CREATE TABLE tbl_employee (
    strEmpno CHAR(3) PRIMARY KEY,
    strName nVARCHAR2(20) NOT NULL,
    strJob nVARCHAR2(20),
    intSal NUMBER(5),
    strDeptNo nVARCHAR2(20)
    
);

-- 테이블 변경
ALTER TABLE tbl_employee MODIFY intSal NUMBER(10);
