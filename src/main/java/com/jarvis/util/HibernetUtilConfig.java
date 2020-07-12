package com.jarvis.util;

import java.util.Properties;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.*;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableJpaRepositories(basePackages="com.jarvis.dao",
		entityManagerFactoryRef="sessionFactory",
		transactionManagerRef="transactionManager")
@EnableTransactionManagement
public class HibernetUtilConfig {
	
	@Value("${db.driver}")
	private String DB_DRIVER;
	
	@Value("${db.url}")
	private String DB_URL;
	
	@Value("${db.username}")
	private String DB_USER;
	
	@Value("${db.password}")
	private String DB_PASSWORD;
	
	@Value("${hibernate.show_sql}")
	private String SHOW_SQL;
	
	@Value("${hibernate.dialect}")
	private String DIALECT;
	
	/*
	 * @Value("${hibernate.hbm2ddl.auto}") private String DDL_AUTO;
	 */
	
	@Value("${entitymanager.packagesToScan}")
	private String PACKAGES_TO_SCAN;
	
	@Bean
	public DataSource datasource(){
		DriverManagerDataSource datasource = new DriverManagerDataSource();
		datasource.setDriverClassName(DB_DRIVER);
		datasource.setUrl(DB_URL);
		datasource.setUsername(DB_USER);
		datasource.setPassword(DB_PASSWORD);
		return datasource;
	}
	
	@Bean
	public LocalSessionFactoryBean sessionFactory(){
		LocalSessionFactoryBean sessionFactory = new LocalSessionFactoryBean();
		sessionFactory.setDataSource(datasource());
		sessionFactory.setPackagesToScan(PACKAGES_TO_SCAN);
		
		Properties hibernetproperties = new Properties();
		hibernetproperties.put("hibernet.dialect",DIALECT);
		hibernetproperties.put("hibernet.show-sql", SHOW_SQL);
		//hibernetproperties.put("hibernate.hbm2ddl.auto", DDL_AUTO);
		
		sessionFactory.setHibernateProperties(hibernetproperties);
		
		return sessionFactory;
	}
	
	@Bean
	public HibernateTransactionManager transactionManager(){
		HibernateTransactionManager transactionManager = new HibernateTransactionManager();
		transactionManager.setSessionFactory(sessionFactory().getObject());
		return transactionManager;
	}
}
