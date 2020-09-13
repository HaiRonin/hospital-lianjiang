package com.jingbao.service.impl;

import com.google.gson.Gson;
import com.jingbao.config.Config;
import com.jingbao.prjo.HisResponse;
import com.jingbao.service.HisService;
import com.jingbao.util.HttpUtils;
import com.jingbao.util.JsonUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author wu123
 * @since 2019-01-17
 */
@Service
public class HisServiceImpl  implements HisService {

    private static Logger logger = LoggerFactory.getLogger(HisServiceImpl.class);

    @Override
    public String request(String dataParam, String api) {
        /*测试代码**/
//        Gson gson = new Gson();
//        Map<String, Object> map = new HashMap<String, Object>();
//        map = gson.fromJson(dataParam, map.getClass());
//        if(map.containsKey("id")){
//            String id=(String) map.get("id");
//            if(StringUtils.isBlank(id)){
//                map.put("id","oKuwuv3fRIi_C26FkR6W0OzOtSBk");
//                dataParam = JsonUtils.toJson(map);
//            }
//        }
        Map<String, String> headers = new HashMap<>();
        headers.put("arg0", dataParam);
        HttpResponse response;
        String result = "";
        try {
            logger.info("=======接口名称=>"+Config.URL+api);
            logger.info("=======请求参数=>"+dataParam);
            response = HttpUtils.doPost(Config.URL, api, Config.GET_METHOD, new HashMap<>(), null,headers);
            result = EntityUtils.toString(response.getEntity(), "UTF-8");
        } catch (Exception e) {
            logger.info("==========================His接口请求异常====================================");
            e.printStackTrace();
        }
        logger.info("=======返回内容=>"+result);
        return result;
    }

    @Override
    public HisResponse requestHisService(String dataParam, String api) {
        Map<String, String> headers = new HashMap<>();
        headers.put("arg0", dataParam);
        HttpResponse responseInfo;
        String result = "";
        try {
//            logger.info("==========================His接口=======begin====================================");
            logger.info("=======接口名称=>"+Config.URL+api);
            logger.info("=======请求参数=>"+dataParam);
            responseInfo = HttpUtils.doPost(Config.URL, api, Config.GET_METHOD, new HashMap<>(), null,headers);
            result = EntityUtils.toString(responseInfo.getEntity(), "UTF-8");
        } catch (Exception e) {
            e.printStackTrace();
            logger.info("==========================His接口请求异常====================================");
        }
        logger.info("=======返回内容=>"+result);
//        logger.info("==========================His接口=======end====================================");
        if(StringUtils.isNotBlank(result)){
            Gson gson = new Gson();
            HisResponse hisResponse =  gson.fromJson(result,HisResponse.class);
            return hisResponse;
        }
//        logger.info("==========================His接口请求异常====================================");
        return null;
    }
}
