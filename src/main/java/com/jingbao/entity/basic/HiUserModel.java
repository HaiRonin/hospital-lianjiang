package com.jingbao.entity.basic;

import java.io.Serializable;

import lombok.Data;

/**
 * 患者信息
 * @author dell
 *
 */
@Data
public class HiUserModel implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3551684413272966272L;
	
	private String patientNo;				//患者编号
	private String patientName;				//患者姓名
	private String patientIdcardNo;			//身份证号
	private String socialsecurityNO;		//社保号
	private String patientSex;				//姓别(“0”女，“1”男，“3”表示未知)
	private String patientBirthday;			//出生日期
	private String balance;					//门诊余额
	private String patientTelephone;		//联系电话
	private String address;					//家庭住址
	private String personCategory = "3";	//人员类别（默认为“3”，表示未知）
	private String resultCode;				//00：表示成功；未注册返回01，其他表示失败
	private String resultMsg;				//返回信息
	
	public HiUserModel() {}

}
