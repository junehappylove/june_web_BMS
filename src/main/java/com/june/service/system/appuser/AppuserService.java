package com.june.service.system.appuser;

import java.util.List;

import org.springframework.stereotype.Service;

import com.june.entity.Page;
import com.june.service.common.BaseService;
import com.june.util.PageData;


@Service("appuserService")
public class AppuserService extends BaseService{

	/*
	* 通过loginname获取数据
	*/
	public PageData findByUId(PageData pd)throws Exception{
		return (PageData)dao.findForObject("AppuserMapper.findByUId", pd);
	}
	
	/*
	* 通过邮箱获取数据
	*/
	public PageData findByUE(PageData pd)throws Exception{
		return (PageData)dao.findForObject("AppuserMapper.findByUE", pd);
	}
	
	/*
	* 通过编号获取数据
	*/
	public PageData findByUN(PageData pd)throws Exception{
		return (PageData)dao.findForObject("AppuserMapper.findByUN", pd);
	}
	
	/*
	*用户列表(用户组)
	*/
	@SuppressWarnings("unchecked")
	public List<PageData> listPdPageUser(Page page)throws Exception{
		return (List<PageData>) dao.findForList("AppuserMapper.userlistPage", page);
	}
	
	/*
	* 保存用户IP
	*/
	public void saveIP(PageData pd)throws Exception{
		dao.update("AppuserMapper.saveIP", pd);
	}
	
	/*
	* 登录判断
	*/
	public PageData getUserByNameAndPwd(PageData pd)throws Exception{
		return (PageData)dao.findForObject("AppuserMapper.getUserInfo", pd);
	}
	/*
	* 跟新登录时间
	*/
	public void updateLastLogin(PageData pd)throws Exception{
		dao.update("AppuserMapper.updateLastLogin", pd);
	}
	//======================================================================================

	@Override
	public String xmlMapper() {
		return "AppuserMapper";
	}
	
	
}

