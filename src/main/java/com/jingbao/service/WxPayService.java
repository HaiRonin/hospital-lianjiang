package com.jingbao.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jingbao.enums.SignType;
import com.jingbao.model.PayRequest;
import com.jingbao.model.PayResponse;
import com.jingbao.model.RefundRequest;
import com.jingbao.model.RefundResponse;

/**
 * 支付相关
 * @author dell
 *
 */
public interface WxPayService {

	/**
	 * 发起支付
	 * @param request
	 * @return
	 */
	PayResponse pay(PayRequest request);
	
	 /**
     * 验证支付结果. 包括同步和异步.
     *
     * @param toBeVerifiedParamMap 待验证的支付结果参数.
     * @param signType             签名方式.
     * @param sign                 签名.
     * @return 验证结果.
     */
    boolean verify(Map<String, String> toBeVerifiedParamMap, SignType signType, String sign);
	
    /**
     * 同步回调
     * @param request
     * @return
     */
    PayResponse syncNotify(HttpServletRequest request);

    /**
     * 异步回调
     * @param notifyData
     * @return
     */
    PayResponse asyncNotify(String notifyData);

    /**
     * 退款
     * @param request
     * @return
     */
    RefundResponse refund(RefundRequest request);
}
