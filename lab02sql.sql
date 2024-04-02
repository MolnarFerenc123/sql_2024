SELECT * FROM konyvtar.konyv;

SELECT k.cim, k.ar, k.ar*5, k.ar/6 korte FROM konyvtar.konyv k;

SELECT 5*5, sin(3) FROM DUAL;

SELECT * FROM konyvtar.konyv k
ORDER BY k.ar NULLS FIRST;

SELECT * FROM konyvtar.konyv k
ORDER BY k.tema DESC, k.ar DESC NULLS FIRST;

SELECT * FROM konyvtar.konyv k
WHERE k.ar > 3000 OR k.ar <= 1000
ORDER BY k.ar DESC;

SELECT * FROM konyvtar.konyv k
WHERE NOT (k.tema = 'krimi' AND k.ar != 3000)
ORDER BY k.ar DESC;

SELECT * FROM konyvtar.konyv k
WHERE k.ar >= 1200 AND k.ar <= 3000
ORDER BY k.ar;

SELECT * FROM konyvtar.konyv k
WHERE k.ar BETWEEN 1200 AND 3000
ORDER BY k.ar;

SELECT * FROM konyvtar.konyv k
WHERE k.ar IS NOT NULL;

SELECT * FROM konyvtar.konyv k
WHERE k.tema = 'horror' OR k.tema = 'sci-fi' OR k.tema = 'krimi';

SELECT * FROM konyvtar.konyv k
WHERE k.tema NOT IN ('sci-fi', 'krimi', 'horror');

SELECT k.cim FROM konyvtar.konyv k
WHERE k.cim LIKE '%a_á%';

SELECT username FROM all_users
WHERE username LIKE 'U\_%' ESCAPE '\'
ORDER BY username;

SELECT * FROM v$version;

SELECT POWER(2,3) FROM DUAL;

SELECT MOD(-15,4) FROM DUAL;

SELECT REMAINDER(-15,4) FROM DUAL;

SELECT CHR(65), CHR(97), CHR(35) FROM DUAL;

select ASCII('A') FROM DUAL;

SELECT CONCAT('A','BC') FROM DUAL;

SELECT 'A' || 'bc' || 'DE' FROM DUAL;

SELECT tema, INITCAP(cim) FROM konyvtar.konyv;

SELECT LOWER(cim), UPPER(cim) FROM konyvtar.konyv;

SELECT cim, substr(cim,4,5) FROM konyvtar.konyv;

SELECT cim, REPLACE(cim,'sz' ,'****') FROM konyvtar.konyv;

SELECT cim, TRIM('a' FROM lower(cim)) FROM konyvtar.konyv
WHERE lower(cim) LIKE 'a%a';

SELECT user, uid FROM DUAL;

SELECT * FROM konyvtar.konyv k
WHERE lower(k.cim) LIKE '%a%a%' AND lower(k.cim) NOT LIKE '%a%a%a%';