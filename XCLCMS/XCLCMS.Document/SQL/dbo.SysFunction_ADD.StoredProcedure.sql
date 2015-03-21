USE [XCLCMS]
GO
/****** Object:  StoredProcedure [dbo].[SysFunction_ADD]    Script Date: 03/21/2015 10:00:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SysFunction_ADD]
@SysFunctionID bigint,
@FunctionName varchar(100),
@FK_TypeID bigint,
@Remark nvarchar(500),
@RecordState char(1),
@CreateTime datetime,
@CreaterID bigint,
@CreaterName nvarchar(50),
@UpdateTime datetime,
@UpdaterID bigint,
@UpdaterName nvarchar(50)

 AS 
	INSERT INTO [SysFunction](
	[SysFunctionID],[FunctionName],[FK_TypeID],[Remark],[RecordState],[CreateTime],[CreaterID],[CreaterName],[UpdateTime],[UpdaterID],[UpdaterName]
	)VALUES(
	@SysFunctionID,@FunctionName,@FK_TypeID,@Remark,@RecordState,@CreateTime,@CreaterID,@CreaterName,@UpdateTime,@UpdaterID,@UpdaterName
	)
GO
