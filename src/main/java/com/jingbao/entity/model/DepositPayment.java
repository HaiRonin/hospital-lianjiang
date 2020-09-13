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
 * @since 2019-02-26
 */
@TableName("deposit_payment")
public class DepositPayment implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 住院号
     */
    @TableField("in_hos_no")
    private String inHosNo;
    /**
     * 床号
     */
    @TableField("bed_no")
    private String bedNo;
    /**
     * 支付类型
     */
    @TableField("pay_type")
    private String payType;
    @TableField("pay_record")
    private String payRecord;
    @TableField("pay_money")
    private String payMoney;
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
     * 订单创建时间
     */
    @TableField("creat_time")
    private Date creatTime;
    /**
     * 商户id
     */
    private String appid;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getInHosNo() {
        return inHosNo;
    }

    public void setInHosNo(String inHosNo) {
        this.inHosNo = inHosNo;
    }

    public String getBedNo() {
        return bedNo;
    }

    public void setBedNo(String bedNo) {
        this.bedNo = bedNo;
    }

    public String getPayType() {
        return payType;
    }

    public void setPayType(String payType) {
        this.payType = payType;
    }

    public String getPayRecord() {
        return payRecord;
    }

    public void setPayRecord(String payRecord) {
        this.payRecord = payRecord;
    }

    public String getPayMoney() {
        return payMoney;
    }

    public void setPayMoney(String payMoney) {
        this.payMoney = payMoney;
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

    public Date getCreatTime() {
        return creatTime;
    }

    public void setCreatTime(Date creatTime) {
        this.creatTime = creatTime;
    }

    public String getAppid() {
        return appid;
    }

    public void setAppid(String appid) {
        this.appid = appid;
    }

    @Override
    public String toString() {
        return "DepositPayment{" +
        "id=" + id +
        ", inHosNo=" + inHosNo +
        ", bedNo=" + bedNo +
        ", payType=" + payType +
        ", payRecord=" + payRecord +
        ", payMoney=" + payMoney +
        ", successfulPayment=" + successfulPayment +
        ", outTradeNo=" + outTradeNo +
        ", transactionId=" + transactionId +
        ", creatTime=" + creatTime +
        ", appid=" + appid +
        "}";
    }
}
