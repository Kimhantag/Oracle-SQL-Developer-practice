//---------------------------------------------------------------------------------------//
// 10~11 SQL ���̺� JOIN //

select *
    from emp;

select *
    from dept;

// equl join : ���� ���̺��� �����ؼ� ����ϱ�. //
// join �� �÷��� Ȯ���� ��, �÷��� �տ� ���̺� ��(���̺� ��Ī)�� ���̴� ���� ȿ������. //
// ���� 58-1. ������ SALESMAN�� ������� �̸��� ������ �μ���ġ�� ����ϼ���. //
select ename, e.job, d.loc
    from emp e, dept d
    where e.deptno = d.deptno and e.job = 'SALESMAN';
    
// ���� 58-2. DALLAS���� �ٹ��ϴ� ������� �̸��� ���ް� �μ���ġ�� ����ϼ���. //
select e.ename, e.sal, d.loc
    from emp e, dept d
    where e.deptno = d.deptno and d.loc = 'DALLAS';
    
 
 
// �޿� ��� ���̺� ���� //
create table salgrade
( grade   number(10),
  losal   number(10),
  hisal   number(10) );
 
insert into salgrade  values(1,700,1200);
insert into salgrade  values(2,1201,1400);
insert into salgrade  values(3,1401,2000);
insert into salgrade  values(4,2001,3000);
insert into salgrade  values(5,3001,9999);
 
commit;

select *
    from salgrade;   
// non equl join : ����� �÷��� ���� ���� ���̺��� �����ϱ�. //
// ���� 59. ��� ���̺�� �޿� ���̺��� �����Ͽ� �̸��� ����, ���޿� ���� ����� ����ϼ���. //
select e.ename, e.sal, s.grade
    from emp e, salgrade s
    where e.sal between s.losal and s.hisal;

// ���� 59. �޿������ 4����� ������� �̸��� ������ ����ϴµ� ������ ���� ������� ����ϼ���. //
select e.ename, e.sal
    from emp e, salgrade s
    where e.sal between s.losal and s.hisal
          and s.grade = 4
    order by e.sal desc;



// outer join : ���� ���̺��� �����ϵ�, �����ϴ� �÷��� Ư�� ���̺� ���� ��� �����. //
// equi join�� join ���� �÷��� �������� �����ϴ� ���� ���ؼ��� join��. //
// ���� 60. ������̺� ��ü�� �̸��� �μ���ġ�� ����ϴµ� JACK�� ��µǰ� �ϼ���. //
insert into emp(empno, ename, sal, deptno)
    values(7122, 'JACK', 30000, 70);

select *
    from emp;
    
select e.ename, d.loc
    from emp e, dept d
    where e.deptno = d.deptno(+);
    
    
// self join : ���� ���̺� ���� ���� //
// ���� 61. ����̸��� ������ ����ϰ� ������ �̸��� ������ ����ϼ���. //
//         �׸��� �������� ����麸�� �� ���� ������ �޴� ����� �����͸� ����ϼ���. //
select ���.ename ����̸�, ���.job �������, ���.sal �������,
       ������.ename �������̸�, ������.job ����������, ������.sal �����ڿ���
    from emp ���, emp ������
    where ���.mgr = ������.empno
          and ���.sal > ������.sal;
          

// ���� ���� 1. ����Ŭ ���� ����  //
//           1) equi join / 2) non equi join / 3) outer join / 4) self join //
//          2. 1999 ansi ���� ���� //

// on�� : 1999ansi�� ���� ����
// from ���̺�1 join ���̺�2 //
// on (���̺�1.�÷�1 = ���̺�2.�÷�2) // 
// ���� 62. ������ 1000���� 3000������ ������� �̸��� ���ް� �μ� ��ġ�� on���� ����� ���� �������� ����ϼ���. //
select e.ename, e.sal, d.loc
    from emp e join dept d
    on (e.deptno = d.deptno)    
    where e.sal between 1000 and 3000;
    

// using�� : using���� table ��Ī(alias)�� ���� �ʴ´�. //
// ���� 63. using ���� ����� ���� �������� �μ���ġ�� DALLAS�� ������� �̸��� ���ް� �μ���ġ�� ����ϼ���. //
select e.ename, e.sal, d.loc
    from emp e join dept d
    using (deptno)
    where d.loc = 'DALLAS';
    
    
// natural join : on, using������ �����ϰ� �����ϴ� ��� //
// using ���� ���������� ���� �÷� �տ� ���̺� ��Ī�� ���� �ȵ� //
// ���� 64. ������ SALESMAN�̰� �μ���ȣ�� 30���� ������� �̸��� ������ ���ް� �μ� ��ġ�� ����ϼ���.
select e.ename, e.job, e.sal, d.loc
    from emp e natural join dept d
    where e.job = 'SALESMAN' and
          deptno = 30;
          
          
// left, right outer join //
// ���� 66. ������ �����͸� ��� ���̺� �Է��ϰ� 1999ansi ���� ������ ����Ͽ� �̸��� ����, ���ް� �μ���ġ�� //
//         ����ϴµ� ������̺� JACK�� ��µ� �� �ֵ��� �ϼ���. //
insert into emp(empno, ename, sal, job, deptno)
    values(8282, 'JACK', 3000, 'ANALYST', 50);
commit;

select e.ename, e.job, e.sal, d.loc
    from emp e left outer join dept d
    on (e.deptno = d.deptno);
    
    
// full outer join : SQL join���� �������� �ʴ� ���� //
// ���� 66. ������ ANALYST �̰ų� �μ���ġ�� BOSTON�� ������� �̸�, ����, ����, �μ���ġ�� ����ϴµ� //
//          full outer join�� ����Ͽ� ����ϼ���. //
select e.ename, e.job, e.sal, d.loc
    from emp e full outer join dept d
    on (e.deptno = d.deptno)
    where e.job = 'ANALYST' or d.loc = 'BOSTON';