package com.jarvis.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

@Entity
@Table(name="tblPut")

@DynamicInsert
@DynamicUpdate
public class Put implements Serializable{
	
	@Id
	@Column(name="idPut", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private java.lang.Long idPut;
	private String stockNameTicker;
	private String stockPrice;
	private String strikePrice;
	private String putPrice;
	private String expirationDate;
	private String daysExpiration;
	private String reqIncrease;
	private String breakEven;
	private String downProtection;
	private String leverageRatio;
	private String incomePotential;
	private String incomePerDay;
	private String annualPremium;
	private Date lastUpdatedAt;
	
	private String rank;
	
	
	public java.lang.Long getIdPut() {
		return idPut;
	}
	public void setIdPut(java.lang.Long idPut) {
		this.idPut = idPut;
	}
	public String getStockNameTicker() {
		return stockNameTicker;
	}
	public void setStockNameTicker(String stockNameTicker) {
		this.stockNameTicker = stockNameTicker;
	}
	public String getStockPrice() {
		return stockPrice;
	}
	public void setStockPrice(String stockPrice) {
		this.stockPrice = stockPrice;
	}
	public String getStrikePrice() {
		return strikePrice;
	}
	public void setStrikePrice(String strikePrice) {
		this.strikePrice = strikePrice;
	}
	public String getPutPrice() {
		return putPrice;
	}
	public void setPutPrice(String putPrice) {
		this.putPrice = putPrice;
	}
	public String getExpirationDate() {
		return expirationDate;
	}
	public void setExpirationDate(String expirationDate) {
		this.expirationDate = expirationDate;
	}
	public String getDaysExpiration() {
		return daysExpiration;
	}
	public void setDaysExpiration(String daysExpiration) {
		this.daysExpiration = daysExpiration;
	}
	public String getReqIncrease() {
		return reqIncrease;
	}
	public void setReqIncrease(String reqIncrease) {
		this.reqIncrease = reqIncrease;
	}
	public String getBreakEven() {
		return breakEven;
	}
	public void setBreakEven(String breakEven) {
		this.breakEven = breakEven;
	}
	public String getDownProtection() {
		return downProtection;
	}
	public void setDownProtection(String downProtection) {
		this.downProtection = downProtection;
	}
	public String getLeverageRatio() {
		return leverageRatio;
	}
	public void setLeverageRatio(String leverageRatio) {
		this.leverageRatio = leverageRatio;
	}
	public String getIncomePotential() {
		return incomePotential;
	}
	public void setIncomePotential(String incomePotential) {
		this.incomePotential = incomePotential;
	}
	public String getIncomePerDay() {
		return incomePerDay;
	}
	public void setIncomePerDay(String incomePerDay) {
		this.incomePerDay = incomePerDay;
	}
	public String getAnnualPremium() {
		return annualPremium;
	}
	public void setAnnualPremium(String annualPremium) {
		this.annualPremium = annualPremium;
	}
	public Date getLastUpdatedAt() {
		return lastUpdatedAt;
	}
	public void setLastUpdatedAt(Date lastUpdatedAt) {
		this.lastUpdatedAt = lastUpdatedAt;
	}
	
	public String getRank() {
		return rank;
	}

	public void setRank(String rank) {
		this.rank = rank;
	}

}
