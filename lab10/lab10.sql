/*
    contab          | hr                | vanzari 
    ----------------------------------------------
    plan conturi    | contracte         | incasari
    note contabile  | angajati          | stocuri
    balante         | functii           | clienti
    bilanturi       |                   | facturi
*/

-- conectati ca sys: create user contab identified by parola;

/*
    pentru a da acces altui user la o tabela care nu e a lui
    grant: insert, delete, select, update

    ex: (din hr) grant select, insert on angajati to contab;
        revoke insert on angajati from contab;


create user gica1 identified by parolaluigica;

 roluri de useri 
sys> create role operator_contab;

contab> grant select plan_conturi to operator_contab;
        grant select, insert, delete, update on note_contabile to operator_contab;

sys> grant operator_contab to giga1;


*/

/*
sa se creeze o tabela Ultimii_veniti care sa contina in fiecare departament ultimii veniti in firma
va avea coloanele 
nume angajat, den depart, data angajare, vechimea in ani



select a.ename nume_angajat, b.dname den_depart, a.hiredate data_angaj, round((sysdate - a.hiredate) / 365) vechime
    from emp a join dept b on a.deptno = b.deptno
where
    not exists (select c.hiredate
                from emp c
                where c.deptno = a.deptno and c.hiredate > a.hiredate);
*/


create table ultimii_veniti as 
(select a.ename nume_angajat, b.dname den_depart, a.hiredate data_angaj, round((sysdate - a.hiredate) / 365) vechime
    from emp a join dept b on a.deptno = b.deptno
where
    not exists (select c.hiredate
                from emp c
                where c.deptno = a.deptno and c.hiredate > a.hiredate));

select * from ultimii_veniti;

drop table ultimii_veniti;


/*

    sa se creeze o tabela care sa contina toate gradele salariale ale angajatilor care fac parte din depart
    angajatului fara niciun sef

*/
create table grade as (
select b.grade grad
from salgrade b join emp c on c.sal between b.losal and b.hisal
where c.deptno = 
    (select a.deptno 
    from emp a 
    where 
        a.mgr is null));

select * from grade;

drop table grade;

/*

    sa se creeze o tabela denumita ang_blake care sa contina toti ang departamentului
    sefului cu cei mai multi subordonati 
    structura tabela: nume angajat, den depart, an angajare, grad salarial, nr ani vechime
    vechimea e nr natural

*/


/*
    VIEW
*/

create or REPLACE view v_emp as
select empno, ename, hiredate, mgr, deptno
  from emp;


sys> grant select, insert, update, delete on v_emp to gica1;



/*
    alter
*/


alter table angajati 
--add (col10 number);
--modify (col9 number(7,2))
-- add constraint
-- drop constraint








