USE Kolonia_test;

-- data zakonczenia obozu = daty rozpoczecia + ilosc dni
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'TR' AND name = '')
DROP TRIGGER wstaw_date_zakonczenia_turnusu;
GO

CREATE TRIGGER wstaw_date_zakonczenia_turnusu ON turnus AFTER INSERT
AS
BEGIN
	DECLARE @turnusID VARCHAR(6),
			@data_rozpoczecia DATE,
			@ilosc_dni INT,
			@D DATE;

	SELECT @data_rozpoczecia = inserted.data_rozpoczecia FROM inserted;
	SELECT @ilosc_dni = inserted.ilosc_dni FROM inserted;
	SET @turnusID = (SELECT turnus_id FROM inserted);
	SET @D = DATEADD(DAY, @ilosc_dni, @data_rozpoczecia);

	UPDATE turnus
	SET turnus.data_zakonczenia = @D
	WHERE (turnus.turnus_id = @turnusID);

END
GO

-- ten sam pracownik nie moze byc jednoczesnie prowadzacym obozu i kierownikiem kolonii na tym samym turnusie.
-- po dodaniu prowadzacego(obozu), pobierz termin(id turnusu) dla jego obozu, pobierz kierownika turnusu (o tym samym id turnusu), porównaj pracownikow jeœli to ten sam pracownik wyœwietl komunikat o b³êdzie.
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'TR' AND name = '')
DROP TRIGGER sprawdz_czy_kieroTurnusu;
GO

CREATE TRIGGER sprawdz_czy_kieroTurnusu ON oboz AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @a INT,
			@b INT,
			@c VARCHAR(6),
			@d INT;
			
	SELECT @a = inserted.oboz_id FROM inserted; --wstawiany oboz
	SET @b = (SELECT TOP 1 o.id_prowadzacy FROM oboz as o WHERE o.oboz_id = @a) --prowadzacy wstawionego obozu
	SET @c = (SELECT TOP 1 t.turnus_id FROM turnus as t, kolonia as k, oboz as o WHERE o.id_prowadzacy = @b AND o.id_kolonia = k.kolonia_id AND k.id_turnus = t.turnus_id) --turnus na ktorym pracuje wstawiony prowadzacy obozu
	SET @d = (SELECT TOP 1 k.id_kierownikPracownik FROM kolonia as k, turnus as t WHERE t.turnus_id = @c AND t.turnus_id = k.id_turnus) --kierownik ktory pracuje na turnusie powyzej wyszukanym

	IF (@b = @d)
	BEGIN
		RAISERROR('Ten pracownik jest juz kierownikiem biezacej kolonii! Nie mozna podczas tego samego turnusu byc jednoczesnie prowadzacym obozu i kieronikiem kolonii.', 16, 1);
		ROLLBACK;
	END
END
GO
--INSERT INTO Kolonia_test..oboz VALUES (5, 1, 7, 1, 'gitarowy');

-- Wyliczenie pensji (transzy) na podstawie profilu. pensjaPodstawowa = stawka_profilu * ilosc_dni_obozu
IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'TR' AND name = '')
DROP TRIGGER obliczeniePensjiPodstawowej;
GO

CREATE TRIGGER obliczeniePensjiPodstawowej ON transza AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @a VARCHAR(6),
			@b INT,
			@z INT,
			@c INT,
			@d MONEY,
			@e MONEY;


	SET @a = (SELECT id_turnus FROM inserted)
	SET @b = (SELECT id_profil FROM inserted)
	SET @z = (SELECT id_pracownik FROM inserted)
	SET @c = (SELECT TOP 1 t.ilosc_dni FROM turnus as t, transza as t2 WHERE t.turnus_id = @a AND t2.id_turnus = t.turnus_id)
	SET	@d = (SELECT TOP 1 p.stawkaDniowaProwadzacego FROM profil as p, transza as t WHERE p.profil_id = @b AND t.id_profil = p.profil_id)
	SET	@e = @c * @d

	UPDATE transza
	SET transza.pensjaPodstawowa = @e
	WHERE (transza.id_turnus = @a AND transza.id_profil = @b AND transza.id_pracownik = @z)
END




CREATE TRIGGER PracownikNieUczestnik ON pracownik INSTEAD OF INSERT
AS
BEGIN
	declare @a int;
	declare @b int;

	--set @a = (select p.id_osoba from pracownik as p, osoba as o where p.id_osoba = o.osoba_id) 
	--set @b = (select u.id_osoba from uczestnik as u, osoba as o where u.id_osoba = o.osoba_id)

	SELECT @a = pracownik.id_osoba
	FROM pracownik
	WHERE( pracownik.pracownik_id = ( 
			SELECT inserted.pracownik_id
			FROM inserted
			) );

	SELECT @b = uczestnik.id_osoba
	FROM uczestnik
	WHERE( uczestnik.uczestnik_id = ( 
			SELECT inserted.uczestnik_id
			FROM inserted
			) );
	
	if(@a=@b)
		BEGIN
		RAISERROR('pracownik nie moze byc uczestnikiem',16 ,1);
        ROLLBACK;
		END
	ELSE
	BEGIN
		INSERT INTO pracownik SELECT * FROM inserted;
	END
END