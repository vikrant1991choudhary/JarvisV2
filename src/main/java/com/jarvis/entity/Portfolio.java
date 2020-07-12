package com.jarvis.entity;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

@Entity
@Table(name="tblPortfolio")

@DynamicInsert
@DynamicUpdate
public class Portfolio implements Serializable{
	
	@Id
	@Column(name="idPortfolio", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long idPortfolio;
	private String name;
	private String isSoftDeleted;
	
	@ManyToMany
	@JoinTable(
	  name = "portfoliostockset", 
	  joinColumns = @JoinColumn(name = "idPortfolio"), 
	  inverseJoinColumns = @JoinColumn(name = "idStock"))
	private Set<Stock> stocks;
	
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
	public String getIsSoftDeleted() {
		return isSoftDeleted;
	}
	public void setIsSoftDeleted(String isSoftDeleted) {
		this.isSoftDeleted = isSoftDeleted;
	}
	
	public Set<Stock> getStocks() {
		return stocks;
	}
	public void setStocks(Set<Stock> stocks) {
		this.stocks = stocks;
	}

}
