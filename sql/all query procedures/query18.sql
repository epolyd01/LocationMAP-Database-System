CREATE PROCEDURE [dbo].[Q18]

@x DECIMAL(15,12),
@y DECIMAL(15,12),
@floor_number int

AS
DECLARE @z int


SET @z=3 * @floor_number

SELECT  P.POIsID, P.POIName,CONCAT('(',P.X, ' , ' ,P.Y,')') AS [Point],SQRT( POWER( (P.X - @x),2) + POWER( (P.Y - @y),2) +  POWER( (F.Number*3-@z),2)) AS [Apostasi]
FROM POIs P INNER JOIN Floor F ON P.FloorID = F.FloorID
WHERE (P.X!=@x OR P.Y!=@y or F.Number!=@floor_number) AND SQRT( POWER( (P.X - @x),2) + POWER( (P.Y - @y),2) +  POWER( (F.Number*3-@z),2)) = (

SELECT MIN( apostasi )
 FROM (
SELECT SQRT( POWER( (P.X - @x),2) + POWER( (P.Y - @y),2) +  POWER( (F.Number*3)-@z,2)) as apostasi
FROM POIs P INNER JOIN Floor F ON P.FloorID = F.FloorID) AS P1
WHERE (P.X!=@x OR P.Y!=@y or F.Number!=@floor_number)
)