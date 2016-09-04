/**
 * 中科方德软件有限公司<br>
 * BMSystem:com.june.service.common.BaseService.java
 * 日期:2016年8月18日
 */
package com.june.service.common;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.june.dao.DaoSupport;
import com.june.entity.Page;
import com.june.entity.PageTable;
import com.june.util.Const;
import com.june.util.PageData;

/**
 * 基础服务类 <br>
 * 
 * @author 王俊伟 wjw.happy.love@163.com
 * @date 2016年8月18日 上午11:34:26
 */
@Transactional
public abstract class BaseService {

	/**
	 * mapper文件的映射名称
	 * 
	 * @return
	 * @date 2016年8月18日 下午1:50:50
	 * @writer iscas
	 */
	public abstract String xmlMapper();

	@Resource(name = "daoSupport")
	protected DaoSupport dao;

	/**
	 * 新增
	 * 
	 * @param pd
	 * @throws Exception
	 * @date 2016年8月18日 下午1:23:23
	 * @writer iscas
	 */
	public void save(PageData pd) throws Exception {
		dao.save(xmlMapper() + Const.OPT_SAVE, pd);
	}
	public void save(PageTable pt) throws Exception {
		dao.save(xmlMapper() + Const.OPT_SAVE, pt);
	}

	/**
	 * 删除
	 * 
	 * @param pd
	 * @throws Exception
	 * @date 2016年8月18日 下午1:45:42
	 * @writer iscas
	 */
	public void delete(PageData pd) throws Exception {
		dao.delete(xmlMapper() + Const.OPT_DELE, pd);
	}
	public void delete(PageTable pt) throws Exception {
		dao.delete(xmlMapper() + Const.OPT_DELE, pt);
	}

	/**
	 * 批量删除
	 * 
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 * @date 2016年8月18日 下午2:06:31
	 * @writer iscas
	 */
	public void deleteAll(String[] ArrayDATA_IDS) throws Exception {
		dao.delete(xmlMapper() + Const.OPT_DELE_ALL, ArrayDATA_IDS);
	}

	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 * @date 2016年8月18日 下午1:43:45
	 * @writer iscas
	 */
	public void edit(PageData pd) throws Exception {
		dao.update(xmlMapper() + Const.OPT_EDIT, pd);
	}
	public void edit(PageTable pt) throws Exception {
		dao.update(xmlMapper() + Const.OPT_EDIT, pt);
	}

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 * @date 2016年8月18日 下午1:44:16
	 * @writer iscas
	 */
	public PageData findById(PageData pd) throws Exception {
		return (PageData) dao.findForObject(xmlMapper() + Const.OPT_SEARCH, pd);
	}
	
	public PageTable findById(PageTable pt) throws Exception {
		return (PageTable) dao.findForObject(xmlMapper() + Const.OPT_SEARCH, pt);
	}

	/**
	 * 批量获取
	 * 
	 * @param ArrayDATA_IDS
	 * @return
	 * @throws Exception
	 * @date 2016年8月18日 下午2:10:36
	 * @writer iscas
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> getAllById(String[] ArrayDATA_IDS) throws Exception {
		return (List<PageData>) dao.findForList(xmlMapper() + Const.OPT_GET_ALL, ArrayDATA_IDS);
	}
	@SuppressWarnings("unchecked")
	public List<PageTable> getAllById_(String[] ArrayDATA_IDS) throws Exception {
		return (List<PageTable>) dao.findForList(xmlMapper() + Const.OPT_GET_ALL, ArrayDATA_IDS);
	}

	/**
	 * 查询总数
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 * @date 2016年8月18日 下午1:44:48
	 * @writer iscas
	 */
	public PageData findCount(PageData pd) throws Exception {
		return (PageData) dao.findForObject(xmlMapper() + Const.OPT_COUNT, pd);
	}
	public PageTable findCount(PageTable pt) throws Exception {
		return (PageTable) dao.findForObject(xmlMapper() + Const.OPT_COUNT, pt);
	}

	/**
	 * 列表(全部)
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 * @date 2016年8月18日 下午2:04:56
	 * @writer iscas
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList(xmlMapper() + Const.OPT_LIST_ALL, pd);
	}
	@SuppressWarnings("unchecked")
	public List<PageTable> listAll(PageTable pt) throws Exception {
		return (List<PageTable>) dao.findForList(xmlMapper() + Const.OPT_LIST_ALL, pt);
	}

	/**
	 * 分页查询
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 * @date 2016年8月18日 下午2:12:58
	 * @writer iscas
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page) throws Exception {
		return (List<PageData>) dao.findForList(xmlMapper() + Const.OPT_PAGED, page);
	}
	
	@SuppressWarnings("unchecked")
	public List<PageTable> list_(Page page) throws Exception {
		return (List<PageTable>) dao.findForList(xmlMapper() + Const.OPT_PAGED, page);
	}
}
