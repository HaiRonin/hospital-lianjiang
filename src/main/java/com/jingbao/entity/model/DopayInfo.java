package com.jingbao.entity.model;

import com.baomidou.mybatisplus.enums.IdType;
import java.util.Date;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author wu123
 * @since 2019-01-26
 */
@TableName("dopay_info")
public class DopayInfo implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 用户名
     */
    @TableField("syn_user_name")
    private String synUserName;
    /**
     * 效验码
     */
    @TableField("syn_key")
    private String synKey;
    /**
     * 缴费编号
     */
    @TableField("hi_fee_nos")
    private String hiFeeNos;
    /**
     * 支付交易流水
     */
    @TableField("pay_record")
    private String payRecord;
    /**
     * 实际支付金额
     */
    @TableField("pay_money")
    private Double payMoney;
    /**
     * 社保卡号
     */
    private String socialsecurityNO;
    /**
     * 统筹结算流水号
     */
    @TableField("over_record")
    private String overRecord;
    /**
     * 统筹金额
     */
    @TableField("over_money")
    private String overMoney;
    /**
     * 医保返回信息
     */
    @TableField("medicare_return")
    private String medicareReturn;
    /**
     * 银行返回信息
     */
    @TableField("bank_return")
    private String bankReturn;
    /**
     * 终端号
     */
    @TableField("terminal_code")
    private String terminalCode;
    /**
     * 个人编号
     */
    @TableField("user_no")
    private String userNo;
    /**
     * 0,非医保 1,市医保  2,其他医保
     */
    @TableField("medicare_type")
    private Integer medicareType;
    /**
     * 手机id
     */
    @TableField("app_id")
    private String appId;
    /**
     * 创建时间
     */
    @TableField("creat_time")
    private Date creatTime;
    /**
     * 支付类型(住院还是门诊还是挂号)
     */
    @TableField("pay_type")
    private String payType;
    /**
     * 是否支付成功(0未成功,1成功)
     */
    @TableField("successful_payment")
    private String successfulPayment;
    /**
     * 商户订单号
     */
    @TableField("out_trade_no")
    private String outTradeNo;
    /**
     * 微信订单号
     */
    @TableField("transaction_id")
    private String transactionId;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSynUserName() {
        return synUserName;
    }

    public void setSynUserName(String synUserName) {
        this.synUserName = synUserName;
    }

    public String getSynKey() {
        return synKey;
    }

    public void setSynKey(String synKey) {
        this.synKey = synKey;
    }

    public String getHiFeeNos() {
        return hiFeeNos;
    }

    public void setHiFeeNos(String hiFeeNos) {
        this.hiFeeNos = hiFeeNos;
    }

    public String getPayRecord() {
        return payRecord;
    }

    public void setPayRecord(String payRecord) {
        this.payRecord = payRecord;
    }

    public Double getPayMoney() {
        return payMoney;
    }

    public void setPayMoney(Double payMoney) {
        this.payMoney = payMoney;
    }

    public String getSocialsecurityNO() {
        return socialsecurityNO;
    }

    public void setSocialsecurityNO(String socialsecurityNO) {
        this.socialsecurityNO = socialsecurityNO;
    }

    public String getOverRecord() {
        return overRecord;
    }

    public void setOverRecord(String overRecord) {
        this.overRecord = overRecord;
    }

    public String getOverMoney() {
        return overMoney;
    }

    public void setOverMoney(String overMoney) {
        this.overMoney = overMoney;
    }

    public String getMedicareReturn() {
        return medicareReturn;
    }

    public void setMedicareReturn(String medicareReturn) {
        this.medicareReturn = medicareReturn;
    }

    public String getBankReturn() {
        return bankReturn;
    }

    public void setBankReturn(String bankReturn) {
        this.bankReturn = bankReturn;
    }

    public String getTerminalCode() {
        return terminalCode;
    }

    public void setTerminalCode(String terminalCode) {
        this.terminalCode = terminalCode;
    }

    public String getUserNo() {
        return userNo;
    }

    public void setUserNo(String userNo) {
        this.userNo = userNo;
    }

    public Integer getMedicareType() {
        return medicareType;
    }

    public void setMedicareType(Integer medicareType) {
        this.medicareType = medicareType;
    }

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    public Date getCreatTime() {
        return creatTime;
    }

    public void setCreatTime(Date creatTime) {
        this.creatTime = creatTime;
    }

    public String getPayType() {
        return payType;
    }

    public void setPayType(String payType) {
        this.payType = payType;
    }

    public String getSuccessfulPayment() {
        return successfulPayment;
    }

    public void setSuccessfulPayment(String successfulPayment) {
        this.successfulPayment = successfulPayment;
    }

    public String getOutTradeNo() {
        return outTradeNo;
    }

    public void setOutTradeNo(String outTradeNo) {
        this.outTradeNo = outTradeNo;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    @Override
    public String toString() {
        return "DopayInfo{" +
        "id=" + id +
        ", synUserName=" + synUserName +
        ", synKey=" + synKey +
        ", hiFeeNos=" + hiFeeNos +
        ", payRecord=" + payRecord +
        ", payMoney=" + payMoney +
        ", socialsecurityNO=" + socialsecurityNO +
        ", overRecord=" + overRecord +
        ", overMoney=" + overMoney +
        ", medicareReturn=" + medicareReturn +
        ", bankReturn=" + bankReturn +
        ", terminalCode=" + terminalCode +
        ", userNo=" + userNo +
        ", medicareType=" + medicareType +
        ", appId=" + appId +
        ", creatTime=" + creatTime +
        ", payType=" + payType +
        ", successfulPayment=" + successfulPayment +
        ", outTradeNo=" + outTradeNo +
        ", transactionId=" + transactionId +
        "}";
    }
}
