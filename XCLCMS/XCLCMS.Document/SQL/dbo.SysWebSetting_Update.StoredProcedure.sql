USE [XCLCMS]
GO
/****** Object:  StoredProcedure [dbo].[SysWebSetting_Update]    Script Date: 03/21/2015 10:00:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SysWebSetting_Update]
@SysWebSettingID bigint,
@KeyName varchar(100),
@KeyValue varchar(2000),
@Remark varchar(1000),
@RecordState char(1),
@CreateTime datetime,
@CreaterID bigint,
@CreaterName nvarchar(50),
@UpdateTime datetime,
@UpdaterID bigint,
@UpdaterName nvarchar(50)
 AS 
	UPDATE [SysWebSetting] SET 
	KeyName=@KeyName , RecordState=@RecordState ,
	[KeyValue] = @KeyValue,[Remark] = @Remark,[CreateTime] = @CreateTime,[CreaterID] = @CreaterID,[CreaterName] = @CreaterName,[UpdateTime] = @UpdateTime,[UpdaterID] = @UpdaterID,[UpdaterName] = @UpdaterName
	WHERE SysWebSettingID=@SysWebSettingID
GO
