package com.jarvis.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.type.LongType;
import org.hibernate.type.StringType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jarvis.common.Constants;
import com.jarvis.dao.AdminBondRepository;
import com.jarvis.dao.AdminStockRepository;
import com.jarvis.dao.PortfolioDAORepository;
import com.jarvis.dao.UserDAORepository;
import com.jarvis.dto.BondDTO;
import com.jarvis.dto.PortfolioDTO;
import com.jarvis.dto.StockDTO;
import com.jarvis.entity.Bond;
import com.jarvis.entity.MarketData;
import com.jarvis.entity.Portfolio;
import com.jarvis.entity.ResModel;
import com.jarvis.entity.Stock;
import com.jarvis.entity.User;
import com.jarvis.entity.UserBondSet;
import com.jarvis.entity.UserStockSet;
import com.jarvis.util.Utility;

@Service
public class AdminStockBondServiceImpl implements AdminStockBondService {

	@Autowired
	AdminStockRepository stockrepository;

	@Autowired
	AdminBondRepository bondrepository;
	
	@Autowired
	UserDAORepository userDAORepository;
	
	@Autowired
	PortfolioDAORepository portfolioDAORepository;
	
	@Autowired
	
	SessionFactory sessionFactory;

	@Override
	public List<StockDTO> findAllStocks() {
		List<Stock> dbresult = stockrepository.findAllStockData();
		List<StockDTO> retresult = new ArrayList<StockDTO>();
		for (Stock result : dbresult) {
			StockDTO r = new StockDTO();
			r.setIdStock(result.getIdStock());
			r.setStockName(result.getStockName());
			r.setCompany(result.getCompany());
			r.setSector(result.getSector());
			r.setIndustry(result.getIndustry());
			r.setCountry(result.getCountry());
			r.setMarketCapital(result.getMarketCapital());
			r.setAvgAnnualPE(result.getAvgAnnualPE());

			retresult.add(r);
		}
		return retresult;
	}

	@Override
	public List<Bond> findAllBonds() {
		return bondrepository.findAllBondData();
	}

	@Override
	public List<StockDTO> findAllFavoriteStocks(Long userId) {
		
		List<Stock> dbresult = stockrepository.findAllFavoriteStocks(userId);
		List<StockDTO> retresult = new ArrayList<StockDTO>();
		for (Stock result : dbresult) {
			StockDTO r = new StockDTO();
			r.setIdStock(result.getIdStock());
			r.setStockName(result.getStockName());
			r.setCompany(result.getCompany());
			r.setSector(result.getSector());
			r.setIndustry(result.getIndustry());
			r.setCountry(result.getCountry());
			r.setMarketCapital(result.getMarketCapital());
			r.setAvgAnnualPE(result.getAvgAnnualPE());

			retresult.add(r);
		}
		return retresult;
	}

	@Override
	public List<Bond> findAllFavoriteBonds(Long userId) {

		return bondrepository.findAllFavoriteBonds(userId);
	}
	
	@Override
	public ResModel addTicker(String tickerName, String company, String sector, String industry, String country,
			String marketCap) {
		//StockDAO stockDAO = new StockDAO();
		ResModel res = new ResModel();
		Stock stock = new Stock();
		stock.setStockName(tickerName);
		stock.setCompany(company);
		stock.setSector(sector);
		stock.setIndustry(industry);
		stock.setCountry(country);
		stock.setMarketCapital(marketCap);
		
		String stockDB = stockrepository.findStockByName(tickerName);
		if(stockDB == null) {
			//stockDAO.addTicker(stock); 
			stockrepository.save(stock);
		res.setMsg("Stock saved successfully");
		return res;
		}
		else {
			res.setMsg("Stock already exits.");
			//return "Stock already exits.";
			return res;
			}
		
		//return "Stock saved successfully";
	}

	@Override
	public ResModel changePassword(String userEmail, String newPassword) {
		// TODO Auto-generated method stub
		//return null;
		ResModel res = new ResModel();
		User user = userDAORepository.findUserByEmail(userEmail);
		if(user != null){
			user.setPassword(newPassword);
			userDAORepository.save(user); 
			res.setMsg("Password Change successfully");
			return res;
		}else{
			res.setMsg("User not Avaiable");
			return res;
		}
		
	}

	@Override
	public boolean saveFavoriteStock(List<StockDTO> stocks, String userId) {
		
		  Connection con = null; 
		  PreparedStatement pstmt = null; 
		  		  
		  
		Session session = null;
		session = sessionFactory.openSession();
		System.out.println("User Id : " + userId);
		try {
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			con = DriverManager.getConnection(Constants.CONNECTION_URL, Constants.CONNECTION_U_NAME,
					Constants.CONNECTION_U_PWD);

			for (StockDTO stock : stocks) {

				String queryStr = "Select * from userStockSet where idUser="+userId+" and idStock=" + stock.getIdStock();
				
				org.hibernate.query.Query query = session.createNativeQuery(queryStr).addEntity(UserStockSet.class);
				List queryList = query.list();
				
				System.out.println("-----------Query of Stock -"+queryStr);
				System.out.println("queryList for Stock = " + queryList.size());
				if (queryList.size()==0) {

					pstmt = con.prepareStatement("INSERT INTO userStockSet(idUser,idStock) VALUES ( "
							+ Long.parseLong(userId) + "," + stock.getIdStock() + ")");
					boolean status = pstmt.execute();
					System.out.println("saveFavoriteStock Insert has been saved " + status);
				} else {
					System.out.println("Stock Already Exist");
				}
			}
			for (StockDTO stock : stocks) {
				System.out.println("User inner Id : " + stock.getAvgAnnualPE());
				System.out.println("Stock inner Id : " + stock.getIdStock());

				/*
				 * pstmt = con.prepareStatement("update Stock set avgAnnualPE=" +
				 * stock.getAvgAnnualPE() + "where idStock=" + stock.getIdStock()); boolean
				 * status = pstmt.execute();
				 * 
				 * System.out.println("saveFavoriteStock Update has been saved " + status);
				 */

				System.out.println("saveFavoriteStock Update has been saved ");

			}
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
		 
		
	}

	@Override
	public boolean saveFavoriteBond(List<BondDTO> bonds, String userId) {
		  Connection con = null; 
		  PreparedStatement pstmt = null; 
		  		  
		  
		Session session = null;
		session = sessionFactory.openSession();
		System.out.println("User Id : " + userId);
		try {
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			con = DriverManager.getConnection(Constants.CONNECTION_URL, Constants.CONNECTION_U_NAME,
					Constants.CONNECTION_U_PWD);

			
			for (BondDTO bond : bonds) {
				
				String queryStr="Select * from userBondSet where idUser="+userId+" and idBond="+bond.getIdBond();
				org.hibernate.query.Query query = session.createNativeQuery(queryStr).addEntity(UserBondSet.class);
				List queryList = query.list();
				System.out.println("Query Size for Bond="+queryList);
				if(queryList.size()==0)				
				 {
					pstmt = con.prepareStatement("INSERT INTO userBondSet(idUser,idBond) VALUES ( "
							+ Long.parseLong(userId) + "," + bond.getIdBond() + ")");
					boolean status = pstmt.execute();
					System.out.println("saveFavoriteBond Insert has been saved "+status);
				
				  }else { 
					  System.out.println("Already Exist"); 
					  }
				 
			}
			
			for (BondDTO bond : bonds) {

				/*
				 * pstmt = con.prepareStatement( "update Bond set cusip=" + bond.getCusip() +
				 * "where idBond=" + bond.getIdBond()); boolean status = pstmt.execute();
				 * System.out.println("saveFavoriteBond Update has been saved " + status);
				 */
				
				System.out.println("saveFavoriteBond Update has been saved ");

			}
			 
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}
	
	@Override
	public List<StockDTO> getAllStocksForPolio(){
		List<StockDTO> stockDTOList = new ArrayList<StockDTO>();
		stockDTOList = findStockForPolio(); // Assuming 2L as Admin UserId		
		return stockDTOList;
	}
	
	public List<StockDTO> findStockForPolio(){

		Session session = null; 
		session = sessionFactory.openSession(); 
		String queryStr = "select Stock.idStock, stockName from Stock order by stockName asc";
		System.out.println("findStockForPolio  Query---"+queryStr);

		org.hibernate.query.Query query = session.createNativeQuery(queryStr)
				.addScalar("idStock", new LongType())
				.addScalar("stockName", new StringType());

		List results = query.list();

		List<StockDTO> stockDTOList = new ArrayList<StockDTO>();

		if (results != null) {
			Iterator itr = results.iterator();
			while (itr.hasNext()) {
				Object[] columns = (Object[]) itr.next();	

				StockDTO stockDTO = new StockDTO();
				
				stockDTO.setIdStock(Long.parseLong(columns[0].toString()));
				stockDTO.setStockName(columns[1].toString());
				stockDTO.setCheckBoxHtml("<input type='checkbox'  name='stockChkBox' value='" + stockDTO.getStockName() + "'>");
			
				stockDTOList.add(stockDTO);
			}

		}

		session.close();

		return stockDTOList;

	}
	

	@Override
	public ResModel createPortfolio(List<String> stockNames, String name) throws Exception{
		Class.forName("net.sourceforge.jtds.jdbc.Driver");
		Connection con = null;
		PreparedStatement pstmt = null;
		
		Session session = null;
		
		Portfolio oldPf = portfolioDAORepository.findPortfolioSetByName(name);
		
		if(oldPf != null) {
			con = DriverManager.getConnection (Constants.CONNECTION_URL, Constants.CONNECTION_U_NAME, Constants.CONNECTION_U_PWD);
			Long idPf =  oldPf.getIdPortfolio();
			System.out.println("idPf= "+idPf);
			
			session = sessionFactory.openSession();		

			pstmt = con.prepareStatement("DELETE FROM portfolioStockSet WHERE idPortfolio="+idPf);
			boolean status = pstmt.execute();

			portfolioDAORepository.delete(oldPf);
			session.close();
			pstmt.close();
			con.close();
		}
		
		ResModel res = new ResModel();
		try {
			Portfolio pf = new Portfolio();
			pf.setName(name); 
			pf.setIsSoftDeleted("0"); 
			//	BaseDAO.create(pf); 
			portfolioDAORepository.save(pf);

			Portfolio savedPF = portfolioDAORepository.findPortfolioSetByName(name);	
			
			Connection con1 = null;
			PreparedStatement pstmt1 = null;
			
			con1 = DriverManager.getConnection (Constants.CONNECTION_URL, Constants.CONNECTION_U_NAME, Constants.CONNECTION_U_PWD);
			
			Session session1 = null;

			session1 = sessionFactory.openSession(); 


			String queryStr = "select * from stock where stockName in ( ";
			for (String stockName : stockNames) {
				queryStr = queryStr + "'"+ stockName +  "', ";
			}
			queryStr = queryStr.substring(0, queryStr.length() -2);
			queryStr = queryStr + ")";

			System.out.println("queryStr in savePortfolio -- "+queryStr);

			org.hibernate.query.Query  query = session1.createNativeQuery(queryStr).addEntity(Stock.class);
			List<Stock> list = query.list();
			if(list != null)
				System.out.println("list.size() -- "+list.size()); 


			for (Stock stock : list) {

				pstmt1 = con1.prepareStatement("INSERT INTO portfolioStockSet VALUES ( "+ savedPF.getIdPortfolio()+","+ stock.getIdStock()+")");
				boolean status = pstmt1.execute();
				System.out.println("Portfolio Stock set has been saved "+status);
				res.setMsg("Portfolio Stock set has been saved ");

			}
			session1.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<PortfolioDTO> getAllPortfolio() {
		String queryString = "select name,STRING_AGG (stockName,',')as stockName from tblportfolio,portfolioStockSet,stock where " + 
							"tblportfolio.idPortfolio= portfolioStockSet.idPortfolio " + 
							"and stock.idStock=portfolioStockSet.idStock group by name;";

			/* "select name,stockName from tblportfolio,portfolioStockSet,stock where "+
				"tblportfolio.idPortfolio= portfolioStockSet.idPortfolio "+
				"and stock.idStock=portfolioStockSet.idStock;";*/

				Session session = null;
				session = sessionFactory.openSession(); 
				List<PortfolioDTO> portfolios = new ArrayList<PortfolioDTO>();
				org.hibernate.query.Query query = session.createNativeQuery(queryString)
						.addScalar("name", StringType.INSTANCE)
						.addScalar("stockName", StringType.INSTANCE);
				System.out.println("getAllPortfolio"+queryString);
				List results = query.list();
				
				if (!Utility.isNullOrEmpty(results)) {
				Iterator itr = results.iterator();
				while (itr.hasNext()) {
					Object[] columns = (Object[]) itr.next();
					
					String name = columns[0].toString();
					String ticker = columns[1].toString();
					PortfolioDTO pd = new PortfolioDTO();
					pd.setName(name);
					pd.setTicker(ticker); 
					portfolios.add(pd);
				}
				}
				session.close();
				return portfolios;
	}
	
	@Override
	public List<StockDTO> getAllPortfolioByName(String name) {
		String queryString = "select stockName from portfolioStockSet,stock where idPortfolio in (select idPortfolio from tblportfolio where name='"+name+"') " + 
				"and stock.idStock=portfolioStockSet.idStock";

		List<StockDTO> stockDTOs = findStockForPolio();
		List<StockDTO> newStockDTOs = new ArrayList<>();

		Session session = null;
		session = sessionFactory.openSession(); 
		List<PortfolioDTO> portfolios = new ArrayList<PortfolioDTO>();
		org.hibernate.query.Query query = session.createNativeQuery(queryString).addScalar("stockName", StringType.INSTANCE);
		System.out.println("getAllPortfolio="+queryString);
		List<String> results = query.list();
		session.close();
		for (StockDTO stock : stockDTOs) {
			
			if (!Utility.isNullOrEmpty(results)) {
				for (String object : results) {		
					if(stock.getStockName().equalsIgnoreCase(object)) {
						//StockDTO newStockDTO = new StockDTO();
						//newStockDTO.setIdStock(stock.getIdStock());
						//newStockDTO.setStockName(stock.getStockName()); 
						//stockDTOs.remove(stock);						
						stock.setCheckBoxHtml("<input type='checkbox' checked name='dateChkBox' value='" + object + "'>");
						//newStockDTOs.add(stock);
					}
				}
			}
			newStockDTOs.add(stock);
			
		}
		return newStockDTOs;
	}
}
