--------------------------------------------------------------------------------------------
// 21 데이터 품질 높이기1


--------------------------------------------------------------------------------------------
// primary key : 유일한 값을 가져야하는 컬럼에 대하여 제약함. 중복된 값과 null값이 입력할 수 없게 됨.
// constraint 제약이름 primary key 
// 제약을 주는 방법 : 1. 테이블을 생성할 때 제약부여
//                  2. 만들어진 테이블에 제약부여
// 예제 104. 사원번호에 중복된 데이터와 null값을 입력되지 않게 하세요.
drop table dept2;
create table dept2
    (deptno number(10) constraint dept2_deptno_pk primary key,
     dname varchar2(10),
     loc varchar2(10));

insert into dept2 values(10, 'aaa', 'bbb');
insert into dept2 values(20, 'aaa', 'bbb');
select * from dept2;

insert into dept2 values(10, 'vvv', 'www');
// 무결성 제약조건 위배 에러 발생
insert into dept2 values(null, 'ccc', 'aaa');
// null값 입력불가

select table_name, constraint_name
    from user_constraints
    where table_name = 'DEPT2';
// 테이블 이름과 제약 이름 확인

alter table dept2
    drop constraint dept2_deptno_pk;
// dept2_deptno_pk 제약 제거

alter table dept2
    add constraint dept2_deptno_pk primary key(deptno);
// 기존 테이블에 제약조건을 추가하는 방법

// 문제 104. 사원 테이블의 empno에 primary key를 생성하세요.
alter table emp
    add constraints emp_empno_pk primary key(empno);


--------------------------------------------------------------------------------------------
// unique : 중복된 값을 입력하지 못하게 하는 제약
//
create table dept3
    (deptno number(10),
     dname varchar2(14) constraint dept3_dname_uni unique,
     loc varchar2(10));
     
select a.constraint_name, a.constraint_type, b.column_name
    from user_constraints a, user_cons_columns b
    where a.constraint_name = b.constraint_name
          and a.table_name = 'DEPT3';
   // user_constraints : 테이블마다 존재하는 제약조건 출력
   // user_cons_column : 제약조건이 걸려있는 컬럼명 출력
   
insert into dept3 values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept3 values(20, 'RESEARCH', 'DALLAS');
insert into dept3 values(30, 'SALES', 'CHICAGO');
insert into dept3 values(40, 'OPERATIONS', 'BOSTON');
select * from dept3;

insert into dept3 values(50, 'RESEARCH', 'SEOUL');
// 무결성 제약 조건 위배

alter table dept3
    drop constraint dept3_dname_uni;
select * from dept3;

alter table dept3
    add constraint dept3_dname_uni unique(dname);
insert into dept3 values(50, 'RESEARCH', 'SEOUL');
// 무결성 제약 조건 위배

// 문제 105-1. 사원번호, 사원이름, 월급, 직업을 담는 테이블을 아래와 같이 생성하는데 사원번호 컬럼에
//             중복된 데이터가 입력되지 않게 제약을 걸어서 생성하세요.
//             (테이블명 : emp1000, 컬럼명 : empno, ename, sal, job)
create table emp1000
    (empno number(10) constraint emp1000_empno_uni unique,
     ename varchar2(10),
     sal number(10),
     job varchar2(10));
select * from emp1000;

insert into emp1000 values(1111, 'scott', 3000, 'salesman');
insert into emp1000 values(1111, 'smith', 4000, 'analyst');

// 문제 105-2. 사원테이블의 사원번호에 중복된 데이터가 있는지 검색해보세요.
select empno, count(*)
    from emp
    group by empno
    having count(*) >= 2;
    // 데이터베이스가 커서 한눈에 알아볼 수 없으므로 having 조건을 통해 확인
    
// 문제 105-3. 사원 테이블의 사원번호에 중복되 데이터가 입력되지 못하도록 제약을 거세요.
alter table emp
    add constraint emp_empno_uni unique(empno);