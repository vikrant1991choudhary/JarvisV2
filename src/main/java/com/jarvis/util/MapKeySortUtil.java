package com.jarvis.util;

import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

public class MapKeySortUtil  {
	
	private static class ValueComparer implements Comparator{
	
	private Map  _data = null;
	public ValueComparer (Map data){
		super();
		_data = data;
	}
	
     public int compare(Object o1, Object o2) {
    	 Double e1 = (Double) o1;
         Double e2 = (Double) o2;
         System.out.println("compare");
         return Double.compare(e1, e2);
     }
	}
     
     public static void main(String[] args) {
    	 Map<Double, String> unsortedData = new HashMap<Double, String>();
 		 unsortedData.put(15.6, "d");
 		 unsortedData.put(-15.6, "b");
 		 unsortedData.put(1.6, "c");
 		 unsortedData.put(35.6, "d");
 		 unsortedData.put(-19.6, "a");
 		 System.out.println("unsortedData size = " + unsortedData.size());
 		Map<Double, String> sortedData = new TreeMap<Double, String>(new MapKeySortUtil.ValueComparer(unsortedData));
 		System.out.println("sortedData size = " + sortedData.size());
 		for(Double key : sortedData.keySet()){
 			System.out.println(sortedData.get(key));
 		}
	}

}
