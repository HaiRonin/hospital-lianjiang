package com.jingbao.config;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.KeyStore;

import javax.net.ssl.SSLContext;

import lombok.Data;

import org.apache.http.ssl.SSLContexts;
import org.apache.tomcat.util.http.fileupload.IOUtils;

/**
 * 公众号内H5支付配置
 * @author dell
 *
 */
@Data
public class WxPayH5Config extends PayConfig {
	
	/** 公众号appId */
	private String appId;
	
	/** 公众号appSecret */
	private String appSecret;
	
	/** 商户号 */
	private String mchId;
	
	/** 商户密钥 */
	private String mchKey;

	/**支付地址*/
	private String wxPayUrl;
	
	/** 查询地址*/
	private String wxQueryUrl;
	
	/** 商户证书路径 */
	private String keyPath;
	
	/** 证书内容 */
	private SSLContext sslContext;
	
	public SSLContext initSSLContext() {
		FileInputStream inputStream = null;
		try {
			inputStream = new FileInputStream(new File(this.keyPath));
		} catch (IOException e) {
			throw new RuntimeException("读取微信商户证书文件出错", e);
		}

		try {
			KeyStore keystore = KeyStore.getInstance("PKCS12");
			char[] partnerId2charArray = mchId.toCharArray();
			keystore.load(inputStream, partnerId2charArray);
			this.sslContext = SSLContexts.custom().loadKeyMaterial(keystore, partnerId2charArray).build();
			return this.sslContext;
		} catch (Exception e) {
			throw new RuntimeException("证书文件有问题，请核实！", e);
		} finally {
			IOUtils.closeQuietly(inputStream);
		}
	}
	
}
