-- create table departamente
-- (
--     id_departament number(2) not null,
--     denumire_departament varchar2(30),
--     telefon varchar2(10),
--     constraint pk_id_dep primary key (id_departament)
-- );

-- create table grila_salariu
-- (
--     grad number(2),
--     nivel_inferior number,
--     nivel_superior number
-- );

-- create table angajati
-- (
--     id_angajat number(4) not null,
--     nume varchar2(30),
--     prenume varchar2(30),
--     functie varchar2(20),
--     -- id_sef number(4),
--     data_angajarii date default sysdate,
--     salariu number(7, 2) default 2000,
--     comision number(7,2),
--     id_dep number
--     -- constraint pk_num_prenum primary key (nume, prenume),
--     -- constraint fk_ang_dep foreign key (id_dep) references departamente(id_departament)
-- );

-- desc departamente;
-- desc angajati;

-- insert into grila_salariu values(1, 1, 1000);
-- insert into grila_salariu values(1, 1001, 2000);

-- insert into departamente values(10, 'Proiectare Software', '3212121');
-- insert into departamente values(20, 'Asigurarea Calitatii ', '3212122');
-- insert into departamente values(30, 'Proiectare Software', '3212124');

-- insert into angajati (id_angajat, nume, prenume, functie) values (1001, 'Ionescu', 'Ion', 'Director');
-- insert into angajati (id_angajat, nume, prenume, functie) values (1002, 'Ionescu', 'Ionel', 'Programator');
-- insert into angajati (id_angajat, nume, prenume, functie, id_sef, salariu) values (1003, 'Ionescu', 'Ionelus', 'Programator', 1024, 10);

-- select * from angajati;
-- update angajati set comision = 0.1 * salariu;
-- select * from angajati;

-- select * from angajati;

-- delete from angajati
--  where nume='Pop' and prenume='Alina';

-- delete from angajati
--  where data_angajarii < '01-JAN-1985';

-- delete from angajati
--     where comision is null;

--  Să se selecteze id_ang, nume, functie și salariu pentru
-- angajatii care au același sef. Id-ul șefului se va introduce de la
-- tastatură.

-- accept id number prompt 'intoduceti id-ul sefului: '

-- select empno, ename, job , sal
-- from emp
--     where mgr=&id;

-- select ename, '&job' job, sal -- ia toate intrarile si suprascrie valorile din coloana 'job'
-- from emp;                       -- cu ce am introdus eu
    -- where
    --     job = &functie;      -- functia e string, deci merge asa doar daca la tastatura scriu
                                -- intre apostrof

-- insert into angajati select * from emp;

-- select * from angajati;

-- select ename, job, &salariu_anual sal_anual  -- primeste o formula de calcul pt salariu anual
-- from &tabel
--     where
--         &col=&deptno;


-- select ename, job, &&venit_lun venit_lun
-- from emp
--     where &venit_lun > 2000;

-- select empno, job, hiredate
-- from emp
--     where
--         job='&1' and
--         hiredate > to_date('&2', 'DD-MM-YYYY');

-- accept dep number prompt "numarul departamentului este: " 

-- select ename
-- from emp
-- where 
--     deptno=&dep and
--     12*(sal + nvl(comm, 0) * sal) > &target;

-- undefine dep


-- drop table grila_salariu;
-- drop table angajati;
-- drop table departamente;



-- Sa se calculeze, pentru fiecare angajat din SALES, o prima de 200 pentru toti care au EMPNO par si de 300 pentru ceilalti
-- select a.ename, a.empno, decode(mod(a.empno, 2), 0, 200, 300) "prima salariu"
-- from emp a, dept b
-- where a.deptno = b.deptno and
--     b.dname = 'SALES';

-- Sa se selecteze toti angajatii ce primesc un comision si au gradul salarial > 1, afisand si un indicator 
-- cu privire la venitul lor (BUN, FOARTE BUN)
-- Daca venitul unui angajat este <=2500, atunci venitul este BUN. Daca venitul este > 2500, 
-- atunci venitul este FOARTE BUN
-- Lista va fi afisata sub forma:
-- ANGAJAT  COMISION  GRAD SALARIAL VENIT     CALIFICATIV VENIT

-- select a.ename, nvl(a.comm, 0) comision, b.grade, a.sal+nvl(a.comm, 0) venit, 
--     decode (sign(A.SAL+ NVL(A.COMM, 0)-2500), -1, 'BUN', 0, 'BUN', 'FOARTE BUN') CALIFICATIV
-- from emp a, salgrade b
-- where nvl(a.comm, 0) > 0 and
--     b.grade != 1 and
--     (a.sal between b.losal and b.hisal);

-- Sa se afiseze, pentru toti angajatii departamentului RESEARCH, o lista care sa contina o apreciere a vechimii angajatului. 
-- Aprecierea vechimii se va face astfel :
--	Daca au venit in firma inainte de 31 decembrie 1980, atunci vechime=’FOARTE VECHI’
--	Daca au venit in firma intre anii 1981 si 1986, atunci vechime=’VECHI’
--	Daca au venit in firma dupa 1986, atunci vechime=’RECENT’

-- select a.ename, case when extract(YEAR from a.hiredate) > 1986 then 'RECENT'
--                 when extract(YEAR from a.hiredate) between 1981 and 1986 then 'VECHI'
--                 else 'FOARTE VECHI' end "aproximare vechime"
-- from emp a, dept b
-- where a.deptno = b.deptno and
-- b.dname = 'RESEARCH';


-- select a.ename, case when a.job = 'MANAGER' then 0
--                     when a.job = 'PRESIDENT' then 0
--                     when nvl(a.comm, 0) = 0 then 100
--                     else 300 end "prima"
-- from emp a;

/*
create table R
(
    A varchar2(30),
    B varchar2(30),
    C varchar2(10)
);

insert into R values('a1', 'b3', 'c5');
insert into R values('a4', 'b2', 'c2');
insert into R values('a6', 'b3', 'c3');

create table S
(
    A varchar2(30),
    B varchar2(30),
    E varchar2(10)
);

insert into S values('a1', 'b3', 'e1');
insert into S values('a6', 'b3', 'e2');
insert into S values('a3', 'b2', 'e3');

select * from
R, S;

select * from
R r join S s on r.B = s.B; 

desc R;
desc S;

drop table R;
drop table S;*/



/* selectati numarul de angajati din fiecare departament */
-- select dname, count(*)
-- from emp a join dept d 
-- on a.deptno = d.deptno
-- group by dname;

-- -- dep cu cei mai multi angajati
-- select dname, count(*)
-- from emp a join dept b 
-- on a.deptno = b.deptno
-- group by dname
-- having count(*) = (select max(count(*))
--                     from emp
--                     group by deptno);



----- Exemplu subiect colocviu
--Sa se creeze o tabela denumita ANG_BLAKE care sa contina toti angajatii din departamentul sefului cu cei mai multi subordonati. Structura tabelei este urmatoarea :
--Nume_angajat, Den_departament, An_angajare, Venit, Ani_vechime
--Vechimea se va calcula ca si numar natural.
--Se va utiliza, pentru testare, baza de date formata din tabelele EMP, DEPT si SALGRADE.

select a.mgr
from emp a
group by a.mgr
having count(a.empno) = (select max(count(*))
            from emp c 
            group by c.mgr);

select b.ename Nume_angajat, dep.dname Den_departament,
    extract(year from b.hiredate) An_angajare, (b.sal + nvl(b.comm, 0)) venit,
    trunc((sysdate - b.hiredate) / 365) Ani_vechime
from emp b join dept dep on b.deptno = dep.deptno
where b.deptno = (
    select d.deptno
    from emp d
    where d.empno = (select a.mgr
        from emp a
        group by a.mgr
        having count(a.empno) = (select max(count(*))
                    from emp c 
                    group by c.mgr))
);
    

