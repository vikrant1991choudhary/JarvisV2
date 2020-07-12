package com.jarvis.dto;

import java.io.Externalizable;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectOutput;
import java.io.Serializable;

public class BondDTO implements Serializable, Externalizable{
	
	private Number idBond;
	private String issuerName;
	private String type;
	private String cusip;
	private String ytm;
	private String coupon;
	private String maturity;
	
	
	public Number getIdBond() {
		return idBond;
	}
	public void setIdBond(Number idBond) {
		this.idBond = idBond;
	}
	public String getIssuerName() {
		return issuerName;
	}
	public void setIssuerName(String issuerName) {
		this.issuerName = issuerName;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	public String getCusip() {
		return cusip;
	}

	public void setCusip(String cusip) {
		this.cusip = cusip;
	}
	
	public String getYtm() {
		return ytm;
	}
	public void setYtm(String ytm) {
		this.ytm = ytm;
	}
	public String getCoupon() {
		return coupon;
	}
	public void setCoupon(String coupon) {
		this.coupon = coupon;
	}
	public String getMaturity() {
		return maturity;
	}
	public void setMaturity(String maturity) {
		this.maturity = maturity;
	}
	public void readExternal(ObjectInput in) throws IOException, ClassNotFoundException {
		idBond = (Number)in.readObject();
		issuerName = (String)in.readObject();
		type = (String)in.readObject();
		cusip = (String)in.readObject();		
		ytm = (String)in.readObject();
		coupon = (String)in.readObject();
		maturity = (String)in.readObject();
	}

	public void writeExternal(ObjectOutput out) throws IOException {
		out.writeObject(idBond);
		out.writeObject(issuerName);
		out.writeObject(type);
		out.writeObject(cusip);
		out.writeObject(ytm);
		out.writeObject(coupon);
		out.writeObject(maturity);
	}

}
