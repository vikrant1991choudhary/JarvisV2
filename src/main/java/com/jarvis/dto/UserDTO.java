/**
 * 
 */
package com.jarvis.dto;

import java.io.Externalizable;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectOutput;
import java.io.Serializable;


public class UserDTO implements Serializable, Externalizable{

	private Number idUser;
	private String firstName;
	private String lastName;
	private String email;
	private String password;
	private String message;
	private String isSoftDeleted = "N";
	private String isActive = "N";
	private String isUploadAllowed;
	
	

	


	public Number getIdUser() {
		return idUser;
	}

	public void setIdUser(Number idUser) {
		this.idUser = idUser;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String message) {
		this.password = message;
	}	

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public java.lang.String getIsSoftDeleted() {
		return isSoftDeleted;
	}

	public void setIsSoftDeleted(java.lang.String isSoftDeleted) {
		this.isSoftDeleted = isSoftDeleted;
	}

	public java.lang.String getIsActive() {
		return isActive;
	}

	public void setIsActive(java.lang.String isActive) {
		this.isActive = isActive;
	}
	
	

	public String getIsUploadAllowed() {
		return isUploadAllowed;
	}

	public void setIsUploadAllowed(String isUploadAllowed) {
		this.isUploadAllowed = isUploadAllowed;
	}

	public void readExternal(ObjectInput in) throws IOException, ClassNotFoundException {
		idUser = (Number)in.readObject();
		firstName = (String)in.readObject();
		lastName = (String)in.readObject();
		email = (String)in.readObject();
		password = (String)in.readObject(); 
		message = (String)in.readObject(); 
		isSoftDeleted = (String)in.readObject();
		isActive = (String)in.readObject(); 
		isUploadAllowed= (String)in.readObject();
	}

	public void writeExternal(ObjectOutput out) throws IOException {
		out.writeObject(idUser);
		out.writeObject(firstName);
		out.writeObject(lastName);
		out.writeObject(email);
		out.writeObject(password);
		out.writeObject(message);
		out.writeObject(isSoftDeleted);
		out.writeObject(isActive);
		out.writeObject(isUploadAllowed);
	}
}
