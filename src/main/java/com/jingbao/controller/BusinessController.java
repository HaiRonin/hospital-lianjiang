package com.jingbao.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/business")
public class BusinessController {

    /**
     * 首页
     *
     * @return
     */
    @RequestMapping("/index")
    public String bindInfo() {
        return "/hospitalized/index";
    }
}
