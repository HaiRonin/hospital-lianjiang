package com.jingbao.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * 门诊 挂号
 * @author dell
 *
 */
@Controller
@RequestMapping("/registration")
public class RegistrationController {



	/**
	 * 确定挂号信息
	 * @return
	 */
	@RequestMapping(value = "/registeredInfo")
	public String registeredInfo() {
		return "registration/registeredInfo";
	}

	/**
	 * 预约挂号
	 * @return
	 */
	@RequestMapping(value = "/subscribe")
	public String subscribe() {
		return "registration/subscribeDoctorInfo";
	}

	/**
	 * 智能导诊
	 * @return
	 */
	@RequestMapping(value = "/guide")
	public String intelligenceGuide() {
		return "registration/intelligenceGuide";
	}
	
	/**
	 * 挂号 选科室subscribe
	 * @return
	 */
	@RequestMapping(value = "/departmentList")
	public String departmentList() {
		return "registration/departmentList";
	}


	/**
	 * 挂号 -根据科室获取医生列表
	 * @return
	 */
	@RequestMapping(value = "/departmentDoctorList")
	public String departmentDoctorList() {
		return "registration/departmentDoctorList";
	}


	/**
	 * 医生信息
	 */
	@RequestMapping(value = "/doctorInfo")
	public String doctorInfo() {
		return "registration/doctorInfo";
	}


	/**
	 * 门诊挂号
	 * @return
	 */
	@RequestMapping(value = "/clinc")
	public String clincRegistration() {
		return "registration/clinicRegistration";
	}
	
	/**
	 * 挂号 选时间
	 * @return
	 */
	@RequestMapping(value = "/timePick")
	public String clincTimePick() {
		return "registration/clincTimePick";
	}
	
	/**
	 * 确认挂号信息
	 * @return
	 */
	@RequestMapping(value = "/ensure")
	public String ensureRegistration() {
		return "registration/ensureRegistration";
	}
	
	/**
	 * 挂号费支付
	 * @return
	 */
	@RequestMapping(value = "/pay")
	public String registrationPay() {
		return "registration/registrationPay";
	}
	
	/**
	 * 挂号详情
	 * @return
	 */
	@RequestMapping(value = "/detail")
	public String registrationDetail() {
		return "registration/registrationDetail";
	}

	/**
	 * 获取检查,检验数据查询就诊人
	 * @return
	 */
	@RequestMapping(value = "/queryExaminationRecordInfo")
	public String queryExaminationRecordInfo() {
		return "registration/queryExaminationRecordInfo";
	}

	/**
	 * 获取检查,检验数据详情
	 * @return
	 */
	@RequestMapping(value = "/queryExaminationRecordDetails")
	public String queryExaminationRecordDetails() {
		return "registration/queryExaminationRecordDetails";
	}

	/**
	 * 获取检查,检验数据
	 * @return
	 */
	@RequestMapping(value = "/queryExaminationRecordList")
	public String queryExaminationRecordList() {
		return "registration/queryExaminationRecordList";
	}
	/**
	 * 获取检查,检验数据跳转
	 * @return
	 */
	@RequestMapping(value = "/queryExaminationRecord")
	public String queryExaminationRecord() {
		return "registration/queryExaminationRecord";
	}
	/**
	 *科室介绍
	 * @return
	 */
	@RequestMapping(value = "/sectionIntroductionList")
	public String sectionIntroductionList() {
		return "registration/sectionIntroductionList";
	}

	/**
	 *科室介绍详细信息
	 * @return
	 */
	@RequestMapping(value = "/sectionIntroduction")
	public String sectionIntroduction() {
		return "registration/sectionIntroduction";
	}

	
}
