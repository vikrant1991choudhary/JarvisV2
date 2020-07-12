/**
 * 
 */
package com.jarvis.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

@Entity
@Table(name="metadata")

@DynamicInsert
@DynamicUpdate
public class MetaData implements Serializable,Comparable<MetaData>{
	
	@Id
	@Column(name="idMetaData", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long idMetaData;
	private String element;
	private String internalName;
	private String metadataName;
	private String isSoftDeleted;
	//private MarketDataFile marketDataFile; // for file import we are using a single table
	
	private String elementDisplayName;
	private String elementType;
	private Byte isAmountField = new Byte("0");
	private Byte isSymbolField = new Byte("0");
	private Byte isSearchCriteria = new Byte("0");
	private Byte isVisibleInDashboard = new Byte("0");
	private Byte isCurrencyField = new Byte("0");
	
	private Integer sortOrder;
	
	
	
	
	public Long getIdMetaData() {
		return idMetaData;
	}

	public void setIdMetaData(Long idMetaData) {
		this.idMetaData = idMetaData;
	}

	public String getElement() {
		return element;
	}

	public void setElement(String element) {
		this.element = element;
	}

	public String getInternalName() {
		return internalName;
	}

	public void setInternalName(String internalName) {
		this.internalName = internalName;
	}

	public String getMetadataName() {
		return metadataName;
	}

	public void setMetadataName(String metadataName) {
		this.metadataName = metadataName;
	}

	public String getIsSoftDeleted() {
		return isSoftDeleted;
	}

	public void setIsSoftDeleted(String isSoftDeleted) {
		this.isSoftDeleted = isSoftDeleted;
	}

	/*
	 * public MarketDataFile getMarketDataFile() { return marketDataFile; }
	 * 
	 * public void setMarketDataFile(MarketDataFile marketDataFile) {
	 * this.marketDataFile = marketDataFile; }
	 */

	public String getElementDisplayName() {
		return elementDisplayName;
	}

	public void setElementDisplayName(String elementDisplayName) {
		this.elementDisplayName = elementDisplayName;
	}

	public String getElementType() {
		return elementType;
	}

	public void setElementType(String elementType) {
		this.elementType = elementType;
	}

	public Byte getIsAmountField() {
		return isAmountField;
	}

	public void setIsAmountField(Byte isAmountField) {
		this.isAmountField = isAmountField;
	}

	public Byte getIsSymbolField() {
		return isSymbolField;
	}

	public void setIsSymbolField(Byte isSymbolField) {
		this.isSymbolField = isSymbolField;
	}

	public Byte getIsSearchCriteria() {
		return isSearchCriteria;
	}

	public void setIsSearchCriteria(Byte isSearchCriteria) {
		this.isSearchCriteria = isSearchCriteria;
	}

	public Byte getIsVisibleInDashboard() {
		return isVisibleInDashboard;
	}

	public void setIsVisibleInDashboard(Byte isVisibleInDashboard) {
		this.isVisibleInDashboard = isVisibleInDashboard;
	}

	public Byte getIsCurrencyField() {
		return isCurrencyField;
	}

	public void setIsCurrencyField(Byte isCurrencyField) {
		this.isCurrencyField = isCurrencyField;
	}

	public int compareTo(MetaData o) {
			if("Tickers_Watchlist".equalsIgnoreCase(o.getMetadataName())) {
				return (int) (this.sortOrder - o.sortOrder);
			}
			return (int) (this.idMetaData - o.idMetaData);
	}
	
	public boolean equals(Object obj) {
		//return super.equals(obj);
		return this.internalName.equals(((MetaData)obj).internalName);
	}

	public Integer getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(Integer sortOrder) {
		this.sortOrder = sortOrder;
	}
}
