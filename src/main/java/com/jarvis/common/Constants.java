/**
 * 
 */
package com.jarvis.common;

import com.jarvis.util.PropertiesFileReader;

/**
 * @author msaugata
 *
 */
public class Constants {

	public static final String APPLICATION_URL = PropertiesFileReader.getString("application_url");

	public static int EXACT = 1;
	public static int LIKE = 2;

	public static final String ROLE_NAME_ROLE_TABLE = "roleName";
	public static final String ROLE_ADMIN = "Admin";
	public static final String ROLE_END_USER = "enduser";

	
	  public static final String IS_MAIL_AUTHENTICATE = PropertiesFileReader.getString("is_mail_authenticate"); 
	  public static final String AUTH_UID = PropertiesFileReader.getString("auth_uid"); 
	  public static final String AUTH_PWD = PropertiesFileReader.getString("auth_pwd"); 
	  public static final String MAIL_HOST = PropertiesFileReader.getString("mail_host");
	  public static final String MAIL_FROM = PropertiesFileReader.getString("mail_from");
	 

	public static final String IMPORT_TYPE_NETTED = "Netted Transaction";
	public static final String IMPORT_TYPE_BULK = "Bulk Transaction";
	public static final String IMPORT_TYPE_FILEBASED = "File Based Transaction";

	//public static final String CONNECTION_URL = "jdbc:mysql://localhost:3306/jarvis";
	public static final String CONNECTION_URL = "jdbc:sqlserver://localhost:1433;databaseName=MarketDataAnalyzer";
	

        //	public static final String CONNECTION_URL = "jdbc:jtds:sqlserver://localhost:1433/MarketDataAnalyzer;user=sa;password=ef0rce!@#";

			

	// public static final String CONNECTION_U_NAME ="sa"; //"root";
	// public static final String CONNECTION_U_PWD = "ef0rce!@#";
	
	public static final String CONNECTION_U_NAME ="sa"; //"root";
	public static final String CONNECTION_U_PWD = "passwd";
	
	public static final String FileInServer="A:/Data";
	
	// Added by Vikrant
	//public static final String FileInServer = "C:\\data\\";
	
	
}
