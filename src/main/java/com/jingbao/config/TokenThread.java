//package com.jingbao.config;
//
//import java.io.IOException;
//
//import com.jingbao.util.RedisUtils;
//import net.sf.json.JSONObject;
//
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//
//import com.jingbao.prjo.AccessToken;
//import com.jingbao.prjo.Ticket;
//import com.jingbao.util.WeiXinUtil;
//import redis.clients.jedis.Jedis;
//
//
///**
// * @Description: 定时获取微信access_token的线程
// * @ClassName: TokenThread
// * @author songqi
// * @date 2017年7月10日
// */
//public class TokenThread implements Runnable  {
//
//	private Logger logger = LoggerFactory.getLogger(TokenThread.class);
//
//	public static String appid = "wxf5b2e5f205119e25";
//
//	public static String appsecret = "11b9109f356573077836d29b044730fc";
//
//
//	public static AccessToken accessToken = null;
//
//	public static Ticket ticket = null;
//
//	@Override
//	public void run() {
//		try {
//
//			while (true) {
//				accessToken = WeiXinUtil.getAccessToken(Config.Wx.APP_ID,Config.Wx.APPSECRET);
//				if (null != accessToken) {
//					ticket = WeiXinUtil.getTicket(accessToken.getToken());
//					if (ticket != null) {
//						logger.info("\njsapi ticket创建成功");
//					} else {
//						logger.info("\njsapi ticket创建失败");
//					}
//					Jedis jedis = RedisUtils.getJedis();
//                    jedis.set("token",accessToken.getToken());
//					logger.info("获取access_token成功，有效时长{}秒 token:{}", accessToken.getExpiresIn(), accessToken.getToken());
//					// 休眠7000秒
//					Thread.sleep((accessToken.getExpiresIn() - 200) * 1000);
//				} else {
//					// 如果access_token为null，60秒后再获取
//					Thread.sleep(60 * 1000);
//				}
//			}
//		} catch (InterruptedException | IOException e) {
//			 try {
//                 Thread.sleep(60 * 1000);
//             } catch (InterruptedException e1) {
//                 logger.error("{}", e1);
//             }
//             logger.error("{}", e);
//		}
//	}
//
//}
