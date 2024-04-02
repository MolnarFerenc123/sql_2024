/*
	===== Adatbazisrendszerek 01. gyakorlat (2024.02.20) =====
	>>>>> Keszitette: Varga Jozsef Mark
*/

-- 1. Listazzuk ki az aktualis datumot!

-- 2. Alap muveletek:

-- 3. Listazzuk ki a `KONYVTAR` sema `KONYV` tablajanak ossze sorat!
SELECT * FROM KONYVTAR.KONYV;
-- 4. Listazzuk ki a `KONYVTAR` sema `KONYV` tablajanak cim es ar oszlopait!
SELECT cim, ar FROM KONYVTAR.KONYV;
-- 5. Listazzuk ki az osszes konyvszerzo vezetek- es keresztnevet!
SELECT szerzo.vezeteknev, szerzo.keresztnev FROM konyvtar.szerzo;
-- 6. Listazzuk ki az osszes temat (minden tema csak egyszer szerepeljen)!
SELECT DISTINCT k.tema FROM konyvtar.konyv k;
-- 7. Listazzuk ki a konyvek oldalankenti arat!
SELECT k.cim, k.ar/k.oldalszam AS "oldalankenti ar" FROM konyvtar.konyv k;
-- 7. Listazzuk ki a konyvek oldalankenti arat ket 3 tizedes jegyre kerekitve!
SELECT k.cim, ROUND(k.ar/k.oldalszam,2) AS "oldalankenti ar" FROM konyvtar.konyv k;
-- 8. Listazzuk ki az osszes konyvszerzok teljes nevet szokozzel elvalasztva!
SELECT szerzo.vezeteknev || ' ' || szerzo.keresztnev AS "szerzo" FROM konyvtar.szerzo;
-- 9. Listazzuk ki a konyvek arait es neveit, ar szerint csokkeno sorrendben!
SELECT k.ar, k.cim FROM konyvtar.konyv k
ORDER BY k.ar DESC;
-- 10. Listazzuk ki a konyvek arait es neveit, ar szerint csokkeno sorrendben! A `NULL` ertekek a legvegen legyenek!
SELECT k.ar, k.cim FROM konyvtar.konyv k
ORDER BY k.ar DESC NULLS LAST;
-- 11. Listazzuk ki a konyvek adatait, cim illetve ar szerint novekvo sorrendben!
SELECT * FROM konyvtar.konyv k
ORDER BY k.cim, k.ar;
-- 12. Listazzuk ki a `KONYVTAR` sema `KONYV` tablajanak cim es ar oszlopait, ahol az ar nagyobb, mint 4000 Ft!
SELECT k.cim, k.ar FROM konyvtar.konyv k
WHERE k.ar > 4000;
-- 13. Listazzuk ki a `KONYVTAR` sema `KONYV` tablajanak cim es ar oszlopait, ahol az ar nagyobb, mint 4000 Ft es a cim tartalmazza a "Java" szot!
SELECT k.cim, k.ar FROM konyvtar.konyv k
WHERE k.ar > 4000 AND cim LIKE '%Java%';
-- 14. Listazzuk ki a pontosan 3000 Ft-ba kerulo konyvek cimet es arat, tema szerint rendezve!
SELECT k.cim, k.ar, k.tema FROM konyvtar.konyv k
WHERE k.ar = 3000
GROUP BY k.tema, k.cim, k.ar;
-- 15. Listazzuk ki azon konyvek adatait, melyeknek ara 3000 Ft es 4000 Ft kozott van!
SELECT * FROM konyvtar.konyv k
WHERE k.ar < 4000 AND k.ar > 3000;
-- 16. Listazzuk ki azon konyvek cimet es arat, melyeknek ara 1000 Ft es 2000 Ft kozott van, es a cim tartalmazza a "Hold" szot!
SELECT * FROM konyvtar.konyv k
WHERE k.ar < 2000 AND k.ar > 1000 AND k.cim LIKE '%Hold%';
-- 17. Listazzuk ki a 'sci-fi' temaju konyvek cimet es arat, ar szerint csokkeno sorrendben!
SELECT k.cim, k.ar FROM konyvtar.konyv k
WHERE k.tema = 'sci-fi'
ORDER BY k.ar DESC;
-- 18. Listazzuk ki a 'sci-fi' es 'fantasy' temaju konyvek cimeit!
SELECT k.cim FROM konyvtar.konyv k
WHERE k.tema = 'sci-fi' OR k.tema = 'fantasy';
-- 19. Listazzuk a **nem** 'sci-fi' es 'fantasy' temaju konyvek adatait!
SELECT * FROM konyvtar.konyv k
WHERE k.tema != 'sci-fi' AND k.tema != 'fantasy';
-- 20. Listazzuk ki a szerzok teljes nevet alfabetikus sorrendben rendezve!
SELECT szerzo.vezeteknev || ' ' || szerzo.keresztnev AS "szerzo_teljes" FROM konyvtar.szerzo
ORDER BY "szerzo_teljes";
-- 21. Listazzuk ki azon szerzok neveit, amelyek vezetekneveben szerepel legalabb ket `a` betu!
SELECT szerzo.vezeteknev || ' ' || szerzo.keresztnev FROM konyvtar.szerzo
WHERE szerzo.vezeteknev || ' ' || szerzo.keresztnev LIKE '%a%a%';
-- 22. Listazzuk ki azon szerzok neveit, amelyek vezetekneveben szerepel **pontosan** egy `a` betu!
SELECT szerzo.vezeteknev || ' ' || szerzo.keresztnev FROM konyvtar.szerzo
WHERE szerzo.vezeteknev || ' ' || szerzo.keresztnev LIKE '%a%' AND szerzo.vezeteknev || ' ' || szerzo.keresztnev NOT LIKE '%a%a%';
-- 23. Listazzuk a ferfi nyugdijas tagok nevet es cimet. A lista legyen keresztnev szerint csokkenoen, azon belul vezeteknev szerint novekvoen rendezett.
SELECT t.vezeteknev, t.keresztnev, t.cim FROM konyvtar.tag t
WHERE t.nem = 'f' AND t.besorolas = 'nyugdíjas'
ORDER BY t.keresztnev DESC, t.vezeteknev;
-- 24. Listazzuk ki a Debreceni tagok neveit es teljes cimet!
SELECT t.vezeteknev, t.keresztnev, t.cim FROM konyvtar.tag t
WHERE t.cim LIKE '%Debrecen,%';
-- 25. Irjuk ki a tagok keresztneveit csupa nagybetuvel! Minden nev csak egyszer szerepeljen!
SELECT DISTINCT UPPER(t.keresztnev) FROM konyvtar.tag t;
-- 25. Irjunk egy- illetve tobb soros megjegyzeseket!
--asdasd
/*
szia
mi a helyzet?
*/