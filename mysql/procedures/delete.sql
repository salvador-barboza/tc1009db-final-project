DROP PROCEDURE IF EXISTS deletePaciente;
CREATE PROCEDURE deletePaciente (IN idPaciente INT)
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
