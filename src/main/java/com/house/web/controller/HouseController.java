package com.house.web.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.house.web.entity.House;
import com.house.web.service.HouseService;

@Controller
public class HouseController {

	@Autowired
	private HouseService houseService;
	
	@GetMapping("/index")
	public String house_list(Model model,String date,Integer id) {
		
		SimpleDateFormat format1 = new SimpleDateFormat ("yyyy-MM-dd");
				
		Date today = new Date();
				
		String time = format1.format(today);
		
		if(date == null)
			date = time;
		
		model.addAttribute("date", date);
		model.addAttribute("houselist",houseService.getHouseList(date));
		
		if(id != null) {
			model.addAttribute("house",houseService.getHouse(id));
		}
		return "index";
	}
	
	@GetMapping("/house_reg")
	public String house_reg(){
		
		return "house_reg";
	}
	@PostMapping("/house_reg")
	public String house_reg(House house) throws IOException {
		
		System.out.println("Asdsas");
		
	    return "redirect:/index";
	}
}
