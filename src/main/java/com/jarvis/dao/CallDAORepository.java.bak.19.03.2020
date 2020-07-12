package com.jarvis.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.jarvis.entity.Call;

@Repository
public interface CallDAORepository extends JpaRepository<Call, Integer>{

	@Query(value = "select * from tblCall where stockNameTicker like ?%1 order by lastUpdatedAt desc", nativeQuery = true)
	public List<Call> findAllCallsByTickerName(String tickerName);
	
	@Query(value = "select distinct CONVERT(char(10), lastUpdatedAt,126) as lastUpdatedAt from tblCall order by lastUpdatedAt desc", nativeQuery = true)
	public List<String> findAllDates();
	
	@Query(value = "select * from tblCall where CONVERT(VARCHAR(25), lastUpdatedAt, 126) LIKE ?1%", nativeQuery = true)
	public List<Call> findCallDataByDate(String date);
	
}
