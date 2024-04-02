select sysdate from dual;

select to_char(sysdate, 'yyyy.mm.dd hh24:mi:ss') from dual;

select to_char(sysdate, 'syyyy') from dual;


select to_char(sysdate, 'yy y yyy year Year YEAR') from dual;

select to_char(sysdate, 'mm mon Mon MON month Month MONTH') from dual;

select to_char(sysdate, 'd dd ddd dy Dy DY day DAY Day') from dual;

select to_char(sysdate, 'hh hh12 hh24') from dual;

select to_char(sysdate, 'mi mm ss sssss') from dual;

select to_char(sysdate, 'cc w ww') from dual;

select to_char(add_months(sysdate,1), 'yyyy.mm.dd hh24:mi:ss') from dual;

select to_char(sysdate-1, 'yyyy.mm.dd hh24:mi:ss') from dual;

select to_char(add_months(sysdate,12), 'yyyy.mm.dd hh24:mi:ss') from dual;

select to_char(sysdate+1/(24*60*60), 'yyyy.mm.dd hh24:mi:ss') from dual;

SELECT to_char(szuletesi_datum, 'yyyy. mm. dd. hh24:mi:ss') FROM konyvtar.szerzo sz;

SELECT to_date('2005.01.01 19:10:00', 'yyyy. mm. dd. hh24:mi:ss') FROM DUAL;

SELECT (sysdate - to_date('2003.08.19 19:10:00', 'yyyy. mm. dd. hh24:mi:ss'))/7 FROM DUAL;

SELECT months_between(sysdate, to_date('2003.08.19 19:10:00', 'yyyy. mm. dd. hh24:mi:ss'))/12 FROM DUAL;

SELECT last_day(sysdate) FROM DUAL;

SELECT EXTRACT(YEAR FROM sysdate) FROM DUAL;

SELECT EXTRACT(DAY FROM sysdate) FROM DUAL;

SELECT to_char(trunc(sz.szuletesi_datum,'yyyy'),'yyyy. mm. dd. hh24:mi:ss') FROM konyvtar.szerzo sz;

SELECT to_char(round(sz.szuletesi_datum,'mm'),'yyyy. mm. dd. hh24:mi:ss') FROM konyvtar.szerzo sz;

SELECT to_char(trunc(sz.szuletesi_datum,'yyyy'),'yyyy. mm. dd. hh24:mi:ss') FROM konyvtar.szerzo sz;

SELECT sz.vezeteknev || ' ' || sz.keresztnev teljes_nev, to_char(sz.szuletesi_datum,'yyyy. mm. dd.') szuletesi_datum, TRUNC(MONTHS_BETWEEN(sysdate,sz.szuletesi_datum)/12) eletkor FROM konyvtar.szerzo sz
WHERE TRUNC(MONTHS_BETWEEN(sysdate,sz.szuletesi_datum)/12) >= 100
ORDER BY eletkor DESC;

SELECT sz.vezeteknev || ' ' || sz.keresztnev teljes_nev FROM konyvtar.szerzo sz
WHERE LOWER(sz.vezeteknev || ' ' || sz.keresztnev) LIKE '%e%e%' AND LOWER(sz.vezeteknev || ' ' || sz.keresztnev) NOT LIKE '%e%e%e%'
AND EXTRACT(MONTH FROM sz.szuletesi_datum) IN (5,7,12)
ORDER BY sz.keresztnev DESC, sz.vezeteknev;

SELECT sz.vezeteknev || ' ' || sz.keresztnev teljes_nev FROM konyvtar.szerzo sz
WHERE (LENGTH(sz.vezeteknev) >= 7 AND (sz.keresztnev LIKE '_a%' OR sz.keresztnev LIKE '_e%' OR sz.keresztnev LIKE '_i%' OR sz.keresztnev LIKE '_o%' OR sz.keresztnev LIKE '_u%'))
OR (EXTRACT(YEAR FROM sz.szuletesi_datum) < 1950 AND EXTRACT(MONTH FROM sz.szuletesi_datum) IN (5,7,11))
ORDER BY LENGTH(sz.vezeteknev) DESC, EXTRACT(MONTH FROM sz.szuletesi_datum);


SELECT sz.vezeteknev || ' ' || sz.keresztnev teljes_nev FROM konyvtar.szerzo sz
WHERE (LENGTH(sz.vezeteknev) >7 AND SUBSTR(sz.keresztnev,2,1) IN ('a','e','i','o','u'))
OR (EXTRACT(YEAR FROM sz.szuletesi_datum) < 1950 AND EXTRACT(MONTH FROM sz.szuletesi_datum) IN (5,7,11))
ORDER BY LENGTH(sz.vezeteknev) DESC, EXTRACT(MONTH FROM sz.szuletesi_datum);

SELECT MIN(k.ar), MAX(k.kiadas_datuma), MIN(k.cim), MAX(tema), SUM(k.ar), COUNT(k.konyv_azon), COUNT(k.ar), COUNT(k.tema), AVG(k.ar), SUM(k.ar)/COUNT(k.konyv_azon) FROM konyvtar.konyv k;

SELECT k.tema, COUNT(k.konyv_azon), MIN(k.ar), MAX(k.ar), SUM(k.ar) FROM konyvtar.konyv k
GROUP BY k.tema
ORDER BY k.tema;

SELECT k.kiado, COUNT(k.konyv_azon), MAX(k.oldalszam) FROM konyvtar.konyv k
GROUP BY k.kiado;

SELECT k.kiado, COUNT(k.konyv_azon) FROM konyvtar.konyv k
HAVING COUNT(k.konyv_azon) > 3
GROUP BY k.kiado;

SELECT to_char(sz.szuletesi_datum, 'month') FROM konyvtar.szerzo sz
WHERE LOWER(sz.keresztnev) LIKE '%a%'
GROUP BY to_char(sz.szuletesi_datum, 'month')
HAVING COUNT(sz.szerzo_azon) > 1
ORDER BY COUNT(sz.szerzo_azon) DESC;
