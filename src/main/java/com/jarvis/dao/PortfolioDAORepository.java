package com.jarvis.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.jarvis.entity.Portfolio;

@Repository
public interface PortfolioDAORepository extends JpaRepository<Portfolio, Integer>{

 			public Portfolio findPortfolioSetByName(String name);

}
