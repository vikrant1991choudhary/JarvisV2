package com.jarvis.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/JarvisV2")
public class CommonController {
	
	@RequestMapping(value="/welcome", method = RequestMethod.GET)
    public String showWelcomePage(ModelMap model){
        return "welcome";
    }
	
	@GetMapping({"/", "/login"})
	public String login(){
		return "login";
	}
	
	@GetMapping("/home")
	public String home(){
		return "home";
	}
	
	@PostMapping("/imports")
	public String imports(ModelMap model, HttpServletRequest request){
		HttpSession session= request.getSession();
		if(request.getParameter("isUploadAllowed").equalsIgnoreCase("Y"))
			session.setAttribute("isUploadAllowed", "Y");
		else
			session.setAttribute("isUploadAllowed", "N");
		model.addAttribute("searchedRows", null);
		return "imports";
	}
	
	@PostMapping("/tickersimport")
	public String tickersimport(HttpServletRequest request){
		HttpSession session= request.getSession();
		if(request.getParameter("isUploadAllowed").equalsIgnoreCase("Y"))
			session.setAttribute("isUploadAllowed", "Y");
		else
			session.setAttribute("isUploadAllowed", "N");
		return "tickersimport";
	}
	
	@PostMapping("/bondimport")
	public String bondimport(HttpServletRequest request){
		HttpSession session= request.getSession();
		if(request.getParameter("isUploadAllowed").equalsIgnoreCase("Y"))
			session.setAttribute("isUploadAllowed", "Y");
		else
			session.setAttribute("isUploadAllowed", "N");
		return "bondimport";
	}
	
	@PostMapping("/everythingimport")
	public String everythingimport(HttpServletRequest request){
		HttpSession session= request.getSession();
		if(request.getParameter("isUploadAllowed").equalsIgnoreCase("Y"))
			session.setAttribute("isUploadAllowed", "Y");
		else
			session.setAttribute("isUploadAllowed", "N");
		return "everythingimport";
	}
	
	@GetMapping("/calls")
	public String calls(){
		return "call";
	}
	
	@GetMapping("/puts")
	public String puts(){
		return "put";
	}
	
	@GetMapping("/admin")
	public String admin(){
		return "admin";
	}
	
	@GetMapping("/weekly")
	public String weekly(){
		return "weekly";
	}
	
	@GetMapping("/realTimeStock")
	public String realTimeStock(){
		return "realTimeStock";
	}
	
	@GetMapping("/realTimeBond")
	public String realTimeBond(){
		return "realTimeBond";
	}
	
	@GetMapping("/realTimeCurrencies")
	public String realTimeCurrencies(){
		return "realTimeCurrencies";
	}

	@GetMapping("/ruleengine")
	public String ruleengine(){
		return "rule/drag3";
	}
	@GetMapping("/allStocks")
	public String allStocks(){
		return "allStocks";
	}
	@GetMapping("/changePassword")
	public String changePassword(){
		return "changePassword";
	}
	@GetMapping("/createPortFolio")
	public String createPortFolio(){
		return "createPortFolio";
	}
	
	@GetMapping("/addTicker")
	public String addTicker(){
		return "addTicker";
	}
}
