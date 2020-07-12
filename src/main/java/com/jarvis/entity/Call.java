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
@Table(name="tblCall")

@DynamicInsert
@DynamicUpdate
public class Call implements Serializable{

	@Id
	@Column(name="idCall", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private java.lang.Long idCall;
	private String stockNameTicker ;
	private String stockPrice ;
	private String strikePrice ;
	private String callPrice ;
	private String expirationDate ;
	private String daysExpiration ;
	private String reqIncrease ;
	private String breakEven ;
	private String percentage ;
	private String leverageRatio ;
	private Date lastUpdatedAt;
	private String costofTenCalls ;
	private String rank;
	
	public java.lang.Long getIdCall() {
		return idCall;
	}
	public void setIdCall(java.lang.Long idCall) {
		this.idCall = idCall;
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
	public String getCallPrice() {
		return callPrice;
	}
	public void setCallPrice(String callPrice) {
		this.callPrice = callPrice;
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
	public String getPercentage() {
		return percentage;
	}
	public void setPercentage(String percentage) {
		this.percentage = percentage;
	}
	public String getLeverageRatio() {
		return leverageRatio;
	}
	public void setLeverageRatio(String leverageRatio) {
		this.leverageRatio = leverageRatio;
	}
	public String getCostofTenCalls() {
		return costofTenCalls;
	}
	public void setCostofTenCalls(String costofTenCalls) {
		this.costofTenCalls = costofTenCalls;
	}
	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}
	public Date getLastUpdatedAt() {
		return lastUpdatedAt;
	}
	public void setLastUpdatedAt(Date lastUpdatedAt) {
		this.lastUpdatedAt = lastUpdatedAt;
	}
}
