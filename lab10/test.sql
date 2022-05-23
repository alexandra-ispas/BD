/*

    sa se creeze o tab numita prost_platiti
    cu toti angajatii din fiecare depart care au cele mai mici venitiru
    si nu s-au angajat intr-o luna de iarna (12, 1, 2)

    numele angajatului, den depart, venit, luna angajarii

*/
create table prosti_platiti as 
(select a.ename nume, b.dname dept, a.sal + nvl(a.comm, 0) venit, extract(month from a.hiredate) luna 
  from emp a join dept b on a.deptno = b.deptno
where 
    extract(month from a.hiredate) not in (12, 1, 2) and
    a.sal + nvl(a.comm, 0) = (select min(c.sal + nvl(c.comm, 0))
                                from emp c
                                where c.deptno = a.deptno and
                                extract(month from c.hiredate) not in (12, 1, 2)));

select * from prosti_platiti;
drop table prosti_platiti;