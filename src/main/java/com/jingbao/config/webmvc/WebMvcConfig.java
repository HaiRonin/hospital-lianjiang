package com.jingbao.config.webmvc;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * 仅跳转页面的url配置
 * @author dell
 *
 */
@Configuration
public class WebMvcConfig extends WebMvcConfigurerAdapter {

	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		//跳转个人信息页面
		registry.addViewController("/user").setViewName("user/myinfo");
		
		// 跳转到智能导诊页面
		registry.addViewController("/guide").setViewName("/test1");
		
		// 跳转到医院介绍页面
		registry.addViewController("/introduce").setViewName("/introduce");
		
		// 跳转到我的住院页面
		registry.addViewController("/hospitalize").setViewName("/myHospitalize");
	}
}
