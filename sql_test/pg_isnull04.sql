/*NULL 처리하기*/

SELECT
ANIMAL_TYPE, 
CASE WHEN NAME IS NULL THEN 'No name' ELSE NAME END AS NAME,
SEX_UPON_INTAKE
FROM ANIMAL_INS
ORDER BY ANIMAL_ID