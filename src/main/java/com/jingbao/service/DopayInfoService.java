package com.jingbao.service;

import com.jingbao.entity.model.DopayInfo;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author wu123
 * @since 2019-01-26
 */
public interface DopayInfoService extends IService<DopayInfo> {

    boolean postHisDopayInfo(String orderNo, String transactionId);

}
