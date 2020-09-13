package com.jingbao.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.google.gson.Gson;
import com.jingbao.entity.model.DepositPayment;
import com.jingbao.dao.DepositPaymentMapper;
import com.jingbao.entity.model.DopayInfo;
import com.jingbao.entity.model.DoregInfo;
import com.jingbao.prjo.HisResponse;
import com.jingbao.service.DepositPaymentService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.jingbao.service.HisService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author wu123
 * @since 2019-02-26
 */
@Service
public class DepositPaymentServiceImpl extends ServiceImpl<DepositPaymentMapper, DepositPayment> implements DepositPaymentService {
    private static Logger logger = LoggerFactory.getLogger(DoregInfoServiceImpl.class);
    @Autowired
    private HisService hisService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean postHisDepositPayment(String orderNo, String transactionId) {
        EntityWrapper<DepositPayment> wntityWrapperDoregInfo = new EntityWrapper<>();
        DepositPayment depositPayment=new DepositPayment();
        depositPayment.setOutTradeNo(orderNo);
        wntityWrapperDoregInfo.setEntity(depositPayment);
        DepositPayment  depositPaymentInfoNew = this.selectOne(wntityWrapperDoregInfo);
        if(depositPaymentInfoNew==null){
            return false;
        }
//        if(StringUtils.isNoneBlank(depositPaymentInfoNew.getTransactionId())){
//            return true;
//        }
        if(depositPaymentInfoNew.getSuccessfulPayment().equals("1")){
            return true;
        }
        if(depositPaymentInfoNew.getSuccessfulPayment().equals("2")){
            return true;
        }

        DepositPayment depositPaymentInfoList = new DepositPayment();
        depositPaymentInfoList.setTransactionId(transactionId);
        depositPaymentInfoList.setId(depositPaymentInfoNew.getId());

        Map<String, Object> dataParamInfo = new HashMap<String, Object>();
        dataParamInfo.put("synUserName","");
        dataParamInfo.put("inHosNo",depositPaymentInfoNew.getInHosNo());
        dataParamInfo.put("synKey","");
        dataParamInfo.put("payType",depositPaymentInfoNew.getPayType());
        dataParamInfo.put("payRecord",transactionId);
        dataParamInfo.put("payMoney",depositPaymentInfoNew.getPayMoney());
        dataParamInfo.put("bedNo",depositPaymentInfoNew.getBedNo());
        dataParamInfo.put("payReturn","");
        dataParamInfo.put("terminalCode","");


        Gson gson = new Gson();
        HisResponse hisResponse= hisService.requestHisService(gson.toJson(dataParamInfo).toString(),"/inpatientpayment");
        if(null != hisResponse){
            logger.info(">>>>>>>>>>>>>>>调用His【押金补缴】接口>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+hisResponse.getResultMsg());
            if(hisResponse.getResultCode().equals("00")){
                depositPaymentInfoList.setSuccessfulPayment("1");
                this.updateById(depositPaymentInfoList);
                return true;
            }
        }
        this.updateById(depositPaymentInfoList);
        logger.info(">>>>>>>>>>>>>>>调用His【押金补缴】接口失败>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        return false;
    }


    //修改支付状态
    @Override
    public boolean updateDepositPaymentSuccessfulPayment(String orderNo) {
        //查询出支付状态并修改
        EntityWrapper<DepositPayment> wntityWrapperDoregInfo = new EntityWrapper<>();
        DepositPayment DepositPaymentInfo = new DepositPayment();
        DepositPaymentInfo.setOutTradeNo(orderNo);
        wntityWrapperDoregInfo.setEntity(DepositPaymentInfo);
        DepositPayment DepositPaymentInfoNew = this.selectOne(wntityWrapperDoregInfo);
        DepositPayment DepositPaymentInfoNewInfoList=new DepositPayment();
        DepositPaymentInfoNewInfoList.setId(DepositPaymentInfoNew.getId());
        //更改本地支付字段为已退款
        DepositPaymentInfoNewInfoList.setSuccessfulPayment("2");
        boolean info =this.updateById(DepositPaymentInfoNewInfoList);
        return info;
    }

}
