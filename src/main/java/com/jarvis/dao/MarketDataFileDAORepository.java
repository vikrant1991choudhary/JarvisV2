package com.jarvis.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.jarvis.entity.MarketDataFile;

@Repository
public interface MarketDataFileDAORepository extends JpaRepository<MarketDataFile, Integer>{

	@Query("SELECT createdOn FROM MarketDataFile b where b.metaDataName = ?1 "
			+ "and isSoftDeleted= 'N' and marketDataSource != 'metadata' order by 1 desc")
	public List<Date> findImportDatesByMonth(String metadataName);
}
