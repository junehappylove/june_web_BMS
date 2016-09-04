package com.june.service.weixin.imgmsg;

import org.springframework.stereotype.Service;

import com.june.service.common.BaseService;
import com.june.util.PageData;


@Service("imgmsgService")
public class ImgmsgService extends BaseService{

	/*
	* 匹配关键词
	*/
	public PageData findByKw(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ImgmsgMapper.findByKw", pd);
	}

	@Override
	public String xmlMapper() {
		return "ImgmsgMapper";
	}
}

