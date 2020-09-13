package com.jingbao.entity.basic;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;

import java.util.List;

/**
 * 微服务 响应对象，主要是微服务有多种异常msg和code的传递，简单业务不需使用，如果要返回对象才要设置泛型,否则返回的data默认null
 * 返回 状态码/消息提示/数据 的统一模式：{"code":0, "msg":"succ", "data":{"a":"aa","b":[]} }
 */
public class ServiceResult<T> extends BaseResult<T> {

	private static Logger logger =LoggerFactory.getLogger(ServiceResult.class);

	public ServiceResult(){
		super();
	}

	public ServiceResult(T data) {
		super(data);
	}


	public ServiceResult(int code, String message, T data) {
		super(code, message, data);
	}

	public ServiceResult(int code, String message) {
		super(code, message);
	}


	/**
	 * 以指定结果常量构建 （成功或失败的结果返回）
	 * @param serviceResultConstant  结果码常量
	 */
	public ServiceResult(ServiceResultConstant serviceResultConstant) {
		code = serviceResultConstant.getCode();
		msg = serviceResultConstant.getMsg();
	}


	public ServiceResult(ServiceResultConstant serviceResultConstant, T data) {
		super(serviceResultConstant.getCode(), serviceResultConstant.getMsg(), data);
	}



	/**
	 * 构建通用的异常的返回（失败的结果返回）
	 * @param e
	 */
	private ServiceResult(Exception e){
		e.printStackTrace();
		ServiceResultConstant resultConstant = ServiceResultConstant.FAILED;
		code = resultConstant.getCode();
		msg = resultConstant.getMsg();
		if(e != null){
			// 如果时运行时异常，有很多都是微服务里业务判断的主动抛出可读信息，不显示java.lang.RuntimeException字样，直接提示信息给用户
			if (e instanceof RuntimeException){
				 if (!StringUtils.isEmpty(e.getMessage())){
					 msg = e.getMessage();
				 } else {
					 msg = "错误信息：" + e.getClass().getName();
				 }
			} else {
				msg = "系统异常：" + e.toString();
			}

		}
	}





	/**
	 * 返回默认的处理成功，返回msg=success ,code=0,data=[]的默认json
	 * @return
	 */
	public static <T>ServiceResult<T> succ() {
		return new ServiceResult<T>();
	}

	/**
	 * 返回默认的处理失败提示
	 * @return
	 */
	public static <T>ServiceResult<T> fail() {
		return new ServiceResult<T>(ServiceResultConstant.FAILED);
	}

	/**
	 *
	 * @param e
	 * @return
	 */
	public static <T> ServiceResult<T> fail(Exception e) {
		return new ServiceResult<T>(e);
	}

	public static <T> ServiceResult<T> fail(ServiceResultConstant serviceResultConstant) {
		return new ServiceResult<T>(serviceResultConstant);
	}

	public static <T> ServiceResult<T> fallback(Throwable cause) {
		if(cause != null){
			if(cause.getMessage().indexOf("Load balancer does not have available server for client") > 0){
				return ServiceResult.fail(ServiceResultConstant.MICROSERVICE_NOT_FOUND);
			}
			logger.error("微服务异常：",cause);
		}
		return ServiceResult.fail(ServiceResultConstant.FALLBACK);
	}
	
	/**
	 * 当次操作的返回是否成功
	 * @return
	 */
	public boolean success(){
		if (getCode() == ServiceResultConstant.SUCCESS.getCode()){
			return true;
		}
		return false;
	}
	

	public static <T> ServiceResult<T> parameterValidateFail(BindException e) {
		return createMsgChain(e.getBindingResult());
	}

	/**
	 * 生成异常信息链
	 * @Author : YHQ
	 * @Date: 17:55 2018-06-14
	 *
	 */
	private static <T> ServiceResult<T> createMsgChain(BindingResult bindingResult) {
		ServiceResult<T> result = new ServiceResult<>();
		result.setCode(ServiceResultConstant.FAILED.getCode());
		List<ObjectError> errors = bindingResult.getAllErrors();
		StringBuilder msg = new StringBuilder();
		for (ObjectError objectError : errors) {
			msg.append("[").append(objectError.getDefaultMessage()).append("]");
		}
		result.setMsg(msg.toString());
		return result;
	}

	public static <T> ServiceResult<T> parameterValidateFail(MethodArgumentNotValidException e) {
		return createMsgChain(e.getBindingResult());
	}

	public static <T> ServiceResult<T> fail(String msg, int code) {
		return new ServiceResult<T>(code, msg);
	}
}
