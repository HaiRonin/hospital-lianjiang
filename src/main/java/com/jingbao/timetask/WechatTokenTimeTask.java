package com.jingbao.timetask;

import com.jingbao.config.Config;
import com.jingbao.prjo.AccessToken;
import com.jingbao.util.JedisUtil;

import com.jingbao.util.WeiXinUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import redis.clients.jedis.Jedis;

/**
 * Created by ASUS on 2019/1/27.
 */
@Component
@Configurable
@EnableScheduling
public class WechatTokenTimeTask {

    private Logger logger = LoggerFactory.getLogger(WechatTokenTimeTask.class);

    //每100分钟执行一次，官方有说明，token没120分钟过期，提前20分钟获取
    @Scheduled(cron = "0 */100 *  * * * ")
    //@Scheduled(cron = "*/90 * * * * ?")
    public void reportCurrentByCron(){
        AccessToken accessToken = WeiXinUtil.getAccessToken();
        if (null != accessToken) {
//            Jedis jedis = RedisUtils.getJedis();
//            jedis.set("token", accessToken.getAccess_token());
            JedisUtil.getJedis().set("token",accessToken.getAccess_token());
            JedisUtil.getJedis().expire("token",60*115);
            logger.info("获取access_token成功==>accessToken="+accessToken.toString());
        }
    }
}
