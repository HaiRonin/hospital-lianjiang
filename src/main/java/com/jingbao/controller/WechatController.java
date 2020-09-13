package com.jingbao.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.google.gson.Gson;
import com.jingbao.entity.basic.DoRegIn;
import com.jingbao.entity.basic.ServiceResult;
import com.jingbao.entity.model.DepositPayment;
import com.jingbao.entity.model.DopayInfo;
import com.jingbao.entity.model.DoregInfo;
import com.jingbao.prjo.AccessToken;
import com.jingbao.prjo.WeixinUserInfo;
import com.jingbao.service.DepositPaymentService;
import com.jingbao.service.DopayInfoService;
import com.jingbao.service.DoregInfoService;
import com.jingbao.service.IWechatService;
import com.jingbao.util.JedisUtil;

import com.jingbao.util.StringUtil;
import com.jingbao.util.WeiXinUtil;
import com.jingbao.weixin.entity.WXPayResult;
import lombok.extern.slf4j.Slf4j;
import me.chanjar.weixin.mp.api.WxMpMessageRouter;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.message.WxMpXmlMessage;
import me.chanjar.weixin.mp.bean.message.WxMpXmlOutMessage;
import org.apache.commons.lang3.StringUtils;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.xml.sax.InputSource;
import redis.clients.jedis.Jedis;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.StringReader;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author dell
 */
@Controller
@RequestMapping(value = "/wechat")
@Slf4j
public class WechatController {

    @Autowired
    private WxMpService wxMpService;

    @Autowired
    private WxMpMessageRouter router;

    @Autowired
    private DopayInfoService dopayInfoService;

    @Autowired
    private DoregInfoService doregInfoService;

    @Autowired
    private IWechatService iWechatService;

    @Autowired
    private DepositPaymentService depositPaymentService;

    private static final Logger logger = LoggerFactory.getLogger(WechatController.class);

    /**
     * 创建临时带参数二维码
     * @expireSeconds 该二维码有效时间，以秒为单位。 最大不超过2592000（即30天），此字段如果不填，则默认有效期为30秒。
     * @param sceneId 场景Id
     * @return
     * 2018 1 8
     */
    @RequestMapping(value = "/getCreateTempQr")
    @ResponseBody
    @SuppressWarnings("unchecked")
    public String getCreateTempQr(@RequestParam(value = "expireSeconds") String expireSeconds,@RequestParam(value = "sceneId") int sceneId) {
        String createTempQr = WeiXinUtil.createTempQr(expireSeconds,sceneId);
        if (StringUtil.isNotNull(createTempQr)) {
            System.out.println("======================"+createTempQr);
            return createTempQr;
        }
        return null;
    }

    /**
     * 换取token后，获得openid，公众号的appId和secret
     *
     * @param code 微信回调返回的code
     * @author: yixin
     * @Date 2018-12-10
     */
    @GetMapping(value = "/getOpenid")
    @ResponseBody
    @SuppressWarnings("unchecked")
    public String getOpenid(@RequestParam(value = "code") String code) {

        logger.info("WeiXinUtil-getOpenid===>>>code="+code);
        String openId = JedisUtil.getJedis().get("wechat_"+code);
        if(StringUtils.isBlank(openId)){
            openId = WeiXinUtil.getOpenid(code);
            if(StringUtil.isNotNull(openId)){
                JedisUtil.getJedis().set("wechat_"+code, openId);
                JedisUtil.getJedis().expire("wechat_"+code,60*30);
            }else {
                logger.info("获取用户openId失败【111】==>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>openId="+openId);
            }
        }
        logger.info("WeiXinUtil-WeiXinUtil.getOpenid===>>>openId="+openId);
        if (StringUtil.isNotNull(openId)) {
            //获取不到token则重新从微信获取
            logger.info("WeiXinUtil-WeiXinUtil.AccessToken===>>>token="+(JedisUtil.getJedis().get("token")));
            if(StringUtils.isBlank(JedisUtil.getJedis().get("token"))){
                AccessToken accessToken = WeiXinUtil.getAccessToken();
                if(null != accessToken.getAccess_token()){
                    logger.info("AccessToken>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>="+accessToken);
                    JedisUtil.getJedis().set("token", accessToken.getAccess_token());
                    JedisUtil.getJedis().expire("token",60*115);
                    logger.info("redis获取不到access_token，重新获取设置==>accessToken="+accessToken.toString());
                    WeixinUserInfo user = WeiXinUtil.getUserInfo(accessToken.getAccess_token(), openId);
                    user.setOpenId(openId);
                    logger.info("获取用户信息成功="+user.toString());
                    return new Gson().toJson(user);
                }
            }
            logger.info("RedisUtils.getJedis().get(\"token\")>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>="+JedisUtil.getJedis().get("token"));
            WeixinUserInfo user = WeiXinUtil.getUserInfo(JedisUtil.getJedis().get("token"), openId);
            user.setOpenId(openId);
            logger.info("获取用户信息成功="+user.toString());
            return new Gson().toJson(user);
        }
        logger.info("获取用户openId失败【137】==>code="+code);
        return "1000";
    }


    /**
     * 处理微信服务器发送的get请求,确认请求来自于微信服务器
     *
     * @param signature
     * @param timestamp
     * @param nonce
     * @param echostr
     * @return
     */
    @GetMapping(value = "/portal", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String authGet(@RequestParam(name = "signature", required = false) String signature,
                          @RequestParam(name = "timestamp", required = false) String timestamp,
                          @RequestParam(name = "nonce", required = false) String nonce,
                          @RequestParam(name = "echostr", required = false) String echostr) {
        if (StringUtils.isAnyBlank(signature, timestamp, nonce, echostr)) {
            throw new IllegalArgumentException("请求参数非法，请核实!");
        }
        if (this.wxMpService.checkSignature(timestamp, nonce, signature)) {
            return echostr;
        }
        return "非法请求";
    }

    /**
     * 处理微信服务器发送的post请求
     *
     * @param requestBody
     * @param signature
     * @param timestamp
     * @param nonce
     * @param encType
     * @param msgSignature
     * @return
     */
    @PostMapping(value = "/portal", produces = "application/xml; charset=UTF-8")
    @ResponseBody
    public String post(@RequestBody String requestBody, @RequestParam("signature") String signature,
                       @RequestParam("timestamp") String timestamp, @RequestParam("nonce") String nonce,
                       @RequestParam(name = "encrypt_type", required = false) String encType,
                       @RequestParam(name = "msg_signature", required = false) String msgSignature) {


        if (!this.wxMpService.checkSignature(timestamp, nonce, signature)) {
            throw new IllegalArgumentException("非法请求，可能属于伪造的请求！");
        }

        String out = null;
        if (encType == null) {
            // 明文传输的消息
            WxMpXmlMessage inMessage = WxMpXmlMessage.fromXml(requestBody);
            WxMpXmlOutMessage outMessage = this.route(inMessage);
            if (outMessage == null) {
                return "";
            }

            out = outMessage.toXml();
        } else if ("aes".equals(encType)) {
            // aes加密的消息
            WxMpXmlMessage inMessage = WxMpXmlMessage.fromEncryptedXml(requestBody,
                    this.wxMpService.getWxMpConfigStorage(), timestamp, nonce, msgSignature);
            WxMpXmlOutMessage outMessage = this.route(inMessage);
            if (outMessage == null) {
                return "";
            }

            out = outMessage.toEncryptedXml(this.wxMpService.getWxMpConfigStorage());
        }


        return out;
    }

    private WxMpXmlOutMessage route(WxMpXmlMessage message) {
        try {
            return this.router.route(message);
        } catch (Exception e) {
        }

        return null;
    }


    /**
     * 微信支付回调
     *
     * @param request
     * @param response
     * @param model
     */
    @RequestMapping("/notify_weixin")
    public ServiceResult notify_weixin(HttpServletRequest request,
                                       HttpServletResponse response, Model model) {

        logger.info("微信支付回调》》》》》》》》》》》》》》》开始");
        String inputLine;
        String notityXml = "";
        String resXml = "";

        try {
            while ((inputLine = request.getReader().readLine()) != null) {
                notityXml += inputLine;
            }
            request.getReader().close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        logger.info("微信接收到的报文：" + notityXml);
        Map m = parseXmlToList2(notityXml);
        WXPayResult wpr = new WXPayResult();
        wpr.setAppid(m.get("appid").toString());
        wpr.setBank_type(m.get("bank_type").toString());
        wpr.setCash_fee(Integer.parseInt(m.get("cash_fee").toString()));
        wpr.setFee_type(m.get("fee_type").toString());
        wpr.setIs_subscribe(m.get("is_subscribe").toString());
        wpr.setMch_id(m.get("mch_id").toString());
        wpr.setNonce_str(m.get("nonce_str").toString());
        wpr.setOpenid(m.get("openid").toString());
        wpr.setOut_trade_no(m.get("out_trade_no").toString());
        wpr.setResult_code(m.get("result_code").toString());
        wpr.setReturn_code(m.get("return_code").toString());
        wpr.setSign(m.get("sign").toString());
        wpr.setTime_end(m.get("time_end").toString());
        wpr.setTotal_fee(Integer.parseInt(m.get("total_fee").toString()));
        wpr.setTrade_type(m.get("trade_type").toString());
        wpr.setTransaction_id(m.get("transaction_id").toString());
        String orderNo = wpr.getOut_trade_no();
        if ("SUCCESS".equalsIgnoreCase(wpr.getResult_code())) {
            if(orderNo==null){
                logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>orderNo商户流水号为空》》》》》》》》》》》》》》》");
                resXml = "<xml>" + "<return_code><![CDATA[SUCCESS]]></return_code>"
                        + "<return_msg><![CDATA[OK]]></return_msg>" + "</xml> ";
                logger.info("微信支付回调数据结束" + resXml);
                return ServiceResult.succ();
            }else {
                if(orderNo.substring(0,2).equals("RE")){
                    //生成收款记录 调用his。
                    boolean isOK = doregInfoService.postHisRegInfo(orderNo,wpr.getTransaction_id());
                    if (isOK){
                        logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>his请求成功》》》》》》》》》》》》》》》SUCCESS");
                        return ServiceResult.succ();
                    }else{
                        EntityWrapper<DoregInfo> wntityWrapperDoregInfo = new EntityWrapper<>();
                        DoregInfo doregInfo = new DoregInfo();
                        doregInfo.setOutTradeNo(orderNo);
                        wntityWrapperDoregInfo.setEntity(doregInfo);
                        DoregInfo doregInfoNew = doregInfoService.selectOne(wntityWrapperDoregInfo);
                        //String.valueOf(doregInfoNew.getPayAmount())
                        Map<String, Object> info = iWechatService.refund(wpr.getTransaction_id(),String.valueOf(String.valueOf(wpr.getTotal_fee()/100)));
                        if(info.get("code").equals("SUCCESS")){
                           boolean updateInfo = doregInfoService.updateRegInfoSuccessfulPayment(orderNo);
                            if (updateInfo) {
                                logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>successfulPayment修改成功》》》》》》》》》》》》》》》SUCCESS");
                            }else {
                                logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>successfulPayment修改失败》》》》》》》》》》》》》》》FAIL");
                            }
                            // 支付成功
                            resXml = "<xml>" + "<return_code><![CDATA[SUCCESS]]></return_code>"
                                    + "<return_msg><![CDATA[OK]]></return_msg>" + "</xml> ";
                            logger.info("微信支付回调数据结束" + resXml);
                            return ServiceResult.succ();
                        }else {
                            resXml = "<xml>" + "<return_code><![CDATA[FAIL]]></return_code>"
                                    + "<return_msg><![CDATA[报文为空]]></return_msg>" + "</xml> ";
                            logger.info("微信支付回调数据结束" + resXml);
                            return ServiceResult.fail();
                        }

                    }
                }else if(orderNo.substring(0,2).equals("DO")){
                    //生成收款记录 调用his。
                    boolean getIsOK = dopayInfoService.postHisDopayInfo(orderNo,wpr.getTransaction_id());
                    if (getIsOK){
                        logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>his请求成功》》》》》》》》》》》》》》》SUCCESS");
                        return ServiceResult.succ();
                    }else{
                        EntityWrapper<DopayInfo> wntityWrapper = new EntityWrapper<>();
                        DopayInfo dopayInfo = new DopayInfo();
                        dopayInfo.setOutTradeNo(orderNo);
                        wntityWrapper.setEntity(dopayInfo);
                        DopayInfo dopayInfoNew = dopayInfoService.selectOne(wntityWrapper);
                        Map<String, Object> getInfo = iWechatService.refund(wpr.getTransaction_id(),String.valueOf(wpr.getTotal_fee()/100));
                        if(getInfo.get("code").equals("SUCCESS")) {
//                            //更新本地数据库
//                            EntityWrapper<DopayInfo> wntityWrapper = new EntityWrapper<>();
//                            DopayInfo dopayInfo = new DopayInfo();
//                            dopayInfo.setOutTradeNo(orderNo);
//                            wntityWrapper.setEntity(dopayInfo);
//                            DopayInfo dopayInfoNew = dopayInfoService.selectOne(wntityWrapper);
                            DopayInfo dopayInfoList = new DopayInfo();
                            dopayInfoList.setSuccessfulPayment("2");
                            dopayInfoList.setId(dopayInfoNew.getId());
                            dopayInfoService.updateById(dopayInfoList);
                            // 支付成功
                            resXml = "<xml>" + "<return_code><![CDATA[SUCCESS]]></return_code>"
                                    + "<return_msg><![CDATA[OK]]></return_msg>" + "</xml> ";
                            logger.info("微信支付回调数据结束" + resXml);
                        }else {
                            resXml = "<xml>" + "<return_code><![CDATA[FAIL]]></return_code>"
                                    + "<return_msg><![CDATA[报文为空]]></return_msg>" + "</xml> ";
                            logger.info("微信支付回调数据结束" + resXml);
                            return ServiceResult.fail();

                        }
                    }
                }else {
                    //生成收款记录 调用his。
                    boolean getIsOK = depositPaymentService.postHisDepositPayment(orderNo,wpr.getTransaction_id());
                    if (getIsOK){
                        logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>his请求成功》》》》》》》》》》》》》》》SUCCESS");
                        return ServiceResult.succ();
                    }else{
                        EntityWrapper<DepositPayment> wntityWrapperDepositPayment = new EntityWrapper<>();
                        DepositPayment depositPaymentInfo = new DepositPayment();
                        depositPaymentInfo.setOutTradeNo(orderNo);
                        wntityWrapperDepositPayment.setEntity(depositPaymentInfo);
                        DepositPayment depositPayment = depositPaymentService.selectOne(wntityWrapperDepositPayment);
                        //String.valueOf(depositPayment.getPayAmount())
                        Map<String, Object> info = iWechatService.refund(wpr.getTransaction_id(),String.valueOf(String.valueOf(wpr.getTotal_fee()/100)));
                        if(info.get("code").equals("SUCCESS")){
                            boolean updateInfo = depositPaymentService.updateDepositPaymentSuccessfulPayment(orderNo);
                            if (updateInfo) {
                                logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>successfulPayment修改成功》》》》》》》》》》》》》》》SUCCESS");
                            }else {
                                logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>successfulPayment修改失败》》》》》》》》》》》》》》》FAIL");
                            }
                            // 支付成功
                            resXml = "<xml>" + "<return_code><![CDATA[SUCCESS]]></return_code>"
                                    + "<return_msg><![CDATA[OK]]></return_msg>" + "</xml> ";
                            logger.info("微信支付回调数据结束" + resXml);
                            return ServiceResult.succ();
                        }else {
                            resXml = "<xml>" + "<return_code><![CDATA[FAIL]]></return_code>"
                                    + "<return_msg><![CDATA[报文为空]]></return_msg>" + "</xml> ";
                            logger.info("微信支付回调数据结束" + resXml);
                            return ServiceResult.fail();
                        }
                    }
                }
            }
            // 支付成功
            resXml = "<xml>" + "<return_code><![CDATA[SUCCESS]]></return_code>"
                    + "<return_msg><![CDATA[OK]]></return_msg>" + "</xml> ";
            logger.info("微信支付回调数据结束" + resXml);
            //生成收款记录。
        } else {
            resXml = "<xml>" + "<return_code><![CDATA[FAIL]]></return_code>"
                    + "<return_msg><![CDATA[报文为空]]></return_msg>" + "</xml> ";
            logger.info("微信支付回调数据结束" + resXml);
            return ServiceResult.fail();
        }
        return null;
    }



    private static Map parseXmlToList2(String xml) {
        Map retMap = new HashMap();
        try {
            StringReader read = new StringReader(xml);
            // 创建新的输入源SAX 解析器将使用 InputSource 对象来确定如何读取 XML 输入
            InputSource source = new InputSource(read);
            // 创建一个新的SAXBuilder
            SAXBuilder sb = new SAXBuilder();
            // 通过输入源构造一个Document
            org.jdom.Document doc = sb.build(source);
            Element root = (Element) doc.getRootElement();// 指向根节点
            List<Element> es = root.getChildren();
            if (es != null && es.size() != 0) {
                for (Element element : es) {
                    retMap.put(element.getName(), element.getValue());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return retMap;
    }

    @GetMapping(value = "/test", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public boolean authGet(@RequestParam(name = "a", required = false) String orderNo,
                          @RequestParam(name = "b", required = false) String transactionId) {
        boolean flag = doregInfoService.postHisRegInfo(orderNo,transactionId);
        return flag;
    }
}
