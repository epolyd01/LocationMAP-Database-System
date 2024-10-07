USE [aanast04]
GO
/****** Object:  Table [dbo].[Building]    Script Date: 04-Dec-22 11:48:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Building](
	[Y] [decimal](15, 12) NOT NULL,
	[X] [decimal](15, 12) NOT NULL,
	[Address] [nvarchar](100) NOT NULL,
	[BCode] [nvarchar](10) NOT NULL,
	[CampusID] [int] NULL,
	[Small_Description] [nvarchar](300) NOT NULL,
	[Date_Of_Register] [date] NOT NULL,
	[Owner] [nvarchar](50) NULL,
	[BuildID] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Building] PRIMARY KEY CLUSTERED 
(
	[BuildID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [U_BCode] UNIQUE NONCLUSTERED 
(
	[BCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Campus]    Script Date: 04-Dec-22 11:48:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Campus](
	[URL] [nvarchar](120) NOT NULL,
	[CName] [nvarchar](70) NOT NULL,
	[Description] [nvarchar](150) NOT NULL,
	[Date_Of_Registration] [date] NOT NULL,
	[CampusID] [int] NOT NULL,
 CONSTRAINT [PK_Campus] PRIMARY KEY CLUSTERED 
(
	[CampusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [U_CName] UNIQUE NONCLUSTERED 
(
	[CName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fingerprint]    Script Date: 04-Dec-22 11:48:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fingerprint](
	[Date_Of_Register] [datetime] NOT NULL,
	[X] [decimal](15, 12) NOT NULL,
	[Y] [decimal](15, 12) NOT NULL,
	[Floor] [int] NOT NULL,
	[FingerprintID] [int] NOT NULL,
	[Seq_Num] [int] NOT NULL,
 CONSTRAINT [PK_Fingerprint] PRIMARY KEY CLUSTERED 
(
	[FingerprintID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Floor]    Script Date: 04-Dec-22 11:48:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Floor](
	[Small_Description] [nvarchar](150) NOT NULL,
	[Floorplan_File] [nvarchar](40) NOT NULL,
	[Number] [smallint] NOT NULL,
	[BuildID] [int] NOT NULL,
	[FloorID] [int] NOT NULL,
	[FName] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_Floor] PRIMARY KEY CLUSTERED 
(
	[FloorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Object]    Script Date: 04-Dec-22 11:48:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Object](
	[Height] [int] NOT NULL,
	[Width] [int] NOT NULL,
	[ObjectID] [int] NOT NULL,
	[FingerprintID] [int] NOT NULL,
	[TypeID] [int] NOT NULL,
	[Small_Description] [nvarchar](150) NOT NULL,
	[User_entry] [int] NOT NULL,
 CONSTRAINT [PK_Object] PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[POIs]    Script Date: 04-Dec-22 11:48:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[POIs](
	[POIsID] [int] NOT NULL,
	[Type] [nvarchar](40) NOT NULL,
	[Description] [nvarchar](4000) NULL,
	[POIName] [nvarchar](50) NULL,
	[X] [decimal](15, 12) NOT NULL,
	[Y] [decimal](15, 12) NOT NULL,
	[FloorID] [int] NOT NULL,
 CONSTRAINT [PK_POIs] PRIMARY KEY CLUSTERED 
(
	[POIsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Type]    Script Date: 04-Dec-22 11:48:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Type](
	[Title] [varchar](50) NOT NULL,
	[Model_Of_Origin] [nvarchar](50) NOT NULL,
	[User_entry] [int] NOT NULL,
	[TypeID] [int] NOT NULL,
 CONSTRAINT [PK_Type] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [U_Title] UNIQUE NONCLUSTERED 
(
	[Title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 04-Dec-22 11:48:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Password] [nvarchar](35) NOT NULL,
	[UserName] [nvarchar](20) NOT NULL,
	[ID] [int] NOT NULL,
	[Sex] [char](1) NOT NULL,
	[Seq_Num] [int] IDENTITY(1,1) NOT NULL,
	[Date_Of_Birth] [date] NOT NULL,
	[LName] [nvarchar](40) NOT NULL,
	[FName] [nvarchar](40) NOT NULL,
	[Type] [char](1) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Seq_Num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [U_ID] UNIQUE NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [U_Password] UNIQUE NONCLUSTERED 
(
	[Password] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [U_UserName] UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Building] ADD  CONSTRAINT [DF__Building__Date_O__361203C5]  DEFAULT (getdate()) FOR [Date_Of_Register]
GO
ALTER TABLE [dbo].[Campus] ADD  DEFAULT (getdate()) FOR [Date_Of_Registration]
GO
ALTER TABLE [dbo].[Fingerprint] ADD  DEFAULT (getdate()) FOR [Date_Of_Register]
GO
ALTER TABLE [dbo].[Building]  WITH CHECK ADD  CONSTRAINT [FK_Building_Campus] FOREIGN KEY([CampusID]) ON UPDATE CASCADE ON DELETE SET NULL
REFERENCES [dbo].[Campus] ([CampusID])
GO
ALTER TABLE [dbo].[Building] CHECK CONSTRAINT [FK_Building_Campus]
GO
ALTER TABLE [dbo].[Fingerprint]  WITH CHECK ADD  CONSTRAINT [FK_Fingerprint_User] FOREIGN KEY([Seq_Num]) ON UPDATE CASCADE
REFERENCES [dbo].[User] ([Seq_Num])
GO
ALTER TABLE [dbo].[Fingerprint] CHECK CONSTRAINT [FK_Fingerprint_User]
GO
ALTER TABLE [dbo].[Floor]  WITH CHECK ADD  CONSTRAINT [FK_Floor_Building] FOREIGN KEY([BuildID]) ON UPDATE CASCADE
REFERENCES [dbo].[Building] ([BuildID])
GO
ALTER TABLE [dbo].[Floor] CHECK CONSTRAINT [FK_Floor_Building]
GO
ALTER TABLE [dbo].[Object]  WITH CHECK ADD  CONSTRAINT [FK_Object_Fingerprint] FOREIGN KEY([FingerprintID]) ON UPDATE CASCADE
REFERENCES [dbo].[Fingerprint] ([FingerprintID])
GO
ALTER TABLE [dbo].[Object] CHECK CONSTRAINT [FK_Object_Fingerprint]
GO
ALTER TABLE [dbo].[Object]  WITH CHECK ADD  CONSTRAINT [FK_Object_Type] FOREIGN KEY([TypeID]) ON UPDATE CASCADE
REFERENCES [dbo].[Type] ([TypeID])
GO
ALTER TABLE [dbo].[Object] CHECK CONSTRAINT [FK_Object_Type]
GO
ALTER TABLE [dbo].[Object]  WITH CHECK ADD  CONSTRAINT [FK_Object_User] FOREIGN KEY([User_entry]) ON UPDATE CASCADE
REFERENCES [dbo].[User] ([Seq_Num])
GO
ALTER TABLE [dbo].[Object] CHECK CONSTRAINT [FK_Object_User]
GO
ALTER TABLE [dbo].[POIs]  WITH CHECK ADD  CONSTRAINT [FK_POIs_Floor] FOREIGN KEY([FloorID]) ON UPDATE CASCADE
REFERENCES [dbo].[Floor] ([FloorID])
GO
ALTER TABLE [dbo].[POIs] CHECK CONSTRAINT [FK_POIs_Floor]
GO
ALTER TABLE [dbo].[Type]  WITH CHECK ADD  CONSTRAINT [FK_Type_User] FOREIGN KEY([User_entry]) ON UPDATE CASCADE
REFERENCES [dbo].[User] ([Seq_Num])
GO
ALTER TABLE [dbo].[Type] CHECK CONSTRAINT [FK_Type_User]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD CHECK  (([Sex]='m' OR [Sex]='f' OR [Sex]='F' OR [Sex]='M'))
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD CHECK  (([Type]='3' OR [Type]='2' OR [Type]='1'))
GO
