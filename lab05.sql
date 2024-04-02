SELECT aut.azon, aut.szin, aut.rendszam FROM szerelo.sz_auto aut INNER JOIN szerelo.sz_autofelertekeles autfe ON aut.azon = autfe.auto_azon
WHERE aut.szin IN ('piros','kék','fekete')
GROUP BY aut.azon, aut.szin, aut.rendszam
HAVING  AVG(autfe.ertek) > 2000000
ORDER BY aut.szin, aut.rendszam;

SELECT autt.megnevezes FROM szerelo.sz_autotipus autt LEFT OUTER JOIN szerelo.sz_auto aut ON autt.azon = aut.tipus_azon
GROUP BY autt.azon, autt.megnevezes
HAVING COUNT(aut.azon) < 3;

SELECT k.konyv_azon, k.cim, COUNT(ksz.szerzo_azon) FROM konyvtar.konyv k LEFT OUTER JOIN konyvtar.konyvszerzo ksz ON k.konyv_azon = ksz.konyv_azon
GROUP BY k.konyv_azon, k.cim;

SELECT aut.szin, COUNT(DISTINCT szerm.azon)
FROM szerelo.sz_auto aut INNER JOIN szerelo.sz_szereles szer ON aut.azon = szer.auto_azon
INNER JOIN szerelo.sz_szerelomuhely szerm ON szer.muhely_azon = szerm.azon
GROUP BY aut.szin;

SELECT autfe.ertek FROM szerelo.sz_auto aut INNER JOIN szerelo.sz_autofelertekeles autfe ON aut.azon = autfe.auto_azon
WHERE aut.rendszam = 'SQL339';

SELECT autfe.ertek FROM szerelo.sz_autofelertekeles autfe
WHERE autfe.auto_azon IN (SELECT aut.azon FROM szerelo.sz_auto aut WHERE aut.rendszam = 'SQL339');

SELECT * FROM szerelo.sz_autofelertekeles autfe INNER JOIN (SELECT * FROM szerelo.sz_auto aut WHERE aut.rendszam = 'SQL339') sqlrend ON autfe.auto_azon = sqlrend.azon;

SELECT * FROM szerelo.sz_auto aut1
WHERE aut1.szin = 'piros' AND aut1.elso_vasarlasi_ar > (SELECT AVG(aut2.elso_vasarlasi_ar) FROM szerelo.sz_auto aut2);

SELECT * FROM szerelo.sz_szereles szer
WHERE szer.szereles_kezdete < (SELECT ADD_MONTHS(MAX(szul_dat),20*12) FROM szerelo.sz_szerelo);

SELECT tul.nev, tul.cim FROM szerelo.sz_tulajdonos tul 
UNION
SELECT szer.nev, szer.cim FROM szerelo.sz_szerelo szer;

SELECT tul.nev, tul.cim FROM szerelo.sz_tulajdonos tul 
MINUS
SELECT szer.nev, szer.cim FROM szerelo.sz_szerelo szer;

SELECT * FROM szerelo.sz_auto
WHERE azon NOT IN (SELECT auto_azon FROM szerelo.sz_autofelertekeles);

SELECT tul.nev, tul.cim FROM szerelo.sz_tulajdonos tul 
INTERSECT
SELECT szer.nev, szer.cim FROM szerelo.sz_szerelo szer;

SELECT tul.nev, tul.cim FROM szerelo.sz_tulajdonos tul
WHERE (tul.nev, tul.cim) IN (SELECT szer.nev, szer.cim FROM szerelo.sz_szerelo szer);

SELECT DISTINCT aut.szin, aut.rendszam FROM szerelo.sz_auto aut
WHERE aut.azon IN (SELECT auto_azon FROM szerelo.sz_autofelertekeles) OR aut.azon IN (SELECT auto_azon FROM szerelo.sz_auto_tulajdonosa);

SELECT marka, megnevezes FROM szerelo.sz_autotipus
UNION
SELECT nev, 'alma' FROM szerelo.sz_automarka;

SELECT COUNT(DISTINCT );

SELECT COUNT(DISTINCT SUBSTR(cim, 1, instr(cim,', ')-1)) FROM szerelo.sz_szerelomuhely;

SELECT SUBSTR(cim, 1, instr(cim,', ')-1) FROM szerelo.sz_szerelomuhely
UNION
SELECT SUBSTR(cim, 1, instr(cim,', ')-1) FROM szerelo.sz_tulajdonos
UNION
SELECT SUBSTR(cim, 1, instr(cim,', ')-1) FROM szerelo.sz_szerelo;

