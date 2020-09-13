//package com.jingbao.config;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//
///**
// * @Description:  初始化servlet
// * @ClassName: InitServlet
// * @author songqi
// * @date 2017年7月10日
// */
//@WebServlet(urlPatterns = {"/initservlet"})
//public class InitServlet extends HttpServlet {
//
//	private static final long serialVersionUID = 350424462922584431L;
//
//	private static Logger logger = LoggerFactory.getLogger(InitServlet.class);
//
//	@Override
//	public void init() throws ServletException {
//		TokenThread.appid = getInitParameter("appid");
//		TokenThread.appsecret = getInitParameter("appsecret");
//
//		logger.info("weixin api appid:{}", TokenThread.appid);
//        logger.info("weixin api appsecret:{}", TokenThread.appsecret);
//
//        // 未配置appid、appsecret时给出提示
//        if ("".equals(TokenThread.appid) || "".equals(TokenThread.appsecret)) {
//            logger.error("appid and appsecret configuration error, please check carefully.");
//        } else {
//            // 启动定时获取access_token的线程
//            new Thread(new TokenThread()).start();
//        }
//
//	}
//}
