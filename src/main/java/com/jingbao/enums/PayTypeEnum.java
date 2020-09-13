package com.jingbao.enums;

import com.jingbao.exception.PayException;

/**
 * 支付方式
 * 
 * @author dell
 *
 */
public enum PayTypeEnum {

	WXPAY_H5("wxpay_h5", "微信公众账号支付"), ;

	private String code;

	private String name;

	private PayTypeEnum(String code, String name) {
		this.code = code;
		this.name = name;
	}

	public String getCode() {
		return code;
	}
	
	public String getName() {
		return name;
	}
	
	public static PayTypeEnum getByCode(String code) {
		for (PayTypeEnum payTypeEnum : PayTypeEnum.values()) {
			if (payTypeEnum.getCode().equals(code)) {
				return payTypeEnum;
			}
		}
		throw new PayException(PayResultEnum.PAY_TYPE_ERROR);
	}
}
