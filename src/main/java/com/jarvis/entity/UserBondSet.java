package com.jarvis.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

@Entity
@Table(name="userBondSet")

@DynamicInsert
@DynamicUpdate
public class UserBondSet implements Serializable {
	
	@Id
	@Column(name="idBond", nullable=false)
	private Long idBond;
	
	@Id
	@Column(name="idUser", nullable=false)
	private Long idUser;

	public Long getIdBond() {
		return idBond;
	}

	public void setIdBond(Long idBond) {
		this.idBond = idBond;
	}

	public Long getIdUser() {
		return idUser;
	}

	public void setIdUser(Long idUser) {
		this.idUser = idUser;
	}
	
	
	

}
