package com.jingbao.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

@Component
public class WechatPayConfig {

	@Autowired
	private WechatMpProperties wechatMpProperties;

	@Bean
	public WxPayH5Config wxPayH5Config() {

		WxPayH5Config config = new WxPayH5Config();
		config.setAppId(wechatMpProperties.getMpAppId());
		config.setAppSecret(wechatMpProperties.getMpAppSecret());
		config.setMchId(wechatMpProperties.getMchId());
		config.setMchKey(wechatMpProperties.getMchKey());
		config.setKeyPath(wechatMpProperties.getKeyPath());
		config.setNotifyUrl(wechatMpProperties.getNotifyUrl());
		
		return config;
	}
}
