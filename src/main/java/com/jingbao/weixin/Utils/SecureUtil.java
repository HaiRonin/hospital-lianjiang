package com.jingbao.weixin.Utils;

import java.security.MessageDigest;

/**
 * @Description:
 * @author
 * @date 2018/3/1 16:25
 * @version V1.0
 */
public class SecureUtil {
	public static String md5(String text) throws Exception {
		return md5(text.getBytes("UTF-8"));
	}

	public static String md5(byte[] source) throws Exception {
		int bufferSize = 4096;
		byte[] buffer = new byte[4096];

		MessageDigest md5 = MessageDigest.getInstance("MD5");

		int remain = source.length;

		while (remain > 0) {
			int len = (remain > bufferSize) ? bufferSize : remain;
			System.arraycopy(source, source.length - remain, buffer, 0, len);
			remain = remain - len;

			md5.update(buffer, 0, len);
		}

		return byte2Hex(md5.digest());
	}

	public static String byte2Hex(byte[] bytes) throws Exception {
		final String hex = "0123456789abcdef";

		String result = "";
		for (int i = 0; i < bytes.length; i++) {
			result += hex.charAt(bytes[i] >> 4 & 0x0F);
			result += hex.charAt(bytes[i] & 0x0F);
		}

		return new String(result);
	}
}
