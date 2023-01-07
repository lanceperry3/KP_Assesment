

 
WITH phn_addr AS 
 (
   SELECT DISTINCT * 
   FROM
 (

	SELECT 
			p.NAME
		,p.MRN_NB
			,P.PRSN_IK	AS MAIN_PRSN_IK
			,phn.LNE_NB    
			,phn.USG_TYP 	AS hw
			,p.PRSN_IK

	FROM 
		PRSN					P
		LEFT JOIN 	PRSN_PHN	PHN	 	ON p.PRSN_IK = phn.PRSN_IK
	UNION ALL 
	SELECT 
			p.NAME
		,p.MRN_NB
			,P.PRSN_IK	AS MAIN_PRSN_IK
			,addr.LNE_NB
			,addr.addr_typ AS hw
			,p.PRSN_IK
	FROM 
			PRSN					P
		LEFT JOIN   PRSN_ADDR	ADDR	ON p.prsn_ik = addr.PRSN_IK
	) a
	WHERE lne_nb IS NOT NULL
),
joined AS
(
	SELECT 
		pa.NAME 
		,pa.MRN_NB 
		,pa.hw 			AS TYPE
		,phn.PHONE_NBR 	AS PHONE_NUMBER
		,addr.addr		AS ADDR
		,pa.PRSN_IK
	FROM 
			phn_addr 	pa 		
		LEFT JOIN PRSN_PHN	PHN	ON pa.hw = phn.USG_TYP 		AND pa.MAIN_PRSN_IK = phn.PRSN_IK
		LEFT JOIN PRSN_ADDR	ADDR	ON pa.hw = addr.addr_typ 	AND pa.MAIN_PRSN_IK = addr.PRSN_IK
)
SELECT 
	p.NAME 
        ,p.MRN_NB 
        ,CASE WHEN j.TYPE IS NULL 			THEN '(null)' 	ELSE j.TYPE 		END AS TYPE
        ,CASE WHEN j.PHONE_NUMBER IS NULL 	THEN 'N/A'		ELSE j.PHONE_NUMBER	END	AS PHONE_NUMBER
        ,CASE WHEN j.ADDR IS NULL 			THEN 'N/A'		ELSE j.ADDR   		END	AS ADDR
  	,CASE WHEN j.PHONE_NUMBER IS NOT NULL AND j.ADDR IS NOT NULL 		THEN 'MEMBER HAS BOTH'
              WHEN j.PHONE_NUMBER IS NULL AND j.ADDR IS NOT NULL 		THEN 'MEMBER HAS ADDR ONLY'
              WHEN j.PHONE_NUMBER IS NOT NULL AND j.ADDR IS NULL 		THEN 'MEMBER HAS PHONE ONLY'
              									ELSE 'MEMBER HAS NONE'	END 	AS COMMENT_TX
FROM 
	PRSN				P
        LEFT JOIN joined		j ON p.PRSN_IK = j.PRSN_IK
        
        
        
        
        
        
