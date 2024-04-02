SELECT marka, COUNT(azon) FROM szerelo.sz_autotipus
GROUP BY marka
HAVING COUNT(azon) > 3
ORDER BY COUNT(azon);

SELECT szin FROM szerelo.sz_auto
WHERE EXTRACT(YEAR FROM elso_vasarlas_idopontja) > 2000
GROUP BY szin
HAVING AVG(elso_vasarlasi_ar) > 6000000
ORDER BY szin DESC;

SELECT * FROM szerelo.sz_autotipus ati INNER JOIN szerelo.sz_auto au ON ati.azon = au.tipus_azon
WHERE marka = 'Volkswagen';

SELECT * FROM szerelo.sz_autotipus ati, szerelo.sz_auto au
WHERE ati.azon = au.tipus_azon AND ati.sz_autotipusmarka = 'Volkswagen';

SELECT * FROM szerelo.sz_autotipus, szerelo.sz_auto;


--sql-339
SELECT DISTINCT sz_szerelomuhely.cim
FROM (szerelo.sz_auto INNER JOIN szerelo.sz_szereles
ON sz_auto.azon = sz_szereles.auto_azon) 
INNER JOIN szerelo.sz_szerelomuhely
ON sz_szereles.muhely_azon = sz_szerelomuhely.azon
WHERE sz_auto.rendszam = 'LOP789';

SELECT k.konyv_azon, sz.vezeteknev || ' ' || sz.keresztnev
FROM konyvtar.konyv k INNER JOIN konyvtar.konyvszerzo ksz
ON k.konyv_azon = ksz.konyv_azon
INNER JOIN konyvtar.szerzo sz
ON ksz.szerzo_azon = sz.szerzo_azon
WHERE cim='Napóleon';

SELECT konyv_azon, sz.vezeteknev || ' ' || sz.keresztnev
FROM konyvtar.konyv k INNER JOIN konyvtar.konyvszerzo ksz
USING(konyv_azon)
INNER JOIN konyvtar.szerzo sz
USING(szerzo_azon)
WHERE cim='Napóleon';

SELECT konyv_azon, sz.vezeteknev || ' ' || sz.keresztnev
FROM konyvtar.konyv k NATURAL JOIN konyvtar.konyvszerzo sz;

SELECT *
FROM szerelo.sz_autotipus ati FULL OUTER JOIN szerelo.sz_auto au
ON ati.azon = au.tipus_azon;

SELECT *
FROM szerelo.sz_autotipus ati, szerelo.sz_auto au
where ati.azon (+)= au.tipus_azon;

SELECT tul.nev "Tulaj neve", tul.azon, aut.rendszam, TO_CHAR(aut.elso_vasarlas_idopontja,'yyyy. mm. dd. hh:mi:ss') vasarlas_idopontja, tul.cim
FROM szerelo.sz_auto aut INNER JOIN szerelo.sz_auto_tulajdonosa auttul
ON aut.azon = auttul.auto_azon
INNER JOIN szerelo.sz_tulajdonos tul
ON auttul.tulaj_azon = tul.azon
WHERE aut.szin IN ('piros','kék','fekete') AND tul.cim LIKE 'Debrecen, %'
ORDER BY aut.szin, tul.nev;

SELECT au.azon, au.rendszam, au.szin, auf.ertek, TO_CHAR(auf.datum,'yyyy. mm. dd. hh:mi:ss')
FROM szerelo.sz_autotipus aut LEFT OUTER JOIN szerelo.sz_auto au
ON aut.azon = au.tipus_azon
LEFT OUTER JOIN szerelo.sz_autofelertekeles auf
ON auf.auto_azon = au.azon
WHERE aut.marka IN ('Audi','Mercedes-Benz','Skoda','Volkswagen','Toyota')
ORDER BY auf.datum DESC;