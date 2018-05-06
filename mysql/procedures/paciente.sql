# DROP PROCEDURE IF EXISTS get_diagnosticos_by_name;
# create procedure get_diagnosticos_by_name(IN name TEXT)
#   BEGIN
#     SELECT
#       C.consulta_date,
#       D.description
#     FROM Paciente P
#       JOIN Consulta C ON C.paciente_id = P.paciente_id
#       JOIN DiagnosticoConsulta DC ON C.consulta_id = DC.consulta_id
#       JOIN DSM5 D ON D.dsm5_id = DC.dsm5_id
#     WHERE CONCAT(P.first_name, ' ', P.last_name) LIKE CONCAT('%', name, '%');
#     END;
#   END;
#
# call get_diagnosticos_by_name('kri');


DROP PROCEDURE IF EXISTS get_historia_by_name;
create procedure get_historia_by_name(IN name TEXT)
  BEGIN
   SELECT
      C.consulta_date AS 'Fecha de consulta',
      C.estatura AS 'Estatura registrada',
      C.peso AS 'Peso registrada',
      C.nota_clinica AS 'Nota Clinica',
      C.motivo,
      CONCAT(D.first_name, ' ', D.last_name) AS 'Doctor',
      C.receta_id AS 'Id de prescripción'
    FROM Paciente P
      JOIN Consulta C on C.paciente_id = P.paciente_id
      JOIN Doctor D on C.doctor_id = D.doctor_id
      JOIN TestResult TR on C.test_result_id = TR.test_result_id
      JOIN Test T ON TR.test_id = T.test_id
    WHERE CONCAT(P.first_name,' ', P.last_name) LIKE CONCAT('%', name, '%')
    ORDER BY P.last_name ASC, C.consulta_date DESC;
  END;




DROP PROCEDURE IF EXISTS get_info_by_name;
CREATE PROCEDURE get_info_by_name(IN name TEXT)
  BEGIN
  SELECT
    CONCAT(P.first_name, ' ', P.last_name) AS Nombre,
    CASE
      WHEN P.gender LIKE 'M' THEN 'Masculino' ELSE 'Femenino' END AS 'Genero',
    P.birth_date AS 'Fecha de Nacimiento',
    P.main_addr AS 'Dirección',
    p.phone_num AS 'Telefono',
    P.email AS Email,
    P.blood_type AS 'Tipo de sangre',
    CONCAT(
        FLOOR(TIMESTAMPDIFF(MONTH, P.birth_date, current_date()) / 12), ' años ',
        FLOOR(TIMESTAMPDIFF(MONTH, P.birth_date, current_date()) mod 12), ' meses'
  ) as Edad
      FROM Paciente P
    WHERE CONCAT(P.first_name, ' ', P.last_name) LIKE CONCAT('%', name, '%');
  END;

DROP PROCEDURE IF EXISTS get_test_results_by_name;
CREATE PROCEDURE get_test_results_by_name (IN name TEXT)
BEGIN
  SELECT
      T.test_result_id AS 'Número de prueba',
      T.submition_date AS Fecha,
      SUM(CASE WHEN
        A.question_id IN (1, 2, 3, 4, 5, 6, 14) THEN A.val END) AS Psiquic,
      SUM(CASE WHEN
        A.question_id IN (7, 8, 9, 10, 11, 12, 13) THEN A.val END) as Somatic,
      SUM(A.val) as Total
    ,
      (CASE
        WHEN SUM(A.val) > 25 THEN 'Severe Anxiety'
        WHEN SUM(A.val) > 18 THEN 'Moderate Anxiety'
        WHEN SUM(A.val) > 14 THEN 'Mild Anxiety' END ) AS Diagnostic
    FROM TestResult T
      JOIN TestResultAnswer A ON T.test_result_id = A.test_result_id
      JOIN Consulta C on T.test_result_id = C.test_result_id
      JOIN Paciente P on C.paciente_id = P.paciente_id
    WHERE CONCAT(P.first_name, ' ', P.last_name) LIKE CONCAT('%', name, '%')
  GROUP BY T.test_result_id
  ORDER BY C.consulta_date DESC;
END;


DROP PROCEDURE IF EXISTS get_medicamentos_by_name;
CREATE PROCEDURE get_medicamentos_by_name(IN name TEXT)
BEGIN
  SELECT
    M.nombre,
    M.ingrediente_activo as 'Ingrediente activo',
    MIN(consulta_date) as 'Primera toma',
    M.laboratorio,
    M.presentacion,
    COUNT(M.medicamento_id) as 'Veces recetado',
    CONCAT(
      FLOOR(TIMESTAMPDIFF(MONTH, min(consulta_date), max(consulta_date)) / 12), ' años ',
      FLOOR(TIMESTAMPDIFF(MONTH, min(consulta_date), max(consulta_date)) mod 12), ' meses') as 'Tiempo en medicamento'
  FROM Paciente P
    JOIN Consulta C on P.paciente_id = C.paciente_id
    JOIN RecetaMedica R on C.receta_id = R.receta_id
    JOIN MedicamentosPorReceta MR on R.receta_id = MR.id_receta
    JOIN Medicamento M on MR.id_medicamento = M.medicamento_id
  WHERE CONCAT(P.first_name, ' ', P.last_name) LIKE CONCAT('%', name, '%')
  GROUP BY M.medicamento_id;
END;


DROP PROCEDURE IF EXISTS get_doctores_by_paciente_name;
CREATE PROCEDURE get_doctores_by_paciente_name(IN name TEXT)
BEGIN
  SELECT
    CONCAT(D.first_name, ' ', D.last_name) AS 'Doctor',
    MIN(consulta_date) as 'Primera visita',
    COUNT(D.doctor_id) as 'Consultas',
    CONCAT(
      'Hace ',
      FLOOR(TIMESTAMPDIFF(MONTH, min(consulta_date), max(consulta_date)) / 12), ' años ',
      FLOOR(TIMESTAMPDIFF(MONTH, min(consulta_date), max(consulta_date)) mod 12), ' meses') as 'Atendido desde'
  FROM Paciente P
    JOIN Consulta C on P.paciente_id = C.paciente_id
    JOIN Doctor D on C.doctor_id = D.doctor_id
  WHERE CONCAT(P.first_name, ' ', P.last_name) LIKE CONCAT('%', name, '%')
  GROUP BY D.doctor_id;
END;
