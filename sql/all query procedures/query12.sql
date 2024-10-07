
CREATE procedure [dbo].[Q12]
AS

SELECT  DISTINCT F1.FingerprintID AS [FingerprintID 1] ,F2.FingerprintID AS [FingerprintID 2]
FROM FINGERPRINT F1, FINGERPRINT F2
WHERE  F1.FingerprintID!=F2.FingerprintID AND F1.FingerprintID>F2.FingerprintID  AND NOT EXISTS(
	SELECT O.TypeID
	FROM [OBJECT] O
	WHERE O.FingerprintID=F1.FingerprintID AND O.TypeID NOT IN(
		SELECT O2.TypeID 
		FROM [OBJECT] O2
		WHERE O2.FingerprintID=F2.FingerprintID
		)
		UNION ALL
		SELECT O.TypeID
		FROM [OBJECT] O
		WHERE O.FingerprintID=F2.FingerprintID AND O.TypeID NOT IN(
		SELECT O1.TypeID 
		FROM [OBJECT] O1 
		WHERE  O1.FingerprintID=F1.FingerprintID
		)
)


GO