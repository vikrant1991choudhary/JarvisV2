package com.jarvis.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.jarvis.entity.Put;

@Repository
public interface PutDAORepository extends JpaRepository<Put, Integer>{

	@Query(value = "select * from tblPut where stockNameTicker LIKE ?%1 order by lastUpdatedAt desc", nativeQuery = true)
	public List<Put> findAllPutByTickerName(String tickerName);
	
	
	@Query(value = "select distinct convert(varchar(10),lastUpdatedAt,126) as lastUpdatedAt from tblPut order by lastUpdatedAt desc", nativeQuery= true)
	public List<String> findAllDatesPuts();
	 
	
	@Query(value = "select * from tblPut where CONVERT(VARCHAR(25), lastUpdatedAt, 126) LIKE ?%1", nativeQuery= true)
	public List<Put> findPutDataByDate(String date);
}
