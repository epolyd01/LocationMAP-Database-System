CREATE PROC [dbo].Q11

AS

SELECT	F.FloorID,F.Number AS [Floor Number], F.BuildID AS [Building Code] 
FROM Floor AS F INNER JOIN POIs AS P ON F.FloorID = P.FloorID	
Group by F.Number,F.BuildID,F.FloorID
HAVING COUNT(P.POIsID) = (
	SELECT MIN(F1.[pois_counter])
	FROM (
		SELECT COUNT(P.POIsID) as [pois_counter]
		FROM Floor AS F INNER JOIN POIs AS P ON F.FloorID = P.FloorID
		GROUP BY F.Number,F.BuildID
		)AS F1
)




GO