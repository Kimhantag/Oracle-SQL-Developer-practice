-------------------------------------------------------------------------------------------------
// 3 ���������, �񱳿����� //

// from, where, select ������ �����, ���� select�� alias�� order by ���� ������ �ٸ� ������ ���Ұ�. //
// ����9. ������ ANALYST �� ������� �̸��� ������ ����ϼ���. //
select ename, sal*12 as ����
    from emp
    where job = 'ANALYST';
    

// ����10. ������ SALESMAN�� �ƴ� ������� �̸��� ������ ����ϼ���. //
select ename, job
    from emp
    where job != 'SALESMAN';
    

// ����11-1. ������ 1000���� 3000���̰� �ƴ� ������� �̸��� ������ ����ϼ���. //
select ename, sal
    from emp
    where sal not between 1000 and 3000; // == where sal < 1000 or sal > 3000;//
    
// ����11-2. 1981�� 11�� 01�Ϻ��� 1982�� 05�� 30�� ���̿� �Ի��� ������� �̸��� �Ի����� ����ϼ���. //
select ename, hiredate
    from emp
    where hiredate between '81/11/01' and '1982/05/30';


// %:wild card, �� �ڸ��� ���� �͵� ������� �� ������ ��� �ǵ� �������.//
// _:under bar, �� �ڸ��� ���� �͵� ������� �ڸ����� �ϳ����� �Ѵ�.// 
// ����12-1. �̸��� �����ڰ� T�� ������ ������� �̸��� ����ϼ���. //
select ename
    from emp
    where ename like '%T';

    
// ����12-2. �̸��� �ι�° ö�ڰ� M�� ������� �̸��� ����ϼ���. //
select ename
    from emp
    where ename like '_M%';


// null : 1. �����Ͱ� ���� ����, 2. �� �� ���� �� -> �񱳿����� �Ұ�. //
// null�� 0�� �ٸ� //
// ���� 13. Ŀ�̼��� null�� �ƴ� ������� �̸��� Ŀ�̼��� ����ϼ���. // 
select ename, comm
    from emp
    where comm is not null;


// ���� ���� ���� �� '=' ��ſ� in ������ ���. //
// ���� 14. ������ SALESMAN, ANALYST, MANAGER�� �ƴ� ������� �̸��� ���ް� ������ ����ϼ���. //
select ename, sal, job
    from emp
    where job not in ('SALESMAN', 'ANALYST', 'MANAGER');


// ���� 15. �μ���ȣ�� 30���̰� Ŀ�̼��� 100�̻��� ������� �̸��� ���ް� Ŀ�̼��� ����ϼ���. //
select ename, sal, comm
    from emp
    where deptno = 30 and comm >= 100;
    

// lower : (�÷��� �Ǵ� "���ڿ�") , initcap : ù�ڴ� �빮�� �������� �ҹ��� //
// ���� 16. �̸��� scott�� ����� �̸��� ������ ����ϴµ� �ҹ��ڷ� �˻��ص� ����� ��µǰ� �ϼ���.//
select ename, sal
    from emp
    where lower(ename)='scott';