package com.june.service.weixin.textmsg;

import org.springframework.stereotype.Service;

import com.june.service.common.BaseService;
import com.june.util.PageData;


@Service("textmsgService")
public class TextmsgService extends BaseService{

	/*
	* 匹配关键词
	*/
	public PageData findByKw(PageData pd)throws Exception{
		return (PageData)dao.findForObject("TextmsgMapper.findByKw", pd);
	}

	@Override
	public String xmlMapper() {
		return "TextmsgMapper";
	}
}

