--------------------------------------------------------------------------------------------
// 26 ������ �м�


--------------------------------------------------------------------------------------------
// ��뵥���� : �����ϼ���_24���� �Ϲ߻���_2018�� 12��.csv
// => ���������� ����
// ���� 126. �츮���� ���ڵ��� ���� ���� �ɸ��� ���� ���ϼ���.(1999�� ����)
select * 
    from cancer
    where �� = '����' and �߻��ڼ� is not null
                     and ���� != '����'
                     and �߻����� = '1999'
    order by �߻��ڼ� desc fetch first 4 rows only; 

// ���� 126. �츮���� ���ڵ��� ���� ���� �ɸ��� ���� ���ϼ���.(1999�� ����)
select * 
    from cancer
    where �� = '����' and �߻��ڼ� is not null
                     and ���� != '����'
                     and �߻����� = '1999'
    order by �߻��ڼ� desc fetch first 4 rows only; 
    

--------------------------------------------------------------------------------------------
// ��� ������ : jobs.txt
// ���� 127. ��Ƽ�� �⽺ ���������� ���� ���� ������ �ܾ��?
select * from speech;

// ������ �ƴ� ���� 1���� �����ؼ� 2��° �ִ� ���� ����ض�
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
// ��� ������ : jobs.txt
// ���� 128. ��Ƽ�� �⽺ ���������� �����ܾ ���� ���ñ� ���� �ܾ ���� ���ñ�?
create table positive ( p_text varchar2(2000));
create table negative ( n_text varchar2(2000));
// �ܾ� �ϳ��� ũ�⸦ �ִ� 2000byte�� ����
select * from speech;
select count(*) from positive;
select count(*) from negative;

alter table speech
    rename column ��1 to speech_text;
    // alter table ���̺�� rename column ���� �÷��̸� to ���ο� �÷��̸�

// �� �����ϱ� 
create or replace view speech_view
as
select regexp_substr(lower(speech_text), '[^ ]+', 1, a) word
    from speech, (select level a
                    from dual
                    connect by level <= 52);
select * from speech_view;
select * from positive;

select count(word) as �����ܾ�
    from speech_view
    where lower(word) in (select lower(p_text)
                            from positive);

// ���� 128. ��Ƽ�� �⽺ ���������� �����ܾ �� ���̳� ���ñ�?
select count(word) as �����ܾ�
    from speech_view
    where lower(word) in (select lower(n_text)
                            from positive);
                            

--------------------------------------------------------------------------------------------
// ��� ������ : 2009�� ���˹߻� ���� ��Ȳ.csv
// => ���� ������ ����
// ���� 129. ������ ���� ���� �߻��ϴ� ������ �����ΰ���?

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

// unpivot : �÷� -> ������ ����
create or replace view unpivot_view
    as
    select *
    from crime_day
    unpivot(cnt for day_cnt in (sun_cnt, mon_cnt, tue_cnt, wed_cnt, thu_cnt,
                                fri_cnt, sat_cnt, unknown_cnt));
select * from unpivot_view;

select * 
    from (select day_cnt, cnt, rank() over(order by day_cnt desc)����
            from unpivot_view
            where trim(crime_day) = '����')
    where ���� = 1;
            // ���� ������ ���Ե��ִ� ��찡 ���� trim �Լ��� ������ ��������.
            
// ���� 129-1. ��ȭ����� ���� ���� �߻��ϴ� ������ �����ΰ���?
select * 
    from (select day_cnt, cnt, rank() over(order by day_cnt desc)����
            from unpivot_view
            where trim(crime_day) = '��ȭ')
    where ���� = 1;
    
// ���� 129-2. ������ ���� ���� �߻��ϴ� ������ �����ΰ���?
select * 
    from (select day_cnt, cnt, rank() over(order by day_cnt desc)����
            from unpivot_view
            where trim(crime_day) = '����')
    where ���� = 1;
    

--------------------------------------------------------------------------------------------
// ��� ������ : �ѱ��������_���к�_��յ�ϱ�.csv
// => ���� ������ ����
// ���� 130. �츮���󿡼� ��ϱ��� ���� ��� ���б��� ����ΰ���?
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

// ���� 130. �츮���󿡼� ���� ���������� ���� ���� ���б��� ����ΰ���?
select * from university_fee;

select *
    from (
            select university, admission_cnt,
                   rank() over(order by admission_cnt desc nulls last) as rank
                from university_fee)
    where rank = 1;