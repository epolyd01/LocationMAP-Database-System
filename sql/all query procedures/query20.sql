
CREATE PROCEDURE [dbo].[Q20]
@k INT,
@floorID INT

AS



SELECT  P1.POIsID AS[POIS ID 1] , P2.POIsID AS [POIS ID 2]
FROM POIs P1,POIs P2
WHERE P1.FloorID=@floorID AND P2.FloorID=@floorID AND P1.POIsID!=P2.POIsID
AND SQRT(Power((P1.X-P2.X),2)+Power((P1.Y-P2.Y),2)) IN (
	SELECT TOP(@k)  SQRT(Power((P1.X-P3.X),2)+Power((P1.Y-P3.Y),2)) as apostasi
	FROM POIs P3
	WHERE P1.FloorID=@floorID AND P3.FloorID=@floorID AND P1.POIsID!=P3.POIsID
	ORDER BY apostasi
	)

