USE [XCLCMS]
GO
/****** Object:  StoredProcedure [dbo].[proc_GenerateID]    Script Date: 03/21/2015 10:00:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_GenerateID](
	@ResultCode INT OUTPUT,
	@ResultMessage NVARCHAR(1000) OUTPUT,

	@IDType CHAR(3),
	@Remark NVARCHAR(100),
	@IDValue BIGINT OUT,
	@IDCode BIGINT OUT
) AS
--生成ID值
BEGIN
	BEGIN TRAN trans
	
	BEGIN TRY
		
		--用户信息ID
		IF(@IDType='USR')
		BEGIN
			SELECT @IDValue=ISNULL(MAX(IDValue),100)+1 FROM dbo.GenerateID WHERE IDType=@IDType
			SET @IDCode=CAST('100'+CAST(@IDValue AS VARCHAR) AS BIGINT)
		END
		--系统配置ID
		ELSE IF(@IDType='SET')
		BEGIN
			SELECT @IDValue=ISNULL(MAX(IDValue),100)+1 FROM dbo.GenerateID WHERE IDType=@IDType
			SET @IDCode=CAST('200'+CAST(@IDValue AS VARCHAR) AS BIGINT)
		END
		--系统字典
		ELSE IF(@IDType='DIC')
		BEGIN
			SELECT @IDValue=ISNULL(MAX(IDValue),100)+1 FROM dbo.GenerateID WHERE IDType=@IDType
			SET @IDCode=CAST('300'+CAST(@IDValue AS VARCHAR) AS BIGINT)
		END
		--系统功能
		ELSE IF(@IDType='FUN')
		BEGIN
			SELECT @IDValue=ISNULL(MAX(IDValue),100)+1 FROM dbo.GenerateID WHERE IDType=@IDType
			SET @IDCode=CAST('400'+CAST(@IDValue AS VARCHAR) AS BIGINT)
		END
		
		INSERT INTO dbo.GenerateID ( IDType, IDValue,IDCode,CreateTime, Remark ) VALUES(@IDType,@IDValue,@IDCode,GETDATE(),@Remark)	
	
		SET @ResultCode=1
		COMMIT TRAN
	
	END TRY
	BEGIN CATCH
	
		set @ResultMessage= ERROR_MESSAGE() 
		SET @ResultCode=0
		ROLLBACK TRAN		
		
	END CATCH

	
END
GO
