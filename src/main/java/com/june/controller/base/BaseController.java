package com.june.controller.base;


import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.june.entity.Page;
import com.june.util.Const;
import com.june.util.Logger;
import com.june.util.PageData;
import com.june.util.UuidUtil;

/**
 * 
 * BaseController <br>
 * 
 * @author 王俊伟 wjw.happy.love@163.com
 * @date 2016年8月17日 下午7:32:14
 */
public class BaseController {
	
	protected Logger logger = Logger.getLogger(this.getClass());
	
	/**
	 * 得到PageData
	 */
	public PageData getPageData(){
		return new PageData(this.getRequest());
	}
	
	/**
	 * 得到ModelAndView
	 */
	public ModelAndView initMV(){
		return new ModelAndView();
	}
	
	/**
	 * 得到request对象
	 */
	public HttpServletRequest getRequest() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		return request;
	}

	/**
	 * 得到32位的uuid
	 * @return
	 */
	public String get32UUID(){
		return UuidUtil.get32UUID();
	}
	
	/**
	 * 得到分页列表的信息 
	 */
	public Page getPage(){
		return new Page();
	}
	
	public static void logBefore(Logger logger, String interfaceName){
		//logger.info("");
		logger.info("start");
		try {
			logger.info(new String(interfaceName.getBytes(),"GBK"));
		} catch (UnsupportedEncodingException e) {
			logger.info(interfaceName);
			e.printStackTrace();
		}
	}
	
	public static void logAfter(Logger logger){
		logger.info("end");
		//logger.info("");
	}

	/* ===============================权限================================== */
	/**
	 * 权限处理
	 * @return
	 * @date 2016年8月17日 下午7:36:06
	 * @writer iscas
	 */
	public Map<String, String> getHC(){
		Subject currentUser = SecurityUtils.getSubject();  //shiro管理的session
		Session session = currentUser.getSession();
		@SuppressWarnings("unchecked")
		Map<String, String> attribute = (Map<String, String>)session.getAttribute(Const.SESSION_QX);
		return attribute;
	}
	/* ===============================权限================================== */

	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
