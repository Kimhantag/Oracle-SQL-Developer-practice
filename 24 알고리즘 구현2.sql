--------------------------------------------------------------------------------------------
// 24 �˰��� ����2


--------------------------------------------------------------------------------------------
// ���� 115. sql�� ������ ����ϱ�.
select lpad(' ', 5-level, ' ') || lpad('��', level, '��') as star
    from dual
    connect by level < 6
union all
select lpad(' ', level, ' ') || lpad('��', 5-level, '��') as star
    from dual 
    connect by level < 6;
    
// ���ϴ� ���ڷ� �ٲ㼭 ����ϱ�
undefine p_num
accept p_num prompt '�����Է� : '

select lpad(' ', &p_num-level, ' ') || lpad('��', level, '��') as star
    from dual
    connect by level < &p_num
union all
select lpad(' ', level, ' ') || lpad('��', &p_num-level, '��') as star
    from dual 
    connect by level < &p_num;
    
// ���� 115. sql�� �𷡽ð� ����ϱ�.
undefine p_num
accept p_num prompt '�����Է� : '

select lpad(' ', level, ' ') || lpad('��', &p_num-level, '��') as star
    from dual 
    connect by level < &p_num
union all
select lpad(' ', &p_num-level, ' ') || lpad('��', level, '��') as star
    from dual
    connect by level < &p_num;


--------------------------------------------------------------------------------------------
// ���� 116. sql�� �簢�� ����ϱ�.
undefine p_n1
undefine p_n2
accept p_n1 prompt '���μ��ڸ� �Է��ϼ��� : ' ;
accept p_n2 prompt '���μ��ڸ� �Է��ϼ��� : ' ;

with loop_table as (select level as num
                     from dual
                     connect by level <= &p_n2)
select lpad('��', &p_n1, '��') as star
    from loop_table;
    
// ���� 116-1. ���ڸ� �ѹ��� ������ϰ�, ���簢���� ��µǰ� �ϼ���.
undefine length
accept length prompt '���̸� �Է��ϼ���: ';

with loop_table as (select level as num
                     from dual
                     connect by level <= &length)
select lpad('��', &&length, '��') as star
    from loop_table;
    // &&: ���� undefine���� ���� �ѹ��� ������� ��.
    

--------------------------------------------------------------------------------------------
// ���� 117. 1���� 10���� �� ����ϱ�
undefine hap
accept hap prompt '���ڸ� �Է��ϼ��� : ';

select sum(level)
    from dual
    connect by level <= &hap;
    
// ���� 117-1. 1���� 100������ ���� �߿��� ¦���� ���� ���ϼ���.
undefine hap
accept hap prompt '���ڸ� �Է��ϼ��� : ';

select sum(level)
    from dual
    where mod(level, 2) = 0
    connect by level <= &hap;

// ���� 117-2. 1���� 100������ ���� �߿��� Ȧ���� ���� ���ϼ���.
undefine hap
accept hap prompt '���ڸ� �Է��ϼ��� : ';

select sum(level)
    from dual
    where mod(level, 2) = 1
    connect by level <= &hap;
    
    
--------------------------------------------------------------------------------------------
// ���� 118. 1���� 10���� �� ����ϱ�
undefine gop
accept gop prompt '���ڸ� �Է��ϼ���: '

select round(exp(sum(ln(level)))) ��
    from dual
    connect by level <= &gop;
    
// ���� 118. 1���� 100������ ¦���� ���� ���ϼ���.
undefine gop
accept gop prompt '���ڸ� �Է��ϼ���: '

select round(exp(sum(ln(level)))) ��
    from dual
    where mod(level, 2) = 0
    connect by level <= &gop;
    

--------------------------------------------------------------------------------------------
// ���� 119. 1���� 10���� ���η� ¦���� ����ϼ���.
define num
accept num prompt '���ڸ� �Է��ϼ���: '

select listagg(level, ', ') as ����
    from dual
    where mod(level, 2) = 0
    connect by level <= &num;
    // within group�� ��Ȳ�� ���� ���� �ʾƵ� ��.
    
// ���� 119. 1���� 10���� ���η� Ȧ���� ����ϼ���.
define num
accept num prompt '���ڸ� �Է��ϼ���: '

select listagg(level, ', ') as ����
    from dual
    where mod(level, 2) = 1
    connect by level <= &num;
    // within group�� ��Ȳ�� ���� ���� �ʾƵ� ��.
    

--------------------------------------------------------------------------------------------
// ���� 120. 1���� 10���� �Ҽ��� ���.
with loop_table as (select level as num
                     from dual
                     connect by level <= 10)
select L1.num as �Ҽ�1
    from loop_table L1, loop_table L2
    where mod(L1.num, L2.num) = 0
    group by L1.num
    having count(L1.num) = 2;
    
// ���� 120-1. 1���� 10���� �Ҽ��� ���� ���ϼ���.
select sum(�Ҽ�)
    from(
    with loop_table as (select level as num
                         from dual
                         connect by level <= 10)
    select L1.num as �Ҽ�
        from loop_table L1, loop_table L2
        where mod(L1.num, L2.num) = 0
        group by L1.num
        having count(L1.num) = 2);

// ���� 120-2. 1���� 10���� �Ҽ��� ���� ���ϼ���.

select round(exp(sum(ln(�Ҽ�)))) ��
    from(
    with loop_table as (select level as num
                         from dual
                         connect by level <= 10)
    select L1.num as �Ҽ�
        from loop_table L1, loop_table L2
        where mod(L1.num, L2.num) = 0
        group by L1.num
        having count(L1.num) = 2);