# CREATE DATABASE hospital;
BEGIN;
USE hospital;
CREATE TABLE Paciente (
  Id              INT,
  Nombre          TEXT,
  fechaNacimiento DATE,
  PRIMARY KEY (id)
);

CREATE TABLE Doctor (
  id     INT,
  nombre TEXT,
  PRIMARY KEY (id)
);


CREATE TABLE Prueba (
  id          INT,
  descripcion TEXT,
  PRIMARY KEY (id)
);


CREATE TABLE PreguntasPrueba (
  id             INT,
  pruebaId       INT,
  numeroPregunta INT,
  textoPregunta  TEXT,
  ayudaPregunta  TEXT,
  PRIMARY KEY (id),
  FOREIGN KEY (pruebaId) REFERENCES Prueba (id)
);


CREATE TABLE InstanciaPrueba (
  id       INT,
  fecha    DATE,
  total    INT,
  pruebaId INT,
  PRIMARY KEY (id),
  FOREIGN KEY (pruebaId) REFERENCES Prueba (id)
);


CREATE TABLE Respuestas (
  preguntaId        INT,
  instanciaPruebaId INT,
  valor             INT,
  respuestaId       INT NOT NULL UNIQUE,
  PRIMARY KEY (respuestaId),
  FOREIGN KEY (preguntaId) REFERENCES PreguntasPrueba (id),
  FOREIGN KEY (instanciaPruebaId) REFERENCES InstanciaPrueba (id)
);


CREATE TABLE Medicamento (
  id                INT,
  nombre            TEXT,
  ingredienteActivo TEXT,
  laboratorio       TEXT,
  presentacion      TEXT,
  PRIMARY KEY (id)
);


CREATE TABLE RecetaMedica (
  id            INT,
  instrucciones TEXT,
  dias          INT,
  frecuencia    INT,
  dosis         NUMERIC,
  PRIMARY KEY (id)
);


CREATE TABLE MedicamentosPorReceta (
  idMedicamento INT,
  idReceta      INT,
  PRIMARY KEY (idMedicamento, idReceta),
  FOREIGN KEY (idReceta) REFERENCES RecetaMedica (id),
  FOREIGN KEY (idMedicamento) REFERENCES Medicamento (id)
);

CREATE TABLE Consulta (
  id                INT,
  fecha             DATE,
  notaClinica       TEXT,
  peso              NUMERIC,
  estatura          NUMERIC,
  doctorId          INT,
  pacienteId        INT,
  instanciaPruebaId INT,
  recetaId          INT,
  PRIMARY KEY (id),
  FOREIGN KEY (doctorId) REFERENCES Doctor (id),
  FOREIGN KEY (pacienteId) REFERENCES Paciente (id),
  FOREIGN KEY (instanciaPruebaId) REFERENCES InstanciaPrueba (id),
  FOREIGN KEY (recetaId) REFERENCES RecetaMedica (id)
);
CREATE TABLE DMS5 (
  id              INT,
  icd9            TEXT,
  icd10           TEXT,
  dsm5Descripcion TEXT,
  PRIMARY KEY (id)
);

CREATE TABLE DiagnosticoConsulta (
  consultaId    INT,
  diagnosticoId INT,
  PRIMARY KEY (consultaId, diagnosticoId),
  FOREIGN KEY (consultaId) REFERENCES Consulta (id),
  FOREIGN KEY (diagnosticoId) REFERENCES DMS5 (id)
);

COMMIT;