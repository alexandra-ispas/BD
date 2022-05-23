--  @C:\Users\Alexandra\Desktop\3sem2\BD\lab6\lab6.sql

/*
select a.ename, b.dname 
from emp a, dept b
where   
    a.deptno(+)=b.deptno; -- pt ca in dept exista inregistrari care n au corespondent in emp


-- sau
select a.ename, b.dname
from emp a right outer join dept b  -- indic tabela mai bogata (dept ca are un dep in plus)
on a.deptno=b.deptno;
*/

--------------------------------------------------functii

/*
    ceil
    floor
    mod
    round: round(15.6)=16
            round(15.68, 1) = 15.7
            round(15.68, -1) = 20 ;; rotunjirea se face la zeci
    trunc: trunc(15.6) = 15 <=> floor
            trunc(15.68, 1) = 15.7
            trunc(15.68, -1) = 10
*/

/*
select ename, empno
from emp
where mod(empno,2)=0;


select round(15.68, -1) from dual;
*/

/*
    selectati nume, salariu, sal/3, val nr intregi din sal/3, rotunjita la sute din sal/3 si rot la sutimi
*/

-- define salariu = sal/3;

-- select ename, sal, sal/3 "sal impartiti la 3", trunc(sal/3) "nr intregi", round(sal/3, -2)
-- from emp;

/*
creati o lista in care sa fie calculata o prima pt ang care nu primesc comision,
nu au func de manager si s-au angajat inainte de 'ALLEN'

prima = 0.23 * (venitul_lunar rotunjit la intregi)

veti afisa: angajat, functia, comision, data angajarii, data angajarii lui ALLEN si prima

*/

/*
select a.ename, a.job, nvl(a.com, 0) com, a.hiredate, 
    b.hiredate, round(0.23 * (nvl(a.com, 0) + a.sal)) prima
    from emp a, emp b
    where b.ename = 'ALLEN' and          -- like
        a.hiredate < b.hiredate and  -- to char
        a.job not like 'MANAGER' and
        nvl(a.comm, 0)=0;  -- sau: comm is null or comm = 0

*/

/*
    length
    substr
    replace
    translate


*/

select replace('PRIMAVARA', 'RA', 'XY') from dual; -- inlocuieste tot subsirul RA cu XY


select translate('PRIMAVARA', 'RA', 'XY') from dual; -- orice R  e inlocuit cu X, orice A cu Y


-- stergere subsir

select replace('PRIMAVARA', 'RA', '') from dual;


/*

pt fiecare angajat sa se gaseasca nr de aparitii ale ultimelor 2 litere din nume in job-ul fiecaruia
in ordinea in care apar ele in ename
afisare: numele, job-ul , nr de aparitii
*/

select ename, job, 
    substr(ename, -2) "ultimele 2",
    replace(job, substr(ename, -2), '') "job scurt",
    (length(job) - length(replace(job, substr(ename, -2), ''))) / 2 "numar aparitii"
    from emp;


/*
    last_day(D)
    next_day(d, 'MONDAY') --urm zi de luni
 */

-- sysdate = data din sistem

select last_day(sysdate), next_day(sysdate, 'WEDNESDAY') from dual;

-- extract intoarce mereu un numar
select
    extract (day from sysdate) zi,
    extract (month from sysdate) luna,
    extract (year from sysdate) an from dual; 

/*
pot sa il fac sa intoarca char 
to_char(date, 'DD')

*/

/*
la fiecare angajat sa afisam un calificativ al venitului sau
*/

select ename, (sal+nvl(comm, 0))*12 "venit anual", 'foarte bun' calificativ
from emp
    where (sal + nvl(comm, 0)) * 12 > 20000
UNION
select ename, (sal+nvl(comm, 0))*12 "venit anual", 'bun' calificativ
from emp
    where (sal + nvl(comm, 0)) * 12 <= 20000
order by 1;
