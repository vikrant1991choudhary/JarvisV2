package com.jarvis.util;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;


/**
 * @author suchakraborty
 * 
 */
public class Utility {

	
	public static String getDateString(Date date, String dateFormat) {
		assert (date != null && dateFormat != null
				& date.toString().length() > 0 && dateFormat.length() > 0) : "Util.getDateString params cannot be null or empty";
		SimpleDateFormat sdf = new SimpleDateFormat();
		sdf.applyPattern(dateFormat);
		return sdf.format(date);
	}

	
	public static synchronized Date getDate(String date, String dateFormat) {
		assert (date != null && dateFormat != null & date.length() > 0 && dateFormat
				.length() > 0) : "Util.getDateString params cannot be null or empty";
		SimpleDateFormat sdf = new SimpleDateFormat();
		sdf.applyPattern(dateFormat);
		try {
			return sdf.parse(date);
		} catch (ParseException e) {
			return null;
		}
	}

	public static synchronized Calendar getDate(Date date) {
		assert (date != null) : "Date cannot be null";
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		return cal;
	}

	public static String zeroPadding(int integer) {
		if (integer <= 9)
			return "0" + integer;
		else
			return "" + integer;
	}

	public static Calendar getTodayInstance() {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		return calendar;
	}

	public static Calendar getSpecifiedInstance(int dayofMonth) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.DAY_OF_MONTH, dayofMonth);
		return calendar;
	}

	public static boolean isNullOrEmpty(Collection c) {
		return (c == null) || c.isEmpty();
	}

	public static boolean isNullOrEmpty(String input) {
		return (input == null || input.trim().length() == 0 || "".equals(input)
				|| "null".equalsIgnoreCase(input) || input.length() == 0);
	}

	public static boolean isNull(String s) {

		return ((s == null) || ("".equalsIgnoreCase(s))
				|| ("null".equalsIgnoreCase(s)) || (s.trim().length() == 0) || (s
				.equalsIgnoreCase(null)));
	}

	public String dateToString(Calendar d) {
		String returnString = "";
		if (d != null && !("".equals(d)) && !"null".equals(d)) {
			SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy");
			returnString = format.format(d);
		}
		return returnString;

	}
	
	public static String saveFileInServer(String fileDir, byte[] fileData, String fileName){
		
		byte[] filesData = fileData;
		String fileLocation = "";
		fileLocation = fileDir + "//" + fileName;
		System.out.println("saveFileInServer :: " + fileLocation);
		FileOutputStream outStream;
		try {
			
			outStream = new FileOutputStream(fileLocation);
			outStream.write(filesData);
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println("saveFileInServer :: " + fileLocation);
		return fileLocation;
		
	}

}
