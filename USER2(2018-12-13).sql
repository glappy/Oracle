-- ����� user2�� ȭ���Դϴ�
CREATE TABLE tbl_employee (
    strEmpno CHAR(3) PRIMARY KEY,
    strName nVARCHAR2(20) NOT NULL,
    strJob nVARCHAR2(20),
    intSal NUMBER(5),
    strDeptNo nVARCHAR2(20)
    
);

-- ���̺� ����
ALTER TABLE tbl_employee MODIFY intSal NUMBER(10);
