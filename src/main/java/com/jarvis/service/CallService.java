package com.jarvis.service;

import java.util.List;

import com.jarvis.dto.CallDTO;
import com.jarvis.dto.ExtTransactionValuesDTO;
import com.jarvis.entity.Call;

public interface CallService {

	public List<Call> getAllCallsByTickerName(String tickerName);
	public List<String> getAllDates();
	public List<Call> findCallDataByDate(String date);
	public List<Call> save(List<Call> call);
}
