-- ����� myMem����ڷ� ������ ȭ���Դϴ�

-- ����Ŭ���� $ ǥ�� �ִ� ���̺��� SYSTEM DICTIONARY��� �Ѵ�
-- SYS DIC��� ��Ī�Ѵ�. �ý����� ������ ��� �ִ� �߿��� ���̺���̴�
-- SYS DIC���� �����ڷ� ���������� Ȯ���� �� ������ myMem�� DBA������ �޾����Ƿ� Ȯ�� ����
SELECT * FROM v$datafile ;
SELECT NAME FROM v$datafile ;

SELECT * FROM dba_tablespaces ;
SELECT * FROM dba_data_files ;
SELECT * FROM v$controlfile ;
SELECT * FROM dba_users ;
SELECT * FROM dba_tab_privs;

SELECT USERNAME,EXPIRY_DATE, DEFAULT_TABLESPACE,PROFILE, AUTHENTICATION_TYPE
FROM dba_users;

