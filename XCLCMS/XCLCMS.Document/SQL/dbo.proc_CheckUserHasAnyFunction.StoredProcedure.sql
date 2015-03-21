USE [XCLCMS]
GO
/****** Object:  StoredProcedure [dbo].[proc_CheckUserHasAnyFunction]    Script Date: 03/21/2015 10:00:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_CheckUserHasAnyFunction](
	--验证某个用户是否拥有指定功能列表中的某个功能权限
	@IsPass TINYINT OUTPUT,--0：验证通过  1：验证不通过
	@UserInfoID BIGINT,--用户ID
	@FunctionListXML XML=NULL--要验证的功能列表，long xml
) AS 
BEGIN
	SET @IsPass=0
	;WITH Function_Info AS (
		--要验证的功能
		SELECT 
		T.C.value('text()[1]','bigint') AS FunctionID
		FROM @FunctionListXML.nodes('//long') AS T(C)
	),UserRoleFunction_Info AS (
		--该用户的所有角色的所有功能
		SELECT
		DISTINCT b.*
		FROM dbo.SysUserRole AS a 
		INNER JOIN dbo.SysRoleFunction AS b ON a.FK_UserInfoID=@UserInfoID AND a.RecordState='N' AND b.RecordState='N' AND a.FK_SysRoleID=b.FK_SysRoleID
	)
	SELECT TOP 1 @IsPass=1 FROM Function_Info AS a
	INNER JOIN UserRoleFunction_Info AS b ON a.FunctionID=b.FK_SysFunctionID
	
	RETURN
END
GO
