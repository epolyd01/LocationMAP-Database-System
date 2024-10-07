


CREATE PROC [dbo].Q10
AS
SELECT F.FloorID,F.Number AS [Floor Number],F.BuildID AS [Building Code],COUNT(P.POIsID) AS [Ammount of Pois]
FROM Floor AS F INNER JOIN POIs AS P ON F.FloorID = P.FloorID
GROUP BY F.Number,F.BuildID,F.FloorID
HAVING COUNT(P.POIsID) > ALL(
	SELECT AVG(P1.[pois_count])
	FROM(
		SELECT COUNT(P.POIsID) AS [pois_count]
		FROM POIs AS P INNER JOIN Floor AS F ON P.FloorID = F.FLoorID
		GROUP BY F.Number,F.BuildID,F.FloorID
		) AS P1
)
ORDER BY FloorID

