--------------------------------------------------------------------------------------------
// 22 ������ ǰ�� ���̱�2


--------------------------------------------------------------------------------------------
// not null : null�� ���� ���ϰ� ��.
// ���� 106. ����̸��� null���� ���� ���ϰ� �ϼ���.
create table dept6
    (deptno number(10),
     dname varchar2(14),
     loc varchar2(10) constraint dept5_loc_nn not null);
     
insert into dept6(deptno, dname) values (50, 'TRANSFER');
//  ���� �߻�, �÷��� �����Ͽ� ���� ���� �ʴ� ��쿡 NULL�� ������ ����ϴ� �Ͱ� ����.

// ���� 106-1. ��� ���̺� ��� �̸��� null ���� � �����ϴ��� �˻��ϼ���.
select count(*)
    from emp
    where ename = null;

// ���� 106-2. ��� ���̺� ����̸��� not null ������ �ż���.
alter table emp
    modify ename constraint emp_ename_nn not null;

// ���� 106-3. �μ� ���̺� �μ���ȣ�� not null ������ �ż���.
alter table dept
    modify deptno constraint dept_deptno_nn not null;


--------------------------------------------------------------------------------------------
// check : �÷��� �������� �ִ� ���.
// ���� 107. ���� �÷��� 9000���� ū ������ �Էµ��� ���ϰ� �ϼ���.
create table emp6
    (empno number(10),
     ename varchar2(20),
     sal number(10) constraint emp6_sal_ck check (sal between 0 and 6000));
     // between�� ��ȣ�� ������.

insert into emp6 values(7839, 'KING', 5000);
insert into emp6 values(7698, 'BLAKE', 2850);
commit;

select * from emp6;
update emp6 set sal = 9000 where ename = 'KING';
// üũ ���������� �����.

// ���� 107-1. üũ ���������� �����ϼ���.
alter table emp6
    drop constraint emp6_sal_ck;
    
// ���� 107-2. ������� ���̺� üũ���� �ɱ�
//             ��� ���̺� ���޿� üũ������ �Ŵµ� ������ 0~9000 ������ �����͸� �Էµǰ� �ϼ���.
alter table emp
    add constraint emp_sal_ck check(sal between 0 and 9000);

insert into emp(empno, ename, sal) values(1111, 'smith', 9500);
// üũ �������� ����

// ���� 107-1. ��� ���̺��� �μ���ȣ�� �μ���ȣ�� 10��, 20��, 30���� �Է�, �����ǰ� üũ������ �ż���.
alter table emp
    add constraint emp_deptno_ck check(deptno in (10, 20, 30));

insert into emp(empno, ename, sal) values(1111, 'smith', 9500);
// üũ �������� ����

// ���� 107-2. �μ����̺��� �μ���ġ�� NEW YORK, DALLAS, CHICAGO, BOSTON�� �Է�, �����ǰ� üũ������ �ż���.
alter table dept
    add constraint dept_loc_ck check(loc in ('NEW YORK', 'DALLAS', 'CHICAGO', 'BOSTON'));
    
// ���� 107-3. ��� ���̺� �̸��� �÷��� ������ ���� �߰��ϰ� �̸��Ͽ� @�� �־�� �����Ͱ� �Է� �Ǵ� �����ǰ� üũ������ �ż���.
alter table emp
    add email varchar2(50);

alter table emp
    add constraint emp_email_ck check(email like '%@%');


--------------------------------------------------------------------------------------------
// foreign key : primary key�� �����Ͽ�, �׿��� �����ʹ� �Էµ��� ���ϰ� �ϴ� ����.
// primary key�� foreign key�� �����Ǳ� ������, �ܵ����� ������ �Ұ�����.
// ���� foreign key�� ���� ������ �� �����ϰų�, cascade �ɼ��� ���� ��� Ű�� �����ϴ� ����� ����ؾ� ��.
// ����108.
create table dept7
    (deptno number(10) constraint dept7_deptno_pk primary key,
     dname varchar2(14),
     loc varchar2(10));
     
create table emp7
    (empno number(10),
     ename varchar2(20),
     sal number(10),
     deptno number(10) constraint emp7_deptno_fk references dept7(deptno));

insert into dept7
    select deptno, dname, loc
    from dept;
    
insert into emp7
    select empno, ename, sal, deptno
    from emp;
    
insert into emp7 values(1111, 'jack', 3000, 80);
// ���Ἲ �������� ���� - �θ� Ű�� ����.

alter table dept7
    drop constraint dept7_deptno_pk;
    // �����߻� - ����/�⺻ Ű�� �ܺ� Ű�� ���� ������.

alter table dept7
    drop constraint dept7_deptno_pk cascade;
    // ��� Ű ����.

select a.constraint_name, a.constraint_type, b.column_name
    from user_constraints a, user_cons_columns b
    where a.table_name in ('DEPT7', 'EMP7') 
          and a.constraint_name = b.constraint_name;
    // Ű ���� Ȯ��.
    
// ���� 108-1. ��� ���̺��� empno�� primary key�� �ż���.
alter table emp
    add constraint emp_empno_pk primary key(empno);

// ���� 108-2. ��� ���̺� ������ ��ȣ�� foreign key ������ �ɰ� ��� ���̺� �����ȣ�� �ִ� �÷���
//             �����ϰ� �Ͽ�, ������ ��ȣ�� ��� ���̺� �ִ� �����ȣ�� �ش��ϴ� ����鸸 ������ ��ȣ�� �Է� �Ǵ� ������ �� �ֵ��� �ϼ���.
alter table emp
    add constraint emp_mgr_fk foreign key(mgr) references emp(empno);


--------------------------------------------------------------------------------------------
// with ~ as : �˻��� �����ɸ��� ��뷮 ������ ���̽�����, �������� �ݺ��Ǵ� ���(���� �������� ������������ ���Ǵ� ��� ��),
//             �� �ؼ��ϱ� ���� ����ϴ� ���. ���� Ʃ���� ���� ���� ��� �����.
// ����

//1) �Ʒ��� ������ 20���� �ɸ��� ������
select job, sum(sal) as ��Ż
    from emp
    group by job;
    
//2) �ش� ������ 1)�� ����� ������ ������������ �����ϱ� ������ �� 40���� �ɸ��� ��.
select job, sum(sal) as ��Ż
    from emp
    group by job
    having sum(sal) > (select job, sum(sal) as ��Ż
                        from emp
                        group by job);
                        
                        
//3) with ~ as ���� ����� ������ 1)�� ���� ������ 20���� �ҿ��Ͽ� �ӽ����̺��� ����
with job_sumsal as (select job, sum(sal) as ��Ż
                  from emp
                  group by job);
                
//4) 2)�� ���� ����� ��Ÿ���� �ش� ������, with ~ as���� �̿��Ͽ� ������ �ӽ����̺��� ����ϱ� ������,
//   2)���� �ξ� ���� �ҿ�ð��� �Һ��ϰ� ��.
select job, ��Ż
    from job_sumsal
    where ��Ż > (select avg(��Ż)
                 from job_sumsal);

// 3), 4)�� �Բ� �����ؾ� ��.                
with job_sumsal as (select job, sum(sal) as ��Ż
                  from emp
                  group by job)
select job, ��Ż
    from job_sumsal
    where ��Ż > (select avg(��Ż)
                 from job_sumsal);
                 
/ ���� 109-1. �μ���ȣ�� ��Ż������ ����ϴµ� �μ���ȣ�� ��Ż������ ��հ����� �� ū �͸� ����ϼ���.
with dept_sumsal as (select deptno, sum(sal) as total
                     from emp
                     group by deptno)
select deptno, total
    from dept_sumsal
    where total > (select avg(total)
                    from dept_sumsal);

// ���� ��� ���
select deptno, sum(sal)
    from emp
    group by deptno
    having sum(sal) > (select avg(sum(sal))
                        from emp
                        group by deptno);
                        
// ���� 109-2. �μ���ġ, �μ���ġ�� ��Ż������ ����ϴµ� �μ���ġ�� ��Ż������ ��������� �� ū �͸� ����ϼ���.
with loc_sal as (select d.loc as loc,sum(e.sal) as total_salary
                  from emp e join dept d
                  on (e.deptno=d.deptno)
                  group by d.loc)
select loc,total_salary
    from loc_sal
    where total_salary > (select avg(total_salary)
                           from loc_sal);
                           

--------------------------------------------------------------------------------------------
// with ~ as��2 => subquery factoring 
// ���� 110.
with job_sumsal as (select job, sum(sal) ��Ż
                     from emp
                     group by job),
     deptno_sumsal as (select deptno, sum(sal) ��Ż
                       from emp
                       group by deptno
                       having sum(sal) > (select avg(��Ż) + 3000
                                           from job_sumsal))
select deptno, ��Ż
    from deptno_sumsal;
    
// ���� 110. �Ի��� �⵵�� �Ի��� �⵵�� ��Ż������ ����ϴµ� �μ���ȣ�� ��Ż���޵��� ��հ����� �� ū �͸� ����ϼ���.
with deptno_total as (select deptno, sum(sal) total
                     from emp
                     group by deptno),
     hiredate_total as (select to_char(hiredate, 'RRRR') as �Ի�⵵, sum(sal) as total
                         from emp
                         group by to_char(hiredate, 'RRRR')
                         having sum(sal) > (select avg(total)
                                             from deptno_total))
select �Ի�⵵, total
    from hiredate_total;
    
