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

/**
 * @author suchakraborty
 *
 */
public class ExtTransactionElementDTO implements Serializable { //,Externalizable{

	private Number elementId;
	private String elementName;
	private String elementInternalName;
	private String elementDisplayName;
	private String elementType;
	
	private String metadataName;
	
	private Byte isAmountField;
	private Byte isUniqueField;
	private Byte isSearchCriteria;
	private Byte isVisibleInDashboard;
	
	private Byte isCurrencyField;
	
	public Number getElementId() {
		return elementId;
	}

	public void setElementId(Number elementId) {
		this.elementId = elementId;
	}

	public String getElementName() {
		return elementName;
	}

	public void setElementName(String elementName) {
		this.elementName = elementName;
	}

	public String getElementInternalName() {
		return elementInternalName;
	}

	public void setElementInternalName(String elementInternalName) {
		this.elementInternalName = elementInternalName;
	}

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

	public String getMetadataName() {
		return metadataName;
	}

	public void setMetadataName(String metadataName) {
		this.metadataName = metadataName;
	}

	public Byte getIsAmountField() {
		return isAmountField;
	}

	public void setIsAmountField(Byte isAmountField) {
		this.isAmountField = isAmountField;
	}

	public Byte getIsUniqueField() {
		return isUniqueField;
	}

	public void setIsUniqueField(Byte isUniqueField) {
		this.isUniqueField = isUniqueField;
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

	/*public void readExternal(ObjectInput input) throws IOException,ClassNotFoundException {
		
		elementId = (Number)input.readObject();
		elementName = (String)input.readObject();
		elementInternalName = (String)input.readObject();
		elementDisplayName = (String)input.readObject();
		elementType = (Integer)input.readObject();
		eftDepartmentName = (String)input.readObject();
		idepartmentId = (Number)input.readObject();
		metadataName = (String)input.readObject();
		isAmountField = (Byte)input.readObject();
		isUniqueField = (Byte)input.readObject();
		isSearchCriteria = (Byte)input.readObject();
		isVisibleInDashboard = (Byte)input.readObject();
		isNettingCriteria = (Byte)input.readObject();
		isTemplateMappingCriteria = (Byte)input.readObject();
		
		
	}
	
	public void writeExternal(ObjectOutput output) throws IOException {
		
		output.writeObject(elementId);
		output.writeObject(elementName);
		output.writeObject(elementInternalName);
		output.writeObject(elementDisplayName);
		output.writeObject(elementType);
		output.writeObject(eftDepartmentName);
		output.writeObject(idepartmentId);
		output.writeObject(metadataName);
		output.writeObject(isAmountField);
		output.writeObject(isUniqueField);
		output.writeObject(isSearchCriteria);
		output.writeObject(isVisibleInDashboard);
		output.writeObject(isNettingCriteria);
		output.writeObject(isTemplateMappingCriteria);
		
	}*/
}
