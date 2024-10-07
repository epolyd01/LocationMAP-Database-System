CREATE PROCEDURE [dbo].Q15
AS

SELECT T.TypeID, T.Title as [Type of Object]
	FROM [Type] AS T
	WHERE NOT EXISTS (
		(SELECT F.FingerprintID
		FROM Fingerprint AS F)

	EXCEPT
		
		(SELECT A.FingerprintID 
		FROM (
			SELECT F.FingerprintID , O.TypeID
			FROM Fingerprint AS F 
			INNER JOIN Object AS O ON F.FingerprintID = O.FingerprintID
			INNER JOIN [Type] AS T ON T.TypeID = O.TypeID   
		)AS A
		WHERE T.TypeID = A.TypeID )
	)




GO