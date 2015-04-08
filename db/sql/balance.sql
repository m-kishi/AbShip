SELECT
    CASE WHEN STRFTIME('%m', date) > '03'
      THEN
        STRFTIME('%Y', date) + 0
      ELSE
        STRFTIME('%Y', date) - 1
    END                                                                    AS year
  , SUM(CASE type WHEN 'EARN' THEN cost ELSE 0 END)                        AS earn
  , SUM(CASE type WHEN 'BNUS' THEN cost ELSE 0 END)                        AS bnus
  , SUM(CASE WHEN type NOT IN ('EARN','BNUS','SPCL') THEN cost ELSE 0 END) AS expense
  , SUM(CASE type WHEN 'SPCL' THEN cost ELSE 0 END)                        AS special
  , SUM(CASE WHEN type IN ('EARN','BNUS') THEN cost ELSE -cost END)        AS balance
FROM
    expenses
WHERE
    type NOT IN ('PRVI','PRVO')
GROUP BY
    year
UNION ALL
SELECT
    9999                                                                   AS year
  , SUM(CASE type WHEN 'EARN' THEN cost ELSE 0 END)                        AS earn
  , SUM(CASE type WHEN 'BNUS' THEN cost ELSE 0 END)                        AS bnus
  , SUM(CASE WHEN type NOT IN ('EARN','BNUS','SPCL') THEN cost ELSE 0 END) AS expense
  , SUM(CASE type WHEN 'SPCL' THEN cost ELSE 0 END)                        AS special
  , SUM(CASE WHEN type IN ('EARN','BNUS') THEN cost ELSE -cost END)        AS balance
FROM
    expenses
WHERE
    type NOT IN ('PRVI','PRVO')
ORDER BY
    year
;
