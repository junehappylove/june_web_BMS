package com.june.service.information.pictures;

import org.springframework.stereotype.Service;

import com.june.service.common.BaseService;
import com.june.util.PageData;


@Service("picturesService")
public class PicturesService extends BaseService{
	
	/*
	* 删除图片
	*/
	public void delTp(PageData pd)throws Exception{
		dao.update("PicturesMapper.delTp", pd);
	}

	@Override
	public String xmlMapper() {
		return "PicturesMapper";
	}
	
}

