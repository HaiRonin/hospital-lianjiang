package com.jingbao.prjo;

import lombok.Data;

/**
 * @Description:
 * @ClassName: AccessToken
 * @author songqi
 * @date 2017年7月5日
 */
@Data
public class AccessToken {

	//{"access_token":"18_os9hzrxFVoGFlqxCaYz92bMblgvsEs4nlWSX4UrVa3OKmd-PwxWQE5RwWJYOCpY023tECz2NoxzIlNDKBmT83Z-Hb87-SC1vHpmmOQoAc29dbMhJixAZdXojHYEZLEbAGAQCV","expires_in":7200}

	private String access_token;

	private int expires_in;

}
