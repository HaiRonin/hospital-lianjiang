package com.jingbao.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.google.gson.Gson;
import com.jingbao.entity.basic.DoRegIn;
import com.jingbao.entity.model.DoregInfo;
import com.jingbao.dao.DoregInfoMapper;
import com.jingbao.prjo.HisResponse;
import com.jingbao.service.DoregInfoService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.jingbao.service.HisService;
import com.jingbao.util.DateUtil;
import com.jingbao.util.MapUtil;
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
 * @since 2019-02-18
 */
@Service
public class DoregInfoServiceImpl extends ServiceImpl<DoregInfoMapper, DoregInfo> implements DoregInfoService {
    private static Logger logger = LoggerFactory.getLogger(DoregInfoServiceImpl.class);
    @Autowired
    private HisService hisService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean postHisRegInfo(String orderNo, String transactionId) {
        EntityWrapper<DoregInfo> wntityWrapperDoregInfo = new EntityWrapper<>();
        DoregInfo doregInfo = new DoregInfo();
        doregInfo.setOutTradeNo(orderNo);
        wntityWrapperDoregInfo.setEntity(doregInfo);
        DoregInfo doregInfoNew = this.selectOne(wntityWrapperDoregInfo);
        if(doregInfoNew==null){
            return false;
        }

        if(doregInfoNew.getSuccessfulPayment().equals("1")){
            return true;
        }
        if(doregInfoNew.getSuccessfulPayment().equals("2")){
            return true;
        }
        DoregInfo doregInfoList=new DoregInfo();
        doregInfoList.setTransactionId(transactionId);
        doregInfoList.setId(doregInfoNew.getId());

        DoRegIn doRegInInfo = new DoRegIn();
        doRegInInfo.setCardNo(doregInfoNew.getCardNo());
        doRegInInfo.setDepartmentorganId(doregInfoNew.getDepartmentorganId());
        doRegInInfo.setOrgandoctorId(doregInfoNew.getOrgandoctorId());
        doRegInInfo.setPatientNo(doregInfoNew.getPatientNo());
        doRegInInfo.setPayAmount(String.valueOf(doregInfoNew.getPayAmount()));
        doRegInInfo.setPayNo(transactionId);
        doRegInInfo.setPayType(Integer.parseInt(doregInfoNew.getPayType()));
        doRegInInfo.setSocialsecurityNO("");
        doRegInInfo.setSourceDate(DateUtil.dateTo0String(doregInfoNew.getSourceDate(),DateUtil.FORMAT_SHORTDATETIME));
        doRegInInfo.setSourceTimeType(doregInfoNew.getSourceTimeType());
        doRegInInfo.setTimestypeNo(Integer.parseInt("0"));

        Map<String, Object> dataParamInfo = new HashMap<String, Object>();
        dataParamInfo.put("synUserName","");
        dataParamInfo.put("synKey","");
        try {
            dataParamInfo.put("doRegIn", MapUtil.objectToMap(doRegInInfo));
        } catch (Exception e) {
            return false;
        }
        Gson gson = new Gson();
        HisResponse hisResponse= hisService.requestHisService(gson.toJson(dataParamInfo).toString(),"/doreg");
        if(null != hisResponse){
            logger.info(">>>>>>>>>>>>>>>调用His【预约挂号】接口>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+hisResponse.getResultMsg());
            if(hisResponse.getResultCode().equals("00")){
                doregInfoList.setSuccessfulPayment("1");
                this.updateById(doregInfoList);
                return true;
            }
        }
        doregInfoList.setResultMsg(hisResponse.getResultMsg());
        this.updateById(doregInfoList);
        logger.info(">>>>>>>>>>>>>>>调用His【预约挂号】接口失败>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        return false;
    }

    //修改支付状态
    @Override
    public boolean updateRegInfoSuccessfulPayment(String orderNo) {
        //查询出支付状态并修改
        EntityWrapper<DoregInfo> wntityWrapperDoregInfo = new EntityWrapper<>();
        DoregInfo doregInfo = new DoregInfo();
        doregInfo.setOutTradeNo(orderNo);
        wntityWrapperDoregInfo.setEntity(doregInfo);
        DoregInfo doregInfoNew = this.selectOne(wntityWrapperDoregInfo);
        DoregInfo doregInfoList=new DoregInfo();
        doregInfoList.setId(doregInfoNew.getId());
        //更改本地支付字段为已退款
        doregInfoList.setSuccessfulPayment("2");
        boolean info =this.updateById(doregInfoList);
        return info;
    }
}
