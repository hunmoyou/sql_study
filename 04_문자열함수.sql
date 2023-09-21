
-- lower(�ҹ���), initcap(�ձ��ڸ� �빮��), upper(�빮��)

SELECT * FROM dual;

/*
dual�̶�� ���̺��� sys�� �����ϴ� ����Ŭ�� ǥ�� ���̺�μ�,
���� �� �࿡ �� �÷��� ��� �ִ� dummy ���̺� �Դϴ�.
�Ͻ����� ��� �����̳� ��¥ ���� � �ַ� ����մϴ�.
��� ����ڰ� ������ �� �ֽ��ϴ�.
*/

SELECT
 'abcDEF', lower('abcDEF'), upper('abcDEF')
 FROM
    dual;
    
SELECT
    last_name,
    LOWER(last_name),
    INITCAP(last_name),
    UPPER(last_name)
FROM employees;

SELECT last_name FROM employees
WHERE LOWER(last_name) = 'austin';

-- length(����), instr(���� ã��, ������ 0�� ��ȯ, ������ �ε��� ��)
SELECT
    'abcDEF', LENGTH('abcDEF'), INSTR('abcDEF', 'z')
FROM dual;

SELECT
    first_name, LENGTH(first_name), INSTR(first_name, 'a')
FROM employees;

-- substr(�ڸ� ���ڿ�, ���� �ε���, ����), concat(���� ����)
-- substr(�ڸ� ���ڿ�, ���� �ε���) -> ���ڿ� ������
-- �ε��� 1���� ����
SELECT
    'abcdef' As ex,
    SUBSTR('abcdef', 2, 3),
    CONCAT('abc', 'def')
FROM dual;

SELECT
    first_name,
    SUBSTR(first_name, 1, 3),
    CONCAT(first_name, last_name)
FROM employees;

-- LAPD, RPAD(��, ���� ���� ���ڿ��� ä���)
SELECT
    LPAD('abc', 10, '*'),
    RPAD('abc', 10, '*')
FROM dual;

-- LTRIM(), RTRIM(), TRIM() ���� ����
-- LTRIM(param1, param2) -> param2�� ���� param1���� ã�Ƽ� ����, (���ʺ���)
-- RTRIM(param1, param2) -> param2�� ���� param1���� ã�Ƽ� ����, (�����ʺ���)
SELECT LTRIM('javascript_java', 'java') FROM dual;
SELECT RTRIM('javascript_java', 'java') FROM dual; 
SELECT TRIM('   java    ') FROM dual;

--replace() 
SELECT
    REPLACE('MY dream is a president', 'president', 'programmer')
FROM dual;

SELECT
    REPLACE(REPLACE('MY dream is a president', 'president', 'programmer'), ' ', '')
FROM dual;

SELECT
    REPLACE(CONCAT('hello', ' world!'), '!', '?')
FROM dual;

/*
���� 1.
EMPLOYEES ���̺��� �̸�, �Ի����� �÷����� �����ؼ� �̸������� �������� ��� �մϴ�.(hire_date�� �Ի����ڷ�)
���� 1) �̸� �÷��� first_name, last_name�� �ٿ��� ����մϴ�. (concat)
���� 2) �Ի����� �÷��� xx/xx/xx�� ����Ǿ� �ֽ��ϴ�. xxxxxx���·� �����ؼ� ����մϴ�. (replace)
*/
SELECT
    CONCAT(first_name, last_name) AS �̸�, REPLACE(hire_date, '/', '') AS �Ի�����
FROM employees;

/*
���� 2.                                 
EMPLOYEES ���̺��� phone_number�÷��� ###.###.####���·� ����Ǿ� �ִ�
���⼭ ó�� �� �ڸ� ���� ��� ���� ������ȣ (02)�� �ٿ� (02).###.####  02#######
��ȭ ��ȣ�� ����ϵ��� ������ �ۼ��ϼ���. (CONCAT, SUBSTR,)
*/
SELECT
    CONCAT('(02)',SUBSTR(phone_number, 4))
FROM employees;

/*
���� 3. 
EMPLOYEES ���̺��� JOB_ID�� it_prog�� ����� �̸�(first_name)�� �޿�(salary)�� ����ϼ���.
���� 1) ���ϱ� ���� ���� �ҹ��ڷ� ���ؾ� �մϴ�.(��Ʈ : lower �̿�)
���� 2) �̸��� �� 3���ڱ��� ����ϰ� �������� *�� ����մϴ�. 
�� ���� �� ��Ī�� name�Դϴ�.(��Ʈ : rpad�� substr �Ǵ� substr �׸��� length �̿�)
���� 3) �޿��� ��ü 10�ڸ��� ����ϵ� ������ �ڸ��� *�� ����մϴ�. 
�� ���� �� ��Ī�� salary�Դϴ�.(��Ʈ : lpad �̿�)
*/
SELECT
     RPAD(SUBSTR(first_name, 1,3),10,'*') As name,
     LPAD(salary,10,'*')
FROM employees
WHERE LOWER(JOB_ID) ='it_prog';

