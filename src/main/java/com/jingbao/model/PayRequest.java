package com.jingbao.model;

import lombok.Data;

import com.jingbao.enums.PayTypeEnum;

/**
 * 支付时请求参数
 * 
 * @author dell
 *
 */
@Data
public class PayRequest {

	/** 支付方式 */
	private PayTypeEnum payTypeEnum;

	/** 订单ID */
	private String orderId;

	/** 订单金额 */
	private Double orderAmount;

	/** 订单名称 */
	private String orderName;

	/** 微信openid */
	private String openid;
	
}
