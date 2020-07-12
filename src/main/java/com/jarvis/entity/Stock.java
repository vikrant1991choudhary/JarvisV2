package com.jarvis.entity;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

@Entity
@Table(name="stock")

@DynamicInsert
@DynamicUpdate
public class Stock implements Serializable{

	@Id
	@Column(name="idStock", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long idStock;
	private String stockName;
	private String company;
	private String sector;
	private String industry;
	private String country;
	private String marketCapital;
	private String avgAnnualPE;
	/*
	 * @ManyToOne
	 * 
	 * @JoinColumn(name="id", nullable=false) private Set<User> users;
	 */
	
	
	//private boolean isSelectedforWeekly;
	
	
	//private Set<User> users;
	@ManyToMany(mappedBy = "stocks")
	private Set<Portfolio> portfolios;

	public Long getIdStock() {
		return idStock;
	}

	public void setIdStock(Long idStock) {
		this.idStock = idStock;
	}

	public String getStockName() {
		return stockName;
	}

	public void setStockName(String stockName) {
		this.stockName = stockName;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getSector() {
		return sector;
	}

	public void setSector(String sector) {
		this.sector = sector;
	}

	public String getIndustry() {
		return industry;
	}

	public void setIndustry(String industry) {
		this.industry = industry;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getMarketCapital() {
		return marketCapital;
	}

	public void setMarketCapital(String marketCapital) {
		this.marketCapital = marketCapital;
	}

	public String getAvgAnnualPE() {
		return avgAnnualPE;
	}

	public void setAvgAnnualPE(String avgAnnualPE) {
		this.avgAnnualPE = avgAnnualPE;
	}

	/*public boolean getIsSelectedforWeekly() {
		return isSelectedforWeekly;
	}
	public void setIsSelectedforWeekly(boolean isSelectedforWeekly) {
		this.isSelectedforWeekly = isSelectedforWeekly;
	}*/

	/*
	 * public Set<User> getUsers() { return users; }
	 * 
	 * public void setUsers(Set<User> users) { this.users = users; }
	 */

	public Set<Portfolio> getPortfolios() {
		return portfolios;
	}

	public void setPortfolios(Set<Portfolio> portfolios) {
		this.portfolios = portfolios;
	}

	
	
	
}
