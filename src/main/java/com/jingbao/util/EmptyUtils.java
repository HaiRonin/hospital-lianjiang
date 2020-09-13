package com.jingbao.util;


import static org.springframework.util.ObjectUtils.isEmpty;

/**
 *
 * author: Blankj
 * blog : http://blankj.com
 * time : 2016/9/28
 * desc : 判空相关工具类
 *
 */
public class EmptyUtils {
    private EmptyUtils() {
        throw new UnsupportedOperationException("u can't instantiate me...");
    }
    /**
     * 判断对象是否非空
     *
     * @param obj 对象
     * @return {@code true}: 非空
    {@code false}: 空
     */
    public static boolean isNotEmpty(Object obj) {
        return !isEmpty(obj);
    }
}