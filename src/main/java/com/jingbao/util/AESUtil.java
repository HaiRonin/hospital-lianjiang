package com.jingbao.util;
import java.security.Security;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.bouncycastle.jce.provider.BouncyCastleProvider;

public class AESUtil {

    /**
     * 密钥算法
     */
    private static final String ALGORITHM = "AES";
    /**
     * 加解密算法/工作模式/填充方式
     */
    private static final String ALGORITHM_MODE_PADDING = "AES/ECB/PKCS7Padding";

    /**
     * AES加密
     *
     * @param data 加密内容
     * @param password 加密密码
     * @return
     * @throws Exception
     */
    public static String encryptData(String data,String password) throws Exception {
        //Security.addProvider(new BouncyCastleProvider());
        // 创建密码器
        Cipher cipher = Cipher.getInstance(ALGORITHM_MODE_PADDING);
        // 初始化为加密模式的密码
        cipher.init(Cipher.ENCRYPT_MODE, getSecretKey(password));
        // 加密
        byte[] result = cipher.doFinal(data.getBytes());

        return  Base64.encodeBase64String(result);
    }

    /**
     * AES解密
     *
     * @param base64Data 解密内容
     * @param password 解密密码
     * @return
     * @throws Exception
     */
    public static String decryptData(String base64Data,String password) throws Exception {
        Security.addProvider(new BouncyCastleProvider());
        // 创建密码器
        Cipher cipher = Cipher.getInstance(ALGORITHM_MODE_PADDING);
        //使用密钥初始化，设置为解密模式
        cipher.init(Cipher.DECRYPT_MODE, getSecretKey(password));
        //执行操作
        byte[] result = cipher.doFinal(Base64.decodeBase64(base64Data));

        return new String(result, "utf-8");
    }

    /**
     * 生成加密秘钥
     *
     * @return
     */
    private static SecretKeySpec getSecretKey(String password) {

        SecretKeySpec key = new SecretKeySpec(MD5Util.MD5Encode(password, "UTF-8").toLowerCase().getBytes(), ALGORITHM);
        return key;
    }

  /*  public static void main(String[] args){
        String A = "QMp6bLccUtxAhoK6KxevK0yA0hMESKUbnz1paA2dU4nIw5tPbUjr3UiRdGzNxfRve91MZgHuUSMcOqfvQcRWoxrEoWGLEeqabGsPgZe538vbAaLVGBhV49BEFP8MfGu3ux/q/+Clz5tmtgG7JdZzEsV3S9z1ki2JlG0usNmsWbSS8VIhKBRbAsCejzGs7YLD4FNA89YZ0fEpAMLhAhmRJmw5ymjPTSUHZ4RkPWDqOrN58AkDuKkM3eL/JzFK6coimp9YJhkeY8rCEmKcLgDM3G6tfPBQ3z2hS3yyhJWLoYkpuRk7qcWMyuls0t8ix/2vuWmilQCyraC6uSLdfK4d7wr6H+t7cTELoNOyrKSIIrTvy5IGqGQuS4+fUjrC5G3jVDa9Ol7SHDJlYzWTvtN3/WS+MjMPsjyrkEudjZNen6kMuiQcTNyCtynAshSpmLQa9CQx4u1pqkthtisRKvMjizefZEPSjW0bezM1aZOkkw4syDy/4PB18QnMjRbJJqZ0S5EfRJ9gN3fgxb6+GXQy3M9BIP/Pvx7FRMorKapq/6ACJJHesG2Rq4sWdAMBoYiFz5OKpIlLAHhz3KpFXbulYimm3zSJChpxXiymOqEt4ozrStiK6jet5Df/jGkjXJAiUG1xEkmDXoG9+WbHr054V4qr2NFCotjOoNCxN1XM18OtFbU4ZBEX9sCtsx5AmEAbyexu8M7/7NpBtXZhSB8VwcoYGhg7VgiEMpAqZaG/94RkjLGjQ9vRn3yQCwaUyAkkgvlqOqV5KcoQvq0UKN/6adNGuoEfiF5daPh2y3JfYTiY2fTMTS9iLfWK0vgZ9doLys8UJvEwwxl5ohnLXYTi7I6tA4dNkRihFMnuNqJblg1VtX4fTfYfQTMyYj2SbiP8MuNLjJxE60gDjC2fZnv6evbqp7ARSsSH/O0EGcYcgfLCTrfODWkJVkUZrxTMl4muuekafqA15wmGMpl4BwjC3rTepdd2YpY8Psilst8q7kbmZCtQ4ezykoFuanzvVmz+T0Ku72hmXd7VCRaU+Q3ORA==";
        try {
            String B = decryptData(A,"your password");
            System.out.println(B);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }*/
}