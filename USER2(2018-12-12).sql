-- ����� user2 ���� ȭ���Դϴ�
-- tbl_test1�� ����
CREATE TABLE tbl_test1(
    str_num CHAR(3) PRIMARY KEY,
    intKor NUMBER(3),
    intEng NUMBER(3),
    intMath NUMBER(3)
);

-- ǥ�������� PK ����
CREATE TABLE tbl_test2 (
    str_num CHAR(3),
    intKor NUMBER(3),
    intEng NUMBER(3),
    intMath NUMBER(3),
    PRIMARY KEY(str_num)
);
DROP TABLE tbl_users;

CREATE TABLE tbl_users (
    str_num CHAR(3),
    str_name nVARCHAR2(20),
    str_tel nVARCHAR2(15),
    PRIMARY KEY (str_num)

);

INSERT INTO tbl_users 
VALUES('001','ȫ�浿','111');
INSERT INTO tbl_users 
VALUES('002','�̸���','22');
INSERT INTO tbl_users 
VALUES('003','������','333');
INSERT INTO tbl_users 
VALUES('004','����','444');
INSERT INTO tbl_users 
VALUES('005','�Ӳ���','555');

INSERT INTO tbl_test1 
VALUES('005',
    ROUND(DBMS_RANDOM.VALUE(100,50),0),
    ROUND(DBMS_RANDOM.VALUE(100,50),0),
    ROUND(DBMS_RANDOM.VALUE(100,50),0)
);
    
SELECT * FROM tbl_test1;    
SELECT * FROM tbl_users;

SELECT * FROM tbl_users
ORDER BY str_num;
    
SELECT * FROM tbl_users
ORDER BY str_num DESC;

-- �л��� ������ �����ϴ� table�� �����ϴµ�
-- ���� �Ϲ����� ������� ���̺��� �����
-- �ʿ��� Į���� ��� �����ϴ� ���̺��� �����Ҽ� �ִ�.

-- �й�, �̸�, ����, ����, ����, ����, ���
-- �й�, �̸�, ��ȭ��ȣ, �ּ�, ����, ����, ����, ����, ���

-- ������ DataBase���� ���������� �Ѱ��� ���̺�
-- �ʿ��� Į���� ��� �����ϴ� ���� �ſ� �ٶ��� ���� �ʴ�.
-- DB ���������� �ʿ��� �����鳢�� table�� ������ ������ �ؼ�
-- Data�� �����Ѵ�.

-- �л������� : tbl_users ���̺� �ְ�
-- ���������� : tbl_test1 ���̺� �ְ� �ϴ� ���� ����.

-- ������, �̷��� ���̺��� �и��ϸ�
-- ���������� ���鼭 �л������� ���� ��ȸ�ϰ� ������
-- ������� �߻��� �Ѵ�.

-- �׷��� ǥ�� SQL���� �ΰ��� table�� ����(JOIN)�ؼ�
-- ��ġ 1���� ���̺�ó�� �����͸� ���� �ִ� ����� �����Ѵ�.

-- �ΰ��� ���̺� ������ ��� ���� �ʹ�. "�׳�"
SELECT * FROM tbl_test1, tbl_users;

-- �ΰ��� table�� ��ȸ(read, select)�Ҷ�
-- �������� �ټ��� table�� ���(JOIN) �����ִ� ���
-- >> JOIN �̶�� �Ѵ�.
-- JOIN �߿��� ���� �ܼ��� ��������, JOIN����
-- EQUAL JOIN �̶�� �Ѵ�. 
SELECT * FROM tbl_test1, tbl_users
WHERE tbl_test1.str_num = tbl_users.str_num ;

-- ���Ѵ� Į���� �����ϱ�
SELECT tbl_test1.str_num,
       tbl_users.str_name,
       tbl_test1.intKor,
       tbl_test1.intEng,
       tbl_test1.intMath
FROM tbl_test1, tbl_users
WHERE tbl_test1.str_num = tbl_users.str_num;

-- ���̺� ���� ���̱�
SELECT T.str_num,
       U.str_name,
       T.intKor,
       T.intEng,
       T.intMath
FROM tbl_test1  T, tbl_users  U
WHERE T.str_num = U.str_num;

-- ����Ŭ 9 �̻󿡼� ����ϴ� ���� EQ JOIN
SELECT T.str_num,
        str_name,
       T.intKor,
       T.intEng,
       T.intMath
FROM tbl_test1 T
NATURAL JOIN tbl_users;

-- test1 ���̺� ������ �ϳ� �߰� �Ѵ�.
INSERT INTO tbl_test1
VALUES('006',90,90,100);

SELECT * FROM tbl_test1;

SELECT T.str_num,
       U.str_name,
       T.intKor,
       T.intEng,
       T.intMath
FROM tbl_test1  T, tbl_users  U
WHERE T.str_num = U.str_num
ORDER BY T.str_num;


SELECT T.str_num,
       U.str_name,
       T.intKor,
       T.intEng,
       T.intMath
FROM tbl_test1  T LEFT JOIN tbl_users U
ON T.str_num = U.str_num;

-- ������ SQL��(SELECT)�� ����������
-- tableó�� ��� �ϰ�, table�� select �ϴ� �������
-- ����Ҽ� �ִ�.
-- >> VIEW ��� �Ѵ�.
CREATE VIEW myJoin
AS
SELECT T.str_num AS TNum,   
       U.str_num AS UNum,
       U.str_name,
       T.intKor,
       T.intEng,
       T.intMath
FROM tbl_test1 T, tbl_users U
WHERE T.str_num = U.str_num(+)
ORDER BY T.str_num;

SELECT * FROM myJoin;
DROP VIEW myJoin;

SELECT * FROM myJoin
WHERE TNum = '002';

SELECT * FROM myJoin
ORDER BY TNum;

-- DCL ���
-- ���� ���� tbl_users, tbl_test1 ���̺� �����͸� �߰� �ߴ�
-- ������, ���� ������ ���� �������� ������ �ȵ� �����̴�
-- ���� �����ʹ� ����Ŭ�� �ӽ� ���念���� ������ �Ǿ� �ִ�.
-- �ӽ� ���念���� ����� �����͸� ������ ���� ������ �����ϴ�
-- Ű���带 �н�
COMMIT; -- ��� ���峻���� ������ ���� ������ �ݿ��϶�
SELECT * FROM tbl_test1;
DELETE FROM tbl_test1;
SELECT * FROM tbl_test1;

ROLLBACK;
SELECT * FROM tbl_test1;
