package com.jarvis.dto;

import java.io.Externalizable;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectOutput;
import java.io.Serializable;


public class StockPerformanceDTO  implements Serializable, Externalizable{
	private String bestMovedStock;
	private String worstMovedStock;
	private String bestMovedBy;
	private String worstMovedBy;

	private String bestMoveCurrValue;
	private String bestMovePrevValue;
	private String worstMoveCurrValue;
	private String worstMovePrevValue;
	
	private String percentageChangeRise;
	private String percentageChangeDrop;
	
	private String prevytm;
	private String currytm;
	private String maturityDate;

	
	
	public String getBestMovedStock() {
		return bestMovedStock;
	}
	public void setBestMovedStock(String bestMovedStock) {
		this.bestMovedStock = bestMovedStock;
	}
	public String getWorstMovedStock() {
		return worstMovedStock;
	}
	public void setWorstMovedStock(String worstMovedStock) {
		this.worstMovedStock = worstMovedStock;
	}
	public String getBestMovedBy() {
		return bestMovedBy;
	}
	public void setBestMovedBy(String bestMovedBy) {
		this.bestMovedBy = bestMovedBy;
	}
	public String getWorstMovedBy() {
		return worstMovedBy;
	}
	public void setWorstMovedBy(String worstMovedBy) {
		this.worstMovedBy = worstMovedBy;
	}
	public String getBestMoveCurrValue() {
		return bestMoveCurrValue;
	}
	public void setBestMoveCurrValue(String bestMoveCurrValue) {
		this.bestMoveCurrValue = bestMoveCurrValue;
	}
	public String getBestMovePrevValue() {
		return bestMovePrevValue;
	}
	public void setBestMovePrevValue(String bestMovePrevValue) {
		this.bestMovePrevValue = bestMovePrevValue;
	}
	public String getWorstMoveCurrValue() {
		return worstMoveCurrValue;
	}
	public void setWorstMoveCurrValue(String worstMoveCurrValue) {
		this.worstMoveCurrValue = worstMoveCurrValue;
	}
	public String getWorstMovePrevValue() {
		return worstMovePrevValue;
	}
	public void setWorstMovePrevValue(String worstMovePrevValue) {
		this.worstMovePrevValue = worstMovePrevValue;
	}
	public String getPercentageChangeRise() {
		return percentageChangeRise;
	}
	public void setPercentageChangeRise(String percentageChangeRise) {
		this.percentageChangeRise = percentageChangeRise;
	}
	public String getPercentageChangeDrop() {
		return percentageChangeDrop;
	}
	public void setPercentageChangeDrop(String percentageChangeDrop) {
		this.percentageChangeDrop = percentageChangeDrop;
	}
	
	
	public String getPrevytm() {
		return prevytm;
	}
	public void setPrevytm(String prevytm) {
		this.prevytm = prevytm;
	}
	public String getCurrytm() {
		return currytm;
	}
	public void setCurrytm(String currytm) {
		this.currytm = currytm;
	}
	public String getMaturityDate() {
		return maturityDate;
	}
	public void setMaturityDate(String maturityDate) {
		this.maturityDate = maturityDate;
	}
	
	public void readExternal(ObjectInput in) throws IOException, ClassNotFoundException {
		bestMovedStock = (String)in.readObject();
		worstMovedStock = (String)in.readObject();
		bestMovedBy = (String)in.readObject();
		worstMovedBy = (String)in.readObject();
		bestMoveCurrValue = (String)in.readObject();
		bestMovePrevValue = (String)in.readObject();
		worstMoveCurrValue = (String)in.readObject();
		worstMovePrevValue = (String)in.readObject();
		percentageChangeRise = (String)in.readObject();
		percentageChangeDrop = (String)in.readObject();
		prevytm = (String)in.readObject();
		currytm = (String)in.readObject();
		maturityDate = (String)in.readObject();
	}

	public void writeExternal(ObjectOutput out) throws IOException {
		out.writeObject(bestMovedStock);
		out.writeObject(worstMovedStock);
		out.writeObject(bestMovedBy);
		out.writeObject(worstMovedBy);
		out.writeObject(bestMoveCurrValue);
		out.writeObject(bestMovePrevValue);
		out.writeObject(worstMoveCurrValue);
		out.writeObject(worstMovePrevValue);
		out.writeObject(percentageChangeRise);
		out.writeObject(percentageChangeDrop);
		out.writeObject(prevytm);
		out.writeObject(currytm);
		out.writeObject(maturityDate);
	}

    
}
