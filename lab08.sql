//DATE - dátum, év, hónap, nap, óra, perc, másodperc
//CHAR - CHAR(5), belerakom: 'alma', lekérdezem: 'alma ', kitölti a maradék helyet space-ekkel
//VARCHAR2 - oracle speciális, változó hosszúságú char, nem tölti ki
//NUMBER - alapesetben lebegõpontos, NUMBER(4) - 4 számjegy, végén tizedesvesszõ: 3213,
//NUMBER - NUMBER(6,2) 6 számjegy, 4 számjegy, tizedesvesszõ, 2 számjegy, 4312,43
//NUMBER(4,-2) 4 számjegy, 2 nulla, tizedesvesszõ: 342400,

CREATE TABLE x_tulaj(
    azon NUMBER(5),
    nev VARCHAR2(50) CONSTRAINT xt_nev_nn NOT NULL,
    szul_dat DATE,
    lakcim VARCHAR2(100),
    taj CHAR(9),
    cipomeret NUMBER(3,1) DEFAULT 40 CONSTRAINT xt_cm_nn NOT NULL,
    CONSTRAINT xt_pk PRIMARY KEY (azon),
    CONSTRAINT xt_uq_nszl UNIQUE(nev, szul_dat, lakcim),
    CONSTRAINT xt_uq_taj UNIQUE(taj),
    CONSTRAINT xt_ck_cp CHECK (cipomeret BETWEEN 0 AND 65)
);

CREATE TABLE x_auto(
    rendszam VARCHAR2(7),
    tipus VARCHAR2(30) CONSTRAINT xa_tipus_nn NOT NULL,
    ar NUMBER(10),
    tulaj_azon NUMBER(5),
    CONSTRAINT xa_pk PRIMARY KEY(rendszam),
    CONSTRAINT xa_fk_tulaj FOREIGN KEY (tulaj_azon) REFERENCES x_tulaj(azon)
);

INSERT INTO x_auto(rendszam,tipus, ar)
VALUES ('abc123','Opel',2000000);


INSERT INTO x_tulaj (azon,nev,szul_dat,lakcim,taj,cipomeret)
VALUES (1,'Molnár Ferenc',TO_DATE('2003.08.19','yyyy.mm.dd.'),'5200 Törökszentmiklós, Bajcsy 17.', '121107549',45);

INSERT INTO x_tulaj (azon,nev,szul_dat,lakcim,taj,cipomeret)
VALUES (2,'Anyu',TO_DATE('1984.06.21.','yyyy.mm.dd.'),'51-es körzet','789456157',65);

INSERT INTO x_tulaj (azon,nev,szul_dat,lakcim,taj,cipomeret)
VALUES (3,'Apu',TO_DATE('1978.06.21.','yyyy.mm.dd.'),'51-es körzet 2-es szoba','789451857',64);

COMMIT;

SELECT * FROM x_tulaj;
SELECT * FROM x_auto;


INSERT INTO x_auto (rendszam,tipus,ar,tulaj_azon)
VALUES ('FER127','Mazda RX7',0, 1);

SELECT * FROM x_auto a FULL OUTER JOIN x_tulaj t ON a.tulaj_azon = t.azon;

DELETE x_auto WHERE rendszam LIKE 'abc%';

ROLLBACK;

UPDATE x_auto
set ar = ar * 1.1,
tipus = 'Volkswagen'
WHERE rendszam LIKE 'abc%';

RENAME x_auto2 TO x_auto;

ALTER TABLE x_auto
RENAME COLUMN ar to ar2;

ALTER TABLE x_auto
RENAME CONSTRAINT xa_fk_tulaj to xa_fk_tul;

ALTER TABLE x_auto
DROP COLUMN ar;

ALTER TABLE x_auto
ADD (ar NUMBER(10) DEFAULT 0 CONSTRAINT xa_ar_nn NOT NULL);

ALTER TABLE x_auto
MODIFY (ar NUMBER(12));

ALTER TABLE x_auto
DROP CONSTRAINT xa_fk_tul;

ALTER TABLE x_auto
ADD CONSTRAINT xa_fk_tulaj FOREIGN KEY (tulaj_azon) REFERENCES x_tulaj(azon);

CREATE TABLE y_szamok
(sz number(4,1));

INSERT INTO Y_szamok (sz) VALUES(2.1);
INSERT INTO Y_szamok (sz) VALUES(-2.1);
INSERT INTO Y_szamok (sz) VALUES(2.13);
INSERT INTO Y_szamok (sz) VALUES(2123.14);
COMMIT;
ROLLBACK;
SELECT * FROM y_szamok;
DELETE y_szamok;

TRUNCATE TABLE y_szamok;

SAVEPOINT SP1;

INSERT INTO Y_szamok (sz) VALUES(4.5);

ROLLBACK TO SP1;

GRANT SELECT ON y_szamok to u_k8su9l;

GRANT INSERT ON y_szamok to u_k8su9l;

FOR Lcntr IN 1..100
LOOP
   INSERT INTO k8su9l.y_szamok (sz) VALUES (1);
END LOOP;
