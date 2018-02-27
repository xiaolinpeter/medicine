package com.peter.shiro.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 后台首页
 * 
 * @author xiaolin_peter
 *
 */

@Controller
public class HomeController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = "/index.html", method = RequestMethod.GET)
	public String index(Model model) {
		logger.debug("-----后台首页-----");
		model.addAttribute("title", "后台首页");
		return "index";
	}

}
