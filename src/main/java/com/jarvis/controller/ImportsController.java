package com.jarvis.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.jarvis.dto.BondDTO;
import com.jarvis.dto.BondImportDTO;
import com.jarvis.dto.CompareBondStockDTO;
import com.jarvis.dto.CompareHistoryDataDTO;
import com.jarvis.dto.ExtTransactionElementDTO;
import com.jarvis.dto.ExtTransactionValuesDTO;
import com.jarvis.dto.MarketDataFileDTO;
import com.jarvis.dto.StockDTO;
import com.jarvis.dto.PortfolioDTO;
import com.jarvis.dto.StockPerformanceDTO;
import com.jarvis.dto.StockPerformancePairDTO;
import com.jarvis.dto.WeekToWeekStockCompareDTO;
import com.jarvis.entity.MarketData;
import com.jarvis.entity.ResModel;
import com.jarvis.service.ImportsService;

@Controller
@RequestMapping("/JarvisV2")
public class ImportsController {

	@Autowired
	ImportsService service;
	
	@RequestMapping(value="/uploadFile", method = RequestMethod.POST)
	public String uploadFile(ModelMap model, @RequestParam("metaDataName") String metaDataName, @RequestParam("myfile") MultipartFile file) {
		System.out.println("metaDataName = " + metaDataName);
		System.out.println("myfile = " + file);
		
		MarketDataFileDTO fileImportDTO = new MarketDataFileDTO();
		fileImportDTO.setFileName(file.getOriginalFilename());
		fileImportDTO.setMetaDataName(metaDataName);
		try {
			fileImportDTO.setFileData(file.getBytes());
			ResModel res=service.importFile(fileImportDTO );
			System.out.println("Res---"+res.getMsg());
			if(res.getMsg().equalsIgnoreCase("File imported successfully.")) {
			//System.out.println("File imported successfully.");
			model.addAttribute("successMsg", res.getMsg());
			model.addAttribute("color", "green");
		}else {
			model.addAttribute("successMsg", res.getMsg());
			model.addAttribute("color", "red");
		}
		} catch (Exception e) {
			e.printStackTrace();
		
		}
		/*	service.importFile(fileImportDTO );
			System.out.println("File imported successfully.");
			model.addAttribute("successMsg", "File imported successfully.");
			model.addAttribute("color", "green");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("successMsg", "File not imported. Please try again.");
			model.addAttribute("color", "red");
		}
		*/
		return "imports";
	}
	
	@RequestMapping(value="/uploadFileEveryThing", method = RequestMethod.POST)
	public String uploadFileEveryThing(ModelMap model, @RequestParam("metaDataName") String metaDataName, @RequestParam("myfile") MultipartFile file) {
		System.out.println("metaDataName = " + metaDataName);
		System.out.println("myfile = " + file);
		
		MarketDataFileDTO fileImportDTO = new MarketDataFileDTO();
		fileImportDTO.setFileName(file.getOriginalFilename());
		fileImportDTO.setMetaDataName(metaDataName);
		try {
			fileImportDTO.setFileData(file.getBytes());
			ResModel res=service.importFile(fileImportDTO );
			System.out.println("Res---"+res.getMsg());
			if(res.getMsg().equalsIgnoreCase("File imported successfully.")) {
			//System.out.println("File imported successfully.");
			model.addAttribute("successMsg", res.getMsg());
			model.addAttribute("color", "green");
		}else {
			model.addAttribute("successMsg", res.getMsg());
			model.addAttribute("color", "red");
		}
		} catch (Exception e) {
			e.printStackTrace();
		
		}

		/*	service.importFile(fileImportDTO );
			System.out.println("File imported successfully.");
			model.addAttribute("successMsg", "File imported successfully.");
			model.addAttribute("color", "green");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("successMsg", "File not imported. Please try again.");
			model.addAttribute("color", "red");
		}*/
		
		return "everythingimport";
	}
	
	@RequestMapping(value="/uploadFileBondImport", method = RequestMethod.POST)
	public String uploadFileBondImport(ModelMap model, @RequestParam("metaDataName") String metaDataName, @RequestParam("myfile") MultipartFile file) {
		System.out.println("metaDataName = " + metaDataName);
		System.out.println("myfile = " + file);
		
		MarketDataFileDTO fileImportDTO = new MarketDataFileDTO();
		fileImportDTO.setFileName(file.getOriginalFilename());
		fileImportDTO.setMetaDataName(metaDataName);
		try {
			fileImportDTO.setFileData(file.getBytes());
			ResModel res=service.importFile(fileImportDTO );
			System.out.println("Res---"+res.getMsg());
			if(res.getMsg().equalsIgnoreCase("File imported successfully.")) {
			//System.out.println("File imported successfully.");
			model.addAttribute("successMsg", res.getMsg());
			model.addAttribute("color", "green");
		}else {
			model.addAttribute("successMsg", res.getMsg());
			model.addAttribute("color", "red");
		}
		} catch (Exception e) {
			e.printStackTrace();
		
		}

			/*service.importFile(fileImportDTO );
			System.out.println("File imported successfully.");
			model.addAttribute("successMsg", "File imported successfully.");
			model.addAttribute("color", "green");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("successMsg", "File not imported. Please try again.");
			model.addAttribute("color", "red");
		} */
		
		return "bondimport";
	}
	@RequestMapping(value="/uploadFileTickerImport", method = RequestMethod.POST)
	public String uploadFileTickerImport(ModelMap model, @RequestParam("metaDataName") String metaDataName, @RequestParam("myfile") MultipartFile file) {
		System.out.println("metaDataName = " + metaDataName);
		System.out.println("myfile = " + file);
		
		MarketDataFileDTO fileImportDTO = new MarketDataFileDTO();
		fileImportDTO.setFileName(file.getOriginalFilename());
		fileImportDTO.setMetaDataName(metaDataName);
		try {
			fileImportDTO.setFileData(file.getBytes());
			ResModel res=service.importFile(fileImportDTO );
			System.out.println("Res---"+res.getMsg());
			if(res.getMsg().equalsIgnoreCase("File imported successfully.")) {
			//System.out.println("File imported successfully.");
			model.addAttribute("successMsg", res.getMsg());
			model.addAttribute("color", "green");
		}else {
			model.addAttribute("successMsg", res.getMsg());
			model.addAttribute("color", "red");
		}
		} catch (Exception e) {
			e.printStackTrace();
		
		}

			/*service.importFile(fileImportDTO );
			System.out.println("File imported successfully.");
			model.addAttribute("successMsg", "File imported successfully.");
			model.addAttribute("color", "green");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("successMsg", "File not imported. Please try again.");
			model.addAttribute("color", "red");
		} */
		
		return "tickersimport";
	}
	
	
	@GetMapping(value="/findImportDatesByMonth")
	public ResponseEntity<List<BondImportDTO>> findImportDatesByMonth(@RequestParam("metaDataName") String metaDataName) {
		System.out.println("findImportDatesByMonth metaDataName = " + metaDataName);
		try {
			List<BondImportDTO> dtos = service.findImportDatesByMonth(metaDataName);
			return new ResponseEntity<List<BondImportDTO>>(dtos, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<List<BondImportDTO>>(new ArrayList<BondImportDTO>(), HttpStatus.OK);
	}
	
	@GetMapping(value="/getColumns")
	public ResponseEntity<List<ExtTransactionElementDTO>> getColumns(@RequestParam("metaDataName") String metaDataName) {
		System.out.println("getColumns metaDataName = " + metaDataName);
		try {
			List<ExtTransactionElementDTO> dtos = service.getColumns(metaDataName);
			return new ResponseEntity<List<ExtTransactionElementDTO>>(dtos, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<List<ExtTransactionElementDTO>>(new ArrayList<ExtTransactionElementDTO>(), HttpStatus.OK);
	}
	
	@PostMapping(value="/searchDebtReport")
	public ModelAndView searchDebtReport(@RequestParam("sectorList") List<String> sectorList,@RequestParam("industryList") List<String> industryList,
			@RequestParam("txtDebtEq") String txtDebtEq, @RequestParam("txtDebtEBTTM") String txtDebtEBTTM, @RequestParam("txtIntCovRatio") String txtIntCovRatio,
			@RequestParam("txtEBT") String txtEBT, @RequestParam("txtDebtEBTF") String txtDebtEBTF, @RequestParam("txtIntExp") String txtIntExp,
			@RequestParam("txtEBTF") String txtEBTF, @RequestParam("txtMktCap") String txtMktCap, @RequestParam("txtCashEq") String txtCashEq, 
			@RequestParam("txtTDebt") String txtTDebt, @RequestParam("txtEntVal") String txtEntVal, @RequestParam("txtDebtEVRatio") String txtDebtEVRatio,
			@RequestParam("txtFCF") String txtFCF, @RequestParam("txtAstCov") String txtAstCov, @RequestParam("txtDivYield") String txtDivYield, 
			@RequestParam("txtRSI") String txtRSI, @RequestParam("txtMovAvg") String txtMovAvg, @RequestParam("txtPayRatio") String txtPayRatio, 
			@RequestParam("txtOAS") String txtOAS,@RequestParam("txtYTM") String txtYTM, @RequestParam("txtSpread") String txtSpread, 
			@RequestParam("metaData") String metaData, ModelMap model, HttpServletResponse res) throws IOException{
		
		System.out.println("sectorList : " + sectorList);
		System.out.println("txtDebtEq : " + txtDebtEq);
		System.out.println("txtDebtEBTTM : " + txtDebtEBTTM);
		
		List<MarketData> list =
		service.searchDebtReport(sectorList, industryList, txtDebtEq, txtDebtEBTTM, txtIntCovRatio,
				txtEBT, txtDebtEBTF, txtIntExp,
				txtEBTF, txtMktCap, txtCashEq, txtTDebt, txtEntVal, txtDebtEVRatio,
				txtFCF, txtAstCov, txtDivYield, txtRSI, txtMovAvg, txtPayRatio, txtOAS,
				txtYTM, txtSpread, metaData);
		
		
		Gson gson = new Gson();
		model.addAttribute("searchedRows", gson.toJson(list));
		System.out.println(gson.toJson(list));
		return new ModelAndView("/imports", model);
	}
	
	@GetMapping(value="/getAllSectors")
	public ResponseEntity<List<StockDTO>> getAllSectors() {
		System.out.println("getAllSectors");
		try {
			List<StockDTO> dtos = service.getAllSectors();
			return new ResponseEntity<List<StockDTO>>(dtos, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<List<StockDTO>>(new ArrayList<StockDTO>(), HttpStatus.OK);
	}
	
	@GetMapping(value="/getAllIndustry")
	public ResponseEntity<List<StockDTO>> getAllIndustry() {
		System.out.println("getAllIndustry");
		try {
			List<StockDTO> dtos = service.getAllIndustry();
			return new ResponseEntity<List<StockDTO>>(dtos, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<List<StockDTO>>(new ArrayList<StockDTO>(), HttpStatus.OK);
	}
	
	@GetMapping(value="/getHistoricalDataByStockAndBond")
	public ResponseEntity<List<CompareBondStockDTO>> getHistoricalDataByStockAndBond(String ticker, String cusip){
		System.out.println("---- getHistoricalDataByStockAndBond -----ticker="+ticker+" cusip="+cusip);
		List<CompareBondStockDTO> list = new ArrayList();
		try {
			list = service.getHistoricalDataByStockAndBond(ticker, cusip);
		} catch (Exception e) {

			e.printStackTrace();
		}
		return new ResponseEntity<List<CompareBondStockDTO>>(list,HttpStatus.OK);
	}
	
	@GetMapping(value="/getHistoricalDataByStockAndBondForChart")
	public ResponseEntity<List<CompareBondStockDTO>> getHistoricalDataByStockAndBondForChart(String ticker, String cusip,String year,String year2){
		System.out.println("---- getHistoricalDataByStockAndBondForChart -----ticker="+ticker+" cusip="+cusip +"year="+year+"year2="+year2);
		List<CompareBondStockDTO> list = new ArrayList();
		try {
			list = service.getHistoricalDataByStockAndBondForChart(ticker, cusip,year,year2);
		} catch (Exception e) {

			e.printStackTrace();
		}
		return new ResponseEntity<List<CompareBondStockDTO>>(list,HttpStatus.OK);
	}
	
	@GetMapping(value="/getImportHistorySheetCompare")
	public ResponseEntity<StockPerformancePairDTO> getImportHistorySheetCompare(String metadataName, String date1, String date2){
		System.out.println("---- getImportHistorySheetCompare -----metadataName="+metadataName+" date1="+date1 +"date2="+date2);
		//List<StockPerformancePairDTO> list = new ArrayList();
		StockPerformancePairDTO list=new StockPerformancePairDTO();
		try {
			list = service.getImportHistorySheetCompare(metadataName, date1,date2);
		} catch (Exception e) {

			e.printStackTrace();
		}
		return new ResponseEntity<StockPerformancePairDTO>(list,HttpStatus.OK);
	}
	
	@GetMapping(value="/getStockRanking")
	public ResponseEntity <List<StockPerformanceDTO>> getStockRanking(String metadataName){
		//System.out.println("---- Controller getStockRanking -----");
		//return new MarketDataService().getStockRanking(metadataName);
		System.out.println("---- getStockRanking -----metadataName="+metadataName);
		List<StockPerformanceDTO> list = new ArrayList();
		try {
			list = service.getStockRanking(metadataName);
		} catch (Exception e) {

			e.printStackTrace();
		}
		return new ResponseEntity<List<StockPerformanceDTO>>(list,HttpStatus.OK);
	}
	
	@GetMapping(value="/getCalculateBond")
	public ResponseEntity <List<ExtTransactionValuesDTO>> getCalculateBond(String couponMin, String couponMax, String ytwMin, String ytwMax, String maturityMin, String maturityMax,
			String rating, String callable, String secured,String treasuryYr, String treasuryYield, String metadataName){
		System.out.println("---- getCalculateBond -----couponMin="+couponMin+"couponMax="+couponMax+"ytwMin="+ytwMin+"ytwMax="+ytwMax+"maturityMin="+maturityMin+"maturityMax="+maturityMax
				+"rating="+rating+"callable="+callable+"secured="+secured+"treasuryYr="+treasuryYr+"treasuryYield="+treasuryYield+"metadataName="+metadataName);
		List<ExtTransactionValuesDTO> list = new ArrayList();
		try {
		list= service.getCalculateBond(couponMin, couponMax, ytwMin, ytwMax, maturityMin, maturityMax,
				rating, callable, secured,treasuryYr,treasuryYield, metadataName);
		} catch (Exception e) {

			e.printStackTrace();
		}
		return new ResponseEntity<List<ExtTransactionValuesDTO>>(list,HttpStatus.OK);
	}
	
	
	  @GetMapping(value="/getCalculateTicker")
	  public ResponseEntity <List<ExtTransactionValuesDTO>> getCalculateTicker(String metadataName,
	  String date, String rankWithinTable, String relativeStrength, String
	  priceVs20DAvg, boolean isHighPerforming) throws Exception{
		  System.out.println("---- getCalculateTicker Controller -----metadataName="
				  +metadataName+"rankWithinTable="+rankWithinTable);
		  List<ExtTransactionValuesDTO> list = new ArrayList();
			try {
				list= service.getCalculateTicker(metadataName, date, rankWithinTable,
						  relativeStrength, priceVs20DAvg, isHighPerforming);
				} catch (Exception e) {

					e.printStackTrace();
				}
				return new ResponseEntity<List<ExtTransactionValuesDTO>>(list,HttpStatus.OK);
			}
	  

	  @GetMapping(value="/getDataByWeek")
	  public ResponseEntity <List<ExtTransactionValuesDTO>> getDataByWeek(String metadataName, String date) throws Exception{
		  System.out.println("---- getDataByWeek Controller -----metadataName="
				  +metadataName+"date="+date);
		  List<ExtTransactionValuesDTO> list = new ArrayList();
			try {
				list= service.getImportDataByWeek(metadataName, date);
				} catch (Exception e) {

					e.printStackTrace();
				}
				return new ResponseEntity<List<ExtTransactionValuesDTO>>(list,HttpStatus.OK);
			}

	  
	  @GetMapping(value="/getAllFavStocks")
		public ResponseEntity<List<StockDTO>> getAllFavStocks() {
			System.out.println("getAllFavStocks");
			try {
				List<StockDTO> dtos = service.getAllFavStocks();
				return new ResponseEntity<List<StockDTO>>(dtos, HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return new ResponseEntity<List<StockDTO>>(new ArrayList<StockDTO>(), HttpStatus.OK);
		}
	  
	  @GetMapping(value="/getAllWeeklySector")
		public ResponseEntity<List<StockDTO>> getAllWeeklySector() {
			System.out.println("getAllWeeklySector");
			try {
				List<StockDTO> dtos = service.getAllSectors();
				return new ResponseEntity<List<StockDTO>>(dtos, HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return new ResponseEntity<List<StockDTO>>(new ArrayList<StockDTO>(), HttpStatus.OK);
		}
	  
	  @GetMapping(value="/getAllStocks")
		public ResponseEntity<List<StockDTO>> getAllStocks() {
			System.out.println("getAllStocks");
			try {
				List<StockDTO> dtos = service.getAllStocks();
				return new ResponseEntity<List<StockDTO>>(dtos, HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return new ResponseEntity<List<StockDTO>>(new ArrayList<StockDTO>(), HttpStatus.OK);
		}
	  
	@GetMapping(value="/saveWeeklyStocks")
	public ResponseEntity<List<StockDTO>> saveWeeklyStocks(@RequestParam(value="userId") Long userId, 
			@RequestParam(value="myArray[]") List<String> stockNames) throws Exception{

		System.out.println("---- Imports Controller saveWeeklyStocks"+stockNames.toString() + " -- userId -- " + userId);
		 service.saveWeeklyStocks(stockNames, userId);
		 return new ResponseEntity<List<StockDTO>>(new ArrayList<StockDTO>(), HttpStatus.OK);
	}
	
	@GetMapping(value="/getHistoricalDataByStockAndDate")
	public ResponseEntity<List<CompareHistoryDataDTO>> getHistoricalDataByStockAndDate(String stockA, String stockB, String stockC, String stockD,
			String startDate,String endDate){
		
		 System.out.println("---- Imports Controller getHistoricalDataByStockAndDate "
		 		+ "--stockA-- "+stockA + " -- stockB -- " + stockB
		 		+ "--stockC-- "+stockC + " -- stockD -- " + stockD
		 		+ "--startDate-- "+startDate + " -- endDate -- " + endDate);
		 
		 List<CompareHistoryDataDTO> list = service.getHistoricalDataByStockAndDate(stockA, stockB, stockC, stockD, startDate, endDate);
		 return new ResponseEntity<List<CompareHistoryDataDTO>>(list, HttpStatus.OK);
	}
	
	
	@GetMapping(value="/findHistoricalStockDataByDateWithPercentageChange")
	public ResponseEntity<List<WeekToWeekStockCompareDTO>> findHistoricalStockDataByDateWithPercentageChange(@RequestParam(value="startDate") String startDate,@RequestParam(value="endDate") String endDate,@RequestParam(value="myArray[]") List<String> stockList){

		System.out.println("---- findHistoricalStockDataByDateWithPercentageChange"+stockList.toString() + " -- startDate -- " + startDate+"endDate-- "+endDate);
			
			 List<WeekToWeekStockCompareDTO> list =service.findHistoricalStockDataByDateWithPercentageChange(stockList,startDate,endDate);
			 return new ResponseEntity<List<WeekToWeekStockCompareDTO>>(list, HttpStatus.OK);
	}
	
	
	@GetMapping(value="/getHistoryByTicker")
	  public ResponseEntity <List<ExtTransactionValuesDTO>> getHistoryByTicker(String metadataName,String ticker) throws Exception{
		  System.out.println("---- getHistoryByTicker Controller -----metadataName="
				  +metadataName+"ticker="+ticker);
		  List<ExtTransactionValuesDTO> list = new ArrayList();
			try {
				list= service.getHistoryByTicker(metadataName,ticker);
				} catch (Exception e) {

					e.printStackTrace();
				}
				return new ResponseEntity<List<ExtTransactionValuesDTO>>(list,HttpStatus.OK);
			}
	
	
	@GetMapping(value="/getAllTicker")
	public ResponseEntity <List<ExtTransactionValuesDTO>> getAllTicker(String metadataName){
		//System.out.println("---- Controller getStockRanking -----");
		//return new MarketDataService().getStockRanking(metadataName);
		System.out.println("---- getAllTicker -----metadataName="+metadataName);
		List<ExtTransactionValuesDTO> list = new ArrayList();
		try {
			list = service.getAllTicker(metadataName);
		} catch (Exception e) {

			e.printStackTrace();
		}
		return new ResponseEntity<List<ExtTransactionValuesDTO>>(list,HttpStatus.OK);
	}
	
	
	@GetMapping("/getBondRealData")
	public ResponseEntity<List<MarketData>> getBondRealData(@RequestParam("type") String type){
		System.out.println("In getBondRealData for "+type);
		List<MarketData> list = service.getBondRealData(type);//service.getAllMarketData();
		
		return new ResponseEntity<List<MarketData>>(list,HttpStatus.OK);
	}

	@GetMapping(value="/getChartForHistoryByTicker")
	  public ResponseEntity <List<ExtTransactionValuesDTO>> getChartForHistoryByTicker(String metadataName,String ticker,String year,String year2) throws Exception{
		  System.out.println("---- getChartForHistoryByTicker Controller -----metadataName="
				  +metadataName+"ticker="+ticker);
		  List<ExtTransactionValuesDTO> list = new ArrayList();
			try {
				list= service.getChartForHistoryByTicker(metadataName,ticker,year,year2);
				} catch (Exception e) {

					e.printStackTrace();
				}
				return new ResponseEntity<List<ExtTransactionValuesDTO>>(list,HttpStatus.OK);
			}
	

@GetMapping(value = "/getAllPortFolioTicker")
	public ResponseEntity<List<PortfolioDTO>> getAllPortFolioTicker() {
		System.out.println("getAllPortFolioTicker");
		try {
			List<PortfolioDTO> dtos = service.getAllPortFolioTicker();
			return new ResponseEntity<List<PortfolioDTO>>(dtos, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<List<PortfolioDTO>>(new ArrayList<PortfolioDTO>(), HttpStatus.OK);
	}
	@GetMapping(value = "/getPortFolioStockSet")
	public ResponseEntity<List<MarketData>> getPortFolioStockSet(@RequestParam("idPortfolio") Long idPortfolio) {
		System.out.println("getPortFolioStockSet");
		try {
			List<MarketData> dtos = service.getPortFolioStockSet(idPortfolio);
			return new ResponseEntity<List<MarketData>>(dtos, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<List<MarketData>>(new ArrayList<MarketData>(), HttpStatus.OK);
	}
	
	
	/*
	 * public List<ExtTransactionValuesDTO> getHistoryByTicker(String metaDataName,
	 * String ticker) {
	 * System.out.println("---- FileImportIntegrator getHistoryByTicker -----");
	 * return new FileImportService().getHistoryByTicker(metaDataName, ticker); }
	 */
		
	  
	  
	/*  @GetMapping(value="/getWeeklyAllStocks")
	  public ResponseEntity<List<?>> getWeeklyAllStocks(String marketDataType, Long userId, Set<?> dTOList) throws Exception{
		  
		  System.out.println("getAllFavStocks");
			try {
				if(marketDataType.equalsIgnoreCase("Stocks")){
					return   (ResponseEntity<List<?>>) service.mapStocksWithUser(userId, (Set<StockDTO>)dTOList);
				}else if(marketDataType.equalsIgnoreCase("Bonds")){
					return  (ResponseEntity<List<?>>) service.mapBondsWithUser(userId, (Set<BondDTO>)dTOList);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return new ResponseEntity<List<?>>(new ArrayList<>(), HttpStatus.OK);
		}
			*/
			
			
}
