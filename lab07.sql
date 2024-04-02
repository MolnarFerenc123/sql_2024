SELECT a.azon, a.rendszam, a.szin, t.azon, t.nev FROM szerelo.sz_auto a LEFT OUTER JOIN szerelo.sz_auto_tulajdonosa at ON a.azon = at.auto_azon LEFT OUTER JOIN szerelo.sz_tulajdonos t ON at.tulaj_azon = t.azon
WHERE a.szin IN ('piros','kék','fekete')
ORDER BY a.szin, a.rendszam DESC;

SELECT a.azon, a.rendszam, a.szin, TO_CHAR(sz.szereles_kezdete,'yyyy. mm. dd. hh24:mi:ss') szereles_kezdete, TO_CHAR(sz.szereles_vege,'yyyy. mm. dd. hh24:mi:ss') szereles_vege, TRUNC(sz.szereles_vege-sz.szereles_kezdete) szereles_idotartama
FROM szerelo.sz_auto a INNER JOIN szerelo.sz_szereles sz ON a.azon = sz.auto_azon INNER JOIN szerelo.sz_szerelomuhely szm ON sz.muhely_azon = szm.azon
WHERE szm.nev = 'Bekõ Tóni és Fia Kft.' AND a.szin NOT IN ('piros','kék','fekete')
ORDER BY a.szin, a.rendszam, sz.szereles_kezdete DESC;

SELECT a.szin, COUNT(a.azon) db FROM szerelo.sz_auto a
GROUP BY a.szin
HAVING COUNT(a.azon) < 7
ORDER BY db DESC;

SELECT a.azon, MAX(af.ertek) legnagyobb_ertek FROM szerelo.sz_auto a INNER JOIN szerelo.sz_autofelertekeles af ON a.azon = af.auto_azon
GROUP BY a.azon
ORDER BY legnagyobb_ertek DESC;

SELECT a.azon, a.rendszam, MAX(af.ertek) legnagyobb_ertek FROM szerelo.sz_auto a LEFT OUTER JOIN szerelo.sz_autofelertekeles af ON a.azon = af.auto_azon
GROUP BY a.azon, a.rendszam
ORDER BY legnagyobb_ertek DESC NULLS LAST;

SELECT a.azon, a.rendszam, COUNT(sz.auto_azon) szereles_szama FROM szerelo.sz_auto a LEFT OUTER JOIN szerelo.sz_szereles sz ON a.azon = sz.auto_azon
GROUP BY a.azon, a.rendszam
HAVING COUNT(sz.auto_azon) < 3
ORDER BY szereles_szama DESC;

SELECT a.azon, a.rendszam, MONTHS_BETWEEN(sysdate, a.elso_vasarlas_idopontja)/12 eletkor FROM szerelo.sz_auto a, DUAL
WHERE MONTHS_BETWEEN(sysdate, a.elso_vasarlas_idopontja)/12 < 10;

SELECT a.azon, a.rendszam, TO_CHAR(a.elso_vasarlas_idopontja, 'yyyy. mm. dd. hh24:mi:ss') elso_vasarlas_idopont, TO_CHAR(af.datum, 'yyyy. mm. dd. hh24:mi:ss') felertekeles_datum, MONTHS_BETWEEN(af.datum, a.elso_vasarlas_idopontja)/12 idotartam FROM szerelo.sz_auto a INNER JOIN szerelo.sz_autofelertekeles af ON a.azon = af.auto_azon
WHERE MONTHS_BETWEEN(af.datum, a.elso_vasarlas_idopontja)/12 > 10
ORDER BY idotartam DESC;

SELECT TO_CHAR(a.elso_vasarlas_idopontja, 'Day') het_napja, COUNT(a.azon) eladott_autok FROM szerelo.sz_auto a
GROUP BY TO_CHAR(a.elso_vasarlas_idopontja, 'Day'), TO_CHAR(a.elso_vasarlas_idopontja, 'D')
HAVING COUNT(a.azon) > 10
ORDER BY TO_CHAR(a.elso_vasarlas_idopontja, 'D');

SELECT a.azon, a.rendszam, a.elso_vasarlas_idopontja FROM szerelo.sz_auto a
WHERE EXTRACT(YEAR FROM a.elso_vasarlas_idopontja) BETWEEN 2018 AND 2020
AND a.tipus_azon IS NOT NULL;

SELECT t.azon, t.nev FROM szerelo.sz_tulajdonos t
WHERE LOWER(t.nev) LIKE '%e%e%' AND LOWER(t.nev) NOT LIKE '%e%e%e%'
ORDER BY t.nev;

SELECT * FROM szerelo.sz_tulajdonos t
WHERE t.cim LIKE 'Eger, %';

SELECT t.azon, t.nev, t.cim, SUBSTR(t.cim, 1, INSTR(t.cim, ', ' , 1 , 1) - 1 ) varos, SUBSTR(t.cim, INSTR(t.cim, ', ' , 1 , 1)+2) utca FROM szerelo.sz_tulajdonos t;

SELECT a.azon, a.rendszam FROM szerelo.sz_auto a
WHERE a.azon NOT IN (SELECT auto_azon FROM szerelo.sz_szereles);

SELECT * FROM szerelo.sz_auto a
WHERE a.elso_vasarlasi_ar > (SELECT AVG(elso_vasarlasi_ar) 
                            FROM szerelo.sz_auto 
                            WHERE szin = 'kék');
                            
CREATE SYNONYM g_auto FOR szerelo.sz_auto;

SELECT* FROM g_auto;

//DROP SYNONYM g_auto;

CREATE SEQUENCE seq_k12;

SELECT seq_k12.nextval FROM DUAL;
SELECT seq_k12.currval FROM DUAL;

DROP SEQUENCE seq_k12;

SELECT * FROM dict;