/**
 * 
 */
package com.jarvis.util;

import java.io.InputStream;
import java.util.Properties;


/**
 * @author suchakraborty
 *
 */
public class PropertiesFileReader {

	private static PropertiesFileReader appConfig;
	private static Properties pro;
	private static InputStream ins;
	
	public PropertiesFileReader(String filePath){
		pro = new Properties();
		try {
			loadPropertyFile(filePath);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static String getProperty(String key){
		if(appConfig == null)
			appConfig = new PropertiesFileReader("appConfig.properties");
		return pro.getProperty(key);
	}
	
	public static String getString(String key){
		if(appConfig == null)
			appConfig = new PropertiesFileReader("appConfig.properties");
		return pro.getProperty(key);
	}
	
	public void loadPropertyFile(String filePath) throws Exception{

		  ins = PropertiesFileReader.class.getClassLoader().getResourceAsStream(filePath);
		  pro.load(ins);

	}
	
	public static void main(String[] args) throws Exception{
		System.out.println(PropertiesFileReader.getProperty("AD"));
	}
}
