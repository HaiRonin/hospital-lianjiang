package com.jingbao.enums;

/**
 * 支付结果枚举
 * @author dell
 *
 */
public enum PayResultEnum {
	UNKNOW_ERROR(-1, "未知异常"),
	SUCCESS(0, "成功"),
	PARAM_ERROR(1, "参数错误"),
	CONFIG_ERROR(2, "配置错误, 请检查是否漏了配置项"),
	SYNC_SIGN_VERIFY_FAIL(12, "同步返回签名失败"),
	ASYNC_SIGN_VERIFY_FAIL(13, "异步返回签名失败"),
	PAY_TYPE_ERROR(14, "错误的支付方式"),
	;
	
	private Integer code;
	
	private String msg;

	private PayResultEnum(Integer code, String msg) {
		this.code = code;
		this.msg = msg;
	}

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	
}
