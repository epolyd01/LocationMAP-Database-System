CREATE PROCEDURE [dbo].[Q16]
@typeid int,
@x1 decimal(15,12),
@x2 decimal(15,12),
@y1 decimal(15,12),
@y2 decimal(15,12)

AS


DECLARE @maxX decimal(15,12)
DECLARE @minX decimal(15,12)
DECLARE @maxY decimal(15,12)
DECLARE @minY decimal(15,12)
SET @maxX=@x1
SET @maxY=@y1
SET @minX=@x2
SET @minY=@y2
if @maxX<@x2
	BEGIN
	 SET @maxX=@x2
	 SET @minX=@x1
	END
if @maxY<@y2
	BEGIN
	 SET @maxY=@y2
	 SET @minY=@y1
	END
SELECT COUNT(*)
FROM Object  AS O INNER JOIN Fingerprint AS F ON F.FingerprintID = O.FingerprintID
WHERE  O.TypeID = @typeid AND F.x<=@maxX AND F.x>=@minX AND F.y<=@maxY AND F.y>=@minY 

GO

