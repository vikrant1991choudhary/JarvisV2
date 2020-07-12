package com.jarvis.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.jarvis.entity.User;

@Repository
public interface UserDAORepository extends JpaRepository<User, Integer> {
	
	@Query(value = "select * from tblUser where email = ?1 AND password = ?2 and isSoftDeleted='N'" , nativeQuery = true)
	public User findUserByCredential(String email, String password);
	
	//@Query(value = "select * from tblUser where idUser = ?1", nativeQuery = true)
	public User findUserById(Long idUser);
	
	public User findUserByEmail(String email);

	
	
}
