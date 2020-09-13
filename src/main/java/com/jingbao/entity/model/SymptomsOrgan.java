package com.jingbao.entity.model;

import com.baomidou.mybatisplus.enums.IdType;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author wu123
 * @since 2019-01-26
 */
@TableName("symptoms_organ")
public class SymptomsOrgan implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 男或女：W-女；M-男
     */
    private String sex;
    /**
     * 身体部位
     */
    @TableField("body_part")
    private String bodyPart;
    private String symptoms;
    /**
     * 科室名称
     */
    @TableField("organ_name")
    private String organName;
    /**
     * 科室id
     */
    @TableField("organ_id")
    private Integer organId;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getBodyPart() {
        return bodyPart;
    }

    public void setBodyPart(String bodyPart) {
        this.bodyPart = bodyPart;
    }

    public String getSymptoms() {
        return symptoms;
    }

    public void setSymptoms(String symptoms) {
        this.symptoms = symptoms;
    }

    public String getOrganName() {
        return organName;
    }

    public void setOrganName(String organName) {
        this.organName = organName;
    }

    public Integer getOrganId() {
        return organId;
    }

    public void setOrganId(Integer organId) {
        this.organId = organId;
    }

    @Override
    public String toString() {
        return "SymptomsOrgan{" +
        "id=" + id +
        ", sex=" + sex +
        ", bodyPart=" + bodyPart +
        ", symptoms=" + symptoms +
        ", organName=" + organName +
        ", organId=" + organId +
        "}";
    }
}
