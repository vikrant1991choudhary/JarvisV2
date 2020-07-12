package com.jarvis.dto;

import java.io.Externalizable;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectOutput;
import java.io.Serializable;
import java.util.Date;

public class PutDTO implements Serializable, Externalizable{
	
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
	
	private String rank;
	private Date lastUpdatedAt;
	
	
	public PutDTO() {
		// TODO Auto-generated constructor stub
	}
	
	public PutDTO(String stockNameTicker,
	String stockPrice,
	 String strikePrice,
	 String putPrice,
	 String expirationDate,
	 String daysExpiration,
	 String reqIncrease,
	 String breakEven,
	 String downProtection,
	 String leverageRatio,
	 String incomePotential,
	 String incomePerDay,
	 String annualPremium, String rank) {
		super();
		this.stockNameTicker = stockNameTicker;
		this.stockPrice = stockPrice;
		this.strikePrice = strikePrice;
		this.putPrice = putPrice;
		this.expirationDate = expirationDate;
		this.daysExpiration = daysExpiration;
		this.reqIncrease = reqIncrease;
		this.breakEven = breakEven;
		this.downProtection = downProtection;
		this.leverageRatio = leverageRatio;
		this.incomePotential = incomePotential;
		this.incomePerDay = incomePerDay;
		this.annualPremium = annualPremium;
		this.rank = rank;
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

	public void readExternal(ObjectInput in) throws IOException, ClassNotFoundException {
		stockNameTicker = (String)in.readObject();
		stockPrice = (String)in.readObject();
		strikePrice = (String)in.readObject();
		putPrice = (String)in.readObject();		
		expirationDate = (String)in.readObject();
		daysExpiration = (String)in.readObject();
		reqIncrease = (String)in.readObject();
		breakEven = (String)in.readObject();
		downProtection = (String)in.readObject();
		leverageRatio = (String)in.readObject();
		incomePotential = (String)in.readObject();
		incomePerDay = (String)in.readObject();
		annualPremium = (String)in.readObject();
		
		rank = (String)in.readObject();
		lastUpdatedAt = (Date)in.readObject();
	}

	public void writeExternal(ObjectOutput out) throws IOException {
		out.writeObject(stockNameTicker);
		out.writeObject(stockPrice);
		out.writeObject(strikePrice);
		out.writeObject(putPrice);
		out.writeObject(expirationDate);
		out.writeObject(daysExpiration);
		out.writeObject(reqIncrease);
		out.writeObject(breakEven);
		out.writeObject(downProtection);
		out.writeObject(leverageRatio);
		out.writeObject(incomePotential);
		out.writeObject(incomePerDay);
		out.writeObject(annualPremium);
		
		out.writeObject(rank);
		out.writeObject(lastUpdatedAt);
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
