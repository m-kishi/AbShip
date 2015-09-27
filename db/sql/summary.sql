SELECT
    STRFTIME('%Y', date) AS year
  , STRFTIME('%m', date) AS mnth
  , SUM(CASE type WHEN 'FOOD' THEN cost ELSE 0 END) AS food
  , SUM(CASE type WHEN 'OTFD' THEN cost ELSE 0 END) AS otfd
  , SUM(CASE type WHEN 'GOOD' THEN cost ELSE 0 END) AS good
  , SUM(CASE type WHEN 'FRND' THEN cost ELSE 0 END) AS frnd
  , SUM(CASE type WHEN 'TRFC' THEN cost ELSE 0 END) AS trfc
  , SUM(CASE type WHEN 'PLAY' THEN cost ELSE 0 END) AS play
  , SUM(CASE type WHEN 'HOUS' THEN cost ELSE 0 END) AS hous
  , SUM(CASE type WHEN 'ENGY' THEN cost ELSE 0 END) AS engy
  , SUM(CASE type WHEN 'CNCT' THEN cost ELSE 0 END) AS cnct
  , SUM(CASE type WHEN 'MEDI' THEN cost ELSE 0 END) AS medi
  , SUM(CASE type WHEN 'INSU' THEN cost ELSE 0 END) AS insu
  , SUM(CASE type WHEN 'OTHR' THEN cost ELSE 0 END) AS othr
  , SUM(CASE type WHEN 'EARN' THEN cost ELSE 0 END) AS earn
  , SUM(CASE type WHEN 'BNUS' THEN cost ELSE 0 END) AS bnus
  , SUM(CASE type WHEN 'SPCL' THEN cost ELSE 0 END) AS spcl
  , SUM(CASE type WHEN 'PRVI' THEN cost ELSE 0 END) AS prvi
  , SUM(CASE type WHEN 'PRVO' THEN cost ELSE 0 END) AS prvo
  , SUM(CASE WHEN type NOT IN ('EARN','BNUS','SPCL','PRVI','PRVO') THEN cost ELSE 0 END) AS ttal
  , SUM(CASE WHEN type = 'EARN' THEN cost WHEN type NOT IN ('BNUS','SPCL','PRVI','PRVO') THEN -cost ELSE 0 END) AS blnc
FROM
    expenses
WHERE
    user_id = [user_id]
GROUP BY
    year
  , mnth
ORDER BY
    year
  , mnth
;

