
 CREATE PROCEDURE [dbo].Q7

 AS

 SELECT	O.TypeID,T.Title
FROM Fingerprint AS F 
INNER JOIN Object AS O  ON F.FingerprintID = O.FingerprintID
INNER JOIN Type AS T ON T.TypeID = O.TypeID 
Group by O.TypeID,T.Title
HAVING COUNT(O.TypeID) = ALL(
	SELECT MAX(T1.[type_counter])
	FROM (
		SELECT COUNT(O.TypeID) as [type_counter]
		FROM Fingerprint AS F 
		INNER JOIN Object AS O  ON F.FingerprintID = O.FingerprintID
		INNER JOIN Type AS T ON T.TypeID = O.TypeID	
		GROUP BY O.TypeID
		)AS T1
)

GO

