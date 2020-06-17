package com.house.web.service;

import java.util.List;

import com.house.web.entity.House;

public interface HouseService{

	List<House> getHouseList();
	
	List<House> getHouseList(String date);
	
	House getHouse(int id);
	
	int insert(House house);
	
}
