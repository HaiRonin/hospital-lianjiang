package com.jingbao.controller;


import com.google.gson.Gson;
import com.jingbao.config.Config;
import com.jingbao.entity.basic.ServiceResult;
import com.jingbao.service.HisService;
import com.jingbao.service.impl.WechatServiceImpl;
import com.jingbao.util.HttpUtils;
import com.jingbao.util.JsonUtils;
import com.jingbao.util.StringUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/his")
public class HisController {

    @Autowired
    private HisService hisService;

    @Autowired
    WechatServiceImpl wechatService;

    private static Logger logger = LoggerFactory.getLogger(HisController.class);


    /**
     * 首页
     *
     * @return
     */
    @RequestMapping("/index")
    public String index() {
        return "/index";
    }


    /**
     * 科室介绍
     *
     * @return
     */
    @RequestMapping("/depInfo")
    public String depInfo() {
        return "index/departmentInfo";
    }

    /**
     * 公用接口-请求
     * @return
     */

    @RequestMapping("/request")
    @ResponseBody
    @SuppressWarnings("all")
    public String request(@RequestParam("dataParam") String dataParam,@RequestParam("api") String api) {
        return hisService.request(dataParam,api);
    }


    /**
     * 支付下单
     *
     * @return
     */

    @RequestMapping("/jsPay")
    @ResponseBody
    @SuppressWarnings("all")
    public ServiceResult jsPay(@RequestParam("payAount") String payAount, @RequestParam("openId") String openId,@RequestParam(value="outTradeNo")String outTradeNo) {
        return wechatService.jsPay(payAount, openId,outTradeNo);
    }

}
