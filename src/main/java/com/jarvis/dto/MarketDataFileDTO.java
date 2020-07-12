/**
 * 
 */
package com.jarvis.dto;

import java.io.Externalizable;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectOutput;
import java.io.Serializable;
import java.util.Date;


public class MarketDataFileDTO implements Serializable, Externalizable{

	private Number idMarketDataFile;
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
	private int isfailed;
	private String failreason;


	public Number getIdMarketDataFile() {
		return idMarketDataFile;
	}
	public void setIdBulkTxnFile(Number idMarketDataFile) {
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
	public String getImportType() {
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
	public int getIsfailed() {
		return isfailed;
	}
	public void setIsfailed(int isfailed) {
		this.isfailed = isfailed;
	}
	public String getFailreason() {
		return failreason;
	}
	public void setFailreason(String failreason) {
		this.failreason = failreason;
	}

	
	public void readExternal(ObjectInput input) throws IOException,ClassNotFoundException {
		idMarketDataFile = (Number)input.readObject();
		fileData = (byte[])input.readObject();
		fileName = (String)input.readObject();
		fileType = (String)input.readObject();
		fileSize = (Number)input.readObject();
		fileLocation = (String)input.readObject();
		createdOn = (Date)input.readObject();
		createdBy = (String)input.readObject();
		marketDataType = (String)input.readObject();
		marketDataSource = (String)input.readObject();;
		isSoftDeleted = (String)input.readObject();
		metaDataName = (String)input.readObject();
		isfailed = (Integer)input.readObject();
		failreason = (String)input.readObject();

	}
	public void writeExternal(ObjectOutput output) throws IOException {
		output.writeObject(idMarketDataFile);
		output.writeObject(fileData);
		output.writeObject(fileName);
		output.writeObject(fileType);
		output.writeObject(fileSize);
		output.writeObject(fileLocation);
		output.writeObject(createdOn);
		output.writeObject(createdBy);
		output.writeObject(marketDataType);
		output.writeObject(marketDataSource);
		output.writeObject(isSoftDeleted);
		output.writeObject(metaDataName);
		output.writeObject(isfailed);
		output.writeObject(failreason);

	}

}
