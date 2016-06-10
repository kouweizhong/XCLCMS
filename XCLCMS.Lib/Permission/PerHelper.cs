﻿using System;
using System.Collections.Generic;
using System.Linq;

namespace XCLCMS.Lib.Permission
{
    /// <summary>
    /// 权限帮助类
    /// </summary>
    public class PerHelper
    {
        #region 角色相关

        /// <summary>
        /// 获取角色列表
        /// </summary>
        public static List<XCLCMS.Data.Model.SysRole> GetRoleList()
        {
            return new XCLCMS.Data.BLL.SysRole().GetModelList("");
        }

        /// <summary>
        /// 获取功能列表
        /// </summary>
        public static List<XCLCMS.Data.Model.View.v_SysFunction> GetFunctionList()
        {
            return new XCLCMS.Data.BLL.View.v_SysFunction().GetModelList("");
        }

        /// <summary>
        /// 获取指定用户的角色
        /// </summary>
        public static List<XCLCMS.Data.Model.SysRole> GetRoleByUserID(long userId)
        {
            return new XCLCMS.Data.BLL.SysRole().GetListByUserID(userId);
        }

        /// <summary>
        /// 获取普通商户的所有功能数据源列表
        /// </summary>
        public static List<XCLCMS.Data.Model.View.v_SysFunction> GetNormalMerchantFunctionTreeList()
        {
            var bll = new XCLCMS.Data.BLL.SysFunction();
            var roleBLL = new XCLCMS.Data.BLL.View.v_SysRole();
            var roleModel = roleBLL.GetModelByCode(XCLCMS.Data.CommonHelper.SysRoleConst.SysRoleCodeEnum.MerchantMainRole.ToString());
            if (null == roleModel)
            {
                throw new Exception("请指定普通商户所有功能主角色！");
            }
            var allFuns = GetFunctionList();
            var funLst = bll.GetListByRoleID(roleModel.SysRoleID.Value);
            var resultId = new List<long>();

            if (null != funLst && funLst.Count > 0)
            {
                funLst.ForEach(k =>
                {
                    var lst = bll.GetLayerListBySysFunctionId(k.SysFunctionID);
                    if (null != lst && lst.Count > 0)
                    {
                        resultId.AddRange(lst.Select(m => m.SysFunctionID));
                    }
                });
            }
            resultId = resultId.Distinct().ToList();
            return allFuns.Where(k => resultId.Contains(k.SysFunctionID.Value)).ToList();
        }

        #endregion 角色相关

        #region 权限功能相关

        /// <summary>
        /// 判断指定用户是否至少拥有权限组中的某个权限
        /// </summary>
        public static bool HasAnyPermission(long userId, List<XCLCMS.Lib.Permission.Function.FunctionEnum> functionList)
        {
            bool flag = false;
            if (null != functionList && functionList.Count > 0)
            {
                List<long> funList = functionList.Select(k => (long)k).ToList();
                flag = new XCLCMS.Data.BLL.SysFunction().CheckUserHasAnyFunction(userId, funList);
            }
            return flag;
        }

        /// <summary>
        /// 判断指定用户是否拥有某个权限
        /// </summary>
        public static bool HasPermission(long userId, XCLCMS.Lib.Permission.Function.FunctionEnum funEm)
        {
            return PerHelper.HasAnyPermission(userId, new List<Function.FunctionEnum>() {
                funEm
            });
        }

        #endregion 权限功能相关
    }
}