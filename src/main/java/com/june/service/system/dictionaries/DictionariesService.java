package com.june.service.system.dictionaries;

import java.util.List;

import org.springframework.stereotype.Service;

import com.june.entity.Page;
import com.june.service.common.BaseService;
import com.june.util.PageData;

@Service("dictionariesService")
public class DictionariesService extends BaseService{
		
	//查询某编码
	public PageData findBmCount(PageData pd) throws Exception {
		return (PageData) dao.findForObject("DictionariesMapper.findBmCount", pd);
	}
	
	//列出同一父类id下的数据
	public List<PageData> dictlistPage(Page page) throws Exception {
		return list(page);
	}

	@Override
	public String xmlMapper() {
		return "DictionariesMapper";
	}
	
}
