// 12~13 ���� �����ڿ� �������� //

// union all : ���տ����ڷ� �����͸� ���Ʒ��� �����ϱ�. //
// �����ϴ� ���̺��� ����ϴ� �÷��� ������ ������ ������ ��ġ���Ѿ� ��. //
// ���� 67. �μ���ȣ�� �μ���ȣ�� ��Ż ������ ����ϴµ� ������ ���� �� �Ʒ��� ��ü ��Ż ���޵� ����ϼ���. //
select deptno, sum(sal)
    from emp
    group by deptno
union all
select to_number(null) as deptno, sum(sal)
    from emp
    order by deptno asc;
    
// ���� 67. ������ ������ ��Ż������ ����ϴµ� �� �Ʒ��� ��ü ��Ż���޵� ����ϼ���. //
select job, sum(sal)
    from emp
    group by job
union all
select to_char(null) job, sum(sal)
    from emp
    order by job asc;
 
// rollup�� �̿��Ͽ� ����ϴ� �͵� ������.//
select job, sum(sal)
    from emp
    group by rollup(job)
    order by job asc;


// union : ���� �÷��� �������� �����Ͽ� �����͸� ������. //
// ���� 68. �Ի��� �⵵, �Ի��� �⵵�� ��Ż������ ����ϴµ� �� �Ʒ��� ��ü ��Ż ������ ��µǰ� �ϼ���. //
//         �Ի��� �⵵�� ������ �Ǿ ��µǰ� �ϼ���. //
select to_char(hiredate,'RRRR') �Ի�⵵, sum(sal)
    from emp
    group by hiredate
union
select to_char(null) �Ի�⵵, sum(sal)
    from emp
    order by �Ի�⵵ asc;
    

// intersect : �����͸� �������� ����ϱ�. //
// intersect�� �ߺ��Ǵ� ���� ����� �Ӹ� �ƴ϶� ù �÷��� �������� �����Ͽ� ����Ѵ�. //
// ���� 69. ��� ���̺�� �μ� ���̺���� ����� �μ���ȣ�� �������� ����ϼ���. //

select deptno
    from emp
intersect
select deptno
    from dept;
    

// minus : �������� �������� ����ϱ�. //
// ���� 70. �μ����̺��� �����ϴµ� ��� ���̺��� �������� �ʴ� �μ���ȣ��? //
select deptno
    from dept
minus
select deptno
    from emp;
    

// ������ ��������. //
// ���� 71. JONES���� �� ���� ������ �޴� ������� �̸��� ������ ����ϼ���. //
select ename, sal
    from emp
    where sal > (select sal 
                 from emp 
                 where ename = 'JONES');

// ���� 71. ALLEN���� �� �ʰ� �Ի��� ������� �̸��� ������ ����ϼ���. //
select ename, hiredate, sal
    from emp
    where hiredate > (select hiredate
                      from emp
                      where ename = 'ALLEN');
                      
                      
// ������ ��������. //
// ���� �� �������� : ���� ������ ���� ���������� ���ϵǴ� ���� �Ѱ��� ���� >, <, =, !=  ��� //
// ���� �� �������� : ���� ������ ���� ���������� ���ϵǴ� ���� �������� //
// ���� in, not in, >all, <all, >any, <any ���, �ε�ȣ �� ��ȣ ���Ұ� //
// ���� 72. ������ SALESMAN�� ������ ���� ������ �޴� ������� �̸��� ������ ����ϼ���. //
select ename, sal
    from emp
    where sal in (select sal
                  from emp
                  where job = 'SALESMAN');
                  // ������ SALESMAN�� ����� ������ �������� ���� ���� //

// ���� 72. �μ���ȣ�� 20���� ������ ���� ������ ���� ������� �̸��� ������ ����ϼ���. //
select ename, job
    from emp
    where job in (select job
                  from emp
                  where deptno = 20);
                  

// not in �����ڸ� ����� �������� ����ϱ�. //
// ���� 73. �����ڰ� �ƴ� ������� �̸��� ����ϼ���. //

// false case : null�� ���ԵǾ� ���� ���, not in�� ����ϸ� null�� ���� ������ �߰��ؾ���. //
// select ename                      //
//   from emp                        //
//    where empno not in (select mgr // 
//                        from emp); //

select ename
    from emp
    where empno not in (select mgr
                        from emp
                        where mgr is not null);
                        // select nvl(mgr, -1)�� ���� //
                        
                        
// exists, not exist //
// exists���� ������������ ����Ǵ� Ư¡�� ����. //
// ���� 74. �μ����̺� �������� �ʴ� �μ���ȣ, �̸�, ������ ����ϼ���. //
select *
    from dept 
    where not exists (select *
                      from emp
                      where emp.deptno = dept.deptno);
                      

// having�� ���� ���� //
// �׷� �Լ� group by�� �˻������� �ְ� ������ having���� ����ؾ���. where���� ���Ұ�. //
// ���� 75. �μ���ȣ, �μ���ȣ �� �ο����� ����ϴµ� 10�� �μ���ȣ�� �ο������� �� ū �͸� ����ϼ���. //
select deptno, count(*) �μ��ο�
    from emp
    group by deptno
    having count(*) > (select count(*)
                            from emp
                            where deptno = 10);
                            

// from�� ���� ���� //
// rank over()�� ���� �ַ� select������ ��µǴ� �÷��鿡 ���� where������ ������ �ְ� ���� �� // 
// from���� �̿��� �������� �ۼ� //
// ���� 76. ������ SALESMAN�� ����� �߿��� ���� ���� �Ի��� ����� �̸��� �Ի����� ����ϼ���. //
select ename, hiredate
    from (select ename, hiredate, rank() over(order by hiredate asc) rnk
          from emp
          where job = 'SALESMAN')
    where rnk = 1;

// ���� ����� ����ϴ� ���� //
select ename, hiredate
    from (select *
          from emp
          where job = 'SALESMAN'
          order by hiredate asc)
    where rownum = 1
    

// select���� ���� ���� //
// select���� where ���� ���ǰ� select ���� �������� where���� ������ ��� �ۼ��� �� �ֵ��� �Ѵ�. //
// ���� 77. ������ SALESMAN�� ������� �̸��� ������ ����ϰ�, �ִ���ް� �ּҿ��޵� �Բ� ����ϼ���. //
select ename, sal, (select max(sal) from emp where job = 'SALESMAN') �ִ����,
                   (select min(sal) from emp where job = 'SALESMAN') �ּҿ���
    from emp
    where job = 'SALESMAN';

// ���� 77. �μ���ȣ�� 20���� ������� �̸��� ������ ����ϰ� �� ���� 20�� �μ���ȣ�� ������� ��տ����� ��µǰ� �ϼ���. //
select ename, sal, (select avg(sal) from emp where deptno = 20) ��տ���
    from emp
    where deptno = 20;

// **** select ���� 6������ *********** //
//  ����  |   ��   |  �������� ��������  //
//   5     select         ����        //
//   1      from          ����        //
//   2      where         ����        //
//   3     group by      �Ұ���       //
//   4      having        ����        //
//   6     order by       ����        //