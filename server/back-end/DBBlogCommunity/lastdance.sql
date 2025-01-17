USE [Blog_Community]
GO
/****** Object:  StoredProcedure [dbo].[Get_Story_Of_Friends]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_Story_Of_Friends] @idUserParams nvarchar(128)
AS
Declare @IdUser nvarchar (128)
set @IdUser = @idUserParams

select stories.*, acc.* from USERSTORIES as stories, USERINFO as acc
where stories.IdUser = acc.IdUser AND  stories.IdUser IN (select IdUserFriend from FRIENDS as f where f.IdUser = @IdUser)
AND DATEDIFF(MI,stories.CreatedTS,GETUTCDATE()) < 1440 


GO
/****** Object:  StoredProcedure [dbo].[Get_Story_Of_User]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_Story_Of_User] @idUser nvarchar(128)
AS
SELECT * FROM USERSTORIES
WHERE IdUser = @idUser AND  DATEDIFF(MI,CreatedTS,GETUTCDATE()) < 1440
GO
/****** Object:  StoredProcedure [dbo].[List_Image_In_Post]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[List_Image_In_Post]  @IdUserParams NVARCHAR(128), @StatusParams TINYINT
AS

Declare @IdUser nvarchar (128)
set @IdUser = @IdUserParams

Declare @Status nvarchar (128)
set @Status = @StatusParams

BEGIN

select * from IMAGEPOST as b
where b.IdPost IN
(select a.IdPost from NEWFEEDPOST as a where a.IdUser = @IdUser AND a.Status = @StatusParams)

END
GO
/****** Object:  StoredProcedure [dbo].[Quantity_Image_In_Post]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[Quantity_Image_In_Post] @IdUserParams NVARCHAR(128)
AS
Declare @IdUser nvarchar (128)
set @IdUser = @IdUserParams

BEGIN

select * from IMAGEPOST as a , NEWFEEDPOST as b 
where a.IdPost = b.IdPost And b.IdUser = @IdUserParams

END


GO
/****** Object:  StoredProcedure [dbo].[test_get_story_friends]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[test_get_story_friends] @idUserParams nvarchar(128)
as
Declare @IdUser nvarchar (128)
set @IdUser = @idUserParams

select stories.*, acc.* from USERSTORIES as stories, USERINFO as acc
where stories.IdUser = acc.IdUser AND  stories.IdUser IN (select IdUserFriend from FRIENDS as f where f.IdUser = @IdUser)
AND DATEDIFF(MI,stories.CreatedTS,GETUTCDATE()) < 1440 

GO
/****** Object:  Table [dbo].[ALBUMIMAGES]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALBUMIMAGES](
	[IdAlbumImage] [nvarchar](128) NOT NULL,
	[IdMedia] [nvarchar](128) NOT NULL,
	[AlbumName] [nvarchar](100) NULL,
	[CreatedTS] [datetime] NULL,
	[Quantity] [int] NULL,
	[ContentAlbum] [nvarchar](100) NULL,
	[UpdatedTS] [datetime] NULL,
	[Cover] [nvarchar](max) NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdAlbumImage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ALBUMMUSIC]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALBUMMUSIC](
	[IdAlbumMusic] [nvarchar](128) NOT NULL,
	[IdMedia] [nvarchar](128) NOT NULL,
	[AlbumMusicName] [nvarchar](100) NULL,
	[CreatedTS] [datetime] NULL,
	[Quantity] [int] NULL,
	[ContentAlbumMusic] [nvarchar](100) NULL,
	[Cover] [nvarchar](max) NULL,
	[UpdatedTS] [datetime2](7) NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdAlbumMusic] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ALBUMVIDEOS]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALBUMVIDEOS](
	[IdAlbumVideo] [nvarchar](128) NOT NULL,
	[IdMedia] [nvarchar](128) NOT NULL,
	[AlbumVideoName] [nvarchar](100) NULL,
	[CreatedTS] [datetime] NULL,
	[Quantity] [int] NULL,
	[ContentAlbumVideo] [nvarchar](100) NULL,
	[Cover] [nvarchar](max) NULL,
	[UpdatedTS] [datetime2](7) NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdAlbumVideo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CATEGORY]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORY](
	[IdCategory] [int] IDENTITY(1,1) NOT NULL,
	[NameCategory] [nvarchar](100) NULL,
	[IntroCategory] [nvarchar](max) NULL,
	[CoverCategoryUrl] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCategory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[COMMENT]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COMMENT](
	[IdComment] [nvarchar](128) NOT NULL,
	[IdPost] [nvarchar](128) NOT NULL,
	[IdUser] [nvarchar](128) NOT NULL,
	[Content] [nvarchar](max) NULL,
	[CreatedTS] [datetime] NULL,
	[UpdatedTS] [datetime] NULL,
	[Images] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdComment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FOLLOWS]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FOLLOWS](
	[IdUser] [nvarchar](128) NOT NULL,
	[IdUserRequest] [nvarchar](128) NOT NULL,
	[CreateTS] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUser] ASC,
	[IdUserRequest] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FRIENDS]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FRIENDS](
	[IdUser] [nvarchar](128) NOT NULL,
	[IdUserFriend] [nvarchar](128) NOT NULL,
	[CreateTS] [datetime2](7) NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUser] ASC,
	[IdUserFriend] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IMAGEPOST]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IMAGEPOST](
	[IdImage] [nvarchar](128) NOT NULL,
	[IdPost] [nvarchar](128) NOT NULL,
	[ImagesUrl] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdImage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IMAGES]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IMAGES](
	[IdImage] [nvarchar](128) NOT NULL,
	[IdAlbumImage] [nvarchar](128) NOT NULL,
	[ContentImage] [nvarchar](max) NULL,
	[LinkUrl] [nvarchar](max) NULL,
	[CreatedTS] [datetime] NULL,
	[UpdatedTS] [datetime] NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdImage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[INTROSTUDY]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[INTROSTUDY](
	[IdStudy] [nvarchar](128) NOT NULL,
	[IdUserIntro] [nvarchar](128) NULL,
	[Studying] [nvarchar](500) NULL,
	[StudyFrom] [char](4) NULL,
	[StudyTo] [char](4) NULL,
	[IDStatusSocial] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdStudy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[INTROWORKING]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[INTROWORKING](
	[IdWorking] [nvarchar](128) NOT NULL,
	[IdUserIntro] [nvarchar](128) NULL,
	[WorkingAt] [nvarchar](500) NULL,
	[WorkFrom] [char](4) NULL,
	[WorkTo] [char](4) NULL,
	[IDStatusSocial] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdWorking] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LIKECOMMENT]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LIKECOMMENT](
	[IdComment] [nvarchar](128) NOT NULL,
	[IdUser] [nvarchar](128) NOT NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdComment] ASC,
	[IdUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LIKEPOST]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LIKEPOST](
	[IdPost] [nvarchar](128) NOT NULL,
	[IdUser] [nvarchar](128) NOT NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPost] ASC,
	[IdUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LIKEREPLYCOMMENT]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LIKEREPLYCOMMENT](
	[IdReply] [nvarchar](128) NOT NULL,
	[IdUser] [nvarchar](128) NOT NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdReply] ASC,
	[IdUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MUSICLISTENS]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MUSICLISTENS](
	[IdMusic] [nvarchar](128) NOT NULL,
	[CreatedTS] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdMusic] ASC,
	[CreatedTS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MUSICS]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MUSICS](
	[IdMusic] [nvarchar](128) NOT NULL,
	[IdAlbumMusic] [nvarchar](128) NOT NULL,
	[ContentMusic] [nvarchar](max) NULL,
	[LinkUrl] [nvarchar](max) NULL,
	[CreatedTS] [datetime] NULL,
	[UpdatedTS] [datetime] NULL,
	[MusicName] [nvarchar](256) NULL,
	[Singer] [nvarchar](100) NULL,
	[Cover] [nvarchar](max) NULL,
	[Time] [char](20) NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdMusic] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NEWFEEDPOST]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NEWFEEDPOST](
	[IdPost] [nvarchar](128) NOT NULL,
	[IdUser] [nvarchar](128) NOT NULL,
	[IdCategory] [int] NOT NULL,
	[Content] [nvarchar](max) NULL,
	[CreatedTS] [datetime] NULL,
	[UploadedTS] [datetime] NULL,
	[Location] [nvarchar](200) NULL,
	[TimeStampSort] [datetime] NULL,
	[Images] [nvarchar](max) NULL,
	[Emotion] [tinyint] NULL,
	[SharePost] [nvarchar](128) NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPost] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NOTIFYSETTING]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NOTIFYSETTING](
	[IdNotifySetting] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Descriptions] [nvarchar](max) NULL,
	[StatusNotify] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdNotifySetting] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NOTIFYTYPE]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NOTIFYTYPE](
	[IdNotifyType] [int] IDENTITY(1,1) NOT NULL,
	[Value] [tinyint] NULL,
	[Discription] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdNotifyType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[REPLYCOMMENT]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REPLYCOMMENT](
	[IdReply] [nvarchar](128) NOT NULL,
	[IdComment] [nvarchar](128) NULL,
	[IdUser] [nvarchar](128) NULL,
	[Content] [nvarchar](max) NULL,
	[CreatedTS] [datetime2](7) NULL,
	[UpdatedTS] [datetime2](7) NULL,
	[Images] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdReply] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[REQUESTFRIENDS]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REQUESTFRIENDS](
	[IdUser] [nvarchar](128) NOT NULL,
	[IdUserRequest] [nvarchar](128) NOT NULL,
	[CreateTS] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUser] ASC,
	[IdUserRequest] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[STATUSSOCIAL]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[STATUSSOCIAL](
	[IdStatusSocial] [tinyint] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdStatusSocial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[STORYSEEN]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STORYSEEN](
	[IdStory] [nvarchar](128) NOT NULL,
	[IdUser] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_STORYSEEN] PRIMARY KEY CLUSTERED 
(
	[IdStory] ASC,
	[IdUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[USERACCOUNT]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[USERACCOUNT](
	[IdUser] [nvarchar](128) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[PasswordHash] [nvarchar](max) NOT NULL,
	[PasswordSalt] [nvarchar](max) NOT NULL,
	[DateOfBirth] [date] NULL,
	[LastUpdatedTS] [datetime] NULL,
	[CreatedTS] [datetime] NOT NULL,
	[StatusAccount] [tinyint] NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NULL,
	[PhoneNumber] [varchar](50) NULL,
	[PhoneNumberConfirmed] [bit] NULL,
	[TwoFactorEnabled] [bit] NULL,
	[AccessFailedCount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[USERADDRESS]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[USERADDRESS](
	[IdUserAddress] [nvarchar](128) NOT NULL,
	[IdUser] [nvarchar](128) NOT NULL,
	[City] [nvarchar](50) NULL,
	[Province] [nvarchar](50) NULL,
	[DetailAddress] [nvarchar](max) NULL,
	[Country] [nvarchar](50) NULL,
	[Status] [tinyint] NULL,
	[LiveFrom] [char](4) NULL,
	[LiveTo] [char](4) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUserAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[USERCONTACT]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[USERCONTACT](
	[IdUserContact] [nvarchar](128) NOT NULL,
	[IdUser] [nvarchar](128) NOT NULL,
	[PhoneNumber] [varchar](max) NULL,
	[Email] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUserContact] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[USERHASNOTIFY]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERHASNOTIFY](
	[IdNotify] [nvarchar](128) NOT NULL,
	[IdNotifyType] [int] NULL,
	[SeenTime] [datetime] NULL,
	[CreatedTS] [datetime] NULL,
	[Content] [nvarchar](200) NULL,
	[IdPost] [nvarchar](128) NULL,
	[IdNotifySetting] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdNotify] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[USERINFO]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERINFO](
	[IdInfo] [nvarchar](128) NOT NULL,
	[IdUser] [nvarchar](128) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Gender] [bit] NULL,
	[DateOfBirth] [date] NULL,
	[LastUpdatedTS] [datetime] NULL,
	[CreatedTS] [datetime] NOT NULL,
	[Avatar] [nvarchar](256) NULL,
	[Cover] [nvarchar](256) NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdInfo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[USERINTRO]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERINTRO](
	[IdUserIntro] [nvarchar](128) NOT NULL,
	[IdUser] [nvarchar](128) NOT NULL,
	[IntroContent] [nvarchar](max) NULL,
	[Hobby] [nvarchar](max) NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUserIntro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[USERMEDIA]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERMEDIA](
	[IdMedia] [nvarchar](128) NOT NULL,
	[IdUser] [nvarchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdMedia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[USERRELATIONSHIP]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERRELATIONSHIP](
	[IdUserRelationship] [nvarchar](128) NOT NULL,
	[IdInfo] [nvarchar](128) NOT NULL,
	[StatusRelationship] [tinyint] NULL,
	[CreatedDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUserRelationship] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[USERSEXCLUDE]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERSEXCLUDE](
	[IdUser] [nvarchar](128) NOT NULL,
	[IdUserExclude] [nvarchar](128) NOT NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUser] ASC,
	[IdUserExclude] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[USERSTORIES]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERSTORIES](
	[IdStory] [nvarchar](128) NOT NULL,
	[IdUser] [nvarchar](128) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[CreatedTS] [datetime] NULL,
	[TypeContent] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdStory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[USERTOKEN]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERTOKEN](
	[IdToken] [nvarchar](128) NOT NULL,
	[IdUser] [nvarchar](128) NOT NULL,
	[ContentToken] [nvarchar](max) NOT NULL,
	[CreatedTS] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdToken] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VIDEOS]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VIDEOS](
	[IdVideo] [nvarchar](128) NOT NULL,
	[IdAlbumVideo] [nvarchar](128) NOT NULL,
	[ContentVideo] [nvarchar](max) NULL,
	[LinkUrl] [nvarchar](max) NULL,
	[CreatedTS] [datetime] NULL,
	[UpdatedTS] [datetime] NULL,
	[VideoName] [nvarchar](256) NULL,
	[Cover] [nvarchar](max) NULL,
	[Time] [char](20) NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdVideo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VIDEOVIEWS]    Script Date: 29/06/2020 12:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VIDEOVIEWS](
	[IdVideo] [nvarchar](128) NOT NULL,
	[CreatedTS] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdVideo] ASC,
	[CreatedTS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'0d505f55-f1d8-4934-aaa9-afb833aa5296', N'2823ae67-c88e-4f48-aef8-dbb42158768a', N'Cover', CAST(0x0000ABBC0070192D AS DateTime), NULL, N'Your cover', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'1bfb38c2-e45c-415d-8c02-c71ccb94a3c3', N'2791f490-070e-4f26-85db-b94a3f11126b', N'Cover', CAST(0x0000AB27005E23A1 AS DateTime), NULL, N'Your cover', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'247b12d9-7c84-4ca8-b587-7e2d55b12ebb', N'b6e2dcd2-5895-4952-a870-7faaa0727812', N'Cover', CAST(0x0000ABD200CD3BD5 AS DateTime), NULL, N'Your cover', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'24f6986f-148a-4961-abd1-2a06272b64cb', N'0a20524a-ca74-44bb-ad6b-40f39cc7b1cc', N'Avatar', CAST(0x0000AB27005D3363 AS DateTime), NULL, N'Your avatar', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'29177035-352b-4a6f-82cb-25778979b183', N'0a20524a-ca74-44bb-ad6b-40f39cc7b1cc', N'Cover', CAST(0x0000AB27005D3363 AS DateTime), NULL, N'Your cover', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'2cafd03d-0060-4e32-9784-9148a99b95cf', N'9eb5a853-88b4-43d0-8fa0-82145016553f', N'Cover', CAST(0x0000ABBC008188F3 AS DateTime), NULL, N'Your cover', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'2d27b48e-1323-4e1e-aeb7-414ade3a1cb4', N'b74c5f44-754f-45c9-9286-1ec631fbac09', N'Avatar', CAST(0x0000ABBC0071FF5D AS DateTime), NULL, N'Your avatar', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'51f129f1-95ed-4735-a56c-8906a80a7304', N'2791f490-070e-4f26-85db-b94a3f11126b', N'Avatar', CAST(0x0000AB27005E23A1 AS DateTime), NULL, N'Your avatar', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'5c978786-6e76-4d1f-a52b-45a25a65c1f4', N'9eb5a853-88b4-43d0-8fa0-82145016553f', N'Avatar', CAST(0x0000ABBC008188F3 AS DateTime), NULL, N'Your avatar', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'7699a03e-4f91-47c1-b540-354987d0f33f', N'01a8b196-486e-400f-b79a-3f46c28e31c6', N'Cover', CAST(0x0000ABBC006DFCB7 AS DateTime), NULL, N'Your cover', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'854b0ade-6daf-4841-9c3b-6552ebfd346b', N'b74c5f44-754f-45c9-9286-1ec631fbac09', N'Cover', CAST(0x0000ABBC0071FF5D AS DateTime), NULL, N'Your cover', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'8c623ce5-90c9-446a-ae92-d68cbb14f29a', N'ae9ba3ca-fa49-4b45-b09a-2786c149e300', N'Cover', CAST(0x0000ABBC00716136 AS DateTime), NULL, N'Your cover', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'9a587c5f-5785-463c-961d-bea92be43f68', N'9effe861-e959-4e20-9e72-183bbfdf2b74', N'Cover', CAST(0x0000AB27008FB69A AS DateTime), NULL, N'Your cover', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'9fdf42eb-ee85-4c06-93a3-f25c73e8655a', N'2823ae67-c88e-4f48-aef8-dbb42158768a', N'Avatar', CAST(0x0000ABBC0070192D AS DateTime), NULL, N'Your avatar', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'a4caf5f9-0089-47fa-b302-64f13468462a', N'9effe861-e959-4e20-9e72-183bbfdf2b74', N'DEFAULT', CAST(0x0000AB27008FB69A AS DateTime), NULL, N'Home Images', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'a50ad7b1-5bb9-4251-8d72-8594e1903da4', N'2791f490-070e-4f26-85db-b94a3f11126b', N'DEFAULT', CAST(0x0000AB27005E23A1 AS DateTime), NULL, N'Home Images', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'a61ee0f3-2ede-44fa-b8b7-5849c0644d9d', N'a5aefbcb-bfdd-4b20-a8fd-b61a5d691147', N'Cover', CAST(0x0000ABBD0065FEF0 AS DateTime), NULL, N'Your cover', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'b37ec381-d941-4093-96f3-14848c3e0bc2', N'ae9ba3ca-fa49-4b45-b09a-2786c149e300', N'Avatar', CAST(0x0000ABBC00716136 AS DateTime), NULL, N'Your avatar', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'cf1d0328-1908-4ff7-b237-696f5e98e8bb', N'b6e2dcd2-5895-4952-a870-7faaa0727812', N'Avatar', CAST(0x0000ABD200CD3BD5 AS DateTime), NULL, N'Your avatar', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'd62b818e-f9d7-4c9a-8854-b8e7fc1badd5', N'9effe861-e959-4e20-9e72-183bbfdf2b74', N'Avatar', CAST(0x0000AB27008FB69A AS DateTime), NULL, N'Your avatar', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'f85e8020-d9ae-4458-996b-4ae686fa03eb', N'b6e2dcd2-5895-4952-a870-7faaa0727812', N'DEFAULT', CAST(0x0000ABD200CD3BD5 AS DateTime), NULL, N'Home Images', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'fb489d5c-35df-4c9a-b6d2-d065ab070004', N'a5aefbcb-bfdd-4b20-a8fd-b61a5d691147', N'Avatar', CAST(0x0000ABBD0065FEF0 AS DateTime), NULL, N'Your avatar', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'fc763359-732b-4af6-b278-3d6080891319', N'0a20524a-ca74-44bb-ad6b-40f39cc7b1cc', N'DEFAULT', CAST(0x0000AB27005D3363 AS DateTime), NULL, N'Home Images', NULL, NULL, NULL)
INSERT [dbo].[ALBUMIMAGES] ([IdAlbumImage], [IdMedia], [AlbumName], [CreatedTS], [Quantity], [ContentAlbum], [UpdatedTS], [Cover], [Status]) VALUES (N'ff45da53-3e04-4715-a4aa-0957caf9ebb3', N'01a8b196-486e-400f-b79a-3f46c28e31c6', N'Avatar', CAST(0x0000ABBC006DFCB7 AS DateTime), NULL, N'Your avatar', NULL, NULL, NULL)
INSERT [dbo].[ALBUMMUSIC] ([IdAlbumMusic], [IdMedia], [AlbumMusicName], [CreatedTS], [Quantity], [ContentAlbumMusic], [Cover], [UpdatedTS], [Status]) VALUES (N'00c8c45c-92d4-4ff6-a59b-cfd8239ccb5a', N'ae9ba3ca-fa49-4b45-b09a-2786c149e300', N'DEFAULT', CAST(0x0000ABBC00716136 AS DateTime), NULL, N'Home music song', NULL, NULL, NULL)
INSERT [dbo].[ALBUMMUSIC] ([IdAlbumMusic], [IdMedia], [AlbumMusicName], [CreatedTS], [Quantity], [ContentAlbumMusic], [Cover], [UpdatedTS], [Status]) VALUES (N'00e6a745-5af8-42da-b1ce-30d63cf5a721', N'2791f490-070e-4f26-85db-b94a3f11126b', N'DEFAULT', CAST(0x0000AB27005E23A1 AS DateTime), NULL, N'Home music song', NULL, NULL, NULL)
INSERT [dbo].[ALBUMMUSIC] ([IdAlbumMusic], [IdMedia], [AlbumMusicName], [CreatedTS], [Quantity], [ContentAlbumMusic], [Cover], [UpdatedTS], [Status]) VALUES (N'29908b6d-1613-4f31-8803-68f12fe42cae', N'2823ae67-c88e-4f48-aef8-dbb42158768a', N'DEFAULT', CAST(0x0000ABBC0070192D AS DateTime), NULL, N'Home music song', NULL, NULL, NULL)
INSERT [dbo].[ALBUMMUSIC] ([IdAlbumMusic], [IdMedia], [AlbumMusicName], [CreatedTS], [Quantity], [ContentAlbumMusic], [Cover], [UpdatedTS], [Status]) VALUES (N'3e7923d8-261d-4a64-b7b3-63e0e6a066f6', N'b74c5f44-754f-45c9-9286-1ec631fbac09', N'DEFAULT', CAST(0x0000ABBC0071FF5D AS DateTime), NULL, N'Home music song', NULL, NULL, NULL)
INSERT [dbo].[ALBUMMUSIC] ([IdAlbumMusic], [IdMedia], [AlbumMusicName], [CreatedTS], [Quantity], [ContentAlbumMusic], [Cover], [UpdatedTS], [Status]) VALUES (N'4c82fa03-1242-42c8-aec2-3b6ad0e78b5f', N'a5aefbcb-bfdd-4b20-a8fd-b61a5d691147', N'DEFAULT', CAST(0x0000ABBD0065FEF0 AS DateTime), NULL, N'Home music song', NULL, NULL, NULL)
INSERT [dbo].[ALBUMMUSIC] ([IdAlbumMusic], [IdMedia], [AlbumMusicName], [CreatedTS], [Quantity], [ContentAlbumMusic], [Cover], [UpdatedTS], [Status]) VALUES (N'5a3a8705-9a4f-4428-9d0e-2dfd319ddf13', N'0a20524a-ca74-44bb-ad6b-40f39cc7b1cc', N'DEFAULT', CAST(0x0000AB27005D3363 AS DateTime), NULL, N'Home music song', NULL, NULL, NULL)
INSERT [dbo].[ALBUMMUSIC] ([IdAlbumMusic], [IdMedia], [AlbumMusicName], [CreatedTS], [Quantity], [ContentAlbumMusic], [Cover], [UpdatedTS], [Status]) VALUES (N'7c4ca54e-bb5f-48a7-8471-a4b913d1e8c1', N'2791f490-070e-4f26-85db-b94a3f11126b', N'NHACCUADAT', CAST(0x0000AB2700741589 AS DateTime), NULL, N'', N'["1E5EXzJnM8gq1kGQzgb2uTIn0cvplbuca"]', NULL, 1)
INSERT [dbo].[ALBUMMUSIC] ([IdAlbumMusic], [IdMedia], [AlbumMusicName], [CreatedTS], [Quantity], [ContentAlbumMusic], [Cover], [UpdatedTS], [Status]) VALUES (N'bebd7e9e-3ca5-48ae-85b2-45bd874e9bac', N'0a20524a-ca74-44bb-ad6b-40f39cc7b1cc', N'Lil pump', CAST(0x0000ABCD00F17B3F AS DateTime), NULL, N'Album tạo vào ngày mưa rơi', N'["1yb_uF9mTjZ7h0VQlwbP97nANOwUqvN86"]', NULL, 1)
INSERT [dbo].[ALBUMMUSIC] ([IdAlbumMusic], [IdMedia], [AlbumMusicName], [CreatedTS], [Quantity], [ContentAlbumMusic], [Cover], [UpdatedTS], [Status]) VALUES (N'c4d66ece-83b4-46c8-8715-eb52dbe40f4b', N'01a8b196-486e-400f-b79a-3f46c28e31c6', N'DEFAULT', CAST(0x0000ABBC006DFCB7 AS DateTime), NULL, N'Home music song', NULL, NULL, NULL)
INSERT [dbo].[ALBUMMUSIC] ([IdAlbumMusic], [IdMedia], [AlbumMusicName], [CreatedTS], [Quantity], [ContentAlbumMusic], [Cover], [UpdatedTS], [Status]) VALUES (N'caa83082-f9b7-4803-973e-9303e78b65a2', N'9eb5a853-88b4-43d0-8fa0-82145016553f', N'DEFAULT', CAST(0x0000ABBC008188F3 AS DateTime), NULL, N'Home music song', NULL, NULL, NULL)
INSERT [dbo].[ALBUMMUSIC] ([IdAlbumMusic], [IdMedia], [AlbumMusicName], [CreatedTS], [Quantity], [ContentAlbumMusic], [Cover], [UpdatedTS], [Status]) VALUES (N'd5ca86aa-ea42-4729-8ec7-da3b474dea26', N'9effe861-e959-4e20-9e72-183bbfdf2b74', N'DEFAULT', CAST(0x0000AB27008FB69A AS DateTime), NULL, N'Home music song', NULL, NULL, NULL)
INSERT [dbo].[ALBUMMUSIC] ([IdAlbumMusic], [IdMedia], [AlbumMusicName], [CreatedTS], [Quantity], [ContentAlbumMusic], [Cover], [UpdatedTS], [Status]) VALUES (N'f0a77cc9-900b-46cb-bac1-379d31ace338', N'0a20524a-ca74-44bb-ad6b-40f39cc7b1cc', N'I wanna go away', CAST(0x0000ABC900C43E0C AS DateTime), NULL, N'', N'["1QEryOvNBuIhCgMczy50xtp_fGz98MMWQ"]', NULL, 1)
INSERT [dbo].[ALBUMMUSIC] ([IdAlbumMusic], [IdMedia], [AlbumMusicName], [CreatedTS], [Quantity], [ContentAlbumMusic], [Cover], [UpdatedTS], [Status]) VALUES (N'f292bb0c-f5a2-4fa7-9f42-9c8f96f14ad6', N'b6e2dcd2-5895-4952-a870-7faaa0727812', N'DEFAULT', CAST(0x0000ABD200CD3BD5 AS DateTime), NULL, N'Home music song', NULL, NULL, NULL)
INSERT [dbo].[ALBUMMUSIC] ([IdAlbumMusic], [IdMedia], [AlbumMusicName], [CreatedTS], [Quantity], [ContentAlbumMusic], [Cover], [UpdatedTS], [Status]) VALUES (N'f9c2b611-5f24-4e37-9975-879cc66697cd', N'0a20524a-ca74-44bb-ad6b-40f39cc7b1cc', N'Hivs', CAST(0x0000ABCA009AEF9A AS DateTime), NULL, N'', N'["1Hz6TMncd4kWgrvUeBENkx--QFHSn2c52"]', NULL, 1)
INSERT [dbo].[ALBUMVIDEOS] ([IdAlbumVideo], [IdMedia], [AlbumVideoName], [CreatedTS], [Quantity], [ContentAlbumVideo], [Cover], [UpdatedTS], [Status]) VALUES (N'12678ce3-ad78-471c-8f42-6f7738af3ad3', N'0a20524a-ca74-44bb-ad6b-40f39cc7b1cc', N'DEFAULT', CAST(0x0000AB27005D3363 AS DateTime), NULL, N'Home video', NULL, NULL, NULL)
INSERT [dbo].[ALBUMVIDEOS] ([IdAlbumVideo], [IdMedia], [AlbumVideoName], [CreatedTS], [Quantity], [ContentAlbumVideo], [Cover], [UpdatedTS], [Status]) VALUES (N'19aa4ea3-e6c9-43cd-988f-3c9aac722d3f', N'ae9ba3ca-fa49-4b45-b09a-2786c149e300', N'DEFAULT', CAST(0x0000ABBC00716136 AS DateTime), NULL, N'Home video', NULL, NULL, NULL)
INSERT [dbo].[ALBUMVIDEOS] ([IdAlbumVideo], [IdMedia], [AlbumVideoName], [CreatedTS], [Quantity], [ContentAlbumVideo], [Cover], [UpdatedTS], [Status]) VALUES (N'3d72b851-02b1-45b7-bda8-6cdbac9f3904', N'9eb5a853-88b4-43d0-8fa0-82145016553f', N'DEFAULT', CAST(0x0000ABBC008188F3 AS DateTime), NULL, N'Home video', NULL, NULL, NULL)
INSERT [dbo].[ALBUMVIDEOS] ([IdAlbumVideo], [IdMedia], [AlbumVideoName], [CreatedTS], [Quantity], [ContentAlbumVideo], [Cover], [UpdatedTS], [Status]) VALUES (N'3e0f24d7-753b-4935-8911-3e3c55aa5d88', N'9effe861-e959-4e20-9e72-183bbfdf2b74', N'DEFAULT', CAST(0x0000AB27008FB69A AS DateTime), NULL, N'Home video', NULL, NULL, NULL)
INSERT [dbo].[ALBUMVIDEOS] ([IdAlbumVideo], [IdMedia], [AlbumVideoName], [CreatedTS], [Quantity], [ContentAlbumVideo], [Cover], [UpdatedTS], [Status]) VALUES (N'817d2add-10d2-4204-a1b0-37a1e0f89089', N'a5aefbcb-bfdd-4b20-a8fd-b61a5d691147', N'DEFAULT', CAST(0x0000ABBD0065FEF0 AS DateTime), NULL, N'Home video', NULL, NULL, NULL)
INSERT [dbo].[ALBUMVIDEOS] ([IdAlbumVideo], [IdMedia], [AlbumVideoName], [CreatedTS], [Quantity], [ContentAlbumVideo], [Cover], [UpdatedTS], [Status]) VALUES (N'83672368-8f84-4a6f-b451-ee024abdb293', N'2791f490-070e-4f26-85db-b94a3f11126b', N'DEFAULT', CAST(0x0000AB27005E23A1 AS DateTime), NULL, N'Home video', NULL, NULL, NULL)
INSERT [dbo].[ALBUMVIDEOS] ([IdAlbumVideo], [IdMedia], [AlbumVideoName], [CreatedTS], [Quantity], [ContentAlbumVideo], [Cover], [UpdatedTS], [Status]) VALUES (N'857f8964-52e4-4a03-a4e7-dc5a57f3b092', N'01a8b196-486e-400f-b79a-3f46c28e31c6', N'DEFAULT', CAST(0x0000ABBC006DFCB7 AS DateTime), NULL, N'Home video', NULL, NULL, NULL)
INSERT [dbo].[ALBUMVIDEOS] ([IdAlbumVideo], [IdMedia], [AlbumVideoName], [CreatedTS], [Quantity], [ContentAlbumVideo], [Cover], [UpdatedTS], [Status]) VALUES (N'ce15e862-d037-4979-99ea-e476594e08bc', N'b74c5f44-754f-45c9-9286-1ec631fbac09', N'DEFAULT', CAST(0x0000ABBC0071FF5D AS DateTime), NULL, N'Home video', NULL, NULL, NULL)
INSERT [dbo].[ALBUMVIDEOS] ([IdAlbumVideo], [IdMedia], [AlbumVideoName], [CreatedTS], [Quantity], [ContentAlbumVideo], [Cover], [UpdatedTS], [Status]) VALUES (N'ee5e9b56-b335-43bf-a210-abc97c6101fa', N'2823ae67-c88e-4f48-aef8-dbb42158768a', N'DEFAULT', CAST(0x0000ABBC0070192D AS DateTime), NULL, N'Home video', NULL, NULL, NULL)
INSERT [dbo].[ALBUMVIDEOS] ([IdAlbumVideo], [IdMedia], [AlbumVideoName], [CreatedTS], [Quantity], [ContentAlbumVideo], [Cover], [UpdatedTS], [Status]) VALUES (N'f1b25c54-87b6-4401-833f-0a262c2a8fbe', N'b6e2dcd2-5895-4952-a870-7faaa0727812', N'DEFAULT', CAST(0x0000ABD200CD3BD5 AS DateTime), NULL, N'Home video', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[CATEGORY] ON 

INSERT [dbo].[CATEGORY] ([IdCategory], [NameCategory], [IntroCategory], [CoverCategoryUrl]) VALUES (1, N'Status', N'', N'')
SET IDENTITY_INSERT [dbo].[CATEGORY] OFF
INSERT [dbo].[COMMENT] ([IdComment], [IdPost], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'0183c84d-39ea-4983-9b52-999380cfe363', N'30f099a9-c0f7-4381-ba6c-897b121b1c4d', N'b78f81eb-0649-42ad-b855-75551462c11d', N'Đây là comment thứ 5', CAST(0x0000AB270084FFF5 AS DateTime), NULL, NULL)
INSERT [dbo].[COMMENT] ([IdComment], [IdPost], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'0adec2dc-5b9a-47ea-bd27-0f86f19a4d8b', N'30f099a9-c0f7-4381-ba6c-897b121b1c4d', N'b78f81eb-0649-42ad-b855-75551462c11d', N'Và đây là comment thứ 3', CAST(0x0000AB27007CA8D6 AS DateTime), NULL, NULL)
INSERT [dbo].[COMMENT] ([IdComment], [IdPost], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'0ebd1cac-e3da-45e1-b4c8-80477106019f', N'3b5bb4a0-bab0-4a15-9739-f8e2ad10cd7e', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Oke luôn nè ', CAST(0x0000ABD700588A19 AS DateTime), NULL, NULL)
INSERT [dbo].[COMMENT] ([IdComment], [IdPost], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'17a4ee81-ef08-43a1-8844-d092fe8fe8b0', N'30f099a9-c0f7-4381-ba6c-897b121b1c4d', N'b78f81eb-0649-42ad-b855-75551462c11d', N'Đây là comment đầu tiền !', CAST(0x0000AB27007A2490 AS DateTime), NULL, NULL)
INSERT [dbo].[COMMENT] ([IdComment], [IdPost], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'1bb89b13-c85b-4b05-b0b4-0cfce9761e9d', N'a8fe9c11-7ebe-4860-a171-3e9fa17d563b', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Thử cái comment vào bài 0 có comment', CAST(0x0000ABD700747D14 AS DateTime), NULL, NULL)
INSERT [dbo].[COMMENT] ([IdComment], [IdPost], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'31aa57d9-6653-40c3-b773-2c85fc19e51a', N'68c30dfb-4155-422c-97dd-f3adf4d2ca2c', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Oke em êi, chỉnh sửa em êi', CAST(0x0000ABD700874EE6 AS DateTime), NULL, NULL)
INSERT [dbo].[COMMENT] ([IdComment], [IdPost], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'4783af20-a952-4473-94c5-4925515bec7a', N'68c30dfb-4155-422c-97dd-f3adf4d2ca2c', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'OK binz', CAST(0x0000ABDA00900F76 AS DateTime), NULL, NULL)
INSERT [dbo].[COMMENT] ([IdComment], [IdPost], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'5a676969-a4cc-4de7-9cb6-c0dbb4c03105', N'30f099a9-c0f7-4381-ba6c-897b121b1c4d', N'b78f81eb-0649-42ad-b855-75551462c11d', N'Đây là comment thứ 2', CAST(0x0000AB27007C9B3A AS DateTime), NULL, NULL)
INSERT [dbo].[COMMENT] ([IdComment], [IdPost], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'75c41ef5-1d48-453d-aed1-cbc27828af12', N'8d0612bd-9b16-4d79-b693-623823ef5380', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Lại cái nữa này', CAST(0x0000ABD70074E102 AS DateTime), NULL, NULL)
INSERT [dbo].[COMMENT] ([IdComment], [IdPost], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'80737b09-d2a6-49d9-8b81-8a31397c7e34', N'cf4bfe30-1de4-4881-ac97-2f8c6da78463', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Comment cho bài này', CAST(0x0000ABD70073B8C4 AS DateTime), NULL, NULL)
INSERT [dbo].[COMMENT] ([IdComment], [IdPost], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'823b16ad-8d01-45c1-97ed-f1340cd4e45b', N'1a499908-7aab-4255-aa06-e503ab47e296', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Comment 1', CAST(0x0000AB29009C7B39 AS DateTime), NULL, NULL)
INSERT [dbo].[COMMENT] ([IdComment], [IdPost], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'9cc8e834-0769-4191-ae6a-55cc68408b07', N'68c30dfb-4155-422c-97dd-f3adf4d2ca2c', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'Anh đây em êi', CAST(0x0000ABD7008780A8 AS DateTime), NULL, NULL)
INSERT [dbo].[COMMENT] ([IdComment], [IdPost], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'9fabdf5a-d447-46b1-805a-39f9983148e1', N'a00c45e2-bb41-4095-ab8c-7d0a03e26324', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'Hahahaha, lại là ta ', CAST(0x0000ABD7004A0D3A AS DateTime), NULL, NULL)
INSERT [dbo].[COMMENT] ([IdComment], [IdPost], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'ca647676-338b-48ea-9f07-1dcc9054425c', N'aaa895e2-076a-40d5-9c43-56c2eef520f0', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Comment 1', CAST(0x0000AB29009A808F AS DateTime), NULL, NULL)
INSERT [dbo].[COMMENT] ([IdComment], [IdPost], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'd47ff4b2-8887-41ef-ade2-b7d476069844', N'a00c45e2-bb41-4095-ab8c-7d0a03e26324', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Đây là comment đầu tiên của chủ tus , chỉnh sửa thêm, thêm lần nữa, test update comment Phát cuối. Oke thành công luôn', CAST(0x0000ABD600FD529F AS DateTime), NULL, NULL)
INSERT [dbo].[COMMENT] ([IdComment], [IdPost], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'd9ca35e0-9965-4ea9-9308-bdd0ea6f3340', N'2520d471-0547-42b9-9705-942c1dbad5e7', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Số 1', CAST(0x0000AB270098C039 AS DateTime), NULL, NULL)
INSERT [dbo].[COMMENT] ([IdComment], [IdPost], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'f14e8c92-8065-482e-8367-7ed82e94792d', N'2c0e78c8-9744-4ed7-af1a-9466a113dd14', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Oke em êi', CAST(0x0000ABD7007598DF AS DateTime), NULL, NULL)
INSERT [dbo].[COMMENT] ([IdComment], [IdPost], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'f2edf6b1-0768-4d78-a7ea-8869a1e58740', N'bb12b0f1-d0bb-4ecd-8566-755944b7a6a7', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'deep try vãi', CAST(0x0000ABD70074B74E AS DateTime), NULL, NULL)
INSERT [dbo].[COMMENT] ([IdComment], [IdPost], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'f30d6f69-55ca-43a2-b86a-642829d5c620', N'30f099a9-c0f7-4381-ba6c-897b121b1c4d', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Đây là comment thứ 4', CAST(0x0000AB270083D598 AS DateTime), NULL, NULL)
INSERT [dbo].[FOLLOWS] ([IdUser], [IdUserRequest], [CreateTS]) VALUES (N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', CAST(0x07EAA19CD33F43410B AS DateTime2))
INSERT [dbo].[FOLLOWS] ([IdUser], [IdUserRequest], [CreateTS]) VALUES (N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'47fa49eb-82ff-4803-b702-a084801fca16', CAST(0x07061F94573B43410B AS DateTime2))
INSERT [dbo].[FOLLOWS] ([IdUser], [IdUserRequest], [CreateTS]) VALUES (N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'52543c92-07e7-4732-86e0-8b7412ddf6f1', CAST(0x079042327D3C43410B AS DateTime2))
INSERT [dbo].[FOLLOWS] ([IdUser], [IdUserRequest], [CreateTS]) VALUES (N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'8716298b-194b-411d-ace6-ea67509cfb8d', CAST(0x0759BCDCE93C43410B AS DateTime2))
INSERT [dbo].[FOLLOWS] ([IdUser], [IdUserRequest], [CreateTS]) VALUES (N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', CAST(0x073174103D7041410B AS DateTime2))
INSERT [dbo].[FRIENDS] ([IdUser], [IdUserFriend], [CreateTS], [Status]) VALUES (N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', CAST(0x07A673E2A96E41410B AS DateTime2), 0)
INSERT [dbo].[FRIENDS] ([IdUser], [IdUserFriend], [CreateTS], [Status]) VALUES (N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', CAST(0x0785ACD11E4E43410B AS DateTime2), 0)
INSERT [dbo].[FRIENDS] ([IdUser], [IdUserFriend], [CreateTS], [Status]) VALUES (N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', CAST(0x07A725E2A96E41410B AS DateTime2), 0)
INSERT [dbo].[FRIENDS] ([IdUser], [IdUserFriend], [CreateTS], [Status]) VALUES (N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', CAST(0x07089D86834D43410B AS DateTime2), 0)
INSERT [dbo].[FRIENDS] ([IdUser], [IdUserFriend], [CreateTS], [Status]) VALUES (N'db65b042-e0b2-434d-bc4e-06fb2afebe27', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', CAST(0x07AD36D11E4E43410B AS DateTime2), 0)
INSERT [dbo].[FRIENDS] ([IdUser], [IdUserFriend], [CreateTS], [Status]) VALUES (N'db65b042-e0b2-434d-bc4e-06fb2afebe27', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', CAST(0x07E15F87834D43410B AS DateTime2), 0)
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'05400bf9-a29a-4f3b-89ed-3022978c1808', N'a00c45e2-bb41-4095-ab8c-7d0a03e26324', N'1Xp6vVZBHO_o5goV1xSjfsbjupdgwvuyx')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'11e5f1ba-8dd1-4dcd-a1a0-2b5505739673', N'2eed1cf3-e41b-41cc-9481-b55cdbb24921', N'1JmkRkhNJijrz0euxsmrv4Is8Qq7zmnuy')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'1453b2f7-5846-466d-9961-2c750e49148a', N'2eed1cf3-e41b-41cc-9481-b55cdbb24921', N'1im1xq3Ezs6AMIeW7-x2QE6IWKH-sfIfU')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'16ad6dc0-a8e3-48b7-9f18-840bea81bc80', N'2eed1cf3-e41b-41cc-9481-b55cdbb24921', N'1oJFvHPG9hQeDEwNgJj7Ohjp3J6eqssYO')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'24e6f9fb-8bc3-4542-9933-c524bbf3dde9', N'68c30dfb-4155-422c-97dd-f3adf4d2ca2c', N'1vuQ4tgUJG1ebRiUwOmfZojgKR8wVb_Zo')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'2bfa2d62-a404-4fcc-b4c5-b8e60138b95a', N'a8fe9c11-7ebe-4860-a171-3e9fa17d563b', N'1U2asEEBZzGadfVTz9UuAMLvlPGo3cLk3')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'31754f2b-07fe-488d-93d4-b99846653dca', N'2eed1cf3-e41b-41cc-9481-b55cdbb24921', N'1isFGRTXaNPkkZwiXxFOX6aoAVjwa4Gdo')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'34693b0c-158a-48b2-bb03-bb13acfe6260', N'68c30dfb-4155-422c-97dd-f3adf4d2ca2c', N'1BVNqRgh_qpNEOv63Sb01CmbVzVfPT_H7')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'34a59353-9b6d-4b35-9228-82a8c6f494b3', N'68c30dfb-4155-422c-97dd-f3adf4d2ca2c', N'1HJAjcf3Z2BfuAt-povtKOrGyTqZhtDVp')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'4c034e78-30eb-4952-8f86-a1388f83ce0b', N'2c0e78c8-9744-4ed7-af1a-9466a113dd14', N'1NQLCpShXmUE7ppIkjTrQJWdUnaB4uaIt')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'54518be3-9062-447d-8941-50183007f3b7', N'8d0612bd-9b16-4d79-b693-623823ef5380', N'1nl3ySsI9T2ElKRRO5WCX4CcVnKe8pVaF')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'69b8f07b-a5e5-4117-b72b-9ae0b7ef1a7a', N'7e187b9a-9737-49e7-a13e-068ef5979de5', N'1nXqFp_9w9bY_-Usdrq5nLB7tkVkdMDjy')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'8803612b-7a0f-48e7-9cac-69b8d3019670', N'cf4bfe30-1de4-4881-ac97-2f8c6da78463', N'1AnpDCgf3U7iyW3rGmiMR5tCLKZwbyB2j')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'88ba88ca-e8ba-455f-8035-9631a0b2ab41', N'3b5bb4a0-bab0-4a15-9739-f8e2ad10cd7e', N'1E3qC0meJt32Uy6DU3jSRLZJ3HPm1nJyo')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'99fb2e15-38ad-4c0d-8616-24ca30b4d6d0', N'68c30dfb-4155-422c-97dd-f3adf4d2ca2c', N'1J-cb-Qj28led_QYsqg7ulGFFbR0H2PXP')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'9ec397fd-57e6-472f-8d85-e974152c366d', N'2c0e78c8-9744-4ed7-af1a-9466a113dd14', N'1QbPvcIGRzCyeJF1NRCgOYU9H3VpuXQNG')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'ac5205a6-2999-4d8c-9dac-b6cf5c38bc28', N'2eed1cf3-e41b-41cc-9481-b55cdbb24921', N'14ZFt7vCdfxg_Sa75dTq74NIxb9Ol0f3D')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'cb4da8e6-3711-4517-b806-1c9235657309', N'a00c45e2-bb41-4095-ab8c-7d0a03e26324', N'1c5bUusvYGRzEbBQjCJ_JAEBS-5wqaBW4')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'd2b2ff6b-d6dd-4a92-bf28-b14ee1fdfcd6', N'a00c45e2-bb41-4095-ab8c-7d0a03e26324', N'1OV5dNvvoKUy8kuuYNXl8wLJb7MUOb4aL')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'd3db70f9-9250-4c35-93fd-8630418cef83', N'2eed1cf3-e41b-41cc-9481-b55cdbb24921', N'1VJqE4Cyl759nCQnRc7x2eyGTwSi-758M')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'e9e8fe53-9a51-497e-9424-e51ed51020ac', N'68c30dfb-4155-422c-97dd-f3adf4d2ca2c', N'1rWYrwvofsF4457utJnZ7GJH9UgfZrLrP')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'ea80961d-9bef-4367-a41c-6823ebb6bf1a', N'a00c45e2-bb41-4095-ab8c-7d0a03e26324', N'1C4ujidnQ5NRzQL2Nq97NjiOX7QPRrmQ3')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'f809163b-996d-4927-bbc3-6e24e0f2db89', N'bb12b0f1-d0bb-4ecd-8566-755944b7a6a7', N'1APaxu67yIFXdijT5KcEO4-d-sbO0NhXN')
INSERT [dbo].[IMAGEPOST] ([IdImage], [IdPost], [ImagesUrl]) VALUES (N'fd8898d8-fdf0-4b17-a6f0-1ee2e5557a28', N'68c30dfb-4155-422c-97dd-f3adf4d2ca2c', N'15DO7gH2YMAL-7hZfvThwPqXkWsmNmiyt')
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'036b53fb-26ab-46f3-a7cd-58fd410dee37', N'fc763359-732b-4af6-b278-3d6080891319', NULL, N'14wn7jDG-tWxAssmugrr7q-z9czQYBWc8', CAST(0x0000AB280040ED2F AS DateTime), CAST(0x0000AB280040ED2F AS DateTime), 1)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'0de535e7-7697-417a-b12f-d79629e94439', N'fc763359-732b-4af6-b278-3d6080891319', NULL, N'1foa0HYTk8BEoQss4LSLvJui0nA10Fj80', CAST(0x0000AB280040ED2F AS DateTime), CAST(0x0000AB280040ED2F AS DateTime), 1)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'10e590d4-074d-4de8-8696-0337ee21b9d6', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'["1P-MZ0wK84CaAmrNofFA8GF2JLzo2RwN5"]', CAST(0x0000ABCD008C0156 AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'11c75078-87f4-4eb5-9424-889ed1f38282', N'29177035-352b-4a6f-82cb-25778979b183', NULL, N'1bk3yiISmpihD-RRv-PSRajOgl3YDLLaU', CAST(0x0000AB2800439B2F AS DateTime), CAST(0x0000AB2800439B2F AS DateTime), 1)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'12ae75f9-47d5-4ef6-9bcd-d85647a17f22', N'fc763359-732b-4af6-b278-3d6080891319', NULL, N'1AeDNLR8vvO9sZaAma8WBCcMfGhpGGGxI', CAST(0x0000AB280040ED2F AS DateTime), CAST(0x0000AB280040ED2F AS DateTime), 1)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'17095000-5a85-4c73-8a5b-abe7a7e053d5', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'["18x3LUJvj9c8_orwDEGlzp6a4IoTKO1zN"]', CAST(0x0000ABCC00470CDC AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'1789aff4-8538-4aef-acee-5288eb42124f', N'29177035-352b-4a6f-82cb-25778979b183', NULL, N'1DXqbdTbQ7WHz1I2HYerBzGfMetA3D6j2', CAST(0x0000AB2800439B2F AS DateTime), CAST(0x0000AB2800439B2F AS DateTime), 1)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'1efe8cf5-8a64-42fd-adbf-9056a6d9fe2d', N'29177035-352b-4a6f-82cb-25778979b183', NULL, N'["1U6aH7tTwyVghJbpICWQapZEs_CIjpS_J"]', CAST(0x0000ABCC005555D2 AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'249e5f8f-d9d9-4bfd-8d8f-a62143d83e76', N'29177035-352b-4a6f-82cb-25778979b183', NULL, N'["1GbkiywzQUjcoyciodJi-yZPRE_W_JcB5"]', CAST(0x0000ABCC005595FF AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'2e2ad060-e904-4707-8af7-68fead050b36', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'["1SzWn6Zqvt_edrNWV-fSOXochd7U2RnER"]', CAST(0x0000ABCC00491EE2 AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'2febafb6-53eb-4318-9730-8384ed2a879d', N'cf1d0328-1908-4ff7-b237-696f5e98e8bb', NULL, N'["1-LDr4tWKUL0RXFf_weyCzmUZgCft8gZ7"]', CAST(0x0000ABD200D720E4 AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'34a7a74b-76f8-4ba2-927f-2545b6af4ebc', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'["1S_Nm1Q5Qf6Is-oAaCUarqBo1fbZmFRe1"]', CAST(0x0000ABCC00429680 AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'385dc1ee-4c3e-4aa3-a817-4e5648ef89ff', N'29177035-352b-4a6f-82cb-25778979b183', NULL, N'["1U5XSIvfbEX1DfbZTJZLovGicop36eAJi"]', CAST(0x0000ABCD008BD433 AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'3aef3062-9bb1-4b00-a153-a1fbf14b9e68', N'29177035-352b-4a6f-82cb-25778979b183', NULL, N'["16k_ME0mKcWat_GgXwYODCWbAD62bA5Mz"]', CAST(0x0000ABCC005704EE AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'3b762d32-9ef3-4309-a22a-4eb914179174', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'["1U1h3L253QLAsrCpT2GOZ3OphGdJ_CBoM"]', CAST(0x0000ABCC004C48FD AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'425ab940-2c98-493a-8f5d-aff82d397dbc', N'fc763359-732b-4af6-b278-3d6080891319', NULL, N'19y9lhrxZnXK4K5ALJY65a4c6TifwMWF6', CAST(0x0000AB280040ED2F AS DateTime), CAST(0x0000AB280040ED2F AS DateTime), 1)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'4aae1398-afaa-4334-bd73-0c9ddd51743c', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'["1WwzZ96rnLCywW_O9E8LX7j7r2HA5Z3ae"]', CAST(0x0000ABCC004BB31C AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'4bb452f1-467b-4d4b-947f-962d3252987a', N'fc763359-732b-4af6-b278-3d6080891319', NULL, N'1MrXOzsQzELwl5F_rr06q47KRZxJFFC8z', CAST(0x0000AB280040ED2F AS DateTime), CAST(0x0000AB280040ED2F AS DateTime), 1)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'4c874b1e-a6cc-447e-8858-53ee39a1c8d3', N'fc763359-732b-4af6-b278-3d6080891319', NULL, N'14VcFAOkX5LjanyCON9FrCX5lEllwTpXc', CAST(0x0000AB280040ED2F AS DateTime), CAST(0x0000AB280040ED2F AS DateTime), 1)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'4f6b52ca-e74c-44e9-bff2-84abf07e048c', N'29177035-352b-4a6f-82cb-25778979b183', NULL, N'["1ChQ-sQWX9sekXXjn7FsKGdrdD7RD9URJ"]', CAST(0x0000ABCC006A1D58 AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'511f1b11-f2cc-48da-8e82-53a4ed20bf4a', N'29177035-352b-4a6f-82cb-25778979b183', NULL, N'["1hPMcJRcgyyUdoXl1Bx9qu9MyatroKzF2"]', CAST(0x0000ABCC006A0A67 AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'5275fa96-6dc9-4711-bbf2-2e3b25a66a81', N'29177035-352b-4a6f-82cb-25778979b183', NULL, N'1W_BkUCu4YGZFcAzNnKchuUebfD4NcaBf', CAST(0x0000AB2800439B2F AS DateTime), CAST(0x0000AB2800439B2F AS DateTime), 1)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'5f0ec05f-4e8d-4464-8458-8210b7c009b1', N'fc763359-732b-4af6-b278-3d6080891319', NULL, N'1c-gBaSqY6EurQhz5T94NyVddJcJkPVs8', CAST(0x0000AB280040ED2F AS DateTime), CAST(0x0000AB280040ED2F AS DateTime), 1)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'6d701585-8c4b-486b-a591-5ab3a46b5eee', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'["1fiJ8hUk6lABfYAbDK-0R8K0X12FQ1KZw"]', CAST(0x0000ABCC004AC050 AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'721de3f5-7a76-4536-b354-fd134254415b', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'["1xHxTSQoyhin7FZo6hksnDMXuisPaS7wR"]', CAST(0x0000ABCC004A9598 AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'776554bf-9940-47ad-8da5-c09c9f4da295', N'29177035-352b-4a6f-82cb-25778979b183', NULL, N'["1JAPDz3c0xUq0F8DbegUf4kUD_OW7epwX"]', CAST(0x0000ABCC0051C008 AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'7c54cb4f-d665-47b5-a9ce-e97127fc73c9', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'1JhB8m6zKOBCdzkwP8nUyuMZFwLJqP0r1', CAST(0x0000AB2800431C93 AS DateTime), CAST(0x0000AB2800431C93 AS DateTime), 1)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'814993a7-6dda-4506-ab86-697763594054', N'29177035-352b-4a6f-82cb-25778979b183', NULL, N'["1Hs80sVoCF_75ugbq7lEtgThhnLBdLsFJ"]', CAST(0x0000ABCC0055892B AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'8ca000aa-53e6-44a4-ac40-368fe6cf9a42', N'29177035-352b-4a6f-82cb-25778979b183', NULL, N'["1l89Ly1Bw68sZT2lixr33Vc-InlILtU9o"]', CAST(0x0000ABCC005752FB AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'8e081870-4fc9-4ac9-9cb9-a17d004e2caf', N'29177035-352b-4a6f-82cb-25778979b183', NULL, N'["1T5n3l0N4KsCEG3K2ZkuMzzULQ4DMqiKc"]', CAST(0x0000ABCC00511A8A AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'8ef6b57e-3353-4ba0-a4b6-89a837dd4de7', N'fc763359-732b-4af6-b278-3d6080891319', NULL, N'19X4zqEOVs4D7JnyYovZ-ywmgvDmX16zd', CAST(0x0000AB280040ED2F AS DateTime), CAST(0x0000AB280040ED2F AS DateTime), 1)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'9002c080-6290-460f-ba78-36923cd400aa', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'19CDWCxqjGnXby3_yIsZZ8BMjs_Z_SSGk', CAST(0x0000AB2800431C93 AS DateTime), CAST(0x0000AB2800431C93 AS DateTime), 1)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'94dd1f16-45b8-488a-b51c-d09efba3e357', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'["1WXU2C-82zeXcKRfl-FKC-L2X4KQkuAhY"]', CAST(0x0000ABCC004B046F AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'95e0b7a0-8604-4019-bc92-0faa12a0d626', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'["147fKrAmuO_jsdTa5gn2sDce4gY8CBiGm"]', CAST(0x0000AB280043DE23 AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'b51692a2-2027-4f0c-9207-0ce03f13abff', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'["1KwxfSe4Lu_kkI6TQPr66Uvrwb3HYhrVt"]', CAST(0x0000ABCC004963C8 AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'c1e5682b-3a2a-439e-8b34-fd6ea588e9a6', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'["1hXe3CFcQUllJjB53J6qFQEdyquUQ3IYE"]', CAST(0x0000ABCC0050D3F2 AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'c2a04ee7-cd68-421a-9d97-d9e34315bef2', N'29177035-352b-4a6f-82cb-25778979b183', NULL, N'["1qlDWC_KO2KrgxXKiPvfll4jIT6WtSawr"]', CAST(0x0000ABD200D77654 AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'c3046e23-21e5-4bea-9821-b26287ff6689', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'17Cu9TzYcZDVI4G9b13D2agTGFJkYlapz', CAST(0x0000AB2800431C93 AS DateTime), CAST(0x0000AB2800431C93 AS DateTime), 1)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'c5709521-931e-4d8e-8bd9-0511d1d29f9d', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'["1DhDT4pI4OU_HOifoVao32huqxqAhWgoV"]', CAST(0x0000ABCC004AD90C AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'c93eb208-6315-4a66-b3e6-b3980b53e02a', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'["118UsDJpBii7XhG3JaNe5lte3vJt2ijhx"]', CAST(0x0000ABCC004636D0 AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'caf602b0-fbd0-4092-a757-4a9ef641cd60', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'["1G3qZfRNfissMZ4biKwUW4njIuA9mT778"]', CAST(0x0000ABCC00503E71 AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'cb81c471-50d9-4f05-9705-d6dfd67fb427', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'1EseJJc7pZvDfEW6NyqLj60y2h9w8hV4c', CAST(0x0000AB2800431C93 AS DateTime), CAST(0x0000AB2800431C93 AS DateTime), 1)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'cc1c1190-4547-46f5-9d90-95d356bb0128', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'["1uO5LjFYNw0Oj5Bvngyn1TjPsluKUgTVY"]', CAST(0x0000ABCC00484CD9 AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'cfc154c8-eb6a-4211-b224-a4ed26e950ad', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'["1f1sc-1kBZOYQ8lBs1wP7rToTHydG47VT"]', CAST(0x0000ABD200D535C9 AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'dd6fbe6b-8e44-456f-9375-0b9b91414090', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'["1ejD5_DHff5i_4l79zE_xELWylITqt7hX"]', CAST(0x0000ABCC004C37DE AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'e0ddb37d-7e1c-4f80-9e36-4446784a1b54', N'29177035-352b-4a6f-82cb-25778979b183', NULL, N'["1uMg55z2AM_c6Pso44qtYygDgc2JOtGKF"]', CAST(0x0000ABCC0054E4CB AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'edef2c1c-2404-4661-92d0-2a3668848b27', N'29177035-352b-4a6f-82cb-25778979b183', NULL, N'["1bMPhMnWEZT2t5lz50m7Um2L5gM0pvljc"]', CAST(0x0000ABCC00557DAF AS DateTime), NULL, NULL)
INSERT [dbo].[IMAGES] ([IdImage], [IdAlbumImage], [ContentImage], [LinkUrl], [CreatedTS], [UpdatedTS], [Status]) VALUES (N'eee2085e-1540-4a7a-bec2-fb25d7cc0cae', N'24f6986f-148a-4961-abd1-2a06272b64cb', NULL, N'["1l271DBlCB5OV6-DPFxOVBguDrRblaV32"]', CAST(0x0000ABCC0046B0A7 AS DateTime), NULL, NULL)
INSERT [dbo].[INTROSTUDY] ([IdStudy], [IdUserIntro], [Studying], [StudyFrom], [StudyTo], [IDStatusSocial]) VALUES (N'0f0e9a22-c775-4423-9344-8f03e6c01cde', N'15285075-79e2-4920-aa9e-d0cae2082840', N'Đại học Sơn La', N'2010', N'2020', 1)
INSERT [dbo].[INTROSTUDY] ([IdStudy], [IdUserIntro], [Studying], [StudyFrom], [StudyTo], [IDStatusSocial]) VALUES (N'271eafd0-dc1d-4548-b560-8a11282b66c1', N'15285075-79e2-4920-aa9e-d0cae2082840', N'Nguyễn Văn Bé Lên Ba', N'2005', N'2005', 2)
INSERT [dbo].[INTROSTUDY] ([IdStudy], [IdUserIntro], [Studying], [StudyFrom], [StudyTo], [IDStatusSocial]) VALUES (N'4a7b734e-63a3-4e6b-9336-d42b7f9b3e05', N'2b1970e7-03a5-4fb7-97f7-c8d79e2190ae', N'Trinh gia Food', N'2020', N'2020', 1)
INSERT [dbo].[INTROSTUDY] ([IdStudy], [IdUserIntro], [Studying], [StudyFrom], [StudyTo], [IDStatusSocial]) VALUES (N'964adefb-5c33-4d1f-a70f-f0557e22e0a7', N'15285075-79e2-4920-aa9e-d0cae2082840', N'Đại học Hutech', N'2010', N'2010', 1)
INSERT [dbo].[INTROSTUDY] ([IdStudy], [IdUserIntro], [Studying], [StudyFrom], [StudyTo], [IDStatusSocial]) VALUES (N'bae768f9-4ed8-423d-8b51-5ff589d0b743', N'2b1970e7-03a5-4fb7-97f7-c8d79e2190ae', N'Trinh gia food 2', N'2010', N'2015', 2)
INSERT [dbo].[INTROWORKING] ([IdWorking], [IdUserIntro], [WorkingAt], [WorkFrom], [WorkTo], [IDStatusSocial]) VALUES (N'3001f988-81ce-4329-bb8f-edbc5cc5df4a', N'15285075-79e2-4920-aa9e-d0cae2082840', N'Oke la', N'2010', N'2010', 1)
INSERT [dbo].[INTROWORKING] ([IdWorking], [IdUserIntro], [WorkingAt], [WorkFrom], [WorkTo], [IDStatusSocial]) VALUES (N'421c0a3d-2473-41b9-bbee-d1fdaf4d6e1f', N'15285075-79e2-4920-aa9e-d0cae2082840', N'Bes leen ba', N'2010', NULL, 1)
INSERT [dbo].[LIKEPOST] ([IdPost], [IdUser], [Status]) VALUES (N'1a499908-7aab-4255-aa06-e503ab47e296', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 0)
INSERT [dbo].[LIKEPOST] ([IdPost], [IdUser], [Status]) VALUES (N'2520d471-0547-42b9-9705-942c1dbad5e7', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 0)
INSERT [dbo].[LIKEPOST] ([IdPost], [IdUser], [Status]) VALUES (N'2520d471-0547-42b9-9705-942c1dbad5e7', N'b78f81eb-0649-42ad-b855-75551462c11d', 0)
INSERT [dbo].[LIKEPOST] ([IdPost], [IdUser], [Status]) VALUES (N'2c0e78c8-9744-4ed7-af1a-9466a113dd14', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 0)
INSERT [dbo].[LIKEPOST] ([IdPost], [IdUser], [Status]) VALUES (N'30f099a9-c0f7-4381-ba6c-897b121b1c4d', N'b78f81eb-0649-42ad-b855-75551462c11d', 0)
INSERT [dbo].[LIKEPOST] ([IdPost], [IdUser], [Status]) VALUES (N'3b5bb4a0-bab0-4a15-9739-f8e2ad10cd7e', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 0)
INSERT [dbo].[LIKEPOST] ([IdPost], [IdUser], [Status]) VALUES (N'3b5bb4a0-bab0-4a15-9739-f8e2ad10cd7e', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', 0)
INSERT [dbo].[LIKEPOST] ([IdPost], [IdUser], [Status]) VALUES (N'68c30dfb-4155-422c-97dd-f3adf4d2ca2c', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 0)
INSERT [dbo].[LIKEPOST] ([IdPost], [IdUser], [Status]) VALUES (N'8d0612bd-9b16-4d79-b693-623823ef5380', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 0)
INSERT [dbo].[LIKEPOST] ([IdPost], [IdUser], [Status]) VALUES (N'8d0612bd-9b16-4d79-b693-623823ef5380', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', 0)
INSERT [dbo].[LIKEPOST] ([IdPost], [IdUser], [Status]) VALUES (N'a00c45e2-bb41-4095-ab8c-7d0a03e26324', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 0)
INSERT [dbo].[LIKEPOST] ([IdPost], [IdUser], [Status]) VALUES (N'a00c45e2-bb41-4095-ab8c-7d0a03e26324', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', 0)
INSERT [dbo].[LIKEPOST] ([IdPost], [IdUser], [Status]) VALUES (N'a8fe9c11-7ebe-4860-a171-3e9fa17d563b', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 0)
INSERT [dbo].[LIKEPOST] ([IdPost], [IdUser], [Status]) VALUES (N'a8fe9c11-7ebe-4860-a171-3e9fa17d563b', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', 0)
INSERT [dbo].[LIKEPOST] ([IdPost], [IdUser], [Status]) VALUES (N'aaa895e2-076a-40d5-9c43-56c2eef520f0', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 0)
INSERT [dbo].[LIKEPOST] ([IdPost], [IdUser], [Status]) VALUES (N'bb12b0f1-d0bb-4ecd-8566-755944b7a6a7', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 0)
INSERT [dbo].[LIKEPOST] ([IdPost], [IdUser], [Status]) VALUES (N'bb12b0f1-d0bb-4ecd-8566-755944b7a6a7', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', 0)
INSERT [dbo].[LIKEPOST] ([IdPost], [IdUser], [Status]) VALUES (N'cd99dc0e-dcdf-40b7-84b1-59917bb3e756', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 0)
INSERT [dbo].[LIKEPOST] ([IdPost], [IdUser], [Status]) VALUES (N'cd99dc0e-dcdf-40b7-84b1-59917bb3e756', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', 0)
INSERT [dbo].[LIKEPOST] ([IdPost], [IdUser], [Status]) VALUES (N'cf4bfe30-1de4-4881-ac97-2f8c6da78463', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 0)
INSERT [dbo].[LIKEPOST] ([IdPost], [IdUser], [Status]) VALUES (N'cf4bfe30-1de4-4881-ac97-2f8c6da78463', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', 0)
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'0edf86ae-b788-46e7-8076-67da9e4669ee', CAST(0x07FA0E9F8E8428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'0edf86ae-b788-46e7-8076-67da9e4669ee', CAST(0x0738E6C68F8428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'0edf86ae-b788-46e7-8076-67da9e4669ee', CAST(0x070BA654B98428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'0edf86ae-b788-46e7-8076-67da9e4669ee', CAST(0x0741A410BA8428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'0edf86ae-b788-46e7-8076-67da9e4669ee', CAST(0x07950201BE8428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'0edf86ae-b788-46e7-8076-67da9e4669ee', CAST(0x0722043CD98428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'0edf86ae-b788-46e7-8076-67da9e4669ee', CAST(0x07BA5E74D98428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'0edf86ae-b788-46e7-8076-67da9e4669ee', CAST(0x071A6EDDD98428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'0edf86ae-b788-46e7-8076-67da9e4669ee', CAST(0x070C15777D8628410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'0edf86ae-b788-46e7-8076-67da9e4669ee', CAST(0x074D9416B98628410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'0edf86ae-b788-46e7-8076-67da9e4669ee', CAST(0x0762E97E733D30410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'0edf86ae-b788-46e7-8076-67da9e4669ee', CAST(0x07F7D684733D30410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'0edf86ae-b788-46e7-8076-67da9e4669ee', CAST(0x07BC490FFC7830410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'0edf86ae-b788-46e7-8076-67da9e4669ee', CAST(0x077C3C12FC7830410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'0edf86ae-b788-46e7-8076-67da9e4669ee', CAST(0x073DE28A177930410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'0edf86ae-b788-46e7-8076-67da9e4669ee', CAST(0x07351274237930410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'0edf86ae-b788-46e7-8076-67da9e4669ee', CAST(0x074B466E932740410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'296d76de-b99a-4891-8054-e605238bea3d', CAST(0x0721AEA38F4382400B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'296d76de-b99a-4891-8054-e605238bea3d', CAST(0x0747327E398428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'296d76de-b99a-4891-8054-e605238bea3d', CAST(0x07263E9C578428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'296d76de-b99a-4891-8054-e605238bea3d', CAST(0x077BA40B5A8428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'296d76de-b99a-4891-8054-e605238bea3d', CAST(0x07FA626F788428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'296d76de-b99a-4891-8054-e605238bea3d', CAST(0x076615F5828628410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'296d76de-b99a-4891-8054-e605238bea3d', CAST(0x07F9F134BC8628410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'296d76de-b99a-4891-8054-e605238bea3d', CAST(0x07BEF6B4297930410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'296d76de-b99a-4891-8054-e605238bea3d', CAST(0x07A8313A707930410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'296d76de-b99a-4891-8054-e605238bea3d', CAST(0x078F5E7E8A7930410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'296d76de-b99a-4891-8054-e605238bea3d', CAST(0x0782B4FD972740410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', CAST(0x0755E9287E8428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', CAST(0x07FA2AA38D8428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', CAST(0x0758D84A8F8428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', CAST(0x07E5FB7CAA8428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', CAST(0x0717D47AB88428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', CAST(0x07FA22CCB98428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', CAST(0x0735E59BBA8428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', CAST(0x071B9E24D98428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', CAST(0x0791B057D98428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', CAST(0x07B3DE90D98428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', CAST(0x07A46B42EE8428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', CAST(0x07741B5DD98528410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', CAST(0x073D4E59488628410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', CAST(0x0751F4BD718628410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', CAST(0x074234F97F8628410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', CAST(0x074CBDB9048728410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', CAST(0x07A6CAF4027930410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', CAST(0x07D05EF7027930410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', CAST(0x07CB86AF107930410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', CAST(0x07A0BEE7217930410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', CAST(0x0736EAFF902740410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', CAST(0x078AEBDEB42740410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'dd76bafd-f135-4362-8034-cfcb38d68277', CAST(0x079E823CD73B82400B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'dd76bafd-f135-4362-8034-cfcb38d68277', CAST(0x075B9B85453D82400B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'dd76bafd-f135-4362-8034-cfcb38d68277', CAST(0x07ED96C1937A28410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'dd76bafd-f135-4362-8034-cfcb38d68277', CAST(0x075BEA1C378428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'dd76bafd-f135-4362-8034-cfcb38d68277', CAST(0x07B496A3568428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'dd76bafd-f135-4362-8034-cfcb38d68277', CAST(0x07AC8352588428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'dd76bafd-f135-4362-8034-cfcb38d68277', CAST(0x07724C445C8428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'dd76bafd-f135-4362-8034-cfcb38d68277', CAST(0x07AA5625738428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'dd76bafd-f135-4362-8034-cfcb38d68277', CAST(0x075DB1B4798428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'dd76bafd-f135-4362-8034-cfcb38d68277', CAST(0x07D950BCDA8428410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'dd76bafd-f135-4362-8034-cfcb38d68277', CAST(0x07B60E991B7930410B AS DateTime2))
INSERT [dbo].[MUSICLISTENS] ([IdMusic], [CreatedTS]) VALUES (N'dd76bafd-f135-4362-8034-cfcb38d68277', CAST(0x07612AA9952740410B AS DateTime2))
INSERT [dbo].[MUSICS] ([IdMusic], [IdAlbumMusic], [ContentMusic], [LinkUrl], [CreatedTS], [UpdatedTS], [MusicName], [Singer], [Cover], [Time], [Status]) VALUES (N'0edf86ae-b788-46e7-8076-67da9e4669ee', N'bebd7e9e-3ca5-48ae-85b2-45bd874e9bac', NULL, N'["1d16FRG_aQetW8WZz3e813HR0561Kz2Vm"]', CAST(0x0000ABCD010492D2 AS DateTime), NULL, N'Hết thương cạn nhớ', NULL, N'["1VuACQ1qo917hpnZEJklzJdI1s3NVcIxf"]', N'283.512             ', 1)
INSERT [dbo].[MUSICS] ([IdMusic], [IdAlbumMusic], [ContentMusic], [LinkUrl], [CreatedTS], [UpdatedTS], [MusicName], [Singer], [Cover], [Time], [Status]) VALUES (N'296d76de-b99a-4891-8054-e605238bea3d', N'7c4ca54e-bb5f-48a7-8471-a4b913d1e8c1', NULL, N'["1E8PalrN_TorE7i-gTkvtTlrWmi4Bttfl"]', CAST(0x0000AB270075D330 AS DateTime), NULL, N'La Ban Khong The Yeu ', N'Hoang', NULL, N'271.416             ', 1)
INSERT [dbo].[MUSICS] ([IdMusic], [IdAlbumMusic], [ContentMusic], [LinkUrl], [CreatedTS], [UpdatedTS], [MusicName], [Singer], [Cover], [Time], [Status]) VALUES (N'786293aa-38f9-4b85-8018-1234c0aea0a0', N'bebd7e9e-3ca5-48ae-85b2-45bd874e9bac', NULL, N'["1s3u7U5mvV-pVYXvOXVfL1ikiwFOlt10A"]', CAST(0x0000ABCD010088A0 AS DateTime), NULL, N'Hết thương', NULL, NULL, N'283.512             ', 1)
INSERT [dbo].[MUSICS] ([IdMusic], [IdAlbumMusic], [ContentMusic], [LinkUrl], [CreatedTS], [UpdatedTS], [MusicName], [Singer], [Cover], [Time], [Status]) VALUES (N'dd76bafd-f135-4362-8034-cfcb38d68277', N'00e6a745-5af8-42da-b1ce-30d63cf5a721', NULL, N'["1L3B0_4w9REOqioiz7Ov8O5E_U1b4sNzn"]', CAST(0x0000AB270074E8E1 AS DateTime), NULL, N'Het thuong can nho', N'Duc Fuck', N'["1eCNgWwZk8Uce6TY-3a1yagfN9PeCX0WR"]', N'283.512             ', 1)
INSERT [dbo].[NEWFEEDPOST] ([IdPost], [IdUser], [IdCategory], [Content], [CreatedTS], [UploadedTS], [Location], [TimeStampSort], [Images], [Emotion], [SharePost], [Status]) VALUES (N'1a499908-7aab-4255-aa06-e503ab47e296', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 1, N'Âsđ', CAST(0x0000AB29009C6728 AS DateTime), NULL, N'Ho Chi Minh', CAST(0x0000AB29009C6728 AS DateTime), N'["1OwvkRyPcx4uziN7lJINkoJgKYBYmbWpm"]', NULL, NULL, 1)
INSERT [dbo].[NEWFEEDPOST] ([IdPost], [IdUser], [IdCategory], [Content], [CreatedTS], [UploadedTS], [Location], [TimeStampSort], [Images], [Emotion], [SharePost], [Status]) VALUES (N'2520d471-0547-42b9-9705-942c1dbad5e7', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 1, N'Bài post của Tiến Đạt', CAST(0x0000AB2700841B8C AS DateTime), NULL, N'Ho Chi Minh', CAST(0x0000AB2700841B8C AS DateTime), N'["1_2fAoEMECyhvMj1o0ZzRatAQRaSrwzdB","1H_0eqeZVwOt6WttQzsiz4tLhRO_dxVRu"]', NULL, NULL, 1)
INSERT [dbo].[NEWFEEDPOST] ([IdPost], [IdUser], [IdCategory], [Content], [CreatedTS], [UploadedTS], [Location], [TimeStampSort], [Images], [Emotion], [SharePost], [Status]) VALUES (N'2c0e78c8-9744-4ed7-af1a-9466a113dd14', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 1, N'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', CAST(0x0000ABD300366425 AS DateTime), NULL, NULL, CAST(0x0000ABD300366425 AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NEWFEEDPOST] ([IdPost], [IdUser], [IdCategory], [Content], [CreatedTS], [UploadedTS], [Location], [TimeStampSort], [Images], [Emotion], [SharePost], [Status]) VALUES (N'2eed1cf3-e41b-41cc-9481-b55cdbb24921', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 1, N'Why do we use it?
It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using ''Content here, content here'', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for ''lorem ipsum'' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).', CAST(0x0000ABD70082BF9B AS DateTime), CAST(0x0000ABE8008CB7F5 AS DateTime), NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[NEWFEEDPOST] ([IdPost], [IdUser], [IdCategory], [Content], [CreatedTS], [UploadedTS], [Location], [TimeStampSort], [Images], [Emotion], [SharePost], [Status]) VALUES (N'30f099a9-c0f7-4381-ba6c-897b121b1c4d', N'b78f81eb-0649-42ad-b855-75551462c11d', 1, N'Tien Dat ', CAST(0x0000AB27006CD27A AS DateTime), NULL, N'Ho Chi Minh', CAST(0x0000AB27006CD27A AS DateTime), N'["1ZxeWR2kYGss7RP_qTytMSqpQ34NA4H_y"]', NULL, NULL, 1)
INSERT [dbo].[NEWFEEDPOST] ([IdPost], [IdUser], [IdCategory], [Content], [CreatedTS], [UploadedTS], [Location], [TimeStampSort], [Images], [Emotion], [SharePost], [Status]) VALUES (N'3b5bb4a0-bab0-4a15-9739-f8e2ad10cd7e', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', 1, N'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries', CAST(0x0000ABD600F58F24 AS DateTime), NULL, NULL, CAST(0x0000ABD600F58F24 AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NEWFEEDPOST] ([IdPost], [IdUser], [IdCategory], [Content], [CreatedTS], [UploadedTS], [Location], [TimeStampSort], [Images], [Emotion], [SharePost], [Status]) VALUES (N'60a54c17-2bc7-4260-a795-347889b4193a', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 1, N'Where can I get some? alo alo asqwewqedasdsadsadsadassuwaradsasd', CAST(0x0000ABD70083E83C AS DateTime), CAST(0x0000ABE80082F244 AS DateTime), NULL, CAST(0x0000ABE80082F244 AS DateTime), NULL, NULL, NULL, 2)
INSERT [dbo].[NEWFEEDPOST] ([IdPost], [IdUser], [IdCategory], [Content], [CreatedTS], [UploadedTS], [Location], [TimeStampSort], [Images], [Emotion], [SharePost], [Status]) VALUES (N'68c30dfb-4155-422c-97dd-f3adf4d2ca2c', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 1, N'Why do we use it?
It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using ''Content here, content here'', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for ''lorem ipsum'' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).', CAST(0x0000ABD700839C3A AS DateTime), CAST(0x0000ABE8008C9836 AS DateTime), NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[NEWFEEDPOST] ([IdPost], [IdUser], [IdCategory], [Content], [CreatedTS], [UploadedTS], [Location], [TimeStampSort], [Images], [Emotion], [SharePost], [Status]) VALUES (N'7e187b9a-9737-49e7-a13e-068ef5979de5', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', 1, N'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,', CAST(0x0000ABD600F3B83F AS DateTime), NULL, NULL, CAST(0x0000ABD600F3B83F AS DateTime), NULL, NULL, NULL, 2)
INSERT [dbo].[NEWFEEDPOST] ([IdPost], [IdUser], [IdCategory], [Content], [CreatedTS], [UploadedTS], [Location], [TimeStampSort], [Images], [Emotion], [SharePost], [Status]) VALUES (N'8d0612bd-9b16-4d79-b693-623823ef5380', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 1, N'Không có nội dung.', CAST(0x0000ABD30074543B AS DateTime), NULL, NULL, CAST(0x0000ABD30074543B AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NEWFEEDPOST] ([IdPost], [IdUser], [IdCategory], [Content], [CreatedTS], [UploadedTS], [Location], [TimeStampSort], [Images], [Emotion], [SharePost], [Status]) VALUES (N'a00c45e2-bb41-4095-ab8c-7d0a03e26324', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', 1, N'Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for ''lorem ipsum'' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)', CAST(0x0000ABD600F61571 AS DateTime), NULL, NULL, CAST(0x0000ABD600F61571 AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NEWFEEDPOST] ([IdPost], [IdUser], [IdCategory], [Content], [CreatedTS], [UploadedTS], [Location], [TimeStampSort], [Images], [Emotion], [SharePost], [Status]) VALUES (N'a8fe9c11-7ebe-4860-a171-3e9fa17d563b', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 1, N'Ảnh của duy.', CAST(0x0000ABD30074FF60 AS DateTime), NULL, NULL, CAST(0x0000ABD30074FF60 AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NEWFEEDPOST] ([IdPost], [IdUser], [IdCategory], [Content], [CreatedTS], [UploadedTS], [Location], [TimeStampSort], [Images], [Emotion], [SharePost], [Status]) VALUES (N'aaa895e2-076a-40d5-9c43-56c2eef520f0', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 1, N'Bài viết demo', CAST(0x0000AB29009A6E44 AS DateTime), NULL, N'Ho Chi Minh', CAST(0x0000AB29009A6E44 AS DateTime), N'["13m7iLqw47UYNjb3G0_ir_IoHQn2BFfFW"]', NULL, NULL, 1)
INSERT [dbo].[NEWFEEDPOST] ([IdPost], [IdUser], [IdCategory], [Content], [CreatedTS], [UploadedTS], [Location], [TimeStampSort], [Images], [Emotion], [SharePost], [Status]) VALUES (N'bb12b0f1-d0bb-4ecd-8566-755944b7a6a7', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 1, N'Không có nội dung.', CAST(0x0000ABD300745DD3 AS DateTime), NULL, NULL, CAST(0x0000ABD300745DD3 AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NEWFEEDPOST] ([IdPost], [IdUser], [IdCategory], [Content], [CreatedTS], [UploadedTS], [Location], [TimeStampSort], [Images], [Emotion], [SharePost], [Status]) VALUES (N'cd99dc0e-dcdf-40b7-84b1-59917bb3e756', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 1, N'Why do we use it?
It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using ''Content here, content here'', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for ''lorem ipsum'' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).', CAST(0x0000ABD700838529 AS DateTime), NULL, NULL, CAST(0x0000ABD700838529 AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NEWFEEDPOST] ([IdPost], [IdUser], [IdCategory], [Content], [CreatedTS], [UploadedTS], [Location], [TimeStampSort], [Images], [Emotion], [SharePost], [Status]) VALUES (N'cf4bfe30-1de4-4881-ac97-2f8c6da78463', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', 1, N'Học hành tận mạng.', CAST(0x0000ABD3007606A3 AS DateTime), NULL, NULL, CAST(0x0000ABD3007606A3 AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[REPLYCOMMENT] ([IdReply], [IdComment], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'09424002-e3d0-41b4-b5ec-6494169e7564', N'0ebd1cac-e3da-45e1-b4c8-80477106019f', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Sao k được', CAST(0x07FE4C305F2A35410B AS DateTime2), NULL, NULL)
INSERT [dbo].[REPLYCOMMENT] ([IdReply], [IdComment], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'2f240dd1-afb3-400d-a337-11b768659c9d', N'd9ca35e0-9965-4ea9-9308-bdd0ea6f3340', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N' Tui trả lời chính mình nè, sửa nè', CAST(0x07E88798B44D82400B AS DateTime2), CAST(0x075EB11C702935410B AS DateTime2), NULL)
INSERT [dbo].[REPLYCOMMENT] ([IdReply], [IdComment], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'33517699-bc90-431c-89a0-032e978b7717', N'ca647676-338b-48ea-9f07-1dcc9054425c', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Rep comment 1', CAST(0x075B14C89A4E84400B AS DateTime2), NULL, NULL)
INSERT [dbo].[REPLYCOMMENT] ([IdReply], [IdComment], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'4e17bcd0-f989-45b6-b2de-372c250d1767', N'80737b09-d2a6-49d9-8b81-8a31397c7e34', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Comment nè', CAST(0x07149723AF8432410B AS DateTime2), NULL, NULL)
INSERT [dbo].[REPLYCOMMENT] ([IdReply], [IdComment], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'52ce10d7-38a5-4a10-ab47-ceb070b90ede', N'f14e8c92-8065-482e-8367-7ed82e94792d', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Oke nữa nè', CAST(0x07EA6E7A3C2A35410B AS DateTime2), NULL, NULL)
INSERT [dbo].[REPLYCOMMENT] ([IdReply], [IdComment], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'5bf03f27-36b0-4d97-8b3d-db7ef4b6d049', N'd9ca35e0-9965-4ea9-9308-bdd0ea6f3340', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Nice !', CAST(0x0701C7E7E82383400B AS DateTime2), NULL, NULL)
INSERT [dbo].[REPLYCOMMENT] ([IdReply], [IdComment], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'73460db4-f173-4213-9e99-b32494bdccf2', N'd9ca35e0-9965-4ea9-9308-bdd0ea6f3340', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Trả lời cái nữa nè', CAST(0x0772B162308132410B AS DateTime2), NULL, NULL)
INSERT [dbo].[REPLYCOMMENT] ([IdReply], [IdComment], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'880869d4-2891-4ed4-aec7-25ae02f092bc', N'd9ca35e0-9965-4ea9-9308-bdd0ea6f3340', N'b78f81eb-0649-42ad-b855-75551462c11d', N'Rep một cái', CAST(0x07F75D8FD44E82400B AS DateTime2), NULL, NULL)
INSERT [dbo].[REPLYCOMMENT] ([IdReply], [IdComment], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'896a00eb-e317-4a5f-9df7-cd8d5e2522e2', N'31aa57d9-6653-40c3-b773-2c85fc19e51a', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Ôi  nice luôn', CAST(0x07E0C22F792A35410B AS DateTime2), NULL, NULL)
INSERT [dbo].[REPLYCOMMENT] ([IdReply], [IdComment], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'd07b93a9-4616-48fb-a149-1015ecc4eeee', N'31aa57d9-6653-40c3-b773-2c85fc19e51a', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'Chứ sao zẩy', CAST(0x07C1E2D0882A35410B AS DateTime2), NULL, NULL)
INSERT [dbo].[REPLYCOMMENT] ([IdReply], [IdComment], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'd6195182-c86c-42a3-9a1a-9ab4aa9613bd', N'1bb89b13-c85b-4b05-b0b4-0cfce9761e9d', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Oke luoon', CAST(0x076FD7B6308432410B AS DateTime2), NULL, NULL)
INSERT [dbo].[REPLYCOMMENT] ([IdReply], [IdComment], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'd7e32301-b749-49db-8729-87f7d86dd2f4', N'0ebd1cac-e3da-45e1-b4c8-80477106019f', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'Được của ló', CAST(0x0763B6A1563A35410B AS DateTime2), NULL, NULL)
INSERT [dbo].[REPLYCOMMENT] ([IdReply], [IdComment], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'e65ff861-5921-45b8-ab45-eb4fc1b78598', N'823b16ad-8d01-45c1-97ed-f1340cd4e45b', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'rEp comment', CAST(0x07AD46CEB14F84400B AS DateTime2), NULL, NULL)
INSERT [dbo].[REPLYCOMMENT] ([IdReply], [IdComment], [IdUser], [Content], [CreatedTS], [UpdatedTS], [Images]) VALUES (N'f368a73e-62f1-42c5-b7ab-96c107e6e075', N'31aa57d9-6653-40c3-b773-2c85fc19e51a', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N' Tui trả lời chính mình nè, sửa cái nè', CAST(0x072D1FB3868132410B AS DateTime2), CAST(0x07FAFB4BDD2935410B AS DateTime2), NULL)
INSERT [dbo].[REQUESTFRIENDS] ([IdUser], [IdUserRequest], [CreateTS]) VALUES (N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'15720292-3e40-4e4a-925c-992b00f31520', CAST(0x071F7D31EC4532410B AS DateTime2))
INSERT [dbo].[REQUESTFRIENDS] ([IdUser], [IdUserRequest], [CreateTS]) VALUES (N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'52543c92-07e7-4732-86e0-8b7412ddf6f1', CAST(0x07FE5F57EA4532410B AS DateTime2))
INSERT [dbo].[REQUESTFRIENDS] ([IdUser], [IdUserRequest], [CreateTS]) VALUES (N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'80a39abd-4605-4afa-819a-b1351c4974c1', CAST(0x07F6AA37641C30410B AS DateTime2))
INSERT [dbo].[REQUESTFRIENDS] ([IdUser], [IdUserRequest], [CreateTS]) VALUES (N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'fdbe87b7-cd17-46ae-abb4-a0989a2b60d9', CAST(0x07CF3A59E64532410B AS DateTime2))
INSERT [dbo].[REQUESTFRIENDS] ([IdUser], [IdUserRequest], [CreateTS]) VALUES (N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'15720292-3e40-4e4a-925c-992b00f31520', CAST(0x076BB626706C41410B AS DateTime2))
INSERT [dbo].[REQUESTFRIENDS] ([IdUser], [IdUserRequest], [CreateTS]) VALUES (N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'47fa49eb-82ff-4803-b702-a084801fca16', CAST(0x0761E5FA4F3B43410B AS DateTime2))
INSERT [dbo].[REQUESTFRIENDS] ([IdUser], [IdUserRequest], [CreateTS]) VALUES (N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'52543c92-07e7-4732-86e0-8b7412ddf6f1', CAST(0x079DD0DBF73B43410B AS DateTime2))
INSERT [dbo].[REQUESTFRIENDS] ([IdUser], [IdUserRequest], [CreateTS]) VALUES (N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'b3dc917b-854b-4703-b032-36aaf9a6a600', CAST(0x07BE6B7A7F3943410B AS DateTime2))
SET IDENTITY_INSERT [dbo].[STATUSSOCIAL] ON 

INSERT [dbo].[STATUSSOCIAL] ([IdStatusSocial], [Description]) VALUES (1, N'Public')
INSERT [dbo].[STATUSSOCIAL] ([IdStatusSocial], [Description]) VALUES (2, N'Private')
SET IDENTITY_INSERT [dbo].[STATUSSOCIAL] OFF
INSERT [dbo].[STORYSEEN] ([IdStory], [IdUser]) VALUES (N'18b52cff-2fc8-4dad-a460-3ed523cdce39', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949')
INSERT [dbo].[STORYSEEN] ([IdStory], [IdUser]) VALUES (N'19c85ac3-d557-4840-be39-31690fad5733', N'b576c13a-a769-48dd-82bc-9e37f41ebd48')
INSERT [dbo].[STORYSEEN] ([IdStory], [IdUser]) VALUES (N'19c85ac3-d557-4840-be39-31690fad585', N'b576c13a-a769-48dd-82bc-9e37f41ebd48')
INSERT [dbo].[STORYSEEN] ([IdStory], [IdUser]) VALUES (N'19c85ac3-d557-4840-be39-31690fadyhg', N'b576c13a-a769-48dd-82bc-9e37f41ebd48')
INSERT [dbo].[STORYSEEN] ([IdStory], [IdUser]) VALUES (N'455d5bc4-84b8-4104-99dd-d0800a28d8d4', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949')
INSERT [dbo].[STORYSEEN] ([IdStory], [IdUser]) VALUES (N'4c843be3-737a-424f-bc43-2f41a1f60f32', N'b576c13a-a769-48dd-82bc-9e37f41ebd48')
INSERT [dbo].[STORYSEEN] ([IdStory], [IdUser]) VALUES (N'60f2c8d2-d538-45f7-8ee0-ede0d92d8c7a', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949')
INSERT [dbo].[STORYSEEN] ([IdStory], [IdUser]) VALUES (N'82525ed8-04ec-493d-a94a-73457945f108', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949')
INSERT [dbo].[STORYSEEN] ([IdStory], [IdUser]) VALUES (N'84adc4b1-0f44-4610-a3f6-b495f6d8de39', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949')
INSERT [dbo].[STORYSEEN] ([IdStory], [IdUser]) VALUES (N'84bde355-50d7-46bd-8113-ad9ce8c7706e', N'b576c13a-a769-48dd-82bc-9e37f41ebd48')
INSERT [dbo].[STORYSEEN] ([IdStory], [IdUser]) VALUES (N'b78f81eb-0649-42ad-b855-75551462c11d', N'b576c13a-a769-48dd-82bc-9e37f41ebd48')
INSERT [dbo].[STORYSEEN] ([IdStory], [IdUser]) VALUES (N'd19710a5-d937-42e0-9b86-f36ae2ab8eca', N'b576c13a-a769-48dd-82bc-9e37f41ebd48')
INSERT [dbo].[STORYSEEN] ([IdStory], [IdUser]) VALUES (N'e300af48-876f-477b-82fa-3a6b58dc4154', N'b576c13a-a769-48dd-82bc-9e37f41ebd48')
INSERT [dbo].[STORYSEEN] ([IdStory], [IdUser]) VALUES (N'f38bdbbc-3385-4817-8e9a-f414eb03b66e', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949')
INSERT [dbo].[USERACCOUNT] ([IdUser], [Username], [PasswordHash], [PasswordSalt], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [StatusAccount], [Email], [EmailConfirmed], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [AccessFailedCount]) VALUES (N'15720292-3e40-4e4a-925c-992b00f31520', N'thisishac009@gmail.com', N'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.IjQ3NzI5YzQ3Zjg4MWNiMTQxOGY4ZGYzMzY3MDRkMjgxYWY2NzJmMWViNTNhMjE1MzM0ZmQ2ZmRkMTBlM2UxMWUi.Apa9lAtOBAdMP_GU5flTWTk0xS2yrW586ZQnI6hFE1o', N'67b530cc5857a2f5c2a89b8aaeb03b45', CAST(0x4B210B00 AS Date), NULL, CAST(0x0000ABBD0065FEED AS DateTime), 1, N'thisishac009@gmail.com', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERACCOUNT] ([IdUser], [Username], [PasswordHash], [PasswordSalt], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [StatusAccount], [Email], [EmailConfirmed], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [AccessFailedCount]) VALUES (N'19c85ac3-d557-4840-be39-31690fad5733', N'huy.trinh.5011@gmail.com', N'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.ImJiZDg3NTQ5MWZiYjExNTAwN2I3YzQ3NmQ3ZDYwOGRkNDI1NTVjYjg5OGU5YTFmZjlhNDJlYTI2OTExYTNkZmQi.R8gVkusb438m-XxqFLPK6PlWPPqeIKqaNCY_RbXXkVw', N'cf60508bb033c256c0cb0d1584c9c27c', CAST(0x7B400B00 AS Date), NULL, CAST(0x0000AB27008F8C00 AS DateTime), 1, N'huy.trinh.5011@gmail.com', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERACCOUNT] ([IdUser], [Username], [PasswordHash], [PasswordSalt], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [StatusAccount], [Email], [EmailConfirmed], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [AccessFailedCount]) VALUES (N'2c6363f0-014a-4424-8942-2ae475fabe02', N'datomg3q1998@gmail.com', N'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.IjM2NDBhNGFlZTVjNjNmZTdkN2QwZWMxYjY4ZGExZDhhNmEyYzgxMWYzNWNhNjY3YjI2YjJkM2JmMzgzY2VlYmIi.6sjo5Tbz0sv0rWB_1ekveE9585QiuqZ-MFkV_KtqzX0', N'2907639cce5e0f1ae12d89455d9d2c7e', CAST(0x76400B00 AS Date), NULL, CAST(0x0000AB27008EC31E AS DateTime), 1, N'datomg3q1998@gmail.com', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERACCOUNT] ([IdUser], [Username], [PasswordHash], [PasswordSalt], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [StatusAccount], [Email], [EmailConfirmed], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [AccessFailedCount]) VALUES (N'2f3be62e-0eb5-4d3e-ad8c-1fa799745537', N'thisisfood2@gmail.com', N'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.IjJmOGU2NTcwYjdlOTA4MjRkMzA0YWZmYjhlNDkxYmNhNjBkNGJhMTNlYTQ5ZDQ3NWFhYzA3MTM1NGFmYmE4YmIi.g5yBcXwjarzEeQEns-pSwl81ryWXGN2db6exrMo3JxM', N'25507b8135053ce06b0e5094a5a3d09b', CAST(0xC3210B00 AS Date), NULL, CAST(0x0000ABBC00716135 AS DateTime), 1, N'thisisfood2@gmail.com', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERACCOUNT] ([IdUser], [Username], [PasswordHash], [PasswordSalt], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [StatusAccount], [Email], [EmailConfirmed], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [AccessFailedCount]) VALUES (N'47fa49eb-82ff-4803-b702-a084801fca16', N'thisistoan@gmail.com', N'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.IjQ0NmQ1ZDk0ZmNjOTlmNmZmMTBlODBhZjBlZDY1ZGIwMjhhMTc3NmQ2YTk2MDk2NzM2NTBkNWRiOWQzY2YyOTci.tjbhWmBc8PSKdR5gzVRRCJMm53J44drB18N800_ICW8', N'75374acc8e459fc9aa919f430ea92f62', CAST(0x67210B00 AS Date), NULL, CAST(0x0000AB890078EEB8 AS DateTime), 1, N'thisistoan@gmail.com', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERACCOUNT] ([IdUser], [Username], [PasswordHash], [PasswordSalt], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [StatusAccount], [Email], [EmailConfirmed], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [AccessFailedCount]) VALUES (N'4847583d-5e79-4f08-8527-f7e080a78800', N'thisistroi@gmail.com', N'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.ImE0NDFhMjRlYjM4NTU0ZTdiOTdkZTNiMWEyYWY2OGIxNmZiNjVlOTY2MmEzZDAxYmEwMTU4MGQ4NGVmNzY5N2Ei.mRvSoTQoyW251T5pmiBYfi7LSFoQ8IEUidXKiXxEwmw', N'9bcd31984d3999317456a81008baf5f0', CAST(0x84220B00 AS Date), NULL, CAST(0x0000AB89007B57C6 AS DateTime), 1, N'thisistroi@gmail.com', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERACCOUNT] ([IdUser], [Username], [PasswordHash], [PasswordSalt], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [StatusAccount], [Email], [EmailConfirmed], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [AccessFailedCount]) VALUES (N'52543c92-07e7-4732-86e0-8b7412ddf6f1', N'thisisfood@gmail.com', N'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.IjJmOGU2NTcwYjdlOTA4MjRkMzA0YWZmYjhlNDkxYmNhNjBkNGJhMTNlYTQ5ZDQ3NWFhYzA3MTM1NGFmYmE4YmIi.HVocMyG4agWVlkO7cvKuwdLG3oDXrwOphm2jUTotvFw', N'd475d85c62a87608318ba20d59719759', CAST(0xC3210B00 AS Date), NULL, CAST(0x0000ABBC006DFCB3 AS DateTime), 1, N'thisisfood@gmail.com', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERACCOUNT] ([IdUser], [Username], [PasswordHash], [PasswordSalt], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [StatusAccount], [Email], [EmailConfirmed], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [AccessFailedCount]) VALUES (N'80a39abd-4605-4afa-819a-b1351c4974c1', N'thisisvan@gmail.com', N'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.IjE5MjdiN2NiODhlNTY3NTM3NjI4MzhmNDM1Mjc3MWI0YmQ0ZGYzODg1OWJhNGYxNzRmYTdjM2RkOTc4NjI3NjMi.HYqGr-Sze3x3X-JOKoB5d2w3bdq_IplTaiLj2alo11A', N'260789250b07e8bf263fc6bd5f0cccda', CAST(0xE1150B00 AS Date), NULL, CAST(0x0000AB89007AE61D AS DateTime), 1, N'thisisvan@gmail.com', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERACCOUNT] ([IdUser], [Username], [PasswordHash], [PasswordSalt], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [StatusAccount], [Email], [EmailConfirmed], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [AccessFailedCount]) VALUES (N'8716298b-194b-411d-ace6-ea67509cfb8d', N'dat123@gmail.com', N'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.IjM2NDBhNGFlZTVjNjNmZTdkN2QwZWMxYjY4ZGExZDhhNmEyYzgxMWYzNWNhNjY3YjI2YjJkM2JmMzgzY2VlYmIi._kliuxRz5pcIX5UN7-4ZVzrqdF5R3uHTduoUb7LrWko', N'a2f3ffed0e7ee0d050d2bb7133b6b0e0', CAST(0x87400B00 AS Date), NULL, CAST(0x0000AB27009956B3 AS DateTime), 1, N'dat123@gmail.com', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERACCOUNT] ([IdUser], [Username], [PasswordHash], [PasswordSalt], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [StatusAccount], [Email], [EmailConfirmed], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [AccessFailedCount]) VALUES (N'8bf30a1f-3ffe-45e0-89c1-b52fc0402554', N'thisisbedat@gmail.com', N'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.IjM2NDBhNGFlZTVjNjNmZTdkN2QwZWMxYjY4ZGExZDhhNmEyYzgxMWYzNWNhNjY3YjI2YjJkM2JmMzgzY2VlYmIi.QH9LjmtmwnI_DsMVeD5WwHxNp31vTq38ipDc4VgxLqE', N'cc02c6fc577245e86111daf6abe9da2f', CAST(0x4B210B00 AS Date), NULL, CAST(0x0000ABC5006DB5AB AS DateTime), 1, N'thisisbedat@gmail.com', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERACCOUNT] ([IdUser], [Username], [PasswordHash], [PasswordSalt], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [StatusAccount], [Email], [EmailConfirmed], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [AccessFailedCount]) VALUES (N'9f07b194-7d19-4567-b095-a69813a10928', N'tatata@gmail.com', N'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.IjM2NDBhNGFlZTVjNjNmZTdkN2QwZWMxYjY4ZGExZDhhNmEyYzgxMWYzNWNhNjY3YjI2YjJkM2JmMzgzY2VlYmIi.41G5rrs-WbfalxOvxFp3NVInedorYXE5-9REHX1WeFY', N'077329361443ac18f62027633b06fae5', CAST(0x73400B00 AS Date), NULL, CAST(0x0000AB27008F143E AS DateTime), 1, N'tatata@gmail.com', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERACCOUNT] ([IdUser], [Username], [PasswordHash], [PasswordSalt], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [StatusAccount], [Email], [EmailConfirmed], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [AccessFailedCount]) VALUES (N'b3dc917b-854b-4703-b032-36aaf9a6a600', N'buisinguyen.bsn@gmail.com', N'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.ImQ1NDkzYjliOGI2NTExYmJjYWY0MzhmNTQ4YTNiYmVlYjBjMTdlNThkNDlhMDA2NmU4NDYxM2NhMWFhZGE2MDEi.rnrD_-wnKuz3YtbnYJhYyxHKMdAUnSa1zpABzLKzvIw', N'f1d0800931adc671216c606575f46f4d', CAST(0x4B210B00 AS Date), NULL, CAST(0x0000ABBC008188DE AS DateTime), 1, N'buisinguyen.bsn@gmail.com', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERACCOUNT] ([IdUser], [Username], [PasswordHash], [PasswordSalt], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [StatusAccount], [Email], [EmailConfirmed], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [AccessFailedCount]) VALUES (N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'thisisdat1998@gmail.com', N'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.IjM2NDBhNGFlZTVjNjNmZTdkN2QwZWMxYjY4ZGExZDhhNmEyYzgxMWYzNWNhNjY3YjI2YjJkM2JmMzgzY2VlYmIi.gnJBFwrW6sV4VuKQBna6-bl4-gRWVoN0MR4g-L5wtf0', N'45a6f07e7fdb832d493f04756f100f37', CAST(0x7C400B00 AS Date), CAST(0x0000ABBD00653ECE AS DateTime), CAST(0x0000AB27005D1D7E AS DateTime), 1, N'thisisdat1998@gmail.com', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERACCOUNT] ([IdUser], [Username], [PasswordHash], [PasswordSalt], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [StatusAccount], [Email], [EmailConfirmed], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [AccessFailedCount]) VALUES (N'b78f81eb-0649-42ad-b855-75551462c11d', N'datpham200120@gmail.com', N'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.IjMwNjI1NDJiMjIzYTljY2Q5ZTdiMjZhZDMxMGM4NmZjMTMwZTkwMzYzMmU5YjE5NTljMmM5N2M2NjU4YmM5MGYi.54DWMNSZfkz0g5-fy5ZNARxCaOyT7RAwzANi213XOpE', N'ed27896b5a9a731289d4a1ddec0f185c', CAST(0x73400B00 AS Date), CAST(0x0000AB27005E5BD4 AS DateTime), CAST(0x0000AB27005D61F7 AS DateTime), 1, N'datpham200120@gmail.com', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERACCOUNT] ([IdUser], [Username], [PasswordHash], [PasswordSalt], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [StatusAccount], [Email], [EmailConfirmed], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [AccessFailedCount]) VALUES (N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'thisisfood1@gmail.com', N'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.IjJmOGU2NTcwYjdlOTA4MjRkMzA0YWZmYjhlNDkxYmNhNjBkNGJhMTNlYTQ5ZDQ3NWFhYzA3MTM1NGFmYmE4YmIi.TeYodcvPXx0yjRf8bm-kRGlEHb1q2D9JgSoEoZsBQCA', N'eb86f678edb24731221d34a8623bf13e', CAST(0xC3210B00 AS Date), NULL, CAST(0x0000ABBC0070191F AS DateTime), 1, N'thisisfood1@gmail.com', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERACCOUNT] ([IdUser], [Username], [PasswordHash], [PasswordSalt], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [StatusAccount], [Email], [EmailConfirmed], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [AccessFailedCount]) VALUES (N'd4d31272-cb28-4b4b-b3d7-78f8c8817b13', N'thisisfood3@gmail.com', N'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.IjJmOGU2NTcwYjdlOTA4MjRkMzA0YWZmYjhlNDkxYmNhNjBkNGJhMTNlYTQ5ZDQ3NWFhYzA3MTM1NGFmYmE4YmIi.aoQMHGC3TcKixx1ETUUXkNAwrKi8-E4k7IBL5CW_kqo', N'e8580723948a7bb4cb317fcc859d408c', CAST(0xC3210B00 AS Date), NULL, CAST(0x0000ABBC0071FF5B AS DateTime), 1, N'thisisfood3@gmail.com', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERACCOUNT] ([IdUser], [Username], [PasswordHash], [PasswordSalt], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [StatusAccount], [Email], [EmailConfirmed], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [AccessFailedCount]) VALUES (N'db65b042-e0b2-434d-bc4e-06fb2afebe27', N'thisishac@gmail.com', N'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.IjQ3NzI5YzQ3Zjg4MWNiMTQxOGY4ZGYzMzY3MDRkMjgxYWY2NzJmMWViNTNhMjE1MzM0ZmQ2ZmRkMTBlM2UxMWUi.1bhsRZQUkrLvdYD01GeiJMJpoaG5y3Y2vtWMYuNwTYQ', N'30e69db47ee832b2176d5ea585dc4cc1', CAST(0x67210B00 AS Date), NULL, CAST(0x0000AB89007950DF AS DateTime), 1, N'thisishac@gmail.com', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERACCOUNT] ([IdUser], [Username], [PasswordHash], [PasswordSalt], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [StatusAccount], [Email], [EmailConfirmed], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [AccessFailedCount]) VALUES (N'fdbe87b7-cd17-46ae-abb4-a0989a2b60d9', N'thisistong@gmail.com', N'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.IjVlNTQxYWUxY2RiNjU0YTQzZjljMTI1ZGZlMmM0Y2VlZjI3ZjM4YThhNjQwNjMyNzA2MmIwYzc4ZDA1ZTFlNTEi.YJHh5zR3vKaVp2nFPxrazPHel5IXvf3Mph03Hr8bar0', N'05dfeea899e916f2fb96746dbb5e4566', CAST(0x25240B00 AS Date), NULL, CAST(0x0000AB89007BD699 AS DateTime), 1, N'thisistong@gmail.com', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'029f8387-819f-47a7-aa50-8a60e182e8bc', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'08ec0078-9fd6-4575-866c-5dab7fad3fd3', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'0904ed8e-0ecd-47a6-aab7-610c6d3c40a2', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'0e9f8316-c250-482d-b048-ee8fea4247de', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'0f191378-6241-4071-af89-07400d9e8c85', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'12adc18d-a98a-481d-a1e0-110f743f25c5', N'52543c92-07e7-4732-86e0-8b7412ddf6f1', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'149102b5-a1ac-4219-a8a7-b30adad69407', N'd4d31272-cb28-4b4b-b3d7-78f8c8817b13', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'170be7f4-eaff-4faf-b541-2502bf3f0da4', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'17cd5692-d819-41c1-a82d-d9b1a2974950', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'1dd84ee0-2836-4800-be51-d5cde745e88a', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'1e534c0f-826e-4efa-8a4c-62ca9e7cd5fe', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'200afac6-c83b-4fdc-ba57-aeeda5e2dcb3', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'200c7a7b-8007-4e19-a9e5-29dd74a3ba2f', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'205f168f-dd84-47d0-a323-4df0a9fa35ac', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'245c8039-fc80-4959-8049-823d68398f6b', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'248b64bc-f7a8-4f7c-8c3a-1519161f557d', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'24c3e429-6ebf-47f5-a27d-9e2024f3f9d3', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'279b374c-e291-466f-8f98-7cc8541ad911', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'27c1a39a-5af8-4a7a-a31f-533ca5b86f16', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'29c6da6e-fadc-4f1d-ac49-cff1c179def1', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Hồ Chí Minh', N'Hồ Chí Minh', N'42 Lý Tự Trọng', N'Việt Nam', 1, N'2010', NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'2f2a4788-58c0-41ba-9320-5b446653d3ad', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'30751735-00e9-4927-9ca2-3425fabc8b7a', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'32838437-31e9-47da-976b-3664a2335a46', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'36ad1008-72b4-4645-a16c-fa387f4ad8be', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'3880e609-7f18-4b30-8b7c-ec205ed57669', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'398d5b48-5379-4536-9776-c7cf39d917f3', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'3b28e78c-3425-4330-a429-bd3afa695db2', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'3c9b5a04-b61b-4cc6-9211-6494a085c749', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'4018da8d-097b-417e-99c6-d486547fa763', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'4357bbee-abf1-4ad0-b042-1bdf1a3f7518', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'436d8e1a-6a63-4d9d-89f4-55796912c900', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'Hồ Chí Minh', N'Hồ Chí Minh', N'Hồ Chí Minh', N'Hồ Chí Minh', 1, N'2010', NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'4379fe15-1bab-4ebe-9078-ea1f368a7d53', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'43b475eb-efaf-43eb-af8d-9db37727a64a', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'447da7b0-daf2-49c8-8eb8-788e8a617f1a', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'44f54fa5-fd4f-455e-941c-dafa16d28dec', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'4607b378-7239-474e-b9cd-a9310e057619', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'480258ee-0f49-45c7-960f-41920e36a5c0', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'48c2cfdc-34bd-4339-8c46-ef36e69ee83b', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'4ab57d5f-9726-45cf-b559-0af5821cc703', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'4ad2f148-1d1a-4993-b71d-74e1c4e2efd8', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'4b72b1ca-eeb8-4b27-8901-c20fe43d9e8e', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'4c9f9434-2e95-4b5d-b1e0-90c6a1bc80ec', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'4dd6f137-e6c8-4553-8c5c-321cce58d5f9', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'525ab379-3f79-48e2-8ccd-d9e540262650', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'54d437ab-0172-4ffa-bab7-47c0d839ac9e', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'5a00afb8-e2fc-4716-bb05-2a3cdcd75855', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'60530b20-a8f6-4090-b7d9-edaf36456bc2', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'60f2a82c-a28b-45cd-87a4-ee2a818b6d0d', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'62ac4ae5-e938-43a0-8e6f-4f3f6c17291f', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'63567615-1a6f-4bea-a586-ae252c6646aa', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'64dbe975-25c3-48e6-85af-2556f983c459', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'662dfb8e-c8bc-4247-8b8e-088b5421cc6b', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'666de8ac-3620-4691-963a-560647debd9d', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'669deed3-312b-4151-a7e5-0e0c4669002f', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'68263745-2ee7-4c54-a111-64458d7e1025', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'69c0d712-ea52-4ae0-b576-6854b3b91c0c', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'6c6a4287-c5ae-40c4-903e-1112408797de', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'6e36f4bc-2c64-44f9-aec4-d574d81d8d18', N'19c85ac3-d557-4840-be39-31690fad5733', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'6eb7fabc-939c-4c14-af4e-a85615d252fc', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'7492ab39-89d0-434a-a8d1-5e0175d5788b', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'7568db79-01b8-4ac7-9a2e-b9c7758a8102', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'780be9e3-d2ad-4521-81be-bf915ee6cc21', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'7b3a8bad-7825-4da7-b456-dd158b00803a', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'81b25db1-0ab8-4ed9-a80a-ce12e58ab20b', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'847ad76f-47c0-474a-a7cf-973d4ecc12eb', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'8550c9b1-7b6f-4267-8b2e-900b15e8b5f5', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'899a4007-b088-47e2-8e76-3913fd204e4d', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'8a962765-4fe0-4529-8d82-8beed03db64d', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'8ae52c6b-2cc9-41b2-aa24-092778b792b7', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'8b5ef53e-08d1-41ce-938f-4b6dede32377', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'8bd59cde-05f4-4d94-b917-5aca642ff8fe', N'b78f81eb-0649-42ad-b855-75551462c11d', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'8cf6b8c6-df11-4601-9a6d-cf58e3b8e969', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'954f4bc7-8afa-474d-a8fb-361ddadfd651', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'96c4eb9c-3e88-458a-9780-7116c3b327a4', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'979603b7-e7a9-4f46-8157-906fcb7be964', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'9a7e55ec-a0a0-4720-8f73-26f7b0e71599', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'9a81a43b-5dd0-4623-92a4-bdc4e1fa8a11', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'9bce5938-bbaf-479e-b31d-25a267ab37a7', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'9ed37040-0215-4d96-93da-800ddcaf5b0f', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'9fc908fa-fbd7-4057-b306-bac14ea0756b', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'a1aca680-b915-47dd-91c9-d2ee4d7ec6cf', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'a387bac7-a595-4e49-a402-2553369681c5', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Sài Gòn', N'Sài Gòn', N'Sài Gòn', N'Sài Gòn', 1, N'2001', N'2001')
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'a569edcf-1783-4e76-af5c-0431910dfb52', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'aa4c2999-8156-4881-a25a-f83166195339', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'abb8f1fb-0bb9-4146-a3bd-7212f35dcd4a', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'ac6d1807-51e6-47d6-b163-c71e71ece0ad', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'af91be23-7c13-4a7c-998b-b0acbe85a377', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'b187e313-e2b7-4fb9-8f6a-c0665fc2af41', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'b25742a5-71a9-44bf-8e23-998b51ed19a8', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'b33a4fb0-e85a-434f-b048-ba6d5287052d', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'b4c88284-d1fb-41c8-949b-69673279d002', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'b8342681-4cf5-4107-bd29-83154a102621', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'ba7903a4-ff3b-4954-8f4b-659c6be51b58', N'b3dc917b-854b-4703-b032-36aaf9a6a600', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'bb36739d-90b1-4f00-a786-393f6f35f673', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'bbb751bc-d79d-4ecb-9acb-3285799c03c2', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'be921b95-5228-44aa-8006-1f1e56db1d4c', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'beeafb57-801a-444f-9879-6d8dc9d3ad16', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'c1979837-d008-4339-b2de-601c4915c0a3', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'c1eba99a-a177-4cad-b9ae-36e0901824f5', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'c215a558-52c0-493d-aa61-80ac82a4c318', N'2f3be62e-0eb5-4d3e-ad8c-1fa799745537', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'c2ba3e4c-71eb-44a4-8ce3-6e3676d3fdc6', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'c2f9a316-8a39-4b7b-9abd-fdc65effda6b', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'c3a5bcfb-6e0d-4a78-aa77-c201a30bc997', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'c90de404-487d-4b8c-8dab-c80a76ab3b21', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'd02d2c54-550c-4ec9-b55b-eb8f2adde504', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'd2f4fb2d-ff1d-481e-a309-3378c94142b5', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'd35b95e1-790a-47a7-90e9-ed3517cb61ce', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'd55b11dd-36bd-4828-bee4-25b90a51f8dc', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'd6d6319c-638f-4740-99dd-bb9eee451619', N'15720292-3e40-4e4a-925c-992b00f31520', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'd8b89aed-ee20-4972-ab66-9027169120e5', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'd9b75daa-b07e-485e-92b6-98d8a8a242ed', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'Hồ Chí Minh', N'Hồ Chí Minh', N'Hồ Chí Minh', N'Hồ Chí Minh', 2, N'2011', N'2015')
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'db646beb-5c48-4e65-b0a4-c693367bf1bf', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'dc384a4b-7731-418f-84b4-92cf68076e45', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'dcce41dc-2dd1-42e9-a89e-2673d5f55ddd', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'df0a3056-cf7e-424b-becf-93ae485f0c6d', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'e1b18678-3512-4b32-beab-6d4fae613cf4', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'e9abba3a-b06b-4cc9-8df0-f725f631d0cf', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'e9f61f9e-db89-431b-ad3a-6eebcd705162', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'ebd66a14-121a-41bc-bf14-07b0fa0a910f', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'edfca3c3-c853-4086-b14e-ad2c0cb71c5a', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'f36563a6-ccd7-4358-82f9-8fcad7818cb9', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'f8ee81ea-7cb5-43ca-8153-8073f51b7336', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'f93cbe3f-bef4-4761-96f8-32d9dc161706', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERADDRESS] ([IdUserAddress], [IdUser], [City], [Province], [DetailAddress], [Country], [Status], [LiveFrom], [LiveTo]) VALUES (N'fa9fa1b8-4433-43e6-9cc5-5d8df93a5033', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[USERINFO] ([IdInfo], [IdUser], [FirstName], [LastName], [Gender], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [Avatar], [Cover], [Status]) VALUES (N'0f4912eb-4bcb-475c-b628-c9b573167373', N'8bf30a1f-3ffe-45e0-89c1-b52fc0402554', N'Bé', N'Tiến Đạt', 1, CAST(0x4B210B00 AS Date), NULL, CAST(0x0000ABC5006DB5AB AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[USERINFO] ([IdInfo], [IdUser], [FirstName], [LastName], [Gender], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [Avatar], [Cover], [Status]) VALUES (N'4705979e-4d79-4713-ab3d-d7fb9c517339', N'b78f81eb-0649-42ad-b855-75551462c11d', N'Phạm Tiến', N'Đức', 1, CAST(0x73400B00 AS Date), NULL, CAST(0x0000AB27005D61F7 AS DateTime), N'["1Vf6-U2oM5M8AIBYOr4apLr0GpjkPUaLh"]', N'["1-DlGmEkxnQtmcPANYDAcRasKqvgcQLkb"]', NULL)
INSERT [dbo].[USERINFO] ([IdInfo], [IdUser], [FirstName], [LastName], [Gender], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [Avatar], [Cover], [Status]) VALUES (N'4ad649a5-2729-469d-a38e-d51e890f95f4', N'4847583d-5e79-4f08-8527-f7e080a78800', N'Nguyễn Văn', N'Trỗi', 1, CAST(0x84220B00 AS Date), NULL, CAST(0x0000AB89007B57C6 AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[USERINFO] ([IdInfo], [IdUser], [FirstName], [LastName], [Gender], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [Avatar], [Cover], [Status]) VALUES (N'4ba6c41f-c9dd-4018-9bd4-5e328720c3d8', N'fdbe87b7-cd17-46ae-abb4-a0989a2b60d9', N'Nguyễn Văn', N'Tòng', 1, CAST(0x25240B00 AS Date), NULL, CAST(0x0000AB89007BD699 AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[USERINFO] ([IdInfo], [IdUser], [FirstName], [LastName], [Gender], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [Avatar], [Cover], [Status]) VALUES (N'4f0f1007-a561-4ca4-880a-996f60aea683', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'Trịnh Gia', N'Food 1', 1, CAST(0xC3210B00 AS Date), NULL, CAST(0x0000ABBC0070191F AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[USERINFO] ([IdInfo], [IdUser], [FirstName], [LastName], [Gender], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [Avatar], [Cover], [Status]) VALUES (N'50fb1536-ffed-47eb-b14b-9dabf94d0f6f', N'15720292-3e40-4e4a-925c-992b00f31520', N'Thái Hạc', N'Pk', 0, CAST(0x4B210B00 AS Date), NULL, CAST(0x0000ABBD0065FEED AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[USERINFO] ([IdInfo], [IdUser], [FirstName], [LastName], [Gender], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [Avatar], [Cover], [Status]) VALUES (N'52ad441e-0ff3-4dc7-be3d-91b378ae5963', N'80a39abd-4605-4afa-819a-b1351c4974c1', N'Nguyễn Ngọc', N'Văn', 1, CAST(0xE1150B00 AS Date), NULL, CAST(0x0000AB89007AE61D AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[USERINFO] ([IdInfo], [IdUser], [FirstName], [LastName], [Gender], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [Avatar], [Cover], [Status]) VALUES (N'5b29f68b-00e6-4e7c-9978-9800c705ef67', N'8716298b-194b-411d-ace6-ea67509cfb8d', N'Tèn ', N'Ten', 1, CAST(0x87400B00 AS Date), NULL, CAST(0x0000AB27009956B3 AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[USERINFO] ([IdInfo], [IdUser], [FirstName], [LastName], [Gender], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [Avatar], [Cover], [Status]) VALUES (N'704b36e2-25e5-42ec-b0d1-a55a9e5ba507', N'd4d31272-cb28-4b4b-b3d7-78f8c8817b13', N'Trịnh Gia', N'Food 3', 1, CAST(0xC3210B00 AS Date), NULL, CAST(0x0000ABBC0071FF5B AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[USERINFO] ([IdInfo], [IdUser], [FirstName], [LastName], [Gender], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [Avatar], [Cover], [Status]) VALUES (N'7740bb26-a951-4678-b985-292310238547', N'47fa49eb-82ff-4803-b702-a084801fca16', N'Nguyễn Văn ', N'Toàn', 1, CAST(0x67210B00 AS Date), NULL, CAST(0x0000AB890078EEB8 AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[USERINFO] ([IdInfo], [IdUser], [FirstName], [LastName], [Gender], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [Avatar], [Cover], [Status]) VALUES (N'a2de3b0b-db74-45b0-94d7-c6c0a312d771', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', N'Nguyễn Thị Văn', N'Hạc', 0, CAST(0x67210B00 AS Date), NULL, CAST(0x0000AB89007950DF AS DateTime), N'["1-LDr4tWKUL0RXFf_weyCzmUZgCft8gZ7"]', NULL, NULL)
INSERT [dbo].[USERINFO] ([IdInfo], [IdUser], [FirstName], [LastName], [Gender], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [Avatar], [Cover], [Status]) VALUES (N'a4c692be-992f-4ce3-adae-31e0eb88ed8b', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Phạm Tiến', N'Đạt', 1, CAST(0xC3210B00 AS Date), NULL, CAST(0x0000AB27005D1D7E AS DateTime), N'["1f1sc-1kBZOYQ8lBs1wP7rToTHydG47VT"]', N'["1qlDWC_KO2KrgxXKiPvfll4jIT6WtSawr"]', NULL)
INSERT [dbo].[USERINFO] ([IdInfo], [IdUser], [FirstName], [LastName], [Gender], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [Avatar], [Cover], [Status]) VALUES (N'a625268a-11e9-4f7d-9233-27f53c58251b', N'b3dc917b-854b-4703-b032-36aaf9a6a600', N'Bùi Sĩ ', N'Nguyên', 1, CAST(0x4B210B00 AS Date), NULL, CAST(0x0000ABBC008188DE AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[USERINFO] ([IdInfo], [IdUser], [FirstName], [LastName], [Gender], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [Avatar], [Cover], [Status]) VALUES (N'b59ad0b1-f607-4348-883d-7c8f26891dde', N'52543c92-07e7-4732-86e0-8b7412ddf6f1', N'Trịnh Gia', N'Food', 1, CAST(0xC3210B00 AS Date), NULL, CAST(0x0000ABBC006DFCB3 AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[USERINFO] ([IdInfo], [IdUser], [FirstName], [LastName], [Gender], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [Avatar], [Cover], [Status]) VALUES (N'c2cb466c-6384-4bd4-b443-eabb1082ec70', N'2f3be62e-0eb5-4d3e-ad8c-1fa799745537', N'Trịnh Gia', N' Food 2', 1, CAST(0xC3210B00 AS Date), NULL, CAST(0x0000ABBC00716135 AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[USERINFO] ([IdInfo], [IdUser], [FirstName], [LastName], [Gender], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [Avatar], [Cover], [Status]) VALUES (N'ca1b30c4-ff6d-4607-99b1-6b378ccb3544', N'9f07b194-7d19-4567-b095-a69813a10928', N'Tata', N'Csrol', 0, CAST(0x73400B00 AS Date), NULL, CAST(0x0000AB27008F143E AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[USERINFO] ([IdInfo], [IdUser], [FirstName], [LastName], [Gender], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [Avatar], [Cover], [Status]) VALUES (N'f08ae8d7-c6b5-4c9e-b7b7-d5675db09e7f', N'19c85ac3-d557-4840-be39-31690fad5733', N'Hoàng', N'Huy', 1, CAST(0x7B400B00 AS Date), NULL, CAST(0x0000AB27008F8C00 AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[USERINFO] ([IdInfo], [IdUser], [FirstName], [LastName], [Gender], [DateOfBirth], [LastUpdatedTS], [CreatedTS], [Avatar], [Cover], [Status]) VALUES (N'fe5173b1-f007-4b0c-a8e7-2172b7b54a9e', N'2c6363f0-014a-4424-8942-2ae475fabe02', N'Nguyễn', N'Đạt', 1, CAST(0x76400B00 AS Date), NULL, CAST(0x0000AB27008EC31E AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[USERINTRO] ([IdUserIntro], [IdUser], [IntroContent], [Hobby], [Status]) VALUES (N'15285075-79e2-4920-aa9e-d0cae2082840', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', NULL, NULL, NULL)
INSERT [dbo].[USERINTRO] ([IdUserIntro], [IdUser], [IntroContent], [Hobby], [Status]) VALUES (N'1903e6cb-b13d-44ad-b5f6-94fe93d5febe', N'15720292-3e40-4e4a-925c-992b00f31520', NULL, NULL, NULL)
INSERT [dbo].[USERINTRO] ([IdUserIntro], [IdUser], [IntroContent], [Hobby], [Status]) VALUES (N'2b1970e7-03a5-4fb7-97f7-c8d79e2190ae', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', NULL, NULL, NULL)
INSERT [dbo].[USERINTRO] ([IdUserIntro], [IdUser], [IntroContent], [Hobby], [Status]) VALUES (N'2b685848-d092-4d76-b5ca-22be85223ebb', N'19c85ac3-d557-4840-be39-31690fad5733', NULL, NULL, NULL)
INSERT [dbo].[USERINTRO] ([IdUserIntro], [IdUser], [IntroContent], [Hobby], [Status]) VALUES (N'3ebcf5b9-0d3c-4585-a873-2fa74a992d4d', N'd4d31272-cb28-4b4b-b3d7-78f8c8817b13', NULL, NULL, NULL)
INSERT [dbo].[USERINTRO] ([IdUserIntro], [IdUser], [IntroContent], [Hobby], [Status]) VALUES (N'504e852c-4f18-4137-8153-10f78355f2e5', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', NULL, NULL, NULL)
INSERT [dbo].[USERINTRO] ([IdUserIntro], [IdUser], [IntroContent], [Hobby], [Status]) VALUES (N'7bef6dd6-6889-48c5-8f41-3faec1d8d926', N'b3dc917b-854b-4703-b032-36aaf9a6a600', NULL, NULL, NULL)
INSERT [dbo].[USERINTRO] ([IdUserIntro], [IdUser], [IntroContent], [Hobby], [Status]) VALUES (N'85dfda28-4309-446b-b9c0-3e91065e750f', N'2f3be62e-0eb5-4d3e-ad8c-1fa799745537', NULL, NULL, NULL)
INSERT [dbo].[USERINTRO] ([IdUserIntro], [IdUser], [IntroContent], [Hobby], [Status]) VALUES (N'8bc845da-d3a4-4292-81c8-e9113a58aaf1', N'b78f81eb-0649-42ad-b855-75551462c11d', NULL, NULL, NULL)
INSERT [dbo].[USERINTRO] ([IdUserIntro], [IdUser], [IntroContent], [Hobby], [Status]) VALUES (N'9ad407ac-d5c1-48cf-9178-c515551c8586', N'52543c92-07e7-4732-86e0-8b7412ddf6f1', NULL, NULL, NULL)
INSERT [dbo].[USERMEDIA] ([IdMedia], [IdUser]) VALUES (N'01a8b196-486e-400f-b79a-3f46c28e31c6', N'52543c92-07e7-4732-86e0-8b7412ddf6f1')
INSERT [dbo].[USERMEDIA] ([IdMedia], [IdUser]) VALUES (N'0a20524a-ca74-44bb-ad6b-40f39cc7b1cc', N'b576c13a-a769-48dd-82bc-9e37f41ebd48')
INSERT [dbo].[USERMEDIA] ([IdMedia], [IdUser]) VALUES (N'2791f490-070e-4f26-85db-b94a3f11126b', N'b78f81eb-0649-42ad-b855-75551462c11d')
INSERT [dbo].[USERMEDIA] ([IdMedia], [IdUser]) VALUES (N'2823ae67-c88e-4f48-aef8-dbb42158768a', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949')
INSERT [dbo].[USERMEDIA] ([IdMedia], [IdUser]) VALUES (N'9eb5a853-88b4-43d0-8fa0-82145016553f', N'b3dc917b-854b-4703-b032-36aaf9a6a600')
INSERT [dbo].[USERMEDIA] ([IdMedia], [IdUser]) VALUES (N'9effe861-e959-4e20-9e72-183bbfdf2b74', N'19c85ac3-d557-4840-be39-31690fad5733')
INSERT [dbo].[USERMEDIA] ([IdMedia], [IdUser]) VALUES (N'a5aefbcb-bfdd-4b20-a8fd-b61a5d691147', N'15720292-3e40-4e4a-925c-992b00f31520')
INSERT [dbo].[USERMEDIA] ([IdMedia], [IdUser]) VALUES (N'ae9ba3ca-fa49-4b45-b09a-2786c149e300', N'2f3be62e-0eb5-4d3e-ad8c-1fa799745537')
INSERT [dbo].[USERMEDIA] ([IdMedia], [IdUser]) VALUES (N'b6e2dcd2-5895-4952-a870-7faaa0727812', N'db65b042-e0b2-434d-bc4e-06fb2afebe27')
INSERT [dbo].[USERMEDIA] ([IdMedia], [IdUser]) VALUES (N'b74c5f44-754f-45c9-9286-1ec631fbac09', N'd4d31272-cb28-4b4b-b3d7-78f8c8817b13')
INSERT [dbo].[USERRELATIONSHIP] ([IdUserRelationship], [IdInfo], [StatusRelationship], [CreatedDate]) VALUES (N'01af40ed-2838-4a9c-89ff-0832236bee49', N'704b36e2-25e5-42ec-b0d1-a55a9e5ba507', NULL, CAST(0x17410B00 AS Date))
INSERT [dbo].[USERRELATIONSHIP] ([IdUserRelationship], [IdInfo], [StatusRelationship], [CreatedDate]) VALUES (N'5633e0ff-5b95-4bf8-8797-a151e6b6d380', N'52ad441e-0ff3-4dc7-be3d-91b378ae5963', NULL, CAST(0xE4400B00 AS Date))
INSERT [dbo].[USERRELATIONSHIP] ([IdUserRelationship], [IdInfo], [StatusRelationship], [CreatedDate]) VALUES (N'608df981-de47-4dfe-844b-c4f8ddcb91c0', N'a625268a-11e9-4f7d-9233-27f53c58251b', NULL, CAST(0x17410B00 AS Date))
INSERT [dbo].[USERRELATIONSHIP] ([IdUserRelationship], [IdInfo], [StatusRelationship], [CreatedDate]) VALUES (N'613cd25f-4cf9-4012-bd1f-3b52bc948730', N'b59ad0b1-f607-4348-883d-7c8f26891dde', NULL, CAST(0x17410B00 AS Date))
INSERT [dbo].[USERRELATIONSHIP] ([IdUserRelationship], [IdInfo], [StatusRelationship], [CreatedDate]) VALUES (N'84074360-c6b0-47f6-97b0-794e651554cd', N'a2de3b0b-db74-45b0-94d7-c6c0a312d771', NULL, CAST(0xE4400B00 AS Date))
INSERT [dbo].[USERRELATIONSHIP] ([IdUserRelationship], [IdInfo], [StatusRelationship], [CreatedDate]) VALUES (N'855b9042-bb6c-47db-94b7-3045ddfc8217', N'7740bb26-a951-4678-b985-292310238547', NULL, CAST(0xE4400B00 AS Date))
INSERT [dbo].[USERRELATIONSHIP] ([IdUserRelationship], [IdInfo], [StatusRelationship], [CreatedDate]) VALUES (N'8ec48252-ace5-4767-9fe6-5d8da7ff82d4', N'4f0f1007-a561-4ca4-880a-996f60aea683', NULL, CAST(0x17410B00 AS Date))
INSERT [dbo].[USERRELATIONSHIP] ([IdUserRelationship], [IdInfo], [StatusRelationship], [CreatedDate]) VALUES (N'9318806e-52b6-4002-9d26-6e30a0f27163', N'ca1b30c4-ff6d-4607-99b1-6b378ccb3544', NULL, CAST(0x82400B00 AS Date))
INSERT [dbo].[USERRELATIONSHIP] ([IdUserRelationship], [IdInfo], [StatusRelationship], [CreatedDate]) VALUES (N'9915a3f3-7c27-448b-b6d0-708d94d89b2d', N'a4c692be-992f-4ce3-adae-31e0eb88ed8b', NULL, CAST(0x82400B00 AS Date))
INSERT [dbo].[USERRELATIONSHIP] ([IdUserRelationship], [IdInfo], [StatusRelationship], [CreatedDate]) VALUES (N'9be1f1d1-4de8-44cd-9667-4da5f8d872e7', N'5b29f68b-00e6-4e7c-9978-9800c705ef67', NULL, CAST(0x82400B00 AS Date))
INSERT [dbo].[USERRELATIONSHIP] ([IdUserRelationship], [IdInfo], [StatusRelationship], [CreatedDate]) VALUES (N'a1a1d231-37b5-42ae-bbdf-41e46cb3f18d', N'fe5173b1-f007-4b0c-a8e7-2172b7b54a9e', NULL, CAST(0x82400B00 AS Date))
INSERT [dbo].[USERRELATIONSHIP] ([IdUserRelationship], [IdInfo], [StatusRelationship], [CreatedDate]) VALUES (N'acf9af61-4d37-4708-93fa-27d7c455ca49', N'f08ae8d7-c6b5-4c9e-b7b7-d5675db09e7f', NULL, CAST(0x82400B00 AS Date))
INSERT [dbo].[USERRELATIONSHIP] ([IdUserRelationship], [IdInfo], [StatusRelationship], [CreatedDate]) VALUES (N'be3e88bf-64ea-4759-9a2c-73b1dc2a9d95', N'c2cb466c-6384-4bd4-b443-eabb1082ec70', NULL, CAST(0x17410B00 AS Date))
INSERT [dbo].[USERRELATIONSHIP] ([IdUserRelationship], [IdInfo], [StatusRelationship], [CreatedDate]) VALUES (N'd76ae576-ae71-4d4e-bc0a-5ff3c596e1b5', N'0f4912eb-4bcb-475c-b628-c9b573167373', NULL, CAST(0x20410B00 AS Date))
INSERT [dbo].[USERRELATIONSHIP] ([IdUserRelationship], [IdInfo], [StatusRelationship], [CreatedDate]) VALUES (N'dc969c90-26e3-4d9b-a486-5bc0a1edda85', N'4ba6c41f-c9dd-4018-9bd4-5e328720c3d8', NULL, CAST(0xE4400B00 AS Date))
INSERT [dbo].[USERRELATIONSHIP] ([IdUserRelationship], [IdInfo], [StatusRelationship], [CreatedDate]) VALUES (N'f05b86c8-d8cd-4838-b9d5-70ecc35e6c89', N'4705979e-4d79-4713-ab3d-d7fb9c517339', NULL, CAST(0x82400B00 AS Date))
INSERT [dbo].[USERRELATIONSHIP] ([IdUserRelationship], [IdInfo], [StatusRelationship], [CreatedDate]) VALUES (N'f189cb8f-64ff-4d22-a390-944739b4f208', N'50fb1536-ffed-47eb-b14b-9dabf94d0f6f', NULL, CAST(0x18410B00 AS Date))
INSERT [dbo].[USERRELATIONSHIP] ([IdUserRelationship], [IdInfo], [StatusRelationship], [CreatedDate]) VALUES (N'fcf84bca-5dd2-489a-a8c5-f3e7ceeb8f97', N'4ad649a5-2729-469d-a38e-d51e890f95f4', NULL, CAST(0xE4400B00 AS Date))
INSERT [dbo].[USERSEXCLUDE] ([IdUser], [IdUserExclude], [Status]) VALUES (N'19c85ac3-d557-4840-be39-31690fad5733', N'9f07b194-7d19-4567-b095-a69813a10928', 1)
INSERT [dbo].[USERSEXCLUDE] ([IdUser], [IdUserExclude], [Status]) VALUES (N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'2c6363f0-014a-4424-8942-2ae475fabe02', 1)
INSERT [dbo].[USERSEXCLUDE] ([IdUser], [IdUserExclude], [Status]) VALUES (N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'80a39abd-4605-4afa-819a-b1351c4974c1', 1)
INSERT [dbo].[USERSEXCLUDE] ([IdUser], [IdUserExclude], [Status]) VALUES (N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'8716298b-194b-411d-ace6-ea67509cfb8d', 1)
INSERT [dbo].[USERSEXCLUDE] ([IdUser], [IdUserExclude], [Status]) VALUES (N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'b3dc917b-854b-4703-b032-36aaf9a6a600', 2)
INSERT [dbo].[USERSEXCLUDE] ([IdUser], [IdUserExclude], [Status]) VALUES (N'b78f81eb-0649-42ad-b855-75551462c11d', N'19c85ac3-d557-4840-be39-31690fad5733', 1)
INSERT [dbo].[USERSEXCLUDE] ([IdUser], [IdUserExclude], [Status]) VALUES (N'b78f81eb-0649-42ad-b855-75551462c11d', N'8716298b-194b-411d-ace6-ea67509cfb8d', 1)
INSERT [dbo].[USERSEXCLUDE] ([IdUser], [IdUserExclude], [Status]) VALUES (N'b78f81eb-0649-42ad-b855-75551462c11d', N'9f07b194-7d19-4567-b095-a69813a10928', 1)
INSERT [dbo].[USERSTORIES] ([IdStory], [IdUser], [Content], [CreatedTS], [TypeContent]) VALUES (N'07333c32-2265-476a-85ec-69d0861be4b0', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', N'["134q7fO9hXbCeYs-0XMH23-y0iLswsifr"]', CAST(0x0000ABD40056D168 AS DateTime), 1)
INSERT [dbo].[USERSTORIES] ([IdStory], [IdUser], [Content], [CreatedTS], [TypeContent]) VALUES (N'18b52cff-2fc8-4dad-a460-3ed523cdce39', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'["1fs9v7VZ6oeUygEHqQ13Wtum9Cn4gJ8FB"]', CAST(0x0000ABD7008A3F8E AS DateTime), 1)
INSERT [dbo].[USERSTORIES] ([IdStory], [IdUser], [Content], [CreatedTS], [TypeContent]) VALUES (N'19c85ac3-d557-4840-be39-31690fad5733', N'19c85ac3-d557-4840-be39-31690fad5733', N'["15sJXinUUhA3axZH9UB-yUAUdlMwx07aE"]', CAST(0x0000ABD40056D168 AS DateTime), 1)
INSERT [dbo].[USERSTORIES] ([IdStory], [IdUser], [Content], [CreatedTS], [TypeContent]) VALUES (N'19c85ac3-d557-4840-be39-31690fad585', N'19c85ac3-d557-4840-be39-31690fad5733', N'["134q7fO9hXbCeYs-0XMH23-y0iLswsifr"]', CAST(0x0000ABD40056D168 AS DateTime), 1)
INSERT [dbo].[USERSTORIES] ([IdStory], [IdUser], [Content], [CreatedTS], [TypeContent]) VALUES (N'19c85ac3-d557-4840-be39-31690fadyhg', N'19c85ac3-d557-4840-be39-31690fad5733', N'["134q7fO9hXbCeYs-0XMH23-y0iLswsifr"]', CAST(0x0000ABD40056D168 AS DateTime), 1)
INSERT [dbo].[USERSTORIES] ([IdStory], [IdUser], [Content], [CreatedTS], [TypeContent]) VALUES (N'455d5bc4-84b8-4104-99dd-d0800a28d8d4', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'["11El4eFMSSFujZ2gvSILslRWRbSBEcuW2"]', CAST(0x0000ABD701009324 AS DateTime), 1)
INSERT [dbo].[USERSTORIES] ([IdStory], [IdUser], [Content], [CreatedTS], [TypeContent]) VALUES (N'4c843be3-737a-424f-bc43-2f41a1f60f32', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'["1YnuZVpKkOvn63jKXMPIdltIjuvO_YLQx"]', CAST(0x0000ABE6004F7120 AS DateTime), 1)
INSERT [dbo].[USERSTORIES] ([IdStory], [IdUser], [Content], [CreatedTS], [TypeContent]) VALUES (N'60f2c8d2-d538-45f7-8ee0-ede0d92d8c7a', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'["1VX-GtJh2wh8r1ErjpFBx4syWuD36pSd0"]', CAST(0x0000ABD40056D168 AS DateTime), 1)
INSERT [dbo].[USERSTORIES] ([IdStory], [IdUser], [Content], [CreatedTS], [TypeContent]) VALUES (N'7d2ecb31-9e67-47f5-83f8-147e807524cf', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'["1ivw7UQwSJeOxPUoIDiqw1-wyQ7Tf1H-8"]', CAST(0x0000ABE600519F05 AS DateTime), 1)
INSERT [dbo].[USERSTORIES] ([IdStory], [IdUser], [Content], [CreatedTS], [TypeContent]) VALUES (N'82525ed8-04ec-493d-a94a-73457945f108', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'["15sJXinUUhA3axZH9UB-yUAUdlMwx07aE"]', CAST(0x0000ABD40056D168 AS DateTime), 1)
INSERT [dbo].[USERSTORIES] ([IdStory], [IdUser], [Content], [CreatedTS], [TypeContent]) VALUES (N'84adc4b1-0f44-4610-a3f6-b495f6d8de39', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'["1FnThu2-S9i0VW0Jnt7nG6rDnEr6DJitO"]', CAST(0x0000ABD40056D168 AS DateTime), 1)
INSERT [dbo].[USERSTORIES] ([IdStory], [IdUser], [Content], [CreatedTS], [TypeContent]) VALUES (N'84bde355-50d7-46bd-8113-ad9ce8c7706e', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'["1QnBaYmrhw54koPXcWdIDCP1YN88OW0hH"]', CAST(0x0000ABD7010338F8 AS DateTime), 1)
INSERT [dbo].[USERSTORIES] ([IdStory], [IdUser], [Content], [CreatedTS], [TypeContent]) VALUES (N'85d7b9bc-a6e4-46ca-a6f9-82891a45ae56', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'["1TN6fgqYlPgVr7jZmF5qCZOWnPOAdpX9S"]', CAST(0x0000ABE600515F60 AS DateTime), 1)
INSERT [dbo].[USERSTORIES] ([IdStory], [IdUser], [Content], [CreatedTS], [TypeContent]) VALUES (N'b78f81eb-0649-42ad-b855-75551462c11d', N'b78f81eb-0649-42ad-b855-75551462c11d', N'["15sJXinUUhA3axZH9UB-yUAUdlMwx07aE"]', CAST(0x0000ABD40056D168 AS DateTime), 1)
INSERT [dbo].[USERSTORIES] ([IdStory], [IdUser], [Content], [CreatedTS], [TypeContent]) VALUES (N'bb666ed3-0520-47c1-8476-74b0ead277be', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'["1nPyMiDJmZV1JLydClnSoJVNVTaxq_5DX"]', CAST(0x0000ABD5003CA9B1 AS DateTime), 1)
INSERT [dbo].[USERSTORIES] ([IdStory], [IdUser], [Content], [CreatedTS], [TypeContent]) VALUES (N'd19710a5-d937-42e0-9b86-f36ae2ab8eca', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'["1yWdWzQwiqPOBDbPMr6iZ0ZEbZYf0McH9"]', CAST(0x0000ABE6004F5F04 AS DateTime), 1)
INSERT [dbo].[USERSTORIES] ([IdStory], [IdUser], [Content], [CreatedTS], [TypeContent]) VALUES (N'e300af48-876f-477b-82fa-3a6b58dc4154', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'["1W5Rpw3OsD3IIRDaG3VoDZrplvhGvo0nk"]', CAST(0x0000ABD50019DD2E AS DateTime), 1)
INSERT [dbo].[USERSTORIES] ([IdStory], [IdUser], [Content], [CreatedTS], [TypeContent]) VALUES (N'f38bdbbc-3385-4817-8e9a-f414eb03b66e', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'["1-Q5fcic0fJp_wE_h3pu4Ma9gQViyQ7Ex"]', CAST(0x0000ABD40056D168 AS DateTime), 1)
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'000391fd-fb66-4aac-8c90-abb76a8d428a', N'47fa49eb-82ff-4803-b702-a084801fca16', N'MjRjMjM0OTQtZjkzMS00NTcyLThlZjgtYjI4YWJjNDk4ZTJl', CAST(0x0000ABBC0081F141 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'0116bf4a-c1aa-4ca6-96c9-853241a9c4fa', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YjMxOWExYzUtN2ZlMi00YTRmLWJkNWYtYmI4ZGIyMTRlMzJh', CAST(0x0000ABE600D8F2DA AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'01b29bc4-c38a-43f3-84d9-f04cf45611ac', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NzUyNzFmN2UtZTUyNy00ZTgzLWIzMjctM2Q5OTc4YWRkOTIw', CAST(0x0000AB27007CCAA3 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'02dee42a-8eab-4132-b6dd-41a27bb88921', N'47fa49eb-82ff-4803-b702-a084801fca16', N'MWU4Y2Q5MDMtNDQxNS00ZGM2LTk5N2EtMTY4NWU2OTkxOGZl', CAST(0x0000ABBD00324BAB AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'034dd571-e053-4a7c-bba3-f1e24e2b02a0', N'47fa49eb-82ff-4803-b702-a084801fca16', N'NDZkMTRmNGEtNWJmMS00NTI2LWEzOTAtM2NjNzE5OTY0NTY2', CAST(0x0000ABBD003275E4 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'04181928-483e-4e9f-976a-0cffe6bfbd83', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', N'Zjc1ODU1YWEtOGEwMi00N2E4LTg0ZDEtMjNmNGU0NzM5ODdh', CAST(0x0000ABD200CE77F4 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'042fe3e4-e444-449f-a17b-b8639cf4cd1a', N'47fa49eb-82ff-4803-b702-a084801fca16', N'M2ZlZGE3YzctOTFhOC00ODIwLWE2NTItODc3MGNjOTc5Zjhm', CAST(0x0000ABD4008B67A8 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'04960a3b-c40d-4e71-9880-94d53db79a40', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'OTA0NGM1ZjQtODFjYy00MWQ4LTk2M2QtMTExMjAyZmJhMDVi', CAST(0x0000ABA800264D6A AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'04fb5c0b-ab7f-456a-ad88-dff0f1239a92', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YjJmZjQ4Y2MtODMxNy00ZjJhLWFkYjQtNDY5NTE5OTlmNjIz', CAST(0x0000AB87009FF3D7 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'07a52e0b-b421-49e2-8274-25b159963204', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NWE1NmI3ZTktOGJjMy00ZTIxLWFkYTAtZDM0M2VkNGU1Y2Ni', CAST(0x0000ABA700A3C388 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'084fbc2a-2d8f-4113-9070-3bca2d619654', N'47fa49eb-82ff-4803-b702-a084801fca16', N'MDViMmFmMzQtYWQyOS00MzNhLThkMzUtMTdlMWNjYzJlNTYy', CAST(0x0000ABBD0031B0E5 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'0862c0c4-f627-4aa4-ab85-959c577764aa', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'MjQ3Nzc3MjAtNDMyMC00NWM5LTlmMzYtM2ZiMmJkMjBiOWVk', CAST(0x0000ABD60086655F AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'08ff5641-2348-4eac-9f53-1d0dc9a6a0be', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'MjI3N2VmOTMtYzk5OC00ZWM2LTgzYWUtY2I4NzZhMGU1OGE3', CAST(0x0000ABE600EF0373 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'098ba248-a0e0-434c-8e5e-c5bcd783a455', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YjZjZDEyNTYtNzAyNi00NWI2LTgzMmMtNzM2ZGM1MzZiODRj', CAST(0x0000ABA700A1EA33 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'098cb8dc-55f0-46af-b44f-2c7261614704', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MzUyYTcxMGMtZGNmMi00OTIyLTlmMTgtOTcyNjdhMGY2OWY5', CAST(0x0000AB8A00B92D24 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'0b12b6b2-ed11-43c9-afce-15a5c6fbe142', N'47fa49eb-82ff-4803-b702-a084801fca16', N'YTUxMWNkY2YtOWQxZi00YzRlLTgzOWEtOTBkYzMxMTQzMGVi', CAST(0x0000ABBD00365B10 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'0b76f8d0-6bad-4a6a-b521-b6b300b74e08', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NTM5MjYzYzUtZTJlNC00ZGJlLTlhOGUtYmNmOTQ2M2ExOGJi', CAST(0x0000ABA80024DD5F AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'10ab454e-6604-4b62-adbe-bd9e4d9252f3', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZjRjZmI3MzAtM2Y3OC00M2JiLTkyYzgtZTU3ZDBmMDZjYWNl', CAST(0x0000ABA60093F428 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'13a89f6c-6ef1-4165-8334-bcd045c9cd01', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NDMxZGI5NGYtYmU0NS00ZGE0LWI3NDgtZTAyOTY3ZTBjNGUw', CAST(0x0000ABD20079FB30 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'13cf1363-203a-4185-9a68-48f7b60cfadb', N'47fa49eb-82ff-4803-b702-a084801fca16', N'N2E3MmEyZWItNzY3YS00ZWU1LWE4YWMtMGNhMzkyMTZmYzll', CAST(0x0000ABA700B99A09 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'148deaab-9754-4b15-878f-42a3eb8e970c', N'd4d31272-cb28-4b4b-b3d7-78f8c8817b13', N'MDNjOTdjMjgtZjkyOC00ZjFiLTg4MTAtN2JlZDhiODIxMmM1', CAST(0x0000ABBC0079F3FB AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'16049813-8002-4bf7-91fc-9daff0cef029', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MTg2NDIwMzItYzc2MC00MDI4LWIxYjMtZDU4ZjA1ZmY3NWYy', CAST(0x0000ABD70055DD25 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'1605e5b8-6dea-4605-a6a9-635710b1980b', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NTc4ZjE5YzItOTUwNC00NDkyLWI1ZGItYzhmNzU5NGJhYjMz', CAST(0x0000ABD5007689DE AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'166cbef3-9723-4cf5-9e1e-f16800796960', N'47fa49eb-82ff-4803-b702-a084801fca16', N'Y2FhZmE5ZTMtOWI2ZC00ZDY4LTkwZWYtZGRhNTU0Nzg2YzYy', CAST(0x0000ABBD002E941F AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'17820d3e-f019-429d-81b2-ea5221e2e5db', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NjFlMWEzYmUtM2EwYy00ZDQ1LTg0ZjctMTZhZDVmNTE1NGFh', CAST(0x0000ABD60086E548 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'188a095d-20c2-4522-802d-17de0bbb4b95', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YTY0NDlmZDYtMGU4ZC00NThhLTk4MzItMWY5NTlkM2JkODc3', CAST(0x0000ABA80075DFCD AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'19981a85-f446-4dcc-8586-694fb26ed395', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YzViMjI5OTQtM2QyNS00YmM5LWFhYjgtNDM3ZGRhMWY4YTI4', CAST(0x0000ABE600490A12 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'1a0a96f0-9453-4a89-8331-cd3b25a74a60', N'd4d31272-cb28-4b4b-b3d7-78f8c8817b13', N'MGRjMTU1OGMtZWZlYi00OWIxLWJmNzAtMTgzMDRiN2U2ZTUw', CAST(0x0000ABBC0073E938 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'1a2615b7-e95c-4bd5-abf9-8454c28548de', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'MmQ3MTAwM2MtZmNlNC00NzRjLWFlZmItNDFmMGMzMDkwN2E4', CAST(0x0000ABD50031FBFB AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'1b135e2f-0b3b-4688-9267-7e5fb9107fdb', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ODA3ZDFkYzctOGVjNS00NGZmLTg4NDktMTZhMmQ1NmY0MDI5', CAST(0x0000ABCB00388C2F AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'1c12d758-cbd9-44e9-8819-c4f702bde3cf', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZDc4Yjc0N2EtYmY2NC00MTE3LTgwNzAtYjc1NmExMjYxNTJm', CAST(0x0000AB87009DDADA AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'1e36909b-a880-4671-b8e0-987f345aab0b', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MTE2ZGFlZTQtMmJlNS00NjdjLWFmNjMtODdkYWYwMDEwOWEw', CAST(0x0000ABA700A2219C AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'1eebda8d-35d0-49ea-bd06-55b245c33d6e', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ODQxNjdlMzMtNDNhMS00NTFiLWJhMWItODZlYmQ2ZDkxMjg1', CAST(0x0000ABA600A48DD8 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'1fc6b6a7-896f-4743-a827-af65015f5b15', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'OGNlNzkxZGQtOGViOS00YjdlLTliYjEtZTdkNzY2YzllZDUy', CAST(0x0000ABD4005AF7AA AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'20d7d48a-c289-4112-be37-88debbba3dc1', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MzFjZGEwYzUtNjAyYi00MTIyLTliNTktNWFmZGQ2ZTUxNzc3', CAST(0x0000ABA800392927 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'220f941f-1374-4aec-9b89-bbc2acec928e', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MzBjYWVkZWYtNWE4OC00MjRmLWJiOGEtZDg5ZDExMDFlOTE1', CAST(0x0000ABA800371A79 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'2456f734-26e9-43f0-abd5-174ab9e5ab96', N'd4d31272-cb28-4b4b-b3d7-78f8c8817b13', N'NjhlNDkyYmMtZTI2Zi00MTE2LTkzMzYtYTNkOGVhZTY0NTI2', CAST(0x0000ABBC0074C521 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'266f2e42-b9b4-4a9f-904a-8de959d5705e', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YjIzN2FhNTItMTFmOS00MjMzLWEwNjUtMTY1NTUwYzljNGIw', CAST(0x0000ABD70087898F AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'26a53687-289a-407c-8e47-5fbf4b26ac09', N'47fa49eb-82ff-4803-b702-a084801fca16', N'OTRjODg4ZDYtMGM1MC00Mjk2LWEwOTctMjY1MTRjYmVkYTBm', CAST(0x0000ABBD0034C3FC AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'2703b3ee-8c41-4ebb-8944-00352fd7137c', N'b78f81eb-0649-42ad-b855-75551462c11d', N'ZjU5NzRhM2UtMWRiZC00NDVlLTlkZTUtNThhNTgyMDRjMjA3', CAST(0x0000AB27005E0C17 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'2718d200-20c7-46da-9080-a500bd173118', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Y2ExYjc1NWItZmJjZC00MTQ5LWE3M2YtMmY5N2RhMmI5ZTAw', CAST(0x0000ABA800250F08 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'27bbc6b3-e6bd-45fd-8b65-608d0760a7e0', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'MDViZDA2NmItZGQzNy00Mzg0LTk5MjYtZGJmNmQ0ZmM0N2Yz', CAST(0x0000ABD600F35426 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'29622032-9365-4306-a1c8-ff6ca38fe4a1', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'MTM4ZDU2YzItOWQ4MC00Y2QxLTk1ODQtZGEwYWQ0NWRjMGM4', CAST(0x0000ABD500EEC19B AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'29f3bfb0-9a0b-47e3-a5b3-8486f85ca2eb', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MjYzNzAwOGQtNDQ2YS00ZGIxLWE2ZWYtMTI2ZjNiM2U1M2I1', CAST(0x0000ABD2007A3C66 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'2c95763c-d7b7-46ca-be1d-3a58af749d3b', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NzAwYmI5MGEtNGQ0MC00NWQ2LTkwYjMtNmEzNTkxODNjMGM0', CAST(0x0000ABD60085F5D5 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'2d10394f-fdfd-4d87-beed-ca0051d1ae2f', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NDY1MjVjNTgtMDRhZS00NjExLThjMmYtYzkwZjA4NzIxZTRk', CAST(0x0000ABC5006DE2A6 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'2fddee2a-0ab5-4a1e-80fa-90f223daed37', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NWE3MzZjMWUtNWJjMy00MTFlLTk1MTUtMGJhYWM4YzgxZmUz', CAST(0x0000AB8700968128 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'30179533-ebe0-4557-bab6-6eb58c857c60', N'b78f81eb-0649-42ad-b855-75551462c11d', N'NjQ2NjM2MzEtODc5Yi00YWQ1LWJlMmYtYWY1MTQ5ZThjYjMw', CAST(0x0000AB27009A9CF6 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'321a90bf-2f64-402a-b2ba-e7a0449a8426', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MzYyOGJiM2EtYjhhNS00NTQwLWIxNzYtZDVkZWQyNmZlYmUx', CAST(0x0000ABBD00716588 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'327979d9-8071-4fb6-a1a3-d8d5d244b1b0', N'd4d31272-cb28-4b4b-b3d7-78f8c8817b13', N'MTJiY2Y5MTYtODgwZC00ZDY2LTgwMmYtN2RkMDhkOWRiMjQx', CAST(0x0000ABBC0079B5D8 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'3323ad45-839b-478d-a511-80f8124be03a', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZDdjMjBkZTYtNzI1ZC00MDM4LWI2YzItMTU0YWU5YzE5OWIy', CAST(0x0000ABD2007BEB71 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'3367d715-9f39-40aa-8318-8839b30aea12', N'b3dc917b-854b-4703-b032-36aaf9a6a600', N'OTA4M2I0YTgtNWMzZC00MzY3LTg1ZDYtODJjNTNiOWVjOGE2', CAST(0x0000ABBD0068A5C4 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'336dc22e-4d9c-4c6a-ae8c-a7a795a2dbbb', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YmI0MDU4NTUtY2RmNy00YzExLTk1MzktOTJjODI1MDI3YTA3', CAST(0x0000ABA700A6C22B AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'34534811-29d5-49e7-b51f-987b455e3271', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MWQ3MzNhNjQtN2VlNC00NGJlLWFiNzEtYmQ2MjkxZWY3M2Ni', CAST(0x0000ABA800724948 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'366e6290-ca5e-463b-825c-c750cc314ea8', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'OWJhYjZiOTUtYWJlYy00YzAzLWJiN2EtMGRlODYxMjEyZjZj', CAST(0x0000ABCC006B8CFF AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'37022bcc-3eea-4951-bc47-5f94cb181c9a', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YTQ5N2U2YmYtMDE5ZC00MTRiLWEzN2MtMDMyNTA1NzIxYjE4', CAST(0x0000ABA800705EF8 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'38244dc9-ea9b-4efd-9507-3e5238fc5695', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ODRhZDFhYWQtODI0Yy00OTVmLWFiNTUtMzA0ZDI2MWI1ZGQx', CAST(0x0000AB270083C541 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'38691375-c27f-4e1c-be71-acd0768cac2b', N'b78f81eb-0649-42ad-b855-75551462c11d', N'ZWQxOGExMmUtYWIwNC00MDBhLWJmODgtZTAyMzVkN2Q2M2Y3', CAST(0x0000AB2800527159 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'388baa46-a105-475b-8160-accefd00e1fd', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'NGNkOTU5OWItM2NlMy00OWEyLWJiMmItMTM5NGMxNTA4YThm', CAST(0x0000ABD600857294 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'3a34fb8b-8e90-4547-968f-48926764b042', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', N'ZjJlNDMxYWMtOWYxZS00ZjU5LTlhOWYtOWFhOTUwYTI4NzM5', CAST(0x0000ABE800984381 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'3ab123d6-a2e4-478b-8bf4-b11c9f7ff765', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'ZGQ2ZmZhYTQtMjg4Yi00OTA2LTk4NmEtZjA0MjZiZjI4NDI2', CAST(0x0000ABE800997252 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'3c5625fb-e38b-467a-a3d5-88afe9490551', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZDRmZGNjOTAtOGJmNy00NWYxLWI3MmQtMzU1YzFmNzkwN2Nl', CAST(0x0000AB270099F5EE AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'3cbfd275-3a92-4931-a78a-b1092766bd33', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Y2Y5ZTlkNGQtN2RlNS00NjJlLTlmYzUtOWEyZDZiNTBiNzM1', CAST(0x0000AB27008ED67B AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'3e446076-54fa-4965-ba88-40d302ed7784', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Njc5ZDE0MWMtYzEzNy00MzY0LWIxYmItYjhjMDg5MThlNTI2', CAST(0x0000ABBF00FD6AE9 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'3f7042bd-4df4-4651-9b14-665c8e63f1a4', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YTM4MTYxN2QtYzViYy00NzE1LWI2OGEtM2FmYWFlMzQ5ZTNl', CAST(0x0000ABA700A3EB2D AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'3f970bfa-3a92-4524-8a42-a7d790fc3474', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MDY2YTgzZTEtNWVkOS00MjMyLTlhZWMtOTcyN2FmMzUyMzVk', CAST(0x0000ABA700A3849A AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'4089b7b6-9d06-4580-8047-a331e1deab27', N'd4d31272-cb28-4b4b-b3d7-78f8c8817b13', N'ODZiNzEzZDUtNjUzYy00MmJmLTlhZDktMzQ2N2ZhM2IxZjU4', CAST(0x0000ABBC007C0A15 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'41f65229-1d2f-49fc-a2e3-6fe0a0fdc401', N'47fa49eb-82ff-4803-b702-a084801fca16', N'ZmM0YmVhMDYtMGRjOC00YWJmLTlkNDEtMDJkNjBhYTVhMjFj', CAST(0x0000ABBD0033ED83 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'423346cb-43ad-45ef-b20b-170a1a67db47', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MzgyNzUwZTYtY2I0Mi00ZDljLTg5NmItYTM2MGEzNTNlNzBl', CAST(0x0000ABD20079E9EB AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'4298f4a8-283b-4b24-8fe5-8d529e29d96d', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZWNiNDU4ZmYtMTdjYy00ZGRmLTk1MDUtNDQ0N2Q1NWUxNTU1', CAST(0x0000AB8B007C984C AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'45462061-aba5-4652-90b7-4408287ea0c5', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NTJmMDY4ZTMtNGM5NS00OGMwLWEwZTAtYjUwYzU2YzNhOTc4', CAST(0x0000ABD7008897D5 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'467b02c4-31fc-48d0-8426-a4d9ed30b9ad', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'OTUzNzVjZjUtNTAzNS00ZjBjLWExOGUtMmVhZTE3YmU4YjNj', CAST(0x0000AB8B008CF5F4 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'47e6e59b-4dd4-4ae5-aeb5-a31d056e51ee', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MjA0NDNhZTctNzNiOC00YjgyLTg1ZmItZDg1ZjQ5YTllNGRm', CAST(0x0000ABA80035C945 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'4972e912-09f0-4e1f-9022-bc6c6ac5e8f8', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NGRhZjBkMzQtZTg4Yi00N2MxLWFkZDgtNmY4YjI0ZjQ5ZTE5', CAST(0x0000ABDA00441F11 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'499d82fb-5add-4492-aaa8-c94e6bdbac36', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZDc1OGVlNzAtMWFjMi00ODE5LWE5OWEtMmM0MDE4ZWI5ZjVj', CAST(0x0000ABD7004A31B7 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'4c930883-0476-4105-b66d-ea822b927a7b', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ODUwOGI4MTEtZWVhYS00NzdjLTlmMTctMTM5ZjUwZGFmMjhm', CAST(0x0000ABA80074A74B AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'4ca198d0-5150-4235-a01e-2b921f4ae69b', N'b78f81eb-0649-42ad-b855-75551462c11d', N'Njk4YjBmNzQtZGE0NC00MGNiLWI4ZTEtNjliYTY2NTY4MGIx', CAST(0x0000AB27005E6845 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'4ec13db8-e047-4889-9409-f8228678b8c0', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZjQzYzIyODgtOWIzMy00ZTkwLWI5YWMtOGU2N2ZhMzc0NTg0', CAST(0x0000ABA800734B6F AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'505071f9-5267-4c1f-8604-dfe087ab6102', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MWJiMmE3OGEtNzEwYS00YTc0LTgwNDAtNmEwYjBkODM5Nzkx', CAST(0x0000ABD200BEB5B6 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'5094443c-096a-474c-b232-77721d6d4129', N'47fa49eb-82ff-4803-b702-a084801fca16', N'NDJmZGNlNjUtYThlMy00NzM4LWJhOTUtYTk4ZGJjZDc5OGUx', CAST(0x0000ABBD0032A6FE AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'50a21d62-6661-4e83-9bba-0c1636577a52', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Zjg3YzQ0MDItNzMwMy00ZWQzLWI2YmUtYjkxMDhkNTI3NWUy', CAST(0x0000ABBD0065554D AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'5336c1ef-ae73-4b77-8ff9-fcff605fafeb', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZDE2Mjg1ZmYtOGJlMi00YzYzLWJiYTgtNzk2MDBiNmQ4MDVm', CAST(0x0000ABD4008FC0D7 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'53a62122-ea0a-41c0-ad74-b00db02b2049', N'47fa49eb-82ff-4803-b702-a084801fca16', N'ODc0YjA4MDYtY2E5ZC00NGI1LTkyNjEtM2MyNTIyMzFkZmNk', CAST(0x0000ABBD00369F62 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'541ee96e-2bdd-404e-979a-f41313c0c080', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZjczYmM4YzMtYTZlYS00YTYzLTlhOGUtNGU0MDhmMTQyZTNl', CAST(0x0000ABA6007F8C74 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'54253486-9f49-45ac-937f-bef619da60cd', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YjQ3ZjA0YWYtNGVlOS00ZmMwLThhODEtNTc0NDIzNGIyNTEx', CAST(0x0000ABE8009881CB AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'580bf046-a482-4951-8cbf-3860c8958ea9', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NzU5NzYyMDEtODBhNy00YzY2LTk5YzYtOTkwYmRkMWE5YmRk', CAST(0x0000ABA800372BFC AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'582de9ab-e9aa-404e-a1d6-76cb7b000c7f', N'd4d31272-cb28-4b4b-b3d7-78f8c8817b13', N'YzgzOTA2ODktY2ZiNC00YjAwLTkxYjUtMDk2Y2NlMWUyMjUx', CAST(0x0000ABBC007F9497 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'5984afb2-8525-470b-a800-0a80512f3e5f', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ODZlMWUxYWEtMDZlYy00N2QyLWEwNWMtZWZiZGI3YjFmMmQ1', CAST(0x0000AB8700890EDF AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'59ffd34a-469b-4653-8d00-eb4386434797', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', N'ZmI2ZjBjMjYtOTRmNS00ZmFmLThjODctMTFmMWY3ZTU3Mjk4', CAST(0x0000ABD4005AA210 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'5a1c6039-acbf-48ca-b2fc-f8c440b7e933', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MWNjNGQ1OGItYTMyMy00MmM0LWE1MDgtNWQxNTlhNzk4YWRi', CAST(0x0000ABD200D734C1 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'5abbe81e-055a-4209-84d6-5caf2f658643', N'b78f81eb-0649-42ad-b855-75551462c11d', N'M2ViNzk1Y2QtYTc2Zi00MGEwLWI4ODItMTc1ODQyZGY3M2I1', CAST(0x0000AB27009546E5 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'5b0765c6-c72e-4133-a4b6-6f2298b534b8', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NTczZjJhZTgtZTg1MC00NWQ2LTgxYWYtNmNlYWQzMTdhMjUz', CAST(0x0000ABA6008139AF AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'5c0300ea-ec33-4cf7-9abb-3e888efb2496', N'b3dc917b-854b-4703-b032-36aaf9a6a600', N'ZjViY2FkZjEtYjI2YS00YzAzLTk5NzAtNDgyOTFjNWVhOGM3', CAST(0x0000ABBC0082F8CD AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'5d9efb82-6a5e-4a9c-95c8-8dc6a6d15d12', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'OTNmYTVkNmEtY2M4NS00MTkzLWI1NDUtODdkY2FkODU5Yzgw', CAST(0x0000ABD500EEF554 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'5dd1ff29-d577-49ef-b3a0-a00f3978d46b', N'd4d31272-cb28-4b4b-b3d7-78f8c8817b13', N'NjUwNjIzMWQtZDhjMi00ZjJhLWFjMjctYWRhNTYyZDRkMGFj', CAST(0x0000ABBC00801AA3 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'5de30271-edf3-4bd7-837d-8f6ac0961e6a', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'MGQ5NjgxNTUtOTZlMC00NGJkLWIxZjItOWQ4N2MyOTVlZmMz', CAST(0x0000ABD4008BBC0E AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'5de47a58-ee86-4a89-a4ff-6e461e28e58c', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'M2JlZDc0M2UtYTg4NC00NWZhLWJiYzMtOGYwNjUyM2YwNDE3', CAST(0x0000ABD700877572 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'61f77969-7193-490d-819e-34bbb9528b69', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZGEwNjY5N2ItMWM4ZC00ZDg0LTkxNDAtMzJkY2FjNTUwNjc0', CAST(0x0000ABD2007DCDA1 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'62d64efa-d82f-4714-b9cb-4e318ee7d4ee', N'b3dc917b-854b-4703-b032-36aaf9a6a600', N'MWZmYzNlZWYtN2E5YS00NWQzLWI1NTAtODU3YTljNTllZGZi', CAST(0x0000ABBC0083A1A9 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'646675d8-6eed-49d7-a664-fa7fadc167dd', N'd4d31272-cb28-4b4b-b3d7-78f8c8817b13', N'ZTU3YmJhOGMtNzgwYy00ODY4LWJjMjItMmFkNTdjMDk3ODg1', CAST(0x0000ABBC0072E2FD AS DateTime))
GO
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'65b93b1e-ecc0-4a8b-b78c-c85284343be1', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MWVlZjc5ZjItNDQzYS00Njg3LWJjMGMtMWMxNzg1OTVkM2Nk', CAST(0x0000ABBD00382166 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'66cd843e-d956-486f-b1ea-8374ec4b7b77', N'd4d31272-cb28-4b4b-b3d7-78f8c8817b13', N'ZWJkMTNkZGYtMjY3OS00OTQ4LWIwMzktMWQ2MGEyZjcyOTJj', CAST(0x0000ABBC007F50BF AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'66e76de6-c7b8-4ab9-9607-6a8290a04760', N'47fa49eb-82ff-4803-b702-a084801fca16', N'MzcwZGZiYjAtNDQwNi00MTdhLTg2ZGMtYzZjZjJjN2EzNjFk', CAST(0x0000ABBD002F485A AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'6724b753-6d4a-4c08-ac75-3194039a5107', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZjQwMmE5ZWMtMWFlMi00NDU5LTk3N2UtZWM3OGEwMmQwODAx', CAST(0x0000ABD2007CB29F AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'69303649-e0ac-4e8f-944c-717cc9bcd07e', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'YzdlODAzNjYtMTgxMi00MWU2LWJhMzQtNTBiNDdmNjRlM2Y0', CAST(0x0000ABD4008EFA30 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'6a2273fb-1268-4a0e-ada7-1991a60ed4cd', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NWM3ZjAzMjEtMzJiNC00MGMzLWIxN2YtYTdkN2FlOWRlMDM2', CAST(0x0000ABA8007584FA AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'6a4c7fb2-a78d-4daf-9246-1b8057cf5608', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MjdiOWNjMjItYWU0ZS00MjcyLTgyYjUtNjBkZDAxN2E0ZjBj', CAST(0x0000AB8B007C25E8 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'6a75aad5-3d6e-4b67-8c81-1a38c7046fcb', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'M2Q3YjI5ZWMtM2JjNC00NjRiLTgxYjItMzQ0MTg1NzhhMGU0', CAST(0x0000ABE600E588BA AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'6c266cfc-3aaa-4ece-928e-8e542b3802db', N'd4d31272-cb28-4b4b-b3d7-78f8c8817b13', N'YmQ5NmUyOGUtMDM1Yi00NjBhLTkwMjAtNzMxNjAyM2MwZDdh', CAST(0x0000ABBC00807388 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'6ccb79c0-7f49-4e43-b8a7-69859da99b2e', N'47fa49eb-82ff-4803-b702-a084801fca16', N'ODI0YzE0OTMtYzU3My00NjQyLTk2ZTctNzFjZDEzODcwMzVm', CAST(0x0000ABBD002E025D AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'6d2c9935-4c45-4dc7-aa01-7966ab6e0ab1', N'b78f81eb-0649-42ad-b855-75551462c11d', N'ZDZmZmE5YzEtODkzNS00NTcxLWI2NDctMDQyMDVlNzFlNWU3', CAST(0x0000AB2700992FF7 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'6ea62a2f-7721-4256-a477-bb974f515711', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'YjgxZjNlMmQtNGE1MC00NGFlLTkzNDUtOWU4OTQwZDgyY2E5', CAST(0x0000ABDA0053943B AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'6f9f61ca-2ce0-44d5-b462-f244ef0dcfa1', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YzBiZDU3ZTUtZDFiZS00MmM1LWI2YTktOGU4MzlhYTM2MThh', CAST(0x0000ABD5003002FD AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'6fa9ae8f-22ab-4718-93d9-b056ddc8b891', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZjM0ZjMwNDAtNjY5NS00Y2U0LWEyMmYtY2ZhYTM2YzBlMThm', CAST(0x0000ABD700498F26 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'70c63fc5-010e-43b4-9d8a-d81b5cdd4cc0', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Y2M1MDYzNjItMjM4Ni00MGIzLWIzNmEtNzQwZDJhNGEzMjY2', CAST(0x0000ABA700A6587A AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'719031bf-746c-49d7-98e3-0e34b4cbcc55', N'd4d31272-cb28-4b4b-b3d7-78f8c8817b13', N'YmIzYTI4MjktMDkwZC00ZWY4LThhNmUtMWYwODc1YmE2OGJm', CAST(0x0000ABBC008133B3 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'7209c02b-9daa-47b4-814e-0157611fb693', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'OGJlZjVmOWItOWZjMS00M2RhLTkzMzMtNmJjNmRmNTYxMDIx', CAST(0x0000ABD600F571F5 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'72c4b223-f590-4def-8f6b-ec42ae0b93af', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YzZhNDEzNWEtNzg0OS00NWNjLWJlYjEtZWI3MjNmYTVkOTg1', CAST(0x0000ABA8003A559A AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'735d4c05-b811-4d35-88c6-bc84164aa965', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', N'ZWIxN2M5ZjAtMDJkMi00YTcwLWE5NWUtOTY3ZjcyNjM5YzY2', CAST(0x0000ABD4007DD717 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'74c4b7f1-4e98-4434-bdd2-cda82db51ea1', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ODU1YWVkZmEtNTJjNy00MWFkLTg3ZTYtZDc0ZDI0ODkxZTgx', CAST(0x0000ABBC006D6580 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'74f6eeed-3692-4a58-be35-18904f01c453', N'd4d31272-cb28-4b4b-b3d7-78f8c8817b13', N'MmY1YmZiZGQtMmUyOC00YWVjLWE0MDItMGE1YzkxY2NhMmFh', CAST(0x0000ABBC007CE94A AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'75507d8a-4f9e-4617-9655-be978cfe248e', N'47fa49eb-82ff-4803-b702-a084801fca16', N'YjE0OWE4YmEtNmQwNy00NmRlLWIwMTktYzFmZmYwMGJhOWMy', CAST(0x0000ABBD002F8549 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'7578d437-0cd2-4683-bb8d-8816d9245e36', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MjIxYzAzZGItOWEwZi00MTZhLWFkYzgtYWQzMjEyYjkzNTBm', CAST(0x0000ABA6009269FB AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'7650315d-5cc9-4960-87f1-f315e279959f', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NmU3YjFhY2QtMzkyNS00MDgyLWE5ZjYtM2Q2OWE2OWU3Mjlh', CAST(0x0000ABD70103669E AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'76a27d94-3c84-454a-b766-222c67c499cd', N'b3dc917b-854b-4703-b032-36aaf9a6a600', N'YWY2MmZiMGQtNjFmZi00OGU2LTg5NDYtM2ZiMDgyNTdmMDIx', CAST(0x0000ABBD0068416A AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'772a6c1d-504e-4d28-a5cb-584cc379e141', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'MWQ0YjVmY2QtZjg5Yi00OWI3LWE1YjgtNmU5ZmY0NWJjMzRi', CAST(0x0000ABDA00729E15 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'77d99c59-4bc9-40ed-9e23-927c850b677d', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'OTg3MTJmNjktNDY2ZS00NTU3LWFhNzMtNTdiM2Y3ZmE4ZDNl', CAST(0x0000ABD6008A0901 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'791acc82-6e5c-4396-9de3-f58d3e082ae9', N'47fa49eb-82ff-4803-b702-a084801fca16', N'YWM0YzBmZjMtY2Y4Ny00NjIxLTkxMzMtZmJhOWJlZGY5OTNk', CAST(0x0000ABBD003061B0 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'7bc881be-15e7-461a-9b76-5ee296f01434', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YTk1ZDVlMTMtMzVlMy00ZTM3LThiZDgtYjE2NGIwZjZmN2Rh', CAST(0x0000ABD600F641A2 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'7c48bd2c-0756-400b-8f45-809d26907bae', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NjlkOGZjMDUtNmFmMS00OTRkLWEwMzAtODczMTdhYjg1M2M4', CAST(0x0000ABE5004CD3A1 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'7c5d39f2-363d-4686-980c-92f6d06800fb', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YTcwMTU5M2ItNDM5Yi00YTg4LWIzNTQtYmYzMmEzMWRiYzVi', CAST(0x0000ABE50044918C AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'7d4c69c1-1b2c-467c-bf6f-098441f92c75', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZGUzYzgxZDMtNjFhZS00NTVkLWFiYTctNDllZDU0MjdmZDIz', CAST(0x0000AB8B0085FC57 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'7df3e796-76fb-44fe-85c8-9c3b0142c8a2', N'd4d31272-cb28-4b4b-b3d7-78f8c8817b13', N'MDIxMTNmOWUtOGVkYi00NGE5LWExOTgtYzU2ZmQyN2ZkMmZi', CAST(0x0000ABBC007DB1FA AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'80319b5e-6d7c-415f-85a8-c3c247f77a1e', N'47fa49eb-82ff-4803-b702-a084801fca16', N'ZmEzOGRlYTAtZTI2NS00NjdiLWIzYjQtOTgxOTI1MDRmOTZj', CAST(0x0000ABBD0032ECA1 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'810dcb86-671b-48bc-b239-0fa05a5caca5', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'M2QwMjNmNzUtNjY4ZC00MzVjLTk1OGQtMTI2NDg2M2M4Njk2', CAST(0x0000ABD70101997D AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'8124e5a8-18dc-4b82-9f71-5065dd5daec5', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MGEyOTc4NjQtYzAzNS00ZjY3LWE2NDYtMDU2MzU3ZTU4Yzhk', CAST(0x0000ABA8007230A5 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'820dc4fc-6eec-4d13-941b-914ced4b0d4b', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'YzNmZTQzMDEtN2RkMS00MWZmLTliNWUtZmRmZmM5MmI5ZWQ4', CAST(0x0000ABD800546077 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'821d2ef9-6ef3-4f50-b1f0-9477e829a4a8', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ODlkYzMwMGEtOTU1Ni00NDBjLWE4MTYtMzQyYTY4MDAxZjkx', CAST(0x0000AB28004D2EBF AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'8339793f-73ce-442a-8af2-ca05a6d24680', N'b3dc917b-854b-4703-b032-36aaf9a6a600', N'NTUwZWZkZGEtODA0Yi00M2EzLTkyOTktZjY1MWE3YWY2MGMw', CAST(0x0000ABBC00834D58 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'834ef897-11ab-46a0-8f76-34ae2cb60158', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'MDFmYjhjMzEtODdlYi00MGJlLTkxMGYtOTJlMzgxZjA4NmU5', CAST(0x0000ABE600D9827F AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'843921fb-9507-4a8d-8f98-2bb236863198', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'OTA3YmFkZDktZDFjNS00ZjZiLTg2MTUtMjFlYzZiYzhkZTYw', CAST(0x0000ABD700E6D0EB AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'856e047a-97d3-4f42-b5fc-715e705f2480', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'OWY3ZmY2NTItOWI5NC00MTdlLTgzYjctMTJjYWQ2ZTUwNmE3', CAST(0x0000AB270094E6C4 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'8704a95c-e73a-49c6-9218-59531aaf9f86', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'OTllODliMTMtYjAxOS00YTEyLWE3NTUtMTFkNzkxMDgxZTM0', CAST(0x0000ABD2007C7E70 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'874de4fd-e1ad-40bc-8bac-a7632be4e02b', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MDU0YzcyOWUtMWIxZS00MmZiLWE2YTItZWU2MDljMmY2ZTY1', CAST(0x0000AB8A0097AFCA AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'8915d808-45be-41ea-a8f0-5fefe1e5ed0c', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ODdiZTNlMmYtNWNmMS00MzM2LTkxMmItNzMyZWQ0ODdjMGJl', CAST(0x0000ABC10041D5A1 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'89daa4c6-9658-43cc-b1ef-a27663c32038', N'd4d31272-cb28-4b4b-b3d7-78f8c8817b13', N'OGQ0YWI4ZmEtMDQwNi00OTNlLTk5NTUtMGI4ZjZmNTgzY2Ey', CAST(0x0000ABBC0076202D AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'8a7d0edf-c674-4f10-9730-8697c8aa3883', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'OThiN2RhOTItYTA0Ni00Yzk5LTgxOTEtOTYxY2JkZTA4NzQ2', CAST(0x0000ABA80036C7AA AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'8b813072-fdeb-4c97-9081-334571230e70', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'OTUwNzAxNjQtMjQzNy00MzQwLWFkODctYmZhZjk3NmUzNjk1', CAST(0x0000ABA80070C07F AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'8c3e4619-8ecf-429c-8d9e-2a244b2d0133', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZWZhZDliM2YtZjJjZS00MWMxLWEzNmEtZmI1MDg5ZTQ5NjQ1', CAST(0x0000ABE800998321 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'8c8b2e44-d196-4dee-a5e6-66e67ff83bbd', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MThjODYxMTItZWVlNS00MjY2LWFmZjMtZmVhYWViYzU4YzI4', CAST(0x0000ABA8003A0C20 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'8ca6324e-fdab-4f4d-bc1a-817306850dcb', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YTg2ZTg3YzctOGYxYS00MTVjLWI4NWItMmYwZDYyYjc5ZWEw', CAST(0x0000ABD300527A61 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'8cf0dea2-a6b8-4bfe-b69e-320c26dd8025', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'OTM1NjFjYWMtZTQ1Yy00YzI0LWJkNzYtYWRhYTE5YjQ1ZjJi', CAST(0x0000ABC200E5C766 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'8dce5696-778a-4bcf-b667-0e6fec103d41', N'47fa49eb-82ff-4803-b702-a084801fca16', N'YzJhMzc0MmItY2FlMy00NmQ4LWJmNWEtZmU3YTExMDU1ZWMx', CAST(0x0000ABBD0031676E AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'8fb8c273-1985-427d-b0fd-117193a23036', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YzcxNDdkMTMtNzViMC00YWM4LTk4NWUtNWIzYmQ1NDUxOWVk', CAST(0x0000ABA80026AF7C AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'905f4ffa-4806-4c92-a558-5667e4a6b3b3', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NWNiOGVmOGItNjA0Yi00YmVhLTk5YTMtYWZkMmY5MWQ1ZmUw', CAST(0x0000ABA8003B833D AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'90ec6b48-37c0-48d7-a4dc-feedddb20e17', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MThhZTFiNDItOGQzMy00OTIxLTk0OWMtYWQ1MDY1YjkyMzYz', CAST(0x0000ABA80026944E AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'930277f4-08cf-41b9-adf5-7450024a4bac', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YjBmMGIyYWUtODFlYS00MzIyLWEwYzYtYjc3ODIyODNhZTNh', CAST(0x0000ABD300521A33 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'931e5ef4-ec8d-434b-8b79-6511ce9093d3', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MmQ1NjM4MDgtZjFkMS00MWY0LWEwMGUtMzM2NThmNzk0ZWVj', CAST(0x0000AB8B008E0F68 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'93666100-b888-4b79-89ab-89a7dda0f455', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', N'YTBmZWQ4YjgtYmM0YS00NDAxLWFiM2UtZjMxN2IzMjI4ZTBm', CAST(0x0000ABE800998FAE AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'93d40968-fb85-40f4-a320-d013ae3d0ac1', N'47fa49eb-82ff-4803-b702-a084801fca16', N'OTQ2YzlhZjktMGQxYy00YTE3LWExY2QtMjk2ZjQ3MjMwZmQ2', CAST(0x0000ABBD0035D876 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'96a462c7-535c-4bf9-945e-f8938a37de89', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MWQzNmJmOTktODJjNC00NDZhLTg3ZDktYTdkMGE1ZTA3YmFm', CAST(0x0000ABA80075A82D AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'97ea969c-04e0-421b-89c2-fa2230d2ea23', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NDE2ZjBhNDMtNDAzMS00ZjZkLTk5ZTctMDU4MWM2ZTNlMGEw', CAST(0x0000AB87009816FF AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'993e6161-a107-4d50-86bc-86d2409691f8', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Mzk4MzI5YjEtMzBhYS00NDYwLTk1MjktYmQwNGM0ZDFmYTYx', CAST(0x0000AB280021C898 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'995c1efa-c378-4a8d-b869-d8c1d1fa6dcd', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZDJkMTdkZWYtMDg0ZS00MzdlLTk2NzMtMzJlZTVjY2YxNWRi', CAST(0x0000AB2800559A85 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'99db297c-317b-4e8f-b67a-1a7622a82a48', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'YzYwZTI1ZDctM2Y2MC00MDRkLWI2MDctNWFkMGM0OGY2ZTMz', CAST(0x0000ABD70100A82B AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'99eafc1d-a7bb-41d7-9713-9add1e399504', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', N'Y2Q5ZmRiMWEtM2EwMS00ZjViLTk5MDItYjY0NDU4N2Y4YTY1', CAST(0x0000ABD300EAF8CA AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'9a4d3388-45b3-40dd-8fee-80ad2b983d04', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YzE0NjJhNmItOTVhOC00YTdkLWExZTktODBkMGU4MWM4YTRk', CAST(0x0000ABD200CD7308 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'9ae1efe1-2e07-49cb-b7b9-a70a1fff4c39', N'd4d31272-cb28-4b4b-b3d7-78f8c8817b13', N'MzMwZDFjNDUtZjFkOS00M2UwLTk3NDUtMDU1ZjM4Yzk1Yjc2', CAST(0x0000ABBC007B1232 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'9c501a9f-61ed-4c8d-8437-fd3dab861293', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZmYxNWQ3MDMtMGU3ZS00ZmNhLTg0YzgtMTIzYzhjY2ZiM2Q3', CAST(0x0000ABA8003B46CB AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'9c6d33f7-42d9-42f7-9d33-d2791e6fc2b7', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', N'MTJhMWJhYWQtNDBkOC00ZjdhLWEzNzEtZTBkZThjNzkxNGQz', CAST(0x0000ABD200D70E53 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'9e735fac-a694-4f76-a720-0be9f01d3f1b', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'NzYzOTA4ODItN2M4My00OWJhLWE5YTEtN2JmZDc3ZDU3OGJj', CAST(0x0000ABE5004458AD AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'9f040ba8-b285-4358-8111-6f75f32abba6', N'47fa49eb-82ff-4803-b702-a084801fca16', N'ZjZjOTBjZDctOWQ5Yi00NzdkLTg2ZGMtZTdkZGY1YzQxZGY0', CAST(0x0000ABBD00337FA6 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'9f0abee3-a5f1-45d3-9f10-7077bc7ccbe9', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'OTNkNGUwZjMtNWNmZS00MDQ5LWE1MmEtZTQwNjQ2NmY3NzI4', CAST(0x0000ABD2007A01D7 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'9f2500c2-f8c3-473c-8bf6-0f7e55eac1d4', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZjhmYTRjYWYtYWU0ZC00YjhjLTgyMzMtOTAwZTAzMTc1MjE4', CAST(0x0000AB8B008AE7C2 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'a282493b-c166-4776-9224-61d4991fbf36', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NjJkODQ0MzQtNzdkYS00YzU4LWI0NmEtNWZhN2I0ZGRiZDdl', CAST(0x0000ABA8006E83A8 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'a347eda5-3a9b-4bb9-935b-03155ad1de6a', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MDQzM2EwZTUtMzBlMC00NDIxLWIxMjctOWQwODU5MjRjNGUz', CAST(0x0000ABD2007D2431 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'a3ab0188-0490-43dd-b5d2-96785b8360db', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZTI3Nzk2MWUtNWY0OC00MzgwLTk0ZWEtNGQ4NGU4MmY3ZGJl', CAST(0x0000ABC00055126D AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'a451f0c7-44ec-4e6e-a366-9ef25d60dbd1', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ODFjODQxOGQtY2M5MS00NjdjLTg2YjgtN2IwZDljZWVlYWJk', CAST(0x0000ABDA00537294 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'a6335ab2-feb6-428c-a149-f4dff2fee765', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NDg4MGY0NjctODYyNy00ODg2LTg2YjctYWZjMGEzMTM3MzFk', CAST(0x0000ABDA0072C6C2 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'a8e97415-1218-461d-bcc5-34eca908f235', N'47fa49eb-82ff-4803-b702-a084801fca16', N'M2EzMTEzMjMtMGE5Mi00ZTQ5LTkxOGYtODVhYTVmZDYwYjQ3', CAST(0x0000ABBD003033E2 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'aa653e8c-1c92-4a1b-91e7-3fdff0d84d48', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZjJkMzdiYTAtN2JkYi00NmU4LTgwYjYtYjk2NjFiZGIwMzlm', CAST(0x0000AB27008F27D8 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'ab259212-7eb7-4b3f-a057-c21593b96e53', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NGRmZDIxMjMtOGRkMy00MzMzLTkyODEtMTViYmI0YjkxZjQy', CAST(0x0000ABA600938604 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'ab553569-4ddb-4f38-a00d-0a9990ed2b44', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'YThhYTQ3NmQtZDRmZC00NTRjLWJiZmYtYWI5YzZiMmE5YzNj', CAST(0x0000ABD5001A159E AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'abdc2a0d-e2fb-407c-b039-538524284149', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YWNiNWE0NGMtN2ZiZS00NTQwLWI2NjAtNjhjMGNiZTA5OWNh', CAST(0x0000ABD30056E87E AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'ac312290-5891-469f-9f93-6f6b46d90e5e', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZTM1OTkzMTYtYjE4Yi00YjgyLTgxM2UtZjkyOGVhNDVlOTdl', CAST(0x0000ABCB008202E1 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'ac660525-d110-4243-a296-e600c75917e2', N'b78f81eb-0649-42ad-b855-75551462c11d', N'ZTVjNmMyMzAtNTVmOS00NjUxLWI2MDgtZmE2MTk0NDg3ZWY5', CAST(0x0000AB27009ACFE3 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'aca84080-18ab-4f83-83a2-8621b8767d9e', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MTM0ODg0MDAtOTZmYy00YTE5LTg3ZGItNDg1ZjQyOTUzODE2', CAST(0x0000ABA6008B858C AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'ae96cd51-b136-4059-88fd-923bb36493a5', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YmQ0ODAwNjQtYzhmNi00MWM4LWI2NGEtNTU2MWNiZmYwOTNh', CAST(0x0000ABA80072F453 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'af3faae3-f009-483e-8603-21f0bcb4c801', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MTY5NDIzNzYtNTc2MC00MDIwLWIwYTAtNGRkNDY5ODBmYzk4', CAST(0x0000ABBD0037B65B AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'afa8821a-e8f2-4629-8e35-74608fc980a1', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'OGY3NDMxOTYtYzE5ZS00MDk3LWIyNmQtYjNmYzVkZGM4Y2Ni', CAST(0x0000ABE6004F5050 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'aff3d03f-ccfb-4d09-bbc6-74e141911e00', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MGZlYjc4MTYtNGNjOC00ODFlLWFjOGYtNjFkYjI1NDVlM2Q5', CAST(0x0000ABE8009902F7 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'b06d4346-49ab-4d40-8630-66c725ff2b23', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MGExY2M5MmQtYzFlNi00ZDc2LTgxYzQtZGFlMWEzNmIxYzc4', CAST(0x0000AB8A00B97BA8 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'b0e60ed9-5257-4af7-ac6a-e05e2f5bf5e1', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZjhiMzZmMDItNjk1NS00Mjk1LTg3NDAtMmYxZDFlMGM5ZjY3', CAST(0x0000ABD300EBBA14 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'b1bd0d0a-a5c5-46bd-aec2-82e43e18f8ba', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'NWJkNzEwOWUtY2RlOS00YTgwLWFkYjYtNDYwNTEyNzczODNh', CAST(0x0000ABE800985CD4 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'b39eddab-66c5-4da3-91a1-1909d18b0308', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NmE5MWZiNDItNzIwNC00NGYxLTgwYmUtZmQyODdjNjE2YzNk', CAST(0x0000ABA80036E438 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'b3c0da3b-81ca-4517-ba62-0179ef4c1738', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Yzg2MDViYTktYjIxNi00ZmNhLWE5ODItMWRiZDQ5MTkwN2E1', CAST(0x0000AB8B008F3C9F AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'b45d5475-176f-4901-a4a3-e35b68bf32b7', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZGRkNWM5MjMtYjhmMi00NDRiLTg1OWItZDcxZmViNmM0NDdm', CAST(0x0000AB87009DABDC AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'b4a9bc53-6c3e-4de2-8835-895a02d96ec5', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NTRkMzY5NmItMDg2ZS00NjkwLWE1NzctMzFlMmQ3NTI4YzIz', CAST(0x0000ABA7009FF008 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'b59ce09e-7aa3-42b3-80a2-23c747209bf0', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ODUyZGEwOWEtMDcwNy00YWE2LThmZGYtMWQ0MGU2ZThmMDEx', CAST(0x0000ABA6009803BD AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'b78cf32e-84e4-41d8-9bdb-4b26dbf7bc77', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NDA2OTAwNWYtYjZkNC00OTY3LWJmZDItMTU5ZDJjZTdiMjgw', CAST(0x0000ABCA00A061A6 AS DateTime))
GO
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'b8549298-d9b1-442e-b9be-a030342fafdd', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'MzM4ZmJjMWUtOTBjMy00ODYwLWJjZDUtNDE1MjhiMGZhZDg0', CAST(0x0000ABE600C310B7 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'bae7b82c-97d6-4037-91a0-63a3614740c6', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ODlkOTlhOTEtNWU1Ny00NjU1LTlmMGItZWNlNzg5MzZiZGM4', CAST(0x0000ABBD00387321 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'bd94e694-0c4b-42ab-841b-f2414691842b', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NTNmZmE4NzktM2RiOS00NTBlLWEzNjktMjUwODIxN2U1MTBi', CAST(0x0000ABE600629E3F AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'bdc25e13-737c-4cec-9e9f-f82092cd6748', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YjA2YzkxYWEtMDUxNy00YTE4LTlhOTEtZWViZTQ2MWM4YWQx', CAST(0x0000ABD50019FF10 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'bfab1c2b-6492-4ec1-8896-f2a3564343db', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YjA5OTI5NDEtNDkzYS00ZWI3LWJkZmMtMjUxNGYxYWE3NzUw', CAST(0x0000ABA80023257A AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'bffcf570-bcae-4f97-87fc-83b635f91b8d', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NWZmMjNiMGQtMjE2OC00YmYzLWI3NDktZTcyOGM5MGRiYjQy', CAST(0x0000ABD30053B4D7 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'bffd7931-2c4f-434a-b822-86cc5f93de80', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NWZiMDc2NmUtMGIxMi00NWM0LWJjMzktOWVlZjVlZjUzYjI2', CAST(0x0000AB870097BD41 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'c081b95c-3f43-4dfe-9053-07e0319a5d38', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ODRiYjlkYTYtMTJlZC00MmMyLTlmOWQtMjNiYTIwOTA1OWI4', CAST(0x0000ABD800522978 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'c0dc6b75-f77e-46d4-9bfb-30910d405c8d', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZDczMWMyMDUtN2Y3ZC00YjljLWFhN2QtZGQxMjQxMWE3YmJm', CAST(0x0000AB270095FA3C AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'c208046c-863f-4a3a-872c-b0c072a66f12', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YzdiZTJlYzctN2EwMy00YmE5LTkzMWUtZmYzNjFlNDBiMmNk', CAST(0x0000ABD6008557FA AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'c27796b6-2885-420f-99a9-dc94f52c846d', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'OTNmN2UyNTYtZjFjMS00NDA2LWI5N2ItNTZiMDkyN2EzNDEx', CAST(0x0000ABBD007253A0 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'c290027c-078f-49ef-8f8c-56b14a90cb2f', N'd4d31272-cb28-4b4b-b3d7-78f8c8817b13', N'NjY3YzNjMTAtODJmNi00NDMzLTg4MDctNWViNTg4YjQ2MDA4', CAST(0x0000ABBC007CAF2D AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'c2eda969-e643-41e5-931d-1e754f08ae5a', N'19c85ac3-d557-4840-be39-31690fad5733', N'NmQ1ODk5NzMtOWI5Yy00YWQ4LWJjNGYtNGIwNzY4MTUyZjZj', CAST(0x0000AB27009AB878 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'c3d1d267-a936-45f1-8ef6-1b6fd42120da', N'b3dc917b-854b-4703-b032-36aaf9a6a600', N'ZjZlZmUxNWUtZDVmOS00YzJkLThlMDQtNWYzY2IxMjljZjYw', CAST(0x0000ABBD0067D3AA AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'c7e54ec3-a860-45d3-b715-fa73671fde67', N'b78f81eb-0649-42ad-b855-75551462c11d', N'NjI3ZjhiNTAtNjc4Ni00Yzg1LWJhMTYtMGFkMzc2Y2ZkODFl', CAST(0x0000AB270084B0CC AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'c8858ad7-60c5-40f0-b355-ae4598b4ebb6', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NzgzY2IxNDgtYWQ1OS00YTFhLWE4NjgtN2VmMDg2NTY4MjNm', CAST(0x0000ABB1002C67A1 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'c9d887f0-4957-43b6-b0dc-8ab718b67d49', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'OWU2YjIxYzgtYjg5Ny00NDczLWE5MGMtMmRhNzNlYTk4MDY1', CAST(0x0000AB8700A03D63 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'cad433e0-3390-4ed6-87d7-c48a3860292f', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'OTczMDM1N2YtZmU0YS00Y2Y1LWFkN2EtYmFlYzVlODBlMmIw', CAST(0x0000ABDA0053AC5A AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'cc256a17-a447-4c36-8581-d6d058a95a53', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZmM0OWExOTQtYTEyNC00Mjg0LWFiYmQtNjEwNjJmYjNkNjY2', CAST(0x0000ABE6004F8355 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'cc2d43d5-589a-4f69-855b-52cd619b82da', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MGU2MDg0NmQtOGNkOS00MjliLTk2NDMtODFhN2JjYjQ1YzQ2', CAST(0x0000AB8700917E70 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'ccb362d7-fca7-4c9a-8747-0d38e9caf205', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', N'MWFmMTNmNDMtMjdkNi00MGQ5LTlhMmEtN2I0Zjc3M2YyYzZh', CAST(0x0000ABD200CC6988 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'cda9ab95-cf34-417d-affc-d30ec97c58b2', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZWZhZWYzYTMtY2ZkOS00ZDg3LTllMDAtNGM4OGM4NmJkYjA0', CAST(0x0000ABA80038A213 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'ce7b60d1-f454-4d92-96e5-596cb76bbd23', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NzZmMjUyNWQtZTEzNy00YmMwLTkzY2EtMWFkMTQwMjRkZTU5', CAST(0x0000ABE8007891FA AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'd02f3c7a-c283-4860-9f8a-5e8e3fc879da', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NTE0OWYzZGYtM2M2MS00YTVhLWE1YzYtMTUxMjI2NGFmOTE0', CAST(0x0000ABD400800C90 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'd052272c-6104-4392-a0f0-40836a486bf6', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MzVkNmI4NTAtMTdjYy00ZTg4LTg4NGYtMDg4NTMxNjMyYWJk', CAST(0x0000ABA700A19F01 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'd055ccaa-e915-489b-9ceb-f559382e48ed', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZDAxNzc3OWItNGExMy00YTU0LThiZjUtYTY2NGQwNDM0OTY1', CAST(0x0000ABA800729113 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'd1f12d2b-8b56-4d1c-b225-15bf6f5b34dd', N'd4d31272-cb28-4b4b-b3d7-78f8c8817b13', N'NWQ3ZGI4MzAtNmYyMS00NDc3LTlkYTAtOWE3ZjZlODI5MjJl', CAST(0x0000ABBC0077C63C AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'd39a80f7-f330-424f-9baf-98e9499edba0', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YzRhN2UyMDItZGI5Yi00MjFjLWI5YzAtNWYzNmE5N2U4YTBk', CAST(0x0000ABD200D4941C AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'd4842e84-fe32-4136-b078-eb15d51433c0', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'NzM5ZTZiOTgtMTI4ZC00NGQ3LThiYmEtMTdmOTA3OGE1MzFh', CAST(0x0000ABD7004A00D8 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'd4b2ae5b-4ecc-4b32-8829-0c3066463901', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'OTg5N2JmOTQtMzJmMi00N2M2LWJkMGMtZGI5ZmExMjNlZjc1', CAST(0x0000ABA6007F5377 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'd6bd3ade-24f8-4d65-8798-2cd67f5ae62a', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YzFmM2NiMjQtNzJiNy00ZDExLTlmNGMtNTYzMTg0ZjQ2ZWQ1', CAST(0x0000ABE5003DB181 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'd75cfa2a-4c95-42bd-a2f4-4195a9af3b55', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZDc4ZWQxOGItODNlNS00NWE3LWI1OWUtMWZmZjg3OWMyNGEw', CAST(0x0000AB8B008D6F7F AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'd9b6e44d-f465-484f-97ee-47707b23bf13', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'ZTZjZTQ5YTAtZTkwNi00MjUzLWFmNzYtOTMzNjJjYzg0MDdh', CAST(0x0000ABD50019BECC AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'da17bff2-7c78-4bb4-b7c8-2ea837344549', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', N'YmIxZmQ2NzQtZjY3Yi00OWUyLTgzMTAtZmU0MDEzZDJlNDJm', CAST(0x0000ABD70087B24D AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'db6de38f-bd48-43e2-9f5b-9bb8f09dd369', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'Y2ZmNDZjNDItNmIyMS00NTAxLTg1NTEtMDQ1NGUzZDk4Y2Ex', CAST(0x0000ABA60081AA95 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'dbe44c33-ed61-4fea-b202-973764c26160', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MTE1ZDQzMjQtMzFiNS00NGRkLTkxZDMtOGQ5ZTdlMmVlODNh', CAST(0x0000ABD50018AB7E AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'dc54efca-8a27-417d-a0b8-9ef4f0d35cd1', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YjhkMmRiMzQtNWQ0MS00YzI4LWExOTYtNDVhZTU1MzQ1OGQz', CAST(0x0000ABA80071210C AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'dcf3deb0-5549-4d91-952c-3cab8d708f3e', N'47fa49eb-82ff-4803-b702-a084801fca16', N'Yzk1OWM4NDktNzY2ZC00MDIyLTlkZGUtZDcxODE2ZWM4YzIz', CAST(0x0000ABBD00309CF0 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'ddb7a9ef-5a9f-43b6-af0f-814bc6831978', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'NjIwMTgwOGYtNmMxNC00ODU1LWJiZjEtMGQ5YWM0ZDZkZGFi', CAST(0x0000ABE60045F54B AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'ddf174fc-ac87-4336-bd03-88ec6caf3896', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MzdlMmRlMzctNjVjYS00ZjZjLWI5ODItMmE3MzFlMzBmMzk4', CAST(0x0000ABA8003996B3 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'e00957da-7262-4db7-8528-5d03d3055549', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'YzhkM2E2Y2EtYjA0Zi00MjAxLThjMDAtN2Y4YzQwYjU4Mzhl', CAST(0x0000ABE800709E3C AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'e0485047-0489-4c24-8ef7-7b30ea979618', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MTJkNWE3MWItMmNmMC00OTg4LTkxYzYtZTlmOTMzYTkzNzIx', CAST(0x0000ABE8009963C2 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'e059a025-dcd2-4281-8663-b3b19c79e7cd', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NjVkNDdlMmUtN2JhOS00NjZjLTlmMDItZDZhNDlhNjc2NTU0', CAST(0x0000ABE800793779 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'e0fd343c-8e4a-400b-8e30-2181ebd84a76', N'19c85ac3-d557-4840-be39-31690fad5733', N'YzFhYjljOWEtY2Q4OS00YWQ3LTlkYWMtNGY1ZGEzODc0MDI2', CAST(0x0000AB27008FCF24 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'e3f71418-5fd6-4122-8703-38518289895b', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', N'NTUzN2ViZjctNmZkZi00MjRkLThkODQtN2ZlODliZjhlOWM1', CAST(0x0000ABD4008AECF3 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'e4c5ff9c-e5b1-4387-835d-01f84dcf2baf', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'OTI5ZjM1OTQtOWYzYi00MzkyLWJiMzEtNTU5YmM5ZGQ0NDk3', CAST(0x0000ABBD0037D492 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'e4d633ca-351f-4078-a4f8-f0c98c37a1e1', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NDhmY2Y2MGUtNWI2YS00NzY1LTkzODYtNTFkZDg3YWUwMjFk', CAST(0x0000ABD20079FB59 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'e5bcf887-59e6-4d80-9867-57b0084a64ae', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YjhkMDAzZTItOTExYi00ODg4LWE2ZGUtMmVkYjE0OGI5MjQ2', CAST(0x0000ABD2007A0327 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'e7f7f6bf-c0df-4b21-aa57-18cc5c0138c0', N'19c85ac3-d557-4840-be39-31690fad5733', N'ZWM4NThjYjctODNkZC00NWQ1LWJiOTItMGZiZjQwODNmMGUy', CAST(0x0000AB27009A7795 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'e874cbc9-830f-4298-b457-456880de74db', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MWVjOGUzYWUtODVlYi00NTA3LWE0MjktMDUyYmNhY2E2ZmVl', CAST(0x0000ABA800368142 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'e8d2fe28-07b5-4675-ac5f-b2ab37047681', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'NTdmMzBjNWItNzY0MC00ZDRhLWIyODgtZjc0MjRjNWNlNzY2', CAST(0x0000ABD600854173 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'e952352d-2435-44ff-baf9-83d26b0bd2cb', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'NThkZjVlOGYtOTc4NC00NDYyLWFlODUtZDA5NTcyMzZiMThk', CAST(0x0000ABE5003D0D45 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'ea1e3905-d4ac-461a-96ca-93a906acae38', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NjEwZTg2NTItOWIwYi00YzExLWExOTQtMDNhNzJkZjBlMmZk', CAST(0x0000ABD30052432F AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'ea39600d-258d-479b-8b76-6ed080220ee3', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'MjAwOWE2YmEtMDExYi00ODZmLWI4OTAtYWEwNDIxOTE1NDVh', CAST(0x0000ABE50045A4E4 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'eaf18e41-430f-440b-8be8-2fa06530e009', N'db65b042-e0b2-434d-bc4e-06fb2afebe27', N'N2U1MzFiZWQtMzExMS00YzkzLWJkOTQtMzJhNzkxZjE2YzY5', CAST(0x0000ABD200CD3BBD AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'eb51f9a5-4f87-4c79-9625-a6bf8865d9d2', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NTZjMzUyMGQtNjhkNS00OGE2LTgxMzgtYTcwNTU2NTY5MmVj', CAST(0x0000ABA700A6FBAD AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'ec093dc8-4233-4d37-9a5a-7bbd9d44fffe', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'M2U0M2MzZWYtNzI0MC00NjRmLWFiNzQtNjk5OGJmMWYyMThk', CAST(0x0000AB87009F73C1 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'ec2b41b9-22e5-486b-895f-431c4299f242', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YzEyYzY4OWEtNzEzYi00NzkwLWJmZWEtMDA2ZDNiODIxYTgx', CAST(0x0000ABD20079FA0D AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'ec2e5e7b-a82d-49c3-9295-19df089ae645', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NWNhYjc5NGQtODBhOC00YzAyLWEyMWUtZDFjNjFmNmI5ZTE0', CAST(0x0000ABA800754B04 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'ed65abfa-c86e-46e2-b996-7fbe9466aca1', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'OTNiZTQ4M2YtM2FmNi00Y2QzLThlYmEtNDM5ODdlMzk3ZGQ0', CAST(0x0000ABA80070E39A AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'eeb770a1-d41b-4e2b-91fb-3fac9483cfea', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'ZjIxYjI1ZTctNTFkNC00MjU4LWI5ZjItNjE3Mzg3MWU1Yjhj', CAST(0x0000ABD800521133 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'eebcfea3-caab-4508-be31-16033050f45d', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NmQ2NmNmNmUtZWIwZS00ODMyLTlhYmYtNmNiNjFiOGJlODRi', CAST(0x0000ABA8006F805A AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'efeefb67-4699-4d72-b5da-5b686f2e2584', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'OTk3MjZiNmItNDQxMS00YjZjLWJmZTUtY2Q2ZWZkZDY3ZjZk', CAST(0x0000AB8700945A4D AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'f2692c63-aea3-45f4-b149-d5d0529f8824', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NmE4YjI3YmMtOTk0NS00OTU5LWE4YzgtZDJkODZmNDAxNDEz', CAST(0x0000ABD4008D1E77 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'f2f57481-3125-43fd-838c-cf33fa288021', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZjA0OWFhMzYtZmY0Ny00OWY0LWFlNGUtNjAxMmJkYmI0NjY0', CAST(0x0000AB290096C61B AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'f3dd229d-8c6b-42d5-a2d9-19f0ea0d0c68', N'be477ae9-87dc-4e3e-b7e8-8c16bd884949', N'MTJkYWQ3ZmQtNTIyNC00MGE1LTg3MWYtYTAwMGI5MWMzZDk3', CAST(0x0000ABD60086F65F AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'f3e67c47-f119-4653-87b5-9ea1f3605380', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NTc5NzExNmUtOTFjMy00MTUyLThmNmItYTAyZTIxODMzOGZi', CAST(0x0000ABBF003666C8 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'f4496f57-0b54-408a-8f3d-149383dd5fc0', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZDk3OGNlYmItNzZjNS00ZTdkLWI3OTctYTc4MGFkNTk2NjU1', CAST(0x0000ABA80071B6D2 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'f46d75c6-6b71-4dd4-84e2-e2f3c83e2f82', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ODRhYzVlMjItMTIwNy00NGFhLWI3ZmYtMDQ1N2E5ZmUzMWU1', CAST(0x0000ABA700A2A6EE AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'f4da661c-f138-4e83-ac70-0896a9d0f1cc', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YzE0ZDM0NjEtMDg5OC00N2M2LTk2YzEtMzI4NDkxNGZkMDA3', CAST(0x0000ABD70069CEEE AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'f6c591c4-1cb7-49fc-aaa0-c41be47899ce', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MjYwNzkxZTQtOThkYS00OGIwLWJlM2UtYmJlM2EzMTkwMjI3', CAST(0x0000ABD70056552C AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'f7346c1c-b062-4d50-84b4-e986cd6fba1f', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZWU5NDBmMGItMDdkZi00YzNjLThmZGQtYmMzNmFhNzQ4NzE4', CAST(0x0000ABBD0036CC18 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'f750da27-b975-46d3-b2fe-3d94a5889b44', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'YjRiMjg1NGYtMTY0ZS00OGNkLTk5NzktYzZmMzNlZWE0OWU4', CAST(0x0000ABD2007BF03C AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'f75596e8-17ba-4057-aa47-58662213228b', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'ZGE5YzkyOWItNThlMC00NmRhLTg0NGItZTQ3ZWZjMWVlZjYy', CAST(0x0000ABE800999F92 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'f77c2210-0a50-4b71-8d84-4bf070fa6849', N'b78f81eb-0649-42ad-b855-75551462c11d', N'ZDdmNWIzNTAtOGQyNS00ZDkxLThhMmQtYjk4ZDFmOTdiZTBl', CAST(0x0000AB27009963CE AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'f78b1c9a-d723-422b-8f6f-7a52637e24e9', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NzEyODExZTEtZjQ1MS00MDk5LWJkN2MtNWNmNmIwYTE4MWNh', CAST(0x0000ABD50034F29F AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'fbdc1b7b-a348-41e0-b52c-d7dbbc786ed0', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MDc0MTA3NmQtMWI3OS00Y2FiLThjNTEtYWYzYzBhN2NmODY4', CAST(0x0000ABD2007A098F AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'fc2c0b57-921d-44e1-982b-f1477515db96', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'NDIxNDNmNDktMTRjNS00MGM5LTlmY2YtMDRmMjY5Njg0Mzk1', CAST(0x0000ABE600EF63A4 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'fc62058c-ddee-4fef-a10f-efaf6107e471', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'MmQ3MGYxYTgtNWVmYy00YmM4LTg1YjUtOGMxM2E3MjkwOWI1', CAST(0x0000AB87009E8251 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'fcca7814-6b9d-4027-98e8-f7e2bf145c3b', N'b576c13a-a769-48dd-82bc-9e37f41ebd48', N'N2I1YmViNmUtODI0YS00N2ExLTllOTAtNThkYzhhYTNjMGEx', CAST(0x0000ABD500ED6871 AS DateTime))
INSERT [dbo].[USERTOKEN] ([IdToken], [IdUser], [ContentToken], [CreatedTS]) VALUES (N'fd8b1364-c4bc-4510-9076-da3dd5433170', N'47fa49eb-82ff-4803-b702-a084801fca16', N'Y2I4YjlmYjgtY2JmOS00ODlkLWFmYmItYjdjZmM2ODliZjc0', CAST(0x0000AB89007C114D AS DateTime))
ALTER TABLE [dbo].[ALBUMIMAGES] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ALBUMMUSIC] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ALBUMVIDEOS] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[IMAGES] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[MUSICS] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[NEWFEEDPOST] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[USERADDRESS] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[USERINFO] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[USERINTRO] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[VIDEOS] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ALBUMIMAGES]  WITH CHECK ADD  CONSTRAINT [FK_AlbumImage_Status_StatusSocial] FOREIGN KEY([Status])
REFERENCES [dbo].[STATUSSOCIAL] ([IdStatusSocial])
GO
ALTER TABLE [dbo].[ALBUMIMAGES] CHECK CONSTRAINT [FK_AlbumImage_Status_StatusSocial]
GO
ALTER TABLE [dbo].[ALBUMIMAGES]  WITH CHECK ADD  CONSTRAINT [FK_ALBUMIMAGES_IdMedia_USERMEDIA] FOREIGN KEY([IdMedia])
REFERENCES [dbo].[USERMEDIA] ([IdMedia])
GO
ALTER TABLE [dbo].[ALBUMIMAGES] CHECK CONSTRAINT [FK_ALBUMIMAGES_IdMedia_USERMEDIA]
GO
ALTER TABLE [dbo].[ALBUMMUSIC]  WITH CHECK ADD  CONSTRAINT [FK_ALBUMMUSIC_IdMedia_USERMEDIA] FOREIGN KEY([IdMedia])
REFERENCES [dbo].[USERMEDIA] ([IdMedia])
GO
ALTER TABLE [dbo].[ALBUMMUSIC] CHECK CONSTRAINT [FK_ALBUMMUSIC_IdMedia_USERMEDIA]
GO
ALTER TABLE [dbo].[ALBUMMUSIC]  WITH CHECK ADD  CONSTRAINT [FK_AlbumMusic_Status_StatusSocial] FOREIGN KEY([Status])
REFERENCES [dbo].[STATUSSOCIAL] ([IdStatusSocial])
GO
ALTER TABLE [dbo].[ALBUMMUSIC] CHECK CONSTRAINT [FK_AlbumMusic_Status_StatusSocial]
GO
ALTER TABLE [dbo].[ALBUMVIDEOS]  WITH CHECK ADD  CONSTRAINT [FK_AlbumVideo_Status_StatusSocial] FOREIGN KEY([Status])
REFERENCES [dbo].[STATUSSOCIAL] ([IdStatusSocial])
GO
ALTER TABLE [dbo].[ALBUMVIDEOS] CHECK CONSTRAINT [FK_AlbumVideo_Status_StatusSocial]
GO
ALTER TABLE [dbo].[ALBUMVIDEOS]  WITH CHECK ADD  CONSTRAINT [FK_ALBUMVIDEOS_IdMedia_USERMEDIA] FOREIGN KEY([IdMedia])
REFERENCES [dbo].[USERMEDIA] ([IdMedia])
GO
ALTER TABLE [dbo].[ALBUMVIDEOS] CHECK CONSTRAINT [FK_ALBUMVIDEOS_IdMedia_USERMEDIA]
GO
ALTER TABLE [dbo].[COMMENT]  WITH CHECK ADD  CONSTRAINT [FK_COMMENT_IdPost_NEWFEEDPOST] FOREIGN KEY([IdPost])
REFERENCES [dbo].[NEWFEEDPOST] ([IdPost])
GO
ALTER TABLE [dbo].[COMMENT] CHECK CONSTRAINT [FK_COMMENT_IdPost_NEWFEEDPOST]
GO
ALTER TABLE [dbo].[COMMENT]  WITH CHECK ADD  CONSTRAINT [FK_COMMENT_IdPost_USERACCOUNT] FOREIGN KEY([IdUser])
REFERENCES [dbo].[USERACCOUNT] ([IdUser])
GO
ALTER TABLE [dbo].[COMMENT] CHECK CONSTRAINT [FK_COMMENT_IdPost_USERACCOUNT]
GO
ALTER TABLE [dbo].[FOLLOWS]  WITH CHECK ADD  CONSTRAINT [FK_FOLLOWS_IdUser_USERACCOUNT] FOREIGN KEY([IdUser])
REFERENCES [dbo].[USERACCOUNT] ([IdUser])
GO
ALTER TABLE [dbo].[FOLLOWS] CHECK CONSTRAINT [FK_FOLLOWS_IdUser_USERACCOUNT]
GO
ALTER TABLE [dbo].[FOLLOWS]  WITH CHECK ADD  CONSTRAINT [FK_FOLLOWS_IdUserRequest_USERACCOUNT] FOREIGN KEY([IdUserRequest])
REFERENCES [dbo].[USERACCOUNT] ([IdUser])
GO
ALTER TABLE [dbo].[FOLLOWS] CHECK CONSTRAINT [FK_FOLLOWS_IdUserRequest_USERACCOUNT]
GO
ALTER TABLE [dbo].[FRIENDS]  WITH CHECK ADD  CONSTRAINT [FK_FRIENDS_IdUser_USERACCOUNT] FOREIGN KEY([IdUser])
REFERENCES [dbo].[USERACCOUNT] ([IdUser])
GO
ALTER TABLE [dbo].[FRIENDS] CHECK CONSTRAINT [FK_FRIENDS_IdUser_USERACCOUNT]
GO
ALTER TABLE [dbo].[FRIENDS]  WITH CHECK ADD  CONSTRAINT [FK_FRIENDS_IdUserFriend_USERACCOUNT] FOREIGN KEY([IdUserFriend])
REFERENCES [dbo].[USERACCOUNT] ([IdUser])
GO
ALTER TABLE [dbo].[FRIENDS] CHECK CONSTRAINT [FK_FRIENDS_IdUserFriend_USERACCOUNT]
GO
ALTER TABLE [dbo].[IMAGEPOST]  WITH CHECK ADD  CONSTRAINT [FK_IMAGEPOST_IdPost_NEWFEEDPOST] FOREIGN KEY([IdPost])
REFERENCES [dbo].[NEWFEEDPOST] ([IdPost])
GO
ALTER TABLE [dbo].[IMAGEPOST] CHECK CONSTRAINT [FK_IMAGEPOST_IdPost_NEWFEEDPOST]
GO
ALTER TABLE [dbo].[IMAGES]  WITH CHECK ADD  CONSTRAINT [FK_Image_Status_StatusSocial] FOREIGN KEY([Status])
REFERENCES [dbo].[STATUSSOCIAL] ([IdStatusSocial])
GO
ALTER TABLE [dbo].[IMAGES] CHECK CONSTRAINT [FK_Image_Status_StatusSocial]
GO
ALTER TABLE [dbo].[IMAGES]  WITH CHECK ADD  CONSTRAINT [FK_IMAGES_IdAlbumImage_ALBUMIMAGES] FOREIGN KEY([IdAlbumImage])
REFERENCES [dbo].[ALBUMIMAGES] ([IdAlbumImage])
GO
ALTER TABLE [dbo].[IMAGES] CHECK CONSTRAINT [FK_IMAGES_IdAlbumImage_ALBUMIMAGES]
GO
ALTER TABLE [dbo].[INTROSTUDY]  WITH CHECK ADD  CONSTRAINT [FK_STATUSSOCIAL_IdStatusSocial_INTROSTUDY] FOREIGN KEY([IDStatusSocial])
REFERENCES [dbo].[STATUSSOCIAL] ([IdStatusSocial])
GO
ALTER TABLE [dbo].[INTROSTUDY] CHECK CONSTRAINT [FK_STATUSSOCIAL_IdStatusSocial_INTROSTUDY]
GO
ALTER TABLE [dbo].[INTROSTUDY]  WITH CHECK ADD  CONSTRAINT [FK_USERINTRO_IdUserIntro_INTROSTUDY] FOREIGN KEY([IdUserIntro])
REFERENCES [dbo].[USERINTRO] ([IdUserIntro])
GO
ALTER TABLE [dbo].[INTROSTUDY] CHECK CONSTRAINT [FK_USERINTRO_IdUserIntro_INTROSTUDY]
GO
ALTER TABLE [dbo].[INTROWORKING]  WITH CHECK ADD  CONSTRAINT [FK_STATUSSOCIAL_IdStatusSocial_INTROWORKING] FOREIGN KEY([IDStatusSocial])
REFERENCES [dbo].[STATUSSOCIAL] ([IdStatusSocial])
GO
ALTER TABLE [dbo].[INTROWORKING] CHECK CONSTRAINT [FK_STATUSSOCIAL_IdStatusSocial_INTROWORKING]
GO
ALTER TABLE [dbo].[INTROWORKING]  WITH CHECK ADD  CONSTRAINT [FK_USERINTRO_IdUserIntro_INTROWORKING] FOREIGN KEY([IdUserIntro])
REFERENCES [dbo].[USERINTRO] ([IdUserIntro])
GO
ALTER TABLE [dbo].[INTROWORKING] CHECK CONSTRAINT [FK_USERINTRO_IdUserIntro_INTROWORKING]
GO
ALTER TABLE [dbo].[LIKECOMMENT]  WITH CHECK ADD  CONSTRAINT [FK_LikeComment_IdComment_Comment] FOREIGN KEY([IdComment])
REFERENCES [dbo].[COMMENT] ([IdComment])
GO
ALTER TABLE [dbo].[LIKECOMMENT] CHECK CONSTRAINT [FK_LikeComment_IdComment_Comment]
GO
ALTER TABLE [dbo].[LIKECOMMENT]  WITH CHECK ADD  CONSTRAINT [FK_LikeComment_IdUser_UserAccount] FOREIGN KEY([IdUser])
REFERENCES [dbo].[USERACCOUNT] ([IdUser])
GO
ALTER TABLE [dbo].[LIKECOMMENT] CHECK CONSTRAINT [FK_LikeComment_IdUser_UserAccount]
GO
ALTER TABLE [dbo].[LIKEPOST]  WITH CHECK ADD  CONSTRAINT [FK_UserAccount_IdUser_USERACCOUNT] FOREIGN KEY([IdUser])
REFERENCES [dbo].[USERACCOUNT] ([IdUser])
GO
ALTER TABLE [dbo].[LIKEPOST] CHECK CONSTRAINT [FK_UserAccount_IdUser_USERACCOUNT]
GO
ALTER TABLE [dbo].[LIKEREPLYCOMMENT]  WITH CHECK ADD  CONSTRAINT [FK_LikeReplyComment_IdComment_ReplyComment] FOREIGN KEY([IdReply])
REFERENCES [dbo].[REPLYCOMMENT] ([IdReply])
GO
ALTER TABLE [dbo].[LIKEREPLYCOMMENT] CHECK CONSTRAINT [FK_LikeReplyComment_IdComment_ReplyComment]
GO
ALTER TABLE [dbo].[LIKEREPLYCOMMENT]  WITH CHECK ADD  CONSTRAINT [FK_LikeReplyComment_IdUser_UserAccount] FOREIGN KEY([IdUser])
REFERENCES [dbo].[USERACCOUNT] ([IdUser])
GO
ALTER TABLE [dbo].[LIKEREPLYCOMMENT] CHECK CONSTRAINT [FK_LikeReplyComment_IdUser_UserAccount]
GO
ALTER TABLE [dbo].[MUSICLISTENS]  WITH CHECK ADD  CONSTRAINT [FK_MusicListens_IdMusic_Music] FOREIGN KEY([IdMusic])
REFERENCES [dbo].[MUSICS] ([IdMusic])
GO
ALTER TABLE [dbo].[MUSICLISTENS] CHECK CONSTRAINT [FK_MusicListens_IdMusic_Music]
GO
ALTER TABLE [dbo].[MUSICS]  WITH CHECK ADD  CONSTRAINT [FK_Music_Status_StatusSocial] FOREIGN KEY([Status])
REFERENCES [dbo].[STATUSSOCIAL] ([IdStatusSocial])
GO
ALTER TABLE [dbo].[MUSICS] CHECK CONSTRAINT [FK_Music_Status_StatusSocial]
GO
ALTER TABLE [dbo].[MUSICS]  WITH CHECK ADD  CONSTRAINT [FK_MUSICS_IdAlbumMusic_ALBUMMUSICS] FOREIGN KEY([IdAlbumMusic])
REFERENCES [dbo].[ALBUMMUSIC] ([IdAlbumMusic])
GO
ALTER TABLE [dbo].[MUSICS] CHECK CONSTRAINT [FK_MUSICS_IdAlbumMusic_ALBUMMUSICS]
GO
ALTER TABLE [dbo].[NEWFEEDPOST]  WITH CHECK ADD  CONSTRAINT [FK_CATEGORY_IdCategory_NEWFEEDPOST] FOREIGN KEY([IdCategory])
REFERENCES [dbo].[CATEGORY] ([IdCategory])
GO
ALTER TABLE [dbo].[NEWFEEDPOST] CHECK CONSTRAINT [FK_CATEGORY_IdCategory_NEWFEEDPOST]
GO
ALTER TABLE [dbo].[NEWFEEDPOST]  WITH CHECK ADD  CONSTRAINT [FK_NewFeedPost_Status_StatusSocial] FOREIGN KEY([Status])
REFERENCES [dbo].[STATUSSOCIAL] ([IdStatusSocial])
GO
ALTER TABLE [dbo].[NEWFEEDPOST] CHECK CONSTRAINT [FK_NewFeedPost_Status_StatusSocial]
GO
ALTER TABLE [dbo].[NEWFEEDPOST]  WITH CHECK ADD  CONSTRAINT [FK_USERACCOUNT_IdUser_NEWFEEDPOST] FOREIGN KEY([IdUser])
REFERENCES [dbo].[USERACCOUNT] ([IdUser])
GO
ALTER TABLE [dbo].[NEWFEEDPOST] CHECK CONSTRAINT [FK_USERACCOUNT_IdUser_NEWFEEDPOST]
GO
ALTER TABLE [dbo].[REPLYCOMMENT]  WITH CHECK ADD  CONSTRAINT [FK_COMMENT_IdUser_REPLY] FOREIGN KEY([IdComment])
REFERENCES [dbo].[COMMENT] ([IdComment])
GO
ALTER TABLE [dbo].[REPLYCOMMENT] CHECK CONSTRAINT [FK_COMMENT_IdUser_REPLY]
GO
ALTER TABLE [dbo].[REPLYCOMMENT]  WITH CHECK ADD  CONSTRAINT [FK_REPLY_IdUser_USERACCOUNT] FOREIGN KEY([IdUser])
REFERENCES [dbo].[USERACCOUNT] ([IdUser])
GO
ALTER TABLE [dbo].[REPLYCOMMENT] CHECK CONSTRAINT [FK_REPLY_IdUser_USERACCOUNT]
GO
ALTER TABLE [dbo].[REQUESTFRIENDS]  WITH CHECK ADD  CONSTRAINT [FK_REQUESTFRIENDS_IdUser_USERACCOUNT] FOREIGN KEY([IdUser])
REFERENCES [dbo].[USERACCOUNT] ([IdUser])
GO
ALTER TABLE [dbo].[REQUESTFRIENDS] CHECK CONSTRAINT [FK_REQUESTFRIENDS_IdUser_USERACCOUNT]
GO
ALTER TABLE [dbo].[REQUESTFRIENDS]  WITH CHECK ADD  CONSTRAINT [FK_REQUESTFRIENDS_IdUserRequest_USERACCOUNT] FOREIGN KEY([IdUserRequest])
REFERENCES [dbo].[USERACCOUNT] ([IdUser])
GO
ALTER TABLE [dbo].[REQUESTFRIENDS] CHECK CONSTRAINT [FK_REQUESTFRIENDS_IdUserRequest_USERACCOUNT]
GO
ALTER TABLE [dbo].[STORYSEEN]  WITH CHECK ADD  CONSTRAINT [FK_STORYSEEN_IdStory_USERSTORIES] FOREIGN KEY([IdStory])
REFERENCES [dbo].[USERSTORIES] ([IdStory])
GO
ALTER TABLE [dbo].[STORYSEEN] CHECK CONSTRAINT [FK_STORYSEEN_IdStory_USERSTORIES]
GO
ALTER TABLE [dbo].[USERADDRESS]  WITH CHECK ADD  CONSTRAINT [FK_USERADDRESS_IdUser_USERACCOUNT] FOREIGN KEY([IdUser])
REFERENCES [dbo].[USERACCOUNT] ([IdUser])
GO
ALTER TABLE [dbo].[USERADDRESS] CHECK CONSTRAINT [FK_USERADDRESS_IdUser_USERACCOUNT]
GO
ALTER TABLE [dbo].[USERADDRESS]  WITH CHECK ADD  CONSTRAINT [FK_UserAddress_Status_StatusSocial] FOREIGN KEY([Status])
REFERENCES [dbo].[STATUSSOCIAL] ([IdStatusSocial])
GO
ALTER TABLE [dbo].[USERADDRESS] CHECK CONSTRAINT [FK_UserAddress_Status_StatusSocial]
GO
ALTER TABLE [dbo].[USERCONTACT]  WITH CHECK ADD  CONSTRAINT [FK_USERCONTACT_IdUser_USERACCOUNT] FOREIGN KEY([IdUser])
REFERENCES [dbo].[USERACCOUNT] ([IdUser])
GO
ALTER TABLE [dbo].[USERCONTACT] CHECK CONSTRAINT [FK_USERCONTACT_IdUser_USERACCOUNT]
GO
ALTER TABLE [dbo].[USERHASNOTIFY]  WITH CHECK ADD  CONSTRAINT [FK_USERHASNOTIFY_IdNotifySetting_NOTIFYSETTING] FOREIGN KEY([IdNotifySetting])
REFERENCES [dbo].[NOTIFYSETTING] ([IdNotifySetting])
GO
ALTER TABLE [dbo].[USERHASNOTIFY] CHECK CONSTRAINT [FK_USERHASNOTIFY_IdNotifySetting_NOTIFYSETTING]
GO
ALTER TABLE [dbo].[USERHASNOTIFY]  WITH CHECK ADD  CONSTRAINT [FK_USERHASNOTIFY_IdNotifyType_NOTIFY] FOREIGN KEY([IdNotifyType])
REFERENCES [dbo].[NOTIFYTYPE] ([IdNotifyType])
GO
ALTER TABLE [dbo].[USERHASNOTIFY] CHECK CONSTRAINT [FK_USERHASNOTIFY_IdNotifyType_NOTIFY]
GO
ALTER TABLE [dbo].[USERHASNOTIFY]  WITH CHECK ADD  CONSTRAINT [FK_USERHASNOTIFY_IdPost_NEWFEEDPOST] FOREIGN KEY([IdPost])
REFERENCES [dbo].[NEWFEEDPOST] ([IdPost])
GO
ALTER TABLE [dbo].[USERHASNOTIFY] CHECK CONSTRAINT [FK_USERHASNOTIFY_IdPost_NEWFEEDPOST]
GO
ALTER TABLE [dbo].[USERINFO]  WITH CHECK ADD  CONSTRAINT [FK_USERINFO_IdUser_USERACCOUNT] FOREIGN KEY([IdUser])
REFERENCES [dbo].[USERACCOUNT] ([IdUser])
GO
ALTER TABLE [dbo].[USERINFO] CHECK CONSTRAINT [FK_USERINFO_IdUser_USERACCOUNT]
GO
ALTER TABLE [dbo].[USERINFO]  WITH CHECK ADD  CONSTRAINT [FK_UserInfo_Status_StatusSocial] FOREIGN KEY([Status])
REFERENCES [dbo].[STATUSSOCIAL] ([IdStatusSocial])
GO
ALTER TABLE [dbo].[USERINFO] CHECK CONSTRAINT [FK_UserInfo_Status_StatusSocial]
GO
ALTER TABLE [dbo].[USERINTRO]  WITH CHECK ADD  CONSTRAINT [FK_USERINTRO_IdUser_USERACCOUNT] FOREIGN KEY([IdUser])
REFERENCES [dbo].[USERACCOUNT] ([IdUser])
GO
ALTER TABLE [dbo].[USERINTRO] CHECK CONSTRAINT [FK_USERINTRO_IdUser_USERACCOUNT]
GO
ALTER TABLE [dbo].[USERINTRO]  WITH CHECK ADD  CONSTRAINT [FK_UserIntro_Status_StatusSocial] FOREIGN KEY([Status])
REFERENCES [dbo].[STATUSSOCIAL] ([IdStatusSocial])
GO
ALTER TABLE [dbo].[USERINTRO] CHECK CONSTRAINT [FK_UserIntro_Status_StatusSocial]
GO
ALTER TABLE [dbo].[USERMEDIA]  WITH CHECK ADD  CONSTRAINT [FK_USERMEDIA_IdMedia_USERACCOUNT] FOREIGN KEY([IdUser])
REFERENCES [dbo].[USERACCOUNT] ([IdUser])
GO
ALTER TABLE [dbo].[USERMEDIA] CHECK CONSTRAINT [FK_USERMEDIA_IdMedia_USERACCOUNT]
GO
ALTER TABLE [dbo].[USERRELATIONSHIP]  WITH CHECK ADD  CONSTRAINT [FK_USERRELATIONSHIP_IdInfo_USERINFO] FOREIGN KEY([IdInfo])
REFERENCES [dbo].[USERINFO] ([IdInfo])
GO
ALTER TABLE [dbo].[USERRELATIONSHIP] CHECK CONSTRAINT [FK_USERRELATIONSHIP_IdInfo_USERINFO]
GO
ALTER TABLE [dbo].[USERSEXCLUDE]  WITH CHECK ADD  CONSTRAINT [FK_USERACCOUNT_IdUser_USERSEXCLUDE] FOREIGN KEY([IdUser])
REFERENCES [dbo].[USERACCOUNT] ([IdUser])
GO
ALTER TABLE [dbo].[USERSEXCLUDE] CHECK CONSTRAINT [FK_USERACCOUNT_IdUser_USERSEXCLUDE]
GO
ALTER TABLE [dbo].[USERSEXCLUDE]  WITH CHECK ADD  CONSTRAINT [FK_USERACCOUNT_IdUserExclude_USERSEXCLUDE] FOREIGN KEY([IdUserExclude])
REFERENCES [dbo].[USERACCOUNT] ([IdUser])
GO
ALTER TABLE [dbo].[USERSEXCLUDE] CHECK CONSTRAINT [FK_USERACCOUNT_IdUserExclude_USERSEXCLUDE]
GO
ALTER TABLE [dbo].[USERSTORIES]  WITH CHECK ADD  CONSTRAINT [FK_USERSTORIES_IdUser_USERACCOUNT] FOREIGN KEY([IdUser])
REFERENCES [dbo].[USERACCOUNT] ([IdUser])
GO
ALTER TABLE [dbo].[USERSTORIES] CHECK CONSTRAINT [FK_USERSTORIES_IdUser_USERACCOUNT]
GO
ALTER TABLE [dbo].[USERTOKEN]  WITH CHECK ADD  CONSTRAINT [FK_USERTOKEN_IdUser_USERACCOUNT] FOREIGN KEY([IdUser])
REFERENCES [dbo].[USERACCOUNT] ([IdUser])
GO
ALTER TABLE [dbo].[USERTOKEN] CHECK CONSTRAINT [FK_USERTOKEN_IdUser_USERACCOUNT]
GO
ALTER TABLE [dbo].[VIDEOS]  WITH CHECK ADD  CONSTRAINT [FK_Video_Status_StatusSocial] FOREIGN KEY([Status])
REFERENCES [dbo].[STATUSSOCIAL] ([IdStatusSocial])
GO
ALTER TABLE [dbo].[VIDEOS] CHECK CONSTRAINT [FK_Video_Status_StatusSocial]
GO
ALTER TABLE [dbo].[VIDEOS]  WITH CHECK ADD  CONSTRAINT [FK_VIDEOS_IdAlbumVideo_ALBUMVIDEOS] FOREIGN KEY([IdAlbumVideo])
REFERENCES [dbo].[ALBUMVIDEOS] ([IdAlbumVideo])
GO
ALTER TABLE [dbo].[VIDEOS] CHECK CONSTRAINT [FK_VIDEOS_IdAlbumVideo_ALBUMVIDEOS]
GO
ALTER TABLE [dbo].[VIDEOVIEWS]  WITH CHECK ADD  CONSTRAINT [FK_MusicListens_IdMusic_Video] FOREIGN KEY([IdVideo])
REFERENCES [dbo].[VIDEOS] ([IdVideo])
GO
ALTER TABLE [dbo].[VIDEOVIEWS] CHECK CONSTRAINT [FK_MusicListens_IdMusic_Video]
GO
