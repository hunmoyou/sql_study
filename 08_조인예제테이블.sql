-- ���̺� ����
CREATE TABLE info (
    id NUMBER NOT NULL,
    title VARCHAR2(100),
    content VARCHAR2(100),
    regdate DATE DEFAULT sysdate NOT NULL,
    CONSTRAINT info_pk PRIMARY KEY
    (
    id
    )
    ENABLE
);

CREATE TABLE auth (
    auth_id NUMBER NOT NULL,
    name VARCHAR2(30),
    job VARCHAR2(30),
    CONSTRAINT table1_pk PRIMARY KEY
    (
        auth_id
    )
    ENABLE
);
-- ������ ����
CREATE SEQUENCE seq_info;
CREATE SEQUENCE seq_auth;

INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'java', 'java is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'jsp', 'jsp is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'spring', 'spring is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'oracle', 'oracle is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'mysql', 'mysql is');             
INSERT INTO info(id, title, content) VALUES(SEQ_INFO.nextval, 'c', 'c is');             

INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, '�̰��', 'developer');
INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, 'ȫ����', 'DBA');
INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, '�̼���', 'designer');
INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, '��浿', 'scientist');
INSERT INTO auth(auth_id, name, job) values(SEQ_AUTH.nextval, '�̰��', 'teacher');

SELECT * FROM info;
SELECT * FROM auth;


-- �÷� �߰�
ALTER TABLE info
ADD(auth_id NUMBER);

-- info ���̺��� auth_id�� auth���̺��� auth_id�� �߰��ϴ� �۾�.
UPDATE info
SET auth_id = 3
WHERE id = 5;