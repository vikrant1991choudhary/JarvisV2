package com.jarvis.service;

import java.io.FileInputStream;
import java.io.InputStream;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.RichTextString;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.type.BooleanType;
import org.hibernate.type.LongType;
import org.hibernate.type.StringType;
import org.hibernate.type.Type;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jarvis.common.Constants;
import com.jarvis.dao.MarketDataDAORepository;
import com.jarvis.dao.MarketDataFileDAORepository;
import com.jarvis.dao.MarketHistoryDAORepository;
import com.jarvis.dao.MetaDataDAORepository;
import com.jarvis.dao.StockDAORepository;
import com.jarvis.dao.UserDAORepository;
import com.jarvis.dao.PortfolioDAORepository; 
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
import com.jarvis.entity.Bond;
import com.jarvis.entity.MarketData;
import com.jarvis.entity.MarketDataFile;
import com.jarvis.entity.MarketHistoryData;
import com.jarvis.entity.MetaData;
import com.jarvis.entity.Stock;
import com.jarvis.entity.ResModel;
import com.jarvis.entity.User;
import com.jarvis.entity.Portfolio;
import com.jarvis.util.CommonUtil;
import com.jarvis.util.ExcelParserUtil;
import com.jarvis.util.StockComparator;
import com.jarvis.util.Utility;
import com.jarvis.dto.PortfolioDTO;
	

@Service
public class ImportsServiceImpl implements ImportsService {
	
	@Autowired
	//static
	SessionFactory sessionFactory;
	
	@Autowired
	MarketDataDAORepository marketDataDao;
	
	@Autowired
	MarketDataFileDAORepository marketDataFileDao;
	
	@Autowired
	MetaDataDAORepository metaDataDao;
	
	@Autowired
	StockDAORepository stockDao;
	@Autowired
	UserDAORepository userDAORepository;
	
	@Autowired
	MarketHistoryDAORepository marketHistoryDataDao;
	@Autowired
	PortfolioDAORepository portfolioDAORepository;
	
	
	static Class class1 = null;
	static{
 
		try {
			class1 = Class.forName("com.jarvis.entity.MarketData");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	@Override
	public ResModel importFile(MarketDataFileDTO fileImportDTO) throws Exception {
		ResModel res=new ResModel();
		String metadataName = fileImportDTO.getMetaDataName();
		String fileName = fileImportDTO.getFileName();
		if(isMetadataNameDuplicate(fileName)){
			throw new Exception("File Name Already exists.");
		}

		boolean retFlag = false;

		System.out.println("metadataName --> "+metadataName);

		List<MetaData> metaDataList = new ArrayList<MetaData>();
		metaDataList = metaDataDao.findByMetadataName(metadataName);

		//Collections.sort(metaDataList);
		List<MarketData> bulkList = new ArrayList<MarketData>();
		//String fileLocation = fileImportDTO.getFileLocation();
		/* Vikrant Change */
		String fileLocation = Utility.saveFileInServer(Constants.FileInServer,fileImportDTO.getFileData(), fileImportDTO.getFileName());

		List<String> headerList = ExcelParserUtil.getHeadersOfExcelForMetadata(fileLocation);
		Map<Integer, String> orderedMap = new LinkedHashMap<Integer, String>();
		orderedMap = ExcelParserUtil.getOrderedMapForHeader();
		boolean isSuccess = true;
		String msg="File not imported. Please change below Header Value(s) in Excel."+ "<br>" ;
		for(int c =0 ; c < metaDataList.size(); c++){
			MetaData data = metaDataList.get(c);
			String dbHeaderVal = data.getElement();
			String headerVal = orderedMap.get(c);
			System.out.println("dbHeaderVal = " + dbHeaderVal + " headerVal = " + headerVal);
			if(!dbHeaderVal.equalsIgnoreCase(headerVal)){
				//System.out.println("Mismatch ....");
				if( "Price Change ($)".equals(dbHeaderVal) && "Price Chg. ($)".equals(headerVal)
						|| "Price Change ($)".equals(dbHeaderVal) && "Price Chg. ($)".equals(headerVal) 
						|| "Price Change (%)".equals(dbHeaderVal) && "Price Chg. (%)".equals(headerVal)
						|| "Price / Free Cash Flow".equals(dbHeaderVal) && "FCF".equals(headerVal)) {
					
				}else {
				msg = msg+" from "+headerVal;
				msg = msg+" to "+dbHeaderVal+ "<br>" ;			
				
				isSuccess = false;
			//	throw new Exception("EXCELImport Exception : Headers are not matching with Metadata");
				//return res;
				}
			}

		}
		
		if(!isSuccess) {
			res.setMsg(msg);
			return res;
		}

		/*for(int c =0 ; c < metaDataList.size(); c++){
			MetaData data = metaDataList.get(c);
			String dbHeaderVal = data.getElement();
			String headerVal = orderedMap.get(c);
			//System.out.println("dbHeaderVal = " + dbHeaderVal + " headerVal = " + headerVal);
			if(!dbHeaderVal.equals(headerVal)){
				//System.out.println("Mismatch ....");
						System.out.println("dbHeaderVal = " + dbHeaderVal + " headerVal = " + headerVal);
				throw new Exception("EXCELImport Exception : Headers are not matching with Metadata");
			}

		} */

		InputStream inp = new FileInputStream(fileLocation);
		Workbook wb = WorkbookFactory.create(inp);

		Sheet sheet = wb.getSheetAt(0);

		Iterator<Row> rows = sheet.rowIterator();
		//List<String> headerList = new ArrayList<String>();
		List<String> txnValList = new ArrayList<String>();
		String txnVal = "";
		String header = "";
		RichTextString richTextString = null;
		Map<String, String> txnValMap = new LinkedHashMap<String, String>();
		while (rows.hasNext ())
		{
			Row row = rows.next ();
			//System.out.println ("Row No.: " + row.getRowNum () + " no. of cell = " + row.getPhysicalNumberOfCells());
			if(row.getRowNum () == 0){
				continue;
			}
			if(ExcelParserUtil.isRowEmpty(row))
				break;

			Iterator<Cell> cells = row.cellIterator();
			int x = 0;
			for(int c = 0; c < headerList.size(); c++)
			{
				Cell cell = row.getCell((short)c);

				if(metadataName.contains("Bond")){
					//System.out.println("Bond - getCellValueForBond");
					header = ExcelParserUtil.getCellValueForBond(cell);
				}
				else if(metadataName.contains("Ticker")){ // we have to do customization if we have date field in excel
					//System.out.println("Ticker - getCellValue");
					header = ExcelParserUtil.getCellValue(cell);
				}
				else{ // any type of excel import
					//System.out.println("else  - getCellValue");
					header = ExcelParserUtil.getCellValue(cell);
				}

				if(row.getRowNum () == 0 && header!=null)
					headerList.add(header);
				else if(row.getRowNum () != 0){
					txnValList.add(header);
					txnValMap.put(headerList.get(x), header);
					//System.out.println("key = " + headerList.get(x) + " val = " + header);
				}else if(cell == null){
					txnValMap.put(headerList.get(x), null);
				}
				x++;
			}

			if(row.getRowNum () != 0 ){
				MarketData marketData = new MarketData();
				for(int i = 0; i < metaDataList.size(); i++ ){
					MetaData metaData = metaDataList.get(i);
					//if(header.equals(metaData.getElement())){
					try {
						String methodName = metaData.getInternalName().replaceFirst("e", "E");
						//System.out.println("methodName = " + methodName);
						Method method = class1.getMethod("set" + methodName , String.class);
						String ll = (String) txnValMap.get(headerList.get(i));
						//System.out.println("ll---------> " + ll);
						method.invoke(marketData, ll);
						//System.out.println("Value set = " + tempVal + " for " + name);
					} catch (Exception e) {
						e.printStackTrace();
					}
					//}
					//bulkList.add(MarketData);
				}
				bulkList.add(marketData);
			}

		}


		System.out.println("bulkList size = " + bulkList.size());

		System.out.println("GOING TO INSERT .... ");
		/*
		 * double FileSize = fileName.length(); //String
		 * FileName=Double.toString(bytes);
		 * System.out.println("File Length---->"+FileSize);
		 * System.out.println("File Name---->"+fileName);
		 */

		MarketDataFile marketDataFile = new MarketDataFile();
		marketDataFile.setCreatedBy("User");
		marketDataFile.setCreatedOn(Calendar.getInstance().getTime());
		marketDataFile.setFileLocation(fileLocation);
		marketDataFile.setFileName(fileImportDTO.getFileName());
		//marketDataFile.setFileSize(new Long(fileImportDTO.getFileSize().toString()));
	//	marketDataFile.setFileSize(FileSize);
		marketDataFile.setMarketDataType("Debt_Report_Matrices");
		marketDataFile.setIsSoftDeleted("N");
		marketDataFile.setMarketDataSource("File");
		marketDataFile.setMetaDataName(fileImportDTO.getMetaDataName());

		marketDataFileDao.save(marketDataFile);

		Long fileId = (Long) marketDataFile.getIdMarketDataFile();

		/*FileImportDTO importDTO = new FileImportDTO();
		importDTO.setCreatedBy(bulkTxnFile.getCreatedBy());
		importDTO.setCreatedOn(bulkTxnFile.getCreatedOn());
		importDTO.setFileName(bulkTxnFile.getFileName());
		importDTO.setIdBulkTxnFile(fileId);*/


		System.out.println("START TIME ----- " + Calendar.getInstance().getTime());
		System.out.println("b4 hitting db");
		
		System.out.println("connectionURL = " + Constants.CONNECTION_URL);
		System.out.println("username = " + Constants.CONNECTION_U_NAME+ " password= "+Constants.CONNECTION_U_PWD);
		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			con = DriverManager.getConnection (Constants.CONNECTION_URL, Constants.CONNECTION_U_NAME, Constants.CONNECTION_U_PWD);
			//con.setAutoCommit(false);
			pstmt = con.prepareStatement("INSERT INTO MarketData(element1,element2,element3,element4,element5,element6,element7," +
					"element8,element9,element10,element11,element12,element13,element14,element15,element16,element17," +
					"element18,element19,element20,element21,element22,element23,element24,element25,element26,element27," +
					"element28,element29,element30,element31,element32,element33,element34,element35,element36,element37," +
					"element38,element39,element40,element41,element42,element43,element44,element45,element46,element47," +
					"element48,element49,element50,element51,element52,element53,element54,element55,element56,element57," +
					"element58,element59,element60,idMarketDataFile,isSoftDeleted,lastUpdatedBy,lastUpdatedAt,metadataName) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?," +
					"?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

			final int batchSize = 100;
			int count = 0;

			for (MarketData bulkTxn : bulkList) {
				//BulkTxn bulkTxn = bulkList.get(i);

				pstmt.setString(1,metadataName);

				for(int j = 1; j<=60 ; j++){
					Method method = class1.getMethod("getElement" + j);
					String val = (String)method.invoke(bulkTxn);
					//System.out.println("val = " + val);
					pstmt.setString(j, val);
				}
				pstmt.setLong(61,fileId);
				pstmt.setByte(62, new Byte("0"));
				pstmt.setString(63, "User");
				pstmt.setTimestamp(64, new java.sql.Timestamp(new Date().getTime()));
				pstmt.setString(65, fileImportDTO.getMetaDataName());

				pstmt.addBatch();

				if (++count % batchSize == 0) {
					//System.out.println("X-ing ... ");
					pstmt.executeBatch();
					//con.commit();
					pstmt.clearBatch();
				}
			}

			pstmt.executeBatch();
			//System.out.println(updateCounts.length);
			//con.commit();

			res.setMsg("File imported successfully.");
			return res;
		}
		catch(Exception e){
			System.out.println("Throwable --- " );
			e.printStackTrace();
			/*BulkTxnFile btf = BulkTxnFileDAO.findBulkTxnFileById(fileId);
			btf.setIsFileParsingSuccessful("N");
			BulkTxnFileDAO.update(btf);*/
			res.setMsg("File not imported. Please try again.");
			return res;
		}
		finally{
			pstmt.close();
			con.close();
			System.out.println("END TIME ----- " + Calendar.getInstance().getTime());
		}
	}
	
	public boolean isMetadataNameDuplicate(String meteDataName) {

		//return marketDataDao.isMetadataNameDuplicate(meteDataName);
		return false;

	}

	@Override
	public List<BondImportDTO> findImportDatesByMonth(String metaDataName) throws Exception {
		
		List<BondImportDTO> dtoList = new ArrayList<BondImportDTO>();
		
		String[] months = {"January","February","March","April","May","June","July","August","September"
				,"October","November","December"};
		List<Date> dates = marketDataFileDao.findImportDatesByMonth(metaDataName);
		
		if(!CommonUtil.isCollectionEmpty(dates)) {
		//	System.out.println("dates size --> "+dates.size());
			for (Date date : dates) {
				String dateOfImport = date.toString();
				//System.out.println(dateOfImport); 
				if(!CommonUtil.isStringEmpty(dateOfImport)){
					String dateStr = dateOfImport.split(" ")[0]; 
					Integer mon = new Integer(dateStr.split("-")[1]);
					//dateList.add(months[mon-1] + "~" + dateStr); // 2014-08-12 : we could change the pattern as MM/dd/yyyy
					BondImportDTO bondImportDTO = new BondImportDTO();
					bondImportDTO.setCheckBoxHtml("<input type=\"checkbox\" name=\"dateChkBox\" value=\"" + dateStr + "\" />");
					bondImportDTO.setYear(new Integer(Calendar.getInstance().get(Calendar.YEAR)).toString());
					bondImportDTO.setMonth(months[mon-1]);
					bondImportDTO.setImportDate(dateStr);
					dtoList.add(bondImportDTO);
					
				}
			}
		}
		return dtoList;
	}

	@Override
	public List<ExtTransactionElementDTO> getColumns(String metaDataName) throws Exception {
		
		List<ExtTransactionElementDTO> extTransactionElementDTOList = new ArrayList<ExtTransactionElementDTO>();
		List<MetaData> metaDataList = metaDataDao.findByMetadataName(metaDataName);
		
		for (MetaData metaData : metaDataList) {
			ExtTransactionElementDTO extTransactionElementDTO = new ExtTransactionElementDTO();

			extTransactionElementDTO.setElementDisplayName(metaData.getElementDisplayName());
			extTransactionElementDTO.setElementName(metaData.getElement());
			extTransactionElementDTO.setElementInternalName(metaData.getInternalName());
			extTransactionElementDTO.setElementType(metaData.getElementType());
			extTransactionElementDTO.setIsAmountField(metaData.getIsAmountField());
			extTransactionElementDTO.setIsSearchCriteria(metaData.getIsSearchCriteria());
			extTransactionElementDTO.setIsUniqueField(metaData.getIsSymbolField());
			extTransactionElementDTO.setIsVisibleInDashboard(metaData.getIsVisibleInDashboard());
			extTransactionElementDTO.setIsCurrencyField(metaData.getIsCurrencyField());
			extTransactionElementDTO.setMetadataName(metaDataName);

			extTransactionElementDTOList.add(extTransactionElementDTO);
		}
		
		return extTransactionElementDTOList;
	}
	
	
	public List<MarketData> searchDebtReport(List<String> sectorList, List<String> industryList, String debtEq, String txtDebtEBTTM, String txtIntCovRatio,
			String txtEBT, String txtDebtEBTF, String txtIntExp,
			String txtEBTF, String txtMktCap, String txtCashEq, String txtTDebt, String txtEntVal, String txtDebtEVRatio,
			String txtFCF, String txtAstCov, String txtDivYield, String txtRSI, String txtMovAvg, String txtPayRatio, String txtOAS,
			String txtYTM, String txtSpread, String metadata){
		
		if(debtEq == null || debtEq.length() == 0 || !containsOperator(debtEq))
			debtEq = ">=0";
		
		String sectorNames = "";
		if(sectorList != null && sectorList.size() > 0){
			for(String stock : sectorList ){

				if(!Utility.isNullOrEmpty(stock))
					sectorNames += ",'" + stock + "'";  
			}
			sectorNames = sectorNames.substring(sectorNames.indexOf(",")+1, sectorNames.length());
		}
		
		String industryNames = "";
		if(industryList != null && industryList.size() > 0){
			for(String stock : industryList ){

				if(!Utility.isNullOrEmpty(stock))
					industryNames += ",'" + stock + "'";  
			}		

			industryNames = industryNames.substring(industryNames.indexOf(",")+1, industryNames.length());
		}
		
		
		String queryStr = "select * from MarketData where metadataName = '" + metadata +"' and cast(LTRIM(RTRIM(element14)) AS DECIMAL(10,6)) "+debtEq;
		
		if(sectorNames.length() > 0) queryStr = queryStr +  " AND element13 in (" + sectorNames + ") ";
		if(industryNames.length() > 0) queryStr = queryStr +  " AND element12 in (" + industryNames + ") ";
		
		if(txtDebtEBTTM != null && txtDebtEBTTM.length() > 0 && containsOperator(txtDebtEBTTM)) queryStr = queryStr +  " AND cast(LTRIM(RTRIM(element15)) AS DECIMAL(10,6)) "+txtDebtEBTTM;
		if(txtIntCovRatio != null && txtIntCovRatio.length() > 0 && containsOperator(txtIntCovRatio)) queryStr = queryStr +  " AND cast(LTRIM(RTRIM(element17)) AS DECIMAL(10,6)) "+txtIntCovRatio;
		if(txtEBT != null && txtEBT.length() > 0 && containsOperator(txtEBT)) queryStr = queryStr +  " AND cast(LTRIM(RTRIM(element19)) AS DECIMAL(10,6)) "+txtEBT;
		if(txtDebtEBTF != null && txtDebtEBTF.length() > 0 && containsOperator(txtDebtEBTF)) queryStr = queryStr +  " AND cast(LTRIM(RTRIM(element16)) AS DECIMAL(10,6)) "+txtDebtEBTF;
		if(txtIntExp != null && txtIntExp.length() > 0 && containsOperator(txtIntExp)) queryStr = queryStr +  " AND cast(LTRIM(RTRIM(element22)) AS DECIMAL(10,6)) "+txtIntExp;
		if(txtEBTF != null && txtEBTF.length() > 0 && containsOperator(txtEBTF)) queryStr = queryStr +  " AND cast(LTRIM(RTRIM(element20)) AS DECIMAL(10,6)) "+txtEBTF;
		if(txtMktCap != null && txtMktCap.length() > 0 && containsOperator(txtMktCap)) queryStr = queryStr +  " AND cast(LTRIM(RTRIM(element21)) AS DECIMAL(10,6)) "+txtMktCap;
		if(txtCashEq != null && txtCashEq.length() > 0 && containsOperator(txtCashEq)) queryStr = queryStr +  " AND cast(LTRIM(RTRIM(element25)) AS DECIMAL(10,6)) "+txtCashEq;
		if(txtTDebt != null && txtTDebt.length() > 0 && containsOperator(txtTDebt)) queryStr = queryStr +  " AND cast(LTRIM(RTRIM(element23)) AS DECIMAL(10,6)) "+txtTDebt;
		if(txtEntVal != null && txtEntVal.length() > 0 && containsOperator(txtEntVal)) queryStr = queryStr +  " AND cast(LTRIM(RTRIM(element24)) AS DECIMAL(10,6)) "+txtEntVal;
		
		if(txtDebtEVRatio != null && txtDebtEVRatio.length() > 0 && containsOperator(txtDebtEVRatio)) queryStr = queryStr +  " AND cast(LTRIM(RTRIM(element28)) AS DECIMAL(10,6)) "+txtDebtEVRatio;
		if(txtFCF != null && txtFCF.length() > 0 && containsOperator(txtFCF)) queryStr = queryStr +  " AND cast(LTRIM(RTRIM(element33)) AS DECIMAL(10,6)) "+txtFCF;
		if(txtAstCov != null && txtAstCov.length() > 0 && containsOperator(txtAstCov)) queryStr = queryStr +  " AND cast(LTRIM(RTRIM(element27)) AS DECIMAL(10,6)) "+txtAstCov;
		if(txtDivYield != null && txtDivYield.length() > 0 && containsOperator(txtDivYield)) queryStr = queryStr +  " AND cast(LTRIM(RTRIM(element29)) AS DECIMAL(10,6)) "+txtDivYield;
		if(txtRSI != null && txtRSI.length() > 0 && containsOperator(txtRSI)) queryStr = queryStr +  " AND cast(LTRIM(RTRIM(element31)) AS DECIMAL(10,6)) "+txtRSI;
		if(txtMovAvg != null && txtMovAvg.length() > 0 && containsOperator(txtMovAvg)) queryStr = queryStr +  " AND cast(LTRIM(RTRIM(element32)) AS DECIMAL(10,6)) "+txtMovAvg;
		if(txtPayRatio != null && txtPayRatio.length() > 0 && containsOperator(txtPayRatio)) queryStr = queryStr +  " AND cast(LTRIM(RTRIM(element30)) AS DECIMAL(10,6)) "+txtPayRatio;
		if(txtOAS != null && txtOAS.length() > 0 && containsOperator(txtOAS)) queryStr = queryStr +  " AND cast(LTRIM(RTRIM(element35)) AS DECIMAL(10,6)) "+txtOAS;
		if(txtYTM != null && txtYTM.length() > 0 && containsOperator(txtYTM)) queryStr = queryStr +  " AND cast(LTRIM(RTRIM(element36)) AS DECIMAL(10,6)) "+txtYTM;
		if(txtSpread != null && txtSpread.length() > 0 && containsOperator(txtSpread)) queryStr = queryStr +  " AND cast(LTRIM(RTRIM(element34)) AS DECIMAL(10,6)) "+txtSpread;
		
		//queryStr = queryStr +  " order by cast(LTRIM(RTRIM(element31)) AS DECIMAL(10,6)) desc ";
		queryStr = queryStr +  " and idMarketDataFile in (select max(idMarketDataFile) from MarketDataFile where metadataName = '" + metadata +"') "
				+ "order by cast(LTRIM(RTRIM(element31)) AS DECIMAL(10,6)) desc ";
		
		System.out.println("Query in searchDebtReport ----> "+queryStr);
		
		List<MarketData> marketDataList = new ArrayList<MarketData>();
		Session session = null; 
		try{ session = sessionFactory.openSession(); 
			marketDataList = (List<MarketData>)session.createNativeQuery(queryStr, MarketData.class).list();
			session.close();
		 }catch(Exception e){ 
			 e.printStackTrace();
		}
		
		System.out.println("MarketData size in searchDebtReport ----> "+marketDataList.size());
		
		
		return marketDataList;
	}
	
	private static boolean containsOperator(String s){
		if(s.contains("=") || s.contains(">") || s.contains("<"))
			return true;
		return false;
	}

	@Override
	public List<StockDTO> getAllStocks() {
		List<String> results = new ArrayList<String>();
		List<StockDTO> stocks = new ArrayList<StockDTO>();
		results = stockDao.findAllStocks();
		
		for (String stockName : results) {
			StockDTO stockDTO = new StockDTO();
			stockDTO.setStockName(stockName); 
			stocks.add(stockDTO);
		}
		
		return stocks;
	}
	
	@Override
	public List<StockDTO> getAllSectors() {
		List<String> results = new ArrayList<String>();
		List<StockDTO> stocks = new ArrayList<StockDTO>();
		results = stockDao.findAllSectors();
		
		for (String sector : results) {
			StockDTO stockDTO = new StockDTO();
			stockDTO.setSector(sector); 
			stocks.add(stockDTO);
		}
		
		return stocks;
	}

	@Override
	public List<StockDTO> getAllIndustry() {
		List<String> results = new ArrayList<String>();
		List<StockDTO> stocks = new ArrayList<StockDTO>();
		results = stockDao.findAllIndustry();

		if(results == null || results.size() == 0)
			return new ArrayList<StockDTO>();
		
		for (String industry : results) {
			StockDTO stockDTO = new StockDTO();
			industry = industry.replaceAll("'", "");
			stockDTO.setIndustry(industry);  
			stocks.add(stockDTO);
		}
		
		return stocks;
	}
	
	@Override
	public List<CompareBondStockDTO> getHistoricalDataByStockAndBond(String ticker, String cusip){
		
		Session session = null; 
		session = sessionFactory.openSession(); 

		List<CompareBondStockDTO> compareBondStockDTOList = new ArrayList<CompareBondStockDTO>();

		/*
		 * String queryStr =
		 * "select distinct m.idMarketData as id,m.element1 as bondName,m.element2 as cusip,m.element9 as bondPrice,"
		 * +
		 * "h.element1 as stockName,h.element3 as stockPrice,s.company as companyName,h.element2 as stockDate,"
		 * +
		 * "m.lastUpdatedAt as bondDate from MarketData m, MarketHistoryData h, Stock s where h.element1 = '"
		 * + ticker + "' " + "AND DAYNAME(h.element2) = 'friday' and m.element2 = '" +
		 * cusip + "'  and " + //
		 * "CONVERT(m.lastUpdatedAt, DATETIME) between CONVERT(h.element2, DATETIME) and "
		 * + "DATE_ADD(h.element2, INTERVAL 7 DAY) and s.stockname = h.element1 " +
		 * "and s.stockName = h.element1";
		 */

		String queryStr = "select distinct m.idMarketData as id,m.element1 as bondName,m.element2 as cusip,m.element9 as bondPrice," +
				"h.element1 as stockName,h.element3 as stockPrice,s.company as companyName,h.element2 as stockDate," +
				"m.lastUpdatedAt as bondDate from MarketData m, MarketHistoryData h, Stock s where h.element1 = '" + ticker + "' " +
				"AND DATENAME(WEEKDAY,h.element2) = 'friday' and m.element2 = '" + cusip + "'  and " +
				"CONVERT(Datetime, m.lastUpdatedAt , 120) between  CONVERT(Datetime, h.element2 , 120) and " +
		        "DATEADD(day,7,h.element2) and s.stockname = h.element1 " + 
				"and s.stockName = h.element1";
		System.out.println(queryStr);
		org.hibernate.query.Query query = session.createNativeQuery(queryStr)
		.addScalar("id",LongType.INSTANCE )
		.addScalar("bondName",StringType.INSTANCE)
		.addScalar("cusip", StringType.INSTANCE)
		.addScalar("bondPrice", StringType.INSTANCE)
		.addScalar("stockName", StringType.INSTANCE)
		.addScalar("stockPrice", StringType.INSTANCE)
		.addScalar("companyName",StringType.INSTANCE)
		.addScalar("stockDate", StringType.INSTANCE)
		.addScalar("bondDate", StringType.INSTANCE);
		
		
		
		List results = query.list();
		System.out.println(results.size());

		if (results != null) {
			Iterator itr = results.iterator();
			while (itr.hasNext()) {
				CompareBondStockDTO compareBondStockDTO = new CompareBondStockDTO();
				Object[] columns = (Object[]) itr.next();
				compareBondStockDTO.setBondName((String) columns[1]);
				compareBondStockDTO.setCusip((String) columns[2]);
				if(Utility.isNullOrEmpty((String) columns[3]))
					compareBondStockDTO.setBondPrice("");
				else
					compareBondStockDTO.setBondPrice(String.format("%.2f",new Double((String) columns[3])));
				compareBondStockDTO.setStockName((String) columns[4]);
				if(Utility.isNullOrEmpty((String) columns[5]))
					compareBondStockDTO.setStockPrice("");
				else
					compareBondStockDTO.setStockPrice(String.format("%.2f",new Double((String) columns[5])));
				compareBondStockDTO.setCompanyName((String) columns[6]);
				compareBondStockDTO.setDate((String) columns[7]);
				if(Utility.isNullOrEmpty((String) columns[3]) || Utility.isNullOrEmpty((String) columns[5]))
					compareBondStockDTO.setBondToStock("");
				else
					compareBondStockDTO.setBondToStock(String.format("%.2f",new Double(Double.parseDouble((String) columns[3]) / Double.parseDouble((String) columns[5]) )));
				compareBondStockDTOList.add(compareBondStockDTO);
			}
		}
		
		System.out.println("compareBondStockDTOList size -> "+compareBondStockDTOList.size());
		session.close();
		return compareBondStockDTOList;
	
	}
	
	

	@Override
	public List<CompareBondStockDTO> getHistoricalDataByStockAndBondForChart(String ticker, String cusip,String year,String year2){
		
		Session session = null; 
		session = sessionFactory.openSession(); 

		List<CompareBondStockDTO> compareBondStockDTOList = new ArrayList<CompareBondStockDTO>();
		
		String queryStr = "select distinct m.idMarketData as id,m.element9 as bondPrice," +
				"h.element3 as stockPrice,h.element2 as stockDate " +
				"from MarketData m, MarketHistoryData h, Stock s where h.element1 = '" + ticker + "' " +
				"AND DATENAME(WEEKDAY,h.element2) = 'friday' AND (CAST(DATENAME(YEAR,h.element2) as int))>='" + year + "' AND (CAST(DATENAME(YEAR,h.element2) as int))<='" + year2 + "' and m.element2 = '" + cusip + "'  and " +
				"CONVERT(Datetime, m.lastUpdatedAt , 120) between  CONVERT(Datetime, h.element2 , 120) and " +
		        "DATEADD(day,7,h.element2) and s.stockname = h.element1 " + 
				"and s.stockName = h.element1";
		System.out.println(queryStr);
		org.hibernate.query.Query query = session.createNativeQuery(queryStr)
		.addScalar("id",LongType.INSTANCE )		
		.addScalar("bondPrice", StringType.INSTANCE)
		.addScalar("stockPrice", StringType.INSTANCE)
		.addScalar("stockDate", StringType.INSTANCE);
		
		
		
		List results = query.list();
		System.out.println(results.size());

		if (results != null) {
			Iterator itr = results.iterator();
			while (itr.hasNext()) {
				CompareBondStockDTO compareBondStockDTO = new CompareBondStockDTO();
				Object[] columns = (Object[]) itr.next();
				if(Utility.isNullOrEmpty((String) columns[1]))
					compareBondStockDTO.setBondPrice("");
				else
					compareBondStockDTO.setBondPrice(String.format("%.2f",new Double((String) columns[1])));
				if(Utility.isNullOrEmpty((String) columns[2]))
					compareBondStockDTO.setStockPrice("");
				else
					compareBondStockDTO.setStockPrice(String.format("%.2f",new Double((String) columns[2])));
				if(Utility.isNullOrEmpty((String) columns[3]))
					compareBondStockDTO.setDate("");
				else
					compareBondStockDTO.setDate((String) columns[3]);
				
				compareBondStockDTOList.add(compareBondStockDTO);
			}
		}
		
		System.out.println("getHistoricalDataByStockAndBondForChart size -> "+compareBondStockDTOList.size());
		session.close();
		return compareBondStockDTOList;
	
	}
	
	private Map<Double,StockPerformanceDTO> getTopFiveTickers(Map<String, StockPerformanceDTO> tickerDiffMap,String metadataName) {

		//Map<String, Double> topFiveMap = new HashMap<String, Double>();
		Map<Double,StockPerformanceDTO> topFiveSortedMap = new TreeMap<Double,StockPerformanceDTO>();
		//System.out.println("getTopFiveTickers metadataName-- "+metadataName);
		for(String key : tickerDiffMap.keySet()){
			//System.out.println("getTopFiveTickers---"+key);
			StockPerformanceDTO dto = tickerDiffMap.get(key);
			if(metadataName.equalsIgnoreCase("Tickers_Watchlist")) {
				topFiveSortedMap.put(Double.valueOf(dto.getBestMovedBy()), dto);
			}
			else {
				System.out.println("Else if-"+metadataName+"topFiveSortedMap key- "+dto.getPercentageChangeRise()+"DTO-"+dto.toString());
				
				topFiveSortedMap.put(Double.valueOf(dto.getPercentageChangeRise()), dto);
			}
		}
		System.out.println("getTopFiveTickers topFiveSortedMap Size-- "+topFiveSortedMap.size());
		return topFiveSortedMap;
	}

	private Map<Double,StockPerformanceDTO> getBottomFiveTickers(Map<String, StockPerformanceDTO> tickerDiffMap,String metadataName) {

		//Map<String, Double> worstFiveMap = new HashMap<String, Double>();
		Map<Double,StockPerformanceDTO> worstFiveSortedMap = new TreeMap<Double,StockPerformanceDTO>();
		for(String key : tickerDiffMap.keySet()){
			StockPerformanceDTO dto = tickerDiffMap.get(key);

			if(metadataName.equalsIgnoreCase("Tickers_Watchlist"))
				worstFiveSortedMap.put(Double.valueOf(dto.getWorstMovedBy()), dto);
			else worstFiveSortedMap.put(Double.valueOf(dto.getPercentageChangeDrop()), dto);
		}

		return worstFiveSortedMap;//reverseIt(worstFiveSortedMap);
	}
	private boolean isValid(Object object, boolean isNum) {

		//System.out.println(object);
		boolean isValid = true;
		if(object==null || object.toString() == null || object.toString().equals("- ") || object.toString().equals("-"))
			isValid = false;
		else if(isNum)
		{
			try{
				Double number = Double.parseDouble(object.toString());
			}catch(NumberFormatException e){
				isValid = false;
			}
		}

		//System.out.println(isValid);
		return isValid;
	}
	
	@Override
	public StockPerformancePairDTO getImportHistorySheetCompare(String metadataName,String date1,String date2){
		Session session = null; 
		session = sessionFactory.openSession(); 
		

		try {
			String dt1Str = date1;
			String dt2Str = date2;
			Date d1 = Utility.getDate(dt1Str, "yyyy-mm-dd");
			Date d2 = Utility.getDate(dt2Str, "yyyy-mm-dd");

			if(d1.compareTo(d2)>0){ // date1 is future to date2
				date1 = Utility.getDateString(d1, "yyyy-mm-dd");
				date2 = Utility.getDateString(d2, "yyyy-mm-dd");
			}else{ // date1 is past to date2
				date1 = Utility.getDateString(d2, "yyyy-mm-dd");
				date2 = Utility.getDateString(d1, "yyyy-mm-dd");
			}
		} catch (Exception e1) {
			e1.printStackTrace();
		}

		String queryStr = "";
		org.hibernate.query.Query query = null;
		try {
			StockPerformancePairDTO performancePairDTO = new StockPerformancePairDTO();
		//	List<StockPerformancePairDTO> performancePairDTO = new ArrayList<StockPerformancePairDTO>();

		//	Session session = HibernateUtils.getSession();
			if(metadataName.equalsIgnoreCase("Tickers_Watchlist")){

				if(date1.equals("1900-01-01") || date2.equals("1900-01-01")){    // inside this if block we have 2 cases for 2 metadata ; add for bond : element6/9
					queryStr = "select prevWK.element1,currWK.element1 as tickerr," +
							"prevWK.element3,currWK.element3 as currWKRank from " + 
							"(select * from MarketData m1 where metadataName = '" + metadataName + "' and idMarketDataFile " + 
							"in (select max(idMarketDataFile) from MarketDataFile where metadataName = '" + metadataName + "')) currWK " +
							"JOIN " +
							"(select * from MarketData m1 where metadataName = '" + metadataName + "' and idMarketDataFile " +
							"in (SELECT max(idMarketDataFile) FROM MarketDataFile WHERE metadataName = '" + metadataName + "' and idMarketDataFile " + 
							"NOT IN (SELECT max(idMarketDataFile) FROM MarketDataFile where metadataName = '" + metadataName + "'))) prevWK " +
							" ON " +
							"prevWK.element1 = currWK.element1";

				}else{ 
					queryStr = "select prevWK.element1,currWK.element1 as tickerr," +
							"prevWK.element3,currWK.element3 as currWKRank from " +
							"(select * from MarketData m1 where idMarketDataFile in " +
							"(select idMarketDataFile from MarketDataFile where " +
							"SUBSTRING(CAST(Convert(varchar(11), createdOn ,126) as varchar(11)),0,11) like '"+ date1 +
							"' ) and m1.metadataName = '" + metadataName + "') currWK " +
							"JOIN " +
							"(select * from MarketData m1 where idMarketDataFile in " +
							"(select idMarketDataFile from MarketDataFile where " +
							"SUBSTRING(CAST(Convert(varchar(11), createdOn ,126) as varchar(11)),0,11) like '"+ date2 +
							"' ) and m1.metadataName = '" + metadataName + "') prevWK " +
							" ON " +
							"prevWK.element1 = currWK.element1";
				}

				System.out.println("Compare data of Tickers_Watchlist---"+queryStr);	
				query = session.createNativeQuery(queryStr)
						.addScalar("element1", new StringType())
						.addScalar("tickerr", new StringType())
						.addScalar("element3", new StringType())
						.addScalar("currWKRank", new StringType()); 

			}else if(metadataName.equalsIgnoreCase("Bondpricing_Master")){

				if(date1.equals("1900-01-01") || date2.equals("1900-01-01")){    // inside this if block we have 2 cases for 2 metadata ; add for bond : element6/9
					queryStr = "select prevWK.element1,currWK.element1 as tickerr," +
							"prevWK.element9,currWK.element9 as currWKRank,prevWK.element3 as prevWKytm,currWK.element3 as currWKytm,currWK.element7 as maturityDate from " + 
							"(select * from MarketData m1 where metadataName = '" + metadataName + "' and idMarketDataFile " + 
							"in (select max(idMarketDataFile) from MarketDataFile where metadataName = '" + metadataName + "')) currWK " +
							"JOIN " +
							"(select * from MarketData m1 where metadataName = '" + metadataName + "' and idMarketDataFile " +
							"in (SELECT max(idMarketDataFile) FROM MarketDataFile WHERE metadataName = '" + metadataName + "' and idMarketDataFile " + 
							"NOT IN (SELECT max(idMarketDataFile) FROM MarketDataFile where metadataName = '" + metadataName + "'))) prevWK " +
							" ON " +
							"prevWK.element1 = currWK.element1";

				}else{ 
					queryStr = "select prevWK.element1,currWK.element1 as tickerr," +
							"prevWK.element9,currWK.element9 as currWKRank,prevWK.element3 as prevWKytm,currWK.element3 as currWKytm,currWK.element7 as maturityDate from " +
							"(select * from MarketData m1 where idMarketDataFile in " +
							"(select idMarketDataFile from MarketDataFile where " +
							"SUBSTRING(CAST(Convert(varchar(11), createdOn ,126) as varchar(11)),0,11) like '"+ date1 +
							"' ) and m1.metadataName = '" + metadataName + "') currWK " +
							"JOIN " +
							"(select * from MarketData m1 where idMarketDataFile in " +
							"(select idMarketDataFile from MarketDataFile where " +
							"SUBSTRING(CAST(Convert(varchar(11), createdOn ,126) as varchar(11)),0,11) like '"+ date2 +
							"' ) and m1.metadataName = '" + metadataName + "') prevWK " +
							" ON " +
							"prevWK.element1 = currWK.element1";
				}
				System.out.println("Compare data of Bondpricing_Master---"+queryStr);
				query = session.createNativeQuery(queryStr)
						.addScalar("element1", new StringType())
						.addScalar("tickerr", new StringType())
						.addScalar("element9", new StringType())
						.addScalar("currWKRank", new StringType())
						.addScalar("prevWKytm", new StringType())
						.addScalar("currWKytm", new StringType())
						.addScalar("maturityDate", new StringType());
			}
			else if(metadataName.equalsIgnoreCase("Everything_List")){

				if(date1.equals("1900-01-01") || date2.equals("1900-01-01")){   
					queryStr = "select prevWK.element1,currWK.element1 as tickerr," +
							"prevWK.element6,currWK.element6 as currWKRank from " + 
							"(select * from MarketData m1 where metadataName = '" + metadataName + "' and idMarketDataFile " + 
							"in (select max(idMarketDataFile) from MarketDataFile where metadataName = '" + metadataName + "')) currWK " +
							"JOIN " +
							"(select * from MarketData m1 where metadataName = '" + metadataName + "' and idMarketDataFile " +
							"in (SELECT max(idMarketDataFile) FROM MarketDataFile WHERE metadataName = '" + metadataName + "' and idMarketDataFile " + 
							"NOT IN (SELECT max(idMarketDataFile) FROM MarketDataFile where metadataName = '" + metadataName + "'))) prevWK " +
							" ON " +
							"prevWK.element1 = currWK.element1";

				}else{ 
					queryStr = "select prevWK.element1,currWK.element1 as tickerr," +
							"prevWK.element6,currWK.element6 as currWKRank from " +
							"(select * from MarketData m1 where idMarketDataFile in " +
							"(select idMarketDataFile from MarketDataFile where " +
							"SUBSTRING(CAST(Convert(varchar(11), createdOn ,126) as varchar(11)),0,11) like '"+ date1 +
							"' ) and m1.metadataName = '" + metadataName + "') currWK " +
							"JOIN " +
							"(select * from MarketData m1 where idMarketDataFile in " +
							"(select idMarketDataFile from MarketDataFile where " +
							"SUBSTRING(CAST(Convert(varchar(11), createdOn ,126) as varchar(11)),0,11) like '"+ date2 +
							"' ) and m1.metadataName = '" + metadataName + "') prevWK " +
							" ON " +
							"prevWK.element1 = currWK.element1";
				}

				System.out.println("Compare data of Everything_List---"+queryStr);

				query = session.createNativeQuery(queryStr)
						.addScalar("element1", new StringType())
						.addScalar("tickerr", new StringType())
						.addScalar("element6", new StringType())
						.addScalar("currWKRank", new StringType()); 
			}
			else if(metadataName.equalsIgnoreCase("Everything_List_New")){

				if(date1.equals("1900-01-01") || date2.equals("1900-01-01")){   
					queryStr = "select prevWK.element1,currWK.element1 as tickerr," +
							//"SUBSTRING( prevWK.element8, 2, 10 ) as element8,SUBSTRING( currWK.element8, 2, 10 ) as currWKRank from " + 
							"prevWK.element8 as element8,currWK.element8 as currWKRank from " +
							"(select * from MarketData m1 where metadataName = '" + metadataName + "' and idMarketDataFile " + 
							"in (select max(idMarketDataFile) from MarketDataFile where metadataName = '" + metadataName + "')) currWK " +
							"JOIN " +
							"(select * from MarketData m1 where metadataName = '" + metadataName + "' and idMarketDataFile " +
							"in (SELECT max(idMarketDataFile) FROM MarketDataFile WHERE metadataName = '" + metadataName + "' and idMarketDataFile " + 
							"NOT IN (SELECT max(idMarketDataFile) FROM MarketDataFile where metadataName = '" + metadataName + "'))) prevWK " +
							" ON " +
							"prevWK.element1 = currWK.element1";

				}else{ 
					queryStr = "select prevWK.element1,currWK.element1 as tickerr," +
							//"SUBSTRING( prevWK.element8, 2, 10 ) as element8,SUBSTRING( currWK.element8, 2, 10 ) as currWKRank from " +
							"prevWK.element8 as element8,currWK.element8 as currWKRank from " +
							"(select * from MarketData m1 where idMarketDataFile in " +
							"(select idMarketDataFile from MarketDataFile where " +
							"SUBSTRING(CAST(Convert(varchar(11), createdOn ,126) as varchar(11)),0,11) like '"+ date1 +
							"' ) and m1.metadataName = '" + metadataName + "') currWK " +
							"JOIN " +
							"(select * from MarketData m1 where idMarketDataFile in " +
							"(select idMarketDataFile from MarketDataFile where " +
							"SUBSTRING(CAST(Convert(varchar(11), createdOn ,126) as varchar(11)),0,11) like '"+ date2 +
							"' ) and m1.metadataName = '" + metadataName + "') prevWK " +
							" ON " +
							"prevWK.element1 = currWK.element1";
				}
				System.out.println("Compare data of Everything_List_New---"+queryStr);

				query = session.createNativeQuery(queryStr)
						.addScalar("element1", new StringType())
						.addScalar("tickerr", new StringType())
						.addScalar("element8", new StringType())
						.addScalar("currWKRank", new StringType()); 
			}


			List results = query.list();

			/*StockPerformanceDTO stockPerformanceDTO = new StockPerformanceDTO(); 
			Double bestVal = 0.0;
			Double worstVal = 0.0;

			String bestMovedStock = "";
			String worstMovedStock = "";
			String bestMovedBy = "";
			String worstMovedBy = "";

			String bestMoveCurrValue = "";
			String bestMovePrevValue = "";
			String worstMoveCurrValue = "";
			String worstMovePrevValue = "";*/

			//Map<String, Double> tickerDiffMap = new HashMap<String, Double>();

			Map<String, StockPerformanceDTO> tickerComparatorMap = new HashMap<String, StockPerformanceDTO>();
			Map<Double, StockPerformanceDTO> topFiveTickerMapp = new HashMap<Double, StockPerformanceDTO>();
			Map<Double, StockPerformanceDTO> bottomFiveTickerMapp = new HashMap<Double, StockPerformanceDTO>();

			System.out.println("result size=" + results.size());
			if (!Utility.isNullOrEmpty(results)) {
				Iterator itr = results.iterator();
				while (itr.hasNext()) {
					Object[] columns = (Object[]) itr.next();

					if(isValid(columns[0],false) && isValid(columns[2],true) && isValid(columns[3],true) )
					{
						//						System.out.println("OKK");
						String ticker = columns[0].toString();
						Double prevWKRank = Double.parseDouble(columns[2].toString());
						Double currWKRank = Double.parseDouble(columns[3].toString());
						

						Double diff = prevWKRank - currWKRank; // 0 menas holding same rank, +ve means promotion, -ve means demotion
						//Double diffInPositive = diff * (-1.0);

						StockPerformanceDTO performanceDTO = new StockPerformanceDTO();
						performanceDTO.setBestMovedStock(ticker);
						performanceDTO.setBestMovePrevValue(prevWKRank.toString());
						performanceDTO.setBestMoveCurrValue(currWKRank.toString());
						//performanceDTO.setBestMovedBy(diff.toString());
						performanceDTO.setBestMovedBy(String.format("%.2f",diff));


						performanceDTO.setWorstMovedStock(ticker);
						performanceDTO.setWorstMovePrevValue(prevWKRank.toString());
						performanceDTO.setWorstMoveCurrValue(currWKRank.toString());
						//performanceDTO.setWorstMovedBy(diff.toString());
						performanceDTO.setWorstMovedBy(String.format("%.2f",diff));

						Double percentageChange = (diff/prevWKRank) * 100;
						
						//performanceDTO.setPercentageChangeRise(percentageChange.toString());
						//performanceDTO.setPercentageChangeDrop(percentageChange.toString());

						performanceDTO.setPercentageChangeRise(String.format("%.2f",percentageChange));
						performanceDTO.setPercentageChangeDrop(String.format("%.2f",percentageChange));
						
						try {
							if(metadataName.equalsIgnoreCase("Bondpricing_Master")){
								String currentytm=columns[5].toString();
								String Prevytm=columns[4].toString();
								 if(!"ERROR".equalsIgnoreCase(Prevytm))
									performanceDTO.setPrevytm(String.format("%.2f",new Double(Prevytm)));
						         if(!"ERROR".equalsIgnoreCase(currentytm))
									performanceDTO.setCurrytm(String.format("%.2f",new Double(currentytm)));
								//performanceDTO.setCurrytm(String.format("%.2f",new Double(columns[5].toString())));
								performanceDTO.setMaturityDate(columns[6].toString()); 
							}
						} catch (Exception e) {
							e.printStackTrace();
						}

						//tickerDiffMap.put(ticker, diff);
						tickerComparatorMap.put(ticker,performanceDTO);

						// System.out.println(emp);w
						//System.out.println(prevWKRank + " --- " + currWKRank + " --- " + diff);
						/*if(diff >= bestVal){
							bestVal = diff;
							bestMovedStock = ticker;
							bestMovedBy = diff.toString();
							bestMoveCurrValue = currWKRank.toString();
							bestMovePrevValue = prevWKRank.toString();
						}
						if(diff <= worstVal){
							worstVal = diff;
							worstMovedStock = ticker;
							worstMovedBy = diff.toString();
							worstMoveCurrValue = currWKRank.toString();
							worstMovePrevValue = prevWKRank.toString();

						}*/
					}


				}

				topFiveTickerMapp = getTopFiveTickers(tickerComparatorMap, metadataName);
				bottomFiveTickerMapp = getBottomFiveTickers(tickerComparatorMap, metadataName);

				int pos = 0;
				Double arr[] = new Double[topFiveTickerMapp.keySet().size()];
				for(Double d : topFiveTickerMapp.keySet()){
					arr[pos++] = d;
				}
				//System.out.println("arr len = " + arr.length + " topFiveTickerMapp size = " + topFiveTickerMapp.size());

				List<StockPerformanceDTO> bestFiveStocks = new ArrayList<StockPerformanceDTO>();
				List<StockPerformanceDTO> worstFiveStocks = new ArrayList<StockPerformanceDTO>();

				for(pos=arr.length-1; pos>=arr.length-20; pos--){

					System.out.println("arr["+pos+"]= "  + arr[pos]);
					System.out.println("arr.length -- "+arr.length); 
					//System.out.println("pos -- "+pos);
					StockPerformanceDTO performanceDTO = null;
					try {
						performanceDTO = topFiveTickerMapp.get(arr[pos]);
					} catch (Exception e) {

						e.printStackTrace();
						continue;
					}
					//System.out.println(performanceDTO.getBestMovedStock());
					//System.out.println(performanceDTO.getBestMovedBy());
					if(metadataName.equalsIgnoreCase("Bondpricing_Master")){
						//System.out.println(performanceDTO.getBestMovedBy() + " **** " + String.valueOf(new Double(performanceDTO.getBestMovedBy())*(-1)));
						performanceDTO.setWorstMovedBy(String.valueOf(new Double(performanceDTO.getBestMovedBy())*(-1)));
						performanceDTO.setPercentageChangeDrop(String.valueOf(new Double(performanceDTO.getPercentageChangeRise())*(-1)));
					}
					if(metadataName.equalsIgnoreCase("Everything_List")  || metadataName.equalsIgnoreCase("Everything_List_New")){
						performanceDTO.setWorstMovedBy(String.valueOf(new Double(performanceDTO.getBestMovedBy())*(-1)));
						performanceDTO.setPercentageChangeDrop(String.valueOf(new Double(performanceDTO.getPercentageChangeRise())*(-1)));
					}
					bestFiveStocks.add(performanceDTO); 
				}

				int p = 1;
				for(Double d : bottomFiveTickerMapp.keySet()){
					StockPerformanceDTO performanceDTO = bottomFiveTickerMapp.get(d);
					if(p++ <= 20){
						//System.out.println(performanceDTO.getWorstMovedStock());
						//System.out.println(performanceDTO.getWorstMovedBy());
						if(metadataName.equalsIgnoreCase("Bondpricing_Master")){
							performanceDTO.setBestMovedBy(String.valueOf(new Double(performanceDTO.getWorstMovedBy())*(-1)));
							performanceDTO.setPercentageChangeRise(String.valueOf(new Double(performanceDTO.getPercentageChangeDrop())*(-1)));
						}
						if(metadataName.equalsIgnoreCase("Everything_List")  || metadataName.equalsIgnoreCase("Everything_List_New")){
							performanceDTO.setBestMovedBy(String.valueOf(new Double(performanceDTO.getWorstMovedBy())*(-1)));
							performanceDTO.setPercentageChangeRise(String.valueOf(new Double(performanceDTO.getPercentageChangeDrop())*(-1)));
						}

						worstFiveStocks.add(performanceDTO);
					}
				}
				if(metadataName.equalsIgnoreCase("Tickers_Watchlist")){
					performancePairDTO.setBestFiveStocks(bestFiveStocks);
					performancePairDTO.setWorstFiveStocks(worstFiveStocks);

				}else if(metadataName.equalsIgnoreCase("Bondpricing_Master")){
					performancePairDTO.setBestFiveStocks(worstFiveStocks);
					performancePairDTO.setWorstFiveStocks(bestFiveStocks);
				}else if(metadataName.equalsIgnoreCase("Everything_List")  || metadataName.equalsIgnoreCase("Everything_List_New")){
					performancePairDTO.setBestFiveStocks(worstFiveStocks);
					performancePairDTO.setWorstFiveStocks(bestFiveStocks);
				}



			}
			session.close();

			return  performancePairDTO;
		} catch (Exception e) {
			System.out.println("Exception in getImportHistorySheetCompare ....");
			e.printStackTrace();
		}
		return new StockPerformancePairDTO(); 
	
		
	}
	
	public List<StockPerformanceDTO> getStockRanking(String metadataName) {
		Session session = null; 
		session = sessionFactory.openSession(); 
		List<StockPerformanceDTO> stockPerformanceDTOList = new ArrayList<StockPerformanceDTO>();

		//Session session = HibernateUtils.getSession();
		String queryStr = "select prevWK.element1,currWK.element1 as tickerr," +
				"prevWK.element3,currWK.element3 as currWKRank from " +
				"(select * from MarketData m1 where DATEDIFF(WEEK,GETDATE(),m1.lastUpdatedAt) = -1 " +
				"and m1.metadataName = '" + metadataName + "') prevWK " +
				"JOIN " +
				"(select * from MarketData m1 where  DATEDIFF(WEEK,GETDATE(),m1.lastUpdatedAt) = 0 " +
				"and m1.metadataName = '" + metadataName + "') currWK " +
				"ON " +
				"prevWK.element1 = currWK.element1";
		System.out.println("getStockRanking---> " +queryStr);
		org.hibernate.query.Query query = session.createNativeQuery(queryStr)
				.addScalar("element1", new StringType())
				.addScalar("tickerr", new StringType())
				.addScalar("element3", new StringType())
				.addScalar("currWKRank", new StringType()); 
		List results = query.list();

		StockPerformanceDTO stockPerformanceDTO = new StockPerformanceDTO(); 
		Double bestVal = 0.0;
		Double worstVal = 0.0;

		String bestMovedStock = "";
		String worstMovedStock = "";
		String bestMovedBy = "";
		String worstMovedBy = "";

		String bestMoveCurrValue = "";
		String bestMovePrevValue = "";
		String worstMoveCurrValue = "";
		String worstMovePrevValue = "";
		Double percentageChange=0.0;

		if (results != null) {
			Iterator itr = results.iterator();
			while (itr.hasNext()) {
				Object[] columns = (Object[]) itr.next();

				if(isValid(columns[0].toString(),false) && isValid(columns[2].toString(),true) && isValid(columns[3].toString(),true) )
				{
					//System.out.println("OKK");
					String ticker = columns[0].toString();
					Double prevWKRank = Double.parseDouble(columns[2].toString());
					Double currWKRank = Double.parseDouble(columns[3].toString());
					Double diff = prevWKRank - currWKRank; // 0 menas holding same rank, +ve means demotion, -ve means advancement
					 percentageChange = (diff/prevWKRank) * 100;
					// System.out.println(emp);
					//System.out.println(prevWKRank + " --- " + currWKRank + " --- " + diff);
					if(diff >= bestVal){
						bestVal = diff;
						bestMovedStock = ticker;
						bestMovedBy = diff.toString();
						bestMoveCurrValue = currWKRank.toString();
						bestMovePrevValue = prevWKRank.toString();
					}
					if(diff <= worstVal){
						worstVal = diff;
						worstMovedStock = ticker;
						worstMovedBy = diff.toString();
						worstMoveCurrValue = currWKRank.toString();
						worstMovePrevValue = prevWKRank.toString();

					}
				}
			}

			stockPerformanceDTO.setBestMoveCurrValue(bestMoveCurrValue);
			stockPerformanceDTO.setBestMovedBy(bestMovedBy);
			stockPerformanceDTO.setBestMovedStock(bestMovedStock);
			stockPerformanceDTO.setBestMovePrevValue(bestMovePrevValue);
			stockPerformanceDTO.setPercentageChangeRise(String.format("%.2f",percentageChange));

			stockPerformanceDTO.setWorstMoveCurrValue(worstMoveCurrValue);
			stockPerformanceDTO.setWorstMovedBy(worstMovedBy);
			stockPerformanceDTO.setWorstMovedStock(worstMovedStock);
			stockPerformanceDTO.setWorstMovePrevValue(worstMovePrevValue);
			stockPerformanceDTO.setPercentageChangeDrop(String.format("%.2f",percentageChange));
			
			stockPerformanceDTOList.add(stockPerformanceDTO);
		}
		System.out.println("getStockRanking size -> "+stockPerformanceDTOList.size());
		session.close();
		return stockPerformanceDTOList;

	}
	
	
	public List<MarketData> findImportDataByWeek(String metadataName, String date){		//metadata, '2014-08-20'
		Session session = null; 
		session = sessionFactory.openSession(); 
		String queryStr = "";

		if(date.equals("1900-01-01")){
			if("Bondpricing_Master".equalsIgnoreCase(metadataName)){
				queryStr = "select t1.element3 as element99, t2.* from(select * from marketdata "+
						"where "+
						"metadataName='Tickers_Watchlist' "+
						"and idMarketDataFile in "+
						" (select max(idMarketDataFile) from MarketDataFile where "+
						"metadataName='Tickers_Watchlist' "+
						"))  t1, "+
						" "+
						"(select (select substring (element1,CHARINDEX('(', element1)+1, "+
						"(CHARINDEX(')', element1)-CHARINDEX('(', element1))-1) ) as c1,* "+
						" from marketdata "+
						"where "+
						"metadataName='Bondpricing_Master' and (CHARINDEX(')', element1)-CHARINDEX('(', element1))>0 "+
						"and idMarketDataFile in "+
						" (select max(idMarketDataFile) from MarketDataFile where metadataName='Bondpricing_Master') ) t2 "+
						" where t1.element1 = t2.c1 ";

			}else{
				queryStr = "select * from MarketData where metadataName = '" + metadataName + "' and idMarketDataFile " + 
						"in (select max(idMarketDataFile) from MarketDataFile where metadataName = '" + metadataName + "') and isSoftDeleted=0";
			}

		}else{
			if("Bondpricing_Master".equalsIgnoreCase(metadataName)){
				queryStr = "select t1.element3 as element99, t2.* from(select * from marketdata "+
						"where "+
						"metadataName='Tickers_Watchlist' "+
						"and idMarketDataFile in "+
						" (select idMarketDataFile from MarketDataFile where " +
						"SUBSTRING(CAST(Convert(varchar(11), createdOn ,126) as varchar(11)),0,11) like '" + date + "'))  t1, "+
						" "+
						"(select (select substring (element1,CHARINDEX('(', element1)+1, "+
						"(CHARINDEX(')', element1)-CHARINDEX('(', element1))-1) ) as c1,* "+
						" from marketdata "+
						"where "+
						"metadataName='Bondpricing_Master' and (CHARINDEX(')', element1)-CHARINDEX('(', element1))>0 "+
						"and idMarketDataFile in "+
						" (select idMarketDataFile from MarketDataFile where " +
						" SUBSTRING(CAST(Convert(varchar(11), createdOn ,126) as varchar(11)),0,11) like '" + date + "') ) t2 "+
						" where t1.element1 = t2.c1 ";

			}else{
				queryStr = "select * from MarketData where metadataName = '" + metadataName + "' and idMarketDataFile " + 
						"in (select idMarketDataFile from MarketDataFile where " +
						"SUBSTRING(CAST(Convert(varchar(11), createdOn ,126) as varchar(11)),0,11) like '" + date + "') and isSoftDeleted=0";
			}

		}

		/*queryStr = "select * from MarketData where metadataName = '" + metadataName + "' and idMarketDataFile " + 
                   "in (select idMarketDataFile from MarketDataFile where " +
                   "SUBSTRING(CAST(Convert(varchar(11), createdOn ,126) as varchar(11)),0,11) like '" + date + "')";*/
		System.out.println("findImportDataByWeek----- Query---"+queryStr);
		org.hibernate.query.Query query = session.createNativeQuery(queryStr).addEntity(MarketData.class);
		List<MarketData> list = query.list();
		session.close();
		System.out.println(list.size());
		return list;
	
		
	}
	
	private boolean isRatingSame(String dbVal, String uiVal) {
		String arr[] = dbVal.split("/");
		String actualRating = arr[arr.length-1];
		if(actualRating.contains("+"))
			actualRating =  actualRating.substring(0, actualRating.indexOf("+"));
		else if(actualRating.contains("-"))
			actualRating =  actualRating.substring(0, actualRating.indexOf("-"));

		System.out.println("isRatingSame=" +actualRating + "uiVal="+uiVal);
		if(actualRating.equalsIgnoreCase(uiVal))
			return true;
		else
			return false;
	}

	private boolean isMaturitySame(String dbVal, Integer uiVal){
		Date today = new Date();
		String toDayStr = Utility.getDateString(today, "MM/dd/yyyy");
		Integer currYear = new Integer(toDayStr.split("/")[2]);
		//System.out.println("currYear - "+dbVal.split("/")[2]);
		if((new Integer(dbVal.split("/")[2])-currYear) <= uiVal){
			return true;
		}else{
			return false;
		}

	}
	
	private boolean isUnderTreasuryYR(String dbVal, Integer trMin, Integer trMax){
		Date today = new Date();
		String toDayStr = Utility.getDateString(today, "MM/dd/yyyy");
		Integer currYear = new Integer(toDayStr.split("/")[2]);
		Integer yearDiff = new Integer(dbVal.split("/")[2]) - currYear;
		System.out.println("yearDiff - " + yearDiff);
		if(yearDiff >= trMin && yearDiff <= trMax){
			return true;
		}else{
			return false;
		}

	}

	private boolean isYTWSame(String dbVal, Double uiValMin, Double uiValMax){

		try {
			if(!Utility.isNullOrEmpty(dbVal) && new Double(dbVal)>=uiValMin && new Double(dbVal) <= uiValMax){
				return true;
			}else{
				return false;
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}

	}

	private boolean isCallableSame(String dbVal, String uiVal){
		//System.out.println(dbVal + "  " + uiVal);
		if(uiVal.equalsIgnoreCase("no") && dbVal.equalsIgnoreCase("Non Callable")){

			return true;

		}else if(uiVal.equalsIgnoreCase("yes") && !dbVal.equalsIgnoreCase("Non Callable")){
			return true;
		}else{
			return false;
		}

	}

	private boolean isSecuredSame(String dbVal, String uiVal){

		if(uiVal.equalsIgnoreCase("no") && dbVal.equalsIgnoreCase("Sr. Unsecured")){

			return true;

		}else if(uiVal.equalsIgnoreCase("yes") && dbVal.equalsIgnoreCase("Sr. Secured")){
			return true;
		}else{
			return false;
		}

	}
	
	
	public List<ExtTransactionValuesDTO> getValuesDTODFromBulkTxnList(List<MarketData> list){


		List<ExtTransactionValuesDTO> dtoList = new ArrayList<ExtTransactionValuesDTO>();
		int i = 0;
		String dtoMethodName = "";
		String entityMethodName = "";
		String val = "";
		for(MarketData marketData : list){

			ExtTransactionValuesDTO extTransactionValuesDTO = new ExtTransactionValuesDTO();
			for(i = 1; i<=100; i++){
				dtoMethodName = "setElement" + i ;
				entityMethodName = "getElement" + i ;
				try {
					Method dtoMethod = extTransactionValuesDTO.getClass().getMethod(dtoMethodName, String.class);
					Method entityMethod = marketData.getClass().getMethod(entityMethodName);
					val = (String) entityMethod.invoke(marketData);
					//System.out.println(marketData + " *** " + val);
					if("Tickers_Watchlist".equalsIgnoreCase(marketData.getMetadataName())){
						if(i==7 || i==8 || i==11 || i==12 || i==13 || i==25){
							try {
								Double valInPercntg = new Double(val)*100;
								val = String.format("%.3f", valInPercntg) + "%";
							} catch (Exception e) {
								val = (String) entityMethod.invoke(marketData);
								//e.printStackTrace();
							}
						}
					}
					dtoMethod.invoke(extTransactionValuesDTO, val);

				} catch (Exception e) {
					e.printStackTrace();
				} 
			}
			extTransactionValuesDTO.setLastUpdatedAt(marketData.getLastUpdatedAt());
			extTransactionValuesDTO.setLastUpdatedBy(marketData.getLastUpdatedBy());

			if("Bondpricing_Master".equalsIgnoreCase(marketData.getMetadataName())){
				try {
					extTransactionValuesDTO.setElement9(String.format("%.2f", Double.parseDouble(extTransactionValuesDTO.getElement9())));
					extTransactionValuesDTO.setElement3(String.format("%.2f", Double.parseDouble(extTransactionValuesDTO.getElement3())));
					Double ytw = Double.parseDouble(extTransactionValuesDTO.getElement3());
					String year = extTransactionValuesDTO.getElement7().split("/")[2];
					Integer yearDiff = Integer.parseInt(year) - 2014; 
					extTransactionValuesDTO.setElement17(String.format("%.2f",new Double(ytw/yearDiff)));
				} catch (Exception e) {
					extTransactionValuesDTO.setElement17("N/A");
					e.printStackTrace();
				}
			}

			if("Everything_List".equalsIgnoreCase(marketData.getMetadataName())){

				try {
					Double perChangePrice = Double.parseDouble(extTransactionValuesDTO.getElement3());
					extTransactionValuesDTO.setElement3(String.format("%.3f", new Double(perChangePrice*100)));
				} catch (Exception e) {
					extTransactionValuesDTO.setElement3("N/A");
					e.printStackTrace();
				}

				try {
					Double fdayReutun = Double.parseDouble(extTransactionValuesDTO.getElement4());
					extTransactionValuesDTO.setElement4(String.format("%.3f", new Double(fdayReutun*100)));
				} catch (NumberFormatException e) {
					extTransactionValuesDTO.setElement4("N/A");
					e.printStackTrace();
				}

				try {
					Double twentyDayAvg = Double.parseDouble(extTransactionValuesDTO.getElement5());
					extTransactionValuesDTO.setElement5(String.format("%.3f", new Double(twentyDayAvg*100)));
				} catch (NumberFormatException e) {
					extTransactionValuesDTO.setElement5("N/A");
					e.printStackTrace();
				}

				try {
					Double ytdReturn = Double.parseDouble(extTransactionValuesDTO.getElement7());
					extTransactionValuesDTO.setElement7(String.format("%.3f", new Double(ytdReturn*100)));
				} catch (NumberFormatException e) {
					extTransactionValuesDTO.setElement7("N/A");
					e.printStackTrace();
				}

				try {
					Double dividendYield = 0.0;
					if(extTransactionValuesDTO.getElement8() == null || "-".equals(extTransactionValuesDTO.getElement8().trim()) )
						dividendYield = 0.0;
					else
						dividendYield = Double.parseDouble(extTransactionValuesDTO.getElement8());
					extTransactionValuesDTO.setElement8(String.format("%.3f", new Double(dividendYield*100)));
				} catch (NumberFormatException e) {
					extTransactionValuesDTO.setElement8("N/A");
					e.printStackTrace();
				}


			}

			if("Everything_List_New".equalsIgnoreCase(marketData.getMetadataName())){

				try {
					Double perChangePrice = Double.parseDouble(extTransactionValuesDTO.getElement5());
					extTransactionValuesDTO.setElement5(String.format("%.3f", new Double(perChangePrice*100)));
				} catch (Exception e) {
					extTransactionValuesDTO.setElement5("N/A");
					e.printStackTrace();
				}

				try {
					Double fdayReutun = 0.0;
					if(extTransactionValuesDTO.getElement6() == null || "-".equals(extTransactionValuesDTO.getElement6().trim()) )
						fdayReutun = 0.0;
					else
						fdayReutun = Double.parseDouble(extTransactionValuesDTO.getElement6());
					extTransactionValuesDTO.setElement6(String.format("%.3f", new Double(fdayReutun*100)));
				} catch (NumberFormatException e) {
					extTransactionValuesDTO.setElement6("N/A");
					e.printStackTrace();
				}

				try {
					Double twentyDayAvg = Double.parseDouble(extTransactionValuesDTO.getElement7());
					extTransactionValuesDTO.setElement7(String.format("%.3f", new Double(twentyDayAvg*100)));
				} catch (NumberFormatException e) {
					extTransactionValuesDTO.setElement7("N/A");
					e.printStackTrace();
				}

				try {
					Double ytdReturn = Double.parseDouble(extTransactionValuesDTO.getElement9());
					extTransactionValuesDTO.setElement9(String.format("%.3f", new Double(ytdReturn*100)));
				} catch (NumberFormatException e) {
					extTransactionValuesDTO.setElement9("N/A");
					e.printStackTrace();
				}

				try {
					Double dividendYield = 0.0;
					if(extTransactionValuesDTO.getElement10() == null || "-".equals(extTransactionValuesDTO.getElement10().trim()) )
						dividendYield = 0.0;
					else
						dividendYield = Double.parseDouble(extTransactionValuesDTO.getElement10());
					extTransactionValuesDTO.setElement10(String.format("%.3f", new Double(dividendYield*100)));
				} catch (NumberFormatException e) {
					extTransactionValuesDTO.setElement10("N/A");
					e.printStackTrace();
				}


			}

			dtoList.add(extTransactionValuesDTO);   
		}

		return dtoList;
	
		
	}
	
	
	public List<ExtTransactionValuesDTO> getCalculateBond(String couponMin, String couponMax, String ytwMin, String ytwMax, String maturityMin, String maturityMax,
			String rating, String callable, String secured, String treasuryYr, String treasuryYield, String metadataName){



		List<MarketData> list = findImportDataByWeek(metadataName, "1900-01-01");  
		List<MarketData> sortedList = new ArrayList<MarketData>();



		for (MarketData marketData : list) {

			boolean isRatingMatch = false;
			boolean isMAuturityMatch= false;
			boolean isYTWMatch = false;
			boolean iscallableMatch = false;
			boolean isSecuredMatch = false;
			boolean isTreasuryMappable = false;


			if(rating.equalsIgnoreCase("Any")){
				isRatingMatch = true;
			}else if(isRatingSame(marketData.getElement8(), rating)){
				isRatingMatch = true;
			}

			if(maturityMin.equalsIgnoreCase("Any") && maturityMax.equalsIgnoreCase("Any")){
				isMAuturityMatch = true;
			}else{
				if(maturityMin.equalsIgnoreCase("Any")){
					if(isMaturitySame(marketData.getElement7(), new Integer(maturityMax)-0)){
						isMAuturityMatch = true;
					}
				}else if(maturityMax.equalsIgnoreCase("Any")){
					if(isMaturitySame(marketData.getElement7(), 30-new Integer(maturityMin) )){
						isMAuturityMatch = true;
					}
				}else if(isMaturitySame(marketData.getElement7(), new Integer(maturityMax)-new Integer(maturityMin) )){
					isMAuturityMatch = true;
				}

			}

			if(ytwMin.equalsIgnoreCase("Any") && ytwMax.equalsIgnoreCase("Any")){
				isYTWMatch = true;
			}else{
				if(ytwMin.equalsIgnoreCase("Any")){
					if(isYTWSame(marketData.getElement3(), 0.0, new Double(ytwMax))){
						isYTWMatch = true;
					}
				}else if(ytwMax.equalsIgnoreCase("Any")){
					if(isYTWSame(marketData.getElement3(), new Double(ytwMin), 12.0)){
						isYTWMatch = true;
					}
				}else if(isYTWSame(marketData.getElement3(), new Double(ytwMin), new Double(ytwMax))){
					isYTWMatch = true;
				}
			}

			if(callable.equalsIgnoreCase("Any")){
				iscallableMatch = true;
			}else if(isCallableSame(marketData.getElement4(), callable)){
				iscallableMatch = true;
			}

			if(secured.equalsIgnoreCase("Any")){
				isSecuredMatch = true;
			}else if(isSecuredSame(marketData.getElement6(), secured)){
				isSecuredMatch = true;
			}
			//System.out.println(iscallableMatch +" "+isSecuredMatch+" "+isMAuturityMatch);
			/******************** code for treasury spread ***************************/
			
			String treasuryMaturityMin = "";
			String treasuryMaturityMax = "";

			if(treasuryYr.equalsIgnoreCase("Any") || treasuryYield==null || "".equals(treasuryYield)  ){
				isTreasuryMappable = true;
			}else{ 
				if(treasuryYr.equals("20+")){
					treasuryMaturityMin = "20";
					treasuryMaturityMax = "200";
				}else{
					treasuryMaturityMin = treasuryYr.split("-")[0];
					treasuryMaturityMax = treasuryYr.split("-")[1];
				}
				
				if (isUnderTreasuryYR(marketData.getElement7(), new Integer(treasuryMaturityMin),new Integer(treasuryMaturityMax) )){

					isTreasuryMappable = true;
					Double attractiveIndex = Double.valueOf(marketData.getElement3()) - Double.valueOf(treasuryYield);
					marketData.setAttractionIndex(String.valueOf(attractiveIndex));
					
					marketData.setElement16(String.format("%.2f",attractiveIndex));
				}
			}

			System.out.println("iscallableMatch="+iscallableMatch+"isSecuredMatch="+isSecuredMatch+"isMAuturityMatch"+isMAuturityMatch
					+"isYTWMatch="+isYTWMatch+"isRatingMatch"+isRatingMatch);
			if(iscallableMatch&&isSecuredMatch&&isMAuturityMatch&&isYTWMatch&&isRatingMatch){
				sortedList.add(marketData);
			}

		}

		Collections.sort(sortedList);
		System.out.println(sortedList.size());

		for(MarketData marketData : sortedList){
		//	System.out.println(marketData.getIdMarketData() + " " + marketData.getElement1() + "  " 
		//			+marketData.getElement8() + " " + marketData.getElement7() + " " + marketData.getAttractionIndex() ); 
		}
		List<ExtTransactionValuesDTO> rankList =getValuesDTODFromBulkTxnList(sortedList);
		System.out.println("rankList size = " + rankList.size());
		return rankList;

	
		
	}

	@Override
	public List<ExtTransactionValuesDTO> getCalculateTicker(String metadataName, String date, String rankWithinTable,
			String relativeStrength, String priceVs20DAvg, boolean isHighPerforming) {


		// I/P : db q :  metadataName,  date, rankWithinTable,  relativeStrength,  priceVs20DAvg 
		if(Utility.isNullOrEmpty(rankWithinTable)){
			rankWithinTable = "0.0";
		}
		if(Utility.isNullOrEmpty(relativeStrength)){
			relativeStrength = "0.0";
		}
		if(Utility.isNullOrEmpty(priceVs20DAvg)){
			priceVs20DAvg = "0.0";
		}
		System.out.println("getStocksOnAlgo : rank = " + rankWithinTable + " rel strength = " + relativeStrength +" pv20dAvg = " + priceVs20DAvg);
		// System.out.println("getStocksOnAlgo : eps = " + eps + " ytd = " + ytd +" peg = " + priceVs20DAvg);
		try {
			List<MarketData> list = findStockWith3ConsecutiveRank(metadataName, date,Double.valueOf(rankWithinTable), 
					Double.valueOf(relativeStrength), Double.valueOf(priceVs20DAvg), isHighPerforming);

			Collections.sort(list, new StockComparator());

			List<ExtTransactionValuesDTO> realTimeEqList = getValuesDTODFromBulkTxnList(list);
			System.out.println("getStocksOnAlgo : realTimeEqList size = " + realTimeEqList.size());
			return realTimeEqList;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
			
	}

	@Override
	public List<MarketData> findStockWith3ConsecutiveRank(String metadata, String date, Double rankWithInTable,
			Double relativeStrength, Double priceV20DAvg, boolean isHighPerforming) {
		Session session = null; 
		session = sessionFactory.openSession(); 
		String queryStr = "";

		String sign = isHighPerforming == true ? ">" : "<";
		String signOpp = isHighPerforming == true ? "<" : ">";

		 queryStr = "select element1 from MarketData where metadataName = '" + metadata +"' and CHARINDEX('.',element3) > 0 "+ 
				" and cast(LTRIM(RTRIM(element3)) AS float) " + signOpp + " " + rankWithInTable ;
				
				if(relativeStrength != 0.0) {
					queryStr = queryStr +" and CASE WHEN TRY_PARSE(element18 as float) IS NULL THEN 0 ELSE cast(LTRIM(RTRIM(element18)) AS float) END " +
								sign + relativeStrength ;
				}
				
				if(priceV20DAvg != 0.0) {
					queryStr = queryStr +" and CASE WHEN TRY_PARSE(element9 as float) IS NULL THEN 0 ELSE cast(LTRIM(RTRIM(element9)) AS float)*100 END "
											+ sign + priceV20DAvg ;
				}
				
				queryStr = queryStr+
				
				" and idMarketDataFile in (select top(1) idMarketDataFile from MarketDataFile where "+ 
				"metadataName = '" + metadata +"' order by idMarketDataFile desc ) and isSoftDeleted=0 "+
				"INTERSECT "+
				"select element1 from MarketData where metadataName = '" + metadata +"' and CHARINDEX('.',element3) > 0 "+ 
				"and cast(LTRIM(RTRIM(element3)) AS float) " + signOpp + rankWithInTable +
				//"and CASE WHEN TRY_PARSE(element18 as float) IS NULL THEN 0 ELSE cast(LTRIM(RTRIM(element18)) AS float) END > " + relativeStrength +
				//"and CASE WHEN TRY_PARSE(element9 as float) IS NULL THEN 0 ELSE cast(LTRIM(RTRIM(element9)) AS float) END > " + priceV20DAvg +
				" and idMarketDataFile in (select top(1) idMarketDataFile "+
				"from MarketDataFile where "+
				"idMarketDataFile in (select top 2 idMarketDataFile from MarketDataFile "+ 
				"where metadataName = '" + metadata +"' order by idMarketDataFile desc) "+
				"order by idMarketDataFile ) and isSoftDeleted=0 "+
				"INTERSECT  "+
				"select element1 from MarketData where metadataName = '" + metadata +"' and CHARINDEX('.',element3) > 0 "+ 
				"and cast(LTRIM(RTRIM(element3)) AS float) " + signOpp + rankWithInTable +
				//"and CASE WHEN TRY_PARSE(element18 as float) IS NULL THEN 0 ELSE cast(LTRIM(RTRIM(element18)) AS float) END > " + relativeStrength +
				//"and CASE WHEN TRY_PARSE(element9 as float) IS NULL THEN 0 ELSE cast(LTRIM(RTRIM(element9)) AS float) END > " + priceV20DAvg +
				" and idMarketDataFile in (select top(1) idMarketDataFile "+
				"from MarketDataFile where "+
				"idMarketDataFile in (select top 3 idMarketDataFile from MarketDataFile "+ 
				"where metadataName = '" + metadata +"' order by idMarketDataFile desc) "+
				"order by idMarketDataFile ) and isSoftDeleted=0 ";

		/* queryStr = "select element1 from MarketData where metadataName = '" + metadata +"' and CHARINDEX('.',element3) > 0 "+ 
				"and cast(LTRIM(RTRIM(element3)) AS float) " + signOpp + " " + rankWithInTable +
				"and CASE WHEN TRY_PARSE(element18 as float) IS NULL THEN 0 ELSE cast(LTRIM(RTRIM(element18)) AS float) END " + sign + relativeStrength +
				"and CASE WHEN TRY_PARSE(element9 as float) IS NULL THEN 0 ELSE cast(LTRIM(RTRIM(element9)) AS float)*100 END " + sign + priceV20DAvg +
				" and idMarketDataFile in (select top(1) idMarketDataFile from MarketDataFile where "+ 
				"metadataName = '" + metadata +"' order by idMarketDataFile desc ) and isSoftDeleted=0 "+
				"INTERSECT "+
				"select element1 from MarketData where metadataName = '" + metadata +"' and CHARINDEX('.',element3) > 0 "+ 
				"and cast(LTRIM(RTRIM(element3)) AS float) " + signOpp + rankWithInTable +
				//"and CASE WHEN TRY_PARSE(element18 as float) IS NULL THEN 0 ELSE cast(LTRIM(RTRIM(element18)) AS float) END > " + relativeStrength +
				//"and CASE WHEN TRY_PARSE(element9 as float) IS NULL THEN 0 ELSE cast(LTRIM(RTRIM(element9)) AS float) END > " + priceV20DAvg +
				" and idMarketDataFile in (select top(1) idMarketDataFile "+
				"from MarketDataFile where "+
				"idMarketDataFile in (select top 2 idMarketDataFile from MarketDataFile "+ 
				"where metadataName = '" + metadata +"' order by idMarketDataFile desc) "+
				"order by idMarketDataFile ) and isSoftDeleted=0 "+
				"INTERSECT  "+
				"select element1 from MarketData where metadataName = '" + metadata +"' and CHARINDEX('.',element3) > 0 "+ 
				"and cast(LTRIM(RTRIM(element3)) AS float) " + signOpp + rankWithInTable +
				//"and CASE WHEN TRY_PARSE(element18 as float) IS NULL THEN 0 ELSE cast(LTRIM(RTRIM(element18)) AS float) END > " + relativeStrength +
				//"and CASE WHEN TRY_PARSE(element9 as float) IS NULL THEN 0 ELSE cast(LTRIM(RTRIM(element9)) AS float) END > " + priceV20DAvg +
				"and idMarketDataFile in (select top(1) idMarketDataFile "+
				"from MarketDataFile where "+
				"idMarketDataFile in (select top 3 idMarketDataFile from MarketDataFile "+ 
				"where metadataName = '" + metadata +"' order by idMarketDataFile desc) "+
				"order by idMarketDataFile ) and isSoftDeleted=0 "; */
		 
		 System.out.println("Query in findStockWith3ConsecutiveRank---"+queryStr);

		
		 org.hibernate.query.Query query = session.createSQLQuery(queryStr)
				.addScalar("element1", new StringType());

		

		String tickers = "'";
		List results = query.list();

		if (!Utility.isNullOrEmpty(results)) {
			Iterator itr = results.iterator();
			while (itr.hasNext()) {
				Object column = (Object) itr.next();
				tickers += column.toString()+"','";
			}
		}else{
			tickers = "'";
		}
		session.close();
		System.out.println("Got the tickers ... " + tickers);
		if(tickers.contains("','")){
			tickers = tickers.substring(0, tickers.lastIndexOf("','"));
			return findStockOnAlgo(tickers, metadata, date);
		}else{
			return new ArrayList<MarketData>();
		}


	
	}
	
	private List<MarketData> findStockOnAlgo(String tickers, String metadataName, String date) {
		List<MarketData> list = new ArrayList<MarketData>();
		Session session = null; 
		session = sessionFactory.openSession(); 
		String queryStr = "";
		System.out.println("Applying other filters ... ");
		if(!tickers.equals("'")){
			queryStr = "select * from MarketData where metadataName = '" + metadataName + "' and idMarketDataFile " + 
					"in (select max(idMarketDataFile) from MarketDataFile where metadataName = '" + metadataName + "') and isSoftDeleted=0 "+
					" and element1 in (" + tickers + "')  order by element1";
			org.hibernate.query.Query query = session.createNativeQuery(queryStr).addEntity(MarketData.class);
			list = query.list();
		}

		session.close();
		System.out.println("List for current wk = " + list.size());
		//session = HibernateUtils.getSession();
		session = sessionFactory.openSession(); 

		String fetchPrevWkQ = "select * from MarketData where metadataName = '" + metadataName +
				"' and idMarketDataFile in (select top(1) idMarketDataFile "+
				"from MarketDataFile where "+
				"idMarketDataFile in (select top 2 idMarketDataFile from MarketDataFile "+ 
				"where metadataName = '" + metadataName +"' order by idMarketDataFile desc) "+
				"order by idMarketDataFile ) and isSoftDeleted=0 and element1 in (" + tickers + "') order by element1";

		org.hibernate.query.Query prevWkQuery = session.createNativeQuery(fetchPrevWkQ).addEntity(MarketData.class);
		List prevWkList = prevWkQuery.list();
		System.out.println("prevWkList for prev wk = " + prevWkList.size());
		session.close();

		List<MarketData> finalList = new ArrayList<MarketData>();
		Iterator<MarketData> itr = prevWkList.iterator();
		for(MarketData marketData : list){
			MarketData prevMD = (MarketData)itr.next();
			//System.out.println("***** " + marketData.getElement1() + " **** " + prevMD.getElement1());
			if(marketData.getElement1().equals(prevMD.getElement1())){
				Double diffInPrice = 0.0;
				Double diffInYTD = 0.0;
				try {
					diffInPrice = Double.parseDouble(marketData.getElement10()) - Double.parseDouble(prevMD.getElement10()); 
					diffInYTD = Double.parseDouble(marketData.getElement11()) - Double.parseDouble(prevMD.getElement11());
				} catch (Exception e) {
					e.printStackTrace();
				}
				MarketData newMD = new MarketData();
				newMD = marketData;
				newMD.setElement100(diffInYTD.toString());
				newMD.setElement99(diffInPrice.toString());
				finalList.add(newMD);
			}
		}
		System.out.println("finalList = " + finalList.size());
		return finalList;
	}

	@Override
	public List<ExtTransactionValuesDTO> getImportDataByWeek(String metadataName, String date) {
		// TODO Auto-generated method stub
		List<MarketData> list = findImportDataByWeek(metadataName, date);
		try {
			Collections.sort(list);
		} catch (Exception e) {
			System.out.println("Exception -------------------------------------");
			e.printStackTrace();
		}
		List<ExtTransactionValuesDTO> realTimeEqList = getValuesDTODFromBulkTxnList(list);
		System.out.println("realTimeEqList size = " + realTimeEqList.size());
		return realTimeEqList;
	}
	@Override
	public List<StockDTO> getAllFavStocks(){
		List<StockDTO> stockDTOList = new ArrayList<StockDTO>();
		stockDTOList = findStockDTOByUser(2L); // Assuming 2L as Admin UserId		
		return stockDTOList;
	}
	
	public List<StockDTO> findStockDTOByUser(Long idUser){

		Session session = null; 
		session = sessionFactory.openSession(); 
		String queryStr = "select Stock.idStock, stockName, userStockSet.isSelectedforWeekly FROM userStockSet, Stock"
				+ " WHERE userStockSet.idStock = Stock.idStock AND userStockSet.idUser = "+idUser +" order by isSelectedforWeekly desc";
		System.out.println("findStockDTOByUser  Query---"+queryStr);

		org.hibernate.query.Query query = session.createNativeQuery(queryStr)
				.addScalar("idStock", new LongType())
				.addScalar("stockName", new StringType())
				.addScalar("isSelectedforWeekly", new BooleanType());

		List results = query.list();

		List<StockDTO> stockDTOList = new ArrayList<StockDTO>();

		if (results != null) {
			Iterator itr = results.iterator();
			while (itr.hasNext()) {
				Object[] columns = (Object[]) itr.next();	

				StockDTO stockDTO = new StockDTO();
				//String stockName="";
				//System.out.println("stockName-"+stockName);
				stockDTO.setIdStock(Long.parseLong(columns[0].toString()));
				stockDTO.setStockName(columns[1].toString());
				stockDTO.setIsSelectedforWeekly(Boolean.parseBoolean(columns[2].toString()));
				//System.out.println("stockDTO.getStockName()--"+stockDTO.getStockName());
				if(stockDTO.getIsSelectedforWeekly() )
					stockDTO.setCheckBoxHtml("<input type='checkbox' checked name='dateChkBox' value='" + stockDTO.getStockName() + "'>");
				else
					stockDTO.setCheckBoxHtml("<input type='checkbox' name='dateChkBox' value='" + stockDTO.getStockName() + "'>");
				stockDTOList.add(stockDTO);
			}

		}

		session.close();

		return stockDTOList;

	}
	
	
	@Override
	public List<StockDTO> getAllWeeklySector() {
		List<String> results = new ArrayList<String>();
		List<StockDTO> stocks = new ArrayList<StockDTO>();
		results = stockDao.findAllWeeklySector();
		
		for (String sector : results) {
			StockDTO stockDTO = new StockDTO();
			stockDTO.setSector(sector); 
			stocks.add(stockDTO);
		}
		
		return stocks;
	}
	
	public void saveWeeklyStocks(List<String> stockNames, Long userId)
	{
		
		//String connectionURL = Constants.CONNECTION_URL;
		Connection con = null;
		PreparedStatement pstmt = null;

		Session session = null; 
		session = sessionFactory.openSession(); 

		String queryStr = "select * from Stock where stockName in ( ";
		for (String stockName : stockNames) {
			queryStr = queryStr + "'"+ stockName +  "', ";
		}
		queryStr = queryStr.substring(0, queryStr.length() -2);
		queryStr = queryStr + ")";

		System.out.println("queryStr in saveWeeklyStocks -- "+queryStr);

		org.hibernate.query.Query query = session.createNativeQuery(queryStr).addEntity(Stock.class);
		List<Stock> list = query.list();
		if(list != null)
			System.out.println("list.size() -- "+list.size()); 

		session.close();
		
		try {
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			//con = DriverManager.getConnection (connectionURL);
			con = DriverManager.getConnection (Constants.CONNECTION_URL, Constants.CONNECTION_U_NAME, Constants.CONNECTION_U_PWD);
			System.out.println("Connection = "+ con);
			pstmt = con.prepareStatement("UPDATE userStockSet set isSelectedforWeekly = 0 WHERE idUser = "+ userId);
			int status = pstmt.executeUpdate();
			System.out.println("User Stock set has been updated "+status);

			for (Stock stock : list) {
				//stock.setIsSelectedforWeekly(true); 
				//update(stock);
				//pstmt = con.prepareStatement("INSERT INTO userStockSet VALUES ( "+ userId+","+ stock.getIdStock()+","+ 1+")");
				pstmt = con.prepareStatement("UPDATE userStockSet set isSelectedforWeekly = 1 WHERE idUser = "+ userId + " AND idStock = "+stock.getIdStock());
				status = pstmt.executeUpdate();
				System.out.println("User Stock set has been updated "+status);

			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try {
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			System.out.println("END TIME ----- " + Calendar.getInstance().getTime());
		}

	}

	
	/*
	public Set<Stock> findStockByUser(Long idUser){

		Session session = null; 
		session = sessionFactory.openSession();
		String queryStr = "select * from tblUser where idUser="+idUser;
		System.out.println("findStockByUser--- Query-"+queryStr);
		org.hibernate.query.Query query = session.createNativeQuery(queryStr).addEntity(User.class);
		User user = (User) query.list().get(0);
		Set<Stock> stockSet = user.getStocks();
		session.close();
		return stockSet;

	}
	public Set<Stock> mapStocksWithUser1(Long userId, Set<Stock> stockList) {   */

		/*StockDAO stockDAO = new StockDAO();
		Set<Stock> stocks = new HashSet<Stock>();

		for(Stock stock : stockList){
			Stock stock = stockDAO.findStockByName(stockName);
			stocks.add(stock);
		}*/
		
	/*	Session session = null; 
		session = sessionFactory.openSession();

		User user = userDAORepository.findUserById(userId);
		user.setStocks(stockList);
		session.update(user);

		Set<User> userSet = new HashSet<User>();
		userSet.add(user);

		for(Stock stock:stockList){
			stock.setUsers(userSet);
			session.update(stock);
		}
		session.close();
		return findStockByUser(userId);

	}
	
	private Set<Stock> getDataListFromDTOList(Set<StockDTO> stockDTOList) throws Exception{
		Set<Stock> stockList = new HashSet<Stock>();
		for(StockDTO stockDTO : stockDTOList){
			
			Stock stock = new Stock();
			stock.setIdStock(new Long(stockDTO.getIdStock().toString()));
			stock.setStockName(stockDTO.getStockName());
			stock.setCompany(stockDTO.getCompany());
			stock.setSector(stockDTO.getSector());
			stock.setIndustry(stockDTO.getIndustry());
			stock.setCountry(stockDTO.getCountry());
			stock.setMarketCapital(stockDTO.getMarketCapital());
			stock.setAvgAnnualPE(stockDTO.getAvgAnnualPE());
			stockList.add(stock); 
		}
		System.out.println("stockDTOList.size() -- "+stockList.size()); 
		return stockList;
	}
	private List<StockDTO> getDTOListFromDataList(List<Stock> stokList) throws Exception{
		List<StockDTO> stockDTOList = new ArrayList<StockDTO>();
		for(Stock stock : stokList){
			StockDTO stockDTO = new StockDTO();
			stockDTO.setIdStock((Number)stock.getIdStock());
			stockDTO.setStockName(stock.getStockName());
			stockDTO.setCompany(stock.getCompany());
			stockDTO.setSector(stock.getSector());
			stockDTO.setIndustry(stock.getIndustry());
			stockDTO.setCountry(stock.getCountry());
			stockDTO.setMarketCapital(stock.getMarketCapital());
			stockDTO.setAvgAnnualPE(stock.getAvgAnnualPE());
			stockDTO.setIsSelected(Boolean.FALSE);
			stockDTOList.add(stockDTO); 
		}
		System.out.println("stockDTOList.size() -- "+stockDTOList.size()); 
		return stockDTOList;
	}
	
	public List<StockDTO> mapStocksWithUser(Long userId, Set<StockDTO> stockDTOList) throws Exception{

		Set<Stock> stockSet = mapStocksWithUser1(userId, getDataListFromDTOList(stockDTOList));
		return getDTOListFromDataList(new ArrayList<Stock>(stockSet));
	}
	
	private Set<Bond> getDataListFromDTOListBond(Set<BondDTO> bondDTOList) {
		Set<Bond> bondList = new HashSet<Bond>();
		for(BondDTO bondDTO : bondDTOList){
			
			Bond bond = new Bond();
			bond.setIdBond(new Long(bondDTO.getIdBond().toString()));
			bond.setIssuerName(bondDTO.getIssuerName());
			bond.setType(bondDTO.getType());
			bond.setCusip(bondDTO.getCusip());
			bond.setYtm(bondDTO.getYtm());
			bond.setCoupon(bondDTO.getCoupon());
			bond.setMaturity(bondDTO.getMaturity());
			bondList.add(bond); 
		}
		System.out.println("bondList.size() -- "+bondList.size()); 
		return bondList;
	}
	
	private List<BondDTO> getDTOListFromDataListBond(List<Bond> bondList) throws Exception{
		List<BondDTO> bondDTOList = new ArrayList<BondDTO>();
		for(Bond bond : bondList){
			BondDTO bondDTO = new BondDTO();
			
			bondDTO.setIdBond((Number)bond.getIdBond());
			bondDTO.setIssuerName(bond.getIssuerName());
			bondDTO.setType(bond.getType());
			bondDTO.setCusip(bond.getCusip());
			
			bondDTO.setYtm(bond.getYtm());
			bondDTO.setCoupon(bond.getCoupon());
			bondDTO.setMaturity(bond.getMaturity());
			
			bondDTOList.add(bondDTO); 
		}
		System.out.println("bondDTOList.size() -- "+bondDTOList.size()); 
		return bondDTOList;
	}
	private Set<Bond> findBondsByUser(Long idUser){
		Session session = null; 
		session = sessionFactory.openSession();
		String queryStr = "select * from tblUser where idUser="+idUser;
		System.out.println("Weekly Bond Query--"+queryStr);
		org.hibernate.query.Query query = session.createNativeQuery(queryStr).addEntity(User.class);
		User user = (User) query.list().get(0);
		Set<Bond> bondSet = user.getBonds();
		session.close();
		return bondSet;

	}
	
	public List<BondDTO> mapBondsWithUser(Long userId, Set<BondDTO> bondDTOList) throws Exception{
		
		Set<Bond> bondList = getDataListFromDTOListBond(bondDTOList);
		
		Session session = null; 
		session = sessionFactory.openSession();
		User user = userDAORepository.findUserById(userId);
		user.setBonds(bondList);
		
		session.update(user);
		
		Set<User> userSet = new HashSet<User>();
		userSet.add(user);
		
		for(Bond bond : bondList){
			bond.setUsers(userSet);
			session.update(bond);
		}
		session.close();
		
		return getDTOListFromDataListBond(new ArrayList<Bond>(findBondsByUser(userId)));

	}
	
*/
	@Override
	public List<CompareHistoryDataDTO> getHistoricalDataByStockAndDate(String stockA, String stockB, String stockC, String stockD,
			String startDate,String endDate){

		System.out.println("Service :: getHistoricalDataByStockAndDate :: list1");
		List<MarketHistoryData> list1 = marketHistoryDataDao.
		findHistoricalDataByStockAndDate(stockA, startDate, endDate);

		System.out.println("Service :: getHistoricalDataByStockAndDate :: list2");
		List<MarketHistoryData> list2 = marketHistoryDataDao.
		findHistoricalDataByStockAndDate(stockB, startDate, endDate);
		
		System.out.println("Service :: getHistoricalDataByStockAndDate :: list3");
		List<MarketHistoryData> list3 = marketHistoryDataDao.
				findHistoricalDataByStockAndDate(stockC, startDate, endDate);
		
		System.out.println("Service :: getHistoricalDataByStockAndDate :: list4");
		List<MarketHistoryData> list4 = marketHistoryDataDao.
				findHistoricalDataByStockAndDate(stockD, startDate, endDate);
		
		List<CompareHistoryDataDTO> historicalStockList = new ArrayList<CompareHistoryDataDTO>();
		
		if(stockC != null && stockC.length() > 0 && stockD != null && stockD.length() > 0){
			historicalStockList = getValuesDTODFromHistoricalMarketList(list1, list2, list3, list4);
		}else{
			historicalStockList = getValuesDTODFromHistoricalMarketList(list1, list2);
		}

		

		return historicalStockList;
	}
	
	private List<CompareHistoryDataDTO> getValuesDTODFromHistoricalMarketList(List<MarketHistoryData> list1,
			List<MarketHistoryData> list2, List<MarketHistoryData> list3, List<MarketHistoryData> list4) {

		List<MarketHistoryData> biggerList = new ArrayList<MarketHistoryData>();
		List<MarketHistoryData> shorterList = new ArrayList<MarketHistoryData>();
		List<MarketHistoryData> biggerListC = new ArrayList<MarketHistoryData>();
		List<MarketHistoryData> shorterListC = new ArrayList<MarketHistoryData>();
		List<CompareHistoryDataDTO> dtoList1 = new ArrayList<CompareHistoryDataDTO>();
		List<CompareHistoryDataDTO> dtoList2 = new ArrayList<CompareHistoryDataDTO>();
		List<CompareHistoryDataDTO> dtoList = new ArrayList<CompareHistoryDataDTO>();
		boolean stockAisBigger = true;
		boolean stockCisBigger = true;
		if(list1.size() > list2.size()){
			biggerList = list1;
			shorterList = list2;
		}else{
			biggerList = list2;
			shorterList = list1;
			stockAisBigger = false;
		}
		
		if(list3.size() > list4.size()){
			biggerListC = list3;
			shorterListC = list4;
		}else{
			biggerListC = list4;
			shorterListC = list3;
			stockCisBigger = false;
		}
		
		for(MarketHistoryData historyMarketData1 : biggerList){

			for (MarketHistoryData historyMarketData2 : shorterList){
				if(historyMarketData1.getElement2().equals(historyMarketData2.getElement2())){
					CompareHistoryDataDTO compareHistoryDataDTO = new CompareHistoryDataDTO();
					compareHistoryDataDTO.setDate(historyMarketData2.getElement2());
					if(stockAisBigger){
						compareHistoryDataDTO.setFirstParamVal(String.format("%.2f", new Double(historyMarketData1.getElement6())));
						compareHistoryDataDTO.setSecondParamVal(String.format("%.2f", new Double(historyMarketData2.getElement6())));
					}else{
						compareHistoryDataDTO.setFirstParamVal(String.format("%.2f", new Double(historyMarketData2.getElement6())));
						compareHistoryDataDTO.setSecondParamVal(String.format("%.2f", new Double(historyMarketData1.getElement6())));
					}
					if(stockAisBigger){
						compareHistoryDataDTO.setRatio(String.format("%.2f",
								new Double(historyMarketData1.getElement6())/new Double(historyMarketData2.getElement6())));
					}else{
						compareHistoryDataDTO.setRatio(String.format("%.2f",
								new Double(historyMarketData2.getElement6())/new Double(historyMarketData1.getElement6())));
					}
					dtoList1.add(compareHistoryDataDTO);
				}
			}
		}
		
		
		
		for(MarketHistoryData historyMarketData1 : biggerListC){

			for (MarketHistoryData historyMarketData2 : shorterListC){
				if(historyMarketData1.getElement2().equals(historyMarketData2.getElement2())){
					CompareHistoryDataDTO compareHistoryDataDTO = new CompareHistoryDataDTO();
					compareHistoryDataDTO.setDate(historyMarketData2.getElement2());
					if(stockCisBigger){
						compareHistoryDataDTO.setThirdParamVal(String.format("%.2f", new Double(historyMarketData1.getElement6())));
						compareHistoryDataDTO.setFourthParamVal(String.format("%.2f", new Double(historyMarketData2.getElement6())));
					}else{
						compareHistoryDataDTO.setThirdParamVal(String.format("%.2f", new Double(historyMarketData2.getElement6())));
						compareHistoryDataDTO.setFourthParamVal(String.format("%.2f", new Double(historyMarketData1.getElement6())));
					}
					if(stockCisBigger){
						compareHistoryDataDTO.setRatioThirdFourth(String.format("%.2f",
								new Double(historyMarketData1.getElement6())/new Double(historyMarketData2.getElement6())));
					}else{
						compareHistoryDataDTO.setRatioThirdFourth(String.format("%.2f",
								new Double(historyMarketData2.getElement6())/new Double(historyMarketData1.getElement6())));
					}
					dtoList2.add(compareHistoryDataDTO);
				}
			}
		}
		
		//int count1 = 0;
		
		System.out.println("dtoList1 size --> "+dtoList1.size()); 
		System.out.println("dtoList2 size --> "+dtoList2.size()); 
		
		for (CompareHistoryDataDTO compareHistoryDataDTO1 : dtoList1) {
			//int count2 = count1;
			//count1 ++;
			
			for (CompareHistoryDataDTO compareHistoryDataDTO2 : dtoList2) {
				//count2 ++;
				//log.info("count1 --> "+count1+ " count2 --> " +count2); 
				System.out.println("3 --> "+compareHistoryDataDTO2.getThirdParamVal()); 
				System.out.println("1 --> "+compareHistoryDataDTO1.getFirstParamVal()); 
				if(compareHistoryDataDTO2.getDate().equalsIgnoreCase(compareHistoryDataDTO1.getDate())){//if(count1 == count2){
					compareHistoryDataDTO2.setFirstParamVal(compareHistoryDataDTO1.getFirstParamVal());
					compareHistoryDataDTO2.setSecondParamVal(compareHistoryDataDTO1.getSecondParamVal());
					compareHistoryDataDTO2.setRatio(compareHistoryDataDTO1.getRatio()); 
					dtoList.add(compareHistoryDataDTO2);
				}
			}
		}

		return dtoList;
	}
	
	private List<CompareHistoryDataDTO> getValuesDTODFromHistoricalMarketList(List<MarketHistoryData> list1,
			List<MarketHistoryData> list2) {

		List<MarketHistoryData> biggerList = new ArrayList<MarketHistoryData>();
		List<MarketHistoryData> shorterList = new ArrayList<MarketHistoryData>();
		List<CompareHistoryDataDTO> dtoList = new ArrayList<CompareHistoryDataDTO>();

		if(list1.size() > list2.size()){
			biggerList = list1;
			shorterList = list2;
		}else{
			biggerList = list2;
			shorterList = list1;
		}
		for(MarketHistoryData historyMarketData1 : biggerList){

			for (MarketHistoryData historyMarketData2 : shorterList){
				if(historyMarketData1.getElement2().equals(historyMarketData2.getElement2())){
					CompareHistoryDataDTO compareHistoryDataDTO = new CompareHistoryDataDTO();
					compareHistoryDataDTO.setDate(historyMarketData2.getElement2());
					compareHistoryDataDTO.setFirstParamVal(historyMarketData1.getElement6());
					compareHistoryDataDTO.setSecondParamVal(historyMarketData2.getElement6());
					compareHistoryDataDTO.setRatio(
							new Double((new Double(historyMarketData1.getElement6())/new Double(historyMarketData2.getElement6()))).toString());
					dtoList.add(compareHistoryDataDTO);
				}
			}
		}

		return dtoList;
	}
	
	public List<MarketHistoryData> findHistoricalStockDataByDateWithPercentageChanges(List<String> stockList, String date,String endDate){

		// List<String> stockList could be fetched from loggedInUsers userStockSet
		// pass idUser as input
		// call the below method ...
		/*Set<Stock> stocks = new StockDAO().findStockByUser(idUser);
		List<String> stockList = new ArrayList<String>();
		for(Stock stock : stocks){
			stockList.add(stock.getStockName());
		}*/
		
		String stockNames = "";
		for(String stock : stockList ){
			
			if(!Utility.isNullOrEmpty(stock))
				stockNames += ",'" + stock + "'";  
		}

		stockNames = stockNames.substring(stockNames.indexOf(",")+1, stockNames.length());

		Session session = null; 
		session = sessionFactory.openSession();
		String queryStr = "";
		System.out.println(" findHistoricalStockDataByDateWithPercentageChanges Service stockNames="+stockNames);
		queryStr = "select  t.* from MarketHistoryData t " +
		"join ( " +
		" Select  element1, COUNT(element1)  As 'SameDOB' from MarketHistoryData " +
		" where element1 in (" + stockNames + ") " + 
		" group by element1 " + 
		" HAVING (COUNT(element1) > 1) " +
		" ) a on a.element1 = t.element1 AND DATENAME(WEEKDAY,Cast(element2 as datetime)) = 'friday'" +
		" AND Cast(element2 as datetime) between '" + date + "' and '" + endDate + "'";

		//select * from MarketHistoryData where element1 in ('XLV','XLP','XLF')
		//and Cast(element2 as datetime) in ('2014-09-18')
		
		System.out.println("findHistoricalStockDataByDateWithPercentageChanges-- "+queryStr);
		org.hibernate.query.Query query = session.createNativeQuery(queryStr).addEntity(MarketHistoryData.class);
		List list = query.list();
		System.out.println(list.size());
		session.close();
		return list;
	
		
	}
	
	public List<WeekToWeekStockCompareDTO> findHistoricalStockDataByDateWithPercentageChange(List<String> stockList,String startDate,String endDate){


		List<MarketHistoryData> historyStockList =findHistoricalStockDataByDateWithPercentageChanges(stockList, startDate, endDate);
		//List<WeekToWeekStockCompareDTO> list = new ArrayList<WeekToWeekStockCompareDTO>();
		List<WeekToWeekStockCompareDTO> tempList = new ArrayList<WeekToWeekStockCompareDTO>();
		List<WeekToWeekStockCompareDTO> finalList = new ArrayList<WeekToWeekStockCompareDTO>();
		Map<Double, List<WeekToWeekStockCompareDTO>> finalMap = new HashMap<Double, List<WeekToWeekStockCompareDTO>>();
		Iterator<MarketHistoryData> iterator = historyStockList.iterator();
		MarketHistoryData temp = null;
		MarketHistoryData historyData1 = null;
		MarketHistoryData historyData2 = null;
		boolean first = true;

		WeekToWeekStockCompareDTO cummulativestockCompareDTO = null;
		Double cummulativeChangeVal = 0.0;
		Double cummulativeChangeValPerct = 0.0;
		Double change = 0.0;
		Double percentageChange = 0.0;
		boolean hasChanged = false;
		String prevTicker = "";

		while(iterator.hasNext()){
			if(first){
				historyData1 = (MarketHistoryData)iterator.next();
				first = false;
			}
			else
				historyData1 = temp;
			
			if(iterator.hasNext()){
				historyData2 = (MarketHistoryData)iterator.next();
				if(historyData2!=null && historyData1!=null && !historyData2.getElement1().equals(historyData1.getElement1())){
					//hasChanged = true;
					temp = historyData2;
					historyData2 = null;
				}else{
					temp = historyData2;
				}
			}
			WeekToWeekStockCompareDTO stockCompareDTO = new WeekToWeekStockCompareDTO();
			stockCompareDTO.setTickerName(historyData1.getElement1());
			if(!prevTicker.equals("") && !stockCompareDTO.getTickerName().equals(prevTicker))
				hasChanged = true;
			else
				hasChanged = false;
				
			prevTicker = stockCompareDTO.getTickerName();
			//stockCompareDTO.setWeek1Value(historyData1.getElement2()+ " # " + historyData1.getElement6());
			stockCompareDTO.setWeek1Value(historyData1.getElement2());

			if(hasChanged){
				try {
					System.out.println("shocking code ");
					cummulativestockCompareDTO = new WeekToWeekStockCompareDTO();
					cummulativestockCompareDTO.setChangeInValue(String.format("%.2f",cummulativeChangeVal));
					cummulativestockCompareDTO.setPercentageChange(String.format("%.2f",cummulativeChangeValPerct)+"%");
					cummulativestockCompareDTO.setPrice("CUMULATIVE CHANGE");
					cummulativestockCompareDTO.setTickerName("");
					cummulativestockCompareDTO.setWeek1Value("");
					cummulativestockCompareDTO.setWeek2Value("");
					//list.add(cummulativestockCompareDTO);
					//Collections.sort(tempList);
					tempList.add(cummulativestockCompareDTO);
					finalMap.put(cummulativeChangeValPerct, tempList);
					//finalList.addAll(tempList);
					tempList = new ArrayList<WeekToWeekStockCompareDTO>();
					cummulativeChangeVal = 0.0;
					cummulativeChangeValPerct = 0.0;
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if(historyData2!=null){
				//stockCompareDTO.setWeek2Value(historyData2.getElement2()+ " # " + historyData2.getElement6());
				stockCompareDTO.setWeek2Value(historyData2.getElement2());
				change = new Double(new Double(historyData1.getElement6()) - new Double(historyData2.getElement6()));
				cummulativeChangeVal+= change;
				percentageChange = new Double((change*100)/new Double(historyData2.getElement6()));
				cummulativeChangeValPerct+= percentageChange;
				//String.format("%.2f");
				stockCompareDTO.setPrice(historyData1.getElement6());
				//stockCompareDTO.setChangeInValue(change.toString() );
				stockCompareDTO.setChangeInValue(String.format("%.2f", change));
				//stockCompareDTO.setPercentageChange(new Double(change/new Double(historyData1.getElement6())).toString());
				
				stockCompareDTO.setPercentageChange(String.format("%.2f", percentageChange));
				//list.add(stockCompareDTO);
				tempList.add(stockCompareDTO);



			}
		}
		
		System.out.println("shocking code after loop");
		//Collections.sort(tempList);
		//finalList.addAll(tempList);
		cummulativestockCompareDTO = new WeekToWeekStockCompareDTO();
		cummulativestockCompareDTO.setChangeInValue(String.format("%.2f",cummulativeChangeVal));
		cummulativestockCompareDTO.setPercentageChange(String.format("%.2f",cummulativeChangeValPerct)+"%");
		cummulativestockCompareDTO.setPrice("CUMULATIVE CHANGE");
		cummulativestockCompareDTO.setTickerName("");
		cummulativestockCompareDTO.setWeek1Value("");
		cummulativestockCompareDTO.setWeek2Value("");
		tempList.add(cummulativestockCompareDTO);
		finalMap.put(cummulativeChangeValPerct, tempList);

		/*Double cumulativeChange = 0.0;
		for(WeekToWeekStockCompareDTO stockCompareDTO : list){
			cumulativeChange += Double.valueOf(stockCompareDTO.getChangeInValue());
		}
		WeekToWeekStockCompareDTO cumulativeDTO = new WeekToWeekStockCompareDTO();
		cumulativeDTO.setChangeInValue(String.valueOf(cumulativeChange));
		cumulativeDTO.setPercentageChange("");
		cumulativeDTO.setPrice("");
		cumulativeDTO.setTickerName("");
		cumulativeDTO.setWeek1Value("");
		cumulativeDTO.setWeek2Value("");
		list.add(cumulativeDTO);*/

		/*for(WeekToWeekStockCompareDTO compareDTO : list){
			System.out.println(compareDTO.getTickerName() + " | " + compareDTO.getWeek1Value() + " | " + compareDTO.getWeek2Value() +
					 " | " + compareDTO.getChangeInValue() + " | " + compareDTO.getPercentageChange() + "%");
		}*/
		
		System.out.println(" finalMap size ---- "+finalMap.size());
		TreeSet<Double> keys = new TreeSet<Double>(finalMap.keySet());
		TreeSet<Double> revkeys = (TreeSet<Double>) keys.descendingSet();
		for (Double key : revkeys) { 
			List<WeekToWeekStockCompareDTO> tList = finalMap.get(key);
			System.out.println(" creating final List ---- %C_Val= " + key + " --- tList size = " + tList.size());
			finalList.addAll(tList);
		}
		/*Map<Double, List<WeekToWeekStockCompareDTO>> treeMap = new TreeMap<Double, List<WeekToWeekStockCompareDTO>>(finalMap);
		for(Double key : finalMap.keySet()){
			List<WeekToWeekStockCompareDTO> tList = finalMap.get(key);
			System.out.println(" creating final List ---- %C_Val= " + key + " --- tList size = " + tList.size());
			finalList.addAll(tList);
		}*/
		
		return finalList;
	
		
	}
	
	public List<MarketData> findHistoryByTicker(String metadataName, String ticker){		
		  		
		Session session = null; 
		session = sessionFactory.openSession();
		String queryStr = "";

		if("Bondpricing_Master".equalsIgnoreCase(metadataName)){ 
				queryStr =
						"select distinct t1.element3 as element99, t2.* from(select * from marketdata "+
								"where "+ "metadataName='Tickers_Watchlist' "+ "and idMarketDataFile in "+
								" (select idMarketDataFile from MarketDataFile where "+
								"metadataName='Tickers_Watchlist' "+ "))  t1, "+ " "+
								"(select (select substring (element1,CHARINDEX('(', element1)+1, "+
								"(CHARINDEX(')', element1)-CHARINDEX('(', element1))-1) ) as c1,* "+
								" from marketdata "+ "where "+
								"metadataName='Bondpricing_Master' and (CHARINDEX(')', element1)-CHARINDEX('(', element1))>0 "
								+ ") t2 "
								+ " where t1.element1 = t2.c1"
								+" and SUBSTRING(CAST(Convert(varchar(11), t1.lastUpdatedAt ,126) as varchar(11)),0,11)= SUBSTRING(CAST(Convert(varchar(11), t2.lastUpdatedAt ,126) as varchar(11)),0,11) " 
								+ " and t2.element1 like '%" + ticker +
								"%' order by lastUpdatedAt desc";
		
				/*"select t1.element3 as element99, t2.* from(select * from marketdata "+
						"where "+ "metadataName='Tickers_Watchlist' "+ "and idMarketDataFile in "+
						" (select max(idMarketDataFile) from MarketDataFile where "+
						"metadataName='Tickers_Watchlist' "+ "))  t1, "+ " "+
						"(select (select substring (element1,CHARINDEX('(', element1)+1, "+
						"(CHARINDEX(')', element1)-CHARINDEX('(', element1))-1) ) as c1,* "+
						" from marketdata "+ "where "+
						"metadataName='Bondpricing_Master' and (CHARINDEX(')', element1)-CHARINDEX('(', element1))>0 "
						+ ") t2 "
						+ " where t1.element1 = t2.c1 and t2.element1 like '%" + ticker +
						"%' order by lastUpdatedAt desc";
*/
		}else {

			queryStr = "select * from marketData where metadataName = '"+metadataName+"' AND" + 
					" element1 like '%" + ticker + "%' order by lastUpdatedAt desc";
		}
		//queryStr += orderqry; 
		org.hibernate.query.Query query = session.createNativeQuery(queryStr).addEntity(MarketData.class);
		System.out.println("findHistoryByTicker Query ----"+queryStr);
		/*if (startRecord!=null && maxResults!=null) {
			query.setFirstResult(startRecord.intValue());
			query.setMaxResults(maxResults.intValue());
		}*/
		List list = query.list();
		session.close();
		return list; 
	
	}
	
	public List<ExtTransactionValuesDTO> getHistoryByTicker(String metaDataName, String ticker) {
		//MarketDataDAO marketDataDAO = new MarketDataDAO();
		List<MarketData> list = new ArrayList<MarketData>();


		list = findHistoryByTicker(metaDataName, ticker);
		//dataCount = bulkTxnDAO.getAllUnlockedBulkTxnCount(statusqry, orderqry, metadataName, elements);

		List<ExtTransactionValuesDTO> realTimeEqList = getValuesDTODFromBulkTxnList(list);

		System.out.println("bulkDTOList size = " + realTimeEqList.size());


		return realTimeEqList;
	}
	
	public List<MarketData> findAllTicker(String metadataName){		
		Session session = null; 
		session = sessionFactory.openSession();
		String queryStr = "";

		queryStr = "select element1  from marketData where metadataName = '"+metadataName+"'order by lastUpdatedAt desc";
		//queryStr += orderqry; 
		org.hibernate.query.Query query = session.createNativeQuery(queryStr).addScalar("element1", new StringType());          //.addEntity(MarketData.class);
		System.out.println("findAllTicker Query ----"+queryStr);
		/*if (startRecord!=null && maxResults!=null) {
			query.setFirstResult(startRecord.intValue());
			query.setMaxResults(maxResults.intValue());
		}*/
		List list = query.list();
		session.close();
		return list; 
	}
	
	public List<ExtTransactionValuesDTO> getAllTicker(String metaDataName){
		
		List<ExtTransactionValuesDTO> extTransactionValuesDTOList = new ArrayList<ExtTransactionValuesDTO>();
		// metaDataList = findAllTicker(metaDataName);
		Session session = null; 
		session = sessionFactory.openSession();
		String queryStr = "";

		queryStr = "select distinct element1  from marketData where metadataName = '"+metaDataName+"' and element1 is not null and isnumeric (element1)<>1 order by element1";
		org.hibernate.query.Query query = session.createNativeQuery(queryStr).addScalar("element1", new StringType());          //.addEntity(MarketData.class);
		System.out.println("findAllTicker Query ----"+queryStr);
		
		List metaDataList = query.list();
		System.out.println("metaDataList Size"+metaDataList.size());
		
		 
		 if (!Utility.isNullOrEmpty(metaDataList)) {
				Iterator itr = metaDataList.iterator();
				while (itr.hasNext()) {
					//System.out.println("Iterator list-"+itr.toString());
					String columns = (String) itr.next();
                //   System.out.println("columns---- "+columns);
					
				
				  String ticker = columns; 
				  ExtTransactionValuesDTO extTransactionValuesDTO = new ExtTransactionValuesDTO();
				 extTransactionValuesDTO.setElement1(ticker);
				 
						

						extTransactionValuesDTOList.add(extTransactionValuesDTO);
						
						
						
					}
		 }
		 System.out.println("getAllTicker size -> "+extTransactionValuesDTOList.size());
		 session.close();
		return extTransactionValuesDTOList;

		
		
		
	} 
	
	public List<MarketData> getBondRealData(String type){
		List<MarketData> list = new ArrayList<>();
		list= marketDataDao.findBondRealData(type);
		
		System.out.println(list.size());
		return list;
	}

	public List<MarketData> findChartForHistoryByTicker(String metadataName, String ticker,String year,String year2){		
		Session session = null; 
		session = sessionFactory.openSession();
		String queryStr = "";

		queryStr = "select * from marketData where metadataName = '"+metadataName+"' AND" + 
				" element1 = '" + ticker + "'  AND (CAST(DATENAME(YEAR,lastUpdatedAt) as int))>='" + year + "' AND (CAST(DATENAME(YEAR,lastUpdatedAt) as int))<='" + year2 + "' order by lastUpdatedAt desc";
		org.hibernate.query.Query query = session.createNativeQuery(queryStr).addEntity(MarketData.class);
		System.out.println("findChartForHistoryByTicker Query ----"+queryStr);
		List list = query.list();
		session.close();
		return list; 
	}
	public List<ExtTransactionValuesDTO> getChartForHistoryByTicker(String metaDataName, String ticker,String year,String year2) {
		List<MarketData> list = new ArrayList<MarketData>();
		list = findChartForHistoryByTicker(metaDataName, ticker,year,year2);
		List<ExtTransactionValuesDTO> realTimeEqList = getValuesDTODFromBulkTxnList(list);
		System.out.println("bulkDTOList size = " + realTimeEqList.size());
		return realTimeEqList;
	}

	
	@Override
	public List<PortfolioDTO> getAllPortFolioTicker() {
		List<PortfolioDTO> portfolioDTOs=new ArrayList<PortfolioDTO>();
		List<Portfolio> portfolio=portfolioDAORepository.findAll();
		
		for(Portfolio port:portfolio) {
			PortfolioDTO portfolioDto=new PortfolioDTO();
			portfolioDto.setIdPortfolio(port.getIdPortfolio());
			portfolioDto.setName(port.getName());
			portfolioDTOs.add(portfolioDto);
		}
		
		return portfolioDTOs;
	}

	@Override
	public List<MarketData> getPortFolioStockSet(Long idPortfolio) {
		Session session = null; 
		session = sessionFactory.openSession(); 
		String queryStr = "select * from MarketData b " + 
				"where b.metadataName = 'Tickers_Watchlist' and b.idMarketDataFile " + 
				"= (select max(idMarketDataFile) from MarketDataFile where metadataName = 'Tickers_Watchlist') and b.isSoftDeleted=0" + 
				"and b.element1 in (select stockName from portfoliostockset ps, Stock s" + 
				"	where ps.idStock=s.idStock and ps.idPortfolio ="+ idPortfolio+")";
			
		System.out.println("getPortFolioStockSet ----- Query---"+queryStr);
		org.hibernate.query.Query query = session.createNativeQuery(queryStr).addEntity(MarketData.class);
		List<MarketData> list = query.list();
		session.close();
		System.out.println(list.size());
		return list;
	}
	
	

}
