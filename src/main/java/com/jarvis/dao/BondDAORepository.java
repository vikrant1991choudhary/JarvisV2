package com.jarvis.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.jarvis.entity.Bond;
import com.jarvis.entity.MetaData;

@Repository
public interface BondDAORepository extends JpaRepository<Bond, Integer>{

	@Query("SELECT b FROM Bond b where b.issuerName = ?1")
	public Bond findBondByName(String issuerName);
}
