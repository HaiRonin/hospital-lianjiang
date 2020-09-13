package com.jingbao.controller;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.jingbao.config.Config;
import com.jingbao.entity.model.DepositPayment;
import com.jingbao.entity.model.DopayInfo;
import com.jingbao.entity.model.DoregInfo;
import com.jingbao.service.DepositPaymentService;
import com.jingbao.service.DopayInfoService;
import com.jingbao.service.DoregInfoService;
import com.jingbao.util.DateUtil;
import com.jingbao.util.StringUtil;
import com.jingbao.util.WeiXinUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/DBList")
public class DBListController {

    @Autowired
    private DopayInfoService dopayInfoService;

    @Autowired
    private DoregInfoService doregInfoService;

    @Autowired
    private DepositPaymentService depositPaymentService;

    @RequestMapping("/index")
    @ResponseBody
    public String index() {
        EntityWrapper<DopayInfo> wntityWrapper = new EntityWrapper<DopayInfo>();
        wntityWrapper.where("out_trade_no={0}","123123");
        System.out.println(wntityWrapper.getSqlSegment());
        DopayInfo dopayInfoNew = (DopayInfo)dopayInfoService.selectOne(wntityWrapper);
        return dopayInfoNew.toString();
    }

    @RequestMapping("/test2")
    @ResponseBody
    public String test2() {

        DoregInfo dopayInfo = doregInfoService.selectById(1);
        return dopayInfo.toString();
    }

    /**
     * 2019.1.15
     * 新增支付挂号的记录
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/newPayment")
    public Map<String,String> newPayment(@RequestParam("payMoney") double payMoney,
                                         @RequestParam("synUserName") String synUserName, @RequestParam("synKey") String synKey,
                                         @RequestParam("medicareType") String medicareType, @RequestParam("hiFeeNos") String hiFeeNos)throws Exception {
        Map<String,String> result=new HashMap<String, String>();
        //创建接受的对象
        DopayInfo getDopayInfo = new DopayInfo();
        getDopayInfo.setAppId(Config.Wx.APP_ID);
        getDopayInfo.setCreatTime(new Date());//创建订单时间
        getDopayInfo.setHiFeeNos(hiFeeNos);
        if(StringUtil.isNotEmpty(medicareType)){
            getDopayInfo.setMedicareType(Integer.parseInt(medicareType));
        }
        getDopayInfo.setOverMoney("");
        getDopayInfo.setOverRecord("");
        getDopayInfo.setPayType("5");
        getDopayInfo.setSocialsecurityNO("");
        getDopayInfo.setSynKey(synKey);
        getDopayInfo.setSynUserName(synUserName);
        getDopayInfo.setSuccessfulPayment("0");
        getDopayInfo.setPayMoney(payMoney);
        String orderNo = WeiXinUtil.getOrderNo();//随机字符串
        getDopayInfo.setOutTradeNo("DO"+orderNo);
        boolean  info = dopayInfoService.insert(getDopayInfo);
        if (info){
            result.put("orderNo",getDopayInfo.getOutTradeNo());
            result.put("code", "SUCCESS");
            return result;
        }
        result.put("code", "ERROR");
        return result;
    }

    /**
     * 2019.1.15
     * 新增支付门诊的记录
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/outpatientPayment")
    public Map<String,String> outpatientPayment(@RequestParam("organdoctorId") String organdoctorId, @RequestParam("cardNo") String cardNo,
                                                @RequestParam("patientNo") String patientNo, @RequestParam("socialsecurityNO") String socialsecurityNo,
                                                @RequestParam("sourceDate") String sourceDate, @RequestParam("timestypeNo") String timestypeNo,
                                                @RequestParam("sourceTimeType") String sourceTimeType, @RequestParam("payAmount") double payAmount,
                                                @RequestParam("departmentorganId")String departmentorganId)throws Exception {
        Map<String,String> result=new HashMap<String, String>();
        DoregInfo doregInfo=new DoregInfo();
        doregInfo.setAppId(Config.Wx.APP_ID);
        doregInfo.setCardNo(cardNo);
        doregInfo.setCreatTime(new Date());
        doregInfo.setOrgandoctorId(organdoctorId);
        doregInfo.setPatientNo(patientNo);
        doregInfo.setPayAmount(payAmount);
        doregInfo.setSocialsecurityNO(socialsecurityNo);
        doregInfo.setDepartmentorganId(departmentorganId);
        doregInfo.setPayType("9");
        if(StringUtil.isNotEmpty(sourceDate)){
            doregInfo.setSourceDate(DateUtil.fomatDate(sourceDate));
        }
        if (StringUtil.isNotEmpty(sourceTimeType)){
            doregInfo.setSourceTimeType(Integer.parseInt(sourceTimeType));
        }
        doregInfo.setSuccessfulPayment("0");
        if(StringUtil.isNotEmpty(timestypeNo)){
            doregInfo.setTimestypeNo(Integer.parseInt(timestypeNo));
        }

        String orderNo = WeiXinUtil.getOrderNo();//随机字符串
        doregInfo.setOutTradeNo("RE"+orderNo);


        boolean info=doregInfoService.insertAllColumn(doregInfo);
        if (info){
            result.put("orderNo",doregInfo.getOutTradeNo());
            result.put("successfulPayment",doregInfo.getSuccessfulPayment());
            result.put("code", "SUCCESS");
        }else {
            result.put("code", "ERROR");
        }
        return result;

    }


    @RequestMapping(value = "/getTransactionId")
    @ResponseBody
    public Map<String,String>  getTransactionId(@RequestParam("outTradeNo") String outTradeNo) {

        Map<String,String> result=new HashMap<String, String>();

        EntityWrapper<DoregInfo> wntityWrapperDoregInfo = new EntityWrapper<>();
        DoregInfo doregInfo = new DoregInfo();
        doregInfo.setOutTradeNo(outTradeNo);
        wntityWrapperDoregInfo.setEntity(doregInfo);
        //查询微信订单号
        DoregInfo doregInfoNew = doregInfoService.selectOne(wntityWrapperDoregInfo);

        if (doregInfoNew==null){
            result.put("code", "ERROR");
        }else {
            result.put("transactionId",doregInfoNew.getTransactionId());
            result.put("successfulPayment",doregInfoNew.getSuccessfulPayment());
            result.put("resultMsg",doregInfoNew.getResultMsg());
            result.put("code", "SUCCESS");
        }
        return result;
    }


    /**
     * 2019.2.26
     * 新增押金补缴的记录
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/payment")
    public Map<String,String> payment(@RequestParam("payMoney") String payMoney, @RequestParam("bedNo") String bedNo,
                                       @RequestParam("inHosNo") String inHosNo)throws Exception {
        Map<String,String> result=new HashMap<String, String>();
        //创建接受的对象
        DepositPayment depositPayment = new DepositPayment();
        depositPayment.setAppid(Config.Wx.APP_ID);
        depositPayment.setCreatTime(new Date());//创建订单时间
        depositPayment.setInHosNo(inHosNo);
//        if(StringUtil.isNotEmpty(medicareType)){
//            depositPayment.setMedicareType(Integer.parseInt(medicareType));
//        }
        depositPayment.setBedNo(bedNo);
        depositPayment.setPayType("5");
        depositPayment.setPayMoney(payMoney);
        depositPayment.setSuccessfulPayment("0");
        String orderNo = WeiXinUtil.getOrderNo();//随机字符串
        depositPayment.setOutTradeNo("DP"+orderNo);
        boolean info = depositPaymentService.insert(depositPayment);
        if (info){
            result.put("orderNo",depositPayment.getOutTradeNo());
            result.put("code", "SUCCESS");
            return result;
        }
        result.put("code", "ERROR");
        return result;
    }
}
