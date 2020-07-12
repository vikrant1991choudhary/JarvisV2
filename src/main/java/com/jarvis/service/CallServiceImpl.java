package com.jarvis.service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jarvis.dao.CallDAORepository;
import com.jarvis.entity.Call;

@Service
public class CallServiceImpl implements CallService {
	
	@Autowired
	SessionFactory sessionFactory;
	 

	@Autowired
	CallDAORepository callDao;

	@Override
	public List<Call> getAllCallsByTickerName(String tickerName) {
		System.out.println("Start CallService");
		List<Call> results = new ArrayList<Call>();
		results = callDao.findAllCallsByTickerName(tickerName);
		System.out.println("End CallService");
		return results;
	}

	@Override
	public List<String> getAllDates() {
		
		System.out.println("Start findAllDates");
		List<String> dates = new ArrayList<>();
		dates = callDao.findAllDates();
		System.out.println("End findAllDates");
		return dates;
	}

	@Override
	public List<Call> findCallDataByDate(String date) {
		System.out.println("Start findCallDataByDate");
		List<Call> calls = new ArrayList<>();
		calls = callDao.findCallDataByDate(date);
		System.out.println("End findCallDataByDate");
		return calls;
	}

	@Override
	public List<Call> save(List<Call> calls) {
		System.out.println("Start Savecall");
		List<Call> returncalls = new ArrayList<>();
		for(Call call : calls) {
			returncalls.add(callDao.save(call));
		}
		System.out.println("End Savecall");
		return returncalls;
	}

}
