package com.jingbao.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

import com.alibaba.fastjson.JSON;
import com.jingbao.config.WechatMpProperties;
import com.jingbao.util.HttpXmlUtils;
import com.jingbao.util.StringUtil;
import com.jingbao.util.WxSignUtils;

public class PayServiceImpl {
	
	@Autowired
	private static  WechatMpProperties properties;
	/**
	 * 加载配置文件
	 */
	public static String wx_native_app_id =properties.getMpAppId(); // 微信应用id
	public static String wx_native_mch_id =properties.getMchId(); // 微信商户id
	public static String wx_native_key =properties.getMchKey(); // 微信秘钥
	public static String wxPayUrl = properties.getWxPayUrl(); // 预付单地址
	public static String wxQueryUrl = properties.getWxQueryUrl(); // 查询地址



	/**
	 * 微信原生支付
	 * @param pay_title  支付标题
	 * @param out_trade_no  订单号
	 * @param total_fee  支付金额
	 * @param spbill_create_ip  生成订单的ip地址
	 * @param notify_url  回调地址  例：  https://tz.com/pay/notify/
	 * @return  Map 请看详细信息
	 */
	public  Map<String,String> weixinpay(Map<String,String> pa) {
		Map<String,String> result=new HashMap<String, String>();		
		//随机字符
		String nonce_str = StringUtil.getRandomNum(8);

		String body = pa.get("pay_title");
		String openid = pa.get("openid");
		String total_fee = pa.get("total_fee");
		String spbill_create_ip = pa.get("spbill_create_ip").split(",")[0];// "127.0.0.1";
		String notify_url=pa.get("notify_url");		
		System.out.println("notify_url是：" + notify_url);
		//支付类型
		String trade_type = "JSAPI";

		float timestamp = System.currentTimeMillis() / 1000;
		// 参数：开始生成签名
		SortedMap<Object, Object> parameters = new TreeMap<Object, Object>();
		parameters.put("appid", wx_native_app_id);
		parameters.put("mch_id", wx_native_mch_id);
		parameters.put("nonce_str", nonce_str);
		parameters.put("body", body);
		parameters.put("out_trade_no", pa.get("out_trade_no"));
		parameters.put("total_fee", total_fee);
		parameters.put("openid", openid);
		parameters.put("notify_url", notify_url);
		parameters.put("trade_type", trade_type);
		parameters.put("spbill_create_ip", spbill_create_ip);
		String sign = WxSignUtils.createSign("UTF-8", parameters,wx_native_key);
		System.out.println("签名是：" + sign);
		parameters.put("sign", sign);		
		// 构造xml参数
		String xmlInfo = HttpXmlUtils.xmlInfo(parameters);
		String payNo = HttpXmlUtils.httpsRequest(wxPayUrl, xmlInfo);
		System.out.println("请求结果" + payNo);
		Map doXMLParse = null;
		String signStr = "";
		try {
			doXMLParse = HttpXmlUtils.doXMLParse(payNo);
			if("SUCCESS".equals(doXMLParse.get("return_code"))){
				SortedMap<Object, Object> againParameters = new TreeMap<Object, Object>();
				againParameters.put("appid", doXMLParse.get("appid"));
				againParameters.put("partnerid", wx_native_mch_id);
				againParameters.put("prepayid", doXMLParse.get("prepay_id"));
				againParameters.put("noncestr", StringUtil.getRandomNum(8));
				againParameters.put("timestamp", System.currentTimeMillis() / 1000);
				againParameters.put("package", "prepayid="+doXMLParse.get("prepay_id"));
				String sign1 = WxSignUtils.createSign("UTF-8", againParameters,wx_native_key);
				againParameters.put("sign", sign1);				
				signStr = JSON.toJSONString(againParameters);
				System.out.println("再次签名结果" + signStr);
				result.put("code", "SUCCESS");
				result.put("msg", "签名成功");
				result.put("data", signStr);
				result.put("out_trade_no", pa.get("out_trade_no"));
			}else{
				result.put("code", "ERROR");
				result.put("msg", "签名失败");
			}
			
		} catch (Exception e) {

			e.printStackTrace();
		}
		result.put("service", "微信支付");
		System.out.println("=========================================================");		
		return result;

	}
	
	
	
	/**
	 * 微信订单查询
	 * @param out_trade_no  商户订单号
	 * @return
	 * @throws Exception
	 */
	public  Map<String,String> wxNativeQuery(String  out_trade_no) throws Exception{
		String code="";
		String msg="";
		String nonce_str=StringUtil.getRandomNum(8);		
		// 参数：开始生成签名
		SortedMap<Object, Object> parameters = new TreeMap<Object, Object>();
		parameters.put("appid", wx_native_app_id);
		parameters.put("mch_id", wx_native_mch_id);
		parameters.put("nonce_str", nonce_str);
		parameters.put("out_trade_no", out_trade_no);
		String sign = WxSignUtils.createSign("UTF-8", parameters,wx_native_key);
		System.out.println("签名是：" + sign);
		parameters.put("sign", sign);		
		
		// 构造xml参数
		String xmlInfo = HttpXmlUtils.xmlInfo(parameters);

		String payNo = HttpXmlUtils.httpsRequest(wxQueryUrl, xmlInfo);
		Map doXMLParse = HttpXmlUtils.doXMLParse(payNo);
		if("SUCCESS".equals(doXMLParse.get("return_code"))){
			if("SUCCESS".equals(doXMLParse.get("result_code"))){
				String trade_state=doXMLParse.get("trade_state")+"";
				if ("SUCCESS".equals(trade_state)) {
					code=trade_state;
					msg="支付成功";
				} else if ("REFUND".equals(trade_state)) {
					code=trade_state;
					msg="转入退款";
				} else if ("NOTPAY".equals(trade_state)) {
					code=trade_state;
					msg="未支付";
				} else if ("CLOSED".equals(trade_state)) {
					code=trade_state;
					msg="已关闭";
				} else if ("REVOKED".equals(trade_state)) {
					code=trade_state;
					msg="已撤销";
				}else if("USERPAYING".equals(trade_state)){					
					code=trade_state;
					msg="支付中";
				}else if("PAYERROR".equals(trade_state)){					
					code=trade_state;
					msg="支付失败(其他原因，如银行返回失败)";
				}
			}else{
				code="FAIL";
				msg=doXMLParse.get("err_code_des")+",确认后需重新查询";
			}
		}else{
			code="ERROE";
			msg="系统错误-查询失败";
		}
		doXMLParse.put("code", code);
		doXMLParse.put("msg", msg);
		return doXMLParse;
	}
}
