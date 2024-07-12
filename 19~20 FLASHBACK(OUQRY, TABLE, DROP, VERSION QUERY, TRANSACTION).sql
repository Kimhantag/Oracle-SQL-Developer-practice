--------------------------------------------------------------------------------------------
// 19~20 FLASHBACK(OUQRY, TABLE, DROP, VERSION QUERY, TRANSACTION)


--------------------------------------------------------------------------------------------
// flashback query : �Ǽ��� ���� ������ ����
// as of timestamp(systimestamp - interval 'N' minute) : ���� �ð�(systimestamp)�κ��� N������ ������ ����.
// ���� 99. ��� ���̺��� ����� ���� 5������ ���·� �˻��ϼ���.
select * from emp;

delete from emp;
commit;

select * from emp;
rollback;

select *    
    from emp
    as of timestamp(systimestamp - interval '5' minute);
    // systimestamp : ���� �ð�
    
insert into emp
    select *    
    from emp
    as of timestamp(systimestamp - interval '5' minute);
select * from emp;

show parameter undo;
// undo_retention�� ���� flashback�� ������ �ð��� Ȯ��.

// ���� 99. ������̺��� ������ ��� 0���� �����ϰ� commit�� �Ŀ� ������̺��� 1���� ���·� �ǵ�������.
update emp
    set sal = 0;
select * from emp;
commit;

merge into emp e1
    using (select empno, sal
             from emp 
             as of timestamp(systimestamp - interval '50' minute)) e2
    on (e1.empno = e2.empno)
    when matched then
    update set e1.sal = e2.sal;
    
select empno, sal
    from emp;
    

--------------------------------------------------------------------------------------------
// flash table : �Ǽ��� ���� ���̺��� ����
//               1) alter table ���̺�� enable row movement : ���̺��� ������ �� �ִ� ���·� ����
//               2) flashback table emp to timestamp(systimestamp - interval 'N' minute)
//                  : ���� �ð����� ���� N�� �� ������ ���̺�� flashback
// ���� 100. ������̺��� ����� ���� 5������ ���·� �ǵ�������.
select * from emp;
delete from emp;
commit;
rollback;

select * from emp;

alter table emp enable row movement;

flashback table emp to timestamp(systimestamp - interval '5' minute);
select * from emp;
commit;

// ���� 100. ��� ���̺��� ������ ���� 0���� �����ϰ�, commit�Ŀ� 0���� �����ϱ� �� ���̺�� �����ϼ���.
update emp
    set sal = 0;
select * from emp;
commit;

flashback table emp to timestamp(systimestamp - interval '5' minute);
select * from emp;
commit;


--------------------------------------------------------------------------------------------
// flash drop : drop���� ���������� ������ ������ ����
// flashback table ���̺�� to before drop : ���� �������� drop�� ���̺��� flashback
// select * from user_recyclebin : drop�� ���̺���� �����ϴ� �������� ���
// purge recyclebin : ������ ����
// ���� 101. drop���� ���� �����͸� �����ϼ���.
select * from emp;
drop table emp;

select *
    from user_recyclebin
    order by droptime desc;
    
flashback table emp to before drop;
select * from emp;

purge recyclebin;
select * from user_recyclebin;

// ���� 101. dept ���̺��� drop�ϰ� �ٽ� �����ϼ���.
drop table dept;
select * from dept;

select * from user_recyclebin;
flashback table dept to before drop;

select * from dept;


--------------------------------------------------------------------------------------------
// flashback version query : ���̺� ���� ������ ��� �̷�������� Ȯ���ϱ�.(�����Ͱ� ��� ���ؿԴ���.)
// <versions query�� �ۼ��� ��>
// 1.commit�� ����Ǿ�� version�� ������Ʈ ��
// 2.version_starttime�� �ʱⰪ�� null�� �Ǿ� �����Ƿ� nulls first�� �ۼ��ϸ� ������� Ȯ���ϱ� ������.
// 3.to_timestamp���� Ư�� ������ ���� �������� ������ �� ����,
// ���� 102. �μ����̺��� �μ���ġ�� 
select * from dept;
update dept
    set loc ='SEOUL';
    
select deptno, dname, loc, versions_starttime, versions_endtime, versions_operation
    from dept
    versions between timestamp to_timestamp('24/07/08 16:30:00', 'RRRR-MM-DD HH24:MI:SS') and maxvalue
    order by versions_starttime;
    
 
 --------------------------------------------------------------------------------------------
 // flashvack transation query : ������ �����͸� �ٽ� ������ �� �ִ� ��ũ��Ʈ�� ���