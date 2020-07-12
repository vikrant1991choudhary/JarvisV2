package com.jarvis.dto;

import java.io.Externalizable;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectOutput;
import java.io.Serializable;

public class StockDTO implements Serializable, Externalizable{
	
	private Number idStock;
	private String stockName;
	private String company;
	private String sector;
	private String industry;
	private String country;
	private String marketCapital;
	private String avgAnnualPE;
	private boolean isSelectedforWeekly;
	private String checkBoxHtml;
	
	private boolean isSelected;
	
	
	public Number getIdStock() {
		return idStock;
	}
	public void setIdStock(Number idStock) {
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

	
	public boolean getIsSelected() {
		return isSelected;
	}
	public void setIsSelected(boolean isSelected) {
		this.isSelected = isSelected;
	}
	public boolean getIsSelectedforWeekly() {
		return isSelectedforWeekly;
	}
	public void setIsSelectedforWeekly(boolean isSelectedforWeekly) {
		this.isSelectedforWeekly = isSelectedforWeekly;
	}
	public void readExternal(ObjectInput in) throws IOException, ClassNotFoundException {
		idStock = (Number)in.readObject();
		stockName = (String)in.readObject();
		company = (String)in.readObject();
		sector = (String)in.readObject();
		industry = (String)in.readObject(); 
		country = (String)in.readObject(); 
		marketCapital = (String)in.readObject();
		avgAnnualPE = (String)in.readObject();
		isSelected = (Boolean)in.readObject();
		isSelectedforWeekly  = (Boolean)in.readObject();
	}

	public void writeExternal(ObjectOutput out) throws IOException {
		out.writeObject(idStock);
		out.writeObject(stockName);
		out.writeObject(company);
		out.writeObject(sector);
		out.writeObject(industry);
		out.writeObject(country);
		out.writeObject(marketCapital);
		out.writeObject(avgAnnualPE);
		out.writeObject(isSelected);
		out.writeObject(isSelectedforWeekly);
	}
	public String getCheckBoxHtml() {
		return checkBoxHtml;
	}
	public void setCheckBoxHtml(String checkBoxHtml) {
		this.checkBoxHtml = checkBoxHtml;
	}
	

}
