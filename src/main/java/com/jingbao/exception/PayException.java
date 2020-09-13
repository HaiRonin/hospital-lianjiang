package com.jingbao.exception;

import com.jingbao.enums.PayResultEnum;

/**
 * 支付异常
 * @author dell
 *
 */
public class PayException extends RuntimeException {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2000317563366213037L;
	
	private Integer code;
	
	public PayException(PayResultEnum resultEnum) {
		super(resultEnum.getMsg());
		this.code = resultEnum.getCode();
	}
	
	public Integer getCode() {
		return code;
	}
}
