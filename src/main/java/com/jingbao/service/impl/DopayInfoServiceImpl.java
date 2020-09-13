package com.jingbao.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.google.gson.Gson;
import com.jingbao.entity.model.DopayInfo;
import com.jingbao.dao.DopayInfoMapper;
import com.jingbao.prjo.HisResponse;
import com.jingbao.service.DopayInfoService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.jingbao.service.HisService;
import com.jingbao.util.MapUtil;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author wu123
 * @since 2019-01-26
 */
@Service
public class DopayInfoServiceImpl extends ServiceImpl<DopayInfoMapper, DopayInfo> implements DopayInfoService {
    private static Logger logger = LoggerFactory.getLogger(DoregInfoServiceImpl.class);
    @Autowired
    private HisService hisService;

    @Override
    public boolean postHisDopayInfo(String orderNo, String transactionId) {
        EntityWrapper<DopayInfo> wntityWrapper = new EntityWrapper<>();
        DopayInfo dopayInfo = new DopayInfo();
        dopayInfo.setOutTradeNo(orderNo);
        wntityWrapper.setEntity(dopayInfo);
        DopayInfo dopayInfoNew = this.selectOne(wntityWrapper);
        if (dopayInfoNew == null) {
            return false;
        }
//        if(StringUtils.isNoneBlank(dopayInfoNew.getTransactionId())){
//            return true;
//        }
        if(dopayInfoNew.getSuccessfulPayment().equals("1")){
            return true;
        }
        if(dopayInfoNew.getSuccessfulPayment().equals("2")){
            return true;
        }
        DopayInfo dopayInfoList = new DopayInfo();
        dopayInfoList.setTransactionId(transactionId);
        dopayInfoList.setId(dopayInfoNew.getId());


        Map<String, Object> dataParamInfo = new HashMap<String, Object>();
        dataParamInfo.put("synUserName","");
        dataParamInfo.put("hiFeeNos",dopayInfoNew.getHiFeeNos());
        dataParamInfo.put("synKey","");
        dataParamInfo.put("payType",dopayInfoNew.getPayType());
        dataParamInfo.put("payRecord",transactionId);
        dataParamInfo.put("payMoney",dopayInfoNew.getPayMoney());
        dataParamInfo.put("medicareType",dopayInfoNew.getMedicareType());
        dataParamInfo.put("medicareReturn","");
        dataParamInfo.put("socialsecurityNO","");
        dataParamInfo.put("overRecord","");
        dataParamInfo.put("overMoney","");
        dataParamInfo.put("bankReturn","");
        dataParamInfo.put("terminalCode","");
        dataParamInfo.put("userNo","");


//        Map<String, Object> dataParamInfo = new HashMap<String, Object>();
//        dataParamInfo.put("synUserName","");
//        dataParamInfo.put("synKey","");
//        try {
//            dataParamInfo.put("doRegIn", MapUtil.objectToMap(doRegInInfo));
//        } catch (Exception e) {
//            return false;
//        }
        Gson gson = new Gson();
        HisResponse hisResponse= hisService.requestHisService(gson.toJson(dataParamInfo).toString(),"/dopay");
        if(null != hisResponse){
            logger.info(">>>>>>>>>>>>>>>调用His【门诊支付】接口>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+hisResponse.getResultMsg());
            if(hisResponse.getResultCode().equals("00")){
                dopayInfoList.setSuccessfulPayment("1");
                this.updateById(dopayInfoList);
                return true;
            }
        }
        this.updateById(dopayInfoList);
        logger.info(">>>>>>>>>>>>>>>调用His【门诊支付】接口失败>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        return false;
    }

    }
