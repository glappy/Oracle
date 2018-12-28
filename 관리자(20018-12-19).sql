-- ������ ȭ���Դϴ�

CREATE USER myuser1 IDENTIFIED BY 1111;
-- TABLESPACE�� SYSTEM���̺� �����̽��� �ڵ�����
-- ���� ȯ�濡���� �ſ� ������ ���

GRANT CREATE TABLE TO myuser1;
GRANT SELECT, UPDATE, INSERT ON [table] TO myuser1 ;

--���鶧�� ��ҹ��� ��������� �����ͻ������� ã������ �빮�ڷ� ã�� ��
CREATE TABLESPACE mytsA DATAFILE 'D:/bizwork/ordata/mytsA.dbf' 
SIZE 100M AUTOEXTEND ON NEXT 100K;

-- ����� ����� ������ �� TABLESPACE�� ������ �ʰ� TABLE���� �����ϸ� 
-- TABLE���� SYSTEM TS�� �����Ǿ� ���߿� ���̺����̽��� ���� �� �ű���� ���� ������ �߻��Ѵ�
-- ����ڸ� �����ϰ� ���̺��� ����� ���� ���̺� �����̽��� �ݵ�� �����ϰ� ������� DEFAULT TABLESPACE�� �����ؾ� �Ѵ�

ALTER USER myuser1 DEFAULT TABLESPACE mytsA;

CREATE TABLE emp_table(
    empno       CHAR(6)         PRIMARY KEY,
    empname     nVARCHAR2(20)   NOT NULL,
    empbirth    CHAR(8),
    deptno      CHAR(3)         NOT NULL,
    hredate     CHAR(10)        NOT NULL
);

INSERT INTO emp_table VALUES ('170001','ȫ�浿','880212','001','2019-01-01');
INSERT INTO emp_table VALUES ('170002','�̸���','770215','003','2019-01-02');
INSERT INTO emp_table VALUES ('170003','������','820513','003','2019-01-03');
INSERT INTO emp_table VALUES ('170004','�庸��','941102','004','2019-01-04');
INSERT INTO emp_table VALUES ('170005','�Ӳ���','801212','001','2019-01-05');

SELECT * FROM emp_table ;
DROP TABLE emp_table ;

UPDATE emp_table
SET hredate = '2018-03-01'
WHERE empno = '�庸��'; -- �庸�� �� ����̶��? �� ��� ��� �Ի����� �ٲ�. �ϴ� �̸��� �ҷ� Ȯ���ϰ� �����ȣ�� ���� ������Ʈ�� ��

SELECT * FROM emp_table
WHERE empname = '�庸��';

UPDATE emp_table
SET hredate = '2018-03-01'
WHERE empno = '170004'; -- ���̺��� ������� �μ� SUBLIMETEXT���� �۾��ϸ� �����ϰ� �۾��� �� ����