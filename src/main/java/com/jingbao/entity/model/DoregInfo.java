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
 * @since 2019-02-18
 */
@TableName("doreg_info")
public class DoregInfo implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 医生编号
     */
    @TableField("organdoctor_id")
    private String organdoctorId;
    /**
     * 患者身份证号
     */
    @TableField("card_no")
    private String cardNo;
    /**
     * 患者编号
     */
    @TableField("patient_no")
    private String patientNo;
    /**
     * 社保号
     */
    private String socialsecurityNO;
    /**
     * 取号日期（号源日期）
     */
    @TableField("source_date")
    private Date sourceDate;
    /**
     * 时间段标识(0表示无时间段)
     */
    @TableField("timestype_no")
    private Integer timestypeNo;
    /**
     * 1,上午，2，下午 3，晚上
     */
    @TableField("source_time_type")
    private Integer sourceTimeType;
    /**
     * 支付流水号
     */
    @TableField("pay_no")
    private String payNo;
    /**
     * 已支金额
     */
    @TableField("pay_amount")
    private Double payAmount;
    /**
     * 手机ID
     */
    @TableField("app_id")
    private String appId;
    /**
     * 订单创建时间
     */
    @TableField("creat_time")
    private Date creatTime;
    /**
     * 0支付未成功，1支付成功,  2表示已退款
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
    /**
     * 科室id
     */
    @TableField("departmentorgan_id")
    private String departmentorganId;
    /**
     * 支付方式 
     */
    @TableField("pay_type")
    private String payType;
    /**
     * 返回信息
     */
    @TableField("result_msg")
    private String resultMsg;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getOrgandoctorId() {
        return organdoctorId;
    }

    public void setOrgandoctorId(String organdoctorId) {
        this.organdoctorId = organdoctorId;
    }

    public String getCardNo() {
        return cardNo;
    }

    public void setCardNo(String cardNo) {
        this.cardNo = cardNo;
    }

    public String getPatientNo() {
        return patientNo;
    }

    public void setPatientNo(String patientNo) {
        this.patientNo = patientNo;
    }

    public String getSocialsecurityNO() {
        return socialsecurityNO;
    }

    public void setSocialsecurityNO(String socialsecurityNO) {
        this.socialsecurityNO = socialsecurityNO;
    }

    public Date getSourceDate() {
        return sourceDate;
    }

    public void setSourceDate(Date sourceDate) {
        this.sourceDate = sourceDate;
    }

    public Integer getTimestypeNo() {
        return timestypeNo;
    }

    public void setTimestypeNo(Integer timestypeNo) {
        this.timestypeNo = timestypeNo;
    }

    public Integer getSourceTimeType() {
        return sourceTimeType;
    }

    public void setSourceTimeType(Integer sourceTimeType) {
        this.sourceTimeType = sourceTimeType;
    }

    public String getPayNo() {
        return payNo;
    }

    public void setPayNo(String payNo) {
        this.payNo = payNo;
    }

    public Double getPayAmount() {
        return payAmount;
    }

    public void setPayAmount(Double payAmount) {
        this.payAmount = payAmount;
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

    public String getDepartmentorganId() {
        return departmentorganId;
    }

    public void setDepartmentorganId(String departmentorganId) {
        this.departmentorganId = departmentorganId;
    }

    public String getPayType() {
        return payType;
    }

    public void setPayType(String payType) {
        this.payType = payType;
    }

    public String getResultMsg() {
        return resultMsg;
    }

    public void setResultMsg(String resultMsg) {
        this.resultMsg = resultMsg;
    }

    @Override
    public String toString() {
        return "DoregInfo{" +
        "id=" + id +
        ", organdoctorId=" + organdoctorId +
        ", cardNo=" + cardNo +
        ", patientNo=" + patientNo +
        ", socialsecurityNO=" + socialsecurityNO +
        ", sourceDate=" + sourceDate +
        ", timestypeNo=" + timestypeNo +
        ", sourceTimeType=" + sourceTimeType +
        ", payNo=" + payNo +
        ", payAmount=" + payAmount +
        ", appId=" + appId +
        ", creatTime=" + creatTime +
        ", successfulPayment=" + successfulPayment +
        ", outTradeNo=" + outTradeNo +
        ", transactionId=" + transactionId +
        ", departmentorganId=" + departmentorganId +
        ", payType=" + payType +
        ", resultMsg=" + resultMsg +
        "}";
    }
}
