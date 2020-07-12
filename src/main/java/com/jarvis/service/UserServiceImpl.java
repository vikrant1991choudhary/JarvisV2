package com.jarvis.service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jarvis.dao.MarketDataDAORepository;
import com.jarvis.dao.UserDAORepository;
import com.jarvis.dto.Login;
import com.jarvis.entity.MarketData;
import com.jarvis.entity.User;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserDAORepository userDao;
	
	@Autowired
	MarketDataDAORepository marketDataDao;
	
	@Autowired
	SessionFactory sessionFactory;

	public List<User> getAllUser() {
		return userDao.findAll();
	}
	
	public User isAuthenticate(Login luser){
		/*
		 * Session session = null; try{ session = sessionFactory.openSession(); User
		 * user = (User)session.
		 * createQuery("from User where email = :username AND password = :password")
		 * .setParameter("username", luser.getUsername()) .setParameter("password",
		 * luser.getPassword()) .uniqueResult(); //User user = (User)
		 * query.uniqueResult(); session.close(); if(user!=null){ return true; }
		 * }catch(Exception e){ e.printStackTrace(); return false; } return false;
		 */
		User user = userDao.findUserByCredential(luser.getUsername(), luser.getPassword());
		if(null!=user && null!=user.getFname() && !"".equalsIgnoreCase(user.getFname()))
			return user;
		else
			return null;
		
	}

	public Integer createUser(User user) {
		Session session = null;
		Integer id = 0;
		try{
			session = sessionFactory.openSession();
			session.beginTransaction();
			id = (Integer)session.save(user);
			session.getTransaction().commit();
			session.close();
		}catch(Exception e){
			id=0;
			e.printStackTrace();
		}
		return id;
	}
	
	public List<MarketData> getAllMarketData(){
		return marketDataDao.findAll();
	}
	
	/*public List<MarketData> getAllMarketDataByDate(String metadataName, String date){
		List<MarketData> list = new ArrayList<>();
		if(date.equals("1900-01-01")){
			if("Bondpricing_Master".equalsIgnoreCase(metadataName)){
				
			}else{
				list = marketDataDao.findAllMarketDataByDate(metadataName);
			}
		}else{
			if("Bondpricing_Master".equalsIgnoreCase(metadataName)){
				
			}else{
				String queryStr = "select * from MarketData where metadataName = '" + metadataName + "' and idMarketDataFile " + 
					"in (select idMarketDataFile from MarketDataFile where " +
					"SUBSTRING(CAST(Convert(varchar(11), createdOn ,126) as varchar(11)),0,11) like '" + date + "') and isSoftDeleted=0"
							+ " order by element1";
			}
			
		}
		System.out.println(list.size());
		return list;
	} */

	public List<MarketData> getAllMarketDataByDate(String metadataName, String date){
		List<MarketData> list = new ArrayList<>();
		String queryStr="";
		Session session = null; 
		
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
				try{ session = sessionFactory.openSession(); 
				list = (List<MarketData>)session.createNativeQuery(queryStr, MarketData.class).list();
				session.close();
			 }catch(Exception e){ 
				 e.printStackTrace();
			}
			}else{
				list = marketDataDao.findAllMarketDataByDate(metadataName);
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
				try{ session = sessionFactory.openSession(); 
				list = (List<MarketData>)session.createNativeQuery(queryStr, MarketData.class).list();
				session.close();
			 }catch(Exception e){ 
				 e.printStackTrace();
			}
			}else{
				 queryStr = "select * from MarketData where metadataName = '" + metadataName + "' and idMarketDataFile " + 
					"in (select idMarketDataFile from MarketDataFile where " +
					"SUBSTRING(CAST(Convert(varchar(11), createdOn ,126) as varchar(11)),0,11) like '" + date + "') and isSoftDeleted=0"
							+ " order by element1";
			}
			
		}
		System.out.println(list.size());
		return list;
	}
}
