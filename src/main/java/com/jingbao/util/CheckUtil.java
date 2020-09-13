package com.jingbao.util;

import java.security.MessageDigest;
import java.util.Arrays;

/**
 * @Description:
 * @ClassName: CheckUtil
 * @author songqi
 * @date 2017年7月5日
 */
public class CheckUtil {
	private static final String token = "jingbao";

	public static boolean checkSign(String signature, String timestamp, String nonce) {
		String[] arr = new String[] { token, timestamp, nonce };
		// 排序
		Arrays.sort(arr);
		StringBuffer content = new StringBuffer();
		for (int i = 0; i < arr.length; i++) {
			content.append(arr[i]);
		}
		// sha1加密
		String temp = getSha1(content.toString());
		return temp.equals(signature);

	}

	public static String getSha1(String str) {
		if (str == null || str.length() == 0) {
			return null;
		}
		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };

		try {
			MessageDigest mdTemp = MessageDigest.getInstance("SHA1");
			mdTemp.update(str.getBytes("UTF-8"));
			byte[] md = mdTemp.digest();
			int j = md.length;
			char buf[] = new char[j * 2];
			int k = 0;
			for (int a = 0; a < j; a++) {
				byte bbb = md[a];
				buf[k++] = hexDigits[bbb >>> 4 & 0xf];
				buf[k++] = hexDigits[bbb & 0xf];
			}
			return new String(buf);
		} catch (Exception e) {
			return null;
		}

	}
}
