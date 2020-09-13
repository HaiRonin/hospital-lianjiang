package com.jingbao.config;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;
import org.apache.commons.io.IOUtils;
import org.springframework.util.ResourceUtils;

public class GetCertStream {

    private byte[] certData;

    public InputStream getCertStream() {
        try {
            InputStream certStream = Thread.currentThread().getContextClassLoader().getResourceAsStream("resources/apiclient_cert.p12");
            this.certData = IOUtils.toByteArray(certStream);
            certStream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        ByteArrayInputStream certBis = new ByteArrayInputStream(this.certData);
        return certBis;
    }




}
