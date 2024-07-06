--------------------------------------------------------------------------------------------------
// 7~8 ������ �м� �Լ� //

// rank : ������ �м� �Լ��� ���� ����ϱ�. //
// rank() over(order by �÷��� asc(or desc) )
// ���� 41. �μ���ȣ�� 20���� ������� �̸��� �μ���ȣ�� ���ް� ���޿� ���� ������ ����ϼ���. //
select ename, deptno, sal, rank() over(order by sal desc) as ����
    from emp
    where deptno = 20;


// dense_rank : ������ �м� �Լ��� ���� ����ϱ�(������ ������ ���, ���� ������ ǥ��) //
// rank() over(partition by �÷�1�� order by �÷�2�� asc(or desc)) : partition by�� ���� �÷�1���� order by ����
// ���� 42-1. ����, �̸�, ������ ����ϴµ� ������ �������� ���� ������ ���� ��������� ������ �ο��ϼ���. //
select job, ename, sal, dense_rank() over(partition by job
                                          order by sal desc) as ����
    from emp;

// dense_rank(���ذ�) within group(order by �÷�) : ���ذ��� �ش� �÷������� ���� //
// ���� 42-2. ������ 2945�� ����� ��� ���̺��� ������ ������ �����ΰ���? //
select dense_rank(2945) within group(order by sal desc)
    from emp;
    

// ntile : ������ �м� �Լ��� ��� ����ϱ�. //
// ntile(n) over(order by �÷��� asc(or desc)) : �÷��� n���� ������� ������ �ű�//
// ���� 43. �̸�, �Ի���, �Ի��� ��� ������ ����� �����µ� ����� 5������� ������ ����ϼ���. //
select ename, hiredate, ntile(5) over(order by hiredate asc) ���
    from emp;
    
    
// cume_dist : ������ ���� ����ϱ�. //
// cume_dist() over(order by �÷��� asc(or desc) : �÷������� ������ ������ ��Ÿ��//
// ���� 44. �μ���ȣ, �̸�, ���ް� ������ ������ ���� ������ ����ϼ���. ���� ������ �μ���ȣ�� ���� ��µǵ��� �ϼ���. //
select deptno, ename, sal, round(cume_dist() over(partition by deptno
                                                  order by sal desc),2) as ����
    from emp;
    
    
// listagg : �����͸� ���η� ����ϱ�. //
// listagg(�÷���, ������ �Ǵ� ��ȣ) within group(order by ���� �÷� asc(or desc)) // 
// : ���� Į���� ���Ŀ� ���� ������(�Ǵ� ��ȣ)�� �и��� �÷��� ������ ���η� ��� //
// * group by ���� �� �Բ� ������ ��. //
// ���� 45. ����, �������� ���� ������� �̸��� ���η� ����ϴµ� ���η� ��µ� ���� ������ ���� ������� ��µǰ� �ϼ���. //
select job, listagg(ename, '/') within group(order by sal desc) 
    from emp
    group by job;
    

// lag, lead : �ٷ� ����� ������ ����ϱ�. //
// lag(�÷���, ���ȣ) over(order by ���� �÷� asc(or desc)) //
// lead(�÷���, ���ȣ) over(order by ���� �÷� asc(or desc)) //
// ���� 46. �̸�, �Ի���, �ٷ� ���� �Ի��� ������� �������� ����ϼ���. //
select ename, hiredate, hiredate - lag(hiredate, 1) over(order by hiredate asc) as ����
    from emp;
    
    
// sum over : ���� ������ ����ϱ�. //
// sum(�÷���) over(order by �����÷�) //
// = sum(�÷���) over(order by �����÷� rows between unbounded preceding and current row) //
// ����50. ������ ANALYST, MANAGER�� ���ʵ��� �����ȣ, ����̸�, ����, ���޿� ���� ����ġ�� ����ϼ���. //
select empno, ename, sal, sum(sal) over(order by empno)����
    from emp
    where job in ('ANALYST', 'MANAGER');

// ���� 50. �μ���ȣ�� 20���� ������� ����̸�, ����, ���޿� ���� ����ġ�� ��µǰ� �ϼ���. //
select ename, sal, sum(sal) over(order by sal)����
    from emp
    where deptno = 20;


// ratio_to_report : ���� ����ϱ�. //
// ratio_to_report(�÷���) over()
// ���� 51. �μ���ȣ�� 20���� ������� �����ȣ, �̸�, ����, ���޿� ���� ������ ����ϼ���. //
select empno, ename, sal, round(ratio_to_report(sal) over(),2 ) ����
    from emp
    where deptno = 20;

    
// rollup : ���� ����� �Ʒ��� ����ϱ�. //
// group by rollup(�÷���) //
// ���� 52. �μ���ȣ, �μ���ȣ�� ��Ż������ ����ϴµ� �� �Ʒ��� ��ü ��Ż������ ��µǰ� �ϼ���. //
select deptno, sum(sal)
    from emp
    group by rollup(deptno);
    

// cube : ���� ����� ���� ����ϱ�. //
// group by cube(�÷���) //
// ���� 53. �Ի��� �⵵(4�ڸ�), �Ի��� �⵵�� ��Ż������ ����ϴµ� ������ ��� ���̺��� ��ü ��Ż������ ����ǰ� �ϼ���. //
select to_char(hiredate, 'RRRR') �Ի�⵵, sum(sal)
    from  emp
    group by cube(to_char(hiredate, 'RRRR'));
    
    
// grouping sets : �÷��� ������ ����ϱ�. //
// grouping sets(�÷���1, �÷���2, ()) : ()�� ��ü ���� ��� //
// grouping sets((�÷���1, �÷���2), ()) : �÷�1, �÷�2�� ���ÿ� ���ϴ� ���� ��� //
select deptno, job, sum(sal)
    from emp
    group by grouping sets(deptno, job, ());
    
select deptno, job, sum(sal)
    from emp
    group by grouping sets((deptno, job), ());
    
// ���� 54. �Ի��� �⵵(4�ڸ�)�� ��Ż���ް� ������ ��Ż������ ���Ʒ��� ���� ����ϼ���. //
select to_char(hiredate, 'RRRR'), job, sum(sal)
    from emp
    group by grouping sets(to_char(hiredate, 'RRRR'), job);
    
    
// row_number : ��°�� �ѹ��� �ϱ�. //
// row_number() over(order by �÷��� asc(or desc)) : �÷����� �������� ���� �ѹ����� ��. //
// ���� 55. ������ 1000���� 3000������ ������� �̸��� ������ ����ϴµ� ����ϴ� ��� �� ���� ��ȣ�� �ѹ����ؼ� ����ϼ���. //
select ename, sal, row_number() over(order by empno) ��ȣ
    from emp
    where sal between 1000 and 3000;
    

// rownum : ��µǴ� �� �����ϱ�. //
// select rownum, ... where rownum < n : rownum�� �׻� ���������� ����ó���Ǿ� �����Ƿ� ����ϰ����ϸ� �Է����ְ� ����ϸ� �ȴ�. //
// rownum = 1�� ���������� rownum = n�� �Ұ���, rownum <= n�� ���·� Ȯ���Ͽ��� ��. //
// ���� 56. ������ SALESMAN�� ������� �̸��� ���ް� ������ ����ϴµ� ������ �� 2���� ����ϼ���. //
select rownum, ename, sal, job
    from emp
    where rownum <= 2 and job = 'SALESMAN';
    

// simple top-n queries : ���� �� ��µǴ� �� �����ϱ�. //
// order by �÷��� asc(or desc) fetch first n rows only : �÷� �������� ���� �� ó������ n ����� ���//
// ���� 57. �ֱٿ� �Ի��� ��������� �̸�, �Ի��ϰ� ������ ����ϴµ� ������ 5�� ����ϼ���. //
select ename, hiredate, sal
    from emp
    order by hiredate desc fetch first 5 rows only;
