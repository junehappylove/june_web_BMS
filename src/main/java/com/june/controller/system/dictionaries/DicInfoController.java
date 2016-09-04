/**
 * 中科方德软件有限公司<br>
 * BMSystem:com.june.controller.system.dictionaries.DicInfoController.java
 * 日期:2016年8月26日
 */
package com.june.controller.system.dictionaries;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.june.controller.base.BaseController;
import com.june.entity.Page;
import com.june.entity.PageTable;
import com.june.service.system.dictionaries.DicInfoService;
import com.june.util.Const;

/**
 * 通用字典工具类 <br>
 * 
 * @author 王俊伟 wjw.happy.love@163.com
 * @date 2016年8月26日 上午11:17:55
 */
@Controller
@RequestMapping(value="/dic")
public class DicInfoController extends BaseController {

	@Resource(name="dicInfoService")
	private DicInfoService dicInfoService;
	/**
	 * 通用字典列表页面
	 * @param page
	 * @return
	 * @throws Exception
	 * @date 2016年8月26日 上午11:19:43
	 * @writer iscas
	 */
	@RequestMapping(value="/dicinfo")
	public ModelAndView list(Page page)throws Exception{
		
		ModelAndView mv = this.initMV();
		PageTable pt = new PageTable(this.getRequest(),true);

		String seach = pt.getString("SEARCH_KEY");
		if(StringUtils.isNotEmpty(seach)){
			seach = seach.trim();
			pt.put("SEARCH_KEY", seach);
		}
		page.setShowCount(10);	//设置每页显示条数
		page.setPt(pt);				
		List<PageTable> varList = dicInfoService.list_(page);
		
		mv.setViewName("system/dictionaries/dic_info");
		mv.addObject("varList", varList);
		mv.addObject(Const.PAGE_TABLE, pt);
		return mv;
	}

	/**
	 * 添加页面
	 * @return
	 * @throws Exception
	 * @date 2016年8月29日 下午5:54:29
	 * @writer iscas
	 */
	@RequestMapping(value="/add")
	public ModelAndView add() throws Exception{
		ModelAndView mv = this.initMV();
		PageTable pt ;
		pt = new PageTable(this.getRequest(),true);
		pt.put("EDIT", "add");
		mv.setViewName("system/dictionaries/dic_add");
		mv.addObject(Const.PAGE_TABLE, pt);
		return mv;
	}
	
	/**
	 * 编辑页面
	 * @return
	 * @throws Exception
	 * @date 2016年8月29日 下午5:54:19
	 * @writer iscas
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		ModelAndView mv = this.initMV();
		PageTable pt ;
		pt = new PageTable(this.getRequest(),true);
		pt = dicInfoService.findById(pt);
		pt.put("EDIT", "edit");
		mv.setViewName("system/dictionaries/dic_add");
		mv.addObject(Const.PAGE_TABLE, pt);
		return mv;
	}
	
	/**
	 * 添加或者修改
	 * @param out
	 * @return
	 * @throws Exception
	 * @date 2016年8月29日 下午5:54:09
	 * @writer iscas
	 */
	@RequestMapping(value="/save")
	public ModelAndView save(PrintWriter out) throws Exception{
		ModelAndView mv = this.initMV();
		PageTable pt = new PageTable(this.getRequest(),true);
		String sql = pt.getString("DIC_SQL");
		if(sql.equals("null")||"0".equals(sql)){
			pt.put("DIC_SQL", null);
		}
		String edit = pt.getString("EDIT");//判断添加或者修改
		if("add".equals(edit)){
			dicInfoService.save(pt);
			mv.addObject(Const.MESSAGE,Const.SUCCESS);
		}
		else if("edit".equals(edit)){
			dicInfoService.edit(pt);
			mv.addObject(Const.MESSAGE,Const.SUCCESS);
		}
		else{
			mv.addObject(Const.MESSAGE,Const.FAILED);
		}
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 判断是否存在
	 * @param out
	 * @date 2016年8月29日 下午5:54:50
	 * @writer iscas
	 */
	@RequestMapping(value="/has")
	public void has(PrintWriter out){
		PageTable pt = new PageTable(this.getRequest(),true);
		try{
			if(dicInfoService.findById(pt) != null){
				out.write(Const.ERROR);
			}else{
				out.write(Const.SUCCESS);
			}
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
	}
	

	@RequestMapping(value="/del")
	public void del(PrintWriter out) throws Exception{
		PageTable pt = new PageTable(this.getRequest());
		dicInfoService.delete(pt);
		out.write(Const.SUCCESS);
		out.close();
	}
}
