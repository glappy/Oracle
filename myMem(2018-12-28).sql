-- ����� myMem���� ������ ȭ���Դϴ�
CREATE TABLE tbl_primary(
    p_id    NUMBER        PRIMARY KEY, -- �ʵ�
    p_name  nVARCHAR2(50) NOT NULL,-- �ʵ�
    p_tel   nVARCHAR2(20) -- �ʵ�
); -- CREATE�� ���ؼ� ��������� �� : DB��ü, OBJECT
-- CREATE�� DROP�� DDL
-- DATABASE? ������ �����ϴ� ������ ����. ����Ŭ������ TABLESPACE��� ��
-- ���� ���̺��� PK�� �� ������(���ڵ�=�ʵ尡 ���ΰ�)�� �ĺ��ϴ� � ��ҷμ� ���ȴ�
-- ������ �����ϴ� ���̺����� ���Ƿ� �ڵ带 �����ؼ� �����͸� �߰��� �� ����Ѵ�

-- ������ �����Ͱ� �ٷ����� �߰��Ǵ� ���?
-- �ڵ� ������ �߰��ϱⰡ �ſ� ��ƴ�
-- �̷� ���̺��� ���Ƿ� IDĮ���� �߰��ϰ� ID���� ����� �����Ѵ�
-- MYSQL���� DB������ AUTO INCREMENT��� �ɼ� ������ ����Ŭ(11 ����)�� �ȵ�

-- ����Ŭ�� �ִ� SEQ��� ��ü�� Ȱ���ؼ� AUTO INCREMENTȿ���� ���� �� �ִ�
SELECT * FROM tbl_primary;

-- ���ο� SEQUENCE��ü ����
CREATE SEQUENCE PK_SEQ -- �ǹ� �ִ� �̸����� ����
START WITH 1 
INCREMENT BY 1 -- �ѹ� ��������� �ʱ�ȭ �ȵ�. �ٽ� 1���� ����� ������ SEQ����� �ٸ� �̸����� �ٽ� ���� ��
-- 1�� �ƴ� ������ �Է��ϸ� 2,4,6.. 3,6,9.. ���� �� ����
NOMAXVALUE -- �Ǵ� 1000
NOMINVALUE; -- �Ǵ� 0; 
-- �ڹ��� i++
--��ҹ��� ����� �νĸ��ϴ� ��� ����. SEQ�� ������ �빮�� ���

-- FROM DUAL : ����Ŭ�� �ִ� �׽�Ʈ��(DUMY)���̺� �̿��ؼ� ������ �����̳� �����Լ����� ���� �ϰ��� �� �� ����Ѵ�
-- �ٸ� DB������ SELECT 30*40 �ص� �˾Ƽ� ����
SELECT 30*40 FROM DUAL;

-- ������ ������ PK_SEQ �׽�Ʈ �غ���
SELECT PK_SEQ.NEXTVAL FROM DUAL; -- SELECT�� FROM���� ���� �͵��� Į��, �Լ�, ����. ������ ����.
-- SEQ�� NEXTVAL�� ȣ���ϸ� �������z ���������� INCREMNET BY�� ������ ��ŭ ����Ű�� �� �� ���� RETURN ��
-- SEQ�� NEXTVAL���� INSERT�� �� PK�� ����� ID�� �����ϵ��� �Ͽ� AUTO INCREMENT�� ������ Į���� �� ���� ���� ��밡���ϴ�

INSERT INTO tbl_primary VALUES(2,'ȫ�浿','0001');
INSERT INTO tbl_primary VALUES(PK_SEQ.NEXTVAL,'�̸���','0005');

SELECT * FROM tbl_primary;

-- INSERT ������ �� ���� ID���� SEQ�� ���ؼ� Ȯ���ϴ� ���
SELECT PK_SEQ.CURRVAL FROM DUAL;

-- INSERT�� ������� �ʾ� ������ �߻��ϰ� ���� ID���� ���� �� ���� �� ����Ŭ�� SYSTEM DB
SELECT * FROM USER_SEQUENCES
WHERE SEQUENCE_NAME = 'PK_SEQ';

--RANDOM�Լ� �̿��ؼ� PK����� ���(�ߺ��� ���� �� ����)
SELECT DBMS_RANDOM.VALUE FROM DUAL;
SELECT ROUND(DBMS_RANDOM.VALUE(100000, 9999999)) FROM DUAL;
-- ������ �̿��ؼ� PK�� ����� �ߺ��� ���� ��Ÿ�� ����� �ְ� ID������ ������ ���� �� �ǹ̾��� ������ �ȴ�

INSERT INTO tbl_primary
VALUES(ROUND(DBMS_RANDOM.VALUE(100,9999)),'������','0007');

SELECT * FROM tbl_primary
ORDER BY p_id;

-- GUID, UUID
SELECT SYS_GUID() FROM DUAL;

-- SYS GUID����ؼ� PK������ ���� CHAR(32)�̻��� ������ ����
-- SYS GUID����ؼ� PK������ ���� CHAR(32)���� ���� �߻��� �� ����
-- �׷����� CLOB, BLOB�� ������ ��...........�������̸� ������� ����. DB�ʹ� ���ſ���
INSERT INTO tbl_primary 
VALUES(SYS_GUID(),'�Ӳ���','0000');

CREATE SEQUENCE SEQ_TEST
START WITH 1
INCREMENT BY 1
MAXVALUE 10;

SELECT SEQ_TEST.NEXTVAL FROM DUAL; -- PRIMARY KEY�� ID�� �ƴ� �� �ٽ� 1�� ���ư��� �ϰ� �ʹٸ�?
DROP SEQUENCE SEQ_TEST;

CREATE SEQUENCE SEQ_TEST
START WITH 1
INCREMENT BY 1
MAXVALUE 10
NOCACHE
CYCLE; -- �뷮���� �۾��� �� ���� NOCACHE ���� �� ��

SELECT SEQ_TEST.NEXTVAL FROM DUAL ;

--������ ����. �������� �ٸ� ��üó�� ALTER�� ����� �� ������ START WITH�� ������ �� ����
-- START WITH�����Ϸ��� DROP �ۿ��� �����.
ALTER SEQUENCE SEQ_TEST
INCREMENT BY 2
MAXVALUE 20
NOCYCLE;

-- ������ ���� �������� �����ϰ� ������
CREATE SEQUENCE ASC_SEQ
START WITH 9999
INCREMENT BY -1 -- 1�� �پ��
MINVALUE 0 -- (NOMINVALUE. -1)
MAXVALUE 10000; -- (NOMAXVALUE). START���� MAX�� 1�̶� �� Ŀ����

CREATE TABLE tbl_mytable(
    p_id    NUMBER          PRIMARY KEY,
    p_name  nVARCHAR2(50)   NOT NULL,
    p_tel   nVARCHAR2(20),
    p_kor   NUMBER(3), -- ������ �����Ϸ� ���� Į��. ������ �ִ밪�� ����Ǵ� ��� ���� ũ�⸦ �����ϴ� ���� ����.
    p_eng   NUMBER(3)
);

CREATE SEQUENCE MY_SEQ
START WITH 1
INCREMENT BY 1
NOCYCLE;


INSERT INTO tbl_mytable VALUES (MY_SEQ.NEXTVAL,'�������̸�?','��������ȭ��ȣ?',ROUND(DBMS_RANDOM.VALUE(50,100)),ROUND(DBMS_RANDOM.VALUE(50,100)));
SELECT p_name AS �̸�, (p_kor + p_eng) AS �հ� FROM tbl_mytable;