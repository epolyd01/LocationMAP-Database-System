
CREATE PROCEDURE [dbo].[Q8]

AS

SELECT F.FloorID, P.[Type] AS [POI Type], COUNT(*) AS [Total of POIs]
FROM Pois AS P
INNER JOIN FLOOR AS F ON P.FloorID = F.FloorID
GROUP BY  F.FloorID, P.[Type]
ORDER BY F.FloorID ASC

GO