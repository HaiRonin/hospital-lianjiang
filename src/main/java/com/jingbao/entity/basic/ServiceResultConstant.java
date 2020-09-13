package com.jingbao.entity.basic;

/**
 * 微服务返回结果和状态码常量
 */
public enum ServiceResultConstant {

    //----通用系统级(-1-99)
    MICROSERVICE_NOT_FOUND(-3, "微服务通信失败"),//微服务挂掉等ping不通情况
    FALLBACK(-2, "微服务请求异常，服务降级"),
    FAILED(-1, "微服务系统错误"), //业务异常主动设置

    SUCCESS(1, "success"),

    ERROR(0, "error"),

    SIGN_ERROR(10005, "签名错误"),
    SMS_ERROR(10006, "验证码错误"),

    DB_COLUMN_TOO_LONG(5, "字段过长"),


    FEED_BACK_BE(2001, "一人一天只能提交一次!"),


    DB_CONNECTING_ERROR(6, "数据库连接异常"),

    DB_UPDATE_ERROR(7, "数据库更新异常"),


    NOT_MANAGE(1008, "不是管理员"),

    NOT_PAYPERMISSION_COMPANY(1009, "公司没有挂帐权限，请在线支付。"),
    NOT_COMPANY(1029, "没有此公司！"),
    COMPANY_INFO_REPEAT(1039, "订单信息重复！"),

    NOT_PAYPERMISSION_PERSONAL(1010, "您没有挂帐权限，请向管理员申请。"),

    NOT_PAYPERMISSION_NOT_CAR(1011, "挂帐权限不足，无法使用卡币。"),

    GPS_ACOUNT_ERROR(1020, "gps 价格设置有误，请联系管理员。"),

    YEAR_ACOUNT_ERROR(1030, "gps 年费价格设置有误，请联系管理员。"),

    MANAGE_ZERO(1011, "此公司没有管理员，请先联系客服添加管理员再申请."),

    SEARCH_COMPANY_NOT_ERR(1012, "暂未该公司任何信息!"),

    ACCOUNT_AND_PWD_NULL(1013, "账号或密码不能为空!"),
    DECLARATION_EXIST(1025, "此订单已报单过!"),


    ACCOUNT_NONE(1014, "账号不存在!"),

    PWD_ERR(1015, "密码错误!"),

    DISPATCH(1016, "此订单已经处理!"),

    NOPAY(1017, "此订单不能取消订单!"),

    NOFLEET(1018, "公司没有绑定车队，无法挂帐。!"),

    NOPAYACOUNT(1019, "车队没有设置好价格，请先设置才能挂帐。"),


    //---微服务公用错误码，(10001~10099)
    DATABASE_CONNECT_ERROR(10002, "数据库连接异常"),

    SIM_NUMBER_REPEAT(10012, "SIM重复"),
    SERIAL_NUMBER_REPEAT(10013, "序列号重复"),

    //----通用业务级(10100-10199)
    PARAM_ERROR(10100, "参数异常，请检查必填项"),

    ILLEGAL_REQUEST(10101, "非法请求！"),


    CAR_LOCATION(10102, "卡车定位");

    private int code;

    private String msg;

    ServiceResultConstant(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

}
