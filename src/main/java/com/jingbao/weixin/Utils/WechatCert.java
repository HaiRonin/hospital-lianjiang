package com.jingbao.weixin.Utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

/**
 * 微信支付证书
 */
@Component
public class WechatCert {

    private Logger logger = LoggerFactory.getLogger(this.getClass());



    private static byte[] CERT_DATA;

//    @PostConstruct
//    public void init() {
//        try {
//            File file = new File("C:\\Users\\CangMaoMao\\Desktop\\apiclient_cert.p12");
//            InputStream certStream = new FileInputStream(file);
//            CERT_DATA = new byte[(int) file.length()];
//            certStream.read(CERT_DATA);
//            certStream.close();
//        } catch (Exception e) {
//            logger.error("微信支付证书初始化失败", e);
//        }
//    }

    public InputStream getCertStream() {
        try {
        File file = new File("/usr/local/soft/apiclient_cert.p12");
        InputStream certStream = new FileInputStream(file);
        CERT_DATA = new byte[(int) file.length()];
        certStream.read(CERT_DATA);
        certStream.close();
    } catch (Exception e) {
        logger.error("微信支付证书初始化失败", e);
    }
        ByteArrayInputStream certBis;
        certBis = new ByteArrayInputStream(CERT_DATA);
        return certBis;
    }

}
