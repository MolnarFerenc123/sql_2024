DELETE FROM b_autofelertekeles af
WHERE af.auto_azon IN (SELECT a.azon FROM b_auto a
                        WHERE a.szin = 'kék' OR a.tipus_azon IN (SELECT at.azon FROM szerelo.sz_autotipus at
                                                                WHERE at.marka = 'Opel'));

rollback;

CREATE TABLE b_autotipus AS SELECT * FROM szerelo.sz_autotipus;

SELECT * FROM b_autotipus;

SELECT * FROM b_autotipus at LEFT JOIN b_auto a ON at.azon = a.tipus_azon
WHERE a.tipus_azon IS NULL AND SUBSTR(at.marka,0,1) IN ('C','M','O');

CREATE TABLE b_szereles AS SELECT * FROM szerelo.sz_szereles;

DELETE FROM b_szereles sz
WHERE sz.szereles_kezdete IN (SELECT szereles_kezdete FROM (SELECT sz.szereles_kezdete, at.auto_azon, COUNT(at.tulaj_azon)
FROM szerelo.sz_szereles sz INNER JOIN szerelo.sz_auto a ON sz.auto_azon = a.azon
RIGHT OUTER JOIN szerelo.sz_auto_tulajdonosa at ON a.azon = at.auto_azon
INNER JOIN szerelo.sz_autotipus ati ON a.tipus_azon = ati.azon
INNER JOIN szerelo.sz_szerelomuhely szm ON sz.muhely_azon = szm.azon
INNER JOIN szerelo.sz_szerelo szerelo ON szerelo.azon = szm.vezeto_azon, DUAL
WHERE ADD_MONTHS(sysdate, -36) <= sz.szereles_kezdete AND ati.leiras LIKE '%benzin%' AND szerelo.nev = 'Bekõ Antal'
GROUP BY at.auto_azon, sz.szereles_kezdete
HAVING COUNT(at.tulaj_azon) < 3));

SELECT szereles_kezdete FROM (SELECT sz.szereles_kezdete, at.auto_azon, COUNT(at.tulaj_azon)
FROM szerelo.sz_szereles sz INNER JOIN szerelo.sz_auto a ON sz.auto_azon = a.azon
RIGHT OUTER JOIN szerelo.sz_auto_tulajdonosa at ON a.azon = at.auto_azon
INNER JOIN szerelo.sz_autotipus ati ON a.tipus_azon = ati.azon
INNER JOIN szerelo.sz_szerelomuhely szm ON sz.muhely_azon = szm.azon
INNER JOIN szerelo.sz_szerelo szerelo ON szerelo.azon = szm.vezeto_azon, DUAL
WHERE ADD_MONTHS(sysdate, -36) <= sz.szereles_kezdete AND ati.leiras LIKE '%benzin%' AND szerelo.nev = 'Bekõ Antal'
GROUP BY at.auto_azon, sz.szereles_kezdete
HAVING COUNT(at.tulaj_azon) < 3);

SELECT sz.szereles_kezdete, at.auto_azon, COUNT(at.tulaj_azon)
FROM szerelo.sz_szereles sz INNER JOIN szerelo.sz_auto a ON sz.auto_azon = a.azon
RIGHT OUTER JOIN szerelo.sz_auto_tulajdonosa at ON a.azon = at.auto_azon
INNER JOIN szerelo.sz_autotipus ati ON a.tipus_azon = ati.azon
INNER JOIN szerelo.sz_szerelomuhely szm ON sz.muhely_azon = szm.azon
INNER JOIN szerelo.sz_szerelo szerelo ON szerelo.azon = szm.vezeto_azon, DUAL
WHERE ADD_MONTHS(sysdate, -36) <= sz.szereles_kezdete AND ati.leiras LIKE '%benzin%' AND szerelo.nev = 'Bekõ Antal'
GROUP BY at.auto_azon, sz.szereles_kezdete
HAVING COUNT(at.tulaj_azon) < 3;

SELECT * FROM szerelo.sz_auto_tulajdonosa at
WHERE at.tulaj_azon IN (SELECT t.azon FROM szerelo.sz_tulajdonos t
                        WHERE t.cim LIKE 'Debrecen, %')
AND at.auto_azon IN (SELECT a.azon FROM szerelo.sz_auto a
                    WHERE a.elso_vasarlasi_ar > 5000000
                    AND a.tipus_azon IN (SELECT at.azon FROM szerelo.sz_autotipus at
                                        WHERE at.marka = 'Volkswagen'));

CREATE TABLE b_auto_tulajdonosa AS SELECT * FROM szerelo.sz_auto_tulajdonosa;
                                        
DELETE FROM b_auto_tulajdonosa AT
WHERE at.tulaj_azon IN (SELECT t.azon FROM szerelo.sz_tulajdonos t
                        WHERE t.cim LIKE 'Debrecen, %')
AND at.auto_azon IN (SELECT a.azon FROM szerelo.sz_auto a
                    WHERE a.elso_vasarlasi_ar > 5000000
                    AND a.tipus_azon IN (SELECT at.azon FROM szerelo.sz_autotipus at
                                        WHERE at.marka = 'Volkswagen'));

ROLLBACK;

SELECT * FROM szerelo.sz_autofelertekeles af
WHERE af.ertek > (SELECT elso_vasarlasi_ar*0.97 FROM szerelo.sz_auto a
                    WHERE af.auto_azon = a.azon);
                    
DELETE FROM b_autofelertekeles af
WHERE af.ertek > (SELECT elso_vasarlasi_ar*0.97 FROM szerelo.sz_auto a
                    WHERE af.auto_azon = a.azon);
                    
SELECT * FROM szerelo.sz_szereles sz
WHERE TO_CHAR(sz.szereles_kezdete, 'yyyy') = (SELECT TO_CHAR(a.elso_vasarlas_idopontja, 'yyyy') FROM szerelo.sz_auto a
                                                WHERE a.azon = sz.auto_azon)
AND sz.munkavegzes_ara < (SELECT a.elso_vasarlasi_ar * 0.1 FROM szerelo.sz_auto a
                        WHERE a.azon = sz.auto_azon)
AND sz.muhely_azon = (SELECT szm.azon FROM szerelo.sz_szerelomuhely szm
                        WHERE szm.nev = 'Bekõ Tóni és Fia Kft.');
                        
DELETE FROM b_szereles sz
WHERE TO_CHAR(sz.szereles_kezdete, 'yyyy') = (SELECT TO_CHAR(a.elso_vasarlas_idopontja, 'yyyy') FROM szerelo.sz_auto a
                                                WHERE a.azon = sz.auto_azon)
AND sz.munkavegzes_ara < (SELECT a.elso_vasarlasi_ar * 0.1 FROM szerelo.sz_auto a
                        WHERE a.azon = sz.auto_azon)
AND sz.muhely_azon = (SELECT szm.azon FROM szerelo.sz_szerelomuhely szm
                        WHERE szm.nev = 'Bekõ Tóni és Fia Kft.'
                        AND szm.azon = sz.muhely_azon);
                        
UPDATE b_szereles sz
SET sz.munkavegzes_ara = (SELECT a.elso_vasarlasi_ar*0.01 FROM szerelo.sz_auto a
                            WHERE a.azon = sz.auto_azon),
    sz.szereles_vege = sz.szereles_kezdete+10
WHERE sz.szereles_kezdete IN (SELECT sz.szereles_kezdete FROM szerelo.sz_szereles sz
WHERE sz.muhely_azon = (SELECT szm.azon FROM szerelo.sz_szerelomuhely szm
                        WHERE szm.nev = 'Bekõ Tóni és Fia Kft.'
                        AND szm.azon = sz.muhely_azon)
AND sz.auto_azon IN (SELECT at.auto_azon FROM szerelo.sz_auto_tulajdonosa at
                    WHERE at.tulaj_azon IN (SELECT t.azon FROM szerelo.sz_tulajdonos t
                                            WHERE t.cim LIKE 'Debrecen, %')));
                                            
UPDATE b_autofelertekeles af
SET af.ertek = af.ertek + (SELECT a.elso_vasarlasi_ar*0.03 FROM szerelo.sz_auto a
                            WHERE af.auto_azon = a.azon)
WHERE af.auto_azon IN (SELECT a.azon FROM szerelo.sz_auto a
                        WHERE a.azon = af.auto_azon
                        AND a.tipus_azon IN (SELECT at.azon FROM szerelo.sz_autotipus at
                                            WHERE at.marka = 'Volkswagen'
                                            AND at.azon = a.tipus_azon))
AND af.auto_azon IN (SELECT af.auto_azon FROM szerelo.sz_autofelertekeles af, DUAL
                    WHERE af.datum > ADD_MONTHS(sysdate,5*-12)
                    AND af.ertek > 3000000)