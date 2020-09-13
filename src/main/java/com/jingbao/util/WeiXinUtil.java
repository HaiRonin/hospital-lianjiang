package com.jingbao.util;

import com.alibaba.fastjson.JSON;
import com.google.gson.Gson;
import com.jingbao.config.Config;
import com.jingbao.prjo.*;
import me.chanjar.weixin.common.api.WxConsts.MenuButtonType;
import me.chanjar.weixin.common.bean.menu.WxMenu;
import me.chanjar.weixin.common.bean.menu.WxMenuButton;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.ssl.SSLContexts;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.security.KeyStore;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * @Description:
 * @ClassName: WeiXinUtil
 * @author songqi
 * @date 2017年7月5日
 */
public class WeiXinUtil {
	private static Logger logger = LoggerFactory.getLogger(WeiXinUtil.class);
	/** 项目地址 */
	private static final String PROJECT_URL = "http://056fbafd.ngrok.io/hospital";
	// 临时二维码
	private final static String QR_SCENE = "QR_SCENE";


	/** 获取accesstoken接口 */
	private static final String ACCESS_TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET";

	/** 文件上传接口 */
	private static final String UPLOAD_URL = "https://api.weixin.qq.com/cgi-bin/media/upload?access_token=ACCESS_TOKEN&type=TYPE";
	/** 菜单创建接口 */
	private static final String CREATE_MENU_URL = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=ACCESS_TOKEN";
	/** 菜单查询接口 */
	private static final String QUERY_MENU_URL = "https://api.weixin.qq.com/cgi-bin/menu/get?access_token=ACCESS_TOKEN";
	/** 菜单删除接口 */
	private static final String DELETE_MENU_URL = "https://api.weixin.qq.com/cgi-bin/menu/delete?access_token=ACCESS_TOKEN";
	/** 用户信息查询接口 */
	private static final String QUERY_USER_INFO_URL = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=ACCESS_TOKEN&openid=OPENID&lang=zh_CN";
	/** 获取网页授权凭证接口 */
	public static final String OAUTH2_ACCESSTOKEN_URL = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code";
	/** 网页授权获取用户信息接口 */
	private static final String OAUTH2_USER_INFO_URL = "https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID";
	/** 发送模板信息接口 */
	private static final String SEND_TEMPLATE_MESSAGE = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=ACCESS_TOKEN";
	/** 通过template_id_short获得模板ID */
	private static final String GET_TEMPLATE_ID = "https://api.weixin.qq.com/cgi-bin/template/api_add_template?access_token=ACCESS_TOKEN";
	/** 设置所属行业 */
	//private static final String SET_INDUSTRY = "https://api.weixin.qq.com/cgi-bin/template/api_set_industry?access_token=ACCESS_TOKEN";
	/** 获取jsapi ticket */
	private static final String GET_TICKET = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=ACCESS_TOKEN&type=jsapi";
	
	
	/**
	 * @Description: 上传文件
	 * @param
	 * @param accessToken
	 * @param type
	 * @return
	 * @throws IOException
	 */
	public static String upload(String filePath, String accessToken, String type) throws IOException {
		File file = new File(filePath);
		if (!file.exists() || !file.isFile()) {
			throw new IOException("文件不存在");
		}
		String url = UPLOAD_URL.replace("ACCESS_TOKEN", accessToken).replace("TYPE", type);
		URL urlObj = new URL(url);

		HttpURLConnection con = (HttpURLConnection) urlObj.openConnection();
		con.setRequestMethod("POST");
		con.setDoInput(true);
		con.setDoOutput(true);
		con.setUseCaches(false);
		// 设置请求头信息
		con.setRequestProperty("Connection", "Keep-Alive");
		con.setRequestProperty("Charset", "UTF-8");
		// 设置边界
		String BOUNDARY = "--------" + System.currentTimeMillis();
		con.setRequestProperty("Content-Type", "multipart/form-data;boundary=" + BOUNDARY);

		StringBuilder sb = new StringBuilder();
		sb.append("--");
		sb.append(BOUNDARY);
		sb.append("\r\n");
		sb.append("Content-Disposition:form-data;name=\"file\";filename=\"" + file.getName() + "\"\r\n");
		sb.append("Content-Type:application/octet-stream\r\n\r\n");
		byte[] head = sb.toString().getBytes("utf-8");

		// 获得输出流
		OutputStream out = new DataOutputStream(con.getOutputStream());
		// 输出表头
		out.write(head);
		// 文件正文部分
		// 把文件已流文件的方式，推入到url中
		DataInputStream in = new DataInputStream(new FileInputStream(file));
		int bytes = 0;
		byte[] bufferOut = new byte[1024];
		while ((bytes = in.read(bufferOut)) != -1) {
			out.write(bufferOut, 0, bytes);
		}
		in.close();

		// 结尾部分
		byte[] foot = ("\r\n--" + BOUNDARY + "--\r\n").getBytes("utf-8");// 定义最后数据分割线

		out.write(foot);

		out.flush();
		out.close();

		StringBuffer buffer = new StringBuffer();
		BufferedReader reader = null;
		String result = null;
		// 定义bufferedreader输入流来读取URL的响应
		reader = new BufferedReader(new InputStreamReader(con.getInputStream()));
		String line = null;
		while ((line = reader.readLine()) != null) {
			buffer.append(line);
		}
		if (result == null) {
			result = buffer.toString();
		}
		if (reader != null) {
			reader.close();
		}

		JSONObject jsonObject = JSONObject.fromObject(result);

		String mediaId = jsonObject.getString("media_id");
		return mediaId;

	}

	/**
	 * get请求
	 * 
	 * @param url
	 * @return
	 */
    public static JSONObject doGetStr(String url) {
        // 指定get请求  
        HttpGet httpGet = new HttpGet(url);  
        // 创建httpclient  
        HttpClient httpClient = new DefaultHttpClient();  
        // 发送请求  
        HttpResponse httpResponse;  
        //返回的json  
        JSONObject jsonObject = null;
        try {  
            httpResponse = httpClient.execute(httpGet);  
            // 验证请求是否成功  
            if (httpResponse.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {  
                // 得到请求响应信息  
                String str = EntityUtils.toString(httpResponse.getEntity(), "utf-8");  
                // 返回json  
                jsonObject =JSONObject.fromObject(str);
            }  
        } catch (ClientProtocolException e) {  
            // TODO Auto-generated catch block  
            e.printStackTrace();  
        } catch (IOException e) {  
            // TODO Auto-generated catch block  
            e.printStackTrace();  
        }  
        return jsonObject;
    }

	/**
	 * post请求
	 * 
	 * @param url
	 * @param outStr
	 * @return
	 */

	public static JSONObject doPostStr(String url, String outStr){
		CloseableHttpClient httpClient = HttpClients.createDefault();
		HttpPost httpPost = new HttpPost(url);
		JSONObject jsonObject = null;
		httpPost.setEntity(new StringEntity(outStr, "UTF-8"));
		HttpResponse httpResponse;  
		try {
			httpResponse = httpClient.execute(httpPost);
			String result = EntityUtils.toString(httpResponse.getEntity(), "UTF-8");
			jsonObject = JSONObject.fromObject(result);
		}catch (ClientProtocolException e) {  
            // TODO Auto-generated catch block  
            e.printStackTrace();  
        } catch (IOException e) {  
            // TODO Auto-generated catch block  
            e.printStackTrace();  
        } 
		return jsonObject;
	}

	/**
	 * 获取AccessToken
	 * 
	 * @return
	 */
	@SuppressWarnings("all")
	public static AccessToken getAccessToken() {
		String url = ACCESS_TOKEN_URL.replace("APPID", Config.Wx.APP_ID).replace("APPSECRET", Config.Wx.APPSECRET);
		String result = HttpClientUtils.get(url);
		logger.info("result>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>="+result);
		AccessToken token = new Gson().fromJson(result,AccessToken.class);
		return token;
	}

//	/**
//	 * 获取AccessToken
//	 *
//	 * @return
//	 */
//	@SuppressWarnings("all")
//	public static AccessToken getAccessToken(String appId,String appsecret) {
//		AccessToken token = new AccessToken();
//		String url = ACCESS_TOKEN_URL.replace("APPID", appId).replace("APPSECRET", appsecret);
//		JSONObject jsonObject = doGetStr(url);
//		if (jsonObject != null) {
//			token.setToken(jsonObject.getString("access_token"));
//			token.setExpiresIn(jsonObject.getInt("expires_in"));
//
//		}
//		return token;
//	}



	/**
	 * 组装菜单
	 * 
	 * @return
	 */
	public static WxMenu initMenu() {
		WxMenu menu = new WxMenu();
		/************** 菜单一 *****************/
		WxMenuButton button1 = new WxMenuButton();
		button1.setName("门诊服务");
		
		WxMenuButton button11 = new WxMenuButton();
		button11.setType(MenuButtonType.VIEW);
		button11.setName("智能导诊");
		button11.setUrl(PROJECT_URL + "/registration/guide");
		WxMenuButton button12 = new WxMenuButton();
		button12.setType(MenuButtonType.VIEW);
		button12.setName("我要挂号");
		button12.setUrl(PROJECT_URL + "/registration/registration");
		WxMenuButton button13 = new WxMenuButton();
		button13.setType(MenuButtonType.VIEW);
		button13.setName("门诊缴费");
		button13.setUrl("http://www.baidu.com");
		WxMenuButton button14 = new WxMenuButton();
		button14.setType(MenuButtonType.VIEW);
		button14.setName("检验检查");
		button14.setUrl("http://www.baidu.com");
		
		button1.getSubButtons().add(button11);
		button1.getSubButtons().add(button12);
		button1.getSubButtons().add(button13);
		button1.getSubButtons().add(button14);
		
		/************** 菜单二 *****************/
		WxMenuButton button2 = new WxMenuButton();
		button2.setName("医院信息");
		
		WxMenuButton button21 = new WxMenuButton();
		button21.setType(MenuButtonType.VIEW);
		button21.setName("医院简介");
		button21.setUrl(PROJECT_URL + "/help/introduce");
		WxMenuButton button23 = new WxMenuButton();
		button23.setType(MenuButtonType.VIEW);
		button23.setName("就医指南");
		button23.setUrl(PROJECT_URL + "/help/guideService");
		WxMenuButton button24 = new WxMenuButton();
		button24.setType(MenuButtonType.VIEW);
		button24.setName("操作指南");
		button24.setUrl(PROJECT_URL + "/help/operation");
		
		button2.getSubButtons().add(button24);
		button2.getSubButtons().add(button23);
		button2.getSubButtons().add(button21);
		
		/************** 菜单三 *****************/
		WxMenuButton button3 = new WxMenuButton();
		button3.setName("个人中心");
		
		WxMenuButton button31 = new WxMenuButton();
		button31.setType(MenuButtonType.VIEW);
		button31.setName("挂号记录");
		button31.setUrl(PROJECT_URL + "/user/record");
		WxMenuButton button32 = new WxMenuButton();
		button32.setType(MenuButtonType.VIEW);
		button32.setName("缴费记录");
		button32.setUrl(PROJECT_URL + "/user/payRecord");
		WxMenuButton button33 = new WxMenuButton();
		button33.setType(MenuButtonType.VIEW);
		button33.setName("我的信息");
		button33.setUrl(PROJECT_URL + "/user/myinfo");
		WxMenuButton button34 = new WxMenuButton();
		button34.setType(MenuButtonType.VIEW);
		button34.setName("我的住院");
		button34.setUrl(PROJECT_URL + "/hosp/myHosp");
		
		button3.getSubButtons().add(button31);
		button3.getSubButtons().add(button32);
		button3.getSubButtons().add(button34);
		button3.getSubButtons().add(button33);
		
		menu.getButtons().add(button1);
		menu.getButtons().add(button2);
		menu.getButtons().add(button3);
		return menu;
	}
	/** 创建菜单 */
	public static int createMenu(String token, String menu) {
		String url = CREATE_MENU_URL.replace("ACCESS_TOKEN", token);
		JSONObject jsonObject = null;
		jsonObject = doPostStr(url, menu);
		int result = 0;
		if (jsonObject != null) {
			result = jsonObject.getInt("errcode");
		}
		return result;

	}

	/** 查询菜单 */
	public static JSONObject queryMenu(String token) {
		String url = QUERY_MENU_URL.replace("ACCESS_TOKEN", token);
		JSONObject jsonObject = doGetStr(url);
		return jsonObject;
	}

	/** 删除菜单 */
	public static int deleteMenu(String token) throws ParseException, IOException {
		String url = DELETE_MENU_URL.replace("ACCESS_TOKEN", token);
		JSONObject jsonObject = doGetStr(url);
		int result = 0;
		if (jsonObject != null) {
			result = jsonObject.getInt("errcode");
		}
		return result;
	}

	/**
	 * @Description: 获取用户信息
	 * @author: songqi
	 * @date 2017年7月11日
	 * @param token
	 * @param openid
	 * @return
	 */
	/**
	 * @Description: 获取用户信息
	 * @author: songqi
	 * @date 2017年7月11日
	 * @param token
	 * @param openid
	 * @return
	 */
	public static WeixinUserInfo getUserInfo(String token, String openid) {
		logger.info("ACCESS_TOKEN>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+token);
		logger.info("OPENID>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+openid);
		WeixinUserInfo weixinUserInfo = null;
		String url = QUERY_USER_INFO_URL.replace("ACCESS_TOKEN", token).replace("OPENID", openid);
		JSONObject jsonObject = doGetStr(url);
		//Map<String, Object> jsonMap = JSON.parseObject(HttpUtils.get(url));
		logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+jsonObject);
		if (null != jsonObject) {
			try {
				weixinUserInfo = new WeixinUserInfo();
				// 用户的标识
				weixinUserInfo.setOpenId(jsonObject.getString("openid"));
				// 关注状态（1是关注，0是未关注），未关注时获取不到其余信息
				weixinUserInfo.setSubscribe(jsonObject.getInt("subscribe"));
				// 用户关注时间
				weixinUserInfo.setSubscribeTime(jsonObject.getString("subscribe_time"));
				// 昵称
				weixinUserInfo.setNickname(jsonObject.getString("nickname"));
				// 用户的性别（1是男性，2是女性，0是未知）
				weixinUserInfo.setSex(jsonObject.getInt("sex"));
				// 用户所在国家
				weixinUserInfo.setCountry(jsonObject.getString("country"));
				// 用户所在省份
				weixinUserInfo.setProvince(jsonObject.getString("province"));
				// 用户所在城市
				weixinUserInfo.setCity(jsonObject.getString("city"));
				// 用户的语言，简体中文为zh_CN
				weixinUserInfo.setLanguage(jsonObject.getString("language"));
				// 用户头像
				weixinUserInfo.setHeadimgurl(jsonObject.getString("headimgurl"));
			} catch (Exception e) {
				if (0 == weixinUserInfo.getSubscribe()) {
					logger.error("用户{}已取消关注", weixinUserInfo.getOpenId());
				} else {
					int errorCode = jsonObject.getInt("errcode");
					String errorMsg = jsonObject.getString("errmsg");
					logger.error("获取用户信息失败 errcode:{} errmsg:{}", errorCode, errorMsg);
				}
			}
		}
		return weixinUserInfo;
	}

	/**
	 * @Description: 获取网页授权凭证
	 * @author: songqi
	 * @date 2017年7月11日
	 * @param appId
	 * @param appSecret
	 * @param code
	 * @return
	 */
	public static WeixinOauth2Token getOauth2AccessToken(String appId, String appSecret, String code) {
		WeixinOauth2Token wat = null;
		String url = OAUTH2_ACCESSTOKEN_URL.replace("APPID", appId).replace("SECRET", appSecret)
				.replace("CODE", code);
		JSONObject jsonObject = doGetStr(url);
		if (null != jsonObject) {
			try {
				wat = new WeixinOauth2Token();
				wat.setAccessToken(jsonObject.getString("access_token"));
				wat.setExpiresIn(jsonObject.getInt("expires_in"));
				wat.setRefreshToken(jsonObject.getString("refresh_token"));
				wat.setOpenId(jsonObject.getString("openid"));
				wat.setScope(jsonObject.getString("scope"));
			} catch (Exception e) {
				wat = null;
				int errorCode = jsonObject.getInt("errcode");
				String errorMsg = jsonObject.getString("errmsg");
				logger.error("获取网页授权凭证失败 errcode:{} errmsg:{}", errorCode, errorMsg);
			}
		}
		return wat;
	}

	/**
	 * @Description: 通过网页授权获取用户信息
	 * @author: songqi
	 * @date 2017年7月11日
	 * @param accessToken
	 * @param openId
	 * @return
	 * "https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID";
	 */
	public static SNSUserInfo getSNSUserInfo(String accessToken, String openId) {
		SNSUserInfo snsUserInfo = null;
		String url = OAUTH2_USER_INFO_URL.replace("ACCESS_TOKEN", accessToken).replace("OPENID", openId);
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
				// 用户特权信息
				snsUserInfo.setPrivilegeList(JSONArray.toList(jsonObject.getJSONArray("privilege"), List.class));
			} catch (Exception e) {
				snsUserInfo = null;
				int errorCode = jsonObject.getInt("errcode");
				String errorMsg = jsonObject.getString("errmsg");
				logger.error("获取用户信息失败 errcode:{} errmsg:{}", errorCode, errorMsg);
			}
		}
		return snsUserInfo;
	}

//	/**
//	 * 发送模板消息前获取token
//	 * @param template_id_short
//	 * @param t
//	 * @param m
//	 * @throws IOException
//	 */
//	public static void sendMessageBefore(String template_id_short, WxTemplate t, Map<String,TemplateData> map) throws IOException {
//		AccessToken token = null;
//		if (TokenThread.accessToken == null || TokenThread.accessToken.getToken() == "") {
//			token = WeiXinUtil.getAccessToken();
//		} else {
//			token = TokenThread.accessToken;
//		}
//
//		t.setData(map);
//		WeiXinUtil.sendMessage(t, token.getToken());
//	}
	
//	/**
//	 * 发送template_id_short获取template_id
//	 * @param template_id_short 模板的编号
//	 * @param token
//	 * @return
//	 * @throws IOException
//	 */
//	public static String getTemplateId(String template_id_short) throws IOException {
//		AccessToken token = null;
//		if (TokenThread.accessToken == null || TokenThread.accessToken.getToken() == "") {
//			token = WeiXinUtil.getAccessToken();
//		} else {
//			token = TokenThread.accessToken;
//		}
//		String url = WeiXinUtil.GET_TEMPLATE_ID.replace("ACCESS_TOKEN", token.getToken());
//		JSONObject json = doPostStr(url, template_id_short);
//		return json.getString("template_id");
//	}

	/** 
     * 发送模板消息 
     * @param t 
     * @param accessToken 
     * @return 
	 * @throws IOException 
     */  
    public static int sendMessage(WxTemplate t,String accessToken) throws IOException {  
        int result = 0;  
        // 发送模板消息的url  
        String url = WeiXinUtil.SEND_TEMPLATE_MESSAGE.replace("ACCESS_TOKEN", accessToken);  
        // 将模板对象转换成json字符串  
        String jsonTemplate = JSONObject.fromObject(t).toString();  
        // 调用接口创建模板
        JSONObject jsonObject = doPostStr(url, jsonTemplate);  
        if (null != jsonObject) {  
            if (0 != jsonObject.getInt("errcode")) {  
                result = jsonObject.getInt("errcode");  
                logger.error("发送模板消息失败 errcode:{} errmsg:{}", jsonObject.getInt("errcode"), jsonObject.getString("errmsg"));  
            }  
        }  
        return result;  
    }  
    
    /**
     * 获取ticket
     * @param accessToken
     * @return
     * @throws IOException 
     */
    public static Ticket getTicket(String accessToken) throws IOException {
    	Ticket ticket = new Ticket();
    	String url = GET_TICKET.replace("ACCESS_TOKEN", accessToken);
    	JSONObject jsonObject = doGetStr(url);
    	if (null != jsonObject) {
			if (0 != jsonObject.getInt("errcode")) {
				logger.error("获取ticket失败 errcode:{} errmsg:{}", jsonObject.getInt("errcode"),
						jsonObject.getString("errmsg"));
			} else {
				ticket.setErrcode(jsonObject.getString("errcode"));
				ticket.setErrmsg(jsonObject.getString("errmsg"));
				ticket.setExpires_in(jsonObject.getString("expires_in"));
				ticket.setTicket(jsonObject.getString("ticket"));
				logger.info("获取ticket成功，ticket:{}", jsonObject.getString("ticket"));
			}
    	}
    	return ticket;
    }
    
    /** 
     * 签名算法 
     * @param ticket 
     * @return 
     */  
    public static SignatureInfo getSignature(SignatureInfo sign,Ticket ticket){  
        String data = "jsapi_ticket=" + ticket.getTicket() + "&noncestr=" + sign.getNoncestr() + "&timestamp=" + sign.getTimestamp() + "&url="+sign.getUrl();  
        String signature =  CheckUtil.getSha1(data);   
        sign.setSignature(signature);  
        logger.info("signature=" + sign.getSignature());  
        return sign;  
    }  
	


	/**
	 * 对输入的字符串进行URL编码, 即转换为%20这种形式
	 * 
	 * @param input
	 *            原文
	 * @return URL编码. 如果编码失败, 则返回原文
	 */
	public static String encode(String input) {
		if (input == null) {
			return "";
		}

		try {
			return URLEncoder.encode(input, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return input;
	}

	private static TrustManager myX509TrustManager = new X509TrustManager() {

		@Override
		public X509Certificate[] getAcceptedIssuers() {
			return null;
		}

		@Override
		public void checkServerTrusted(X509Certificate[] chain, String authType) throws CertificateException {
		}

		@Override
		public void checkClientTrusted(X509Certificate[] chain, String authType) throws CertificateException {
		}
	};

	/**
	 * 换取token后，获得openid，公众号的appId和secret
	 * @author: yixin
	 * @Date 2018-12-10
	 * @param code
	 * 微信回调返回的code
	 */
//	@SuppressWarnings("unchecked")
//	public static String getOpenid(String code) {
//		if (StringUtil.isNotNull(code)) {
//			String url = "https://api.weixin.qq.com/sns/oauth2/access_token?" + "appid="+Config.Wx.APP_ID+"" + "&secret="+Config.Wx.APPSECRET+"" + "&code="+code+"&grant_type=authorization_code";
//			Map<String, Object> jsonMap = JSON.parseObject(WeiXinUtil.getJsonFromUrl(url, null, null), Map.class);
//			/*String json = HttpClientUtils.get(url);*/
//			JSONObject jsonObject = doGetStr(url);
////			Map<String, Object> jsonMap = JSON.parseObject(HttpUtils.get(url));
//			//String openid =jsonObject.getString("openid");
//			logger.info("WeiXinUtil.getJsonFromUrl===>>>jsonObject="+jsonObject.toString());
//			if (jsonObject.getString("openid") == null || "0".equals(jsonObject.get("errcode"))) {
//				// 静默方式请求，只获取用户openid
//				return jsonObject.getString("openid");
//			} else {
//				return null;
//			}
//		}
//		return null;
//	}
	@SuppressWarnings("unchecked")
	public static String getOpenid(String code) {
		if (StringUtil.isNotNull(code)) {
			String url = "https://api.weixin.qq.com/sns/oauth2/access_token?" +
					"appid="+Config.Wx.APP_ID+"" +
					"&secret="+Config.Wx.APPSECRET+"" +
					"&code="+code+"&grant_type=authorization_code";
			Map<String, Object> jsonMap = JSON.parseObject(WeiXinUtil.getJsonFromUrl(url, "GET", null), Map.class);
			logger.info("WeiXinUtil.getJsonFromUrl===>>>jsonMap="+jsonMap.toString());
			if (jsonMap.get("errcode") == null || "0".equals(jsonMap.get("errcode"))) {
				logger.info("WeiXinUtil.getOpenid===>>>openid="+jsonMap.get("openid").toString());
				// 静默方式请求，只获取用户openid
				return jsonMap.get("openid").toString();

			} else {
				return null;
			}
		}
		return null;
	}

	/**
	 * 请求一个URL并返回JSON内容
	 *
	 * @param requestMethod
	 * @return
	 * @throws Exception
	 */
	public static String getJsonFromUrl(String urlAdd, String requestMethod, Map<String, Object> param) {
		logger.info("===================【urlAddr入参】===========================>urlAdd:" + urlAdd);
		logger.info("===================【requestMethod入参】===========================>requestMethod:" + requestMethod);
		logger.info("===================【param入参】===========================>param:" + param);
		InputStreamReader reader = null;
		BufferedReader in = null;
		PrintWriter out = null;
		try {
			URL url = new URL(urlAdd);
			URLConnection connection = url.openConnection();
			if (requestMethod != null && (requestMethod.equals("POST") || requestMethod.equals("post"))) {
				// 发送POST请求必须设置如下两行
				connection.setDoOutput(true);
				connection.setDoInput(true);
				// 获取URLConnection对象对应的输出流
				out = new PrintWriter(connection.getOutputStream());
				// 发送请求参数
				if (param != null) {
					logger.info("======================>urlAdd:"+urlAdd+"return-->" + JSON.toJSONString(param));
					out.print(JSON.toJSONString(param));
				}
				// flush输出流的缓冲
				out.flush();
			} else {
				connection.setConnectTimeout(1000);
			}
			reader = new InputStreamReader(connection.getInputStream(), "UTF-8");
			in = new BufferedReader(reader);
			String line = null; // 每行内容
			int lineFlag = 0; // 标记: 判断有没有数据
			StringBuffer content = new StringBuffer();
			while ((line = in.readLine()) != null) {
				content.append(line);
				lineFlag++;
			}
			logger.info("======================>param:" + content.toString());
			return lineFlag == 0 ? null : content.toString();
		} catch (Exception e) {
            logger.error(e.getMessage());
            e.getMessage();
			e.printStackTrace();
			logger.error("连接超时!!!");
			return null;
		} finally {
			if (out != null) {
				out.close();
			}
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {
					logger.error("关闭流出现异常!!!");
				}
			}
			if (reader != null) {
				try {
					reader.close();
				} catch (IOException e) {
					logger.error("关闭流出现异常!!!");
				}
			}
		}
	}

	/**
	 * 创建临时带参数二维码
	 * @expireSeconds 该二维码有效时间，以秒为单位。 最大不超过2592000（即30天），此字段如果不填，则默认有效期为30秒。
	 * @param sceneId 场景Id
	 * @return
	 */
	public static String  createTempQr(String expireSeconds, int sceneId) {
		RestTemplate rest = new RestTemplate();
		//获取AccessToken对象
		String accessToken =getAccessToken().getAccess_token();
		String url = "https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token="+accessToken ;
		// 参数：{"expire_seconds": 604800, "action_name": "QR_SCENE", "action_info": {"scene": {"scene_id": 123}}}
		Map<String,Integer> intMap = new HashMap<String,Integer>();
		intMap.put("scene_id",sceneId);
		Map<String,Map<String,Integer>> mapMap = new HashMap<String,Map<String,Integer>>();
		mapMap.put("scene", intMap);
		Map<String,Object> paramsMap = new HashMap<String,Object>();
		paramsMap.put("expire_seconds", expireSeconds);
		paramsMap.put("action_name", QR_SCENE);
		paramsMap.put("action_info", mapMap);
		MultiValueMap<String, String> headers = new LinkedMultiValueMap<>();
		HttpEntity requestEntity = new HttpEntity(paramsMap, headers);
		Map result = null;
		try {
			ResponseEntity<Map> entity = rest.exchange(url, HttpMethod.POST, requestEntity,Map.class, new Object[0]);
			logger.info("调用生成微信临时二维码URL接口返回结果:" + entity.getBody());
			result = (Map) entity.getBody();
		} catch (Exception e) {
			logger.error("调用生成微信临时二维码URL接口异常",e);
		}
		if(EmptyUtils.isNotEmpty(result)){
			return result.toString();
		}
		return null;
	}


	public static String getRandomStringByLength(int length) {
		String base = "0123456789";
		Random random = new Random();
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < length; i++) {
			int number = random.nextInt(base.length());
			sb.append(base.charAt(number));
		}
		return sb.toString();
	}


	/**
	 * @function 生成商户退款单号
	 * @date 2019-1-11
	 * @return String
	 */
	public static String getOrderNo(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		Date date = new Date();
		return sdf.format(date) + getRandomStringByLength(7);
	}


	/*
	* 微信退款加载证书
	* */
	public static SSLConnectionSocketFactory initCert() throws Exception {
		FileInputStream instream = null;
		KeyStore keyStore = KeyStore.getInstance("PKCS12");
		instream = new FileInputStream(new File(Config.Wx.KEY));
		keyStore.load(instream, Config.Wx.MCHID.toCharArray());

		if (null != instream) {
			instream.close();
		}

		SSLContext sslContext = SSLContexts.custom().loadKeyMaterial(keyStore, Config.Wx.MCHID.toCharArray()).build();
		SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslContext, new String[] { "TLSv1" }, null,
				SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);

		return sslsf;
	}

	public static void main(String[] args) {
		getAccessToken();
	}
}
