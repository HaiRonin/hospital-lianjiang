package com.jingbao.entity.basic;

/**
 * 通用接口返回对象， 返回 状态码/消息提示/数据 的统一模式：{"code":0, "msg":"succ", "data":{"a":"aa","b":[]} }
 * 如果是纯列表功能，比如支付方式列表：{"code":0, "msg":"succ", "data":{"dataList":[]} } 用dataList作为共用键的封装： public  ApiResult<CommonRespListObj<具体的vo>>
 * 
 * @param <T> 泛型可传入单个module vo对象，该对象如果做了swagger注解，则自动生成的api文档就会出现
 */

public class BaseResult<T> {

	// 默认状态码：0成功，其他为失败
	public int code;

	// 默认成功为success，其他为失败原因
	public String msg = "success";

	// 数据结果
	public T data;

	public BaseResult() {

	}

	/**
	 * 构造： 放入单个对象 (成功的返回）
	 * 
	 * @param data
	 */
	public BaseResult(T data) {
		this.data = data;
	}

	public BaseResult(int code, String msg) {
		this.code = code;
		this.msg = msg;
	}

	public BaseResult(int code, String msg, T data) {
		this.code = code;
		this.msg = msg;
		this.data = data;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}

	public static <T> BaseResult<T> fail(String msg, int code) {
		return new BaseResult<T>(code, msg);
	}
	
}
