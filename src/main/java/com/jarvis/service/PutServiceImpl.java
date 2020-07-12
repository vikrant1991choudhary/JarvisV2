package com.jarvis.service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jarvis.dao.PutDAORepository;
import com.jarvis.entity.Call;
import com.jarvis.entity.Put;

@Service
public class PutServiceImpl implements PutService {
	
	@Autowired
	PutDAORepository putDao;

	@Override
	public List<Put> getAllPutsByTickerName(String tickerName) {
		System.out.println("Start putService tickername: "+tickerName);
		List<Put> results = new ArrayList<Put>();
		results = putDao.findAllPutByTickerName(tickerName);
		System.out.println("End PutService");
		return results;
	}

	
	@Override
	public List<String> findAllDatesPut() {
		System.out.println("Start findAllDates");
		List<String> results = new ArrayList<String>();
		results = putDao.findAllDatesPuts();
		System.out.println("End findAllDates");
		return results;
	}

	@Override
	public List<Put> findPutDataByDate(String date) {
		System.out.println("Start findPutDataByDate date: "+date);
		List<Put> results = new ArrayList<Put>();
		results = putDao.findPutDataByDate(date);
		System.out.println("End findPutDataByDate");
		return results;
	}

	@Override
	public List<Put> savePutData(List<Put> puts) {
		System.out.println("Start savePutData");
		List<Put> putsreturn = new ArrayList<Put>();
		for(Put put: puts) {
			putsreturn.add(putDao.save(put));
		}
		System.out.println("End savePutData");
		return putsreturn;
	}
}
