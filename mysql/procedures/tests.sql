DROP PROCEDURE IF EXISTS get_test_info;
CREATE PROCEDURE get_test_info(IN testResultId INT)
BEGIN
  SELECT
    C.consulta_date AS 'Fecha de aplicación',
    CONCAT(P.first_name, ' ', P.last_name) AS 'Nombre del Paciente',
    CONCAT(D.first_name, ' ', D.last_name) AS 'Doctor'
    FROM Paciente P
      JOIN Consulta C ON P.paciente_id = C.paciente_id
      JOIN Doctor D on C.doctor_id = D.doctor_id
  WHERE C.test_result_id = testResultId
  LIMIT 1;
END;

DELEMITER $$
DROP PROCEDURE IF EXISTS get_test_results;
CREATE PROCEDURE get_test_results (IN testResultId INT)
BEGIN
  SELECT
    SUM(CASE WHEN
      A.question_id IN (1, 2, 3, 4, 5, 6, 14) THEN A.val END) AS Psiquic,
    SUM(CASE WHEN
      A.question_id IN (7, 8, 9, 10, 11, 12, 13) THEN A.val END) as Somatic,
    SUM(A.val) as Total,
    (CASE
      WHEN SUM(A.val) > 25 THEN 'Severe Anxiety'
      WHEN SUM(A.val) > 18 THEN 'Moderate Anxiety'
      WHEN SUM(A.val) > 14 THEN 'Mild Anxiety' END )AS Diagnostic
  FROM TestResult T
    JOIN TestResultAnswer A ON T.test_result_id = A.test_result_id
  GROUP BY T.test_result_id
  HAVING T.test_result_id = testResultId;
END;
DELIMETER;

DELIMITER $$
DROP PROCEDURE IF EXISTS get_test_brief;
CREATE PROCEDURE get_test_brief (IN testResultId INT)
BEGIN
  SELECT
    TQ.prompt AS Pregunta,
    TQ.hint as Ayuda,
    A.val AS Resupuesta
  FROM TestResult T
    JOIN TestResultAnswer A ON T.test_result_id = A.test_result_id
    JOIN TestQuestion TQ on A.question_id = TQ.question_id
    WHERE T.test_result_id = testResultId;
END;
DELIMETER;


