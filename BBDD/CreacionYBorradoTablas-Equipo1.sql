-- Equipo 1

-- BORRADO DE TABLAS
DROP TABLE competiciones CASCADE CONSTRAINTS;
DROP TABLE jornadas CASCADE CONSTRAINTS;
DROP TABLE equipos CASCADE CONSTRAINTS;
DROP TABLE jugadores CASCADE CONSTRAINTS;
DROP TABLE enfrentamientos CASCADE CONSTRAINTS;
DROP TABLE usuarios CASCADE CONSTRAINTS;

-- CREACION DE TABLAS
CREATE TABLE competiciones (
    cod_comp NUMBER(4) GENERATED BY DEFAULT AS IDENTITY NOT NULL
        CONSTRAINT comp_cod_pk PRIMARY KEY,
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    estado VARCHAR(10) CHECK(estado IN('activo', 'inactivo'))
);

CREATE TABLE jornadas (
    cod_jornada NUMBER(4) GENERATED BY DEFAULT AS IDENTITY NOT NULL
        CONSTRAINT jor_cod_pk PRIMARY KEY,
    fecha DATE NOT NULL,
    CONSTRAINT jor_codComp_fk FOREIGN KEY (cod_jornada) -- Competicion
        REFERENCES competiciones(cod_comp)
);

CREATE TABLE equipos (
    cod_equipo NUMBER(4) GENERATED BY DEFAULT AS IDENTITY NOT NULL
        CONSTRAINT equi_cod_pk PRIMARY KEY,
    nombre VARCHAR2(50) UNIQUE NOT NULL,
    fechaFundacion DATE NOT NULL
);

CREATE TABLE jugadores (
    cod_jugador NUMBER(4) GENERATED BY DEFAULT AS IDENTITY NOT NULL
        CONSTRAINT jug_cod_pk PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    apellido VARCHAR2(50) NOT NULL,
    nacionalidad VARCHAR2(50) NOT NULL,
    fechaNacimiento DATE NOT NULL,
    nickname VARCHAR2(50) NOT NULL,
    rol VARCHAR2(20) CHECK(rol IN('duelista', 'iniciador', 'centinela', 
        'controlador')) NOT NULL,
    sueldo NUMBER(7, 2) NOT NULL,
    cod_equipo NUMBER(4) NOT NULL,
    CONSTRAINT jug_codEqui_fk FOREIGN KEY (cod_equipo) -- Equipo
        REFERENCES equipos(cod_equipo)
);

CREATE TABLE enfrentamientos (
    cod_enfre NUMBER(4) GENERATED BY DEFAULT AS IDENTITY NOT NULL
        CONSTRAINT enfre_cod_pk PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    fechaFundacion DATE NOT NULL,
    equipo1 NUMBER(4) NOT NULL,
    equipo2 NUMBER(4) NOT NULL,
    ganador NUMBER(4) NOT NULL,
    CONSTRAINT enfre_equipo1_fk FOREIGN KEY (equipo1) -- Equipo 1
        REFERENCES equipos(cod_equipo),
    CONSTRAINT enfre_equipo2_fk FOREIGN KEY (equipo2) -- Equipo 2
        REFERENCES equipos(cod_equipo),
    CONSTRAINT enfre_ganador_fk FOREIGN KEY (ganador) -- Ganador
        REFERENCES equipos(cod_equipo),
    CONSTRAINT enfre_codJor_fk FOREIGN KEY (cod_enfre) -- Jornada
        REFERENCES jornadas(cod_jornada)
);

CREATE TABLE usuarios (
    id NUMBER(4) GENERATED BY DEFAULT AS IDENTITY NOT NULL
        CONSTRAINT user_id_pk PRIMARY KEY,
    email VARCHAR2(255) NOT NULL,
    password VARCHAR2(255) NOT NULL,
    tipo VARCHAR2(5) CHECK(tipo IN('admin', 'user')) NOT NULL
);
