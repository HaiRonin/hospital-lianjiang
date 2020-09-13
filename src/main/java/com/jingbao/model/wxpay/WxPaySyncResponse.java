package com.jingbao.model.wxpay;

import lombok.Data;

import org.simpleframework.xml.Element;
import org.simpleframework.xml.Root;

/**
 * 微信支付同步返回参数
 * https://pay.weixin.qq.com/wiki/doc/api/jsapi.php?chapter=9_1
 * @author dell
 *
 */
@Data
@Root(name = "xml", strict = false)
public class WxPaySyncResponse {

	@Element(name = "return_code")
	private String returnCode;	//返回状态码

	@Element(name = "return_msg", required = false)
	private String returnMsg;	//返回信息

	/** 以下字段在return_code为SUCCESS的时候有返回. */
	@Element(name = "appid", required = false)
	private String appid;	//公众账号ID

	@Element(name = "mch_id", required = false)
	private String mchId;	//商户号

	@Element(name = "device_info", required = false)
	private String deviceInfo;	//设备号

	@Element(name = "nonce_str", required = false)
	private String nonceStr;	//随机字符串

	@Element(name = "sign", required = false)
	private String sign;	//签名

	@Element(name = "result_code", required = false)
	private String resultCode;	//业务结果

	@Element(name = "err_code", required = false)
	private String errCode;		//错误代码

	@Element(name = "err_code_des", required = false)
	private String errCodeDes;		//错误代码描述

	/** 以下字段在return_code 和result_code都为SUCCESS的时候有返回. */
	@Element(name = "trade_type", required = false)
	private String tradeType;	//交易类型

	@Element(name = "prepay_id", required = false)
	private String prepayId;	//预支付交易会话标识

	@Element(name = "code_url", required = false)
	private String codeUrl;		//二维码链接
}
