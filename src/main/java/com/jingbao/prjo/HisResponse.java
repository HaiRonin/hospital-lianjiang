package com.jingbao.prjo;

import lombok.Data;

import java.io.Serializable;

/**
 * Created by ASUS on 2019/1/25.
 */
@Data
public class HisResponse implements Serializable{
    /**
     * 00：表示成功，
        其他表示失败
     */
   private String resultCode;

    /***
     * 返回信息
     */
   private String resultMsg;

    /**
     * 返回消息内容 SON字符串
     */
   private String regDoctor;
}
