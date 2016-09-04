package com.june.service.system.menu;

import java.util.List;

import org.springframework.stereotype.Service;

import com.june.entity.system.Menu;
import com.june.service.common.BaseService;
import com.june.util.PageData;

@Service("menuService")
public class MenuService extends BaseService{
	
	public void save(Menu menu) throws Exception {
		dao.save(xmlMapper()+".save", menu);
	}
	
	public void deleteMenuById(String MENU_ID) throws Exception {
		dao.save("MenuMapper.deleteMenuById", MENU_ID);
	}

	//取最大id
	public PageData findMaxId(PageData pd) throws Exception {
		return (PageData) dao.findForObject("MenuMapper.findMaxId", pd);
	}
	
	public List<Menu> listAllParentMenu() throws Exception {
		//return (List<Menu>) dao.findForList("MenuMapper.listAllParentMenu", null);
		List<Menu> parents = listSubMenuByParentId("0");
		return parents;
	}

	@SuppressWarnings("unchecked")
	public List<Menu> listSubMenuByParentId(String parentId) throws Exception {
		return (List<Menu>) dao.findForList("MenuMapper.listSubMenuByParentId", parentId);
	}
		
	public List<Menu> listAllMenu() throws Exception {
		List<Menu> rl = this.listAllParentMenu();
		String menuid = "";
		for(Menu menu : rl){
			menuid = menu.getMENU_ID();
			List<Menu> subList = this.listSubMenuByParentId(menuid);
			menu.setSubMenu(subList);
		}
		return rl;
	}

	/**
	 * 保存菜单图标 (顶部菜单)
	 */
	public PageData editicon(PageData pd) throws Exception {
		return (PageData)dao.findForObject("MenuMapper.editicon", pd);
	}
	
	/**
	 * 更新子菜单类型菜单
	 */
	public PageData editType(PageData pd) throws Exception {
		return (PageData)dao.findForObject("MenuMapper.editType", pd);
	}

	@Override
	public String xmlMapper() {
		return "MenuMapper";
	}
}
