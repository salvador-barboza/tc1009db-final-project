# CREATE DATABASE hospital;
START TRANSACTION;
USE hospital;

CREATE TABLE Paciente (
  paciente_id INT,
  first_name  TEXT,
  last_name   TEXT,
  gender      CHAR,
  birth_date  DATE,
  blood_type  TEXT,
  main_addr   TEXT,
  phone_num   TEXT,
  email       TEXT,
  PRIMARY KEY (paciente_id)
);

CREATE TABLE Doctor (
  doctor_id   INT,
  first_name  TEXT,
  last_name   TEXT,
  licence_num TEXT,
  office_num  TEXT,
  phone_num   TEXT,
  email       TEXT,
  PRIMARY KEY (doctor_id)
);

CREATE TABLE Test (
  test_id          INT,
  test_name TEXT,
  PRIMARY KEY (test_id)
);

CREATE TABLE TestQuestion (
  question_id INT,
  test_id       INT,
  question_index INT,
  prompt TEXT,
  hint  TEXT,
  PRIMARY KEY (question_id),
  FOREIGN KEY (test_id) REFERENCES Test (test_id)
);

CREATE TABLE TestResult (
  test_result_id INT,
  submition_date    DATE,
  test_id INT,
  PRIMARY KEY (test_result_id),
  FOREIGN KEY (test_id) REFERENCES Test(test_id)
);

CREATE TABLE TestResultAnswer (
  test_result_id INT,
  question_id        INT,
  val INT,
  PRIMARY KEY (test_result_id, question_id),
  FOREIGN KEY (test_result_id) REFERENCES TestResult (test_result_id),
  FOREIGN KEY (question_id) REFERENCES TestQuestion (question_id)
);

CREATE TABLE Medicamento (
  medicamento_id                INT,
  nombre TEXT,
  ingrediente_activo TEXT,
  laboratorio       TEXT,
  presentacion      TEXT,
  PRIMARY KEY (medicamento_id)
);


CREATE TABLE RecetaMedica (
  receta_id            INT,
  instrucciones TEXT,
  dias          INT,
  frecuencia    INT,
  dosis         NUMERIC,
  PRIMARY KEY (receta_id)
);


CREATE TABLE MedicamentosPorReceta (
  id_medicamento INT,
  id_receta      INT,
  PRIMARY KEY (id_receta, id_medicamento),
  FOREIGN KEY (id_receta) REFERENCES RecetaMedica (receta_id),
  FOREIGN KEY (id_medicamento) REFERENCES Medicamento (medicamento_id)
);

CREATE TABLE Consulta (
  consulta_id                INT,
  consulta_date DATE,
  motivo            TEXT,
  nota_clinica       TEXT,
  peso              NUMERIC,
  estatura          NUMERIC,
  doctor_id INT,
  paciente_id        INT,
  test_result_id INT,
  receta_id          INT,
  PRIMARY KEY (consulta_id),
  FOREIGN KEY (doctor_id) REFERENCES Doctor (doctor_id),
  FOREIGN KEY (paciente_id) REFERENCES Paciente (paciente_id),
  FOREIGN KEY (test_result_id) REFERENCES TestResult (test_result_id),
  FOREIGN KEY (receta_id) REFERENCES RecetaMedica (receta_id)
);

CREATE TABLE DSM5 (
  dsm5_id              INT,
  icd9_code            TEXT,
  icd10_code           TEXT,
  description TEXT,
  PRIMARY KEY (dsm5_id)
);

CREATE TABLE DiagnosticoConsulta (
  consulta_id    INT,
  dsm5_id INT,
  PRIMARY KEY (consulta_id, dsm5_id),
  FOREIGN KEY (consulta_id) REFERENCES Consulta (consulta_id),
  FOREIGN KEY (dsm5_id) REFERENCES DSM5 (dsm5_id)
);
ROLLBACK;