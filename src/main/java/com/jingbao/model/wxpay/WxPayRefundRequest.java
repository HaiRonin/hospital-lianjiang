package com.jingbao.model.wxpay;

import com.thoughtworks.xstream.annotations.XStreamAlias;

import lombok.Data;

/**
 * 退款请求参数
 * https://pay.weixin.qq.com/wiki/doc/api/jsapi.php?chapter=9_4
 * @author dell
 *
 */
@XStreamAlias("xml")
@Data
public class WxPayRefundRequest {

	private String appid;	//公众账号ID

	@XStreamAlias("mch_id")
	private String mchId;	//商户号

	@XStreamAlias("nonce_str")	
	private String nonceStr;	//随机字符串

	private String sign;	//签名

	@XStreamAlias("sign_type")
	private String signType;	//签名类型

	@XStreamAlias("transaction_id")
	private String transactionId;	//微信订单号

	@XStreamAlias("out_trade_no")
	private String outTradeNo;	//商户订单号

	@XStreamAlias("out_refund_no")
	private String outRefundNo;	//商户退款单号

	@XStreamAlias("total_fee")
	private Integer totalFee;	//订单金额

	@XStreamAlias("refund_fee")
	private Integer refundFee;	//退款金额

	@XStreamAlias("refund_fee_type")
	private String refundFeeType;	//退款货币种类

	@XStreamAlias("refund_desc")
	private String refundDesc;	//退款原因

	@XStreamAlias("refund_account")
	private String refundAccount;	//退款资金来源
}	
