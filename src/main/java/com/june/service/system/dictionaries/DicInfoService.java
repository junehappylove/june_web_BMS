package com.june.service.system.dictionaries;

import org.springframework.stereotype.Service;

import com.june.service.common.BaseService;

@Service("dicInfoService")
public class DicInfoService extends BaseService{

	@Override
	public String xmlMapper() {
		return "DicInfoMapper";
	}
	
}
