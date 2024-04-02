SELECT * FROM szerelo.sz_auto a
WHERE a.elso_vasarlasi_ar = (SELECT MAX(elso_vasarlasi_ar) FROM szerelo.sz_auto);

SELECT * FROM szerelo.sz_auto
ORDER BY elso_vasarlasi_ar DESC NULLS LAST
FETCH FIRST ROW WITH TIES;

SELECT * FROM konyvtar.konyv k
ORDER BY k.ar DESC NULLS LAST
FETCH FIRST ROW WITH TIES;

SELECT * FROM konyvtar.konyv k
ORDER BY k.ar DESC NULLS LAST
FETCH FIRST ROW ONLY;

SELECT * FROM konyvtar.konyv k
ORDER BY k.ar DESC NULLS LAST
FETCH FIRST 8 ROW WITH TIES;

SELECT * FROM konyvtar.konyv k
ORDER BY k.ar DESC NULLS LAST
OFFSET 5 ROWS FETCH NEXT 8 ROW WITH TIES;

SELECT ROWNUM, k.ar, k.cim FROM konyvtar.konyv k
ORDER BY k.ar DESC NULLS LAST
OFFSET 5 ROWS FETCH NEXT 8 ROW WITH TIES;

SELECT ROWNUM, ar, cim FROM (SELECT k.ar, k.cim FROM konyvtar.konyv k
ORDER BY k.ar DESC NULLS LAST
OFFSET 5 ROWS FETCH NEXT 8 ROW WITH TIES)
WHERE ROWNUM < 5;

SELECT a.* FROM szerelo.sz_auto a INNER JOIN szerelo.sz_autofelertekeles af ON a.azon = af.auto_azon
ORDER BY af.ertek DESC NULLS LAST
FETCH FIRST ROW WITH TIES;

SELECT szm.nev, a.rendszam, TO_CHAR(sz.szereles_kezdete,'yyyy. mm. dd.')
FROM szerelo.sz_auto a INNER JOIN szerelo.sz_szereles sz ON a.azon = sz.auto_azon INNER JOIN szerelo.sz_szerelomuhely szm ON sz.muhely_azon = szm.azon
ORDER BY sz.szereles_kezdete DESC NULLS LAST
FETCH FIRST 10 ROWS WITH TIES;

SELECT auto_azon, COUNT(auto_azon) FROM szerelo.sz_szereles
GROUP BY auto_azon
ORDER BY COUNT(auto_azon) DESC NULLS LAST
FETCH FIRST ROW WITH TIES;

SELECT a.azon, a.rendszam, COUNT(sz.szereles_kezdete) FROM szerelo.sz_szereles sz RIGHT OUTER JOIN szerelo.sz_auto a ON a.azon = sz.auto_azon
GROUP BY a.azon, a.rendszam
ORDER BY COUNT(sz.szereles_kezdete)
FETCH FIRST ROW WITH TIES;

SELECT t.nev FROM szerelo.sz_tulajdonos t
WHERE t.azon IN (SELECT tulaj_azon, COUNT(auto_azon) FROM szerelo.sz_auto_tulajdonosa
GROUP BY tulaj_azon
ORDER BY COUNT(auto_azon) DESC
FETCH FIRST ROW WITH TIES);

SELECT t.azon, t.nev, COUNT(auto_azon) FROM szerelo.sz_auto_tulajdonosa at RIGHT OUTER JOIN szerelo.sz_tulajdonos t ON t.azon = at.tulaj_azon
GROUP BY t.azon, t.nev
ORDER BY COUNT(auto_azon)
FETCH FIRST ROW WITH TIES;

SELECT at.megnevezes FROM szerelo.sz_auto a RIGHT OUTER JOIN szerelo.sz_autotipus at ON a.tipus_azon = at.azon
WHERE a.azon IS NULL;

SELECT a.azon, a.rendszam FROM szerelo.sz_auto a
WHERE a.azon NOT IN (SELECT auto_azon FROM szerelo.sz_szereles);

SELECT a.azon, a.elso_vasarlasi_ar, AVG(af.ertek) FROM szerelo.sz_auto a INNER JOIN szerelo.sz_autofelertekeles af ON a.azon = af.auto_azon
GROUP BY a.azon, a.elso_vasarlasi_ar
HAVING a.elso_vasarlasi_ar < AVG(af.ertek);

SELECT a.azon, a.elso_vasarlasi_ar, AVG(af.ertek) FROM szerelo.sz_auto a INNER JOIN szerelo.sz_autofelertekeles af ON a.azon = af.auto_azon
GROUP BY a.azon, a.elso_vasarlasi_ar
HAVING a.elso_vasarlasi_ar < AVG(af.ertek)*1.2;

SELECT AVG(elso_vasarlasi_ar) FROM szerelo.sz_auto 
WHERE szin = 'piros';

SELECT * FROM szerelo.sz_auto
WHERE elso_vasarlasi_ar > (SELECT AVG(elso_vasarlasi_ar) FROM szerelo.sz_auto 
WHERE szin = 'piros');

SELECT a.rendszam, maxertek.auto_azon, maxertek.max_ertek, af.datum FROM (SELECT auto_azon, MAX(ertek) max_ertek FROM szerelo.sz_autofelertekeles
                                GROUP BY auto_azon) maxertek INNER JOIN szerelo.sz_autofelertekeles af ON maxertek.max_ertek = af.ertek RIGHT OUTER JOIN szerelo.sz_auto a ON af.auto_azon = a.azon;
                                

CREATE VIEW v_piros_auto AS
SELECT a.rendszam, a.azon, a.elso_vasarlasi_ar, a.elso_vasarlas_idopontja, TO_CHAR(a.elso_vasarlas_idopontja, 'yyyy. mm. dd. hh24:mi:ss') elso_vasarlas_idopontja_ch, a.elso_vasarlasi_ar/1000000 egy_milliomod_ar FROM szerelo.sz_auto a
WHERE a.szin = 'piros'
ORDER BY a.elso_vasarlasi_ar;

SELECT * FROM v_piros_auto;

SELECT * FROM v_piros_auto pa INNER JOIN szerelo.sz_szereles sz ON pa.azon = sz.auto_azon