USE [epolyd01]
GO
/****** Object:  StoredProcedure [dbo].[Q5DeleteBuilding]    Script Date: 05-Dec-22 12:24:13 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Q5InsertBuilding]    Script Date: 05-Dec-22 12:24:13 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Q5InsertCampus]    Script Date: 05-Dec-22 12:24:13 AM ******/
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
