
/*
- NUMBER(2) -> ������ 2�ڸ����� ������ �� �ִ� ������ Ÿ��.
- NUMBER(5, 2) -> ������, �Ǽ��θ� ��ģ �� �ڸ��� 5�ڸ�, �Ҽ��� 2�ڸ� ex 103.12
- NUMBER -> ��ȣ�� ������ �� (38, 0)���� �ڵ� �����˴ϴ�. �Ҽ��� ���� 38�ڸ� ����
- VARCHAR2(byte) -> ��ȣ �ȿ� ���� ���ڿ��� �ִ� ���̸� ����. (4000byte����)
- CLOB -> ��뷮 �ؽ�Ʈ ������ Ÿ�� (�ִ� 4Gbyte)
- BLOB -> ������ ��뷮 ��ü (�̹���, ���� ���� �� ���)
- DATE -> BC 4712�� 1�� 1�� ~ AD 9999�� 12�� 31�ϱ��� ���� ����
- ��, ��, �� ���� ����.
*/


CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR(14), --�ѱ� : ����Ŭ�� 3����Ʈ �ڹٴ� 2����Ʈ
    loca VARCHAR2(15),
    dept_date DATE,
    dept_bonus NUMBER(10)
);

DESC dept2;
SELECT * FROM dept2;

-- NUMBER�� VARCHAR2 Ÿ���� ���̸� Ȯ��.
INSERT INTO dept2
VALUES (30, '�濵����', '���', sysdate, 2000000);

-- �÷� �߰�
ALTER TABLE dept2
ADD (dept_count NUMBER(3));

-- �� �̸� ����
ALTER TABLE dept2
RENAME COLUMN dept_count TO emp_count;

-- �� �Ӽ� ����
-- ���� �����ϰ��� �ϴ� �÷��� �����Ͱ� �̹� �����Ѵٸ� �׿� �´� Ÿ������
-- ������ �ּž� �մϴ�. ���� �ʴ� Ÿ�����δ� ������ �Ұ����մϴ�.
ALTER TABLE dept2
MODIFY (dept_name VARCHAR2(2));

--�� ����
ALTER TABLE dept2
DROP COLUMN dept_bonus;

SELECT * FROM dept3;

-- ���̺� �̸� ����
ALTER TABLE dept2
RENAME TO dept3;

-- ���̺� ���� (������ ���ܵΰ� ���� �����͸� ��� ����)
TRUNCATE TABLE dept3;

DROP TABLE dept3;  -- ���̺� ����.. �׳� ����.. �� �����ϴ°�, �ѹ鵵 �ȵ�

ROLLBACK;














