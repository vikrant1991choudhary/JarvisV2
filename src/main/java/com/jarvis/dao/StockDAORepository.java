package com.jarvis.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.jarvis.entity.Stock;

@Repository
public interface StockDAORepository extends JpaRepository<Stock, Integer>{

	@Query(value = "select distinct trim(industry) as industry from Stock where industry not like '%\\\"%' and "
			+ "industry != '' and industry != 'NULL' and industry is not NULL order by 1", nativeQuery = true)
	public List<String> findAllIndustry();
	
	@Query(value = "select distinct trim(sector) as sector from Stock where sector not like '%\\\"%' and "
			+ "sector != '' and sector != 'NULL' and sector is not NULL order by 1", nativeQuery = true)
	public List<String> findAllSectors();
	
	@Query(value="select stockName,company,sector from Stock order by 1", nativeQuery = true)
	public List<String> findAllWeeklySector();
	
	@Query(value = "select distinct trim(stockName) as stockName from Stock where stockName not like '%\\\"%' and "
			+ "stockName != '' and stockName != 'NULL' and stockName is not NULL order by 1", nativeQuery = true)
	public List<String> findAllStocks();
	
}
