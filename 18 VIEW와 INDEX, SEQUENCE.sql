-----------------------------------------------------------------------------------------
// 18 VIEW�� INDEX, SEQUENCE


-----------------------------------------------------------------------------------------
// view : ���̺��� �Ϻ� �����͸� �� �� �ֵ��� ����� ���̺�
//       V 1) ���Ȼ��� ������ �ÿ�
//         2) ������ �������� �����ϰ� �˻��ϱ� ���� ���
// view���� �����͸� ������Ʈ�ϸ�, ���� ���̺� ������Ʈ ��.
// ���� 95. ��� ���̺��� ������ SALESMAN�� ������� �����ȣ, ����̸�, ����, �����ڹ�ȣ, �μ���ȣ��
//          �ٶ� �� �ִ� view�� ���弼��.
create view emp_view
    as 
    select empno, ename, sal, job, deptno
    from emp
    where job = 'SALESMAN';
select * from emp_view;

// ���� 95. ��� ���̺��� �μ���ȣ�� 20���� ������� �����ȣ�� ����̸�, ����, ������ �� �� �ִ� �並 �����ϼ���.
create view emp_view2
    as
    select empno, ename, job, sal
    from emp
    where deptno = 20;
select * from emp_view2;
drop view emp_view2;  
    
-----------------------------------------------------------------------------------------
// view : ���̺��� �Ϻ� �����͸� �� �� �ֵ��� ����� ���̺�
//         1) ���Ȼ��� ������ �ÿ�
//       V 2) ������ �������� �����ϰ� �˻��ϱ� ���� ���    
create view emp_view2
    as
    select deptno, round(avg(sal)) as avgsal
    from emp
    group by deptno;
    // view ������ ��, �� �÷� alias�� �����ؾ� ��.
    select * from emp_view2;
    
// ���� 96. ����, ������ ��Ż������ ����ϴ� view�� emp_view96���� �����ϼ���.
create view emp_view96
    as
    select job, sum(sal) as �����������Ѱ�
    from emp
    group by job;
select * from emp_view96;


-----------------------------------------------------------------------------------------
// index : �˻��ӵ��� ���̴� �����ͺ��̽� ��ü
//         ��뷮�� �����Ϳ��� �ۼ��� ���� ���࿡ �ӵ����Ϲ���(full table scan ����)
// ��ü : ���̺�, ��, �ε���
// ���� 97. ������ 3000�� ����� �̸��� ������ �ε����� ���ؼ� ������ �˻��ϼ���.
explain plan for
select ename, sal
    from emp
    where sal = 3000;
select * from table(dbms_xplan.display);

create index emp_sal
    on emp(sal);
    // sal�� index�� ����
    
explain plan for
select ename, sal
    from emp
    where sal = 3000;
select * from table(dbms_xplan.display);

select rowid, empno, ename
    from emp;
    // rowid : ���� �ּ�, file��ȣ + ����ȣ + row��ȣ �� ������.
    
// ���� 97. ������̺� ������ �ε����� �����ϼ���.
create index emp_job
    on emp(job);
    
explain plan for
    select ename, job
    from emp
    where job = 'SALESMAN';
select * from table(dbms_xplan.display);


-----------------------------------------------------------------------------------------
// sequence : �ߺ����� �ʴ� ���ϰ����� ����
// create sequence ��������
// ���� 98. �����ȣ�� �Է��� ��, �����Ͱ� �ߺ����� �ʰ� ������� �Էµǰ� �ϼ���.
create sequence seql;

select seql.nextval
    from dual;
    
create sequence seq2
    start with 1
    maxvalue 100
    increment by 1
    nocycle;
    // start with n : n���� ����
    // maxvalue N : �ִ� N���� ����
    // increment by k : k�� ����
    // nocycle : n���� N���� ���� �Ŀ� �ٽ� n���� �����ϴ� �ݺ��� �����. ������ �ݺ� ����
    
create table emp500
    (empno number(10),
     ename varchar2(10) );
select * from emp500;

insert into emp500
    values(seq2.nextval, 'SMITH');
select * from emp500;

// ���� 98. dept���̺� �μ���ȣ�� 50������ �Է��ϰ� 10�� �����Ǵ� �������� �����ϼ���.(������ �̸�:dept_seq1)
create sequence dept_seq1
    start with 50
    increment by 10;
 
insert into dept(deptno, dname, loc)
    values(dept_seq1.nextval, 'CHOICE', 'SEOUL');
select * from dept;

rollback;