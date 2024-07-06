-------------------------------------------------------------------------------------------
// 4 특정조건으로 데이터 출력하기 //

// substr : 문자에서 특정 철자 추출 //
// dual : 함수로 실행되는 하나의 결과값을 보기 위한 가상의 테이블 //
// 문제 17. 사원 테이블에서 이름을 출력하는데 이름의 첫글자만 출력하고 첫글자를 소문자로 출력하세요.//
select lower(substr(ename,1,1))
    from emp
    
    
// length : 문자열의 길이를 출력하기, length(문자열) //
// 문제 18. 이름의 철자의 길이가 5개 이상인 사원들의 이름과 이름의 철자의 길이를 출력하세요.//
select ename, length(ename)
    from emp
    where length(ename) >= 5;

    
// INSTR : 문자에서 특정 철자의 위치 출력하기 //
// 문제 19. 이름에 철자 S가 포함된 사원들의 이름을 출력하세요. // 
select ename
    from emp
    where instr(ename, 'S') > 0;
    

// replace : 특정 철자를 다른 철자로 변경하기 //
// regexp : 정규식 표현으로 regexp_뒤에 사용할 함수명을 입력 후 원하는 값을 출력합니다. //
// 문제 20. 이름과 월급을 출력하는데 숫자 0번부터 3번까지는 *로 출력되게 하세요. // 
select ename, regexp_replace(sal, '[0,3]', '*')
    from emp;
    
    
// lpad, rpad : 특정 철자를 n개 만큼 채우기 //
// 문제 21. 이름과 월급을 출력하는데 월급 컬럼의 자릿수를 10자리로 하고, 월급을 출력하고 //
//         남은 나머지 자리 오른쪽에 *을 채워서 출력//
select ename, rpad(sal, 10, '*')
    from emp;
    

// trim, rtrim, ltrim : 특정 철자 잘라내기 //
// rtrim("문자열", "잘라낼 철자"), ltrim("문자열", "잘라낼 철자") //
// trim ("잘라낼 철자" from "문자열") //
// 문제 22. 다음의 데이터를 사원 테이블에 입력하고 이름이 JACK인 사원의 이름과 월급을 출력하세요. //
insert into emp(empno, ename, sal)
  values(3821, 'JACK ', 3000);
  commit;

select ename, sal
    from emp
    where rtrim(ename) = 'JACK';

delete from emp
    where trim(ename) = 'JACK';


// round : 반올림해서 출력하기 //
// 문제 23. 사원테이블에서 이름과 월급의 12%를 출력하는데 소수점 이하는 출력되지 않도록 반올림하세요. //
select ename, round(sal*0.12,0)
    from emp;


// trunc : 숫자를 버리고 출력하기 //
// 문제 24. 사원 테이블에서 이름과 월급의 12%를 출력하는데 소수점 이하는 출력되지 말고 버리세요. //
select ename, trunc(sal*0.12,0)
    from emp;
    

// mod : 나눈 나머지 값 출력하기 //
// 문제 25. 사원번호가 홀수인 사원들의 사원번호와 이름을 출력하세요. //
select empno, ename
    from emp
    where mod(empno, 2) = 1;