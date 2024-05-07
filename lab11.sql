//Listázza ki az 5 legnagyonbb elsõ vásárlási áru autót (rsz, azon, szin) és azok tipusat

SELECT a.rendszam, a.azon, a.szin, at.megnevezes, a.elso_vasarlasi_ar FROM szerelo.sz_auto a INNER JOIN szerelo.sz_autotipus at ON a.tipus_azon=at.azon
ORDER BY a.elso_vasarlasi_ar DESC NULLS LAST
FETCH FIRST 5 ROWS WITH TIES;

//Az 5 legnagyobb munkavégzés áru szereléshez tartozó infükat írja ki: auto azon és rendszam, 
//muhely azon és név, munkavégzés ara, szerelés kezdete, vége. A lista legyen muhely, azon belül rendszám szerint rendezett

SELECT * FROM (SELECT a.azon, a.rendszam, sz.muhely_azon, szm.nev, sz.munkavegzes_ara, sz.szereles_kezdete, sz.szereles_vege
FROM szerelo.sz_szereles sz INNER JOIN szerelo.sz_auto a ON sz.auto_azon = a.azon
INNER JOIN szerelo.sz_szerelomuhely szm ON sz.muhely_azon = szm.azon
ORDER BY sz.munkavegzes_ara DESC NULLS LAST
FETCH FIRST 5 ROWS WITH TIES)
ORDER BY nev, rendszam;

//Listázza ki azokat a márkákat amelyekhez 10nél kevesebb szerelés tartoziik

SELECT am.nev, COUNT(sz.szereles_kezdete)
FROM szerelo.sz_automarka am LEFT OUTER JOIN szerelo.sz_autotipus at ON am.nev = at.marka
LEFT OUTER JOIN szerelo.sz_auto a ON at.azon = a.tipus_azon
LEFT OUTER JOIN szerelo.sz_szereles sz ON sz.auto_azon = a.azon
GROUP BY am.nev
HAVING COUNT(sz.szereles_kezdete) < 10;

//Listázza azon autókat amelyek esetén a legkisebb felértékelé érték értéke kevesebb mint 1 millió

SELECT a.azon, a.rendszam, MIN(af.ertek)
FROM szerelo.sz_auto a INNER JOIN szerelo.sz_autofelertekeles af ON a.azon = af.auto_azon
GROUP BY a.azon, a.rendszam
HAVING MIN(af.ertek) < 1000000;

//Autótipusonkéánt hány autó van:?

SELECT at.azon, at.megnevezes, COUNT(a.azon)
FROM szerelo.sz_auto a FULL OUTER JOIN szerelo.sz_autotipus at ON a.tipus_azon = at.azon
GROUP BY at.azon, at.megnevezes;

//Listázza azokat az autókat, amelyekenk az elsõ vásárlási ára nagyobb, mint az összes piros autó elsõ vásárlási ára

SELECT *
FROM szerelo.sz_auto a
WHERE a.elso_vasarlasi_ar > (SELECT MAX(elso_vasarlasi_ar)
                            FROM szerelo.sz_auto
                            WHERE szin = 'piros');
                            
SELECT *
FROM szerelo.sz_auto a
WHERE a.elso_vasarlasi_ar > ALL(SELECT elso_vasarlasi_ar
                            FROM szerelo.sz_auto
                            WHERE szin = 'piros');
                            
//Listázza azokat az autókat, amelyekenk az elsõ vásárlási ára nagyobb, mint az bármely piros autó elsõ vásárlási ára

SELECT *
FROM szerelo.sz_auto a
WHERE a.elso_vasarlasi_ar > ANY(SELECT elso_vasarlasi_ar
                            FROM szerelo.sz_auto
                            WHERE szin = 'piros');
                            
//Listázza azokat a tipusokat, amelyekhez tartozik autó. Minden tipust csak egyszer

SELECT DISTINCT at.megnevezes
FROM szerelo.sz_autotipus at INNER JOIN szerelo.sz_auto a ON at.azon = a.tipus_azon;

//számolja meg hogy egyes városok hányszor szerepelnek a szerelõ sémában (tulaj, szerelo, muhely)

SELECT SUBSTR(cim, 1, INSTR(cim, ', ')-1), COUNT(*)
FROM (SELECT cim FROM szerelo.sz_tulajdonos
    UNION ALL
    SELECT cim FROM szerelo.sz_szerelomuhely
    UNION ALL
    SELECT cim FROM szerelo.sz_szerelo)
GROUP BY SUBSTR(cim, 1, INSTR(cim, ', ')-1);

//A saját szerelés táblájába szúrja a szerelõ séma szerelés táblájának azon sorait, amely szereléseket a féktelenül bt-ben végezték

INSERT INTO b_szereles
SELECT sz.* FROM szerelo.sz_szereles sz INNER JOIN szerelo.sz_szerelomuhely szm ON sz.muhely_azon = szm.azon
WHERE szm.nev = 'Féktelenül Bt.';

//Hozzon létre nézetet amely a piros autók felértékeléseit listázza az elmúlt 3 évbõl.
//A lista tartalmazza az autó rendszámát, azonosítóját, elsõ vásárlási árat,
//felértékelés értékét, dátumát, elsõ vásárlási idõpont óta eltelt napok számát, és az érték és az elsõ vásárlási ár arányát

CREATE OR REPLACE VIEW piros AS (
SELECT a.rendszam, a.azon, a.elso_vasarlasi_ar, af.ertek, TO_CHAR(af.datum, 'yyyy. mm. dd. hh24:mi:ss') felertekeles_datuma, FLOOR(af.datum-a.elso_vasarlas_idopontja) elso_vasarlasi_idopont_felertekles_datuma_napok, af.ertek/a.elso_vasarlasi_ar ertek_elso_ar_arany
FROM szerelo.sz_auto a LEFT OUTER JOIN szerelo.sz_autofelertekeles af ON a.azon = af.auto_azon, DUAL
WHERE a.szin = 'piros' AND (MONTHS_BETWEEN(sysdate, af.datum) <= 3*12 OR af.datum IS NULL));

DROP VIEW piros;

//exist any all, not in, union, outer join, fetch, create table, alter table, drop table, insert, delete, update, 

ROLLBACK;