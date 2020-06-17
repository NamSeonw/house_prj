package com.house.web.dao.mybatis;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.house.web.dao.HouseDao;
import com.house.web.entity.House;

@Repository
public class MybatisHouseDao implements HouseDao{
	
	private SqlSession sqlSession;
	private HouseDao mapperDao;
	
	@Autowired
	public MybatisHouseDao(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
		mapperDao = sqlSession.getMapper(HouseDao.class);
	}

	@Override
	public List<House> getHouseList() {
		return mapperDao.getHouseList();
	}

	@Override
	public List<House> getHouseList(String date) {
		// TODO Auto-generated method stub
		return mapperDao.getHouseList(date);
	}

	@Override
	public House getHouse(int id) {
		// TODO Auto-generated method stub
		return mapperDao.getHouse(id);
	}

	@Override
	public int insert(House house) {
		return mapperDao.insert(house);
	}
}
