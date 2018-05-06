DROP PROCEDURE IF EXISTS get_visit_count;
CREATE PROCEDURE  get_visit_count()
BEGIN
  SELECT
    CONCAT(P.first_name, ' ', P.last_name) as 'Paciente',
    V.tolly as Visitas,
    V.last as 'Última Visita'
  FROM Paciente P
    JOIN
    (
      SELECT
        paciente_id,
        COUNT(paciente_id) as tolly,
        MAX(consulta_date) as last
      FROM Consulta
      GROUP BY paciente_id
    ) V ON V.paciente_id = P.paciente_id
  ORDER BY V.tolly ASC;
END;

call get_visit_count();