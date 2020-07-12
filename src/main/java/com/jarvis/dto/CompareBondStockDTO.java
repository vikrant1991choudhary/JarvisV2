package com.jarvis.dto;

import java.io.Externalizable;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectOutput;
import java.io.Serializable;

public class CompareBondStockDTO implements Serializable, Externalizable{



	private String bondName;
	private String cusip;
	private String bondPrice;
	private String stockName;
	private String stockPrice;
	private String companyName;
	private String date;
	private String bondToStock;
    

	public String getBondToStock() {
		return bondToStock;
	}

	public void setBondToStock(String bondToStock) {
		this.bondToStock = bondToStock;
	}

	public String getBondName() {
		return bondName;
	}

	public void setBondName(String bondName) {
		this.bondName = bondName;
	}

	public String getCusip() {
		return cusip;
	}

	public void setCusip(String cusip) {
		this.cusip = cusip;
	}

	public String getBondPrice() {
		return bondPrice;
	}

	public void setBondPrice(String bondPrice) {
		this.bondPrice = bondPrice;
	}

	public String getStockName() {
		return stockName;
	}

	public void setStockName(String stockName) {
		this.stockName = stockName;
	}

	public String getStockPrice() {
		return stockPrice;
	}

	public void setStockPrice(String stockPrice) {
		this.stockPrice = stockPrice;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public void readExternal(ObjectInput in) throws IOException, ClassNotFoundException {

		bondName = (String)in.readObject();
		cusip = (String)in.readObject(); 
		bondPrice = (String)in.readObject(); 
		stockName = (String)in.readObject();
		stockPrice = (String)in.readObject();
		companyName = (String)in.readObject();
		date = (String)in.readObject();
		bondToStock = (String)in.readObject();
	}

	public void writeExternal(ObjectOutput out) throws IOException {
		out.writeObject(bondName);
		out.writeObject(cusip);
		out.writeObject(bondPrice);
		out.writeObject(stockName);
		out.writeObject(stockPrice);
		out.writeObject(companyName);
		out.writeObject(date);
		out.writeObject(bondToStock);
	}

}
