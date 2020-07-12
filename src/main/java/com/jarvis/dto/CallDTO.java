package com.jarvis.dto;

import java.io.Externalizable;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectOutput;
import java.io.Serializable;
import java.util.Date;

public class CallDTO implements Serializable, Externalizable{
	
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
	private String costofTenCalls ;
	private String rank;
	private Date lastUpdatedAt;
	
	public CallDTO() {
		// TODO Auto-generated constructor stub
	}
	
	public CallDTO(String breakEven, String callPrice, String daysExpiration,
			String expirationDate, String leverageRatio, String percentage,
			String reqIncrease, String stockNameTicker, String stockPrice,
			String strikePrice,String costofTenCalls, String rank) {
		super();
		this.breakEven = breakEven;
		this.callPrice = callPrice;
		this.daysExpiration = daysExpiration;
		this.expirationDate = expirationDate;
		this.leverageRatio = leverageRatio;
		this.percentage = percentage;
		this.reqIncrease = reqIncrease;
		this.stockNameTicker = stockNameTicker;
		this.stockPrice = stockPrice;
		this.strikePrice = strikePrice;
		this.costofTenCalls = costofTenCalls;
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

	public void readExternal(ObjectInput in) throws IOException, ClassNotFoundException {
		stockNameTicker = (String)in.readObject();
		stockPrice = (String)in.readObject();
		strikePrice = (String)in.readObject();
		callPrice = (String)in.readObject();		
		expirationDate = (String)in.readObject();
		daysExpiration = (String)in.readObject();
		reqIncrease = (String)in.readObject();
		breakEven = (String)in.readObject();
		percentage = (String)in.readObject();
		leverageRatio = (String)in.readObject();
		costofTenCalls = (String)in.readObject();
		rank = (String)in.readObject();
		lastUpdatedAt = (Date)in.readObject();
	}

	public void writeExternal(ObjectOutput out) throws IOException {
		out.writeObject(stockNameTicker);
		out.writeObject(stockPrice);
		out.writeObject(strikePrice);
		out.writeObject(callPrice);
		out.writeObject(expirationDate);
		out.writeObject(daysExpiration);
		out.writeObject(reqIncrease);
		out.writeObject(breakEven);
		out.writeObject(percentage);
		out.writeObject(leverageRatio);
		out.writeObject(costofTenCalls);
		out.writeObject(rank);
		out.writeObject(lastUpdatedAt);
	}
	
	public String toString() {
		// TODO Auto-generated method stub
		return super.toString();
	}
	
	
	

}
