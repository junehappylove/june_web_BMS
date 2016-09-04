package com.june.service.weixin.command;

import org.springframework.stereotype.Service;

import com.june.service.common.BaseService;
import com.june.util.PageData;


@Service("commandService")
public class CommandService extends BaseService{
	
	/**
	* 匹配关键词
	*/
	public PageData findByKw(PageData pd)throws Exception{
		return (PageData)dao.findForObject("CommandMapper.findByKw", pd);
	}

	@Override
	public String xmlMapper() {
		return "CommandMapper";
	}
}

