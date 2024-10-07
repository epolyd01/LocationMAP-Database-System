CREATE PROC [dbo].[Q17]

@Building_ID INT
AS
SELECT CONCAT('(',MIN(P.X),' , ',MAX(P.Y),')') AS [Point one],  CONCAT('(',MAX(P.X),' , ',MIN(P.Y),')') AS [Point two]
FROM POIs AS P INNER JOIN Floor  AS F  ON F.FloorID = P.FloorID
WHERE F.BuildID = @Building_ID



