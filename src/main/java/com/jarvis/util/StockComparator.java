package com.jarvis.util;

import java.util.Comparator;

import com.jarvis.entity.MarketData;


public class StockComparator implements Comparator<MarketData>{

	/* @epsNextYr* : > <no1>;<no2>;<30d estimation>;<next year earning> no4/no3 > 1 => attractive : element14
	 * @priceChange : rising price not %change field ; price change since last upload 
	 * @ytdReturn : increasing since last upload : element11
	 * @pegFwd :lower > larger : element28
	 * @priceByEarning : lower > larger : element22
	 * @priceByBook : lower > larger : element23
	 */ 
	
	public int compare(MarketData m1, MarketData m2) {
		
		int comIndex = -1;
		// stock algo goes here
		// epsNextYr
		
		Double varA = 0.0;
		Double varB = 0.0;
		
		String[] espArr1 = Utility.isNull(m1.getElement14()) ? new String[] {""} : m1.getElement14().split(";");
		String[] espArr2 = Utility.isNull(m2.getElement14()) ? new String[] {""} : m2.getElement14().split(";");
		varA = espArr1.length > 4 ? Double.parseDouble(espArr1[4]) : 0.0;
		varB = espArr1.length > 4 ? Double.parseDouble(espArr1[0]) : 0.0;
		Double epsNY1 = varA-varB ;
		System.out.println(" ticker= " + m1.getElement1() + " varA = " + varA + " varB = " + varB + " epsNY1 = " + epsNY1);
		varA = espArr2.length > 4 ? Double.parseDouble(espArr2[4]) : 0.0;
		varB = espArr2.length > 4 ? Double.parseDouble(espArr2[0]) : 0.0;
		Double epsNY2 = varA-varB ;
		System.out.println(" ticker= " + m2.getElement1() + " varA = " + varA + " varB = " + varB + " epsNY2 = " +epsNY2);
		comIndex = new Double(epsNY2*100 - epsNY1*100).intValue();
		System.out.println("comIndex for esp = " + comIndex);
		if(comIndex == 0) // priceChange
		{
			varA = (Utility.isNull(m1.getElement99()) || m1.getElement99().contains("-")) ? 0.0 : Double.parseDouble(m1.getElement99());
			varB = (Utility.isNull(m2.getElement99()) || m2.getElement99().contains("-")) ? 0.0 : Double.parseDouble(m2.getElement99());
			comIndex = new Double(varA - varB).intValue();
			System.out.println("comIndex for priceChange = " + comIndex);
		}
		if(comIndex == 0) // ytdReturn
		{
			varA = (Utility.isNull(m1.getElement100()) || m1.getElement100().contains("-")) ? 0.0 : Double.parseDouble(m1.getElement100());
			varB = (Utility.isNull(m2.getElement100()) || m2.getElement100().contains("-")) ? 0.0 : Double.parseDouble(m2.getElement100());
			comIndex = new Double(varA - varB).intValue();
			System.out.println("comIndex for ytdReturn = " + comIndex);
		}
		if(comIndex == 0){ // pegFwd
			varA = (Utility.isNull(m1.getElement28()) || m1.getElement28().contains("-")) ? 0.0 : Double.parseDouble(m1.getElement28());
			varB = (Utility.isNull(m2.getElement28()) || m2.getElement28().contains("-")) ? 0.0 : Double.parseDouble(m2.getElement28());
			comIndex = new Double(varA - varB).intValue();
			System.out.println("comIndex for pegFwd = " + comIndex);
		}
		
		if(comIndex == 0){ // priceByEarning
			varA = (Utility.isNull(m1.getElement22()) || m1.getElement22().contains("-")) ? 0.0 : Double.parseDouble(m1.getElement22());
			varB = (Utility.isNull(m2.getElement22()) || m2.getElement22().contains("-")) ? 0.0 : Double.parseDouble(m2.getElement22());
			comIndex = new Double(varA - varB).intValue();
			System.out.println("comIndex for priceByEarning = " + comIndex);
		}
		
		if(comIndex == 0){ // priceByBook
			varA = (Utility.isNull(m1.getElement23()) || m1.getElement23().contains("-")) ? 0.0 : Double.parseDouble(m1.getElement23());
			varB = (Utility.isNull(m2.getElement23()) || m2.getElement23().contains("-")) ? 0.0 : Double.parseDouble(m2.getElement23());
			comIndex = new Double(varA - varB).intValue();
			System.out.println("comIndex for priceByBook = " + comIndex);
		}

		return comIndex;
	}

}
