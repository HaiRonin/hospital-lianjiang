package com.jingbao.service;

import com.alibaba.fastjson.JSON;
import com.jingbao.prjo.HisResponse;
import com.jingbao.util.HttpXmlUtils;
import com.jingbao.util.StringUtil;
import com.jingbao.util.WxSignUtils;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

public interface HisService {
	public String request(String dataParam,  String api);

	/**
	 * 后台直接调用His接口
	 * @param dataParam
	 * @param api
	 * @return
	 */
	public HisResponse requestHisService(String dataParam, String api);
}
