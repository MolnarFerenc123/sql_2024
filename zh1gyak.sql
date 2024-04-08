SELECT h.megrendeles, h.kontener, ROUND(h.rakomanysuly,2) FROM hajo.s_hozzarendel h
WHERE h.rakomanysuly > 15
ORDER BY h.rakomanysuly;

SELECT * FROM hajo.s_kikoto k
WHERE k.leiras LIKE '%kikötõméret: kicsi%' AND k.leiras LIKE '%mobil daruk%';

SELECT u.ut_id, TO_CHAR(u.indulasi_ido,'yyyy. mm. dd. hh24:mi:ss') indulas, TO_CHAR(u.erkezesi_ido,'yyyy. mm. dd. hh24:mi:ss') erkezes, u.indulasi_ido, u.erkezesi_kikoto, u.hajo FROM hajo.s_ut u
WHERE TO_CHAR(u.indulasi_ido,'ss') != '00'
ORDER BY u.indulasi_ido;

SELECT ht.hajo_tipus_id, ht.nev, COUNT(h.hajo_id) FROM hajo.s_hajo h INNER JOIN hajo.s_hajo_tipus ht ON h.hajo_tipus = ht.hajo_tipus_id
WHERE h.max_sulyterheles > 500
GROUP BY ht.hajo_tipus_id, ht.nev;

SELECT TO_CHAR(m.megrendeles_datuma,'yyyy. mm.'), COUNT(m.megrendeles_id) FROM hajo.s_megrendeles m
GROUP BY TO_CHAR(m.megrendeles_datuma,'yyyy. mm.')
HAVING COUNT(m.megrendeles_id) >= 6
ORDER BY TO_CHAR(m.megrendeles_datuma,'yyyy. mm.');

SELECT u.vezeteknev || ' ' || u.keresztnev, u.telefon FROM hajo.s_ugyfel u INNER JOIN hajo.s_helyseg h ON u.helyseg = h.helyseg_id
WHERE h.orszag = 'Szíria';

SELECT ht.nev, MIN(h.netto_suly) FROM hajo.s_hajo h INNER JOIN hajo.s_hajo_tipus ht ON h.hajo_tipus = ht.hajo_tipus_id
GROUP BY ht.nev;

SELECT o.orszag, h.helysegnev FROM hajo.s_kikoto k INNER JOIN hajo.s_helyseg h ON k.helyseg = h.helyseg_id INNER JOIN hajo.s_orszag o ON h.orszag = o.orszag
WHERE o.foldresz = 'Ázsia'
ORDER BY o.orszag, h.helysegnev;

SELECT h.nev, h.hajo_id, u.indulasi_kikoto, u.erkezesi_kikoto, TO_CHAR(u.indulasi_ido, 'yyyy. mm. dd. hh24:mi:ss') FROM hajo.s_ut u INNER JOIN hajo.s_hajo h ON h.hajo_id = u.hajo
ORDER BY u.indulasi_ido DESC
FETCH FIRST ROW WITH TIES;

SELECT k.kikoto_id, h.helysegnev, h.orszag FROM hajo.s_ut u INNER JOIN hajo.s_kikoto k ON u.erkezesi_kikoto = k.kikoto_id INNER JOIN hajo.s_helyseg h ON k.helyseg = h.helyseg_id
WHERE u.indulasi_kikoto = 'It_Cat'
ORDER BY u.indulasi_ido
FETCH FIRST ROW WITH TIES;