
CREATE PROCEDURE [dbo].[Q21](
    @fID int,
	@x decimal (15,12)
    )

AS
SELECT f.FingerprintID,f.Floor,f.X,f.Y, COUNT(O.ObjectID) AS [Object Amount]
INTO #temp
FROM Fingerprint f INNER JOIN Object O ON f.FingerprintID=O.FingerprintID
GROUP BY f.FingerprintID,f.Floor,f.X,f.Y
BEGIN
WITH cte AS (
    SELECT  f.FingerprintID,f.Floor,f.X,f.Y,cast(',' + cast(f.FingerprintID as varchar(10)) + ',' as varchar(max)) as  Path, 0 AS [cycle]  , 0 AS [level], f.[Object Amount]
    FROM #temp f 
    WHERE  f.FingerprintID = @fID 

    UNION ALL
 
    SELECT  f.FingerprintID,f.Floor,f.X,f.Y,c.Path + cast(f.FingerprintID as varchar(10)) + ',',
         case when (c.Path like '%,'+cast(f.FingerprintID as varchar(10))+',%') 
           then 1
           else 0 
         end as [cycle], c.level+1 as [level], (f.[Object Amount]+c.[Object Amount]) AS [Object Amount]
    FROM #temp f ,cte AS c 
	WHERE c.cycle=0 AND c.level<=30 AND f.Floor= c.Floor AND SQRT(POWER(f.X-c.X,2)+POWER(f.Y-c.Y,2))<@x
	
)


SELECT path,level,cte.[Object Amount]
FROM cte 
where cycle=0


END
DROP TABLE #temp