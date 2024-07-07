--------------------------------------------------------------------------------------------------
// 16 �������� ����ϱ�2


--------------------------------------------------------------------------------------------------
// select for update�� : ���� �ٸ� ���ǿ��� ������Ʈ�� ���� ����Ƿ��� ��, ���� ������Ʈ�� ������ ���ǿ���,
//                       �ٸ� ���ǿ��� ������Ʈ ���� ���ϰ� lock�� �ɾ������ ���.
select *
    from emp
    where e.name = 'JONES'
    for update;

// ���� 84. �μ���ȣ�� 10, 20���� ������� �̸��� ������ �μ���ȣ�� ��ȸ�ϴ� ����,
//          �ٸ� ���ǿ��� �μ���ȣ 10��, 20���� ������� �����͸� �������� ���ϰ� �ϼ���.
select ename, job, deptno
    from emp
    where deptno in (10, 20)
    for update;
    

--------------------------------------------------------------------------------------------------    
// ���������� ����Ͽ� ������ �Է��ϱ�
// ���� 85. ������̺�� ���� ������ ���ο� ���̺��� �����ϰ�,
//          ������̺��� �μ���ȣ�� 10���� ������� �����ȣ, �̸�, ����, �μ���ȣ�� ������ ���̺��� �Է��ϼ���.
create table emp2
    as
    select *
        from emp;
        // emp���̺�� ������ emp2���̺��� ������.
select * from emp2;
drop table emp2;

create table emp2
    as
    select *
        from emp
        where 1 = 2;
        // 1=2�� �����ϴ� ���� �������� �ʱ� ������, emp�� ����(�÷�)�� ���� emp2���̺��� ������.

// values�� ������ �����ؾ� ��.
insert into emp2(empno, ename, sal, deptno)
    select empno, ename, sal, deptno
        from emp
        where deptno = 10;

select * from emp2;

// ���� 85. �μ� ���̺�� ���� ������ ���̺��� DEPT2��� �̸����� �����ϰ�,
//         �μ���ȣ�� 20��, 30���� ��� �÷��� �����͸� DEPT2�� �Է��ϼ���.
create table dept2
    as
    select *
        from dept
        where 1 = 2;

insert into dept2
    select *
    from dept
    where deptno in (20, 30);
select * from dept2;


--------------------------------------------------------------------------------------------------
// ���������� ����Ͽ� ������ �����ϱ�
// ���� 86. ������ SALESMAN�� ������� ������ ALLEN�� �������� �����ϼ���.
update emp
    set sal = (select sal
                 from emp
                 where ename = 'ALLEN')
    where job = 'SALESMAN';
select * from emp;
rollback;

// ���� 86. �μ���ȣ�� 30���� ������� ������ MARTIN�� �������� �����ϼ���.
update emp
    set job = (select job
                 from emp
                 where ename = 'MARTIN')
    where deptno = 30;
select * from emp;
rollback;


--------------------------------------------------------------------------------------------------
// ���������� ����Ͽ� ������ �����ϱ�
// ���� 87. SCOTT���� �� ���� ������ �޴� ������� �����ϼ���.
delete from emp
    where sal > (select sal
                   from emp
                   where ename = 'SCOTT');
select * from emp;
rollback;

// ���� 87. ALLEN���� �ʰ� �Ի��� ������� ��� ���� ���켼��.
delete from emp
    where hiredate > (select hiredate
                        from emp
                        where ename = 'ALLEN');
select * from emp;
rollback;


--------------------------------------------------------------------------------------------------
// ���������� ����Ͽ� ������ ��ġ��
// ���� 88. ������ ���� �μ����̺� �μ���ȣ�� ��Ż���� �����Ͱ� �Էµǰ� �ϼ���.
alter table dept
    add sumsal number(10);

// merge�� �ۼ� ��, alias�� �ſ� �߿���.
// into���� ���̺� ��(Ȥ�� ��������), using���� ���̺� ��(Ȥ�� ��������) alias �ۼ��� ������ ���� �ۼ�
merge into dept d
    using ( select deptno, sum(sal) as sumsal
              from emp
           group by deptno) v
    on (d.deptno = v.deptno)
    when matched then
    update set d.sumsal = v.sumsal;
select * from dept;
rollback;

// ���� 88. �μ� ���̺� cnt��� �÷��� �߰��ϰ�, �ش� �μ���ȣ�� �ο����� ���� �����Ͻÿ�.
alter table dept
    add cnt number(10);
    
merge into dept d
    using (select deptno, count(*) cnt
             from emp 
         group by deptno) e
    on (d.deptno = e.deptno)
    when matched then
    update set d.cnt = e.cnt; 

select * from dept;
rollback;