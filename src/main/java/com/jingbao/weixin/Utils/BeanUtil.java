package com.jingbao.weixin.Utils;

import org.apache.commons.beanutils.PropertyUtilsBean;

import java.beans.PropertyDescriptor;
import java.util.HashMap;

public class BeanUtil {

    public HashMap<String, Object> beanToMap(Object obj) {
        HashMap<String, Object> map = new HashMap<String, Object>();
        try {
            PropertyUtilsBean propertyUtilsBean = new PropertyUtilsBean();
            PropertyDescriptor[] descriptors = propertyUtilsBean.getPropertyDescriptors(obj);
            for (int i = 0; i < descriptors.length; i++) {
                String name = descriptors[i].getName();
                if (!"class".equals(name)) {
                    map.put(name, propertyUtilsBean.getNestedProperty(obj, name));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }


    public static String idFormat(String id) {
// 可以用 StringBuilder 这个类，里面有一个接口replace，如下
        StringBuilder sb = new StringBuilder(id);
        sb.replace(6, 10, "****");
        return sb.toString();
    }


}
