package com.jingbao.util;

import me.chanjar.weixin.common.api.WxConsts.MenuButtonType;
import me.chanjar.weixin.common.bean.menu.WxMenu;
import me.chanjar.weixin.common.bean.menu.WxMenuButton;

/**
 *  自定义菜单创建
 * @author dell
 *
 */
public class MenuUtil {
	/** 项目地址 */
	private static final String PROJECT_URL = "http://c577b21e.ngrok.io/hospital";
	
	/**
	 * 组装菜单
	 * @return
	 */
	public static WxMenu menuInit() {
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
	
	public static void main(String[] args) {
		String json = menuInit().toJson();
		System.out.println(json);
	}
}
