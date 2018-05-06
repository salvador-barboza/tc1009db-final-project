#
# RF007 Prescription Details
#  Date, Patient Name, Doctor Name,
# Prescription details
# Medicine, instructions…..

DROP PROCEDURE IF EXISTS get_medicamentos_by_receta;
CREATE PROCEDURE get_medicamentos_by_receta(IN recetaId INT)
BEGIN
  SELECT
    nombre AS Nombre,
    ingrediente_activo AS 'Ingrediente Activo',
    laboratorio AS Laboratorio,
    presentacion AS Presentacion
  FROM Medicamento M
  WHERE medicamento_id IN (
  SELECT M.medicamento_id FROM RecetaMedica R
    JOIN MedicamentosPorReceta MR ON R.receta_id = MR.id_receta
    JOIN Medicamento M on MR.id_medicamento = M.medicamento_id
    WHERE R.receta_id = recetaId
  );
END;

call get_medicamentos_by_receta(15);
#
# #
# DROP PROCEDURE IF EXISTS get_receta_instructions;
# CREATE PROCEDURE get_receta_instructions(IN recetaId INT)
# BEGIN
#   SELECT
#     CONCAT(P.first_name, ' ', P.last_name) as 'Paciente',
#     C.consulta_date as 'Fecha',
#     R.instrucciones,
#     R.dias,
#     CONCAT('Cada ', R.frecuencia, ' horas.') AS Frecuencia,
#     R.dosis
#   FROM RecetaMedica R
#     JOIN Consulta C ON R.receta_id = C.receta_id
#     JOIN Paciente P ON C.paciente_id = P.paciente_id
#   WHERE C.receta_id = recetaId
#   GROUP BY C.receta_id;
# END;
#
#
# DROP PROCEDURE IF EXISTS get_doctor_by_receta;
# CREATE PROCEDURE get_doctor_by_receta(IN recetaId INT)
# BEGIN
#   SELECT
#     CONCAT(D.first_name, ' ', D.last_name) as 'Nombre',
#     D.phone_num AS 'Telefono',
#     D.email,
#     D.licence_num AS 'Cédula',
#     D.office_num AS 'Número de oficina'
#   FROM RecetaMedica R
#     JOIN Consulta C ON R.receta_id = C.receta_id
#     JOIN Doctor D on C.doctor_id = D.doctor_id
#   WHERE C.receta_id = recetaId
#   GROUP BY C.receta_id;
# END;
#
#
# call get_detalles_by_receta(14);