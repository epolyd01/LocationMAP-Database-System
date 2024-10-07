USE [epolyd01]
GO
/****** Object:  StoredProcedure [dbo].[Q10]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[Q10]
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

GO
/****** Object:  StoredProcedure [dbo].[Q11]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Q11]

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
/****** Object:  StoredProcedure [dbo].[Q12]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Q12]
AS
SELECT  DISTINCT F1.FingerprintID AS [FingerprintID 1] ,F2.FingerprintID AS [FingerprintID 2]
FROM FINGERPRINT F1, FINGERPRINT F2
WHERE  F1.FingerprintID!=F2.FingerprintID AND F1.FingerprintID>F2.FingerprintID  AND NOT EXISTS(
	SELECT O.TypeID
	FROM [OBJECT] O
	WHERE O.FingerprintID=F1.FingerprintID AND O.TypeID NOT IN(
		SELECT O2.TypeID 
		FROM [OBJECT] O2
		WHERE O2.FingerprintID=F2.FingerprintID
		)
		UNION ALL
		SELECT O.TypeID
		FROM [OBJECT] O
		WHERE O.FingerprintID=F2.FingerprintID AND O.TypeID NOT IN(
		SELECT O1.TypeID 
		FROM [OBJECT] O1 
		WHERE  O1.FingerprintID=F1.FingerprintID
		)
)
GO
/****** Object:  StoredProcedure [dbo].[Q13]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Q13] (@FingerprintID int)
AS

SELECT DISTINCT F.FingerprintID
FROM Fingerprint AS F INNER JOIN Object AS O ON F.FingerprintID = O.FingerprintID
WHERE  F.FingerprintID != @FingerPrintID AND NOT EXISTS(
	( SELECT O.TypeID
	 FROM Fingerprint AS F1 INNER JOIN Object AS O ON F1.FingerprintID = O.FingerprintID
	 WHERE F1.FingerprintID  = @FingerprintID
	 )

	 EXCEPT

	 (SELECT O.TypeID
	 FROM Fingerprint AS F2 INNER JOIN Object AS O ON F2.FingerprintID = O.FingerprintID
	 WHERE F2.FingerprintID = F.FingerprintID AND  F2.FingerprintID != @FingerprintID)
)
ORDER BY F.FingerprintID

GO
/****** Object:  StoredProcedure [dbo].[Q14]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Q14]
@k int

AS

SELECT TOP(@k) T.Title,T.TypeID,COUNT( DISTINCT F.FingerprintID) AS Amount
FROM [Type] AS T
INNER JOIN [Object] AS O ON T.TypeID = O.TypeID 
INNER JOIN Fingerprint AS  F ON F.FingerprintID = O.FingerprintID
GROUP BY T.Title,T.TypeID 
ORDER BY T.TypeID


GO
/****** Object:  StoredProcedure [dbo].[Q15]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Q15]
AS

SELECT T.TypeID, T.Title as [Type of Object]
	FROM [Type] AS T
	WHERE NOT EXISTS (
		(SELECT F.FingerprintID
		FROM Fingerprint AS F)

	EXCEPT
		
		(SELECT A.FingerprintID 
		FROM (
			SELECT F.FingerprintID , O.TypeID
			FROM Fingerprint AS F 
			INNER JOIN Object AS O ON F.FingerprintID = O.FingerprintID
			INNER JOIN [Type] AS T ON T.TypeID = O.TypeID   
		)AS A
		WHERE T.TypeID = A.TypeID )
	)


GO
/****** Object:  StoredProcedure [dbo].[Q16]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
/****** Object:  StoredProcedure [dbo].[Q17]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Q17]

@Building_ID INT
AS
SELECT CONCAT('(',MIN(P.X),' , ',MAX(P.Y),')') AS [Point one],  CONCAT('(',MAX(P.X),' , ',MIN(P.Y),')') AS [Point two]
FROM POIs AS P INNER JOIN Floor  AS F  ON F.FloorID = P.FloorID
WHERE F.BuildID = @Building_ID



GO
/****** Object:  StoredProcedure [dbo].[Q18]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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
GO
/****** Object:  StoredProcedure [dbo].[Q19]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE[dbo].[Q19]

@k int,
@x decimal(15,12),
@y decimal(15,12),
@floor_number int

AS

DECLARE @z INT


SET @z=3 * @floor_number

SELECT	P.POIsID, P.POIName ,  CONCAT('(',P.X, ',' ,P.Y,')') AS [(X,Y)],SQRT( POWER( (P.X - @x),2) + POWER( (P.Y - @y),2) +  POWER( (F.Number*3-@z),2)) AS [Apostasi]
FROM POIs P INNER JOIN Floor F ON P.FloorID = F.FloorID
WHERE (P.X!=@x OR P.Y!=@y or F.Number!=@floor_number) AND SQRT( POWER( (P.X - @x),2) + POWER( (P.Y - @y),2) +  POWER( (F.Number*3-@z),2)) IN (


SELECT TOP(@k) apostasi
  FROM (
	SELECT SQRT( POWER( (P.X - @x),2) + POWER( (P.Y - @y),2) +  POWER( (F.Number*3)-@z,2)) as apostasi
	FROM POIs P INNER JOIN Floor F ON P.FloorID = F.FloorID
	WHERE (P.X!=@x OR P.Y!=@y or F.Number!=@floor_number)) AS P1
	order by apostasi 
)

GO
/****** Object:  StoredProcedure [dbo].[Q1Edit]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Q1Edit]
  @Password VARCHAR(35) ,
  @UserName VARCHAR(20) ,
  @ID INT ,
  @Sex CHAR(1) ,
  @Date_Of_Birth DATE ,
  @LName VARCHAR(40) ,
  @FName VARCHAR(40) ,
  @Type INT,
  @SelectedUsername VARCHAR(20)


AS
BEGIN

    UPDATE [dbo].[User]
SET 
	[Password] =  @Password,
	[Username] =  @Username,
	[ID] =  @ID,
	[Sex] = @Sex,
	[Date_Of_Birth] = @Date_Of_Birth,
	[LName] = @LName,
	[FName] = @FName,
	[Type] = @Type
	WHERE [UserName] = @SelectedUsername 
END
GO
/****** Object:  StoredProcedure [dbo].[Q1Insert]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Q1Insert]
  @Password VARCHAR(35) ,
  @UserName VARCHAR(20) ,
  @ID INT ,
  @Sex CHAR(1) ,
  @Date_Of_Birth DATE ,
  @LName VARCHAR(40) ,
  @FName VARCHAR(40) ,
  @Type CHAR(1) 

AS
BEGIN

    INSERT [dbo].[User]
        ([Password],[Username] ,[ID],[Sex],[Date_Of_Birth], [LName],[FName], [Type])
    VALUES
        ( @Password, @Username, @ID , @Sex, @Date_Of_Birth, @LName,@FName, @Type)

END
GO
/****** Object:  StoredProcedure [dbo].[Q1View]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Q1View]
AS
BEGIN
    SELECT [Password],[UserName],[ID],[Sex],CAST([Date_of_birth] AS varchar(15))AS [Date of Birth],[LName] AS [Last Name],[FName] AS [First Name],[Type] AS [Role]
    FROM [dbo].[User]
END
GO
/****** Object:  StoredProcedure [dbo].[Q20]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Q20]
@k INT,
@floorID INT

AS



SELECT   P1.POIsID AS[POIS ID 1] , P2.POIsID AS [POIS ID 2]
FROM POIs P1,POIs P2
WHERE P1.FloorID=@floorID AND P2.FloorID=@floorID AND P1.POIsID!=P2.POIsID
AND SQRT(Power((P1.X-P2.X),2)+Power((P1.Y-P2.Y),2)) IN (
	SELECT TOP(@k)  SQRT(Power((P1.X-P3.X),2)+Power((P1.Y-P3.Y),2)) as apostasi
	FROM POIs P3
	WHERE P1.FloorID=@floorID AND P3.FloorID=@floorID AND P1.POIsID!=P3.POIsID
	ORDER BY apostasi
	)

GO
/****** Object:  StoredProcedure [dbo].[Q20V2]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Q20V2]
@k INT,
@floorID INT

AS

SELECT   P1.POIsID AS[POIS ID 1] , P2.POIsID AS [POIS ID 2], SQRT(Power((P1.X-P2.X),2)+Power((P1.Y-P2.Y),2)) as [Apostasi]
FROM POIs P1,POIs P2
WHERE  P1.POIsID>P2.POIsID AND SQRT(Power((P1.X-P2.X),2)+Power((P1.Y-P2.Y),2)) IN(
SELECT  TOP(@k) SQRT(Power((P1.X-P2.X),2)+Power((P1.Y-P2.Y),2)) as apostasi
FROM POIs P1,POIs P2
WHERE P1.FloorID=@floorID AND P2.FloorID=@floorID AND P1.POIsID!=P2.POIsID 
ORDER BY apostasi
	
)
GO
/****** Object:  StoredProcedure [dbo].[Q21]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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


SELECT [path],[level],cte.[Object Amount]
FROM cte 
where cycle=0


END
DROP TABLE #temp






GO
/****** Object:  StoredProcedure [dbo].[Q2DeleteType]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Q2DeleteType]
@ID int

AS

DELETE from [TYPE]
WHERE [Type].TypeID = @ID
GO
/****** Object:  StoredProcedure [dbo].[Q2EditType]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Q2EditType]
  @Title VARCHAR(20),
  @Model_Of_Origin NVARCHAR(30),
  @TypeID INT,
  @User_entry INT,
  @Selected_type VARCHAR(20)


AS
BEGIN

    UPDATE [dbo].[Type]
SET 
     [Title]=@Title,
	 [Model_Of_Origin] = @Model_Of_Origin,
	 [TypeID] = @TypeID,
	 [User_entry] = @User_entry
	WHERE [Title] = @Selected_type 
END
GO
/****** Object:  StoredProcedure [dbo].[Q2InsertType]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Q2InsertType]
  @Title VARCHAR(20),
  @Model_Of_Origin NVARCHAR(30),
  @TypeID INT,
  @User_entry INT
AS
BEGIN

    INSERT INTO  [dbo].[Type]
        ( [TypeID]  ,[Title],[Model_Of_Origin], [User_entry])
    VALUES
        (  @TypeID, @Title, @Model_Of_Origin,@User_entry)

END


GO
/****** Object:  StoredProcedure [dbo].[Q2ViewTypes]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Q2ViewTypes] 
AS
SELECT *
FROM [Type] 
GO
/****** Object:  StoredProcedure [dbo].[Q3DeleteObject]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Q3DeleteObject]
@OID int

AS

DELETE from [Object]
WHERE [Object].ObjectID = @OID
GO
/****** Object:  StoredProcedure [dbo].[Q3InsertFingerprint]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Q3InsertFingerprint]
  @Date_Of_Register DATETIME ,
  @X DECIMAL(15,12) ,
  @Y DECIMAL(15,12) ,
  @Floor INT ,
  @FingerprintID INT ,
  @Seq_Num INT

AS
BEGIN

    INSERT [dbo].[Fingerprint]
        ([Date_Of_Register] ,X,Y,[Floor], FingerprintID,[Seq_Num])
    VALUES
        (  @Date_Of_Register, @X, @Y , @Floor, @FingerprintID, @Seq_Num)

END
GO
/****** Object:  StoredProcedure [dbo].[Q3InsertObject]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Q3InsertObject]
	@Height INT,
	@Width INT,
	@ObjectID INT,
	@FingerprintID INT,
	@TypeID INT,
	@Des NVARCHAR(150),
	@User INT

	AS
	INSERT INTO [dbo].[Object]
           ([Height]
           ,[Width]
           ,[ObjectID]
           ,[FingerprintID]
           ,[TypeID]
           ,[Small_Description]
           ,[User_entry])
     VALUES
           (@Height
           ,@Width
           ,@ObjectID
           ,@FingerprintID
           ,@TypeID
           ,@Des
           ,@User)
GO
/****** Object:  StoredProcedure [dbo].[Q3ViewFingerpint]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Q3ViewFingerpint]
AS

SELECT CAST(F.[Date_Of_Register] AS VARCHAR(50)) as [Date Of Register], F.X,F.Y,F.Floor,F.FingerprintID,F.Seq_Num AS [User entry]
FROM Fingerprint F
GO
/****** Object:  StoredProcedure [dbo].[Q4DeleteFloor]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Q4DeleteFloor]
@id int
as
DELETE Floor
where FloorID=@id
GO
/****** Object:  StoredProcedure [dbo].[Q4DeletePois]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Q4DeletePois]
@poisID int
as

DELETE POIs
where POIsID = @poisID
GO
/****** Object:  StoredProcedure [dbo].[Q4InsertFloor]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[Q4InsertFloor]

@id INT,
@name NVARCHAR(30),
@number INT,
@file NVARCHAR(40),
@des NVARCHAR(150),
@bid INT

AS

INSERT INTO Floor 
([FloorID],FName,Number,Floorplan_File,Small_Description,BuildID)
VALUES
(@id,@name,@number,@file,@des,@bid)
GO
/****** Object:  StoredProcedure [dbo].[Q4InsertPois]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Q4InsertPois]
@id int,
@name nvarchar(50),
@type nvarchar(40),
@x Decimal(15,12),
@y DECIMAL(15,12),
@des nvarchar(4000),
@fid int

as


INSERT INTO POIs
(POIsID,POIName,Type,X,Y,[Description],FloorID)
VALUES(@id,@name,@type,@x,@y,@des,@fid)
GO
/****** Object:  StoredProcedure [dbo].[Q5DeleteBuilding]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Q5DeleteBuilding] 
@bid INT
AS
DELETE [Building]
WHERE BuildID = @bid
GO
/****** Object:  StoredProcedure [dbo].[Q5InsertBuilding]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Q5InsertBuilding]
	@BCode NVARCHAR(10),
	@ID INT,
	@X DECIMAL(15,12),
	@Y DECIMAL(15,12),
	@Address NVARCHAR(100),
	@Des NVARCHAR(300),
	@Date DATE,
	@Owner NVARCHAR(50)

	AS
	INSERT INTO [dbo].[Building]
           ([BCode]
           ,BuildID
           ,X
           ,Y
           ,[Address]
           ,[Small_Description]
		   ,[Date_Of_Register]
           ,[Owner])
     VALUES
           (@BCode
           ,@ID
           ,@X
           ,@Y
           ,@Address
           ,@Des
           ,@Date
		   ,NULLIF(@Owner,'')
		   )
GO
/****** Object:  StoredProcedure [dbo].[Q5InsertCampus]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Q5InsertCampus]
@CName NVARCHAR(70),
@ID INT,
@D NVARCHAR(150),
@Date DATE,
@URL NVARCHAR(120)

AS

INSERT INTO  CAMPUS(CName,CampusID,[Description],[Date_Of_Registration],URL)
	VALUES(@CName,@ID,@D,@Date,@URL)
GO
/****** Object:  StoredProcedure [dbo].[Q6]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Q6]

AS
   SELECT F.FingerprintID, F.Floor, F.X,F.Y, Count(O.ObjectID) AS [Total of Objects]
    FROM Fingerprint AS F INNER JOIN [Object] AS O ON F.FingerprintID =  O.FingerprintID
    GROUP BY F.FingerprintID,F.Floor, F.X,F.Y
    ORDER BY Count(*)


GO
/****** Object:  StoredProcedure [dbo].[Q7]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



 CREATE PROCEDURE [dbo].[Q7]

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
/****** Object:  StoredProcedure [dbo].[Q8]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Q8]

AS

SELECT F.FloorID, P.[Type] AS [POI Type], COUNT(*) AS [Total of POIs]
FROM Pois AS P
INNER JOIN FLOOR AS F ON P.FloorID = F.FloorID
GROUP BY  F.FloorID, P.[Type]
ORDER BY F.FloorID ASC

GO
/****** Object:  StoredProcedure [dbo].[Q9]    Script Date: 05-Dec-22 12:13:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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
