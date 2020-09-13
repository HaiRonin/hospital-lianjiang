package com.jingbao.weixin.entity;

//import com.biubiulife.common.util.BeanUtil;

import com.jingbao.weixin.Utils.BeanUtil;
import com.jingbao.weixin.Utils.WXSignUtils;

import java.util.HashMap;
import java.util.SortedMap;
import java.util.TreeMap;

//import com.biubiulife.weixin.Utils.WXSignUtils;

public class WXAppPay {
	private String appId;
	private String partnerid;
	//private String package;
	private String nonceStr;
	private String timeStamp;
	private String prepay_id;
	private String sign;
	
//	private String codeurl;
//	public String getCodeurl() {
//		return codeurl;
//	}
//	public void setCodeurl(String codeurl) {
//		this.codeurl = codeurl;
//	}
	
	public String getPartnerid() {
		return partnerid;
	}
	public String getAppId() {
		return appId;
	}
	public void setAppId(String appId) {
		this.appId = appId;
	}
	public String getNonceStr() {
		return nonceStr;
	}
	public void setNonceStr(String nonceStr) {
		this.nonceStr = nonceStr;
	}
	public String getTimeStamp() {
		return timeStamp;
	}
	public void setTimeStamp(String timeStamp) {
		this.timeStamp = timeStamp;
	}
	public void setPartnerid(String partnerid) {
		this.partnerid = partnerid;
	}

	
	
	public String getPrepay_id() {
		return prepay_id;
	}
	public void setPrepay_id(String prepay_id) {
		this.prepay_id = prepay_id;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	
	public void makeSign(){
		HashMap<String, Object> m=new BeanUtil().beanToMap(this);
		m.put("package", "prepay_id="+this.getPrepay_id());
		m.put("signType", "MD5");
		m.remove("partnerid");
		m.remove("prepay_id");
		SortedMap<String,Object> sort=new TreeMap<String,Object>(m);  
		String sign= WXSignUtils.createSign("utf-8", sort);
		this.setSign(sign);
	}
	@Override
	public String toString() {
		return "WXAppPay [appId=" + appId + ", partnerid=" + partnerid
				+ ", nonceStr=" + nonceStr + ", timeStamp=" + timeStamp
				+ ", prepayid=" + prepay_id + ", sign=" + sign + "]";
	}
	
/*	public HashMap<String,Object> toHashMap(){
		HashMap<String, Object> m=new BeanUtil().beanToMap(this);
		m.put("package", "Sign=WXPay");
		return m;
	}*/
	
	
	
	
}
