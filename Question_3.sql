--Question 3:	
--Write a query that return the phone number of the third youngest person(s) from the PRSN table (use analytic function if possible)	

SELECT 
	ao."NAME"
        ,CASE WHEN phn."USG_TYP" 	IS NULL THEN '(null)' ELSE phn."USG_TYP" 	END AS USG_TYP
        ,CASE WHEN phn."PHONE_NBR" 	IS NULL THEN '(null)' ELSE phn."PHONE_NBR" 	END AS PHONE_NBR
FROM        
	(
      SELECT

          DENSE_RANK () OVER (ORDER BY p."AGE" DESC) AS dr -- use dense rank so not to skip numbers in the rankings
          ,p."AGE"
          ,p."PRSN_IK"
          ,p."NAME"
      FROM 
      "PRSN"					P
    ) ao
     LEFT JOIN   "PRSN_PHN"	phn	ON ao."PRSN_IK" = phn."PRSN_IK"
WHERE	
		ao.dr = 3 -- limit the data to dense rank 3 to get the third youngest person(s)
