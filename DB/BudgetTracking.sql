USE [master]
GO
/****** Object:  Database [BudgetTracking]    Script Date: 9/15/2018 11:28:31 PM ******/
CREATE DATABASE [BudgetTracking]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BudgetTracking', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\BudgetTracking.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BudgetTracking_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\BudgetTracking_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [BudgetTracking] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BudgetTracking].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BudgetTracking] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BudgetTracking] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BudgetTracking] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BudgetTracking] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BudgetTracking] SET ARITHABORT OFF 
GO
ALTER DATABASE [BudgetTracking] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BudgetTracking] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BudgetTracking] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BudgetTracking] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BudgetTracking] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BudgetTracking] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BudgetTracking] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BudgetTracking] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BudgetTracking] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BudgetTracking] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BudgetTracking] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BudgetTracking] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BudgetTracking] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BudgetTracking] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BudgetTracking] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BudgetTracking] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BudgetTracking] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BudgetTracking] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BudgetTracking] SET  MULTI_USER 
GO
ALTER DATABASE [BudgetTracking] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BudgetTracking] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BudgetTracking] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BudgetTracking] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BudgetTracking] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BudgetTracking] SET QUERY_STORE = OFF
GO
USE [BudgetTracking]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [BudgetTracking]
GO
/****** Object:  Table [dbo].[BudgetType]    Script Date: 9/15/2018 11:28:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BudgetType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_BudgetType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BudgetValue]    Script Date: 9/15/2018 11:28:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BudgetValue](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BudgetTypeID] [int] NOT NULL,
	[Amount] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[RecurringTypeID] [int] NULL,
	[Description] [nvarchar](200) NULL,
 CONSTRAINT [PK_BudgetValue] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RecurringType]    Script Date: 9/15/2018 11:28:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecurringType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Value] [nchar](10) NOT NULL,
 CONSTRAINT [PK_RecurringCostType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BudgetValue]  WITH CHECK ADD  CONSTRAINT [FK_BudgetValue_BudgetType] FOREIGN KEY([BudgetTypeID])
REFERENCES [dbo].[BudgetType] ([ID])
GO
ALTER TABLE [dbo].[BudgetValue] CHECK CONSTRAINT [FK_BudgetValue_BudgetType]
GO
ALTER TABLE [dbo].[BudgetValue]  WITH CHECK ADD  CONSTRAINT [FK_BudgetValue_RecurringCostType] FOREIGN KEY([RecurringTypeID])
REFERENCES [dbo].[RecurringType] ([ID])
GO
ALTER TABLE [dbo].[BudgetValue] CHECK CONSTRAINT [FK_BudgetValue_RecurringCostType]
GO
USE [master]
GO
ALTER DATABASE [BudgetTracking] SET  READ_WRITE 
GO
