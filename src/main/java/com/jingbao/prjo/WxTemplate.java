package com.jingbao.prjo;

import java.util.Map;

/**
 * 模板基类
 * @author dell
 *
 */
public class WxTemplate {
	private String template_id;	// 模板ID
	private String touser;		// 接收者openid
	private String url;			// 模板跳转链接
	private String topcolor;	// 字体颜色
	private Map<String, TemplateData> data;		// 模板里的数据
	
	public String getTemplate_id() {
		return template_id;
	}
	public void setTemplate_id(String template_id) {
		this.template_id = template_id;
	}
	public String getTouser() {
		return touser;
	}
	public void setTouser(String touser) {
		this.touser = touser;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getTopcolor() {
		return topcolor;
	}
	public void setTopcolor(String topcolor) {
		this.topcolor = topcolor;
	}
	public Map<String, TemplateData> getData() {
		return data;
	}
	public void setData(Map<String, TemplateData> data) {
		this.data = data;
	}
	
	
}
