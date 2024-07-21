--------------------------------------------------------------------------------------------
// 26 빅데이터 분석


--------------------------------------------------------------------------------------------
// 사용데이터 : 국립암센터_24개종 암발생률_2018년 12월.csv
// => 공공데이터 포털
// 예제 126. 우리나라 남자들이 가장 많이 걸리는 암을 구하세요.(1999년 기준)
select * 
    from cancer
    where 성 = '남자' and 발생자수 is not null
                     and 암종 != '모든암'
                     and 발생연도 = '1999'
    order by 발생자수 desc fetch first 4 rows only; 

// 문제 126. 우리나라 여자들이 가장 많이 걸리는 암을 구하세요.(1999년 기준)
select * 
    from cancer
    where 성 = '여자' and 발생자수 is not null
                     and 암종 != '모든암'
                     and 발생연도 = '1999'
    order by 발생자수 desc fetch first 4 rows only; 
    

--------------------------------------------------------------------------------------------
// 사용 데이터 : jobs.txt
// 예제 127. 스티븐 잡스 연설문에서 가장 많이 나오는 단어는?
select * from speech;

// 공백이 아닌 것을 1부터 시작해서 2번째 있는 것을 출력해라
select regexp_substr('I never graduated from college', '[^ ]+', 1, 2) word
    from dual;
    
select word, count(*)
    from (
            select regexp_substr(lower(speech_text), '[^ ]+', 1, a) word
                from speech, (select level a
                                from dual
                                connect by level <= 52))
    where word is not null
    group by word
    order by count(*) desc;
    
    
--------------------------------------------------------------------------------------------
// 사용 데이터 : jobs.txt
// 예제 128. 스티브 잡스 연설문에는 긍정단어가 많이 나올까 부정 단어가 많이 나올까?
create table positive ( p_text varchar2(2000));
create table negative ( n_text varchar2(2000));
// 단어 하나의 크기를 최대 2000byte로 설정
select * from speech;
select count(*) from positive;
select count(*) from negative;

alter table speech
    rename column 열1 to speech_text;
    // alter table 테이블명 rename column 기존 컬럼이름 to 새로운 컬럼이름

// 뷰 생성하기 
create or replace view speech_view
as
select regexp_substr(lower(speech_text), '[^ ]+', 1, a) word
    from speech, (select level a
                    from dual
                    connect by level <= 52);
select * from speech_view;
select * from positive;

select count(word) as 긍정단어
    from speech_view
    where lower(word) in (select lower(p_text)
                            from positive);

// 문제 128. 스티브 잡스 연설문에는 부정단어가 몇 건이나 나올까?
select count(word) as 부정단어
    from speech_view
    where lower(word) in (select lower(n_text)
                            from positive);
                            

--------------------------------------------------------------------------------------------
// 사용 데이터 : 2009년 범죄발생 요일 현황.csv
// => 공공 데이터 포털
// 예제 129. 절도가 가장 많이 발생하는 요일은 언제인가요?

create table crime_day
    (crime_day varchar2(50),
     sun_cnt number(10),
     mon_cnt number(10),
     tue_cnt number(10),
     wed_cnt number(10),
     thu_cnt number(10),
     fri_cnt number(10),
     sat_cnt number(10),
     unknown_cnt number(10));
select * from crime_day;

// unpivot : 컬럼 -> 행으로 변경
create or replace view unpivot_view
    as
    select *
    from crime_day
    unpivot(cnt for day_cnt in (sun_cnt, mon_cnt, tue_cnt, wed_cnt, thu_cnt,
                                fri_cnt, sat_cnt, unknown_cnt));
select * from unpivot_view;

select * 
    from (select day_cnt, cnt, rank() over(order by day_cnt desc)순위
            from unpivot_view
            where trim(crime_day) = '절도')
    where 순위 = 1;
            // 값에 공백이 포함되있는 경우가 많아 trim 함수로 공백을 제거해줌.
            
// 문제 129-1. 방화사건이 가장 많이 발생하는 요일은 언제인가요?
select * 
    from (select day_cnt, cnt, rank() over(order by day_cnt desc)순위
            from unpivot_view
            where trim(crime_day) = '방화')
    where 순위 = 1;
    
// 문제 129-2. 살인이 가장 많이 발생하는 요일은 언제인가요?
select * 
    from (select day_cnt, cnt, rank() over(order by day_cnt desc)순위
            from unpivot_view
            where trim(crime_day) = '살인')
    where 순위 = 1;
    

--------------------------------------------------------------------------------------------
// 사용 데이터 : 한국장학재단_대학별_평균등록금.csv
// => 공공 데이터 포털
// 예제 130. 우리나라에서 등록금이 가장 비싼 대학교는 어디인가요?
create table university_fee
    (division  varchar2(20),
     type  varchar2(20),
     university  varchar2(60),
     loc  varchar2(40),
     admission_cnt  number(20),
     admission_fee  number(20,2),
     tuition_fee  number(20,2));
     
select * from university_fee;

select *
    from (
            select university, tuition_fee,
                   rank() over(order by tuition_fee desc nulls last) as rank
                from university_fee)
    where rank = 1;

// 문제 130. 우리나라에서 대학 입학정원이 가장 많은 대학교는 어디인가요?
select * from university_fee;

select *
    from (
            select university, admission_cnt,
                   rank() over(order by admission_cnt desc nulls last) as rank
                from university_fee)
    where rank = 1;