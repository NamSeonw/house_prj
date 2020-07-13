package com.houseprj.web.service;

import java.util.List;

import com.houseprj.web.entity.House;

public interface HouseService{

	List<House> getHouseList();
	
	List<House> getHouseList(String date);
	
	House getHouse(int id);
	
	int insert(House house);
	
}
