package com.jarvis.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.jarvis.entity.MarketHistoryData;

@Repository
public interface MarketHistoryDAORepository extends JpaRepository<MarketHistoryData, Integer>{

	@Query(value = "select * from MarketHistoryData where element1 in " +
	"(?1) AND Cast(element2 as datetime) between ?2 AND ?3 AND " +
	"(DATENAME(WEEKDAY,Cast(element2 as datetime)) = 'friday' OR element2 in (?2,?3))", nativeQuery = true)
	public List<MarketHistoryData> findHistoricalDataByStockAndDate(String stockName, String startDate,
			String endDate);
}
