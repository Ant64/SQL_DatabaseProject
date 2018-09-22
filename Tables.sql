--Tworzenie bazy danych

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'createDatabase')
BEGIN
	DROP PROCEDURE createDatabase
	PRINT 'Usunieto procedure createDatabase'
END
GO

CREATE PROCEDURE createDatabase
AS
BEGIN

	IF exists(select 1 from master.dbo.sysdatabases where name = 'Kolonia_test') 
	BEGIN
		DROP DATABASE Kolonia_test
		PRINT 'Usunieto baze danych Kolonia_test'
	END

	CREATE DATABASE Kolonia_test
	PRINT 'Stworzono baze danych Kolonia_test'

END
GO

--Tworzenie bazy danych
--Tworzenie tabeli osoba

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'createPersonTable')
BEGIN
	DROP PROCEDURE createPersonTable
	PRINT 'Usunieto procedure createPersonTable'
END
GO

CREATE PROCEDURE createPersonTable
AS
BEGIN

	IF OBJECT_ID('Kolonia_test..osoba', 'U') IS NOT NULL 
	BEGIN
		DROP TABLE Kolonia_test..osoba;
		PRINT 'Usunieto tabele osoba'
	END

	CREATE TABLE Kolonia_test..osoba( 
	
		  osoba_id			INT			NOT NULL
		, imie				VARCHAR(15) NOT NULL
		, nazwisko			VARCHAR(30) NOT NULL
		, nr_pesel			VARCHAR(11)	NOT NULL
		, nr_telefonu		INT
		, data_urodzenia	DATE
	) ;

	ALTER TABLE Kolonia_test..osoba ADD CONSTRAINT pk_id_osoba PRIMARY KEY (osoba_id);

	ALTER TABLE Kolonia_test..osoba ADD CONSTRAINT unikalny_pesel UNIQUE (nr_pesel);
	ALTER TABLE Kolonia_test..osoba ADD CONSTRAINT numer_pesel CHECK (
	SUBSTRING(nr_pesel,1,1) BETWEEN '0' AND '9' AND
	SUBSTRING(nr_pesel,2,1) BETWEEN '0' AND '9' AND
	SUBSTRING(nr_pesel,3,1) BETWEEN '0' AND '9' AND
	SUBSTRING(nr_pesel,4,1) BETWEEN '0' AND '9' AND
	SUBSTRING(nr_pesel,5,1) BETWEEN '0' AND '9' AND
	SUBSTRING(nr_pesel,6,1) BETWEEN '0' AND '9' AND
	SUBSTRING(nr_pesel,7,1) BETWEEN '0' AND '9' AND
	SUBSTRING(nr_pesel,8,1) BETWEEN '0' AND '9' AND
	SUBSTRING(nr_pesel,9,1) BETWEEN '0' AND '9' AND
	SUBSTRING(nr_pesel,10,1) BETWEEN '0' AND '9' AND
	SUBSTRING(nr_pesel,11,1) BETWEEN '0' AND '9');
	ALTER TABLE Kolonia_test..osoba ADD CONSTRAINT data_urodzenia CHECK (data_urodzenia < GETDATE());
	ALTER TABLE Kolonia_test..osoba ADD CONSTRAINT numer_telefonu CHECK (nr_telefonu LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]');
	PRINT 'Stworzono tabele uczestnik'

END
GO

--Tworzenie tabeli osoba
--Tworzenie tabeli profil

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'createProfileTable')
BEGIN
	DROP PROCEDURE createProfileTable
	PRINT 'Usunieto procedure createProfileTable'
END
GO

CREATE PROCEDURE createProfileTable
AS
BEGIN

	IF OBJECT_ID('Kolonia_test..profil', 'U') IS NOT NULL 
	BEGIN
		DROP TABLE Kolonia_test..profil;
		PRINT 'Usunieto tabele profil'
	END

	CREATE TABLE Kolonia_test..profil( 
	
			 profil_id					INT			NOT NULL
			,nazwa						VARCHAR(20) NOT NULL
			,stawkaDniowaProwadzacego	MONEY		NOT NULL
	) ;

	ALTER TABLE Kolonia_test..profil ADD CONSTRAINT pk_id_profil PRIMARY KEY (profil_id);

	ALTER TABLE Kolonia_test..profil ADD CONSTRAINT nazwa_profilu CHECK (
	nazwa = 'muzyczny' OR nazwa = 'sportowy' OR nazwa = 'plastyczny' OR nazwa = 'artystyczny' OR nazwa = 'azjatycki' OR nazwa = 'techniczny' OR nazwa = 'kierowniczy');
	PRINT 'Stworzono tabele profil'

END
GO

--Tworzenie tabeli profil
--Tworzenie tabeli turnus

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'createBatchTable')
BEGIN
	DROP PROCEDURE createBatchTable
	PRINT 'Usunieto procedure createBatchTable'
END
GO

CREATE PROCEDURE createBatchTable
AS
BEGIN

	IF OBJECT_ID('Kolonia_test..turnus', 'U') IS NOT NULL 
	BEGIN
		DROP TABLE Kolonia_test..turnus;
		PRINT 'Usunieto tabele turnus'
	END

	CREATE TABLE Kolonia_test..turnus( 
	
		 turnus_id				VARCHAR(6)	NOT NULL
		,data_rozpoczecia		DATE		NOT NULL
		,data_zakonczenia		DATE
		,ilosc_dni				INT			NOT NULL
	) ;

	ALTER TABLE Kolonia_test..turnus ADD CONSTRAINT pk_id_turnus PRIMARY KEY (turnus_id);

	ALTER TABLE Kolonia_test..turnus ADD CONSTRAINT letnie_miesiace CHECK (MONTH(data_rozpoczecia) = 6 OR MONTH(data_rozpoczecia) = 7 OR MONTH(data_rozpoczecia) = 8);
	ALTER TABLE Kolonia_test..turnus ADD CONSTRAINT identyfikacja_turnus_id CHECK (
	SUBSTRING(turnus_id,1,1) BETWEEN '1' AND '9' AND SUBSTRING(turnus_id,2,1) = '_' AND right(turnus_id, 4) = YEAR(data_rozpoczecia));
	ALTER TABLE Kolonia_test..turnus ADD CONSTRAINT ile_dni_limit CHECK (ilosc_dni = 7 OR ilosc_dni = 12);
	PRINT 'Stworzono tabele turnus'

END
GO

--Tworzenie tabeli turnus
--Tworzenie tabeli pracownik

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'createEmployeeTable')
BEGIN
	DROP PROCEDURE createEmployeeTable
	PRINT 'Usunieto procedure createEmployeeTable'
END
GO

CREATE PROCEDURE createEmployeeTable
AS
BEGIN

	IF OBJECT_ID('Kolonia_test..pracownik', 'U') IS NOT NULL 
	BEGIN
		DROP TABLE Kolonia_test..pracownik;
		PRINT 'Usunieto tabele pracownik'
	END

	CREATE TABLE Kolonia_test..pracownik( 
	
		  pracownik_id					INT NOT NULL
		 ,id_osoba						INT NOT NULL
		 ,czyPosiadaUmoweNaObecnySezon	BIT
	) ;

	ALTER TABLE Kolonia_test..pracownik ADD CONSTRAINT pk_id_pracownik PRIMARY KEY (pracownik_id);
	ALTER TABLE Kolonia_test..pracownik ADD CONSTRAINT fk_id_osoba FOREIGN KEY (id_osoba) REFERENCES osoba (osoba_id);

	ALTER TABLE Kolonia_test..pracownik ADD CONSTRAINT uniquePersonWorker UNIQUE(id_osoba); --14.06
	PRINT 'Stworzono tabele pracownik'

END
GO

--Tworzenie tabeli pracownik
--Tworzenie tabeli kolonia

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'createHolidayTable')
BEGIN
	DROP PROCEDURE createHolidayTable
	PRINT 'Usunieto procedure createHolidayTable'
END
GO

CREATE PROCEDURE createHolidayTable
AS
BEGIN

	IF OBJECT_ID('Kolonia_test..kolonia', 'U') IS NOT NULL 
	BEGIN
		DROP TABLE Kolonia_test..kolonia;
		PRINT 'Usunieto tabele kolonia'
	END

	CREATE TABLE Kolonia_test..kolonia( 
	
		 kolonia_id				INT				NOT NULL
		,id_turnus				VARCHAR(6)		NOT NULL
		,id_kierownikPracownik	INT				NOT NULL
		,id_placowka			INT				NOT NULL
	) ;

	ALTER TABLE Kolonia_test..kolonia ADD CONSTRAINT pk_id_kolonia PRIMARY KEY (kolonia_id);
	ALTER TABLE Kolonia_test..kolonia ADD CONSTRAINT fk_id_kierownik FOREIGN KEY (id_kierownikPracownik) REFERENCES pracownik (pracownik_id);
	ALTER TABLE Kolonia_test..kolonia ADD CONSTRAINT fk_id_turnus FOREIGN KEY (id_turnus) REFERENCES turnus (turnus_id);
	ALTER TABLE Kolonia_test..kolonia ADD CONSTRAINT fk_id_placowka FOREIGN KEY (id_placowka) REFERENCES placowka (placowka_id);

	ALTER TABLE Kolonia_test..kolonia ADD CONSTRAINT identyfikacja_turnus_id_tabKolonia CHECK (
	SUBSTRING(id_turnus,1,1) BETWEEN '1' AND '9' AND SUBSTRING(id_turnus,2,1) = '_');
	ALTER TABLE Kolonia_test..kolonia ADD CONSTRAINT kiero_turnus_unikatowe UNIQUE(id_turnus, id_kierownikPracownik);
	ALTER TABLE Kolonia_test..kolonia ADD CONSTRAINT turnusID_unikatowe UNIQUE(id_turnus);
	PRINT 'Stworzono tabele kolonia'

END
GO

--Tworzenie tabeli kolonia
--Tworzenie tabeli obóz

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'createCampTable')
BEGIN
	DROP PROCEDURE createCampTable
	PRINT 'Usunieto procedure createCampTable'
END
GO

CREATE PROCEDURE createCampTable
AS
BEGIN

	IF OBJECT_ID('Kolonia_test..oboz', 'U') IS NOT NULL 
	BEGIN
		DROP TABLE Kolonia_test..Oboz;
		PRINT 'Usunieto tabele oboz'
	END

	CREATE TABLE Kolonia_test..oboz( 
	
		  oboz_id		INT			NOT NULL
		, id_profil		INT			NOT NULL
		, id_prowadzacy	INT			NOT NULL
		, id_kolonia    INT			NOT NULL
		, nazwa_obozu	VARCHAR(20) NOT NULL
	) ;

	ALTER TABLE Kolonia_test..oboz ADD CONSTRAINT pk_id_oboz PRIMARY KEY (oboz_id);
	ALTER TABLE Kolonia_test..oboz ADD CONSTRAINT fk_id_profil_obozu FOREIGN KEY (id_profil) REFERENCES profil (profil_id);
	ALTER TABLE Kolonia_test..oboz ADD CONSTRAINT fk_id_kolonia FOREIGN KEY (id_kolonia) REFERENCES kolonia (kolonia_id);
	ALTER TABLE Kolonia_test..oboz ADD CONSTRAINT fk_id_prowadzacy FOREIGN KEY (id_prowadzacy) REFERENCES pracownik (pracownik_id);

	PRINT 'Stworzono tabele Oboz'

END
GO

--Tworzenie tabeli obóz
--Tworzenie tabeli uczesnik

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'createParticipantTable')
BEGIN
	DROP PROCEDURE createParticipantTable
	PRINT 'Usunieto procedure createParticipantTable'
END
GO

CREATE PROCEDURE createParticipantTable
AS
BEGIN

	IF OBJECT_ID('Kolonia_test..uczestnik', 'U') IS NOT NULL 
	BEGIN
		DROP TABLE Kolonia_test..uczestnik;
		PRINT 'Usunieto tabele uczestnik'
	END

	CREATE TABLE Kolonia_test..uczestnik( 
	
		  uczestnik_id		INT		NOT NULL
		, id_osoba			INT		NOT NULL
		, id_oboz			INT		NOT NULL
		, telefonRodzica	INT
		, nr_pokoju			INT
	) ;

	ALTER TABLE Kolonia_test..uczestnik ADD CONSTRAINT pk_id_uczestnik PRIMARY KEY (uczestnik_id);
	ALTER TABLE Kolonia_test..uczestnik ADD CONSTRAINT fk_id_opiekun FOREIGN KEY (id_osoba) REFERENCES osoba (osoba_id);
	ALTER TABLE Kolonia_test..uczestnik ADD CONSTRAINT fk_id_oboz FOREIGN KEY (id_oboz) REFERENCES oboz (oboz_id);

	ALTER TABLE Kolonia_test..uczestnik ADD CONSTRAINT numer_rodzica CHECK (telefonRodzica LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]');
	PRINT 'Stworzono tabele uczestnik'

END
GO

--Tworzenie tabeli uczesnik
--Tworzenie tabeli transza

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'createSalaryTable')
BEGIN
	DROP PROCEDURE createSalaryTable
	PRINT 'Usunieto procedure createSalaryTable'
END
GO

CREATE PROCEDURE createSalaryTable
AS
BEGIN

	IF OBJECT_ID('Kolonia_test..transza', 'U') IS NOT NULL 
	BEGIN
		DROP TABLE Kolonia_test..transza;
		PRINT 'Usunieto tabele transza'
	END

	CREATE TABLE Kolonia_test..transza( 
	
			   id_profil			INT				NOT NULL
			  ,id_turnus			VARCHAR(6)		NOT NULL
			  ,id_pracownik			INT				NOT NULL
			  ,data_wyplaty			DATE
			  ,pensjaPodstawowa		MONEY
			  ,dodatek				MONEY
	) ;

	ALTER TABLE Kolonia_test..transza ADD CONSTRAINT fk_id_profil_wyplata FOREIGN KEY (id_profil) REFERENCES profil (profil_id);
	ALTER TABLE Kolonia_test..transza ADD CONSTRAINT fk_id_turnus_wyplata FOREIGN KEY (id_turnus) REFERENCES turnus (turnus_id);
	ALTER TABLE Kolonia_test..transza ADD CONSTRAINT fk_id_pracownik_wyplata FOREIGN KEY (id_pracownik) REFERENCES pracownik (pracownik_id);

	ALTER TABLE Kolonia_test..transza ADD CONSTRAINT identyfikacja_turnus_id_tabTransza CHECK (
	SUBSTRING(id_turnus,1,1) BETWEEN '1' AND '9' AND SUBSTRING(id_turnus,2,1) = '_');
	ALTER TABLE Kolonia_test..transza ADD CONSTRAINT unikatowe_FK UNIQUE(id_profil, id_turnus, id_pracownik); --14.06
	PRINT 'Stworzono tabele transza'

END
GO

--Tworzenie tabeli transza
--Tworzenie tabeli placowka


IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'createPlaceTable')
BEGIN
	DROP PROCEDURE createPlaceTable
	PRINT 'Usunieto procedure createPlaceTable'
END
GO

CREATE PROCEDURE createPlaceTable
AS
BEGIN

	IF OBJECT_ID('Kolonia_test..placowka', 'U') IS NOT NULL 
	BEGIN
		DROP TABLE Kolonia_test..placowka;
		PRINT 'Usunieto tabele placowka'
	END

	CREATE TABLE Kolonia_test..placowka( 
	
		 placowka_id		INT			NOT NULL
		,nazwa_osrodka		VARCHAR(20)
		,miejscowosc		VARCHAR(20)
		,ulica				VARCHAR(20)	NOT NULL
		,nr_posesji			INT			NOT NULL
		,kod_pocztowy		VARCHAR(6)	NOT NULL
		,ilosc_pokoji		INT
	) ;

	ALTER TABLE Kolonia_test..placowka ADD CONSTRAINT pk_id_placowka PRIMARY KEY (placowka_id);

	ALTER TABLE Kolonia_test..placowka ADD CONSTRAINT kod_pocztowy_placowka CHECK (kod_pocztowy LIKE '[0-9][0-9]-[0-9][0-9][0-9]');
	PRINT 'Stworzono tabele placowka'

END
GO

--Tworzenie tabeli placowka


--wywolywanie procedur
--kolejnosc: osoba, profil, turnus, pracownik, placowka, kolonia, oboz, uczestnik, transza

GO
BEGIN

	use master

	PRINT 'Wywolanie createDatabase';
	exec createDatabase;

	PRINT 'Wywolanie createPersonTable';
	exec createPersonTable;

	PRINT 'Wywolanie createProfileTable';
	exec createProfileTable;

	PRINT 'Wywolanie createBatchTable';
	exec createBatchTable;

	PRINT 'Wywolanie createEmployeeTable';
	exec createEmployeeTable;

	PRINT 'Wywolanie createPlaceTable';
	exec createPlaceTable;

	PRINT 'Wywolanie createHolidayTable';
	exec createHolidayTable;
	
	PRINT 'Wywolanie createCampTable';
	exec createCampTable;	

	PRINT 'Wywolanie createParticipantTable';
	exec createParticipantTable;	

	PRINT 'Wywolanie createSalaryTable';
	exec createSalaryTable;
	
	PRINT 'Stworzono wszystkie tabele!'

END