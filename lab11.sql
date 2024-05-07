//List�zza ki az 5 legnagyonbb els� v�s�rl�si �ru aut�t (rsz, azon, szin) �s azok tipusat

SELECT a.rendszam, a.azon, a.szin, at.megnevezes, a.elso_vasarlasi_ar FROM szerelo.sz_auto a INNER JOIN szerelo.sz_autotipus at ON a.tipus_azon=at.azon
ORDER BY a.elso_vasarlasi_ar DESC NULLS LAST
FETCH FIRST 5 ROWS WITH TIES;

//Az 5 legnagyobb munkav�gz�s �ru szerel�shez tartoz� inf�kat �rja ki: auto azon �s rendszam, 
//muhely azon �s n�v, munkav�gz�s ara, szerel�s kezdete, v�ge. A lista legyen muhely, azon bel�l rendsz�m szerint rendezett

SELECT * FROM (SELECT a.azon, a.rendszam, sz.muhely_azon, szm.nev, sz.munkavegzes_ara, sz.szereles_kezdete, sz.szereles_vege
FROM szerelo.sz_szereles sz INNER JOIN szerelo.sz_auto a ON sz.auto_azon = a.azon
INNER JOIN szerelo.sz_szerelomuhely szm ON sz.muhely_azon = szm.azon
ORDER BY sz.munkavegzes_ara DESC NULLS LAST
FETCH FIRST 5 ROWS WITH TIES)
ORDER BY nev, rendszam;

//List�zza ki azokat a m�rk�kat amelyekhez 10n�l kevesebb szerel�s tartoziik

SELECT am.nev, COUNT(sz.szereles_kezdete)
FROM szerelo.sz_automarka am LEFT OUTER JOIN szerelo.sz_autotipus at ON am.nev = at.marka
LEFT OUTER JOIN szerelo.sz_auto a ON at.azon = a.tipus_azon
LEFT OUTER JOIN szerelo.sz_szereles sz ON sz.auto_azon = a.azon
GROUP BY am.nev
HAVING COUNT(sz.szereles_kezdete) < 10;

//List�zza azon aut�kat amelyek eset�n a legkisebb fel�rt�kel� �rt�k �rt�ke kevesebb mint 1 milli�

SELECT a.azon, a.rendszam, MIN(af.ertek)
FROM szerelo.sz_auto a INNER JOIN szerelo.sz_autofelertekeles af ON a.azon = af.auto_azon
GROUP BY a.azon, a.rendszam
HAVING MIN(af.ertek) < 1000000;

//Aut�tipusonk��nt h�ny aut� van:?

SELECT at.azon, at.megnevezes, COUNT(a.azon)
FROM szerelo.sz_auto a FULL OUTER JOIN szerelo.sz_autotipus at ON a.tipus_azon = at.azon
GROUP BY at.azon, at.megnevezes;

//List�zza azokat az aut�kat, amelyekenk az els� v�s�rl�si �ra nagyobb, mint az �sszes piros aut� els� v�s�rl�si �ra

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
                            
//List�zza azokat az aut�kat, amelyekenk az els� v�s�rl�si �ra nagyobb, mint az b�rmely piros aut� els� v�s�rl�si �ra

SELECT *
FROM szerelo.sz_auto a
WHERE a.elso_vasarlasi_ar > ANY(SELECT elso_vasarlasi_ar
                            FROM szerelo.sz_auto
                            WHERE szin = 'piros');
                            
//List�zza azokat a tipusokat, amelyekhez tartozik aut�. Minden tipust csak egyszer

SELECT DISTINCT at.megnevezes
FROM szerelo.sz_autotipus at INNER JOIN szerelo.sz_auto a ON at.azon = a.tipus_azon;

//sz�molja meg hogy egyes v�rosok h�nyszor szerepelnek a szerel� s�m�ban (tulaj, szerelo, muhely)

SELECT SUBSTR(cim, 1, INSTR(cim, ', ')-1), COUNT(*)
FROM (SELECT cim FROM szerelo.sz_tulajdonos
    UNION ALL
    SELECT cim FROM szerelo.sz_szerelomuhely
    UNION ALL
    SELECT cim FROM szerelo.sz_szerelo)
GROUP BY SUBSTR(cim, 1, INSTR(cim, ', ')-1);

//A saj�t szerel�s t�bl�j�ba sz�rja a szerel� s�ma szerel�s t�bl�j�nak azon sorait, amely szerel�seket a f�ktelen�l bt-ben v�gezt�k

INSERT INTO b_szereles
SELECT sz.* FROM szerelo.sz_szereles sz INNER JOIN szerelo.sz_szerelomuhely szm ON sz.muhely_azon = szm.azon
WHERE szm.nev = 'F�ktelen�l Bt.';

//Hozzon l�tre n�zetet amely a piros aut�k fel�rt�kel�seit list�zza az elm�lt 3 �vb�l.
//A lista tartalmazza az aut� rendsz�m�t, azonos�t�j�t, els� v�s�rl�si �rat,
//fel�rt�kel�s �rt�k�t, d�tum�t, els� v�s�rl�si id�pont �ta eltelt napok sz�m�t, �s az �rt�k �s az els� v�s�rl�si �r ar�ny�t

CREATE OR REPLACE VIEW piros AS (
SELECT a.rendszam, a.azon, a.elso_vasarlasi_ar, af.ertek, TO_CHAR(af.datum, 'yyyy. mm. dd. hh24:mi:ss') felertekeles_datuma, FLOOR(af.datum-a.elso_vasarlas_idopontja) elso_vasarlasi_idopont_felertekles_datuma_napok, af.ertek/a.elso_vasarlasi_ar ertek_elso_ar_arany
FROM szerelo.sz_auto a LEFT OUTER JOIN szerelo.sz_autofelertekeles af ON a.azon = af.auto_azon, DUAL
WHERE a.szin = 'piros' AND (MONTHS_BETWEEN(sysdate, af.datum) <= 3*12 OR af.datum IS NULL));

DROP VIEW piros;

//exist any all, not in, union, outer join, fetch, create table, alter table, drop table, insert, delete, update, 

ROLLBACK;