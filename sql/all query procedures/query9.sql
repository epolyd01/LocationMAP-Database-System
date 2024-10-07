
CREATE PROC [dbo].[Q9]
AS
BEGIN 
 DECLARE @fingerprints  int = (
	SELECT COUNT(*)
	FROM Fingerprint 
)
END 

SELECT OT.Title ,CAST((COUNT(*)*1.0/@fingerprints) AS DECIMAL(14,2)) AS Average
FROM (SELECT T.Title,T.TypeID, ISNULL(O.ObjectID,0) as [Object]
		FROM [Type] AS T LEFT JOIN [Object] AS O ON O.TypeID=T.TypeID
		
	) AS OT
GROUP BY OT.Title,OT.TypeID
ORDER BY  OT.TypeID

GO

