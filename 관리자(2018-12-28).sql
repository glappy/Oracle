-- ������ ȭ���Դϴ�
-- �ڹ� ���ÿ��� ����� tablespace�� ����� ����

CREATE TABLESPACE bbsTS
DATAFILE 'D:/bizwork/ordata/bbsTS.dbf'
SIZE 100M
AUTOEXTEND ON NEXT 100K;

CREATE USER bbsUSER IDENTIFIED BY 1234
DEFAULT TABLESPACE bbSTS;

GRANT DBA TO bbsUSER;

DROP USER bbsUSER;