DROP PROCEDURE IF EXISTS getVisitasByPaciente;
create procedure getVisitasByPaciente()
  BEGIN
    SELECT
      P.Nombre,
      V.Visitas
    FROM Paciente P
      JOIN
      (
        SELECT
          pacienteId,
          COUNT(pacienteId) as Visitas
        FROM Consulta
        GROUP BY pacienteId
      ) V ON V.pacienteId = P.Id
    ORDER BY P.Nombre ASC;
  END;

DROP PROCEDURE IF EXISTS deletePaciente;
create procedure deletePaciente(IN idPaciente INT)
  BEGIN
    DELETE FROM DiagnosticoConsulta
    WHERE consultaId IN (SELECT id
                         FROM Consulta
                         WHERE pacienteId = idPaciente);

    DELETE FROM Consulta
    WHERE pacienteId = idPaciente;

    DELETE FROM Respuestas
    WHERE instanciaPruebaId IN (
      SELECT id
      FROM InstanciaPrueba
      WHERE id NOT IN (SELECT instanciaPruebaId
                       FROM Consulta)
    );

    DELETE FROM InstanciaPrueba
    where id NOT IN (SELECT instanciaPruebaId
                     FROM Consulta);

    DELETE FROM MedicamentosPorReceta
    WHERE idReceta NOT IN (SELECT recetaId
                           FROM Consulta);

    DELETE FROM RecetaMedica
    WHERE id NOT IN (SELECT recetaId
                     FROM Consulta);
  END;

DROP PROCEDURE IF EXISTS getConsultaCount;
create procedure getConsultaCount()
  BEGIN
    SELECT
      P.Nombre,
      V.Visitas
    FROM Paciente P
      JOIN
      (
        SELECT
          pacienteId,
          COUNT(pacienteId) as Visitas
        FROM Consulta
        GROUP BY pacienteId
      ) V ON V.pacienteId = P.Id
    ORDER BY V.Visitas ASC;
  END;

DROP PROCEDURE IF EXISTS getDiagnosticoCount;
create procedure getDiagnosticoCount()
  BEGIN
    SELECT
      DS.id,
      DI.count,
      DS.dsm5Descripcion AS Description
    FROM DMS5 DS
      JOIN
      (SELECT
         DMS5.id,
         COUNT(DMS5.id) AS count
       FROM DiagnosticoConsulta DC
         JOIN DMS5 ON DMS5.id = DC.diagnosticoId
       GROUP BY DMS5.id) DI ON DS.id = DI.id
    ORDER BY DI.count DESC;
  END;

DROP PROCEDURE IF EXISTS getDiagnosticosByName;
create procedure getDiagnosticosByName(IN name TEXT)
  BEGIN
    SELECT
      P.Nombre,
      DMS5.dsm5Descripcion as 'Descripcion'
    FROM
      Paciente P
      JOIN
      Consulta C ON P.Id = C.pacienteId
      JOIN
      DiagnosticoConsulta DC ON C.id = DC.consultaId
      JOIN
      DMS5 ON DMS5.id = DC.diagnosticoId
    WHERE P.Nombre LIKE CONCAT('%', name, '%');
  END;

DROP PROCEDURE IF EXISTS getHistoriaByPaciente;
create procedure getHistoriaByPaciente(IN name TEXT)
  BEGIN
    SELECT
      P.Id,
      P.Nombre,
      P.fechaNacimiento,
      C.fecha,
      C.estatura,
      C.peso,
      C.notaClinica,
      D.nombre as NombreDoctor,
      PR.descripcion,
      I.id as PruebaId,
      R.Total
    FROM Paciente P
      JOIN Consulta C on P.Id = C.pacienteId
      JOIN Doctor D on C.doctorId = D.id
      JOIN InstanciaPrueba I on C.instanciaPruebaId = I.id
      LEFT JOIN (
        SELECT SUM(valor) as Total, instanciaPruebaId
        FROM Respuestas
        GROUP BY instanciaPruebaId) R ON R.instanciaPruebaId = I.id
      JOIN Prueba PR on I.pruebaId = PR.id
    WHERE P.Nombre LIKE CONCAT('%', name, '%')
    ORDER BY P.Nombre DESC, C.fecha ASC;
  END;

call getHistoriaByPaciente('');

  SELECT SUM(valor) as Total, instanciaPruebaId
  FROM Respuestas
  GROUP BY instanciaPruebaId;

DROP PROCEDURE IF EXISTS getReporteConsultas;
create procedure getReporteConsultas()
  BEGIN
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
  END;

DROP PROCEDURE IF EXISTS getVisitasByPaciente;
create procedure getVisitasByPaciente()
  BEGIN
    SELECT
      P.Nombre,
      V.Visitas
    FROM Paciente P
      JOIN
      (
        SELECT
          pacienteId,
          COUNT(pacienteId) as Visitas
        FROM Consulta
        GROUP BY pacienteId
      ) V ON V.pacienteId = P.Id
    ORDER BY P.Nombre ASC;
  END;

DROP PROCEDURE IF EXISTS getPruebaResults;
CREATE PROCEDURE getPruebaResults(IN pruebaId INT)
BEGIN
  SELECT
    P.textoPregunta,
    R.valor
  FROM Respuestas R JOIN
  PreguntasPrueba P ON
    R.preguntaId = P.id AND
    R.instanciaPruebaId = pruebaId;
END;

call getPruebaResults(1);

