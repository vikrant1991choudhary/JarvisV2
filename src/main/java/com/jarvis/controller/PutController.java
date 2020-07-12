package com.jarvis.controller;

import java.io.BufferedInputStream;
import java.io.InputStream;
import java.net.URL;
import java.text.DecimalFormat;
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
import com.jarvis.entity.Put;
import com.jarvis.service.PutService;

@Controller
@RequestMapping("/JarvisV2")
public class PutController {

	@Autowired
	PutService putService;
	
	@Autowired
	MarketDataDAORepository marketdata;
	
	@GetMapping(value="/findAllPutsByTickerName")
	public ResponseEntity<List<Put>> findAllPutssByTickerName(@RequestParam("tickername") String tickername) {
		System.out.println("findAllPutssByTickerName tickername = " + tickername);
		try {
			List<Put> puts = putService.getAllPutsByTickerName(tickername);
			return new ResponseEntity<List<Put>>(puts, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<List<Put>>(new ArrayList<Put>(), HttpStatus.OK);
	}
	
	
	@GetMapping(value = "/findAllDatesPut")
	public ResponseEntity<List<String>> findAllDatesPut() {
		System.out.println("Start findAllDatesPut controller");
		try {
			List<String> dates = putService.findAllDatesPut();
			return new ResponseEntity<List<String>>(dates, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<List<String>>(new ArrayList<String>(), HttpStatus.OK);
	}
	 
	
	@GetMapping(value="/findPutDataByDate")
	public ResponseEntity<List<Put>> findPutDataByDate(@RequestParam("date") String date) {
		System.out.println("findPutDataByDate date = " + date);
		try {
			List<Put> puts = putService.findPutDataByDate(date);
			return new ResponseEntity<List<Put>>(puts, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<List<Put>>(new ArrayList<Put>(), HttpStatus.OK);
	}

	@PostMapping(value = "/savePuts")
	public ResponseEntity<List<Put>> savePuts(@RequestBody List<Put> puts) {
		System.out.println("savePuts controller");
		try {
			List<Put> putsresult = putService.savePutData(puts);
			return new ResponseEntity<List<Put>>(putsresult, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<List<Put>>(new ArrayList<Put>(), HttpStatus.OK);
	}
	
	@PostMapping("/getCalculatedPutData")
	public ResponseEntity<Put> getCalculatedData(@RequestParam("tickername") String ticker,
			@RequestParam("strikeprice") String strikeprice, @RequestParam("putprice") String putprice,
			@RequestParam("expdate") String expdate) {
		Put put = new Put();
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
				
				put.setStockPrice(tokens[4]);	//Set Stoke price
				stokePricenum = Float.parseFloat(tokens[4]);
				
				put.setStockNameTicker(ticker); // Set StockName
				put.setStrikePrice(strikeprice); // Set Strikeprice
				put.setPutPrice(putprice); // Set putPrice
				put.setExpirationDate(expdate); // SetExpirationDate
				
				 Date date2 = myFormat.parse(inputString2);
				 long diff = date2.getTime() - today.getTime();
				 //System.out.println ("Days: " + TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS));
				 put.setDaysExpiration(String.valueOf(TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS))); //setDays to expire

				float reqIncreasenum = ((Float.parseFloat(strikeprice)*100*10)); // Calculate Required Increment
				put.setReqIncrease(String.valueOf(reqIncreasenum)); // set Required Increment

				float breakEven = (Float.parseFloat(strikeprice)-Float.parseFloat(putprice));
				put.setBreakEven(String.valueOf(breakEven));
				
				float downsideProtection = ((breakEven/Float.parseFloat(strikeprice)-1)*100);
				put.setDownProtection(String.valueOf(downsideProtection)); //Set down side protection

				/*
				 * float percentage = (((breakEven / stokePricenum) - 1) * 100);
				 * put.setPercentage(String.valueOf(percentage));
				 */
				float laverageRatio = (Float.parseFloat(strikeprice)/Float.parseFloat(putprice));
				put.setLeverageRatio(String.valueOf(laverageRatio));

				/*
				 * float costofTencalls = (Float.parseFloat(putprice) * 1000);
				 * put.se(String.valueOf(costofTencalls));
				 */
				
				float incomePotential = (Float.valueOf(putprice)*100*10);
				put.setIncomePotential(String.valueOf(incomePotential));	//Set Income potentials
				
				float incomePerday = (incomePotential/Integer.valueOf(put.getDaysExpiration()));
				put.setIncomePerDay(String.valueOf(incomePerday));
				
				//float anualPremium = (((1/(Integer.parseInt(put.getDaysExpiration())/365)*incomePotential)/reqIncreasenum)*100);
				float anualPremium = (float) (((1.0/(Float.parseFloat(put.getDaysExpiration())/365)*incomePotential)/reqIncreasenum)*100);
				put.setAnnualPremium(String.valueOf(anualPremium));	//Set Anual premium
				
				put.setRank(marketdata.findRankingByStockName(ticker)); //Set rank
				put.setLastUpdatedAt(new Date());
				
				return new ResponseEntity<Put>(put,HttpStatus.OK);
			}


		} catch (Exception e1) {
			e1.printStackTrace();
		}
		 
	return new ResponseEntity<Put>(put,HttpStatus.OK);
		  
	}
}
