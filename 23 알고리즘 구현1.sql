--------------------------------------------------------------------------------------------
// 23 알고리즘 구현1


--------------------------------------------------------------------------------------------
// 예제 111. sql로 1부터 10까지 출력하고 구구단 2단 출력하기.
select level as num
    from dual
    connect by level <= 10;
    
with loop_table as (select level as num
                     from dual
                     connect by level <= 10)
select '2'||'x'||num||'='|| 2*num as "2단"
    from loop_table;

// 문제 111-1. 1부터 100까지의 합은 얼마인가요?
select sum(level)
    from dual
    connect by level <= 100;
    
// 문제 111-2. 1부터 100까지 합에서 숫자 55를 뺀수의 합은 얼마인가요?
select sum(level)
    from dual
    where level != 55
    connect by level <= 100;


// 문제 111-3. 1부터 100까지 짝수의 합은 얼마인가요?
select sum(level)
    from dual
    where mod(level,2) = 0
    connect by level <= 100;
    

--------------------------------------------------------------------------------------------
// 예제 112. 구구단 전체를 sql로 출력하세요.
with loop_table as (select level+1 as num
                     from dual 
                     connect by level <= 8),
     gugu_table as (select level as gugu
                     from dual
                     connect by level <= 9 )
select to_char(a.num)||'x'||to_char(b.gugu)||'='||to_char(b.gugu*a.num) as 구구단
    from loop_table a, gugu_table b;
    // where절 없이 조인되었기 때문에 값이 조인됨.
    
// 문제 112-1. 위의 결과에서 2, 5, 7단만 출력하세요.
with loop_table as (select level as num
                     from dual 
                     connect by level <= 9),
     gugu_table as (select level  as gugu
                     from dual
                     connect by level <= 9 )
select to_char(a.num)||'x'||to_char(b.gugu)||'='||to_char(b.gugu*a.num) as 구구단
    from loop_table a, gugu_table b
    where a.num in (2, 5, 7);
    
// 문제 112-2. 구구단 전체에서 짝수단만 출력하세요.
with loop_table as (select level as num
                     from dual 
                     connect by level <= 9),
     gugu_table as (select level  as gugu
                     from dual
                     connect by level <= 9 )
select to_char(a.num)||'x'||to_char(b.gugu)||'='||to_char(b.gugu*a.num) as 구구단
    from loop_table a, gugu_table b
    where mod(a.num, 2) = 0;
    
    
--------------------------------------------------------------------------------------------
// 예제 113. 직각 삼각형을 SQL로 출력하세요.
with loop_table as (select level as num
                     from dual
                     connect by level <= 8)
select lpad('★', num, '★') as 직각삼각형
    from loop_table;
    // lpad('★', N, '★'): N번째 자리에 ★이 있고 왼쪽부분의 자리들(N-1, N-2, ... 1)에 ★을 채움

// 문제 113-1. 뒤집어진 직각 삼각형을 출력하세요.
with loop_table as (select 9-level as num
                     from dual
                     connect by level <= 8)
select lpad('★', num, '★') as 역직각삼각형
    from loop_table;
    
// 문제 113-2. 예제113, 문제113-1을 위아래로 결합한 모형을 출력하세요.
with loop_table as (select level as num
                     from dual
                     connect by level <= 8)
select lpad('★', num, '★') as star
    from loop_table
union all
select lpad('★', 9-num, '★') as star 
    from loop_table;
    
    
--------------------------------------------------------------------------------------------
// 예제114. 삼각형을 SQL로 출력하세요.
with loop_table as (select level as num
                     from dual
                     connect by level <= 8)
select lpad(' ', 10-num, ' ') || lpad('★', num, '★') as triangle
    from loop_table;
    
// 문제114. 역삼각형을 SQL로 출력하세요.
with loop_table as (select level as num
                     from dual
                     connect by level <= 8)
select  lpad(' ', num, ' ')  || lpad('★', 9-num, '★')  as triangle
    from loop_table;
    // ||를 기준으로 조건의 순서에 따라 차이가 발생함에 유의.