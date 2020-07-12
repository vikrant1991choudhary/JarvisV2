package com.jarvis.entity;


import java.util.Date;
import java.util.Set;

import javax.persistence.*;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;


@Entity
@Table(name="tblUser")

@DynamicInsert
@DynamicUpdate
public class User {

	@Id
	@Column(name="idUser", nullable=false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer id;
	
	@Column(name="firstName")
	private String fname;
	
	@Column(name="lastName")
	private String lname;
	
	@Column(name="email")
	private String email;
	
	@Column(name="password")
	private String password;
	
	private String isUploadAllowed;
	
	/*
	 * @OneToMany(mappedBy="User",fetch = FetchType.EAGER, cascade =
	 * CascadeType.ALL) private Set<Stock> stocks;
	 * 
	 * @OneToMany(mappedBy="User",fetch = FetchType.EAGER, cascade =
	 * CascadeType.ALL) private Set<Bond> bonds;
	 */
	
	/*
	 * @Temporal(TemporalType.DATE)
	 * 
	 * @Column(name="created_date", updatable=false)
	 */
	//private Date created_date = new Date();
	
	/*
	 * @Temporal(TemporalType.DATE)
	 * 
	 * @Column(name="updated_date", insertable=false)
	 */
	//private Date updated_date;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getLname() {
		return lname;
	}

	public void setLname(String lname) {
		this.lname = lname;
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

	public void setPassword(String password) {
		this.password = password;
	}

	public String getIsUploadAllowed() {
		return isUploadAllowed;
	}

	public void setIsUploadAllowed(String isUploadAllowed) {
		this.isUploadAllowed = isUploadAllowed;
	}
	
	

	
	
	
}
