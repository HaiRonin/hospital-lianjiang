package com.jingbao.service;

import com.jingbao.entity.model.DoregInfo;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author wu123
 * @since 2019-02-18
 */
public interface DoregInfoService extends IService<DoregInfo> {
    boolean postHisRegInfo(String orderNo,String transactionId);

    boolean updateRegInfoSuccessfulPayment(String orderNo);

}
