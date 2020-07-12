package com.jarvis.controller;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.apache.http.util.ByteArrayBuffer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jarvis.dao.MarketDataDAORepository;
import com.jarvis.dto.ExtTransactionValuesDTO;
import com.jarvis.entity.Call;
import com.jarvis.service.CallService;

@Controller
@RequestMapping("/JarvisV2")
public class CallController {

	@Autowired
	CallService callService;
	
	@Autowired
	MarketDataDAORepository marketdata;

	@GetMapping(value = "/findAllCallsByTickerName")
	public ResponseEntity<List<Call>> findAllCallsByTickerName(@RequestParam("tickername") String tickername) {
		System.out.println("findAllCallsByTickerName tickername = " + tickername);
		try {
			List<Call> calls = callService.getAllCallsByTickerName(tickername);
			return new ResponseEntity<List<Call>>(calls, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<List<Call>>(new ArrayList<Call>(), HttpStatus.OK);
	}

	@GetMapping(value = "/findAllDates")
	public ResponseEntity<List<String>> findAllDates() {
		System.out.println("findAllDates Controller start");
		try {
			List<String> dates = callService.getAllDates();
			return new ResponseEntity<List<String>>(dates, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<List<String>>(new ArrayList<String>(), HttpStatus.OK);
	}

	@GetMapping(value = "/findCallDataByDate")
	public ResponseEntity<List<Call>> findCallDataByDate(@RequestParam("date") String date) {
		System.out.println("findCallDataByDate Controller start");
		try {
			List<Call> calls = callService.findCallDataByDate(date);
			return new ResponseEntity<List<Call>>(calls, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<List<Call>>(new ArrayList<Call>(), HttpStatus.OK);
	}

	@PostMapping(value = "/saveCalls")
	public ResponseEntity<List<Call>> saveCalls(@RequestBody List<Call> calls) {
		System.out.println("saveCalls Controller start");
		List<Call> savedCalls = new ArrayList<>();
		try {
			savedCalls = callService.save(calls);
			return new ResponseEntity<List<Call>>(savedCalls, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<List<Call>>(new ArrayList<Call>(), HttpStatus.OK);
	}

	@PostMapping("/getCalculatedData")
	public ResponseEntity<Call> getCalculatedData(@RequestParam("tickername") String ticker,
			@RequestParam("strikeprice") String strikeprice, @RequestParam("callprice") String callprice,
			@RequestParam("expdate") String expdate) {
		Call call = new Call();
		DecimalFormat df = new DecimalFormat("00000.00");
		df.setMaximumFractionDigits(2);
		float stokePricenum = 0;
		
		String urlStr = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol="+ticker+"&interval=30min&apikey=TY1WA5LN5KU3SQIV&datatype=csv";
		URL url;
		List<ExtTransactionValuesDTO> dtoList = new ArrayList<ExtTransactionValuesDTO>();
		
		SimpleDateFormat myFormat = new SimpleDateFormat("MM/dd/yyyy");
		String inputString2 = expdate;
		Date today = new Date();
		try {
			url = new URL(urlStr);

			InputStream stream = url.openStream();
			BufferedInputStream bis = new BufferedInputStream(stream);
			ByteArrayBuffer bab = new ByteArrayBuffer(50);

			int current = 0;
			while((current = bis.read()) != -1){
				bab.append((byte) current);
			}
			String stockTxt = new String(bab.toByteArray());
			//log.error(stockTxt);
			String[] outerTokens = stockTxt.split("\n");

			//log.error("outerTokens.length --> "+outerTokens.length);
			
			for (int a1 = 1; a1 < 2; a1++) {

				String[] tokens = outerTokens[a1].split(",");
				for (int i = 0; i < 1; i++) {

					if(tokens[i].startsWith("\"")){
						tokens[i] = tokens[i].substring(1, tokens[i].length() -1);
						if(i==tokens.length - 1){
							tokens[i] = tokens[i].substring(1, tokens[i].length() -3);
						}
					}
				}
				
				ExtTransactionValuesDTO extTransactionValuesDTO = new ExtTransactionValuesDTO();
				
				call.setStockPrice(tokens[4]);	//Set Stoke price
				stokePricenum = Float.parseFloat(tokens[4]);
				
				call.setStockNameTicker(ticker); // Set StockName
				call.setStrikePrice(strikeprice); // Set Strikeprice
				call.setCallPrice(callprice); // Set CallPrice
				call.setExpirationDate(expdate); // SetExpirationDate
				
				 Date date2 = myFormat.parse(inputString2);
				 long diff = date2.getTime() - today.getTime();
				 //System.out.println ("Days: " + TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS));
				 call.setDaysExpiration(String.valueOf(TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS))); //setDays to expire

				float reqIncreasenum = ((Float.parseFloat(callprice)+ Float.parseFloat(strikeprice)) - stokePricenum); // Calculate Required Increment
				call.setReqIncrease(String.valueOf(reqIncreasenum)); // set Required Increment

				float breakEven = (Float.parseFloat(callprice) + Float.parseFloat(strikeprice));
				call.setBreakEven(String.valueOf(breakEven));

				float percentage = (((breakEven / stokePricenum) - 1) * 100);
				call.setPercentage(String.valueOf(percentage));

				float laverageRatio = (Float.parseFloat(strikeprice)/Float.parseFloat(callprice));
				call.setLeverageRatio(String.valueOf(laverageRatio));

				float costofTencalls = (Float.parseFloat(callprice) * 1000);
				call.setCostofTenCalls(String.valueOf(costofTencalls));
				
				call.setRank(marketdata.findRankingByStockName(ticker));
				call.setLastUpdatedAt(new Date());
				return new ResponseEntity<Call>(call,HttpStatus.OK);
			}


		} catch (Exception e1) {
			e1.printStackTrace();
		}
		 
	return new ResponseEntity<Call>(call,HttpStatus.OK);
		  
	}

}
