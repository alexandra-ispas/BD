-- /*Sa se faca o lista toti angajatii care primesc o prima de 10% din salariu. Prima primesc numai
-- angajatii care nu au primit comision si au venit in companie in primele 6 luni ale anului in care
-- s-a angajat presedintele companiei.
-- Antetul listei este:
-- Nume_Presedinte, Data_ang_pres, Nume_ang, Data_ang, Salariu_ang, Comision, Prima*/

-- select pres.ename, pres.hiredate, a.ename, a.hiredate, a.sal, nvl(a.comm, 0) comision, 0.1 * a.sal prima
-- from emp a, emp pres
-- where nvl(pres.mgr, 0) = 0 and
--     nvl(a.comm, 0) = 0 and
--     extract(year from pres.hiredate) = extract(year from a.hiredate) and
--     extract(month from a.hiredate) in (1, 2, 3, 4, 5, 6);


-- -- select next_day(hiredate, 'MONDAY') from emp;

-- /*
-- afisati pt angajatii care fac parte din departamentul cu cei mai multi angajati cu acelasi grad salarial
-- a. numele angajatului cu prima litera mare si restul mici
-- b.anul angajarii cu 2 cifre, carcaterul * si luna angajarii in format text an_luna_ang
-- c.numele depart cu litere mici

-- */

-- select substr(a.ename,0, 1) || lower(substr(a.ename, 2, length(ename))) nume_angajat, 
--         to_char(a.hiredate, 'YY') || '*' || to_char(a.hiredate, 'MM') an_luna_ang,
--         lower(d.dname) dept
-- from emp a join dept d on a.deptno = d.deptno,
--     (select count(*) nr, deptno
--         from emp natural join dept, salgrade
--         where sal between losal and hisal and rownum <= 2
--         group by deptno, grade
--         order by 1 desc
--     ) acelasi_grad
-- where a.deptno = acelasi_grad.deptno;

-- -- select to_char(hiredate, 'yy*MON') from emp;


-- /*
-- 1.Sa se scrie o cerere SQL care face o lista de premiere a angajatilor aplicand urmatoarele
-- criterii:
--     a) Angajatii care au primit comision primesc o prima egala cu salariul mediu pe companie;
--     b) Angajatii care nu au primit comision primesc o prima egala cu salariul minim pe
--     companie;
--     c) Presedintele si directorii nu primesc prima.
-- Antetul listei este urmatorul:
-- Den_part, Nume_ang, Job, Comision, Salariu_min_com, Sal_mediu_com, Prima
-- Obs. Salariile si prima se afiseaza fara zecimale.

-- */

-- select d.dname den_dep, a.ename nume_ang, a.job job, nvl(a.comm, 0) comision, 
--     (select round(min(sal)) from emp) sal_min_com, 
--     (select round(avg(sal)) from emp) sal_mediu_com,
--     case 
--         when nvl(a.comm, 0) != 0 then (select round(avg(sal)) from emp)
--         when nvl(a.comm, 0) = 0 then (select round(min(sal)) from emp)
--         when a.job in ('MANAGER', 'PRESIDENT') then 0
--     end prima
--     from emp a join dept d on a.deptno = d.deptno;

-- /*
-- Sa se faca o lista cu numarul de subalterni care nu au functia 'MANAGER' si media
-- veniturilor acestora (al subalternitor) grupate dupa numele functiei si numele sefului
-- lor.
-- Sa se afiseze doar liniile unde numarul de sublaterni este mai mare sau egala cu 2.
-- Lista are urmatorul antet
-- - Nume sef,
-- - Numele functiei subalternilor
-- - Numar subalterni care nu au functia 'MANAGER'
-- - Media veniturilot sublaternilor care nu au functia 'MANAGER'
-- Ordonati descrescator dupa numele sefului.
-- */

-- select sef.ename nume_sef, 
--         a.job functie_subaltern, 
--         count(a.empno) nr_subalterni, 
--         avg(a.sal + nvl(a.comm, 0))
-- from emp a join emp sef on a.mgr = sef.empno and a.job not like 'MANAGER'
-- having count(a.empno) >= 2
-- group by sef.ename, a.job
-- order by sef.ename desc;

-- /*
-- Pentru angajatii din departamentul 'RESEARCH' afisati:
-- - primele 3 caractere din functie, daca s-au angajat in anul 1981,
-- - ultimele 3 caractere din functie, daca s-au angajat in anul 1982, respectiv
-- - numele intreg al functiei, in celelalte cazuri.
-- Ordonati dupa coloana care afisaza functia astfel calculata.
-- Antetul listei va fi urmatorul:
-- Nume_ang, Nume_dept, Sir_functie_ang.
-- */

-- select a.ename nume_angajat, d.dname nume_dept, 
--     case 
--       when extract(year from a.hiredate) = 1981 then substr(a.job, 0, 3)
--       when extract(year from a.hiredate) = 1982 then substr(a.job, length(a.job) - 2, 3)
--       else a.job
--     end Sir_functie_ang
-- from emp a join dept d on a.deptno = d.deptno
-- order by 3;

-- /*
-- 1.Sa se calculeze, pentru fiecare angajat ce are, in departamentul sau, cel putin doi angajati cu
-- un salariu mai mic decat el si care a venit in firma dupa seful sau direct: vechimea in ani
-- (valoare intreaga), gradul salarial si diferenta dintre salariul sefului sau si salariul sau.
-- Antetul listei de afisat trebuie sa fie :
-- Nume angajat, Denumire departament, Ani vechime, Grad, Diferenta salariu sef
-- */

-- select a.ename nume_angajat,
--         d.dname den_depart,
--         extract(year from sysdate) - extract(year from a.hiredate) vechime,
--         sal.grade grad,
--         sef.sal - a.sal diferenta
-- from emp a join emp sef on a.mgr = sef.empno,
--     dept d, salgrade sal
-- where d.deptno = a.deptno and
--         a.sal between sal.losal and sal.hisal and
--         (select count(*) 
--         from emp 
--         where sal < a.sal and deptno = a.deptno) >= 2 and
--     a.hiredate >= sef.hiredate
-- group by d.dname, a.sal, a.ename, a.hiredate, sal.grade, sef.sal;


-- /*
--     Sa se scrie o cerere SQL care face o lista cu sefii de departament care primesc un
--     bonus la salariu aplicand urmatoarele criterii:
--     - sefii care au primit comision, primesc ca prima salariul mediu pe departamentul din care fac
--     parte;
--     - sefii care nu au primit comision primesc ca prima salariul minim pe departamentul din care
--     fac parte.
--     Antetul listei este urmatorul:
--     Den_depart, Nume_ang, Comision, Sal_min_dep, Sal_mediu_dep, Prima
--     Salariul mediu pe departament se afiseaza fara zecimale.
-- */
-- select d.dname den_dept,
--         a.ename nume_ang,
--         nvl(a.comm, 0) comision,
--         (select min(sal) from emp where deptno = d.deptno) sal_min_dept,
--         (select avg(sal) from emp where deptno = d.deptno) sal_min_dept,
--         case 
--           when nvl(a.comm, 0) != 0 then (select avg(sal) from emp where deptno = d.deptno) 
--           else (select min(sal) from emp where deptno = d.deptno) 
--         end prima
-- from emp a join dept d on a.deptno = d.deptno
-- where a.job in ('MANAGER', 'PRESIDENT');

-- /*
-- 3. Sa se acorde o bonificatie tuturor angajatilor care au salariul mai mare decit salariul
-- mediu in departamentul in care lucreaza presedintele. Bonificatia reprezinta 25% din
-- diferenta intre salariul angajatului si salariul mediu pe companie, rotunjita la doua
-- zecimale.
-- Lista are antetul nume, functie, salariu, bonificatie si va fi ordonata crescator dupa
-- salariu si nume.
-- */
-- select a.ename, a.job, a.sal, round(0.25 * (a.sal - (select avg(sal) from emp)), 2) bonificatie
-- from emp a 
-- where a.sal > (select avg(sal) 
--                     from emp
--                     where deptno = (select x.deptno
--                                     from emp x
--                                     where x.job = 'PRESIDENT'));


create table prima as
select a.ename nume_ang,
        a.job functie,
        nvl(a.comm, 0) comision,
        d.dname den_dept,
        a.hiredate data_angajarii,
        ROUND((sysdate - a.hiredate) / 365) ani_vechime,
        case 
          when nvl(a.comm, 0) = 0 and a.job not like 'MANAGER' then round((select max(sal) 
                                                                    from emp
                                                                    where deptno = a.deptno), 2) || '$'
           when nvl(a.comm, 0) = 0 and a.job like 'MANAGER' then round((select min(sal) 
                                                                    from emp
                                                                    where deptno = a.deptno), 2) || '$'                         
          else round((select avg(sal) 
                from emp
                where deptno = a.deptno), 2) || '$'
        end prima
    from emp a join dept d on a.deptno = d.deptno
    where ROUND((sysdate - a.hiredate) / 365) >= &n 
    group by d.dname, a.ename, a.job, a.comm, a.hiredate, a.deptno
    having count(*) <= 3
    order by a.hiredate;


select * from prima;

drop table prima;


-- select
--     a.ename nume_ang,
--     a.job,
--     a.comm,
--     d.dname, 
--     a.hiredate,
--     ROUND((sysdate - a.hiredate) / 365) an_vechime,
--     concat(cast(CASE
--         WHEN nvl(a.comm,0)=0 AND upper(a.job) != 'MANAGER' THEN 
--                        ROUND((SELECT max(sal)
--                         FROM emp 
--                         WHERE deptno = a.deptno), 2)
--         WHEN nvl(a.comm,0)=0 AND lower(a.job) = 'manager' THEN
--                         ROUND((SELECT min(sal) 
--                         FROM emp
--                         WHERE deptno = a.deptno), 2)
--         ELSE ROUND((SELECT avg(sal)
--                 FROM emp 
--                 WHERE deptno = a.deptno), 2)
--     END as varchar(10)), '$') prima
-- from emp a join dept d on a.deptno = d.deptno
-- where 
--     months_between(sysdate, a.hiredate) > &v * 12 AND
--     3 > (select count(*)
--                 from emp b join dept d on b.deptno = d.deptno
--                 where
--                     b.hiredate < a.hiredate and
--                     a.deptno = b.deptno)
--     order by 4 asc, 5 asc;
