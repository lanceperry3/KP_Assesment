--Question 4:	
--Write a query that will return all person that has multiple addr or multiple phone number	

 
WITH phn_addr AS -- Combine 
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
		p.PRSN_IK 
    	,p.NAME
        ,p.AGE
        ,p.MRN_NB
FROM 
	PRSN				P
    LEFT JOIN joined	j ON p.PRSN_IK = j.PRSN_IK
GROUP BY     
        p.PRSN_IK 
    	,p.NAME
        ,p.AGE
        ,p.MRN_NB
HAVING
		COUNT(j.PHONE_NUMBER) =2 OR COUNT(ADDR) =2
        
        
        
        
        
