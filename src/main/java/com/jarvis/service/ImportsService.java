package com.jarvis.service;

import java.util.List;
import java.util.Set;

import com.jarvis.dto.BondDTO;
import com.jarvis.dto.BondImportDTO;
import com.jarvis.dto.CompareBondStockDTO;
import com.jarvis.dto.CompareHistoryDataDTO;
import com.jarvis.dto.ExtTransactionElementDTO;
import com.jarvis.dto.ExtTransactionValuesDTO;
import com.jarvis.dto.MarketDataFileDTO;
import com.jarvis.dto.StockDTO;
import com.jarvis.dto.StockPerformanceDTO;
import com.jarvis.dto.StockPerformancePairDTO;
import com.jarvis.dto.WeekToWeekStockCompareDTO;
import com.jarvis.entity.MarketData;
import com.jarvis.entity.ResModel;
import com.jarvis.entity.User;
import com.jarvis.dto.PortfolioDTO;

public interface ImportsService {

	public ResModel importFile(MarketDataFileDTO fileImportDTO) throws Exception;
	public List<BondImportDTO> findImportDatesByMonth(String metaDataName) throws Exception;
	public List<ExtTransactionElementDTO> getColumns(String metaDataName) throws Exception;
	public List<MarketData> searchDebtReport(List<String> sectorList, List<String> industryList,
			String txtDebtEq, String txtDebtEBTTM, String txtIntCovRatio, String txtEBT, String txtDebtEBTF,
			String txtIntExp, String txtEBTF, String txtMktCap, String txtCashEq, String txtTDebt, String txtEntVal,
			String txtDebtEVRatio, String txtFCF, String txtAstCov, String txtDivYield, String txtRSI, String txtMovAvg,
			String txtPayRatio, String txtOAS, String txtYTM, String txtSpread, String metaData);
	
	public List<StockDTO> getAllSectors();
	public List<StockDTO> getAllIndustry();
	List<CompareBondStockDTO> getHistoricalDataByStockAndBond(String ticker, String cusip);
	
	List<CompareBondStockDTO> getHistoricalDataByStockAndBondForChart(String ticker, String cusip,String year,String year2);
	
	public StockPerformancePairDTO getImportHistorySheetCompare(String metadataName,String date1,String date2);
	public List<StockPerformanceDTO> getStockRanking(String metadataName);
	public List<ExtTransactionValuesDTO> getCalculateBond(String couponMin, String couponMax, String ytwMin, String ytwMax, String maturityMin, String maturityMax,
			String rating, String callable, String secured, String treasuryYr, String treasuryYield, String metadataName);
	public List<MarketData> findImportDataByWeek(String metadataName, String date);
	public List<ExtTransactionValuesDTO> getCalculateTicker(String metadataName,
			  String date, String rankWithinTable, String relativeStrength, String
			  priceVs20DAvg, boolean isHighPerforming);
	public List<MarketData> findStockWith3ConsecutiveRank(String metadata, String date, Double rankWithInTable, 
			Double relativeStrength, Double priceV20DAvg, boolean isHighPerforming);
	
	public List<ExtTransactionValuesDTO> getValuesDTODFromBulkTxnList(List<MarketData> list);
	
	public List<ExtTransactionValuesDTO> getImportDataByWeek(String metadataName,String date);
	public List<StockDTO> getAllFavStocks();
	
	public List<StockDTO> getAllWeeklySector();
	public void saveWeeklyStocks(List<String> stockNames, Long userId);
	//public List<StockDTO> mapStocksWithUser(Long userId, Set<StockDTO> stockDTOList) throws Exception;
	//public List<BondDTO> mapBondsWithUser(Long userId, Set<BondDTO> bondDTOList) throws Exception;
	List<StockDTO> getAllStocks();
	List<CompareHistoryDataDTO> getHistoricalDataByStockAndDate(String stockA, String stockB, String stockC,
			String stockD, String startDate, String endDate);
	public List<WeekToWeekStockCompareDTO> findHistoricalStockDataByDateWithPercentageChange(List<String> stockList,String startDate,String endDate);
	
	public List<ExtTransactionValuesDTO> getHistoryByTicker(String metaDataName, String ticker);
	
	public List<ExtTransactionValuesDTO> getAllTicker(String metaDataName);
	public List<MarketData> getBondRealData(String type);
		public List<ExtTransactionValuesDTO> getChartForHistoryByTicker(String metaDataName, String ticker,String year,String year2);

	public List<PortfolioDTO> getAllPortFolioTicker();
	public List<MarketData> getPortFolioStockSet(Long idPortfolio);

}
