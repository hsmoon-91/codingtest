/*대여 횟수가 많은 자동차들의 월별 대여 횟수 구하기*/

-- # 대여 시작일 기준 2022년 8월 ~ 2022년 10월 대여횟수 5회이상 월별 자동차 ID별 대여횟수 
-- # 서브 쿼리가 필요한 문제
-- # 왜? 월별, 자동자 ID 별 GROUP BY 를 해야 하고, 특정 월의 총 대여 횟수가 0인 경우는 제외해야하는 조건이 있기 때문이다.
-- # 대여 시작일을 기준으로 2022년 8월부터 2022년 10월까지 총 대여 횟수가 5회 이상 : 1번 
-- # 자동차들에 대해서 해당 기간 동안의 월별 자동차 ID 별 총 대여 횟수(컬럼명: RECORDS) 리스트를 출력 : 2번

SELECT
MONTH(START_DATE) AS MONTH,
CAR_ID,
COUNT(*) AS RECORDS
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
WHERE CAR_ID IN (
    SELECT CAR_ID
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
    WHERE START_DATE >= '2022-08-01' AND START_DATE < '2022-11-01'
    GROUP BY CAR_ID
    HAVING COUNT(*)>=5
)
AND START_DATE >= '2022-08-01' AND START_DATE < '2022-11-01'
GROUP BY MONTH, CAR_ID
HAVING RECORDS != 0
ORDER BY MONTH, CAR_ID DESC


-- 다른 풀이
SELECT MONTH(H.START_DATE) AS MONTH, H.CAR_ID, COUNT(*) AS RECORDS
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY AS H
WHERE H.CAR_ID IN (SELECT HH.CAR_ID 
                  FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY AS HH
                  WHERE DATE_FORMAT(HH.START_DATE, '%Y-%m') BETWEEN "2022-08" AND "2022-10"
                  GROUP BY HH.CAR_ID
                  HAVING COUNT(*) >= 5)
AND DATE_FORMAT(H.START_DATE, '%Y-%m') BETWEEN "2022-08" AND "2022-10"

GROUP BY MONTH, H.CAR_ID
HAVING COUNT(*) != 0 
ORDER BY MONTH ASC, CAR_ID DESC