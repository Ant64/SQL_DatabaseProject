USE uczelnia_test;
-- wyplata = pensjaPodstawowa + dodatek
IF EXISTS (SELECT 1 FROM sysobjects WHERE TYPE = 'TF' AND name = 'wyplata')
BEGIN
	DROP FUNCTION wyplata;
	PRINT 'Usunieto funkcje wyplata';
END

GO

CREATE FUNCTION wyplata
( 
	@id_pracownik INT,
	@id_turnus VARCHAR(6)
)
RETURNS MONEY
AS
BEGIN
	DECLARE @a MONEY, @b MONEY;
	SET @a = (SELECT t.pensjaPodstawowa FROM transza as t WHERE t.id_pracownik = @id_pracownik AND t.id_turnus = @id_turnus)
	SET @b = (SELECT t.dodatek FROM transza as t WHERE t.id_pracownik = @id_pracownik AND t.id_turnus = @id_turnus)
	RETURN  @a + @b;
END
GO
-- wywolanie: select dbo.wyplata (1, '1_2016') as wyplata

-- pobierz ostatnie ID z tabeli osoba
IF EXISTS (SELECT 1 FROM sysobjects WHERE TYPE = 'FN' AND name = 'pobierzOstatniOsobaId')
BEGIN
	DROP FUNCTION pobierzOstatniOsobaId;
	PRINT 'Usunieto funkcje pobierzOstatniOsobaId';
END
GO

CREATE FUNCTION pobierzOstatniOsobaId()
RETURNS INT
AS
BEGIN
	
	DECLARE @index INT;

	SELECT TOP 1 @index = CONVERT(INT, osoba.osoba_id)
	FROM osoba
	ORDER BY osoba.osoba_id DESC;

	RETURN ISNULL( @index, 0 );

END
GO
-- wywolanie: select dbo.pobierzOstatniOsobaId()

-- turnusy zaczynajace sie w danym miesiacu
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'miesiacTurnus')
	DROP PROCEDURE miesiacTurnus;
GO

CREATE PROCEDURE [miesiacTurnus] @miesiac int
AS
SELECT [turnus_id]
      ,[data_rozpoczecia]
      ,[data_zakonczenia]
      ,[ilosc_dni]
  FROM [Kolonia_test].[dbo].[turnus]
  WHERE MONTH([data_rozpoczecia]) = @miesiac
-- wywolanie: exec miesiacTurnus 8

-- wprowadz date wyplaty
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'dataWyplaty2')
	DROP PROCEDURE dataWyplaty2;
GO

CREATE PROCEDURE [dataWyplaty2] @profilId int, @pracownikId int, @turnusId varchar(6), @q date
AS
BEGIN
	UPDATE transza
	SET transza.data_wyplaty = @q
	WHERE transza.id_profil = @profilId AND transza.id_pracownik = @pracownikId AND transza.id_turnus = @turnusId
END
-- wywolanie: exec dataWyplaty2 2, 2, '1_2016', '2016-08-30'

-- sprawdz czy dany pracownik posiada aktualna umowe, jesli nie usun go z tabeli pracownik
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'usunPracBezUmowy')
	DROP PROCEDURE usunPracBezUmowy;
GO

CREATE PROCEDURE [usunPracBezUmowy] @pracownikId INT
AS
BEGIN
	DELETE FROM pracownik
	WHERE pracownik_id = @pracownikId AND pracownik.czyPosiadaUmoweNaObecnySezon = 0
END
-- wywolanie: exec usunPracBezUmowy 0

-- wstaw nowa osobe o tabeli
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'wstawNowaOsobe')
	DROP PROCEDURE wstawNowaOsobe;
GO

CREATE PROCEDURE [wstawNowaOsobe] @imie VARCHAR(20), @nazwisko VARCHAR(30), @nr_pesel VARCHAR(11), @nr_telefonu INT, @data_urodzenia DATE
AS
BEGIN	
	INSERT INTO Kolonia_test..osoba VALUES (dbo.pobierzOstatniOsobaId() + 1, @imie, @nazwisko, @nr_pesel, @nr_telefonu, @data_urodzenia);
END
GO
-- wywolanie: exec wstawNowaOsobe 'Jan', 'Kowalski', '03240615512', 453643231, '2003-04-06'