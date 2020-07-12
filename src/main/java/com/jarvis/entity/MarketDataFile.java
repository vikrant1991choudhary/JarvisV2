/**
 * 
 */
package com.jarvis.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;


@Entity
@Table(name="marketdatafile")

@DynamicInsert
@DynamicUpdate
public class MarketDataFile implements Serializable{

	@Id
	@Column(name="idMarketDataFile", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long idMarketDataFile;
	private byte[] fileData;
	private String fileName;
	private String fileType;
	private Number fileSize;
	private String fileLocation;
	private Date createdOn;
	private String createdBy;
	private String marketDataType;
	private String marketDataSource;
	private String isSoftDeleted;
	private String metaDataName;
	private byte isfailed;
	private String failreason;
	//private Set<MarketData> marketDataSet;
	//private Set<MetaData> metaDataSet;
	
	
	public Long getIdMarketDataFile() {
		return idMarketDataFile;
	}
	public void setIdMarketDataFile(Long idMarketDataFile) {
		this.idMarketDataFile = idMarketDataFile;
	}
	public byte[] getFileData() {
		return fileData;
	}
	public void setFileData(byte[] fileData) {
		this.fileData = fileData;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public Number getFileSize() {
		return fileSize;
	}
	public void setFileSize(Number fileSize) {
		this.fileSize = fileSize;
	}
	public String getFileLocation() {
		return fileLocation;
	}
	public void setFileLocation(String fileLocation) {
		this.fileLocation = fileLocation;
	}
	public Date getCreatedOn() {
		return createdOn;
	}
	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public String getMarketDataType() {
		return marketDataType;
	}
	public void setMarketDataType(String marketDataType) {
		this.marketDataType = marketDataType;
	}
	public String getMarketDataSource() {
		return marketDataSource;
	}
	public void setMarketDataSource(String marketDataSource) {
		this.marketDataSource = marketDataSource;
	}
	public String getIsSoftDeleted() {
		return isSoftDeleted;
	}
	public void setIsSoftDeleted(String isSoftDeleted) {
		this.isSoftDeleted = isSoftDeleted;
	}
	public String getMetaDataName() {
		return metaDataName;
	}
	public void setMetaDataName(String metaDataName) {
		this.metaDataName = metaDataName;
	}
	public byte getIsfailed() {
		return isfailed;
	}
	public void setIsfailed(byte isfailed) {
		this.isfailed = isfailed;
	}
	public String getFailreason() {
		return failreason;
	}
	public void setFailreason(String failreason) {
		this.failreason = failreason;
	}
	/*
	 * public Set<MarketData> getMarketDataSet() { return marketDataSet; } public
	 * void setMarketDataSet(Set<MarketData> marketDataSet) { this.marketDataSet =
	 * marketDataSet; }
	 * 
	 * public Set<MetaData> getMetaDataSet() { return metaDataSet; } public void
	 * setMetaDataSet(Set<MetaData> metaDataSet) { this.metaDataSet = metaDataSet; }
	 */
	 
	
	
		
}
