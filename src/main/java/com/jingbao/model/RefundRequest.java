package com.jingbao.model;

import lombok.Data;

import com.jingbao.enums.PayTypeEnum;

/**
 * 退款时请求参数
 * 
 * @author dell
 *
 */
@Data
public class RefundRequest {

	/**
	 * 支付方式.
	 */
	private PayTypeEnum payTypeEnum;

	/**
	 * 订单号.
	 */
	private String orderId;

	/**
	 * 订单金额.
	 */
	private Double orderAmount;
}
