package com.jarvis.dto;

import java.io.Externalizable;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectOutput;
import java.io.Serializable;


public class WeekToWeekStockCompareDTO implements Serializable, Externalizable{

	private String tickerName;
	private String week1Value;
	private String week2Value;
	private String changeInValue;
	private String percentageChange;
	private String price;

	public String getTickerName() {
		return tickerName;
	}
	public void setTickerName(String tickerName) {
		this.tickerName = tickerName;
	}
	public String getWeek1Value() {
		return week1Value;
	}
	public void setWeek1Value(String week1Value) {
		this.week1Value = week1Value;
	}
	public String getWeek2Value() {
		return week2Value;
	}
	public void setWeek2Value(String week2Value) {
		this.week2Value = week2Value;
	}
	public String getPercentageChange() {
		return percentageChange;
	}
	public String getChangeInValue() {
		return changeInValue;
	}
	public void setChangeInValue(String changeInValue) {
		this.changeInValue = changeInValue;
	}
	public void setPercentageChange(String percentageChange) {
		this.percentageChange = percentageChange;
	}

	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public void readExternal(ObjectInput in) throws IOException, ClassNotFoundException {

		tickerName = (String)in.readObject();
		week1Value = (String)in.readObject(); 
		week2Value = (String)in.readObject(); 
		changeInValue = (String)in.readObject(); 
		percentageChange = (String)in.readObject();
		price = (String)in.readObject();

	}

	public void writeExternal(ObjectOutput out) throws IOException {
		out.writeObject(tickerName);
		out.writeObject(week1Value);
		out.writeObject(week2Value);
		out.writeObject(changeInValue);
		out.writeObject(percentageChange);
		out.writeObject(price);
	}

	/*public int compareTo(WeekToWeekStockCompareDTO o) {
		int comIndex = 0;
		System.out.println("WeekToWeekStockCompareDTO : compare ----------------> ");
			
			try {
				double delta= Double.valueOf(this.getPercentageChange()) - Double.valueOf(o.getPercentageChange());
			    if(delta > 0) return 1;
			    if(delta < 0) return -1;
			    return 0;
				//comIndex = this.getTickerName().compareTo(o.getTickerName());
				//if(comIndex == 0)
					//comIndex = Double.compare(Double.valueOf(this.getPercentageChange()) , Double.valueOf(o.getPercentageChange()));
				   //comIndex = new Double(Double.valueOf(this.getPercentageChange()) - Double.valueOf(o.getPercentageChange())).intValue();
			} catch (NumberFormatException e) {
				//comIndex = 0;
				e.printStackTrace();
				return 0;
			}
			//System.out.println("Stocks : comIndex : " + comIndex);
		//return comIndex;
	}*/
}
