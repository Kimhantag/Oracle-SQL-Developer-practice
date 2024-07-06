-------------------------------------------------------------------------------------------
// 5 ��¥ �����Ϳ� ������ ���� ��ȯ�ϱ� //

// months_between : ��¥ �� ���� �� ����ϱ�, months_between(�ֽų�¥, ���ų�¥) //
// sysdate : ���� ��¥ ��� //
// ���� 26. ���� �¾ ������ ���ñ��� �� �� ������ ����ϼ���. //
select round(months_between(sysdate, '1999/08/29'))
    from dual;
    

// add_months : ���� �� ���� ��¥ ����ϱ�, add_months(���س�¥, ���� ���� ��) //
// ���� 27. ���ú��� 100�� ���� ��¥�� ��� �Ǵ��� ����ϼ���. //
select add_months(sysdate, 100)
    from dual;
    

// next_day : Ư����¥ �ڿ� ���� ������ ��¥ ����ϱ�, next_day(���س�¥, ������ ���ƿ� ����) //
// ���� 28. ���ú��� ������ ���ƿ� �ݿ����� ��¥�� ��� �Ǵ��� ����ϼ���. //
select next_day(sysdate, '�ݿ���')
    from dual;
    

// last_day : Ư�� ��¥�� �ִ� ���� ������ ��¥ ����ϱ� //
// ���� 29. ���ú��� ��� �� ���ϱ��� �� ���� ���Ҵ��� ����ϼ���. //
select last_day(sysdate) - sysdate
    from dual;
    
select ename, hiredate, to_char(hiredate, 'RRRR'), to_char(hiredate, 'MON')
,to_char(hiredate, 'DD'), to_char(hiredate, 'DAY'), to_char(sal, '$9,999,999')
    from emp
    where ename='SCOTT';

//*******************************************************************************//
// to_char : ���������� ������ ���� ��ȯ�ϱ� //
// ��¥�� => ������ //
// ������ => ������ //
// to_char(��¥ �÷���, ��¥ ����//
// ��¥ ���� => �⵵ : RRRR, YYYY, RR, YY //
//              �� : MON, MM            //
//              �� : DD                 //
//             ���� : DAY, DY            //
//*******************************************************************************//


// ���� 30-1. �����Ͽ� �Ի��� ������� �̸��� �Ի��ϰ� �Ի��� ������ ����ϼ���. //
select ename, hiredate, to_char(hiredate, 'DD')
    from emp
    where to_char(hiredate, 'DAY') = '������';

// ���� 30-2. ���� �¾ ������ ������ ����ϼ���. //
select to_char(to_date('1999/08/29', 'RRRR/MM/DD'), 'DAY')
    from dual;
    
    
// nls_session_parameters : ���� ��¥�� �������� Ȯ���ϱ� //
select *
    from nls_session_parameters;
// to_date : ��¥������ ������ ���� ��ȯ�ϱ�, ��¥�� ���İ� ������� �˻������� �����Ű�� ���� ��� //
// ���� 31. 1981�⵵�� �Ի��� ������� �̸��� �Ի����� ����ϴµ� �ֱٿ� �Ի��� ������� ����ϼ���. //
select ename, hiredate
    from emp
    where to_char(to_date(hiredate, 'RRRR/MM/DD'), 'RRRR') = '1981'
    order by hiredate desc;
// ���� ǥ���� //
select ename, hiredate
    from emp
    where hiredate between to_date('1981/01/01', 'RRRR/MM/DD')
                       and to_date('1981/12/31', 'RRRR/MM/DD')+1
    order by hiredate desc;
    
   
// �Ͻ��� �� ��ȯ �����ϱ� //
// �Ͻ��� ����ȯ : Oracle DB���� �������� �����͸� Ȯ�� �� �ڵ����� �� ��ȯ�� �����մϴ�. //
// �׷��� �ӵ��� ������ �� �����Ƿ�, ���¸� ���ߴ� ���� ȿ���� ���� //
// ���� - sal:������, '3000':������ //
select ename, sal
    from emp
    where sal = '3000';
    
// Query �����ȹ : ���ǹ��� ����Ǵ� ������ ������ ��� //
// explain plan for ~ from table(dbms_xplan.display) //
explain plan for
select ename, sal
    from emp
    where sal = '3000';
    
select * from table(dbms_xplan.display);

// ���� 32. ������ �������� ������ �ɱ��? //
// ������ ������ sal �÷� ��ü�� ���������� ��ȯ�ϹǷ�, ȿ������ ���ٰ� �� �� ����. //
// ���� ó������ sal �÷��� ���������� �ۼ��ϴ� ����� �� ���ٰ� �� �� �ִ�. //
explain plan for 
select ename, sal
    from emp
    where sal like '30%';

select * from table(dbms_xplan.display);