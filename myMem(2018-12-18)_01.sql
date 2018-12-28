-- ����� myMem���� ������ ȭ���Դϴ�

SELECT * FROM tbl_iolist ;

-- �ŷ�ó �Ե������� �ڷḸ Ȯ���ϰ� ������
SELECT * FROM tbl_iolist 
WHERE io_dname = '(��)���翣���Ͼ(���ֳ����Ե�)';

-- tbl_iolist�� ��ǰ�̸��� �ŷ�ó�� �ŷ�ó����� ���� ������ �ֱ� ������ 
-- ��ǰ�̳� �ŷ�ó�� �ŷ�ó��ǥ���� ����, �����Ϸ��� �ϸ� �ټ��� �����͸� �����ؾ� �Ѵ�
-- �ټ��� �����͸� �����ϴ� ���� DB���ȯ�� ��Ģ������ �ٶ������� �ʴ�
-- ������ io_list ���̺��� �и��۾��Ͽ� ������ ������ �ټ� �߻����� �ʵ��� ��ġ�� ���ؾ� �Ѵ�
-- ��2����ȭ. 2NF

-- tbl_iolist�κ��� �ŷ�ó��, �ŷ�ó��ǥ���� ��� ��ƺ���
SELECT io_dname, io_ceo
FROM tbl_iolist 
ORDER BY io_dname;

SELECT io_dname,io_ceo
FROM tbl_iolist
GROUP BY io_dname, io_ceo
ORDER BY io_dname;

--�ŷ�ó ���̺� ����
CREATE TABLE tbl_dept(
    d_code	CHAR(4)	PRIMARY KEY,
    d_name	nVARCHAR2(50) NOT NULL,	
    d_ceo	nVARCHAR2(20) NOT NULL,	
    d_tel	nVARCHAR2(20),
    d_addr	nVARCHAR2(50),
    d_fax	nVARCHAR2(20),
    d_sid	CHAR(14)		
);

SELECT COUNT(*) FROM tbl_dept;
SELECT * FROM tbl_dept;

-- io_list ���̺��� �ŷ�ó��, ��ǥ�ڸ� �����ϰ� �ŷ�ó�ڵ� Į������ ��ü
-- JOIN�ؼ� �߸� ����� �����Ͱ� ���°� Ȯ��
SELECT I.io_dname, D.d_name, D.d_code
FROM tbl_iolist I, tbl_dept D
WHERE I.io_dname = D.d_name ;

-- io_list���� ������ dept���̺��� ���� ���� �ִ°�
SELECT I.io_dname, D.d_name, D.d_code
FROM tbl_iolist I, tbl_dept D
    LEFT JOIN tbl_dept D
    ON I.io_dname = D.d_name ;
    
--iolist�� dept���̺��� d_code�� ������ Į�� �߰�
ALTER TABLE tbl_iolist ADD io_dcode CHAR(4);
DESC tbl_iolist ;

-- SUB QUERY
SELECT I.io_dname, (SELECT D.d_name FROM tbl_dept D WHERE D.d_name = I.io_dname AND D.d_ceo = I.io_ceo) AS dname
FROM tbl_iolist I
ORDER BY D.d_name;

SELECT d_name,d_ceo, COUNT(*)
FROM tbl_dept
GROUP BY d_name,d_ceo
HAVING COUNT(*) > 1;

-- SUB QUERY ����� dept table���� d_code�� iolist�� update�Ѵ�
UPDATE tbl_iolist I
SET io_dcode = 
    (SELECT d_code FROM tbl_dept D 
    WHERE I.io_dname = D.d_name AND I.io_ceo = D.d_ceo);
    
SELECT io_dcode, io_dname, io_ceo FROM tbl_iolist ;

-- e.iolist�� dept���̺��� JOIN�ؼ� �ŷ�ó�� ��ǥ�� ���� ��ȸ�ϴ� SQL
SELECT I.io_dcode, D.d_name, D.d_ceo
FROM tbl_iolist I
    LEFT JOIN tbl_dept D
        ON I.io_dcode = D.d_code;
        
-- f.iolist���� io_dname, io_ceoĮ���� �����ص� �ȴ�
ALTER TABLE tbl_iolist DROP COLUMN io_ceo ;

DESC tbl_iolist ;