SELECT
    CASE WHEN STRFTIME('%m', date) > '03'
      THEN
        STRFTIME('%Y', date) + 0
      ELSE
        STRFTIME('%Y', date) - 1
    END                                                           AS year
  , MAX(CASE WHEN name = '電気代' THEN 'ELE'
             WHEN name = 'ガス代' THEN 'GAS'
             WHEN name = '水道代' THEN 'WTR'
                                  ELSE 'ERR'
        END)                                                      AS type
  , SUM(CASE STRFTIME('%m', date) WHEN '04' THEN cost ELSE 0 END) AS mnth04
  , SUM(CASE STRFTIME('%m', date) WHEN '05' THEN cost ELSE 0 END) AS mnth05
  , SUM(CASE STRFTIME('%m', date) WHEN '06' THEN cost ELSE 0 END) AS mnth06
  , SUM(CASE STRFTIME('%m', date) WHEN '07' THEN cost ELSE 0 END) AS mnth07
  , SUM(CASE STRFTIME('%m', date) WHEN '08' THEN cost ELSE 0 END) AS mnth08
  , SUM(CASE STRFTIME('%m', date) WHEN '09' THEN cost ELSE 0 END) AS mnth09
  , SUM(CASE STRFTIME('%m', date) WHEN '10' THEN cost ELSE 0 END) AS mnth10
  , SUM(CASE STRFTIME('%m', date) WHEN '11' THEN cost ELSE 0 END) AS mnth11
  , SUM(CASE STRFTIME('%m', date) WHEN '12' THEN cost ELSE 0 END) AS mnth12
  , SUM(CASE STRFTIME('%m', date) WHEN '01' THEN cost ELSE 0 END) AS mnth01
  , SUM(CASE STRFTIME('%m', date) WHEN '02' THEN cost ELSE 0 END) AS mnth02
  , SUM(CASE STRFTIME('%m', date) WHEN '03' THEN cost ELSE 0 END) AS mnth03
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
