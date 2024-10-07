USE [epolyd01]
GO
/****** Object:  StoredProcedure [dbo].[Q4DeleteFloor]    Script Date: 05-Dec-22 12:22:56 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Q4DeletePois]    Script Date: 05-Dec-22 12:22:56 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Q4InsertFloor]    Script Date: 05-Dec-22 12:22:56 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Q4InsertPois]    Script Date: 05-Dec-22 12:22:56 AM ******/
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
