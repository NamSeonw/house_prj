package com.houseprj.web.service.implement;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.houseprj.web.dao.HouseDao;
import com.houseprj.web.entity.House;
import com.houseprj.web.service.HouseService;

@Service
public class HouseServiceImpl implements HouseService{

	@Autowired
	private HouseDao houseDao;

	@Override
	public List<House> getHouseList() {
		// TODO Auto-generated method stub
		return houseDao.getHouseList();
	}

	@Override
	public List<House> getHouseList(String date) {
		// TODO Auto-generated method stub
		return houseDao.getHouseList(date);
	}

	@Override
	public House getHouse(int id) {
		// TODO Auto-generated method stub
		return houseDao.getHouse(id);
	}

	@Override
	public int insert(House house) {
		// TODO Auto-generated method stub
		return houseDao.insert(house);
	}
}
