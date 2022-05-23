--subcereri pe clauza select

/* sa se selecteze pt fiacera angajat care nu are
gradul salarial al lui allen numele, gradul salarial si salariul mediu din departamentul sau

cand fol o subcerere in select, ea trebuie sa intoarca o sg valoare (o inregistrare si o coloana)


*/

select a.ename, b.grade, (select avg(c.sal) from emp c where c.deptno = a.deptno) medie
from emp a join salgrade b 
    on a.sal between b.losal and b.hisal
WHERE
    b.grade != (select d.grade 
                from emp allen join salgrade d on allen.sal between d.losal and d.hisal
                where allen.ename like 'ALLEN'); 


/* pe from */
select a.ename, b.grade, avgs.medie
from emp a join salgrade b 
    on a.sal between b.losal and b.hisal,
    (select c.deptno, avg(c.sal) medie 
    from emp c
    group by c.deptno) avgs
WHERE
    b.grade != (select d.grade 
                from emp allen join salgrade d on allen.sal between d.losal and d.hisal
                where allen.ename like 'ALLEN')
    and avgs.deptno = a.deptno;


/* subcereri in having 

sa se selecteze dept cu cei mai putini angajati
numele depart, numarul acestora
*/

select a.dname, count(b.empno)
from emp b join dept a on b.deptno = a.deptno
group by a.dname
having count(b.empno) = (select min(count(c.empno)) from emp c group by c.deptno);




/*

care este gradul salarial in care cei mai multi angajati si au incadrat salariul

gradul, numarul de angajati incadrati in el

*/

select b.grade, count(a.empno) nr_angajati
from emp a join salgrade b on a.sal between b.losal and b.hisal
group by b.grade
having count(a.empno) = (select max(count(*)) 
                    from emp c join salgrade d on c.sal between d.losal and d.hisal
                        group by d.grade);

/* sa se afiseza care este dept in care s-au angajat cei mai multi salariati in acelasi an
den depart, anul, nr de ang veniti in aceel an

*/
select a.dname, to_char(b.hiredate, 'yyyy') an, count(b.empno)
from dept a join emp b on a.deptno = b.deptno
group by a.dname, to_char(b.hiredate, 'yyyy')
having count(b.empno) = (select max(count(c.empno))
                        from emp c
                        group by c.deptno, to_char(c.hiredate, 'yyyy'));


/*

subcereri pe order by

toti angajatii din dept cel mai numeros primii, ordinea asta...

*/

select a.ename, a.deptno
from emp a
order by (select count(*)
            from emp b
            where b.deptno = a.deptno) desc;



/*
some
any 
exists
not exists
*/

/*

    select pt fiecare angajat care are cel mai mare salariu din dept sau
    numele, sal, den depart
*/

select a.ename, a.sal, b.dname
from emp a join dept b on a.deptno = b.deptno
where not exists (select c.empno from emp c where c.sal > a.sal and a.deptno = c.deptno);











