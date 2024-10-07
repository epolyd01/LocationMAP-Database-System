USE [epolyd01]
GO
/****** Object:  StoredProcedure [dbo].[Q2DeleteType]    Script Date: 05-Dec-22 12:22:04 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Q2EditType]    Script Date: 05-Dec-22 12:22:04 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Q2InsertType]    Script Date: 05-Dec-22 12:22:04 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Q2ViewTypes]    Script Date: 05-Dec-22 12:22:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Q2ViewTypes] 
AS
SELECT *
FROM [Type] 
GO
