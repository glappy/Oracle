-- 여기는 myMem사용자로 접속한 화면입니다

-- 오라클에서 $ 표시 있는 테이블을 SYSTEM DICTIONARY라고 한다
-- SYS DIC라고 약칭한다. 시스템의 정보를 담고 있는 중요한 테이블들이다
-- SYS DIC들은 관리자로 접속했을때 확인할 수 있으나 myMem은 DBA권한을 받았으므로 확인 가능
SELECT * FROM v$datafile ;
SELECT NAME FROM v$datafile ;

SELECT * FROM dba_tablespaces ;
SELECT * FROM dba_data_files ;
SELECT * FROM v$controlfile ;
SELECT * FROM dba_users ;
SELECT * FROM dba_tab_privs;

SELECT USERNAME,EXPIRY_DATE, DEFAULT_TABLESPACE,PROFILE, AUTHENTICATION_TYPE
FROM dba_users;

