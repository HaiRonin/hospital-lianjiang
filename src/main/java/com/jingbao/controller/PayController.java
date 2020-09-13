package com.jingbao.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.jingbao.config.Config;
import com.jingbao.config.WechatMpProperties;
import com.jingbao.entity.model.DoregInfo;
import com.jingbao.service.DoregInfoService;
import com.jingbao.service.IWechatService;
import com.jingbao.service.PayService;
import com.jingbao.util.*;
import com.jingbao.weixin.Utils.RandCharsUtils;
import com.jingbao.weixin.Utils.WXSignUtils;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.util.*;

import static com.jingbao.config.Config.refundURL;



/**
 * 支付
 * @author dell
 *
 */
@Controller
@RequestMapping(value = "/pay")
@Slf4j
public class PayController {

	private static final Logger logger = LoggerFactory.getLogger(PayController.class);

	@Autowired
	DoregInfoService doregInfoService;

	@Autowired
	private   WechatMpProperties properties;

	@Autowired
    IWechatService iWechatService;

	/**
	 * 原生App支付
	 *
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "nativePay/{service}")
	public Map<String, String> nativePay(HttpServletRequest request,@PathVariable("service") Integer service) {
		Map<String, String> putMap = new HashMap<String, String>();
		long dateTime = System.currentTimeMillis();
		String outTradeNo = "";
		putMap.put("pay_title", "payment");//支付标题
		putMap.put("openid","oKuwuv-GZCDfXsyWNUhUhKCijsnM");//用户openid
		putMap.put("service", service+"");  //支付渠道  1 微信
		putMap.put("spbill_create_ip", "127.0.0.1"); //终端ip  微信支付需要  控制器调用的时候填入，jar里面会自动填入微信
		putMap.put("total_fee", "1");//金额  都是以分单位，支付宝传入的时候会自动变成分单位

		//获取配置文件
//		putMap.put("wx_native_app_id",properties.getMpAppId());//微信应用id
//		putMap.put("wx_native_mch_id",properties.getMchId());//微信商户id
//		putMap.put("wx_native_key",properties.getMchKey());//微信秘钥
//		putMap.put("wxPayUrl", properties.getWxPayUrl());//预付单地址

		Map<String, String> nativePay = new HashMap<>();
		if ("1".equals(putMap.get("service"))) {
			outTradeNo = "10001" + dateTime
					+ (long) (Math.random() * 1000000000L);
			putMap.put("out_trade_no", outTradeNo);
			putMap.put("notify_url", "http://***********/**/**/**/zfb_notiyReturn");//回调地址
			nativePay = PayService.weixinpay(putMap);

		}else {
			nativePay.put("code", "ERROR");
			nativePay.put("msg", "支付通道错误");
		}

		// 签名失败直接返回
		if ("ERROE".equals(nativePay.get("code"))) {
			return nativePay;
		}
		return nativePay;
	}


	/**
	 * 微信异步回调
	 *
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "wx_notiyReturn", method = { RequestMethod.POST })
	public void wx_notiyReturn(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// 读取参数
		InputStream inputStream;
		StringBuffer sb = new StringBuffer();
		inputStream = request.getInputStream();
		String s;
		BufferedReader in = new BufferedReader(new InputStreamReader(
				inputStream, "UTF-8"));
		while ((s = in.readLine()) != null) {
			sb.append(s);
		}
		in.close();
		inputStream.close();

		// 解析xml成map
		Map m = new HashMap();
		m = HttpXmlUtils.doXMLParse(sb.toString());

		// 过滤空 设置 TreeMap
		SortedMap<Object, Object> packageParams = new TreeMap<Object, Object>();
		Iterator it = m.keySet().iterator();
		while (it.hasNext()) {
			String parameter = (String) it.next();
			String parameterValue = (String) m.get(parameter);

			String v = "";
			if (null != parameterValue) {
				v = parameterValue.trim();
			}
			packageParams.put(parameter, v);
		}

		String code = "";
		String msg = "";

		// 判断签名是否正确
		if (WxSignUtils.isWxPaySign("UTF-8", packageParams)) {
			// ------------------------------
			// 处理业务开始

			// ------------------------------
			String resXml = "";
			if ("SUCCESS".equals((String) packageParams.get("result_code"))) {
				code = "SUCCESS";
				msg = "支付成功";

				// 支付成功
				String mch_id = (String) packageParams.get("mch_id");
				String out_trade_no = (String) packageParams
						.get("out_trade_no");
				String trade_no = packageParams.get("transaction_id") + "";
				String total_fee = (String) packageParams.get("total_fee");

				// //////// 执行自己的业务逻辑////////////////

				System.out.println("支付成功。。。。");
				// 通知微信.异步确认成功.必写.不然会一直通知后台.八次之后就认为交易失败了.
				resXml = "<xml>"
						+ "<return_code><![CDATA[SUCCESS]]></return_code>"
						+ "<return_msg><![CDATA[OK]]></return_msg>" + "</xml> ";

			} else {
				System.out
						.println("支付失败,错误信息：" + packageParams.get("err_code"));

				resXml = "<xml>"
						+ "<return_code><![CDATA[FAIL]]></return_code>"
						+ "<return_msg><![CDATA[报文为空]]></return_msg>"
						+ "</xml> ";
				msg = "支付失败";
				code = "FAIL";

			}
			// ------------------------------
			// 处理业务完毕
			// ------------------------------
			BufferedOutputStream out = new BufferedOutputStream(
					response.getOutputStream());
			out.write(resXml.getBytes());
			out.flush();
			out.close();
		} else {
			System.out.println("验签错误");
		}
	}

	/**
	 * 订单查询
	 *
	 * @param out_trade_no
	 * @param trade_no
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "findNativeOrder", produces = "application/json;charset=UTF-8")
	public Map<String, Object> findNativeOrder(String out_trade_no,
			String trade_no) throws Exception {
		Map<String, Object> nativeQuery = new HashMap<>();

		//nativeQuery.put("wx",PayService.wxNativeQuery(out_trade_no));	//微信查单

		// Order order=selectByOutTradeNo(out_trade_no);
		/****************** 下面逻辑是根据订单支付通道来区分调用对应通道的查询接口 *****************/
		// if(order!=null){
		// if (StringUtil.isNull(order.getOutTradeNo()) {
		//     nativeQuery.put("code", "FAIL");
		//     nativeQuery.put("msg", "订单号不能为空");
		// } else {
			//可根据支付渠道判断调用查询渠道
		// if(1==order.getPayMode()){
		// nativeQuery= NativePayService.wxNativeQuery(out_trade_no);
		// }else if(2==order.getPayMode()){
		// nativeQuery = NativePayService.aliNativeQuery(out_trade_no);
		// }else{
		// nativeQuery.put("code", "ERROR");
		// nativeQuery.put("msg", "通道错误");
		// }
		// }
		// }else{
		// nativeQuery.put("code", "FAIL");
		// nativeQuery.put("msg", "订单不存在");
		// }
		return nativeQuery;
	}

		/**
		 * @date 2019年1月14日下午15:26:53 void
		 * @Des:退款
		 */
		@RequestMapping(value = "refundPay")
		public  Map<String, Object> refundPay(@RequestParam("transaction_id") String transactionId,@RequestParam("refund_id") String refundId) {

         return iWechatService.refund(transactionId,refundId);
		}

}
