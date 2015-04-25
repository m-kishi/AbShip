SELECT
    STRFTIME('%Y', date) AS year
  , STRFTIME('%m', date) AS mnth
  , SUM(CASE type WHEN 'FOOD'   THEN cost ELSE 0 END) AS food
  , SUM(CASE type WHEN 'OTFD'   THEN cost ELSE 0 END) AS otfd
  , SUM(CASE name WHEN '電気代' THEN cost ELSE 0 END) AS engy_elc
  , SUM(CASE name WHEN 'ガス代' THEN cost ELSE 0 END) AS engy_gas
  , SUM(CASE name WHEN '水道代' THEN cost ELSE 0 END) AS engy_wtr
FROM
    expenses
GROUP BY
    year
  , mnth
ORDER BY
    year
  , mnth
;

