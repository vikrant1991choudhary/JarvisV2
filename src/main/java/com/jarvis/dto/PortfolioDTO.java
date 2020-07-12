package com.jarvis.dto;

import java.io.Externalizable;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectOutput;
import java.io.Serializable;

public class PortfolioDTO implements Serializable, Externalizable{
	
	private String name;
	private String ticker;
	private Long idPortfolio;
	private String checkBoxHtml;

	public Long getIdPortfolio() {
		return idPortfolio;
	}

	public void setIdPortfolio(Long idPortfolio) {
		this.idPortfolio = idPortfolio;
	}
	
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTicker() {
		return ticker;
	}

	public void setTicker(String ticker) {
		this.ticker = ticker;
	}

	
	public String getCheckBoxHtml() {
		return checkBoxHtml;
	}

	public void setCheckBoxHtml(String checkBoxHtml) {
		this.checkBoxHtml = checkBoxHtml;
	}

	public void readExternal(ObjectInput in) throws IOException, ClassNotFoundException {
		name = (String)in.readObject();
		ticker = (String)in.readObject();
	}

	public void writeExternal(ObjectOutput out) throws IOException {
		out.writeObject(name);
		out.writeObject(ticker);
	}

}
