package com.jingbao.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.jingbao.config.Config;
import com.jingbao.entity.basic.HisCase;
import com.jingbao.prjo.SNSUserInfo;
import com.jingbao.util.HttpUtils;
import com.jingbao.util.SMSUtil;
import com.jingbao.util.WeiXinUtil;
import net.sf.json.JSONObject;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

import static com.jingbao.util.WeiXinUtil.doGetStr;

/**
 * @author dell
 */
@Controller
@RequestMapping("/user")
public class UserController {

    private static Logger logger = LoggerFactory.getLogger(WeiXinUtil.class);

    /**
     * 个人中心
     *
     * @return
     */
    @RequestMapping(value = "/mine")
    public SNSUserInfo mine(String accessToken, String openId) {
        SNSUserInfo snsUserInfo = null;
        String url = "https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID".replace("ACCESS_TOKEN", accessToken).replace("OPENID", openId);
        JSONObject jsonObject = doGetStr(url);
        if (null != jsonObject) {
            try {
                snsUserInfo = new SNSUserInfo();
                // 用户的标识
                snsUserInfo.setOpenId(jsonObject.getString("openid"));
                // 昵称
                snsUserInfo.setNickname(jsonObject.getString("nickname"));
                // 性别（1是男性，2是女性，0是未知）
                snsUserInfo.setSex(jsonObject.getInt("sex"));
                // 用户所在国家
                snsUserInfo.setCountry(jsonObject.getString("country"));
                // 用户所在省份
                snsUserInfo.setProvince(jsonObject.getString("province"));
                // 用户所在城市
                snsUserInfo.setCity(jsonObject.getString("city"));
                // 用户头像
                snsUserInfo.setHeadImgUrl(jsonObject.getString("headimgurl"));
            } catch (Exception e) {
                snsUserInfo = null;
                int errorCode = jsonObject.getInt("errcode");
                String errorMsg = jsonObject.getString("errmsg");
                logger.error("获取用户信息失败 errcode:{} errmsg:{}", errorCode, errorMsg);
            }
        }
        return snsUserInfo;
    }

    /**
     * 个人中心
     *
     * @return
     */
    @RequestMapping(value = "/me")
    public String me() {
        return "user/myCenterTab";
    }



    /**
     * 就诊人列表
     *
     * @return
     */
    @RequestMapping(value = "/memberList")
    public String memberList() {
        return "user/memberList";
    }



    /**
     * 预约记录
     *
     * @return
     */
    @RequestMapping(value = "/reservationRecord")
    public String reservationRecord() {
        return "user/reservationRecord";
    }



    /**
     * 用户注册页面
     *
     * @return
     */
    @RequestMapping(value = "/register")
    public String register() {
        return "user/register";
    }

    /**
     * 用户登录页面
     *
     * @return
     */
    @RequestMapping(value = "/login")
    public String login() {
        return "user/login";
    }


    /**
     * 信息绑定页面
     *
     * @return
     */
    @RequestMapping("/toBindInfo")
    public String toBindInfo() {
        return "user/bindinfo";
    }

    /**
     * 在线建卡页面
     *
     * @return
     */
    @RequestMapping("/toBindInfoline")
    public String toBindInfoline() {
        return "user/bindinfoline";
    }
    /**
     * 我的信息页面
     *
     * @return
     */
    @RequestMapping(value = "/myinfo")
    public String muinfo() {
        return "user/myinfo";
    }

    /**
     * 已缴费记录-门诊
     *
     * @return
     */
    @RequestMapping(value = "/payRecord")
    public String payRecord() {
        return "user/payRecord";
    }

    /**
     * 已缴费记录-门诊清单
     *
     * @return
     */
    @RequestMapping(value = "/payRecordList")
    public String payRecordList() {
        return "user/payRecordList";
    }


    /**
     * 我的挂号记录
     *
     * @return
     */
    @RequestMapping(value = "/record")
    public String registrationRecord() {
        return "registration/registrationRecord";
    }

    /**
     * 待缴费处方记录
     *
     * @return
     */
    @RequestMapping(value = "/stayPayRecord")
    public String stayPayRecord() {
        return "user/stayPayRecord";
    }

    /**
     * 待缴费处方记录详情
     *
     * @return
     */
    @RequestMapping(value = "/stayPayRecordList")
    public String stayPayRecordList() {
        return "user/stayPayRecordList";
    }

}
