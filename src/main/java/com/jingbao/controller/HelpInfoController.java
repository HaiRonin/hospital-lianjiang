package com.jingbao.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jingbao.entity.model.DopayInfo;
import com.jingbao.service.DopayInfoService;
import com.jingbao.util.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.jingbao.entity.basic.Department;
import com.jingbao.entity.basic.HiUserModel;

/**
 *  帮助信息
 * @author dell
 *
 */
@Controller
@RequestMapping("/help")
public class HelpInfoController {

	@Autowired
	DopayInfoService dopayInfoService;

	/**
	 * 跳转医院介绍页面
	 * @return
	 */
	@RequestMapping(value = "/introduce")
	public String hosIntroduce() {
		return "help/hosIntroduce";
	}
	
	/**
	 * 医院简介页面
	 * @return
	 */
	@RequestMapping(value = "/summary")
	public String hosSummary() {
		return "help/hosSummary";
	}

	/**
	 * 科室列表页面
	 * @return
	 */
	@RequestMapping(value = "/depaList")
	public String depaList() {
		return "help/depaList";
	}
	
	/**
	 * 科室介绍页面
	 * @return
	 */
	@RequestMapping(value = "/depaIntroduce")
	public String depaIntroduce(@RequestParam("organId")String organId, Model model) {
		model.addAttribute("organId", organId);
		return "help/depaIntroduce";
	}
	
	/**
	 * 查询科室列表信息
	 * @return
	 */
	@GetMapping(value = "/querydepartmentlist")
	@ResponseBody
	public Map<String, List<Department>> queryDepartmentList() {
		System.out.println("進入querydepartmentlist");
		Department department1 = new Department();
		Department department2 = new Department();
		Department department3 = new Department();
//		department1.setOrganId("1");
//		department2.setOrganId("2");
//		department3.setOrganId("3");
//		department1.setName("内科");
//		department2.setName("外科");
//		department3.setName("骨科");
		List<Department> departments = new ArrayList<Department>();
		departments.add(department1);
		departments.add(department2);
		departments.add(department3);
		Map<String, List<Department>> map = new HashMap<String, List<Department>>();
		map.put("department", departments);
		return map;
	}
	
	/**
	 * 根据科室Id查询科室信息
	 * @param organId 科室Id
	 * @return
	 */
	@GetMapping(value = "/queryDepartmentById")
	@ResponseBody
	public Department queryDepartmentById(@RequestParam("organId") String organId) {
		System.out.println("進入queryDepartmentById");
		Department department = new Department();
//		department.setName("內科");
//		department.setNumDoctors(5);
//		department.setDdesc("科室介绍科室介绍科室介绍科室介绍科室介绍科室介绍科室介绍科室介");
//		department.setDepartAddr("11F");
		return department;
	}
	
	/**
	 * 专家介绍
	 * @return
	 */
	@RequestMapping(value = "/expert")
	public String expertIntroduce() {
		return "help/expertIntroduce";
	}

	/**
	 * 就诊指引
	 * @return
	 */
	@RequestMapping(value = "/guideService")
	public String guideService() {
		return "help/guideService";
	}
	
	/**
	 * 操作指南
	 * @return
	 */
	@RequestMapping(value = "/operation")
	public String operationGuide() {
		return "help/operation";
	}
	
	@RequestMapping(value = "/hello")
	@ResponseBody
	public HiUserModel hello() {
		JsonObject obj = new JsonObject();
		obj.addProperty("hello", "world");
		HiUserModel hiUserModel = new HiUserModel();
//		hiUserModel.setPatientName("张三");
//		hiUserModel.setPatientSex("1");
//		hiUserModel.setPatientIdcardNo("443435523425232");
//		hiUserModel.setPatientTelephone("13544442222");
//		hiUserModel.setBalance("1000");

		return hiUserModel;
	}

	/**
	 * 药品查询
	 * @return
	 */
	@RequestMapping(value = "/drugIntroduce")
	public String drugIntroduce() {
		return "yygh/selectDrugs";
	}

	/**
	 * 药品查询数据
	 * @return
	 */
	@RequestMapping(value = "/yyghDdpt")
	public String yyghDdpt() {
		return "yygh/selectDrugsList";
	}


}
