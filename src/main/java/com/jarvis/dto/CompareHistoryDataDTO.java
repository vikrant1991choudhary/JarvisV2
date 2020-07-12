package com.jarvis.dto;

import java.io.Externalizable;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectOutput;
import java.io.Serializable;
import java.util.Date;

public class CompareHistoryDataDTO implements Serializable, Externalizable{

	private String date;
	private String firstParamVal;
	private String secondParamVal;
	private String ratio;
	
	private String thirdParamVal;
	private String fourthParamVal;
	private String ratioThirdFourth;
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getFirstParamVal() {
		return firstParamVal;
	}
	public void setFirstParamVal(String firstParamVal) {
		this.firstParamVal = firstParamVal;
	}
	public String getSecondParamVal() {
		return secondParamVal;
	}
	public void setSecondParamVal(String secondParamVal) {
		this.secondParamVal = secondParamVal;
	}
	public String getRatio() {
		return ratio;
	}
	public void setRatio(String ratio) {
		this.ratio = ratio;
	}
	
	public String getThirdParamVal() {
		return thirdParamVal;
	}
	public void setThirdParamVal(String thirdParamVal) {
		this.thirdParamVal = thirdParamVal;
	}
	public String getFourthParamVal() {
		return fourthParamVal;
	}
	public void setFourthParamVal(String fourthParamVal) {
		this.fourthParamVal = fourthParamVal;
	}
	public String getRatioThirdFourth() {
		return ratioThirdFourth;
	}
	public void setRatioThirdFourth(String ratioThirdFourth) {
		this.ratioThirdFourth = ratioThirdFourth;
	}
	public void readExternal(ObjectInput in) throws IOException, ClassNotFoundException {
		
		date = (String)in.readObject();
		firstParamVal = (String)in.readObject(); 
		secondParamVal = (String)in.readObject(); 
		ratio = (String)in.readObject();
		
		thirdParamVal = (String)in.readObject();
		fourthParamVal = (String)in.readObject();
		ratioThirdFourth = (String)in.readObject();
		
	}

	public void writeExternal(ObjectOutput out) throws IOException {
		out.writeObject(date);
		out.writeObject(firstParamVal);
		out.writeObject(secondParamVal);
		out.writeObject(ratio);
		
		out.writeObject(thirdParamVal);
		out.writeObject(fourthParamVal);
		out.writeObject(ratioThirdFourth);
	}
	
	
	
	
}
