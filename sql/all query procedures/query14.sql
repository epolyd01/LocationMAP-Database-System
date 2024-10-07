CREATE PROCEDURE [dbo].[Q14]
@k int

AS

SELECT TOP(@k) T.Title,T.TypeID,COUNT( DISTINCT F.FingerprintID) AS Amount
FROM [Type] AS T
INNER JOIN [Object] AS O ON T.TypeID = O.TypeID 
INNER JOIN Fingerprint AS  F ON F.FingerprintID = O.FingerprintID
GROUP BY T.Title,T.TypeID 
ORDER BY T.TypeID