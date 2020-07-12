package com.jarvis.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.jarvis.entity.MarketData;

@Repository
public interface MarketDataDAORepository extends JpaRepository<MarketData, Integer> {
	
	
	@Query(value = "select * from MarketData b where b.metadataName = ?1 and b.idMarketDataFile " + 
	"= (select max(idMarketDataFile) from MarketDataFile where metadataName = ?1) and isSoftDeleted=0", nativeQuery = true)
	public List<MarketData> findAllMarketDataByDate(String metadataName);
	
	@Query(value = "select * from MarketData b where b.element1 = ?1 and isSoftDeleted=0", nativeQuery = true)
	public List<MarketData> findBondRealData(String type);
	
	 @Query(value = "select element3 from MarketData where metadataName = 'Tickers_Watchlist' and element1 = ?1 and idMarketDataFile in (select max(idMarketDataFile) from MarketDataFile where metadataName = 'Tickers_Watchlist')", nativeQuery = true)
	 String findRankingByStockName(String stockname);
	
}
