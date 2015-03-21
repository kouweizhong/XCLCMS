USE [XCLCMS]
GO
/****** Object:  StoredProcedure [dbo].[SysFunction_Update]    Script Date: 03/21/2015 10:00:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SysFunction_Update]
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
	UPDATE [SysFunction] SET 
	FunctionName=@FunctionName , RecordState=@RecordState, 
	[FK_TypeID] = @FK_TypeID,[Remark] = @Remark,[CreateTime] = @CreateTime,[CreaterID] = @CreaterID,[CreaterName] = @CreaterName,[UpdateTime] = @UpdateTime,[UpdaterID] = @UpdaterID,[UpdaterName] = @UpdaterName
	WHERE SysFunctionID=@SysFunctionID
GO
