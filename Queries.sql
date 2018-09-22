--zapytania
USE Kolonia_test
--1 ile turnusow jest obecnie zaplanowanych na sezon 2018(obecny sezon)
select COUNT(t.turnus_id) as liczbaTurnusow
from turnus as t
where right(turnus_id, 4) = YEAR(GETDATE())
--2 pokaz prowadzacego obozu, oraz turnus na jakim prowadzi³ oboz
select t.turnus_id, CONCAT(o2.imie, ' ', o2.nazwisko) as prowadzacyOboz
from turnus as t, oboz as o, kolonia as k, pracownik as p, osoba as o2
where o.id_kolonia = k.kolonia_id AND k.id_turnus = t.turnus_id AND o.id_prowadzacy = p.pracownik_id AND p.id_osoba = o2.osoba_id
order by t.data_rozpoczecia asc
--3 pokaz kierownikow turnusow i turnusy ktore prowadzili
select t.turnus_id, CONCAT(o.imie, ' ', o.nazwisko) as kierownikKolonii
from turnus as t, kolonia as k, pracownik as p, osoba as o
where k.id_turnus = t.turnus_id AND k.id_kierownikPracownik = p.pracownik_id AND p.id_osoba = o.osoba_id
order by t.data_rozpoczecia asc
--4 prowadzacy obozu ktory choc raz podczas wyplaty mial dodatek = 0
--	prowadzacy obozu, dla, dla ktorego nie istnieje transza dla ktorej nie istnieje parametr dodatek = 0 
select CONCAT(o2.imie, ' ', o2.nazwisko) as prowadzacy
from oboz as o, osoba as o2, pracownik as p2
where o2.osoba_id = p2.pracownik_id AND p2.pracownik_id = o.id_prowadzacy AND 
NOT EXISTS 
	(select * 
	 from pracownik as p
	 where p.pracownik_id = o.id_prowadzacy AND NOT EXISTS 
											(select *
											 from transza as t
											 where t.id_pracownik = p.pracownik_id AND t.dodatek = 0))
group by o2.imie, o2.nazwisko
--5 nazwy osrodkow w ktorych przeprowadzane byly/sa obozy o profilu sportowym
--	placowka dla ktorej istenieje kolonia, dla ktorej istnieja oboz/obozy o profilu sportowym
select p.nazwa_osrodka
from kolonia as k, placowka as p
where p.placowka_id = k.id_placowka AND 
EXISTS 
	(select * 
	from oboz as o 
	where k.kolonia_id = o.id_kolonia AND EXISTS 
									(select *
									from profil as p2
									where o.id_profil = p2.profil_id AND p2.profil_id = 2))
--
--6 prowadzacy pracujacy na turnusach 12 dniowych
--pracownik dla ktorego nie istnieje oboz, dla ktorego nie istnieje kolonia, dla ktorej nie istnieje turnus z parametrem ilosc_dni = 12
select p.pracownik_id
from pracownik as p, oboz as o
where p.pracownik_id = o.id_prowadzacy AND 
	NOT EXISTS
	(select *
	from kolonia as k
	where o.id_kolonia = k.kolonia_id AND NOT EXISTS
										(select *
										from turnus as t 
										where k.id_turnus = t.turnus_id AND  t.ilosc_dni = 12))
group by p.pracownik_id
--7 oblicz ilu pracownikow posiada podpisana umowe na obecny sezon
DECLARE kursor CURSOR FOR SELECT p.pracownik_id from pracownik AS p
DECLARE @x INT, @y INT;
OPEN kursor;
FETCH NEXT FROM kursor INTO @x;
SET @y = 0;

WHILE @@FETCH_STATUS = 0
	BEGIN
		IF (1 = (SELECT p.czyPosiadaUmoweNaObecnySezon FROM pracownik as p WHERE p.pracownik_id = @x))
		SET @y += 1;
		FETCH NEXT FROM kursor INTO @x
	END

PRINT @y;

CLOSE kursor;
DEALLOCATE kursor;
--8 pokaz ktory profil/profile poza kierowniczym jest najbardziej dochodowy, pokaz stawke
DECLARE kursor CURSOR FOR SELECT p.profil_id FROM profil as p WHERE p.nazwa != 'kierowniczy'
DECLARE @a INT, @b MONEY, @c INT;
OPEN kursor;
FETCH NEXT FROM kursor INTO @a;
SET @b = 0.0;

WHILE @@FETCH_STATUS = 0
	BEGIN
	SET @c = (SELECT profil.stawkaDniowaProwadzacego FROM profil WHERE profil.profil_id = @a)
		IF (@b < @c)
			SET @b = @c
		FETCH NEXT FROM kursor INTO @a
	END

SELECT profil.nazwa, profil.stawkaDniowaProwadzacego 
FROM profil 
WHERE profil.stawkaDniowaProwadzacego = @c

CLOSE kursor;
DEALLOCATE kursor;
--9 pokaz wszystkich uczestnikow, nazwe obozu w ktorym bral udzial, oraz id turnusu w ktorym odbywal sie oboz
select o2.imie + ' ' + o2.nazwisko as uczestnik, o.nazwa_obozu, k.id_turnus
from osoba as o2, (uczestnik as u JOIN oboz as o ON u.id_oboz = o.oboz_id) JOIN kolonia as k ON o.id_kolonia = k.kolonia_id
where o2.osoba_id = u.uczestnik_id
--10 pokaz uczestnikow ponizej 14 roku zycia, oraz ich wychowawcow i id_turnusu
select u.uczestnik_id, o2.oboz_id, p.pracownik_id, k.id_turnus
from osoba as o, ((uczestnik as u join oboz as o2 on u.id_oboz = o2.oboz_id) join pracownik as p on p.pracownik_id = o2.id_prowadzacy) join kolonia as k on k.kolonia_id = o2.id_kolonia
where o.osoba_id = u.id_osoba and YEAR(o.data_urodzenia) < YEAR(DATEADD(Year, -14, GETDATE()))
--11 ile przecietnie zarabiaja prowadzacy obozow
select AVG(p.stawkaDniowaProwadzacego)
from profil as p
where p.nazwa != 'kierowniczy'
--12 pokaz turnusy 7 dniowe, oraz date rozpoczecia
select t.turnus_id, t.data_rozpoczecia
from turnus as t
where t.ilosc_dni = 7;
--13 wypisz imiona i nazwiska pracownikow
select o.imie + o.nazwisko AS pracownik, p.pracownik_id
from pracownik as p, osoba as o
where p.id_osoba = o.osoba_id
--14 wypisz wszyskie dziewczeta z uczestnikow
select o.imie + ' ' + o.nazwisko AS uczestniczka, u.uczestnik_id
from uczestnik as u, osoba as o
where u.id_osoba = o.osoba_id AND right(o.imie, 1) = 'a'
--15 wypisz uczestnikow nie posiadajacych informacji o numerze tel rodzica
select o.imie + ' ' + o.nazwisko AS uczestnik, u.uczestnik_id
from uczestnik as u, osoba as o
where u.id_osoba = o.osoba_id AND u.telefonRodzica = NULL




--wypisz ile pokoji oferuja wspolpracujace placowki
WITH   cte
AS     (SELECT p.nazwa_osrodka, p.ilosc_pokoji, 0 as n
		from placowka as p
        UNION 
        SELECT p.nazwa_osrodka, p.ilosc_pokoji, n + p.ilosc_pokoji
        FROM   placowka as p,-- cte
		
       )
SELECT nazwa_osrodka, ilosc_pokoji, n
FROM   cte;
--
WITH   cte
AS     (SELECT 1 AS n -- anchor member
        UNION ALL
        SELECT n + 1 -- recursive member
        FROM   cte
        WHERE  n < 50 -- terminator
       )
SELECT n
FROM   cte;
-- NEXT prowadzacy zarabiajacy powyzej sredniej
select p.pracownik_id
from pracownik as p, transza as t, profil as pp
where p.pracownik_id = t.id_pracownik AND t.id_profil = pp.profil_id AND pp.stawkaDniowaProwadzacego > (select AVG(p.stawkaDniowaProwadzacego)
																		from profil as p
																		where p.nazwa != 'kierowniczy')
group by p.pracownik_id


select * from transza
union
select * from profil --1,2,6