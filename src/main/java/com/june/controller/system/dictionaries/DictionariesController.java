package com.june.controller.system.dictionaries;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.june.controller.base.BaseController;
import com.june.entity.Page;
import com.june.service.system.dictionaries.DictionariesService;
import com.june.util.AppUtil;
import com.june.util.Const;
import com.june.util.GetPinyin;
import com.june.util.PageData;

/**
 * 
 * 通用字典工具类 <br>
 * 
 * @author 王俊伟 wjw.happy.love@163.com
 * @date 2016年8月26日 上午10:53:10
 */
@Controller
@RequestMapping(value="/dictionaries")
public class DictionariesController extends BaseController {
	
	/*@Resource(name="menuService")
	private MenuService menuService;*/
	@Resource(name="dictionariesService")
	private DictionariesService dictionariesService;
	
	/**
	 * 保存 添加或者修改
	 */
	@RequestMapping(value="/save")
	public ModelAndView save(PrintWriter out) throws Exception{
		ModelAndView mv = this.initMV();
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData pdp = new PageData();
		pdp = this.getPageData();
		
		String PARENT_ID = pd.getString("PARENT_ID");
		pdp.put("ZD_ID", PARENT_ID);
		String pkid = pd.getString("ZD_ID");
		// 处理 字典的编码，如果用户不输入编码，自动生成编码
		String bm = pd.getString("BIANMA");
		if(StringUtils.isEmpty(bm)){
			String str = pd.getString("NAME");
			bm = GetPinyin.getPinYinHeadCharUpper(str);
			pd.put("BIANMA", bm);
		}
		
		if(StringUtils.isEmpty(pkid)){
			if(null != PARENT_ID && "0".equals(PARENT_ID)){
				pd.put("JB", 1);
				pd.put("P_BM",bm);
			}else{
				pdp = dictionariesService.findById(pdp);//这里才是真真的上一级
				pd.put("JB", Integer.parseInt(pdp.get("JB").toString()) + 1);//级别设置
				// 设置编码
				pd.put("P_BM", pdp.getString("BIANMA") + "_" + bm);
			}
			pd.put("ZD_ID", this.get32UUID());	//ID
			dictionariesService.save(pd);
		}else{
			pdp = dictionariesService.findById(pdp);
			if(null != PARENT_ID && "0".equals(PARENT_ID)){//顶级节点
				pd.put("P_BM",  bm);
			}else{//非顶级节点
				pd.put("P_BM", pdp.getString("BIANMA") + "_" + bm);
			}
			
			dictionariesService.edit(pd);
		}
		
		mv.addObject(Const.MESSAGE,Const.SUCCESS);
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 列表
	 */
	List<PageData> szdList;
	
	@RequestMapping
	public ModelAndView list(Page page)throws Exception{
		
		ModelAndView mv = this.initMV();
		PageData pd = new PageData();
		pd = this.getPageData();
		String PARENT_ID = pd.getString("PARENT_ID");
		
		if(null != PARENT_ID && !"".equals(PARENT_ID) && !"0".equals(PARENT_ID)){
			
			//返回按钮用
			PageData pdp = new PageData();
			pdp = this.getPageData();
			
			pdp.put("ZD_ID", PARENT_ID);
			pdp = dictionariesService.findById(pdp);
			mv.addObject("pdp", pdp);
			
			//头部导航
			szdList = new ArrayList<PageData>();
			this.getZDname(PARENT_ID);	//	逆序
			Collections.reverse(szdList);
			
		}
		
		String NAME = pd.getString("NAME");
		if(null != NAME && !"".equals(NAME)){
			NAME = NAME.trim();
			pd.put("NAME", NAME);
		}
		page.setShowCount(5);	//设置每页显示条数
		page.setPd(pd);				
		List<PageData> varList = dictionariesService.dictlistPage(page);
		
		mv.setViewName("system/dictionaries/zd_list");
		mv.addObject("varList", varList);
		mv.addObject("varsList", szdList);
		mv.addObject(Const.PAGE_DATA, pd);
		return mv;
	}
	
	//递归
	public void getZDname(String PARENT_ID) {
		logBefore(logger, "递归");
		try {
			PageData pdps = new PageData();;
			pdps.put("ZD_ID", PARENT_ID);
			pdps = dictionariesService.findById(pdps);
			if(pdps != null){
				szdList.add(pdps);
				String PARENT_IDs = pdps.getString("PARENT_ID");
				this.getZDname(PARENT_IDs);
			}
		} catch (Exception e) {
			logger.error(e.toString(),e);
		}
	}
	
	/**
	 * 去新增页面
	 */
	@RequestMapping(value="/toAdd")
	public ModelAndView toAdd(Page page){
		ModelAndView mv = this.initMV();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			mv.setViewName("system/dictionaries/zd_edit");
			mv.addObject(Const.PAGE_DATA, pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		return mv;
	}
	
	/**
	 * 去编辑页面
	 */
	@RequestMapping(value="/toEdit")
	public ModelAndView toEdit( String ROLE_ID )throws Exception{
		ModelAndView mv = this.initMV();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = dictionariesService.findById(pd);
		int total = Integer.parseInt(dictionariesService.findCount(pd).get("ZS").toString());
		if(total != 0){
			mv.addObject(Const.MESSAGE, Const.NO);
		}else{
			mv.addObject(Const.MESSAGE, Const.OK);
		}
		mv.setViewName("system/dictionaries/zd_edit");
		mv.addObject(Const.PAGE_DATA, pd);
		return mv;
	}
	
	
	/**
	 * 判断编码是否存在
	 */
	@RequestMapping(value="/has")
	public void has(PrintWriter out){
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String bm = pd.getString("BIANMA");
			if(StringUtils.isEmpty(bm)){
				String str = pd.getString("NAME");
				bm = GetPinyin.getPinYinHeadCharUpper(str);
				pd.put("BIANMA", bm);
			}
			if(dictionariesService.findBmCount(pd) != null){
				out.write(Const.ERROR);
			}else{
				out.write(Const.SUCCESS);
			}
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
	}
	
	/**
	 * 删除用户
	 */
	@RequestMapping(value="/del")
	@ResponseBody
	public Object del(){
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		String errInfo = "";
		try{
			pd = this.getPageData();
			
			if(Integer.parseInt(dictionariesService.findCount(pd).get("ZS").toString()) != 0){
				errInfo = Const.FALSE_;
			}else{
				dictionariesService.delete(pd);
				errInfo = Const.SUCCESS;
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
		map.put(Const.RESULT, errInfo);
		return AppUtil.returnObject(new PageData(), map);
		
	}
	

}
