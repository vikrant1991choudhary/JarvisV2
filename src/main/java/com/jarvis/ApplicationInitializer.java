package com.jarvis;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import com.jarvis.dao.UserDAORepository;

import org.apache.tomcat.util.scan.StandardJarScanner;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication(exclude = HibernateJpaAutoConfiguration.class)
//@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class, HibernateJpaAutoConfiguration.class})
@Configuration
@ComponentScan("com")
//@EnableJpaRepositories(basePackageClasses = UserDAORepository.class) 
//@EnableWebMvc
public class ApplicationInitializer extends SpringBootServletInitializer {

	@Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(ApplicationInitializer.class);
    }

	@Bean
    public TomcatServletWebServerFactory tomcatFactory() {
      return new TomcatServletWebServerFactory() {
        @Override
        protected void postProcessContext(org.apache.catalina.Context context) {
          ((StandardJarScanner) context.getJarScanner()).setScanManifest(false);
        }
      };
    }
	
	public static void main(String[] args) {
		SpringApplication.run(ApplicationInitializer.class, args);
	}
}
