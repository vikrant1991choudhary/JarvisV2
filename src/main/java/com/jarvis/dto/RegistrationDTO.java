
package com.jarvis.dto;

import java.io.Externalizable;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectOutput;
import java.io.Serializable;


public class RegistrationDTO implements Serializable, Externalizable {

	private java.lang.String firstName;
	private java.lang.String lastName;
	private java.lang.String email;	
	private java.lang.String password;


	public java.lang.String getFirstName() {
		return firstName;
	}

	public void setFirstName(java.lang.String firstName) {
		this.firstName = firstName;
	}

	public java.lang.String getLastName() {
		return lastName;
	}

	public void setLastName(java.lang.String lastName) {
		this.lastName = lastName;
	}

	public java.lang.String getEmail() {
		return email;
	}

	public void setEmail(java.lang.String email) {
		this.email = email;
	}

	public java.lang.String getPassword() {
		return password;
	}

	public void setPassword(java.lang.String password) {
		this.password = password;
	}



	public void readExternal(ObjectInput in) throws IOException,
	ClassNotFoundException {
		firstName = (String)in.readObject();
		lastName = (String)in.readObject();
		email = (String)in.readObject();
		password = (String)in.readObject();

	}

	public void writeExternal(ObjectOutput out) throws IOException {
		out.writeObject(firstName);
		out.writeObject(lastName);
		out.writeObject(email);
		out.writeObject(password);


	}

}
