package com.jingbao.weixin.Utils;

import com.alibaba.fastjson.JSONObject;
import org.apache.http.*;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.config.RegistryBuilder;
import org.apache.http.conn.socket.ConnectionSocketFactory;
import org.apache.http.conn.socket.PlainConnectionSocketFactory;
import org.apache.http.conn.ssl.DefaultHostnameVerifier;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.BasicHttpClientConnectionManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.CoreConnectionPNames;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import sun.misc.BASE64Decoder;

import javax.net.ssl.KeyManagerFactory;
import javax.net.ssl.SSLContext;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.net.InetAddress;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.security.KeyStore;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * HTTP工具类.
 *
 * @author David.Huang
 */
public class HttpUtil {

    private static Logger log = LoggerFactory.getLogger(HttpUtil.class);
    /**
     * 创建HttpClient对象
     */
    static CloseableHttpClient httpclient = HttpClients.createDefault();
    /**
     * 默认编码方式 -UTF8
     */
    private static final String DEFAULT_ENCODE = "utf-8";

    private static BASE64Decoder decoder = new BASE64Decoder();

    // 信任所有站点
    static {
        SSLUtil.trustAllHostnames();
        SSLUtil.trustAllHttpsCertificates();
    }

    /**
     * 构造方法
     */
    public HttpUtil() {
        // empty constructor for some tools that need an instance object of the
        // class
    }

    /**
     * GET请求, 结果以字符串形式返回.
     *
     * @param url 请求地址
     * @return 内容字符串
     */
    public static String getUrlAsString(String url) throws Exception {
        return getUrlAsString(url, null, DEFAULT_ENCODE);
    }

    /**
     * GET请求, 结果以字符串形式返回.
     *
     * @param url    请求地址
     * @param params 请求参数
     * @return 内容字符串
     */
    public static String getUrlAsString(String url, Map<String, String> params) throws Exception {
        return getUrlAsString(url, params, DEFAULT_ENCODE);
    }

    /**
     * GET请求, 结果以字符串形式返回.
     *
     * @param url    请求地址
     * @param params 请求参数
     * @param encode 编码方式
     * @return 内容字符串
     */
    public static String getUrlAsString(String url, Map<String, String> params, String encode) throws Exception {
        // 开始时间
        long t1 = System.currentTimeMillis();
        // 获得HttpGet对象
        HttpGet httpGet = getHttpGet(url, params, encode);
        // 调试信息
        log.debug("url:" + url);
        log.debug("encode:" + encode);
        // 发送请求
        String result = executeHttpRequest(httpGet, null);
        // 结束时间
        long t2 = System.currentTimeMillis();
        // 调试信息
        log.debug("result:" + result);
        log.debug("consume time:" + ((t2 - t1)));
        // 返回结果
        return result;
    }

    /**
     * POST请求, 结果以字符串形式返回.
     *
     * @param url 请求地址
     * @return 内容字符串
     */
    public static String postUrlAsString(String url) throws Exception {
        return postUrlAsString(url, null, null, null);
    }

    /**
     * POST请求, 结果以字符串形式返回.
     *
     * @param url    请求地址
     * @param params 请求参数
     * @return 内容字符串
     */
    public static String postUrlAsString(String url, Map<String, String> params) throws Exception {
        return postUrlAsString(url, params, null, null);
    }

    /**
     * POST请求, 结果以字符串形式返回.
     *
     * @param url       请求地址
     * @param params    请求参数
     * @param reqHeader 请求头内容
     * @return 内容字符串
     * @throws Exception
     */
    public static String postUrlAsString(String url, Map<String, String> params, Map<String, String> reqHeader)
            throws Exception {
        return postUrlAsString(url, params, reqHeader, null);
    }

    /**
     * POST请求, 结果以字符串形式返回.
     *
     * @param url       请求地址
     * @param params    请求参数
     * @param reqHeader 请求头内容
     * @param encode    编码方式
     * @return 内容字符串
     * @throws Exception
     */
    public static String postUrlAsString(String url, Map<String, String> params, Map<String, String> reqHeader,
                                         String encode) throws Exception {
        // 开始时间
        long t1 = System.currentTimeMillis();
        // 获得HttpPost对象
        HttpPost httpPost = getHttpPost(url, params, encode);
        // 发送请求
        String result = executeHttpRequest(httpPost, reqHeader);
        // 结束时间
        long t2 = System.currentTimeMillis();
        // 调试信息
        log.debug("url:" + url);
        if (params != null) {
            log.debug("params:" + params.toString());
        }
        log.debug("reqHeader:" + reqHeader);
        log.debug("encode:" + encode);
        log.debug("result:" + result);
        log.debug("consume time:" + ((t2 - t1)));
        // 返回结果
        return result;
    }

    /**
     * 获得HttpGet对象
     *
     * @param url    请求地址
     * @param params 请求参数
     * @param encode 编码方式
     * @return HttpGet对象
     */
    private static HttpGet getHttpGet(String url, Map<String, String> params, String encode) {
        StringBuffer buf = new StringBuffer(url);
        if (params != null) {
            // 地址增加?或者&
            String flag = (url.indexOf('?') == -1) ? "?" : "&";
            // 添加参数
            for (String name : params.keySet()) {
                buf.append(flag);
                buf.append(name);
                buf.append("=");
                try {
                    String param = params.get(name);
                    if (param == null) {
                        param = "";
                    }
                    buf.append(URLEncoder.encode(param, encode));
                } catch (UnsupportedEncodingException e) {
                    log.error("URLEncoder Error,encode=" + encode + ",param=" + params.get(name), e);
                }
                flag = "&";
            }
        }
        log.info("==============getHttpGet url===========================" + buf.toString());
        HttpGet httpGet = new HttpGet(buf.toString());
        return httpGet;
    }

    /**
     * 获得HttpPost对象
     *
     * @param url    请求地址
     * @param params 请求参数
     * @param encode 编码方式
     * @return HttpPost对象
     */
    private static HttpPost getHttpPost(String url, Map<String, String> params, String encode) {
        HttpPost httpPost = new HttpPost(url);
        if (params != null) {
            List<NameValuePair> form = new ArrayList<NameValuePair>();
            for (String name : params.keySet()) {
                form.add(new BasicNameValuePair(name, params.get(name)));
            }
            try {
                UrlEncodedFormEntity entity = new UrlEncodedFormEntity(form, encode);
                httpPost.setEntity(entity);
            } catch (UnsupportedEncodingException e) {
                log.error("UrlEncodedFormEntity Error,encode=" + encode + ",form=" + form, e);
            }
        }
        return httpPost;
    }

    /**
     * 执行HTTP请求
     *
     * @param request   请求对象
     * @param reqHeader 请求头信息
     * @return 内容字符串
     */
    private static String executeHttpRequest(HttpUriRequest request, Map<String, String> reqHeader) throws Exception {
        HttpClient client = null;
        String result = null;
        try {
            // 创建HttpClient对象
            client = new DefaultHttpClient();
            // 设置连接超时时间
            client.getParams().setParameter(CoreConnectionPNames.CONNECTION_TIMEOUT, 60);
            // 设置Socket超时时间
            client.getParams().setParameter(CoreConnectionPNames.SO_TIMEOUT, 36600);
            // 设置请求头信息
            if (reqHeader != null) {
                for (String name : reqHeader.keySet()) {
                    request.addHeader(name, reqHeader.get(name));
                }
            }
            // 获得返回结果
            HttpResponse response = client.execute(request);
            // 如果成功
            System.out.println(response.getEntity());
            result = EntityUtils.toString(response.getEntity());
            if (response.getStatusLine().getStatusCode() != HttpStatus.SC_OK) {
                StringBuffer errorMsg = new StringBuffer();
                errorMsg.append("httpStatus:");
                errorMsg.append(response.getStatusLine().getStatusCode());
                errorMsg.append(response.getStatusLine().getReasonPhrase());
                errorMsg.append(", Header: ");
                Header[] headers = response.getAllHeaders();
                for (Header header : headers) {
                    errorMsg.append(header.getName());
                    errorMsg.append(":");
                    errorMsg.append(header.getValue());
                }
                log.error("HttpResonse Error:" + errorMsg);
            }
        } catch (Exception e) {
            log.error("http连接异常", e);
            throw new Exception("http连接异常");
        } finally {
            try {
                client.getConnectionManager().shutdown();
            } catch (Exception e) {
                log.error("finally HttpClient shutdown error", e);
            }
        }
        return result;
    }

    /**
     * 下载文件保存到本地
     *
     * @param path 文件保存位置
     * @param url  文件地址
     * @throws IOException
     */
    public static void downloadFile(String path, String url) throws IOException {
        log.debug("path:" + path);
        log.debug("url:" + url);
        // 发送请求获得返回结果
        CloseableHttpResponse response = null;
        try {
            // 获得HttpGet对象
            log.info("=============downloadFile path=================" + path + "=======url=========" + url);
            HttpGet httpGet = getHttpGet(url, null, null);
            // 发送请求获得返回结果
            response = httpclient.execute(httpGet);
            // 如果成功
            if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
                log.info("=============downloadFile httpStatus OK=================");
                byte[] result = EntityUtils.toByteArray(response.getEntity());
                BufferedOutputStream bw = null;
                try {
                    // 创建文件对象
                    File f = new File(path);
                    // 创建文件路径
                    if (!f.getParentFile().exists()) {
                        f.getParentFile().mkdirs();
                    }
                    // 写入文件
                    bw = new BufferedOutputStream(new FileOutputStream(path));
                    bw.write(result);
                } catch (Exception e) {
                    log.error("保存文件错误,path=" + path + ",url=" + url, e);
                    throw e;
                } finally {
                    try {
                        if (bw != null) {
                            bw.close();
                        }
                    } catch (Exception e) {
                        log.error("finally BufferedOutputStream shutdown close", e);
                    }
                }
            }
            // 如果失败
            else {
                log.info("=============downloadFile httpStatus fail=================");
                StringBuffer errorMsg = new StringBuffer();
                errorMsg.append("httpStatus:");
                errorMsg.append(response.getStatusLine().getStatusCode());
                errorMsg.append(response.getStatusLine().getReasonPhrase());
                errorMsg.append(", Header: ");
                Header[] headers = response.getAllHeaders();
                for (Header header : headers) {
                    errorMsg.append(header.getName());
                    errorMsg.append(":");
                    errorMsg.append(header.getValue());
                }
                log.error("HttpResonse Error:" + errorMsg);

            }
        } catch (ClientProtocolException e) {
            log.error("下载文件保存到本地,http连接异常,path=" + path + ",url=" + url, e);
            throw e;
        } catch (IOException e) {
            log.error("下载文件保存到本地,文件操作异常,path=" + path + ",url=" + url, e);
            throw e;
        } finally {
            try {
                if (response != null) {
                    response.close();
                }
            } catch (Exception e) {
                log.error("finally HttpClient shutdown error", e);
            }
        }
    }

    public static String doPost(String url, JSONObject json) {
        HttpClient httpClient = null;
        HttpPost httpPost = null;
        String result = null;
        try {
            httpClient = new SSLClient();
            httpPost = new HttpPost(url);
            // 设置参数
            StringEntity s = new StringEntity(json.toJSONString(), DEFAULT_ENCODE);
            s.setContentEncoding(DEFAULT_ENCODE);
            s.setContentType("application/json");
            httpPost.setEntity(s);
            HttpResponse response = httpClient.execute(httpPost);
            if (response != null) {
                HttpEntity resEntity = response.getEntity();
                if (resEntity != null) {
                    result = EntityUtils.toString(resEntity, DEFAULT_ENCODE);
                }
            }
        } catch (Exception ex) {
            log.error("https 请求异常", ex);
        }
        return result;
    }

    public static String doPostByXml(String url, String xml) {
        HttpClient httpClient = null;
        HttpPost httpPost = null;
        String result = null;
        try {
            httpClient = new SSLClient();
            httpPost = new HttpPost(url);
            // 设置参数
            StringEntity s = new StringEntity(xml, DEFAULT_ENCODE);
            s.setContentEncoding(DEFAULT_ENCODE);
            s.setContentType("application/xml");
            httpPost.setEntity(s);
            HttpResponse response = httpClient.execute(httpPost);
            if (response != null) {
                HttpEntity resEntity = response.getEntity();
                if (resEntity != null) {
                    result = EntityUtils.toString(resEntity, DEFAULT_ENCODE);
                }
            }
        } catch (Exception ex) {
            log.error("https 请求异常", ex);
        }
        return result;
    }

    public static String doPostByCert(String url, String data, InputStream certStream, String password) {
        try {
            // 证书
            char[] passwordChar = password.toCharArray();
            KeyStore ks = KeyStore.getInstance("PKCS12");
            ks.load(certStream, passwordChar);

            // 实例化密钥库 & 初始化密钥工厂
            KeyManagerFactory kmf = KeyManagerFactory.getInstance(KeyManagerFactory.getDefaultAlgorithm());
            kmf.init(ks, passwordChar);

            // 创建 SSLContext
            SSLContext sslContext = SSLContext.getInstance("TLS");
            sslContext.init(kmf.getKeyManagers(), null, new SecureRandom());

            SSLConnectionSocketFactory sslConnectionSocketFactory = new SSLConnectionSocketFactory(
                    sslContext,
                    new String[]{"TLSv1"},
                    null,
                    new DefaultHostnameVerifier());

            BasicHttpClientConnectionManager connManager = new BasicHttpClientConnectionManager(
                    RegistryBuilder.<ConnectionSocketFactory>create()
                            .register("http", PlainConnectionSocketFactory.getSocketFactory())
                            .register("https", sslConnectionSocketFactory)
                            .build(),
                    null,
                    null,
                    null
            );

            HttpClient httpClient = HttpClientBuilder.create()
                    .setConnectionManager(connManager)
                    .build();
            HttpPost httpPost = new HttpPost(url);

            RequestConfig requestConfig = RequestConfig.custom().build();
            httpPost.setConfig(requestConfig);

            StringEntity postEntity = new StringEntity(data, "UTF-8");
            httpPost.addHeader("Content-Type", "text/xml");
            httpPost.setEntity(postEntity);

            HttpResponse httpResponse = httpClient.execute(httpPost);
            HttpEntity httpEntity = httpResponse.getEntity();
            return EntityUtils.toString(httpEntity, "UTF-8");
        } catch (Exception e) {
            log.error("https 请求异常", e);
        }
        return null;
    }

    public static String doGet(String url) {
        String result = "";
        HttpClient httpClient = null;
        HttpGet httpGet = null;
        try {
            httpClient = new SSLClient();
            // 打开和URL之间的连接
            httpGet = new HttpGet(url);
            HttpResponse response = httpClient.execute(httpGet);
            if (response != null) {
                HttpEntity resEntity = response.getEntity();
                if (resEntity != null) {
                    result = EntityUtils.toString(resEntity, DEFAULT_ENCODE);
                }
            }
        } catch (Exception e) {
            log.error("发送GET请求出现异常！" + e);
        }
        // 使用finally块来关闭输入流
        finally {
            if (null != httpClient) {
                httpClient.getConnectionManager().shutdown();
            }
        }
        return result;
    }

    public static String doPostGzip(String url, JSONObject json) {
        HttpClient httpClient = null;
        HttpPost httpPost = null;
        String result = null;
        try {
            httpClient = new SSLClient();
            httpPost = new HttpPost(url);
            RequestConfig requestConfig = RequestConfig.custom()
                    .setConnectTimeout(5000).setConnectionRequestTimeout(5000)
                    .setSocketTimeout(5000).build();
            httpPost.setConfig(requestConfig);
            // 设置参数
            StringEntity s = new StringEntity(json.toString(), DEFAULT_ENCODE);
            s.setContentEncoding("gzip");
            s.setContentType("application/json; charset=UTF-8");
            httpPost.setEntity(s);
            HttpResponse response = httpClient.execute(httpPost);
            if (response != null) {
                if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
                    HttpEntity resEntity = response.getEntity();
                    if (resEntity != null) {
                        result = EntityUtils.toString(resEntity, DEFAULT_ENCODE);
                    }
                } else {
                    log.error("响应失败:" + response.getStatusLine().getStatusCode() + " " + response.getStatusLine().getReasonPhrase());
                }
            }
        } catch (Exception ex) {
            log.error("https 请求API异常", ex);
        } finally {
            if (httpClient != null) {
                httpClient.getConnectionManager().shutdown();
            }
        }
        return result;
    }

    /**
     * 读取request流
     *
     * @return
     * @author guoyx
     */
    public static String readReqStr(HttpServletRequest request) {
        BufferedReader reader = null;
        StringBuilder sb = new StringBuilder();
        try {
            reader = new BufferedReader(new InputStreamReader(request
                    .getInputStream(), "utf-8"));
            String line = null;

            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (null != reader) {
                    reader.close();
                }
            } catch (IOException e) {

            }
        }
        return sb.toString();
    }

    public static String getIpAddr(HttpServletRequest request) {
        String ipAddress = request.getHeader("x-forwarded-for");
        if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("Proxy-Client-IP");
        }
        if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getRemoteAddr();
            if (ipAddress.equals("127.0.0.1") || ipAddress.equals("0:0:0:0:0:0:0:1")) {
                //根据网卡取本机配置的IP
                InetAddress inet = null;
                try {
                    inet = InetAddress.getLocalHost();
                } catch (UnknownHostException e) {
                    e.printStackTrace();
                }
                ipAddress = inet.getHostAddress();
            }
        }
        //对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割
        if (ipAddress != null && ipAddress.length() > 15) { //"***.***.***.***".length() = 15
            if (ipAddress.indexOf(",") > 0) {
                ipAddress = ipAddress.substring(0, ipAddress.indexOf(","));
            }
        }
        return ipAddress;
    }
}
