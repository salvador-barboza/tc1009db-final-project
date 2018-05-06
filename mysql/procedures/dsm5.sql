DROP PROCEDURE IF EXISTS get_diagnosticos_by_daterange;
create procedure get_diagnosticos_by_daterange(IN from_date DATE, IN to_date DATE)
  BEGIN
    SELECT
      DS.description AS Nombre,
      DS.dsm5_id AS 'Código DSM5',
      DS.icd9_code AS 'Código  ICD9',
      DS.icd10_code AS 'Código  ICD10',
      DI.tally AS 'Veces diagnosticado',
      DI.last AS 'Última incidencia'
    FROM DSM5 DS
      JOIN
        (SELECT
           D.dsm5_id,
           COUNT(D.dsm5_id) AS tally,
          MAX(C.consulta_date) AS last
         FROM DiagnosticoConsulta DC
           JOIN Consulta C ON DC.consulta_id = C.consulta_id
           JOIN DSM5 D ON D.dsm5_id = DC.dsm5_id
        WHERE 
          C.consulta_date BETWEEN from_date AND to_date
        GROUP BY D.dsm5_id
      ) DI ON DI.dsm5_id = DS.dsm5_id
    ORDER BY DI.tally DESC;
  END;
