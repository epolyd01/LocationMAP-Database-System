USE [epolyd01]
GO
/****** Object:  StoredProcedure [dbo].[Q1Edit]    Script Date: 05-Dec-22 12:21:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Q1Insert]    Script Date: 05-Dec-22 12:21:29 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Q1View]    Script Date: 05-Dec-22 12:21:29 AM ******/
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
