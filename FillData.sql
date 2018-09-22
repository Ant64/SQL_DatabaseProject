USE Kolonia_test

INSERT INTO Kolonia_test..osoba VALUES (1, 'Maciek', 'Mydlowski', '03230334512', 453643231, '2003-05-03'); --uczestnik
INSERT INTO Kolonia_test..osoba VALUES (2, 'Radoslaw', 'Kromka', '00230573512', 758363231, '2000-05-03'); --uczestnik
INSERT INTO Kolonia_test..osoba VALUES (3, 'Mariusz', 'Pudlowski', '08231234512', 953643231, '2008-12-03'); --uczestnik
INSERT INTO Kolonia_test..osoba VALUES (4, 'Zbyszek', 'Myszel', '03924534912', 453643231, NULL); --uczestnik
INSERT INTO Kolonia_test..osoba VALUES (5, 'Michal', 'Kichal', '03924302852', 453643231, NULL); --uczestnik
INSERT INTO Kolonia_test..osoba VALUES (6, 'Zuza', 'Meduza', '93030734512', 453643991, '1993-07-03'); --kadra
INSERT INTO Kolonia_test..osoba VALUES (7, 'Tomek', 'Kromek', '80230534512', 652334231, '1980-05-23'); --kiero
INSERT INTO Kolonia_test..osoba VALUES (8, 'Anna', 'Naganna', '93986445127', 253643991, NULL); --kadra
INSERT INTO Kolonia_test..osoba VALUES (9, 'Alicja', 'Mors', '93060334512', 853643991, '1993-06-03'); --kadra
INSERT INTO Kolonia_test..osoba VALUES (10, 'Paulina', 'Drabina', '93924534511', 853643991, NULL); --kadra
INSERT INTO Kolonia_test..osoba VALUES (11, 'Anna', 'Panna', '95080434512', 652334231, '1995-08-04'); --kiero
INSERT INTO Kolonia_test..osoba VALUES (12, 'Joanna', 'Drawa', '01569028552', 453567231, NULL); --uczestnik
INSERT INTO Kolonia_test..osoba VALUES (13, 'Michal', 'Klawy', '02649028522', 484233231, NULL); --uczestnik
INSERT INTO Kolonia_test..osoba VALUES (14, 'Michalina', 'Ronz', '06943028523', 134566231, NULL); --uczestnik
INSERT INTO Kolonia_test..osoba VALUES (15, 'Gabrysia', 'Dryl', '02648028524', 857643231, NULL); --uczestnik
INSERT INTO Kolonia_test..osoba VALUES (16, 'Fryderyk', 'Chlost', '00531602852', 935743231, NULL); --uczestnik
INSERT INTO Kolonia_test..osoba VALUES (17, 'Marta', 'Warta', '03495602852', 456241231, NULL); --uczestnik
INSERT INTO Kolonia_test..osoba VALUES (18, 'Krysian', 'Karynski', '01549602852', 746593231, NULL); --uczestnik
INSERT INTO Kolonia_test..osoba VALUES (19, 'Daria', 'Kral', '00346502852', 958443231, NULL); --uczestnik
INSERT INTO Kolonia_test..osoba VALUES (20, 'Aleksander', 'March', '06412642852', 638943231, NULL); --uczestnik
INSERT INTO Kolonia_test..osoba VALUES (21, 'Dariusz', 'Husar', '03645650252', 958716531, NULL); --uczestnik
INSERT INTO Kolonia_test..osoba VALUES (22, 'Hanna', 'Dan', '00346694856', 916543231, NULL); --uczestnik
INSERT INTO Kolonia_test..osoba VALUES (23, 'Darek', 'Sarna', '01236502852', 931643231, NULL); --uczestnik
INSERT INTO Kolonia_test..osoba VALUES (24, 'Sara', 'Blomhopper', '00356502852', 991653231, NULL); --uczestnik
INSERT INTO Kolonia_test..osoba VALUES (25, 'Katarzyna', 'Jarzyna', '01256502852', 981343231, NULL); --uczestnik
INSERT INTO Kolonia_test..osoba VALUES (26, 'Robert', 'Grant', '03046502852', 349163231, NULL); --uczestnik
INSERT INTO Kolonia_test..osoba VALUES (27, 'Ignacy', 'Krasinski', '80230533922', 652379851, '1980-05-23'); --kiero
INSERT INTO Kolonia_test..osoba VALUES (28, 'Robert', 'Ganek', '85082533922', 652379851, '1985-08-25');

INSERT INTO Kolonia_test..profil VALUES (1, 'muzyczny', 150.00);
INSERT INTO Kolonia_test..profil VALUES (2, 'sportowy', 150.00);
INSERT INTO Kolonia_test..profil VALUES (3, 'plastyczny', 120.00);
INSERT INTO Kolonia_test..profil VALUES (4, 'artystyczny', 110.00);
INSERT INTO Kolonia_test..profil VALUES (5, 'azjatycki', 120.00);
INSERT INTO Kolonia_test..profil VALUES (6, 'techniczny', 150.00);
INSERT INTO Kolonia_test..profil VALUES (7, 'kierowniczy', 250.00);

INSERT INTO Kolonia_test..turnus VALUES ('1_2016', '2016-06-25', NULL, 7);
INSERT INTO Kolonia_test..turnus VALUES ('2_2016', '2016-07-03', NULL, 12);
INSERT INTO Kolonia_test..turnus VALUES ('3_2016', '2016-07-16', NULL, 7);
INSERT INTO Kolonia_test..turnus VALUES ('4_2016', '2016-07-24', NULL, 12);
INSERT INTO Kolonia_test..turnus VALUES ('5_2016', '2016-08-06', NULL, 7);
INSERT INTO Kolonia_test..turnus VALUES ('1_2017', '2017-06-25', NULL, 7);
INSERT INTO Kolonia_test..turnus VALUES ('2_2017', '2017-07-03', NULL, 12);
INSERT INTO Kolonia_test..turnus VALUES ('3_2017', '2017-07-16', NULL, 7);
INSERT INTO Kolonia_test..turnus VALUES ('4_2017', '2017-07-24', NULL, 12);
INSERT INTO Kolonia_test..turnus VALUES ('5_2017', '2017-08-06', NULL, 7);
INSERT INTO Kolonia_test..turnus VALUES ('1_2018', '2018-06-25', NULL, 7);
INSERT INTO Kolonia_test..turnus VALUES ('2_2018', '2018-07-03', NULL, 12);
INSERT INTO Kolonia_test..turnus VALUES ('3_2018', '2018-07-16', NULL, 7);

INSERT INTO Kolonia_test..pracownik VALUES (1, 6, 1); --kadra
INSERT INTO Kolonia_test..pracownik VALUES (2, 8, 1); --kadra
INSERT INTO Kolonia_test..pracownik VALUES (3, 9, 1); --kadra
INSERT INTO Kolonia_test..pracownik VALUES (4, 10, 1); --kadra
INSERT INTO Kolonia_test..pracownik VALUES (7, 7, 1); --kiero
INSERT INTO Kolonia_test..pracownik VALUES (8, 27, 1); --kiero 
INSERT INTO Kolonia_test..pracownik VALUES (0, 28, 0);

INSERT INTO Kolonia_test..placowka VALUES (1, 'U Ziomka', 'Murzasichle', 'krucza', 33, '04-989', 200);
INSERT INTO Kolonia_test..placowka VALUES (2, 'Villa Fanta', 'Darlowek', 'wronia', 12, '74-953', 120);
INSERT INTO Kolonia_test..placowka VALUES (3, 'Oœrodek Cezar', 'Mragowo', 'lesna', 16, '11-700', 100);

INSERT INTO Kolonia_test..kolonia VALUES (1, '1_2016', 7, 1);
INSERT INTO Kolonia_test..kolonia VALUES (2, '2_2016', 7, 1);
INSERT INTO Kolonia_test..kolonia VALUES (3, '3_2016', 8, 2);
INSERT INTO Kolonia_test..kolonia VALUES (4, '4_2016', 8, 2);
INSERT INTO Kolonia_test..kolonia VALUES (5, '5_2016', 7, 3);
INSERT INTO Kolonia_test..kolonia VALUES (6, '1_2017', 7, 3);
INSERT INTO Kolonia_test..kolonia VALUES (7, '2_2017', 7, 1);
INSERT INTO Kolonia_test..kolonia VALUES (8, '3_2017', 8, 1);
INSERT INTO Kolonia_test..kolonia VALUES (9, '1_2018', 8, 2);
INSERT INTO Kolonia_test..kolonia VALUES (10, '2_2018', 8, 2);
INSERT INTO Kolonia_test..kolonia VALUES (11, '3_2018', 7, 3);

--1_2016
INSERT INTO Kolonia_test..oboz VALUES (1, 1, 1, 1, 'gitarowy');
INSERT INTO Kolonia_test..oboz VALUES (2, 4, 2, 1, 'aktorski');
INSERT INTO Kolonia_test..oboz VALUES (3, 3, 3, 1, 'komiksowy');
INSERT INTO Kolonia_test..oboz VALUES (4, 2, 4, 1, 'trekkingowy');
--2_2017
INSERT INTO Kolonia_test..oboz VALUES (5, 1, 1, 7, 'wokalny');
INSERT INTO Kolonia_test..oboz VALUES (6, 6, 3, 7, 'robotyLego');
--3_2017
INSERT INTO Kolonia_test..oboz VALUES (7, 5, 3, 8, 'manga i anime');
--1_2018
INSERT INTO Kolonia_test..oboz VALUES (8, 2, 4, 9, 'karate');
INSERT INTO Kolonia_test..oboz VALUES (9, 3, 3, 9, 'fotograficzny');

-- 1-5/12-26
INSERT INTO Kolonia_test..uczestnik VALUES (1, 1, 1, 425644654, 12);
INSERT INTO Kolonia_test..uczestnik VALUES (2, 2, 1, 957468654, 12);
INSERT INTO Kolonia_test..uczestnik VALUES (3, 3, 1, 339285754, 12);
INSERT INTO Kolonia_test..uczestnik VALUES (4, 4, 2, 940372834, 1);
INSERT INTO Kolonia_test..uczestnik VALUES (5, 5, 2, 694523654, 1);
INSERT INTO Kolonia_test..uczestnik VALUES (6, 12, 2, 164544654, 2);
INSERT INTO Kolonia_test..uczestnik VALUES (7, 13, 3, 916544654, 2);
INSERT INTO Kolonia_test..uczestnik VALUES (8, 14, 3, 674544654, 2);
INSERT INTO Kolonia_test..uczestnik VALUES (9, 15, 3, 342564952, 32);
INSERT INTO Kolonia_test..uczestnik VALUES (10, 16, 4, 764544654, 32);
INSERT INTO Kolonia_test..uczestnik VALUES (11, 17, 4, 762644654, 13);
INSERT INTO Kolonia_test..uczestnik VALUES (12, 18, 4, 964544654, 13);
INSERT INTO Kolonia_test..uczestnik VALUES (13, 19, 5, 923144654, 11);
INSERT INTO Kolonia_test..uczestnik VALUES (14, 20, 5, 604644654, 11);
INSERT INTO Kolonia_test..uczestnik VALUES (15, 21, 6, 604244654, 11);
INSERT INTO Kolonia_test..uczestnik VALUES (16, 22, 6, 342569454, 11);
INSERT INTO Kolonia_test..uczestnik VALUES (17, 23, 6, 342534154, 4);
INSERT INTO Kolonia_test..uczestnik VALUES (18, 24, 7, 956424654, 4);
INSERT INTO Kolonia_test..uczestnik VALUES (19, 25, 8, 672544654, 4);
INSERT INTO Kolonia_test..uczestnik VALUES (20, 26, 9, 375894654, 4);

INSERT INTO Kolonia_test..transza VALUES (7, '1_2016', 1, '2016-07-20', NULL, 0.0);
INSERT INTO Kolonia_test..transza VALUES (2, '1_2016', 2, NULL, NULL, 400.0);
INSERT INTO Kolonia_test..transza VALUES (3, '1_2016', 3, NULL, NULL, 200.0);
INSERT INTO Kolonia_test..transza VALUES (4, '1_2016', 4, NULL, NULL, 100.0);
INSERT INTO Kolonia_test..transza VALUES (5, '2_2017', 1, NULL, NULL, 100.0);
INSERT INTO Kolonia_test..transza VALUES (6, '2_2017', 3, NULL, NULL, 100.0);
INSERT INTO Kolonia_test..transza VALUES (5, '3_2017', 3, NULL, NULL, 100.0);