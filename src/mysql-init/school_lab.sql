/* =========================
   DATABASE
   ========================= */

USE school_lab;


/* =========================
   TABELLA CLASSI
   ========================= */

CREATE TABLE classi(
    id_classe INT AUTO_INCREMENT PRIMARY KEY,
    anno INT,
    sezione VARCHAR(1)
);


/* =========================
   TABELLA STUDENTI
   FK NULL -> studente senza classe
   ========================= */

CREATE TABLE studenti(
    id_studente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(30),
    cognome VARCHAR(30),
    data_nascita DATE,
    id_classe INT NULL,

    FOREIGN KEY (id_classe)
    REFERENCES classi(id_classe)
);


/* =========================
   TABELLA DOCENTI
   ========================= */

CREATE TABLE docenti(
    id_docente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(30),
    cognome VARCHAR(30),
    email VARCHAR(50)
);


/* =========================
   TABELLA MATERIE
   ========================= */

CREATE TABLE materie(
    id_materia INT AUTO_INCREMENT PRIMARY KEY,
    nome_materia VARCHAR(50)
);


/* =========================
   TABELLA CORSI
   FK NULL -> corso senza docente
   ========================= */

CREATE TABLE corsi(
    id_corso INT AUTO_INCREMENT PRIMARY KEY,
    nome_corso VARCHAR(50),
    id_docente INT NULL,
    id_materia INT,

    FOREIGN KEY (id_docente)
    REFERENCES docenti(id_docente),

    FOREIGN KEY (id_materia)
    REFERENCES materie(id_materia)
);


/* =========================
   TABELLA ISCRIZIONI
   relazione molti-a-molti
   ========================= */

CREATE TABLE iscrizioni(
    id_iscrizione INT AUTO_INCREMENT PRIMARY KEY,
    id_studente INT,
    id_corso INT,
    data_iscrizione DATE,

    FOREIGN KEY (id_studente)
    REFERENCES studenti(id_studente),

    FOREIGN KEY (id_corso)
    REFERENCES corsi(id_corso)
);


/* =========================
   TABELLA VERIFICHE
   ========================= */

CREATE TABLE verifiche(
    id_verifica INT AUTO_INCREMENT PRIMARY KEY,
    id_corso INT,
    data_verifica DATE,
    tipo VARCHAR(20),

    FOREIGN KEY (id_corso)
    REFERENCES corsi(id_corso)
);


/* =========================
   TABELLA VOTI
   ========================= */

CREATE TABLE voti(
    id_voto INT AUTO_INCREMENT PRIMARY KEY,
    id_verifica INT,
    id_studente INT,
    voto INT,
    commento VARCHAR(100) NULL,

    FOREIGN KEY (id_verifica)
    REFERENCES verifiche(id_verifica),

    FOREIGN KEY (id_studente)
    REFERENCES studenti(id_studente)
);


/* =========================
   DATI DI ESEMPIO
   ========================= */

/* CLASSI */

INSERT INTO classi(anno, sezione)
VALUES
(3, 'A'),
(4, 'I'),
(5, 'D');


/* STUDENTI */

INSERT INTO studenti(nome,cognome,data_nascita,id_classe)
VALUES
('Mario','Rossi','2007-05-10',1),
('Anna','Verdi','2006-09-21',2),
('Luca','Bianchi','2007-11-02',1),
('Paolo','Neri','2006-01-15',NULL);   -- studente senza classe


/* DOCENTI */

INSERT INTO docenti(nome,cognome,email)
VALUES
('Marco','Ferrari','ferrari@scuola.it'),
('Laura','Romano','romano@scuola.it');


/* MATERIE */

INSERT INTO materie(nome_materia)
VALUES
('Informatica'),
('Matematica'),
('Sistemi');


/* CORSI */

INSERT INTO corsi(nome_corso,id_docente,id_materia)
VALUES
('SQL Base',1,1),
('Database',2,1),
('Algebra',NULL,2);   -- corso senza docente


/* ISCRIZIONI */

INSERT INTO iscrizioni(id_studente,id_corso,data_iscrizione)
VALUES
(1,1,'2024-09-15'),
(2,1,'2024-09-15'),
(3,2,'2024-09-15');


/* VERIFICHE */

INSERT INTO verifiche(id_corso,data_verifica,tipo)
VALUES
(1,'2025-02-10','scritto'),
(1,'2025-03-15','orale'),
(2,'2025-02-20','scritto');


/* VOTI */

INSERT INTO voti(id_verifica,id_studente,voto,commento)
VALUES
(1,1,8,'buono'),
(1,2,7,'discreto'),
(2,1,9,'ottimo'),
(3,3,6,NULL);