create table depart 
(
cod_depart number(2) primary key,
den_depart varchar2(20),
nr_angajati number(2)
);

desc depart

create table angajati
(
cod_depart number(2),
cod_angajat number(3),
nume varchar2(20),
prenume varchar2(20),
nume_sef varchar2(20),
salariu number(7,2),
localitate varchar2(20),
constraint pk_angajati primary key (cod_depart, cod_angajat),
constraint fk_angajat_depart foreign key (cod_depart) references depart (cod_depart)  
);

desc angajati

insert into depart(cod_depart, den_depart, nr_angajati)
values(1,'IT',3);
insert into depart(cod_depart, den_depart, nr_angajati)
values(2,'HR',3);

insert into angajati(cod_depart, cod_angajat, nume, prenume, nume_sef, salariu, localitate)
values(1, 1, 'Popescu', 'Tudor', 'Ionescu', 2000, 'Cluj');
insert into angajati(cod_depart, cod_angajat, nume, prenume, nume_sef, salariu, localitate)
values(1, 2, 'Constantinescu', 'Costel', 'Florescu', 3000, 'Constanta');
insert into angajati(cod_depart, cod_angajat, nume, prenume, nume_sef, salariu, localitate)
values(1, 3, 'Alexandrescu', 'Cristina', 'Ionescu', 3000, 'Bucuresti');

insert into angajati(cod_depart, cod_angajat, nume, prenume, nume_sef, salariu, localitate)
values(2, 1, 'Popescu', 'Florin', 'Ionescu', 2000, 'Sibiu');
insert into angajati(cod_depart, cod_angajat, nume, prenume, nume_sef, salariu, localitate)
values(2, 2, 'Constantinescu', 'Andreea', 'Florescu', 3000, 'Cluj');
insert into angajati(cod_depart, cod_angajat, nume, prenume, nume_sef, salariu, localitate)
values(2, 3, 'Alexandrescu', 'Cristi', 'Florescu', 4000, 'Suceava');

--afiseaza coloanele nume, prenume, salariu, din tabelul angajati, care au cod_depart = 1 si -- salariu > 1000, ordonati descrescator dupa salariu, si apoi dupa nume

--select nume, prenume, salariu
--from angajati
--where 
--	cod_depart = 1
--	and
--	salariu > 1000
--order by salariu desc, nume;

--afiseaza o coloana cu 1, numita 1

--select 1
--from angajati;

--select 'Angajatul ' || nume || ' castiga ' || salariu
--from angajati;

--&cod - introducere de la tastatura valoare
--&&cod - tine minte valoare

--select nume, prenume, salariu
--from angajati
--where 
--	cod_depart = &&cod
--	and
--	salariu > &sal
--order by salariu desc, nume;

--select nume, prenume, salariu
--from angajati
--where 
--	cod_depart = &cod
--	and
--	salariu > 1000
--order by salariu desc, nume;

--sa se afiseze, pentru fiecare angajat care nu il are ca sef pe Ionescu si care castiga un salariu 
--mai mare decat o valoare citita de la tastatura si lucreaza intr un departament cu codul citit de 
--la tastatura, nume prenume salariu
--variabile simple (&), (&&), accept

--1
select nume, prenume, salariu
from angajati
where 
	nume_sef != 'Ionescu'
	and
	cod_depart = &cod
	and
	salariu > &sal
order by salariu desc, nume;

--2
select nume, prenume, salariu
from angajati
where 
	nume_sef != 'Ionescu'
	and
	cod_depart = &&cod
	and
	salariu > &&sal
order by salariu desc, nume;

select nume, prenume, salariu
from angajati
where 
	nume_sef != 'Ionescu'
	and
	cod_depart = &cod
	and
	salariu > &sal
order by salariu desc, nume;

--3
accept cod number prompt 'introduceti cod departament:'
accept sal number prompt 'introduceti salariu minim:'

select nume, prenume, salariu
from angajati
where 
	nume_sef != 'Ionescu'
	and
	cod_depart = &cod
	and
	salariu > &sal
order by salariu desc, nume;
 	
undefine cod
undefine sal

drop table angajati;
drop table depart;