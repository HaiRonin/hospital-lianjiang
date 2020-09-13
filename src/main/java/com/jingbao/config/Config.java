package com.jingbao.config;

import org.springframework.beans.factory.annotation.Autowired;

public class Config {


    /**
     *
     */
    public static final String baseUrl = "http://weixin.ljfy.com.cn/hospital/wechat/notify_weixin";

    public static final String baseInfoUrl ="http://xhg.free.idcfengye.com/hospital/wechat/notify_weixin";

    /**
     * 公共API
     */
//    public static final String URL = "http://219.129.12.10:8099/wechat.asmx";
      public static final String URL = "http://192.168.0.212:8099/wechat.asmx";
                                     //http://192.168.0.212:8099/wechat.asmx
                                     //http://219.129.12.10:8099/wechat.asmx
    /**
     * 请求方式GET
     */
    public static final String GET_METHOD = "GET";

    /**
     * 请求方式POST
     */
    public static final String POST_METHOD = "POST";


    public static final String NOTIFY_URL = "/wechat/notify_weixin";


    public static final String unifiedorderURL = "https://api.mch.weixin.qq.com/pay/unifiedorder";

    //微信退款地址
    public static final String refundURL = "https://api.mch.weixin.qq.com/secapi/pay/refund";



    public static class Wx {

        //AppID
        public static final String APP_ID = "wx14095476fefe834e";

        //appSecret
        public static final String APPSECRET = "760a4416d6c5a1be0903072c4e650011";

        //商户号
        public static final String MCHID = "1517236221";


        public static final String KEY = "6uldwl1fytm9f733ge36i4ctwkzde7ej";

    }

}
