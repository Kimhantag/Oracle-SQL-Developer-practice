---------------------------------------------------------------------------------------------
// 14~15 DML, DDL //

// SQL의 종류
// 1. query문 : select, from, where, group by, having, order by
// 2. DML문(Data Manipulate Language): insert, update, delete, merge
// 3. DDL문
// 4. DCL문
// 5. TCL문

---------------------------------------------------------------------------------------------
// insert : 데이터 입력 
// 예제 77. 다음의 데이터를 추가하세요. 
insert into emp(empno, ename, sal, job, hiredate)
    values(2812, 'JACK', 3500, 'ANALYST', to_date('2019/06/05', 'RRRR/MM/DD'));
                                          // 날짜를 입력할 때, to_date를 통해 입력해야 잘 들어감. //

select * from emp;
    
rollback; // 실행한 작업을 기존으로 되돌림 

// 문제 78. 부서테이블에 아래의 데이터를 입력하세요. 
// 부서번호:50, 부서이름:RESEARCH, 부서위치:SEOUL 
insert into dept(deptno, dname, loc)
    values(50, 'RESEARCH', 'SEOUL');
    
select * from dept;

rollback;


---------------------------------------------------------------------------------------------
// commit : 데이터 저장, commit 뒤에 rollbackd을 해도 commit 이전으로 돌아가지 않음.
// rollback : 데이터 저장 취소
insert into emp(empno, ename, sal, deptno)
    values(9382, 'jack', 3000, 10);
    
select * from emp; 

rollback;

select * from emp;


---------------------------------------------------------------------------------------------
// update : 데이터 수정하기
// 예제 79. SCOTT의 월급을 3200으로 수정하세요. 
update emp
    set sal = 3200
    where ename = 'SCOTT';
    
select *
    from emp;
    
// 문제 79. 직업이 SALESMAN인 사원들의 커미션을 7000으로 수정하세요.
update emp
    set comm = 7000
    where job = 'SALESMAN';
    
select * from emp;

rollback;

---------------------------------------------------------------------------------------------
// delete, truncate, drop : 데이터 삭제하기
// ----------------------------------------------
//           |  데이터  |  저장공간  |  저장구조  |
// ----------------------------------------------
// delete   |   삭제   |    유지    |    유지    |    
// truncate |   삭제   |    삭제    |    유지    |
// drop     |   삭제   |    삭제    |    유지    |

// delete from 테이블
// rollback이 가능함.
// 예제 80. SCOTT의 데이터를 삭제하세요.
delete from emp
    where ename = 'SCOTT';
    
select * from emp;

rollback;

// 문제 80-1. 월급이 3000이상인 사원들을 삭제하세요.
delete from emp
    where sal >= 3000;
    
select * from emp;

rollback;

// truncate table 테이블
// rollback이 불가능함. 바로 commit이 되기 때문.
// drop은 휴지통에서 가져올 수 있는데, truncate는 다시 복구할 수 있는 방법이 없기 때문에 가장 조심해서 사용해야 함.
// 문제 80-2. 부서테이블을 지우는데 구조만 남기고 다 삭제하세요. 
truncate table dept;

select * from dept;

rollback;

alter session set nls_Date_format='RR/MM/DD';
drop table emp;
drop table dept;


CREATE TABLE DEPT
       (DEPTNO number(10),
        DNAME VARCHAR2(14),
        LOC VARCHAR2(13) );


INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');

CREATE TABLE EMP (
 EMPNO               NUMBER(4) NOT NULL,
 ENAME               VARCHAR2(10),
 JOB                 VARCHAR2(9),
 MGR                 NUMBER(4) ,
 HIREDATE            DATE,
 SAL                 NUMBER(7,2),
 COMM                NUMBER(7,2),
 DEPTNO              NUMBER(2) );


INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,'81-11-17',5000,NULL,10);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,'81-05-01',2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,'81-05-09',2450,NULL,10);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,'81-04-01',2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,'81-09-10',1250,1400,30);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,'81-02-11',1600,300,30);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,'81-08-21',1500,0,30);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,'81-12-11',950,NULL,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,'81-02-23',1250,500,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,'81-12-11',3000,NULL,20);
INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,'80-12-09',800,NULL,20);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,'82-12-22',3000,NULL,20);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,'83-01-15',1100,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,'82-01-11',1300,NULL,10);


commit;

select * from emp;
select * from dept;


---------------------------------------------------------------------------------------------
// merge : 데이터 입력, 수정, 삭제 한번에 하기
// 예제 82. 사원 테이블에서 부서 위치 컬럼을 생성하세요. 또한 부서 테이블만 있는 부서번호를 사원테이블에 입력하세요.
alter table emp
    add loc varchar2(10);
    // loc 컬럼을 생성하고, 입력되는 문자형 데이터의 길이를 10자까지 입력을 제한함.
select * from emp;

merge into emp e
    using dept d
    on (e.deptno = d.deptno)
    when matched then 
    update set e.loc = d.loc
    when not matched then
    insert (e.empno, e.deptno, e.loc) values(1111, d.deptno, d.loc);

select * from emp;

alter session set nls_Date_format='RR/MM/DD';
drop table emp;
drop table dept;


CREATE TABLE DEPT
       (DEPTNO number(10),
        DNAME VARCHAR2(14),
        LOC VARCHAR2(13) );


INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');

CREATE TABLE EMP (
 EMPNO               NUMBER(4) NOT NULL,
 ENAME               VARCHAR2(10),
 JOB                 VARCHAR2(9),
 MGR                 NUMBER(4) ,
 HIREDATE            DATE,
 SAL                 NUMBER(7,2),
 COMM                NUMBER(7,2),
 DEPTNO              NUMBER(2) );


INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,'81-11-17',5000,NULL,10);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,'81-05-01',2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,'81-05-09',2450,NULL,10);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,'81-04-01',2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,'81-09-10',1250,1400,30);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,'81-02-11',1600,300,30);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,'81-08-21',1500,0,30);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,'81-12-11',950,NULL,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,'81-02-23',1250,500,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,'81-12-11',3000,NULL,20);
INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,'80-12-09',800,NULL,20);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,'82-12-22',3000,NULL,20);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,'83-01-15',1100,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,'82-01-11',1300,NULL,10);


commit;

select * from emp;
select * from dept;

// 문제82. 사원테이블에 부서명 컬럼을 추가하고 해당 사원의 부서명으로 값을 갱신하세요.
alter table emp
    add dname varchar2(10);
select * from emp;

merge into emp e
    using dept d
    on (e.deptno = d.deptno)
    when matched then 
    update set e.dname = d.dname;
select * from emp;

alter session set nls_Date_format='RR/MM/DD';
drop table emp;
drop table dept;


CREATE TABLE DEPT
       (DEPTNO number(10),
        DNAME VARCHAR2(14),
        LOC VARCHAR2(13) );


INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');

CREATE TABLE EMP (
 EMPNO               NUMBER(4) NOT NULL,
 ENAME               VARCHAR2(10),
 JOB                 VARCHAR2(9),
 MGR                 NUMBER(4) ,
 HIREDATE            DATE,
 SAL                 NUMBER(7,2),
 COMM                NUMBER(7,2),
 DEPTNO              NUMBER(2) );


INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,'81-11-17',5000,NULL,10);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,'81-05-01',2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,'81-05-09',2450,NULL,10);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,'81-04-01',2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,'81-09-10',1250,1400,30);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,'81-02-11',1600,300,30);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,'81-08-21',1500,0,30);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,'81-12-11',950,NULL,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,'81-02-23',1250,500,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,'81-12-11',3000,NULL,20);
INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,'80-12-09',800,NULL,20);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,'82-12-22',3000,NULL,20);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,'83-01-15',1100,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,'82-01-11',1300,NULL,10);


commit;


---------------------------------------------------------------------------------------------
// lock : 데이터의 일관성을 유지하기 위해, 각 세션에서 업데이트를 동시에 진행할 때, 
//        우선으로 업데이트를 진행한 세션에서의 내용으로 변경되면, 다른 세션에서 업데이트 할 수 없도록 하는 기능
//        첫 세션에서 업데이트 이후 commit을 수행하면, lock은 풀리게되어, 다른 세션에서 업데이트가 가능해짐.
//        다른 세션에서 업데이트를 추가로 하더라도 commit을 수행해야 최종적으로 업데이트가 반영됨.

// 문제 83. SCOTT으로 접속한 창 2개를 열어놓은 상태에서 하나의 창에서 ALLEN의 월급을 2000으로 수정하고,
//         commit을 안한 상태에서 다른 창에서 ALLEN의 부서번호를 10번으로 수정하면 월급이 수정이 될까?

// => 수정되지 않음, 첫번째 세션에서 commit 되지 않았기 때문에, 전체 행에 LOCK이 걸리게 됨.

