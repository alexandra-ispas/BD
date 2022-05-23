-- slectati toti angajatii care au ca sef un id citit de la tastatura
-- care s-au angajat dupa o data citia de la tastatura si care au litera o in interiorul numelui
--afiseaza numele, mgr, data angajatrii si salariul
--sortate crescator dupa nume si salariu
-- in 3 feluri: 

accept sef number prompt 'introduceti seful:'
accept data char prompt 'intorduceti data:'

select ename, mgr, hiredate, sal
from emp
    where
        mgr = &&sef
        and
        hiredate >= to_date('&data', 'DD-MM-YYYY')
        and
        ename like '%O%'
    order by ename, sal;

accept data1 char prompt 'intorduceti data:'
select ename, mgr, hiredate, sal
from emp
    where
        mgr = &sef
        and
        to_char(hiredate, 'yyyymmdd') >= '&data1'
        and
        ename like '%O%'
    order by ename, sal;

accept data2 char prompt 'intorduceti data:'
create table rezultat as
select ename, mgr, hiredate, sal
from emp
    where
        mgr = &sef
        and
        hiredate >= to_date('&data2', 'DD-MM-YYYY')
        and
        ename like '%O%'
    order by ename, sal;

select * from rezultat;
desc rezultat;
drop table rezultat;