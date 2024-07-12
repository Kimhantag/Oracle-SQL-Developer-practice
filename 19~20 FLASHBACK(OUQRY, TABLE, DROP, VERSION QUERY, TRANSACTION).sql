--------------------------------------------------------------------------------------------
// 19~20 FLASHBACK(OUQRY, TABLE, DROP, VERSION QUERY, TRANSACTION)


--------------------------------------------------------------------------------------------
// flashback query : 실수로 지운 데이터 복구
// as of timestamp(systimestamp - interval 'N' minute) : 현재 시간(systimestamp)로부터 N분전의 데이터 복구.
// 예제 99. 사원 테이블을 지우기 전인 5분전의 상태로 검색하세요.
select * from emp;

delete from emp;
commit;

select * from emp;
rollback;

select *    
    from emp
    as of timestamp(systimestamp - interval '5' minute);
    // systimestamp : 현재 시간
    
insert into emp
    select *    
    from emp
    as of timestamp(systimestamp - interval '5' minute);
select * from emp;

show parameter undo;
// undo_retention을 통해 flashback이 가능한 시간을 확인.

// 문제 99. 사원테이블의 월급을 모두 0으로 변경하고 commit한 후에 사원테이블을 1분전 상태로 되돌리세요.
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
// flash table : 실수로 지운 테이블을 복구
//               1) alter table 테이블명 enable row movement : 테이블을 수정할 수 있는 상태로 변경
//               2) flashback table emp to timestamp(systimestamp - interval 'N' minute)
//                  : 현재 시간으로 부터 N분 전 상태의 테이블로 flashback
// 예제 100. 사원테이블을 지우기 전인 5분전의 상태로 되돌리세요.
select * from emp;
delete from emp;
commit;
rollback;

select * from emp;

alter table emp enable row movement;

flashback table emp to timestamp(systimestamp - interval '5' minute);
select * from emp;
commit;

// 문제 100. 사원 테이블의 월급을 전부 0으로 변경하고, commit후에 0으로 변경하기 전 테이블로 복구하세요.
update emp
    set sal = 0;
select * from emp;
commit;

flashback table emp to timestamp(systimestamp - interval '5' minute);
select * from emp;
commit;


--------------------------------------------------------------------------------------------
// flash drop : drop으로 휴지통으로 지워진 데이터 복구
// flashback table 테이블명 to before drop : 가장 마지막에 drop된 테이블을 flashback
// select * from user_recyclebin : drop된 테이블들이 존재하는 휴지통을 출력
// purge recyclebin : 휴지통 비우기
// 예제 101. drop으로 인한 데이터를 복구하세요.
select * from emp;
drop table emp;

select *
    from user_recyclebin
    order by droptime desc;
    
flashback table emp to before drop;
select * from emp;

purge recyclebin;
select * from user_recyclebin;

// 문제 101. dept 테이블을 drop하고 다시 복구하세요.
drop table dept;
select * from dept;

select * from user_recyclebin;
flashback table dept to before drop;

select * from dept;


--------------------------------------------------------------------------------------------
// flashback version query : 테이블에 관한 조작이 어떻게 이루어졌는지 확인하기.(데이터가 어떻게 변해왔는지.)
// <versions query를 작성할 때>
// 1.commit이 진행되어야 version이 업데이트 됨
// 2.version_starttime의 초기값은 null로 되어 있으므로 nulls first를 작성하면 순서대로 확인하기 용이함.
// 3.to_timestamp값은 특정 시점을 시작 지점으로 설정할 수 있음,
// 문제 102. 부서테이블의 부서위치를 
select * from dept;
update dept
    set loc ='SEOUL';
    
select deptno, dname, loc, versions_starttime, versions_endtime, versions_operation
    from dept
    versions between timestamp to_timestamp('24/07/08 16:30:00', 'RRRR-MM-DD HH24:MI:SS') and maxvalue
    order by versions_starttime;
    
 
 --------------------------------------------------------------------------------------------
 // flashvack transation query : 지워진 데이터를 다시 복구할 수 있는 스크립트를 출력