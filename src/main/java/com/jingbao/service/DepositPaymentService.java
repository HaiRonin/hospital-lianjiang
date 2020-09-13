package com.jingbao.service;

import com.jingbao.entity.model.DepositPayment;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author wu123
 * @since 2019-02-26
 */
public interface DepositPaymentService extends IService<DepositPayment> {

    boolean postHisDepositPayment(String orderNo, String transactionId);

    boolean updateDepositPaymentSuccessfulPayment(String orderNo);
}
