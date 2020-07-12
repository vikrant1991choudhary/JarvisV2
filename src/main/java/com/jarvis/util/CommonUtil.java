/**
 * 
 */
package com.jarvis.util;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.StringTokenizer;

/**
 * @author suchakraborty
 *
 */
public class CommonUtil {

	public static String removeSpaces(String s) {
		 
			return s.replaceAll(" ", ""); // regEx : \\s+
	}
	
	public static boolean isStringEmpty(String value){
	
		return value == null ||  value.trim().length() == 0 ? true : false;
	}
	
	public static boolean isCollectionEmpty(Collection c){
		
		return (c == null) || c.isEmpty();
	}
	
	 public static String createStringFromList(List<String> controlDataProvider)
	 {
		 StringBuilder sb=new StringBuilder();
		 if(controlDataProvider!=null && controlDataProvider.size()>0)
		 {
			 for(String str:controlDataProvider)
			 {
				 if(!isStringEmpty(str))
				 sb.append(str).append('~');
				 
			 }
		} 
		 return sb.substring(0,sb.length()-1);
		 
	 }
	 
	 public static List createListFromString(String controlDataProvider)
	 {
		List<String> controlDataProviderList=new ArrayList<String>();
		StringTokenizer tokenizer=new StringTokenizer(controlDataProvider,"~");
		while(tokenizer.hasMoreTokens())
		{
			controlDataProviderList.add(tokenizer.nextToken());
		}
		return controlDataProviderList;
	 }
	 
	 public static String make1stLetterCaps(String word){
		 if(!isStringEmpty(word))
			 return word.toUpperCase().charAt(0) + word.substring(1, word.length());
		 else
			 return "";
	 }
	
	public static void main(String[] args) {
		//System.out.println(removeSpaces("FR14     2004 1010 0505 0001   3M02 606"));
		//System.out.println(make1stLetterCaps("element"));
		System.out.println("lockedid".substring(0, 4));
	}

}
