/*
pt fiecrae angajat din SALES care castiga mai mult decat MARTIN
numele, den depart si salariu
*/

/**
fara order by in subcerere
mai mult subcereri..

end;*/

/* subcerere necorelata, nu are leg cu ce e sus */

select a.ename, b.dname, a.sal 
from
    emp a join dept b on a.deptno = b.deptno
WHERE
    b.dname like 'SALES' and
    a.sal + nvl (a.comm, 0) > (select sal + nvl(comm, 0) 
                                from emp 
                                where ename like 'MARTIN');



/*
sa se afiseze toti angajatii din dept angajatului cu salariul cel mai mare
*/

select a.ename, a.sal 
from emp a 
where a.deptno = (select deptno 
                    from emp 
                    where sal = (select max (sal) from emp));




/*
toti angajatii care fac parte din dept lui KING sau al lui BLAKE
*/

select a.ename, b.dname
from
    emp a join dept b on a.deptno = b.deptno
    WHERE
        a.deptno in (select deptno
                        from emp 
                        where ename in ('KING', 'BLAKE'));


/*
sa se afiseze pt fiecare angajat care castiga mai mult decat ALLEN 
numele venitul angajatului
*/

select a.ename, a.sal + nvl (a.comm, 0) venitul
from emp a
WHERE
    a.sal + nvl(a.comm, 0) > (select sal + nvl(comm, 0) from emp where ename like 'ALLEN');

/*
toti angajatii care castiga mai mult decat media salariilor din departamentul lor
*/
select a.ename, a.sal
from emp a
WHERE
    a.sal > (select avg (b.sal) from emp b where a.deptno = b.deptno);


/*
pt fiecare angajat ce are un venit mai mare decat seful sau 
si nu face parte din gradul lui ALLEN sa se afiseze numele, gr salarial si venitul
*/
select a.ename, b.grade, a.sal+nvl(a.comm, 0) venit
from emp a join salgrade b on a.sal between b.losal and b.hisal
WHERE
    b.grade != (select c.grade 
                from emp al join salgrade c on al.sal between c.losal and c.hisal
                where al.ename like 'ALLEN') and
    a.sal + nvl(a.comm, 0) > (select d.sal + nvl (d.comm, 0)
                                from emp d
                                WHERE
                                    d.empno = a.mgr);

/*
angajatul cu salariu maxim
*/
select ename, sal
from emp
where
    sal = (select max(sal) from emp);

select ename, sal
from emp
where
    sal = (select max(sal) 
            from emp 
            where sal != (select max(sal) from emp));


select a.ename, a.sal 
from
    emp a
    WHERE   
        4 > (select count(distinct b.sal)
            from emp b
            where b.sal > a.sal);


/*
    from se extinde numai cu subcereri necorelate
    -> tabele temporale
*/

/**
pt fiecare angajat ce a venit in firma dupa seful lui aQWa+
numele, data angajarii, valoarea medie a salariilor din firma
*/
select a.ename, a.hiredate, avg_s.medie
from emp a, (select avg(sal) medie from emp) avg_s
where
    a.hiredate > (select b.hiredate 
                    from emp b
                    where
                        b.empno = a.mgr); 


/*
pt fiecare angajat ce castiga mai mult decat BLAKE 
numele, salariul, sal lui blake, diferenta sal sau - sal _blake si denumirea dept lui blake*/
select a.ename, a.sal, blake.sal, a.sal-blake.sal dif, blake.dname
from emp a, (select b.sal, c.dname, b.comm
            from emp b join dept c on b.deptno = c.deptno
            where b.ename like 'BLAKE') blake
where a.sal + nvl(a.comm, 0) > blake.sal + nvl(blake.comm, 0);