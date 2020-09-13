package com.jingbao.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 住院
 * @author dell
 *
 */
@Controller
@RequestMapping("/hosp")
public class HospitalizedController {

	/**
	 * 我的住院
	 * @return
	 */
	@RequestMapping(value = "/myHosp")
	public String myHosp() {
		return "hospitalized/myHospitalized";
	}
	
	/**
	 * 住院信息
	 * @return
	 */
	@RequestMapping(value = "/HospitalInfo")
	public String HospitalInfo() {
		return "hospitalized/HospitalInfo";
	}

	/**
	 * 住院清单明细HospitalInfo
	 * @return
	 */
	@RequestMapping(value = "/hospDetail")
	public String hospDetail() {
		return "hospitalized/hospitalizedDetail";
	}
	
	/**
	 * 住院缴费
	 * @return
	 */
	@RequestMapping(value = "/hospPayment")
	public String hospPayment() {
		return "hospitalized/hospPayment";
	}
	
	/**
	 * 押金补缴
	 * @return
	 */
	@RequestMapping(value = "/depositPayInBack")
	public String depositPayInBack() {
		return "hospitalized/depositPayInBack";
	}
	
	/**
	 * 押金明细
	 * @return
	 */
	@RequestMapping(value = "/depositDetail")
	public String depositDetail() {
		return "hospitalized/depositDetail";
	}


	/**
	 * 出院清单
	 * @return
	 */
	@RequestMapping(value = "/outHospitalList")
	public String outHospitalList() {
		return "hospitalized/outHospitalList";
	}

	/**
	 * 住院清单
	 * @return
	 */
	@RequestMapping(value = "/inHospitalList")
	public String inHospitalList() {
		return "hospitalized/inHospitalList";
	}

	/**
	 * 住院押金
	 * @return
	 */
	@RequestMapping(value = "/depositHospitalList")
	public String depositHospitalList() {
		return "hospitalized/depositHospitalList";
	}

	/**
	 * 挂号预约
	 * @return
	 */
	@RequestMapping(value = "/doreg")
	public String doreg() {
		return "yygh/yyghDeptList";
	}

	/**
	 * 智能导诊
	 * @return
	 */
	@RequestMapping(value = "/intelligentGuidance")
	public String intelligentGuidance() {
		return "registration/smartGuide";
		//return "registration/intelligenceGuide";
	}

	/**
	 * 押金缴纳
	 * @return
	 */
	@RequestMapping(value = "/hospitalizationExpenses")
	public String hospitalizationExpenses() {
		return "hospitalized/hospitalizationExpenses";
	}

}
