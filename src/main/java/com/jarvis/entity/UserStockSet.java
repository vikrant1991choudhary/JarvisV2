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
@Table(name="userStockSet")

@DynamicInsert
@DynamicUpdate
public class UserStockSet implements Serializable {
	
	@Id
	@Column(name="idStock", nullable=false)
	private Long idStock;
	
	@Id
	@Column(name="idUser", nullable=false)
	private Long idUser;

	public Long getIdStock() {
		return idStock;
	}

	public void setIdStock(Long idStock) {
		this.idStock = idStock;
	}

	public Long getIdUser() {
		return idUser;
	}

	public void setIdUser(Long idUser) {
		this.idUser = idUser;
	}
	
	
	
	

}
