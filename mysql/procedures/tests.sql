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
BEGIN``
  SELECT
    TQ.prompt AS Pregunta,
    A.val AS Resupuesta
  FROM TestResult T
    JOIN TestResultAnswer A ON T.test_result_id = A.test_result_id
    JOIN TestQuestion TQ on A.question_id = TQ.question_id
    WHERE T.test_result_id = testResultId;
END;
DELIMETER;



