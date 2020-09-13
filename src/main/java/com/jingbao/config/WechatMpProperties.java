package com.jingbao.config;

import java.util.Map;

import lombok.Data;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 微信账户配置
 * 
 * @author dell
 *
 */
@Data
@Component
@ConfigurationProperties(prefix = "wechat")
public class WechatMpProperties {

	/**
	 * 公众平台id
	 */
	private String mpAppId;

	/**
	 * 公众平台密钥
	 */
	private String mpAppSecret;

	/** 
	 * 公众平台token 
	 */
	private String token;
	
	/**
	 * 商户号
	 */
	private String mchId;

	/**
	 * 商户密钥
	 */
	private String mchKey;

	/**
	 * 支付地址
	 */
	private String wxPayUrl;
	
	/**
	 * 查询地址
	 */
	private String wxQueryUrl;

	/**
	 * 商户证书路径
	 */
	private String keyPath;

	/**
	 * 微信支付异步通知地址
	 */
	private String notifyUrl;

	/**
	 * 微信模版id
	 */
	private Map<String, String> templateId;
}
