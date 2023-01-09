SELECT 
	ao."NAME"
        ,addr."ADDR"
FROM        
	(
      SELECT

          ROW_NUMBER () OVER (ORDER BY p."AGE" DESC) AS rn -- Add a row number descending by age leaving the oldest as row 1
          ,p."AGE"
          ,p."PRSN_IK"
          ,p."NAME"
      FROM 
      "PRSN"					P
    ) ao
     LEFT JOIN   "PRSN_ADDR"	ADDR	ON ao."PRSN_IK" = addr."PRSN_IK"
WHERE	
		ao.rn =1 -- pull only the first row which id the oldest person
