/*경기도에 위치한 식품창고 목록 출력하기*/

-- 기존에 N인 경우도 있으니깐, 무조건 NOT NULL이라고 해서 Y 로 정의하면 안되는 것임. 

SELECT
WAREHOUSE_ID, WAREHOUSE_NAME, ADDRESS,
CASE WHEN FREEZER_YN IS NULL THEN 'N' ELSE FREEZER_YN END AS FREEZER_YN
FROM FOOD_WAREHOUSE
WHERE ADDRESS LIKE '경기도%'
ORDER BY WAREHOUSE_ID