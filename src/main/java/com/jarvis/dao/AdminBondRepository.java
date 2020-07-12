package com.jarvis.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.jarvis.entity.Bond;
import com.jarvis.entity.User;

public interface AdminBondRepository extends JpaRepository<Bond, Long> {

	 @Query(value = "select * from Bond", nativeQuery=true)
	 public List<Bond> findAllBondData();
	 
	 
	 @Query(value = "select idBond,issuerName,type,ISNULL(cusip,'') cusip,ytm,coupon,maturity from bond where idBond in (select idBond from userBondSet where idUser =?1 )", nativeQuery=true)
	 public List<Bond> findAllFavoriteBonds(Long userId);
	 


}
