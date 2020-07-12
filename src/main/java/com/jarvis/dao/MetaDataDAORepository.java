package com.jarvis.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.jarvis.entity.MetaData;

@Repository
public interface MetaDataDAORepository extends JpaRepository<MetaData, Integer>{
	
	@Query("SELECT b FROM MetaData b where b.metadataName = ?1 and isSoftDeleted= 'N' order by sortOrder")
	List<MetaData> findByMetadataName(String metaDataName);
	

}
