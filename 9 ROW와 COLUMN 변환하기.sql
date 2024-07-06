--------------------------------------------------------------------------------------------------
// 9 ROW�� COLUMN ��ȯ�ϱ� //

// sum, decode�� �̿��Ͽ� row�� column���� ����ϱ� //
// ���� 47. �μ���ȣ�� �� ������ ����ϴµ� ���η� ����ϼ���. //
select sum(decode(deptno, 10, sal, null)) as "10",
       sum(decode(deptno, 20, sal, null)) as "20",
       sum(decode(deptno, 30, sal, null)) as "30"
    from emp;
    
// ���� 47. ����, ������ ��Ż ������ ���η� ����ϼ���. //
select job, sum(sal)
    from emp
    group by job;
     
select job, sum(decode(job, 'PRESIDENT', sal)) as "PRESIDENT"
          , sum(decode(job, 'MANAGER', sal)) as "MANAGER"
          , sum(decode(job, 'SALESMAN', sal)) as "SALESMAN"
          , sum(decode(job, 'CLERK', sal)) as "CLERK"
          , sum(decode(job, 'ANALYST', sal)) as "ANALYST"
    from emp
    group by job;
    
    
// pivot�� �̿��ؼ� row�� column���� ��Ÿ����. //
// in line view(=from�� ��������) : �������� ���� ó�� ����Ǵ� from ���� ���ο� ������ �ۼ��ϴ� ��� //
// ���� 48. �μ���ȣ�� �μ���ȣ �� �� ������ ����ϴµ� ������ ���� ���η� ����ϼ���. //
select *
    from (select deptno, sal from emp) 
    pivot ( sum(sal) for deptno in (10, 20, 30));
    // from - pivot - select �� ������ ����� //
    
// ���� 48. ����, ������ ��Ż������ pivot ���� �̿��Ͽ� ���η� ����ϼ���. //
// column�� ' '�� ǥ������ �ʰ� �ϴ� ��� : ex) 'PRESIDENT' as "PRESIDENT"
select *
    from (select job, sal from emp)
    pivot (sum(sal) for job in ('PRESIDENT' as "PRESIDENT", 'MANAGER',
                                'SALESMAN', 'CLERK', 'ANALYST'));


// unpivot�� �̿��Ͽ� column�� row�� ����ϱ�. //
// unpivot(����� �÷��� for �����Ͱ� ��µ� �÷��̸� in (������1, ������2, ...) //
// ���� 49. �÷��� �����ͷ� ���� �ٲټ���. //
delete order2;

create table order2
( ename varchar2(10),
  bicycle number(10),
  camera  number(10),
  notebook number(10));
  
insert into order2 values('SMITH', 2, 3, 1);
insert into order2 values('ALLEN', 1, 2, 3);
insert into order2 values('KING', 3, 2, 2);

commit;

select *
    from order2
    unpivot (�Ǽ� for ������ in ("BICYCLE", "CAMERA", "NOTEBOOK"));
    // unpivot(����� �÷��� for �����Ͱ� ��µ� �÷��̸� in (������1, ������2, ...) //
    // ������1, ������2, ... �� �÷����̹Ƿ� " "�� �ٿ��� �ǰ� �Ⱥٿ��� ��(�׷��� ' '�� �ȵ�) //
    
// ���� 49. ���˿��� ���̺��� �����ϰ� ��ȭ����� ���� ū ������ �������� ����ϼ���. //

create table crime_cause
(
crime_type  varchar2(30),
������  number(10),
���� number(10),
���� number(10),
�㿵�� number(10),
����  number(10),
�ذ�  number(10),
¡�� number(10),
������ȭ  number(10),
ȣ��� number(10),
��Ȥ  number(10),
���   number(10),
�Ҹ�   number(10), 
������   number(10),
��Ÿ   number(10)  );


 insert into crime_cause values( '����',1,6,0,2,5,0,0,51,0,0,147,15,2,118);
 insert into crime_cause values( '���ι̼�',0,0,0,0,2,0,0,44,0,1,255,38,3,183);
 insert into crime_cause values( '����',631,439,24,9,7,53,1,15,16,37,642,27,16,805);
 insert into crime_cause values( '������������',62,19,4,1,33,22,4,30,1026,974,5868,74,260,4614);
 insert into crime_cause values( '��ȭ',6,0,0,0,1,2,1,97,62,0,547,124,40,339);
 insert into crime_cause values( '����',26,6,2,4,6,42,18,1666,27,17,50503,1407,1035,22212);
 insert into crime_cause values( '����',43,15,1,4,5,51,117,1724,45,24,55814,1840,1383,24953);
 insert into crime_cause values( 'ü������',7,1,0,0,1,2,0,17,1,3,283,17,10,265);
 insert into crime_cause values( '����',14,3,0,0,0,10,11,115,16,16,1255,123,35,1047);
 insert into crime_cause values( '��������',22,7,0,0,0,0,0,3,8,15,30,6,0,84);
 insert into crime_cause values( '����������',711,1125,12,65,75,266,42,937,275,181,52784,1879,1319,29067);
 insert into crime_cause values( '����',317,456,12,51,17,116,1,1,51,51,969,76,53,1769);
 insert into crime_cause values( '�ձ�',20,4,0,1,3,17,8,346,61,11,15196,873,817,8068);
 insert into crime_cause values( '��������',0,1,0,0,0,0,0,0,0,0,0,0,18,165);
 insert into crime_cause values( '���ǳ���',1,0,0,0,0,0,0,0,0,0,1,0,12,68);
 insert into crime_cause values( '������',25,1,1,2,5,1,0,0,0,10,4,0,21,422);
 insert into crime_cause values( '��ȭ',15,11,0,1,1,0,0,0,6,2,5,0,2,44);
 insert into crime_cause values( '��������',454,33,8,10,37,165,0,16,684,159,489,28,728,6732);
 insert into crime_cause values( '������������',23,1,0,0,2,3,0,0,0,0,3,0,11,153);
 insert into crime_cause values( '���',12518,2307,418,225,689,2520,17,47,292,664,3195,193,4075,60689);
 insert into crime_cause values( 'Ⱦ��',1370,174,58,34,86,341,3,10,358,264,1273,23,668,8697);
 insert into crime_cause values( '����',112,4,4,0,30,29,0,0,2,16,27,1,145,1969);
 insert into crime_cause values( '��ǳ�ӹ���',754,29,1,6,12,100,2,114,1898,312,1051,60,1266,6712);
 insert into crime_cause values( '���ڹ���',1005,367,404,32,111,12969,4,8,590,391,2116,9,737,11167);
 insert into crime_cause values( 'Ư����������',5313,91,17,28,293,507,31,75,720,194,9002,1206,6816,33508);
 insert into crime_cause values( '�������',57,5,0,1,2,19,3,6,399,758,223,39,336,2195);
 insert into crime_cause values( '���ǹ���',2723,10,6,4,63,140,1,6,5,56,225,6,2160,10661);
 insert into crime_cause values( 'ȯ�����',122,1,0,2,1,2,0,0,15,3,40,3,756,1574);
 insert into crime_cause values( '�������',258,12,3,4,2,76,3,174,1535,1767,33334,139,182010,165428);
 insert into crime_cause values( '�뵿����',513,11,0,0,23,30,0,2,5,10,19,3,140,1251);
 insert into crime_cause values( '�Ⱥ�����',6,0,0,0,0,0,1,0,4,0,4,23,0,56);
 insert into crime_cause values( '���Ź���',27,0,0,3,1,0,2,1,7,15,70,43,128,948);
 insert into crime_cause values( '��������',214,0,0,0,2,7,3,35,2,6,205,50,3666,11959);
 insert into crime_cause values( '��Ÿ',13872,512,35,55,552,2677,51,455,2537,1661,18745,1969,20957,87483);
commit;

select *
    from (select * from crime_cause where crime_type = '��ȭ')
    unpivot (�Ǽ� for ��ȭ���� in (������, ����, ����, �㿵��, ����, �ذ�, ¡��, ������ȭ,
                                  ȣ���, ��Ȥ, ���, �Ҹ�, ������, ��Ÿ))
    order by �Ǽ� desc;