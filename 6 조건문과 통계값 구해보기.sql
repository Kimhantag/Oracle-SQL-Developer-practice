------------------------------------------------------------------------------------------------
// 06 ���ǹ��� ��谪 ���غ��� // 


// nvl,nvl2 : NULL �� ��� �ٸ� ������ ����ϱ�, nvl(�÷���, ���氪) //
// �����ϴ� �÷��� ���氪�� ���� ���°� ���ƾ���. // 
// ���� 33. �̸��� Ŀ�̼��� ����ϴµ� Ŀ�̼��� null�� ������� no comm�̶�� �۾��� ��µǰ� �ϼ���. //
select ename, nvl(to_char(comm), 'no comm')
    from emp; 
    

// decode�� ���� SQL���� if�� �����ϱ� //
// decode( ���� �÷�, ����1, ���1, ����2, ���2, ... , ������) // 
// ���� 34. �̸�, ����, ���ʽ��� ����ϴµ� ������ SALESMAN�̸� 6000�� ����ϰ� ������ ANALYST�� //
//         3000�� ����ϰ� ������ MANAGER�� 2000�� ����ϰ� ������ ������ 0���� ��µǰ� �Ͻÿ�. //
select ename, job, decode(job, 'SALESMAN', 6000,
                                'ANALYST', 3000,
                                'MANAGER', 2000, 0) as ���ʽ�
    from emp;
    
    
// case�� ���� SQL���� if���� �����ϱ� //
// case when �÷���, ����1 then ���氪1 when �÷��� ����2 then ���氪2 ... else �������� end //
// ���� 35. �̸�, ����, ���ʽ��� ����ϴµ� //
//         ������ 3000�̻��̸� ���ʽ��� 9000�� ����ϰ�, //
//         ������ 2000�̻��̸�(2000�̻��̸鼭 3000���� ������) 8000�� ����ϰ� //
//         ������(2000���� ���� �����)�� 0�� ����Ͻÿ�. //

select ename, sal, case when sal >= 3000 then 9000
                        when sal >= 2000 then 8000
                        else 0 end as ���ʽ�
    from emp;
    

// max : �ִ밪 ����ϱ� //
// ���� 36-1. ������ SALESMAN�� ����� �߿����� �ִ������ ����ϼ���.//
select max(sal)
    from emp
    where job = 'SALESMAN';
    
// ���� 36-2. ������ SALESMAN�� ����� �߿����� �ִ������ ����ϴµ� �Ʒ��� ���� ������ ����ϼ���. //
select job, max(sal)
    from emp
    where job = 'SALESMAN'
    group by job;
    // from - where - group by - select�� ������ ����, group by�� ���� //
    // job�� 'SALESMAN'�� ��ǥ�ϴ� �ϳ��� ���� ����.// 
    

// min : �ּҰ� ����ϱ� //
// ���� 37-1. �μ���ȣ�� 20���� ����� �߿��� �ּ� ������ ����ϼ���. //
select min(sal)
    from emp
    where deptno = 20;
    
// ���� 37-2. �μ���ȣ�� �μ���ȣ�� �ּҿ����� ����ϼ���. //
select deptno, min(sal)
    from emp
    group by deptno;


// avg : ��հ� ���ϱ� //
// ���� 38-1. ������ ������ ��� ������ ����ϴµ� ������ ��� ������ ���� �ͺ��� ����ϼ���. //
select job, round(avg(sal))
    from emp
    group by job
    order by 2 desc;
    // from - group by - select - order by ������ ���� //
    
// ���� 38-2. �μ���ȣ, �μ���ȣ �� ��� ������ ����ϴ��� �μ���ȣ �� ��տ����� ����� �� õ������ ǥ���Ͻÿ�. //
select deptno, to_char(round(avg(sal)), '999999,999') as ��տ���
    from emp
    group by deptno;
    

// sum : �հ� ���ϱ� //
// ���� 39-1. 1981�⵵�� �̻��� ������� ������ ��Ż���� ����ϼ���. //
select sum(sal)
    from emp
    where to_char(hiredate, 'RRRR') = '1981';
    
// ���� 39-2. ������ ������ ��Ż������ ����ϴµ� ������ ��Ż������ 6000�̻��� �͸� ����ϼ���. //
select job, sum(sal)
    from emp
    group by job
    having sum(sal)>=6000;
    // group �Լ��� �˻������� �� ���� where�� �ƴ϶� having ���� �ۼ��ؾ� ��.//


// count : �� �� ����ϱ�, count(*) : �� ��ü�� �� //
// count �Լ��� �׷��Լ���, null ���� �����ϰ� ��, avg, sum ���� �������� //
// ���� 40-1. �μ���ȣ, �μ���ȣ �� �ο����� ����ϼ���. //
select deptno, count(*)
    from emp
    group by deptno;
    
// ���� 40-2. ������ ������ �ο����� ����ϴµ� ������ SALESMAN�� �����ϰ� ����ϰ� ������ �ο����� //
//            3�� �̻��� �͸� ����ϼ���. //
select job, count(*)
    from emp
    where job != 'SALESMAN'
    group by job
    having count(*) >= 3;
    // ���� �Ʒ��� ����� ���� �����̳� having ���� �ƴ� where���� ���� ���� ���͸��ϴ� ���� ȿ������. //
    // = select job, count(*)
    //     from emp
    //     group by job
    //     having job!='SALESMAN' and count(*) >= 3; //