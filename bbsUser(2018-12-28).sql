-- ��ȭ���� bbsUserȭ���Դϴ�

-- �Խ��� ������Ʈ 1���� ����� ���� table ����
CREATE TABLE tbl_bbs_main (
	b_id NUMBER PRIMARY KEY, -- IDŰ
	b_date CHAR(10) NOT NULL, -- �ۼ�����
	b_auth nVARCHAR2(20) NOT NULL, 
	b_subject nVARCHAR2(50) NOT NULL, 
	b_text nVARCHAR2(255) NOT NULL
);

-- tbl_bbs_main���� ����� SEQ ����
CREATE SEQUENCE SEQ_BBS_MAIN
START WITH 1
INCREMENT BY 1;

INSERT INTO tbl_bbs_main
VALUES( SEQ_BBS_MAIN.NEXTVAL,'2018-12-28','ȫ�浿','�Խ��ǽ���','������ �ڹٸ� �̿��ؼ� �Խ����� �����');