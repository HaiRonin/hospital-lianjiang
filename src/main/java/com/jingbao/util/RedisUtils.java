package com.jingbao.util;

/**
 * @author likanghong
 */

import com.alibaba.fastjson.JSONObject;
import org.apache.log4j.Logger;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

/**
 * @Description:redis工具类
 * @ClassName:
 * @date 2016年10月31日 上午11:25:06
 */
@SuppressWarnings("unused")
public class RedisUtils {
//    private static final String IP = "47.92.232.233"; // ip
//    private static final int PORT = 6379;         // 端口
//    private static final String AUTH = "xuliyouka008";

    private static final String IP = "127.0.0.1"; // ip
    private static final int PORT = 6379;         // 端口
    private static final String AUTH = null;          // 密码(原始默认是没有密码)
    private static int MAX_ACTIVE = 1024;       // 最大连接数
    private static int MAX_IDLE = 200;          // 设置最大空闲数
    private static int MAX_WAIT = 10000;        // 最大连接时间
    private static int TIMEOUT = 10000;         // 超时时间
    private static boolean BORROW = true;         // 在borrow一个事例时是否提前进行validate操作
    private static JedisPool pool = null;
    private static Logger logger = Logger.getLogger(RedisUtils.class);

    /**
     * 初始化线程池maxIdle
     */
    static {
        JedisPoolConfig config = new JedisPoolConfig();
        config.setMaxTotal(MAX_ACTIVE);
        config.setMaxIdle(MAX_IDLE);
        config.setMaxWaitMillis(MAX_WAIT);
        config.setTestOnBorrow(BORROW);
        pool = new JedisPool(config, IP, PORT, TIMEOUT,AUTH);
    }



    public static void main(String[] args) {
        Jedis jedis = RedisUtils.getJedis();
        jedis.set("a", "a0000000000000");
        System.out.println(jedis.get("a"));
    }


    /**
     * 获取连接
     */
    public static synchronized Jedis getJedis() {
        Jedis jedis = null;
        try {
            if (pool != null) {
                jedis =pool.getResource();
            }
        } catch (Exception e) {
            if (pool != null) {
                getColse(pool.getResource());
            }
            logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>67>>>>>"+e.getMessage());
            e.getMessage();
            e.printStackTrace();
            logger.info("连接池连接异常");
        } finally {
            logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>74>>>>>"+jedis);
            getColse(pool.getResource());
        }
        return jedis;
    }

    /**
     * @param @param  key
     * @param @param  seconds
     * @param @return
     * @return boolean 返回类型
     * @Description:设置失效时间
     */
    public static void disableTime(String key, int seconds) {
        Jedis jedis = null;
        try {
            jedis = getJedis();
            jedis.expire(key, seconds);

        } catch (Exception e) {
            logger.debug("设置失效失败.");
        } finally {
            getColse(jedis);
        }
    }


    /**
     * @param @param  key
     * @param @param  obj
     * @param @return
     * @return boolean 返回类型
     * @Description:插入对象
     */
    public static boolean addObject(String key, Object obj) {

        Jedis jedis = null;
        String value = JSONObject.toJSONString(obj);
        try {
            jedis = getJedis();
            String code = jedis.set(key, value);
            if (code.equals("ok")) {
                return true;
            }
        } catch (Exception e) {
            logger.debug("插入数据有异常.");
            return false;
        } finally {
            getColse(jedis);
        }
        return false;
    }


    /**
     * @param @param key
     * @param @param value
     * @return void 返回类型
     * @Description:存储key~value
     */

    public static boolean addValue(String key, String value) {
        Jedis jedis = null;
        try {
            jedis = getJedis();
            String code = jedis.set(key, value);
            if (code.equals("ok")) {
                return true;
            }
        } catch (Exception e) {
            logger.debug("插入数据有异常.");
            return false;
        } finally {
            getColse(jedis);
        }
        return false;
    }

    /**
     * @param @param  key
     * @param @return
     * @return boolean 返回类型
     * @Description:删除key
     */
    public static boolean delKey(String key) {
        Jedis jedis = null;
        try {
            jedis = getJedis();
            Long code = jedis.del(key);
            if (code > 1) {
                return true;
            }
        } catch (Exception e) {
            logger.debug("删除key异常.");
            return false;
        } finally {
            getColse(jedis);
        }
        return false;
    }

    /**
     * @param @param jedis
     * @return void 返回类型
     * @Description: 关闭连接
     */

    public static void getColse(Jedis jedis) {
        if (jedis != null) {
            jedis.close();
        }
    }

}