USE [epolyd01]
GO
/****** Object:  StoredProcedure [dbo].[Q3DeleteObject]    Script Date: 05-Dec-22 12:22:33 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Q3InsertFingerprint]    Script Date: 05-Dec-22 12:22:33 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Q3InsertObject]    Script Date: 05-Dec-22 12:22:33 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Q3ViewFingerpint]    Script Date: 05-Dec-22 12:22:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Q3ViewFingerpint]
AS

SELECT CAST(F.[Date_Of_Register] AS VARCHAR(50)) as [Date Of Register], F.X,F.Y,F.Floor,F.FingerprintID,F.Seq_Num AS [User entry]
FROM Fingerprint F
GO
