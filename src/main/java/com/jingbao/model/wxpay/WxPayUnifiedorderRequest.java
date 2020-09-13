package com.jingbao.model.wxpay;

import lombok.Data;

import com.thoughtworks.xstream.annotations.XStreamAlias;

/**
 * 微信支付统一下单请求参数
 * https://pay.weixin.qq.com/wiki/doc/api/jsapi.php?chapter=9_1
 * @author dell
 *
 */
@XStreamAlias("xml")
@Data
public class WxPayUnifiedorderRequest {

	private String appid;	//公众账号ID

	@XStreamAlias("mch_id")
	private String mchId;	//商户号

	@XStreamAlias("nonce_str")
	private String nonceStr;	//随机字符串,长度要求在32位以内

	private String sign;	//通过签名算法计算得出的签名值

	private String attach;	//附加数据
	
	private String body;	//商品描述

	private String detail;	//商品详情

	@XStreamAlias("notify_url")
	private String notifyUrl;	//异步接收微信支付结果通知的回调地址，通知url必须为外网可访问的url，不能携带参数

	private String openid;	//用户标识

	@XStreamAlias("out_trade_no")
	private String outTradeNo;	//商户订单号

	@XStreamAlias("spbill_create_ip")
	private String spbillCreateIp;	//终端IP

	@XStreamAlias("total_fee")
	private Integer totalFee;	//订单总金额，单位为分

	@XStreamAlias("trade_type")
	private String tradeType;	//交易类型
}
