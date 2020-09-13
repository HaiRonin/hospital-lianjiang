package com.jingbao.controller;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.jingbao.constants.BodySymptomsEnum;
import com.jingbao.entity.basic.Department;
import com.jingbao.entity.model.BodyPart;
import com.jingbao.entity.model.DopayInfo;
import com.jingbao.entity.model.SymptomsOrgan;
import com.jingbao.entity.model.SymptomsOrganExd;
import com.jingbao.service.BodyPartService;
import com.jingbao.service.SymptomsOrganService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;
import java.util.stream.Collectors;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author wu123
 * @since 2019-01-19
 */
@Controller
@RequestMapping("/symptomsOrgan")
public class SymptomsOrganController {

    @Autowired
    private SymptomsOrganService symptomsOrganService;

    @Autowired
    private BodyPartService bodyPartService;
    /**
     * 获取所有的身体部位
     * @return
     */
    @GetMapping(value = "/getBodyListPart")
    @ResponseBody
    public List<BodyPart> getBodyListPart() {
        EntityWrapper<BodyPart> wntityWrapper = new EntityWrapper<BodyPart>();
        wntityWrapper.orderBy("sort",true);
        List<BodyPart> list = bodyPartService.selectList(wntityWrapper);
        return list;
    }

    /**
     * 根据身体部位获取对应的病症
     * @return
     */
    @GetMapping(value = "/getOrganList")
    @ResponseBody
    public List<SymptomsOrganExd> getOrganList(@RequestParam("bodyPart") String bodyPart,
                                            @RequestParam("sex") String sex,@RequestParam("age") String age) {
        String sexAge = BodySymptomsEnum.getCodeByName(sex+"_"+age);
        EntityWrapper<SymptomsOrgan> wntityWrapper = new EntityWrapper<SymptomsOrgan>();
        wntityWrapper.where("body_part={0}",bodyPart);
        wntityWrapper.and().eq("sex",sexAge);
        List<SymptomsOrgan> list = symptomsOrganService.selectList(wntityWrapper);
        Map<String, List<SymptomsOrgan>> countMap = list.stream().collect(Collectors.groupingBy(o -> o.getSymptoms()));

        List<SymptomsOrganExd> listSymptomsOrganExd = new ArrayList<SymptomsOrganExd>(countMap.size());
        Iterator iter = countMap.entrySet().iterator(); // 获得map的Iterator
        while (iter.hasNext()) {
            Map.Entry entry = (Map.Entry) iter.next();
            SymptomsOrganExd symptomsOrganExd = new SymptomsOrganExd();
            symptomsOrganExd.setSymptoms(entry.getKey().toString());
            symptomsOrganExd.setSex(sexAge);
            symptomsOrganExd.setBodyPart(bodyPart);
            listSymptomsOrganExd.add(symptomsOrganExd);
        }
        return listSymptomsOrganExd;
    }
//    /**
//     * 根据病症获取对应的科室
//     * @return
//     */
//    @GetMapping(value = "/getSymptomsList")
//    @ResponseBody
//    public List<SymptomsOrgan> getSymptomsList(@RequestParam("symptoms") String symptoms) {
//        EntityWrapper<SymptomsOrgan> wntityWrapper = new EntityWrapper<SymptomsOrgan>();
//        wntityWrapper.where("symptoms={0}",symptoms);
//        List<SymptomsOrgan> list = symptomsOrganService.selectList(wntityWrapper);
//        return list;
//    }

    /**
     * 科室介绍
     *
     * @return
     */
    @RequestMapping("/diagnosis")
    public String depInfo(Model model,@RequestParam("bodyPart") String bodyPart,
                          @RequestParam("sex") String sex,@RequestParam("symptoms") String symptoms) {
        EntityWrapper<SymptomsOrgan> wntityWrapper = new EntityWrapper<SymptomsOrgan>();
        wntityWrapper.where("body_part={0}",bodyPart);
        wntityWrapper.and().eq("sex",sex);
        wntityWrapper.and().eq("symptoms",symptoms);
        List<SymptomsOrgan> list = symptomsOrganService.selectList(wntityWrapper);
        model.addAttribute("listOrg", list);
        return "registration/diagnosis";
    }
}

