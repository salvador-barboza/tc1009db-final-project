-- 1. Patient Name and diagnosis for all patients Perez
SELECT P.Nombre, DMS5.dsm5Descripcion as 'Descripcion' FROM
Paciente P JOIN
Consulta C ON P.Id = C.pacienteId JOIN
DiagnosticoConsulta DC ON C.id = DC.consultaId JOIN
DMS5 ON DMS5.id = DC.diagnosticoId
WHERE P.Nombre LIKE '%Fran%';


-- 2. Diagnosis and number of times in descending order of times
  SELECT
    DS.id,
    DI.count,
    DS.dsm5Descripcion AS Description
FROM DMS5 DS JOIN
  ( SELECT
    DMS5.id,
    COUNT(DMS5.id) AS count
    FROM DiagnosticoConsulta DC
      JOIN DMS5 ON DMS5.id = DC.diagnosticoId
    GROUP BY DMS5.id) DI ON DS.id = DI.id
ORDER BY DI.count DESC;


-- 3. Nombre del paciente y Numero de visitas ordenado por nombre del paciente
SELECT
  P.Nombre,
  V.Visitas
FROM Paciente P JOIN
  (
  SELECT
    pacienteId,
    COUNT(pacienteId) as Visitas
  FROM Consulta
  GROUP BY pacienteId
) V ON V.pacienteId = P.Id
ORDER BY P.Nombre ASC;

-- 1) datos generales del paciente, concatenar nombre paciente, (hacer join con tablas 1:1)
-- 2) lista de citas, incluir fecha, doctor, edad paciente, motivo de cita y nota clinica...
-- 3) lista de pruebas y resultados
-- 4) historial de diagnosticos ordenado por fecha mas reciente
-- Expediente de un paciente
-- quitar receta
SELECT
  P.Id,
  P.Nombre,
  P.fechaNacimiento,
  C.fecha,
  C.estatura,
  C.peso,
  C.notaClinica,
  D.nombre as NombreDoctor,
  R.instrucciones,
  R.dias,
  R.dosis,
  R.frecuencia,
  PR.descripcion,
  I.pruebaId,
  SUM(R.total)
FROM Paciente P
  JOIN Consulta C on P.Id = C.pacienteId
  JOIN Doctor D on C.doctorId = D.id
  JOIN RecetaMedica R on C.recetaId = R.id
  JOIN InstanciaPrueba I on C.instanciaPruebaId = I.id
  JOIN Respuestas R ON instanciaPruebaId = I.id
  JOIN Prueba PR on I.pruebaId = PR.id
WHERE P.Id = 2
ORDER BY C.fecha DESC;

-- instancia prueba
-- Desplegar test ansiedad
SELECT *
FROM PreguntasPrueba
WHERE pruebaId =
       (SELECT id
       FROM Prueba
       WHERE Prueba.descripcion LIKE 'Escala de ansiedad de Hamilton');
-- Reporte deconsultas (nombre paciente, fecha Nac,#visitas)

SELECT
  P.Id,
  P.Nombre,
  P.fechaNacimiento,
  CS.Visitas
FROM Paciente P
  JOIN (
         SELECT
           P.Id,
           COUNT(*) as Visitas
         FROM Paciente P
           JOIN Consulta C on P.Id = C.pacienteId
         GROUP BY P.Id) CS ON CS.Id = P.Id;
-- Reporte de diagnosticos (Diagnostico, #pacientes)

-- Borrar expediente
BEGIN;
DELETE FROM DiagnosticoConsulta
WHERE consultaId IN(SELECT id FROM Consulta WHERE pacienteId = 1);

DELETE FROM Consulta
WHERE pacienteId = 1;

DELETE FROM Respuestas
WHERE instanciaPruebaId IN(
    SELECT id FROM InstanciaPrueba
    WHERE id NOT IN(SELECT instanciaPruebaId FROM Consulta)
);

DELETE FROM InstanciaPrueba
where id NOT IN(SELECT instanciaPruebaId FROM Consulta);

DELETE FROM MedicamentosPorReceta
WHERE idReceta NOT IN(SELECT recetaId FROM Consulta);

DELETE FROM RecetaMedica
WHERE id NOT IN(SELECT recetaId FROM Consulta);
COMMIT;