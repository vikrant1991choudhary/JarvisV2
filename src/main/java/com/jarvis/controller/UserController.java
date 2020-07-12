package com.jarvis.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.jarvis.dto.Login;
import com.jarvis.entity.MarketData;
import com.jarvis.entity.User;
import com.jarvis.service.UserService;

@Controller
@RequestMapping("/JarvisV2")
public class UserController {
	
	@Autowired
	UserService service;
	
	/*@RequestMapping(value="/welcome", method = RequestMethod.GET)
    public String showWelcomePage(ModelMap model){
        return "welcome";
    }*/
	
	/*@RequestMapping(value="/welcome", method = RequestMethod.GET)
    public ModelAndView homeGet() {

        return new ModelAndView("welcome");
    }*/
	
	/*@RequestMapping(value="/home", method = RequestMethod.POST)
    public String isUserAuthenticated(ModelMap model){
		System.out.println();
        return "home";
    }*/
	
	@RequestMapping(value="/home", method = RequestMethod.POST)
	public String isUserAuthenticated(ModelMap model,@RequestParam("userName") String userName,
			@RequestParam("password") String password, HttpServletRequest request){
		System.out.println("userName : " + userName);
		Login luser = new Login();
		luser.setUsername(userName);
		luser.setPassword(password);
		User loggedInUser = service.isAuthenticate(luser);
		
		if(loggedInUser!=null){
			HttpSession session= request.getSession(true);
			System.out.println("Controller userID="+loggedInUser.getId());
			session.setAttribute("userID", loggedInUser.getId());
			session.setAttribute("userEmail", loggedInUser.getEmail());
			//System.out.println("IsUploadAllowed="+loggedInUser.getIsUploadAllowed().trim()+"<--");
			session.setAttribute("isUploadAllowed", loggedInUser.getIsUploadAllowed());
			model.addAttribute("welcome", "<h6 style=\"color:#247041\">Good morning "+loggedInUser.getFname()+"!</h6>");
			return "home";
		}else{
			model.addAttribute("message", "wrong credential!");
			return "login";
		}
	}
	
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logout(ModelMap model, HttpServletRequest request){
		System.out.println("Logged Out!!");
		model.addAttribute("message", "You're logged out!");
		HttpSession session= request.getSession(false);
        if(session != null) {
            session.invalidate();
        }
        return "login";
	}
	
	@GetMapping("/getAllUser")
	public ResponseEntity<List<User>> getAllUser(){
		List<User> user = service.getAllUser();
		if(user.size()>0){
			return new ResponseEntity<List<User>>(user,HttpStatus.OK);
		}
		return new ResponseEntity<List<User>>(HttpStatus.NOT_FOUND);
	}
	
	/*
	 * @GetMapping("/isAuthenticate") public ResponseEntity<Void>
	 * isAuthenticate(@RequestBody Login luser){ if(service.isAuthenticate(luser)){
	 * return new ResponseEntity<Void>(HttpStatus.OK); } return new
	 * ResponseEntity<Void>(HttpStatus.NOT_FOUND); }
	 */
	
	@PostMapping("/addUser")
	public ResponseEntity<Integer> addUser(@RequestBody User user){
		int id = service.createUser(user);
		if(id!=0){
			return new ResponseEntity<Integer>(HttpStatus.CREATED);
		}
		return new ResponseEntity<Integer>(HttpStatus.TEMPORARY_REDIRECT);
	}
	
	@GetMapping("/getImportsData")
	public ResponseEntity<List<MarketData>> getImportsData(@RequestParam("metaDataName") String metaDataName){
		System.out.println("In getImportsData for "+metaDataName);
		List<MarketData> user = service.getAllMarketDataByDate(metaDataName, "1900-01-01");//service.getAllMarketData();
		if(user.size()>0){
			return new ResponseEntity<List<MarketData>>(user,HttpStatus.OK);
		}
		return new ResponseEntity<List<MarketData>>(new ArrayList<MarketData>(),HttpStatus.OK);
	}
	
	
}
