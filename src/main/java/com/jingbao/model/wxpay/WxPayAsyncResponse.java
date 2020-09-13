package com.jingbao.model.wxpay;

import org.simpleframework.xml.Element;
import org.simpleframework.xml.Root;

import lombok.Data;

/**
 * 微信支付异步返回参数
 * 
 * @author dell
 *
 */
@Data
@Root(name = "xml", strict = false)
public class WxPayAsyncResponse {

	@Element(name = "return_code")
	private String returnCode;	//返回状态码

	@Element(name = "return_msg", required = false)
	private String returnMsg;	//返回信息

	/** 以下字段在return_code为SUCCESS的时候有返回. */
	@Element(name = "appid", required = false)
	private String appid;		//公众账号ID
	
	@Element(name = "mch_id", required = false)
	private String mchId;		//商户号

	@Element(name = "device_info", required = false)
	private String deviceInfo;		//设备号

	@Element(name = "nonce_str", required = false)
	private String nonceStr;		//随机字符串

	@Element(name = "sign", required = false)
	private String sign;			//签名

	@Element(name = "result_code", required = false)
	private String resultCode;		//业务结果

	@Element(name = "err_code", required = false)
	private String errCode;			//错误代码

	@Element(name = "err_code_des", required = false)
	private String errCodeDes;		//错误代码描述

	@Element(name = "openid", required = false)
	private String openid;		//用户标识

	@Element(name = "is_subscribe", required = false)
	private String isSubscribe;		//是否关注公众账号

	@Element(name = "trade_type", required = false)
	private String tradeType;	//交易类型

	@Element(name = "bank_type", required = false)
	private String bankType;	//付款银行

	@Element(name = "total_fee", required = false)
	private Integer totalFee;	//标价金额

	@Element(name = "fee_type", required = false)
	private String feeType;		//标价币种

	@Element(name = "cash_fee", required = false)
	private String cashFee;		//现金支付金额

	@Element(name = "cash_fee_type", required = false)
	private String cashFeeType;		//现金支付币种

	@Element(name = "coupon_fee", required = false)
	private String couponFee;		//代金券金额

	@Element(name = "coupon_count", required = false)
	private String couponCount;		//代金券使用数量

	@Element(name = "transaction_id", required = false)
	private String transactionId;	//微信支付订单号

	@Element(name = "out_trade_no", required = false)
	private String outTradeNo;		//商户订单号

	@Element(name = "attach", required = false)
	private String attach;		//附加数据

	@Element(name = "time_end", required = false)
	private String timeEnd;		//支付完成时间
}
