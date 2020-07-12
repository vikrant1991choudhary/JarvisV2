package com.jarvis.entity;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

@Entity
@Table(name="bond")

@DynamicInsert
@DynamicUpdate
public class Bond implements Serializable{

	@Id
	@Column(name="idBond", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long idBond;
	private String issuerName;
	private String type;
	private String cusip;
	private String ytm;
	private String coupon;
	private String maturity;
	
	/*
	 * @ManyToOne
	 * 
	 * @JoinColumn(name="id", nullable=false) private Set<User> users;
	 */
	
	//private Set<User> users;

	public Long getIdBond() {
		return idBond;
	}

	public void setIdBond(Long idBond) {
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

	/*
	 * public Set<User> getUsers() { return users; }
	 * 
	 * public void setUsers(Set<User> users) { this.users = users; }
	 */

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

	/*
	 * public Set<User> getUsers() { return users; }
	 * 
	 * public void setUsers(Set<User> users) { this.users = users; }
	 */
	
}
