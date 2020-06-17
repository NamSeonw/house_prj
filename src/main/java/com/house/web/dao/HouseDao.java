package com.house.web.dao;

import java.util.List;

import com.house.web.entity.House;

public interface HouseDao {
	List<House> getHouseList();
	
	List<House> getHouseList(String date);
	
	House getHouse(int id);
	
	int insert(House house);
	
}
