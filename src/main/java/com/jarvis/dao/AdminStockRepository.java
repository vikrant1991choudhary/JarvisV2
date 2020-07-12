package com.jarvis.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.jarvis.entity.Stock;

@Repository
public interface AdminStockRepository extends JpaRepository<Stock, Long> {
	
	@Query(value = "select idStock,stockName,company,sector,industry,country,marketCapital,ISNULL(avgAnnualPE,'') as avgAnnualPE from Stock;", nativeQuery=true )
	public List<Stock> findAllStockData();
	
	@Query(value = "select idStock,stockName,company,sector,industry,country,marketCapital,ISNULL(avgAnnualPE,'') avgAnnualPE from stock where idStock in (select idStock from userStockSet where idUser =?1 )", nativeQuery=true)
	public List<Stock> findAllFavoriteStocks(Long userId);
	
	@Query(value = "select * from Stock where stockName = ?", nativeQuery = true)
	public String findStockByName(String tickerName);
	
	@Query(value = "insert into userStockSet (idStock, idUser) values (?,?);", nativeQuery = true)
	public void saveFavoriteStock(Number stockid, Long userId);
	
	@Query(value="update Stock set avgAnnualPE = ? where idStock = ?", nativeQuery= true)
	public void updatestock(String avgAPE, Number stockId);


}
