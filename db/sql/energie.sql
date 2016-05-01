SELECT
    CASE WHEN TO_CHAR(date, 'MM') > '03'
      THEN
        TO_CHAR(date, 'YYYY')::integer + 0
      ELSE
        TO_CHAR(date, 'YYYY')::integer - 1
    END                                                          AS year
  , MAX(CASE WHEN name = '電気代' THEN 'ELE'
             WHEN name = 'ガス代' THEN 'GAS'
             WHEN name = '水道代' THEN 'WTR'
                                  ELSE 'ERR'
        END)                                                     AS type
  , SUM(CASE TO_CHAR(date, 'MM') WHEN '04' THEN cost ELSE 0 END) AS mnth04
  , SUM(CASE TO_CHAR(date, 'MM') WHEN '05' THEN cost ELSE 0 END) AS mnth05
  , SUM(CASE TO_CHAR(date, 'MM') WHEN '06' THEN cost ELSE 0 END) AS mnth06
  , SUM(CASE TO_CHAR(date, 'MM') WHEN '07' THEN cost ELSE 0 END) AS mnth07
  , SUM(CASE TO_CHAR(date, 'MM') WHEN '08' THEN cost ELSE 0 END) AS mnth08
  , SUM(CASE TO_CHAR(date, 'MM') WHEN '09' THEN cost ELSE 0 END) AS mnth09
  , SUM(CASE TO_CHAR(date, 'MM') WHEN '10' THEN cost ELSE 0 END) AS mnth10
  , SUM(CASE TO_CHAR(date, 'MM') WHEN '11' THEN cost ELSE 0 END) AS mnth11
  , SUM(CASE TO_CHAR(date, 'MM') WHEN '12' THEN cost ELSE 0 END) AS mnth12
  , SUM(CASE TO_CHAR(date, 'MM') WHEN '01' THEN cost ELSE 0 END) AS mnth01
  , SUM(CASE TO_CHAR(date, 'MM') WHEN '02' THEN cost ELSE 0 END) AS mnth02
  , SUM(CASE TO_CHAR(date, 'MM') WHEN '03' THEN cost ELSE 0 END) AS mnth03
FROM
    expenses
WHERE
      user_id = [user_id]
  AND type = 'ENGY'
GROUP BY
    year
  , name
ORDER BY
    type
  , year
;
