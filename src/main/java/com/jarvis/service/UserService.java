package com.jarvis.service;

import java.util.List;

import com.jarvis.dto.Login;
import com.jarvis.entity.MarketData;
import com.jarvis.entity.User;

public interface UserService {
	public List<User> getAllUser();
	public Integer createUser(User user);
	public User isAuthenticate(Login luser);
	public List<MarketData> getAllMarketData();
	public List<MarketData> getAllMarketDataByDate(String metadataName, String date);

}
