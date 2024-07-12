--------------------------------------------------------------------------------------------
// 21 ������ ǰ�� ���̱�1


--------------------------------------------------------------------------------------------
// primary key : ������ ���� �������ϴ� �÷��� ���Ͽ� ������. �ߺ��� ���� null���� �Է��� �� ���� ��.
// constraint �����̸� primary key 
// ������ �ִ� ��� : 1. ���̺��� ������ �� ����ο�
//                  2. ������� ���̺� ����ο�
// ���� 104. �����ȣ�� �ߺ��� �����Ϳ� null���� �Էµ��� �ʰ� �ϼ���.
drop table dept2;
create table dept2
    (deptno number(10) constraint dept2_deptno_pk primary key,
     dname varchar2(10),
     loc varchar2(10));

insert into dept2 values(10, 'aaa', 'bbb');
insert into dept2 values(20, 'aaa', 'bbb');
select * from dept2;

insert into dept2 values(10, 'vvv', 'www');
// ���Ἲ �������� ���� ���� �߻�
insert into dept2 values(null, 'ccc', 'aaa');
// null�� �ԷºҰ�

select table_name, constraint_name
    from user_constraints
    where table_name = 'DEPT2';
// ���̺� �̸��� ���� �̸� Ȯ��

alter table dept2
    drop constraint dept2_deptno_pk;
// dept2_deptno_pk ���� ����

alter table dept2
    add constraint dept2_deptno_pk primary key(deptno);
// ���� ���̺� ���������� �߰��ϴ� ���

// ���� 104. ��� ���̺��� empno�� primary key�� �����ϼ���.
alter table emp
    add constraints emp_empno_pk primary key(empno);


--------------------------------------------------------------------------------------------
// unique : �ߺ��� ���� �Է����� ���ϰ� �ϴ� ����
//
create table dept3
    (deptno number(10),
     dname varchar2(14) constraint dept3_dname_uni unique,
     loc varchar2(10));
     
select a.constraint_name, a.constraint_type, b.column_name
    from user_constraints a, user_cons_columns b
    where a.constraint_name = b.constraint_name
          and a.table_name = 'DEPT3';
   // user_constraints : ���̺��� �����ϴ� �������� ���
   // user_cons_column : ���������� �ɷ��ִ� �÷��� ���
   
insert into dept3 values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept3 values(20, 'RESEARCH', 'DALLAS');
insert into dept3 values(30, 'SALES', 'CHICAGO');
insert into dept3 values(40, 'OPERATIONS', 'BOSTON');
select * from dept3;

insert into dept3 values(50, 'RESEARCH', 'SEOUL');
// ���Ἲ ���� ���� ����

alter table dept3
    drop constraint dept3_dname_uni;
select * from dept3;

alter table dept3
    add constraint dept3_dname_uni unique(dname);
insert into dept3 values(50, 'RESEARCH', 'SEOUL');
// ���Ἲ ���� ���� ����

// ���� 105-1. �����ȣ, ����̸�, ����, ������ ��� ���̺��� �Ʒ��� ���� �����ϴµ� �����ȣ �÷���
//             �ߺ��� �����Ͱ� �Էµ��� �ʰ� ������ �ɾ �����ϼ���.
//             (���̺�� : emp1000, �÷��� : empno, ename, sal, job)
create table emp1000
    (empno number(10) constraint emp1000_empno_uni unique,
     ename varchar2(10),
     sal number(10),
     job varchar2(10));
select * from emp1000;

insert into emp1000 values(1111, 'scott', 3000, 'salesman');
insert into emp1000 values(1111, 'smith', 4000, 'analyst');

// ���� 105-2. ������̺��� �����ȣ�� �ߺ��� �����Ͱ� �ִ��� �˻��غ�����.
select empno, count(*)
    from emp
    group by empno
    having count(*) >= 2;
    // �����ͺ��̽��� Ŀ�� �Ѵ��� �˾ƺ� �� �����Ƿ� having ������ ���� Ȯ��
    
// ���� 105-3. ��� ���̺��� �����ȣ�� �ߺ��� �����Ͱ� �Էµ��� ���ϵ��� ������ �ż���.
alter table emp
    add constraint emp_empno_uni unique(empno);