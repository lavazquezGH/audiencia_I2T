-- Active: 1730472667042@@127.0.0.1@3306@audiencias

CREATE TABLE DISTRITO_JUDICIAL(
    dis_id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    dis_nombre VARCHAR(50)
);

CREATE TABLE USUARIO(  
    usr_id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    usr_nombre VARCHAR(50),
    usr_username VARCHAR(50),
    usr_mail VARCHAR(50),
    usr_estado BOOLEAN,
    usr_login VARCHAR(50),
    usr_password VARCHAR(50),
    usr_isadmin BOOLEAN,
    dis_id int,
    Foreign Key (dis_id) REFERENCES DISTRITO_JUDICIAL(dis_id)
);


CREATE TABLE SALA(
    sal_id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    sal_nombre VARCHAR(50),
    sal_lugar VARCHAR(50),
    dis_id int,
    Foreign Key (dis_id) REFERENCES DISTRITO_JUDICIAL(dis_id)
);

CREATE TABLE AUTORIDAD(
    aut_id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    aut_nombre VARCHAR(50),
    aut_mail VARCHAR(50),
    aut_tipo ENUM('JUEZ', 'FISCAL', 'DEFENSOR') NOT NULL,
    aut_estado BOOLEAN,
    dis_id int,
    Foreign Key (dis_id) REFERENCES DISTRITO_JUDICIAL(dis_id)
);

CREATE TABLE AUDIENCIA(
  aud_id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  aud_nombre VARCHAR(50),
  aud_fecins DATE NOT NULL,
  aud_fecmod DATE,
  aud_estado BOOLEAN,
  aud_tipo ENUM ('DEMORADA', 'EN HORARIO', 'REALIZADA', 'SUSPENDIDA'),
  aud_fecha DATE,
  aud_hora_ini TIME,
  aud_duracion TIME,
  aud_cuij int,
  aud_caratula VARCHAR(255),
  aud_usrins int,
  aud_usrmod INT,
  sal_id INT,
  Foreign Key (aud_usrins) REFERENCES USUARIO(usr_id),
  Foreign Key (aud_usrmod) REFERENCES USUARIO(usr_id),
  Foreign Key (sal_id) REFERENCES SALA(sal_id)
);

CREATE TABLE AUDIENCIA_EXT(
    eau_id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    eau_nombre VARCHAR(50),
    eau_fecins DATE NOT NULL,
    eau_fecmod DATE,
    eau_estado BOOLEAN,
    eau_usrins int,
    eau_usrmod INT,
    aud_id INT,
    aut_id INT,
    Foreign Key (eau_usrins) REFERENCES USUARIO(usr_id),
    Foreign Key (eau_usrmod) REFERENCES USUARIO(usr_id),
    Foreign Key (aud_id) REFERENCES AUDIENCIA(aud_id),
    Foreign Key (aut_id) REFERENCES AUTORIDAD(aut_id)
);

-- ============================
-- Script: inser_audiencias.sql
-- ============================

USE audiencias;

-- ==========================================
-- 1. Insertar datos en DISTRITO_JUDICIAL
-- ==========================================
INSERT INTO distrito_judicial (dis_nombre)
VALUES
  ('Distrito Capital'),
  ('Distrito Sur'),
  ('Distrito Norte');

-- ==========================================
-- 2. Insertar datos en USUARIO
--    (usr_isAdmin: 1=administrador, 0=operador)
--    (usr_login: 1=logueado/habilitado, 0=no)
--    (usr_estado: 1=borrado lógico, 0=activo)
-- ==========================================
INSERT INTO usuario (
  usr_nombre,
  usr_username,
  usr_password,
  usr_mail,
  usr_isAdmin,
  usr_login,
  usr_estado,
  dis_id
)
VALUES
  ('Juan Pérez',   'admin',  'admin',  'juan@admin.com',   1, 1, 0, 1),
  ('María Gómez',  'mgomez',  'abcd',  'maria@example.com',  0, 0, 0, 1),
  ('Carlos López', 'clopez',  '5678',  'carlos@example.com', 0, 1, 0, 2),
  ('Ana Torres',   'atorres', 'efgh',  'ana@example.com',    0, 0, 0, 3);

-- ==========================================
-- 3. Insertar datos en SALA
-- ==========================================
-- Salas para Distrito 1 (dis_id = 1)
INSERT INTO sala (sal_nombre, sal_lugar, dis_id) VALUES
  ('Sala Penal 1',    'Edificio Central - Piso 1', 1),
  ('Sala Civil 1',    'Edificio Central - Piso 2', 1),
  ('Sala Familia 1',  'Edificio Central - Piso 3', 1),
  ('Cámara Gesell 1', 'Edificio Central - Piso 4', 1);

-- Salas para Distrito 2 (dis_id = 2)
INSERT INTO sala (sal_nombre, sal_lugar, dis_id) VALUES
  ('Sala Penal 2',    'Edificio Sur - Piso 1', 2),
  ('Sala Civil 2',    'Edificio Sur - Piso 2', 2),
  ('Sala Familia 2',  'Edificio Sur - Piso 3', 2),
  ('Cámara Gesell 2', 'Edificio Sur - Piso 4', 2);

-- Salas para Distrito 3 (dis_id = 3)
INSERT INTO sala (sal_nombre, sal_lugar, dis_id) VALUES
  ('Sala Penal 3',    'Edificio Norte - Piso 1', 3),
  ('Sala Civil 3',    'Edificio Norte - Piso 2', 3),
  ('Sala Familia 3',  'Edificio Norte - Piso 3', 3),
  ('Cámara Gesell 3', 'Edificio Norte - Piso 4', 3);

-- ==========================================
-- 4. Insertar datos en AUTORIDAD
-- ==========================================
-- Autoridades para Distrito 1 (dis_id = 1)
INSERT INTO autoridad (aut_nombre, aut_mail, aut_tipo, dis_id, aut_estado) VALUES
  ('Juez1 Dist1',     'juez1d1@example.com',    'Juez',     1, 0),
  ('Juez2 Dist1',     'juez2d1@example.com',    'Juez',     1, 0),
  ('Fiscal1 Dist1',   'fiscal1d1@example.com',  'Fiscal',   1, 0),
  ('Fiscal2 Dist1',   'fiscal2d1@example.com',  'Fiscal',   1, 0),
  ('Defensor1 Dist1', 'def1d1@example.com',     'Defensor', 1, 0),
  ('Defensor2 Dist1', 'def2d1@example.com',     'Defensor', 1, 0);

-- Autoridades para Distrito 2 (dis_id = 2)
INSERT INTO autoridad (aut_nombre, aut_mail, aut_tipo, dis_id, aut_estado) VALUES
  ('Juez1 Dist2',     'juez1d2@example.com',    'Juez',     2, 0),
  ('Juez2 Dist2',     'juez2d2@example.com',    'Juez',     2, 0),
  ('Fiscal1 Dist2',   'fiscal1d2@example.com',  'Fiscal',   2, 0),
  ('Fiscal2 Dist2',   'fiscal2d2@example.com',  'Fiscal',   2, 0),
  ('Defensor1 Dist2', 'def1d2@example.com',     'Defensor', 2, 0),
  ('Defensor2 Dist2', 'def2d2@example.com',     'Defensor', 2, 0);

-- Autoridades para Distrito 3 (dis_id = 3)
INSERT INTO autoridad (aut_nombre, aut_mail, aut_tipo, dis_id, aut_estado) VALUES
  ('Juez1 Dist3',     'juez1d3@example.com',    'Juez',     3, 0),
  ('Juez2 Dist3',     'juez2d3@example.com',    'Juez',     3, 0),
  ('Fiscal1 Dist3',   'fiscal1d3@example.com',  'Fiscal',   3, 0),
  ('Fiscal2 Dist3',   'fiscal2d3@example.com',  'Fiscal',   3, 0),
  ('Defensor1 Dist3', 'def1d3@example.com',     'Defensor', 3, 0),
  ('Defensor2 Dist3', 'def2d3@example.com',     'Defensor', 3, 0);

-- ==========================================
-- 5. Insertar datos en AUDIENCIA
-- ==========================================
INSERT INTO audiencia (
  aud_nombre,
  aud_fecha,
  aud_hora_ini,
  aud_usrins,
  aud_usrmod,
  aud_fecins,
  aud_fecmod,
  sal_id,
  aud_estado,
  aud_tipo
)
VALUES
  -- Audiencia #1: en Distrito 1 (sala_id = 1, Distrito Capital)
  ('Audiencia Penal Importante', '2025-03-10', '10:00:00',
    1, 2, '2025-03-01 09:00:00', '2025-03-05 10:00:00',
    1, 0, 'Programada'),
    ('Audiencia Civil','2025-03-11', '09:30:00',
    2, NULL, '2025-03-02 09:30:00', NULL,
    2, 0, 'Programada'),
    ('Audiencia Penal Sur',        '2025-03-12', '11:00:00',
    3, 1, '2025-03-03 11:00:00', '2025-03-06 12:00:00',
    5, 0, 'Demorada'),
    ('Audiencia Cámara Gesell',    '2025-03-13', '14:00:00',
    4, NULL, '2025-03-04 14:00:00', NULL,
    9, 0, 'Suspendida');

-- ==========================================
-- 6. Insertar datos en AUDIENCIA_EXT
--    Cada audiencia debe contar con las tres autoridades correspondientes:
--      - Un Juez, un Fiscal y un Defensor del mismo distrito.
-- ==========================================
INSERT INTO audiencia_ext (eau_usrins, eau_usrmod, eau_fecins, eau_fecmod, aud_id, aut_id)
VALUES
  -- Audiencia #1 (Distrito 1)
  (1, 2, '2025-03-01 09:30:00', '2025-03-05 10:15:00', 1, 1),
  (1, 2, '2025-03-01 09:35:00', '2025-03-05 10:20:00', 1, 3),
  (1, 2, '2025-03-01 09:40:00', '2025-03-05 10:25:00', 1, 5),
  (2, 3, '2025-03-02 09:45:00', '2025-03-06 09:50:00', 2, 2),
  (2, 3, '2025-03-02 09:50:00', '2025-03-06 09:55:00', 2, 4),
  (2, 3, '2025-03-02 09:55:00', '2025-03-06 10:00:00', 2, 6),
  (3, 1, '2025-03-03 11:30:00', '2025-03-06 12:30:00', 3, 7),
  (3, 1, '2025-03-03 11:35:00', '2025-03-06 12:35:00', 3, 9),
  (3, 1, '2025-03-03 11:40:00', '2025-03-06 12:40:00', 3, 11),
  (4, NULL, '2025-03-04 14:30:00', NULL, 4, 13),
  (4, NULL, '2025-03-04 14:35:00', NULL, 4, 15),
  (4, NULL, '2025-03-04 14:40:00', NULL, 4, 17);
