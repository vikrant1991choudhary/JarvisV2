/**
 * 
 */
package com.jarvis.entity;

import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.jarvis.util.Utility;


@Entity
@Table(name="marketData")

@DynamicInsert
@DynamicUpdate
public class MarketData implements Serializable, Comparable<MarketData>{

	@Id
	@Column(name="idMarketData", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long idMarketData;
	private String metadataName;

	private String element1;
	private String element2;
	private String element3;
	private String element4;
	private String element5;
	private String element6;
	private String element7;
	private String element8;
	private String element9;
	private String element10;
	private String element11;
	private String element12;
	private String element13;
	private String element14;
	private String element15;
	private String element16;
	private String element17;
	private String element18;
	private String element19;
	private String element20;
	private String element21;
	private String element22;
	private String element23;
	private String element24;
	private String element25;
	private String element26;
	private String element27;
	private String element28;
	private String element29;
	private String element30;
	private String element31;
	private String element32;
	private String element33;
	private String element34;
	private String element35;
	private String element36;
	private String element37;
	private String element38;
	private String element39;
	private String element40;
	private String element41;
	private String element42;
	private String element43;
	private String element44;
	private String element45;
	private String element46;
	private String element47;
	private String element48;
	private String element49;
	private String element50;
	private String element51;
	private String element52;
	private String element53;
	private String element54;
	private String element55;
	private String element56;
	private String element57;
	private String element58;
	private String element59;
	private String element60;

	private String element61;
	private String element62;
	private String element63;
	private String element64;
	private String element65;
	private String element66;
	private String element67;
	private String element68;
	private String element69;
	private String element70;
	private String element71;
	private String element72;
	private String element73;
	private String element74;
	private String element75;
	private String element76;
	private String element77;
	private String element78;
	private String element79;
	private String element80;
	private String element81;
	private String element82;
	private String element83;
	private String element84;
	private String element85;
	private String element86;
	private String element87;
	private String element88;
	private String element89;
	private String element90;
	private String element91;
	private String element92;
	private String element93;
	private String element94;
	private String element95;
	private String element96;
	private String element97;
	private String element98;
	private String element99;
	private String element100;

	private String amount;
	//private MarketDataFile marketDataFile;
	private String isSoftDeleted;
	private String status;

	private String lastUpdatedBy;
	private Date lastUpdatedAt;

	private transient String attractionIndex;


	public Long getIdMarketData() {
		return idMarketData;
	}

	public void setIdMarketData(Long idMarketData) {
		this.idMarketData = idMarketData;
	}

	public String getMetadataName() {
		return metadataName;
	}

	public void setMetadataName(String metadataName) {
		this.metadataName = metadataName;
	}

	public String getElement1() {
		return element1;
	}

	public void setElement1(String element1) {
		this.element1 = element1;
	}

	public String getElement2() {
		return element2;
	}

	public void setElement2(String element2) {
		this.element2 = element2;
	}

	public String getElement3() {
		return element3;
	}

	public void setElement3(String element3) {
		this.element3 = element3;
	}

	public String getElement4() {
		return element4;
	}

	public void setElement4(String element4) {
		this.element4 = element4;
	}

	public String getElement5() {
		return element5;
	}

	public void setElement5(String element5) {
		this.element5 = element5;
	}

	public String getElement6() {
		return element6;
	}

	public void setElement6(String element6) {
		this.element6 = element6;
	}

	public String getElement7() {
		return element7;
	}

	public void setElement7(String element7) {
		this.element7 = element7;
	}

	public String getElement8() {
		return element8;
	}

	public void setElement8(String element8) {
		this.element8 = element8;
	}

	public String getElement9() {
		return element9;
	}

	public void setElement9(String element9) {
		this.element9 = element9;
	}

	public String getElement10() {
		return element10;
	}

	public void setElement10(String element10) {
		this.element10 = element10;
	}

	public String getElement11() {
		return element11;
	}

	public void setElement11(String element11) {
		this.element11 = element11;
	}

	public String getElement12() {
		return element12;
	}

	public void setElement12(String element12) {
		this.element12 = element12;
	}

	public String getElement13() {
		return element13;
	}

	public void setElement13(String element13) {
		this.element13 = element13;
	}

	public String getElement14() {
		return element14;
	}

	public void setElement14(String element14) {
		this.element14 = element14;
	}

	public String getElement15() {
		return element15;
	}

	public void setElement15(String element15) {
		this.element15 = element15;
	}

	public String getElement16() {
		return element16;
	}

	public void setElement16(String element16) {
		this.element16 = element16;
	}

	public String getElement17() {
		return element17;
	}

	public void setElement17(String element17) {
		this.element17 = element17;
	}

	public String getElement18() {
		return element18;
	}

	public void setElement18(String element18) {
		this.element18 = element18;
	}

	public String getElement19() {
		return element19;
	}

	public void setElement19(String element19) {
		this.element19 = element19;
	}

	public String getElement20() {
		return element20;
	}

	public void setElement20(String element20) {
		this.element20 = element20;
	}

	public String getElement21() {
		return element21;
	}

	public void setElement21(String element21) {
		this.element21 = element21;
	}

	public String getElement22() {
		return element22;
	}

	public void setElement22(String element22) {
		this.element22 = element22;
	}

	public String getElement23() {
		return element23;
	}

	public void setElement23(String element23) {
		this.element23 = element23;
	}

	public String getElement24() {
		return element24;
	}

	public void setElement24(String element24) {
		this.element24 = element24;
	}

	public String getElement25() {
		return element25;
	}

	public void setElement25(String element25) {
		this.element25 = element25;
	}

	public String getElement26() {
		return element26;
	}

	public void setElement26(String element26) {
		this.element26 = element26;
	}

	public String getElement27() {
		return element27;
	}

	public void setElement27(String element27) {
		this.element27 = element27;
	}

	public String getElement28() {
		return element28;
	}

	public void setElement28(String element28) {
		this.element28 = element28;
	}

	public String getElement29() {
		return element29;
	}

	public void setElement29(String element29) {
		this.element29 = element29;
	}

	public String getElement30() {
		return element30;
	}

	public void setElement30(String element30) {
		this.element30 = element30;
	}

	public String getElement31() {
		return element31;
	}

	public void setElement31(String element31) {
		this.element31 = element31;
	}

	public String getElement32() {
		return element32;
	}

	public void setElement32(String element32) {
		this.element32 = element32;
	}

	public String getElement33() {
		return element33;
	}

	public void setElement33(String element33) {
		this.element33 = element33;
	}

	public String getElement34() {
		return element34;
	}

	public void setElement34(String element34) {
		this.element34 = element34;
	}

	public String getElement35() {
		return element35;
	}

	public void setElement35(String element35) {
		this.element35 = element35;
	}

	public String getElement36() {
		return element36;
	}

	public void setElement36(String element36) {
		this.element36 = element36;
	}

	public String getElement37() {
		return element37;
	}

	public void setElement37(String element37) {
		this.element37 = element37;
	}

	public String getElement38() {
		return element38;
	}

	public void setElement38(String element38) {
		this.element38 = element38;
	}

	public String getElement39() {
		return element39;
	}

	public void setElement39(String element39) {
		this.element39 = element39;
	}

	public String getElement40() {
		return element40;
	}

	public void setElement40(String element40) {
		this.element40 = element40;
	}

	public String getElement41() {
		return element41;
	}

	public void setElement41(String element41) {
		this.element41 = element41;
	}

	public String getElement42() {
		return element42;
	}

	public void setElement42(String element42) {
		this.element42 = element42;
	}

	public String getElement43() {
		return element43;
	}

	public void setElement43(String element43) {
		this.element43 = element43;
	}

	public String getElement44() {
		return element44;
	}

	public void setElement44(String element44) {
		this.element44 = element44;
	}

	public String getElement45() {
		return element45;
	}

	public void setElement45(String element45) {
		this.element45 = element45;
	}

	public String getElement46() {
		return element46;
	}

	public void setElement46(String element46) {
		this.element46 = element46;
	}

	public String getElement47() {
		return element47;
	}

	public void setElement47(String element47) {
		this.element47 = element47;
	}

	public String getElement48() {
		return element48;
	}

	public void setElement48(String element48) {
		this.element48 = element48;
	}

	public String getElement49() {
		return element49;
	}

	public void setElement49(String element49) {
		this.element49 = element49;
	}

	public String getElement50() {
		return element50;
	}

	public void setElement50(String element50) {
		this.element50 = element50;
	}

	public String getElement51() {
		return element51;
	}

	public void setElement51(String element51) {
		this.element51 = element51;
	}

	public String getElement52() {
		return element52;
	}

	public void setElement52(String element52) {
		this.element52 = element52;
	}

	public String getElement53() {
		return element53;
	}

	public void setElement53(String element53) {
		this.element53 = element53;
	}

	public String getElement54() {
		return element54;
	}

	public void setElement54(String element54) {
		this.element54 = element54;
	}

	public String getElement55() {
		return element55;
	}

	public void setElement55(String element55) {
		this.element55 = element55;
	}

	public String getElement56() {
		return element56;
	}

	public void setElement56(String element56) {
		this.element56 = element56;
	}

	public String getElement57() {
		return element57;
	}

	public void setElement57(String element57) {
		this.element57 = element57;
	}

	public String getElement58() {
		return element58;
	}

	public void setElement58(String element58) {
		this.element58 = element58;
	}

	public String getElement59() {
		return element59;
	}

	public void setElement59(String element59) {
		this.element59 = element59;
	}

	public String getElement60() {
		return element60;
	}

	public void setElement60(String element60) {
		this.element60 = element60;
	}

	public String getElement61() {
		return element61;
	}

	public void setElement61(String element61) {
		this.element61 = element61;
	}

	public String getElement62() {
		return element62;
	}

	public void setElement62(String element62) {
		this.element62 = element62;
	}

	public String getElement63() {
		return element63;
	}

	public void setElement63(String element63) {
		this.element63 = element63;
	}

	public String getElement64() {
		return element64;
	}

	public void setElement64(String element64) {
		this.element64 = element64;
	}

	public String getElement65() {
		return element65;
	}

	public void setElement65(String element65) {
		this.element65 = element65;
	}

	public String getElement66() {
		return element66;
	}

	public void setElement66(String element66) {
		this.element66 = element66;
	}

	public String getElement67() {
		return element67;
	}

	public void setElement67(String element67) {
		this.element67 = element67;
	}

	public String getElement68() {
		return element68;
	}

	public void setElement68(String element68) {
		this.element68 = element68;
	}

	public String getElement69() {
		return element69;
	}

	public void setElement69(String element69) {
		this.element69 = element69;
	}

	public String getElement70() {
		return element70;
	}

	public void setElement70(String element70) {
		this.element70 = element70;
	}

	public String getElement71() {
		return element71;
	}

	public void setElement71(String element71) {
		this.element71 = element71;
	}

	public String getElement72() {
		return element72;
	}

	public void setElement72(String element72) {
		this.element72 = element72;
	}

	public String getElement73() {
		return element73;
	}

	public void setElement73(String element73) {
		this.element73 = element73;
	}

	public String getElement74() {
		return element74;
	}

	public void setElement74(String element74) {
		this.element74 = element74;
	}

	public String getElement75() {
		return element75;
	}

	public void setElement75(String element75) {
		this.element75 = element75;
	}

	public String getElement76() {
		return element76;
	}

	public void setElement76(String element76) {
		this.element76 = element76;
	}

	public String getElement77() {
		return element77;
	}

	public void setElement77(String element77) {
		this.element77 = element77;
	}

	public String getElement78() {
		return element78;
	}

	public void setElement78(String element78) {
		this.element78 = element78;
	}

	public String getElement79() {
		return element79;
	}

	public void setElement79(String element79) {
		this.element79 = element79;
	}

	public String getElement80() {
		return element80;
	}

	public void setElement80(String element80) {
		this.element80 = element80;
	}

	public String getElement81() {
		return element81;
	}

	public void setElement81(String element81) {
		this.element81 = element81;
	}

	public String getElement82() {
		return element82;
	}

	public void setElement82(String element82) {
		this.element82 = element82;
	}

	public String getElement83() {
		return element83;
	}

	public void setElement83(String element83) {
		this.element83 = element83;
	}

	public String getElement84() {
		return element84;
	}

	public void setElement84(String element84) {
		this.element84 = element84;
	}

	public String getElement85() {
		return element85;
	}

	public void setElement85(String element85) {
		this.element85 = element85;
	}

	public String getElement86() {
		return element86;
	}

	public void setElement86(String element86) {
		this.element86 = element86;
	}

	public String getElement87() {
		return element87;
	}

	public void setElement87(String element87) {
		this.element87 = element87;
	}

	public String getElement88() {
		return element88;
	}

	public void setElement88(String element88) {
		this.element88 = element88;
	}

	public String getElement89() {
		return element89;
	}

	public void setElement89(String element89) {
		this.element89 = element89;
	}

	public String getElement90() {
		return element90;
	}

	public void setElement90(String element90) {
		this.element90 = element90;
	}

	public String getElement91() {
		return element91;
	}

	public void setElement91(String element91) {
		this.element91 = element91;
	}

	public String getElement92() {
		return element92;
	}

	public void setElement92(String element92) {
		this.element92 = element92;
	}

	public String getElement93() {
		return element93;
	}

	public void setElement93(String element93) {
		this.element93 = element93;
	}

	public String getElement94() {
		return element94;
	}

	public void setElement94(String element94) {
		this.element94 = element94;
	}

	public String getElement95() {
		return element95;
	}

	public void setElement95(String element95) {
		this.element95 = element95;
	}

	public String getElement96() {
		return element96;
	}

	public void setElement96(String element96) {
		this.element96 = element96;
	}

	public String getElement97() {
		return element97;
	}

	public void setElement97(String element97) {
		this.element97 = element97;
	}

	public String getElement98() {
		return element98;
	}

	public void setElement98(String element98) {
		this.element98 = element98;
	}

	public String getElement99() {
		return element99;
	}

	public void setElement99(String element99) {
		this.element99 = element99;
	}

	public String getElement100() {
		return element100;
	}

	public void setElement100(String element100) {
		this.element100 = element100;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	/*public MarketDataFile getMarketDataFile() {
		return marketDataFile;
	}

	public void setMarketDataFile(MarketDataFile marketDataFile) {
		this.marketDataFile = marketDataFile;
	}
*/
	public String getIsSoftDeleted() {
		return isSoftDeleted;
	}

	public void setIsSoftDeleted(String isSoftDeleted) {
		this.isSoftDeleted = isSoftDeleted;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getLastUpdatedBy() {
		return lastUpdatedBy;
	}

	public void setLastUpdatedBy(String lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}

	public Date getLastUpdatedAt() {
		return lastUpdatedAt;
	}

	public void setLastUpdatedAt(Date lastUpdatedAt) {
		this.lastUpdatedAt = lastUpdatedAt;
	}

	public String getAttractionIndex() {
		return attractionIndex;
	}

	public void setAttractionIndex(String attractionIndex) {
		this.attractionIndex = attractionIndex;
	}

	public int compareTo(MarketData marketData) {

		int comIndex = 0;
		//System.out.println("compareTO : metaDataName ----------------> " + this.getMetadataName());
		if(this.getMetadataName().equals("Tickers_Watchlist")){
			
			try {
				
				if(this.getElement3() == null || "-".equals(this.getElement3().trim()) || marketData.getElement3() == null || "-".equals(marketData.getElement3().trim()))
					comIndex = 0;
				else{
					comIndex = new Double(Double.valueOf(this.getElement3()) - Double.valueOf(marketData.getElement3())).intValue();
				}
			} catch (NumberFormatException e) {
				comIndex = 0;
				e.printStackTrace();
			}
			//System.out.println("Tickers_Watchlist : comIndex : " + comIndex);
		}
		
        if(this.getMetadataName().equals("Bondpricing_Master")){
			
        	/********************** compare index : rating **********************************/
    		//String ratings[] = {"AAA","AA","A","BBB","BB","B","CCC","CC","C","NR"};
    		String ratings[] = {"AAA+","AAA","AAA-","AA+","AA","AA-","A+","A","A-","BBB+","BBB","BBB-","BB+","BB","BB-","B+","B","B-",
    				            "CCC+","CCC","CCC-","CC+","CC","CC-","C+","C","C-","DDD+","DDD","DDD-","DD+","DD","DD-","D+","D","D-","NR"};
    		Map<String,Integer> ratingMap = new LinkedHashMap<String,Integer>();
    		int i = 30;
    		for(String rat : ratings){
    			ratingMap.put(rat, new Integer(i));
    			i--;
    		}
    		String rating1 = "NR";
    		if(!Utility.isNullOrEmpty(marketData.getElement8()))
    			rating1 = marketData.getElement8();
    		
    		String actualRating = "";
    		String arr[] = rating1.split("/");
    		if(arr.length == 0 && !Utility.isNullOrEmpty(rating1)){
    			/*rating1 += "/" + rating1.substring(0, 1);
    			arr = rating1.split("/");*/
    			actualRating = rating1;
    		}else{
    			actualRating = arr[0];
    		}
    		
    		if(actualRating.equals("-") || actualRating.equals("+") || actualRating.equalsIgnoreCase("WR") || actualRating.equalsIgnoreCase("NR") || 
    				actualRating.equalsIgnoreCase("no rating"))
    			actualRating = "NR"; 
    		/*else if(actualRating.contains("+"))
    			actualRating =  actualRating.substring(0, actualRating.indexOf("+"));
    			//actualRating = "NR"; 
    		else if(actualRating.contains("-"))
    			actualRating =  actualRating.substring(0, actualRating.indexOf("-"));*/
    			//actualRating = "NR"; 
    		/*else if(actualRating.matches("^.*\\d$"))
    			actualRating =  actualRating.substring(0, actualRating.length()-1);*/
    		else if(Utility.isNullOrEmpty(actualRating))
    			actualRating = rating1.substring(0,1); 
    		
    		//System.out.println("Bondpricing_Master : actualRating = " + actualRating);
    		try {
    			if(!actualRating.equals("NR") && actualRating.length()>1 && Character.isUpperCase(actualRating.charAt(0)) && (Character.isLowerCase(actualRating.charAt(1))
    					|| Character.isDigit(actualRating.charAt(1)) ) ){
    				actualRating = rating1.substring(0,1); 
    			}/*else if(!actualRating.equals("NR") && Character.isUpperCase(actualRating.charAt(0)) && Character.isUpperCase(actualRating.charAt(1))){
    				
    			}*/
    		} catch (Exception e1) {
    			System.out.println("Exception Bondpricing_Master :  ----- id ----- "+this.idMarketData);
    			e1.printStackTrace();
    		}
    		
    		/*//String actualRating = arr[arr.length-1];
    		String actualRating = arr[1];
    		if(actualRating.contains("+"))
    			actualRating =  actualRating.substring(0, actualRating.indexOf("+"));
    		else if(actualRating.contains("-"))
    			actualRating =  actualRating.substring(0, actualRating.indexOf("-"));
    		else if(actualRating.matches("^.*\\d$"))
    			actualRating =  actualRating.substring(0, actualRating.length()-1);
    		else if(Utility.isNullOrEmpty(actualRating))
    			actualRating = rating1.substring(0,1); 
    		 */
    		
    		String rating2 = this.getElement8();
    		String actualRating2 = "";
    		String arr2[] = rating2.split("/");
    		if(arr2.length == 0 && !Utility.isNullOrEmpty(rating2)){
    			actualRating2 = rating2;
    		}else{
    			actualRating2 = arr2[0];
    		}
    		
    		if(actualRating2.equals("-") || actualRating2.equals("+") || actualRating2.equalsIgnoreCase("WR") || actualRating2.equalsIgnoreCase("NR") || 
    				actualRating2.equalsIgnoreCase("no rating"))
    			actualRating2 = "NR"; 
    		/*else if(actualRating2.contains("+"))
    			actualRating2 =  actualRating2.substring(0, actualRating2.indexOf("+"));
    			//actualRating2 = "NR"; 
    		else if(actualRating2.contains("-"))
    			actualRating2 =  actualRating2.substring(0, actualRating2.indexOf("-"));*/
    			//actualRating2 = "NR"; 
    		/*else if(actualRating.matches("^.*\\d$"))
    			actualRating =  actualRating.substring(0, actualRating.length()-1);*/
    		else if(!Utility.isNullOrEmpty(actualRating2))
    			actualRating2 = rating2.substring(0,1); 
    		
    		//System.out.println("Bondpricing_Master : actualRating2 = " + actualRating2);
    		try {
    			if(!actualRating2.equals("NR") && actualRating2.length()>1 && Character.isUpperCase(actualRating2.charAt(0)) && (Character.isLowerCase(actualRating2.charAt(1))
    					|| Character.isDigit(actualRating2.charAt(1)) ) ){
    				actualRating2 = rating2.substring(0,1); 
    			}/*else if(!actualRating2.equals("NR") && Character.isUpperCase(actualRating2.charAt(0)) && Character.isUpperCase(actualRating2.charAt(1))){
    				
    			}*/
    		} catch (Exception e1) {
    			System.out.println("Exception Bondpricing_Master : actualRating2 = " + actualRating2+" ----- id ----- "+this.idMarketData);
    			e1.printStackTrace();
    		}
    		
    		/*//String actualRating2 = arr2[arr2.length-1];
    		String actualRating2 = arr2[1];
    		if(actualRating2.contains("+"))
    			actualRating2 =  actualRating2.substring(0, actualRating2.indexOf("+"));
    		else if(actualRating2.contains("-"))
    			actualRating2 =  actualRating2.substring(0, actualRating2.indexOf("-"));
    		else if(actualRating2.matches("^.*\\d$"))
    			actualRating2 =  actualRating2.substring(0, actualRating2.length()-1);
    		else if(Utility.isNullOrEmpty(actualRating2))
    			actualRating2 = rating2.substring(0,1);*/ 

    		//System.out.println(this.idMarketData + " " + actualRating.toUpperCase() + " ----------- " + actualRating2.toUpperCase());
    		
    		try {
    			if(ratingMap.containsKey(actualRating.toUpperCase()) && ratingMap.containsKey(actualRating2.toUpperCase()))
    				comIndex = ratingMap.get(actualRating.toUpperCase())  - ratingMap.get(actualRating2.toUpperCase());
    			else
    				comIndex =  100;
    		} catch (Exception e) {
    			e.printStackTrace();
    			comIndex =  100;
    		}
    		
    		/********************** compare index : AttractionIndex **********************************/

    		/*if(comIndex == 0){
    			if(marketData.getAttractionIndex()!=null && this.attractionIndex!=null){
    				comIndex = new Double(Double.valueOf(marketData.getAttractionIndex()) - Double.valueOf(this.attractionIndex)).intValue();
    			}
    		}*/

    		try {
    			if(comIndex == 0){
    				if(!Utility.isNullOrEmpty(marketData.getAttractionIndex()) && !Utility.isNullOrEmpty(this.attractionIndex)){
    					comIndex = new Double(Double.valueOf(marketData.getAttractionIndex()) - Double.valueOf(this.attractionIndex)).intValue();
    					//System.out.println("AttractionIndex : " + comIndex);
    				}
    			}
    		} catch (Exception e1) {
    			comIndex = 100;
    			e1.printStackTrace();
    		}

    		/********************** compare index : Maturity **********************************/

    		long time1 = 0;
    		long time2 = 0;
    		int comYIndex = -1;
    		if(comIndex == 0){
    			Calendar cal1 = Calendar.getInstance();
    			Calendar cal2 = Calendar.getInstance();
    			SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
    			try {
    				cal1.setTime(sdf.parse(marketData.getElement7()));
    				time1 = cal1.getTimeInMillis();
    				cal2.setTime(sdf.parse(this.getElement7()));
    				time2 = cal2.getTimeInMillis();
    				Long diff = (time2-time1)/60000;
    				comIndex = Integer.parseInt(diff.toString());
    				//System.out.println("comIndex = " + comIndex);
    				int year1 = cal1.get(Calendar.YEAR);
    				int year2 = cal2.get(Calendar.YEAR);
    				comYIndex = year1 - year2;
    			} catch (Exception e) {
    				// TODO Auto-generated catch block
    				e.printStackTrace();
    				comIndex = 100; 
    			}
    		}

    		/********************** compare index : YTM **********************************/
    		/* Priority YTM higher value upper position */
    		if(comYIndex == 0){
    			try {
    				Double ytm1 = new Double(marketData.getElement3());
    				Double ytm2 = new Double(this.getElement3());
    				Double diff = ytm1 - ytm2;
    				comIndex = diff.intValue();
    			} catch (Exception e) {
    				// TODO Auto-generated catch block
    				e.printStackTrace();
    				comIndex = 100;
    			}
    		}

    		/********************** compare index : Callable **********************************/
    		/* Priority Callable no in upper position */
    		int call1 = 0;
    		int call2 = 0;
    		if(comIndex == 0){
    			if("no".equalsIgnoreCase(marketData.getElement4()) ){
    				call1 = 1;
    			}else if("yes".equalsIgnoreCase(marketData.getElement4()) ){
    				call1 = 0;
    			}
    			if("no".equalsIgnoreCase(this.getElement4()) ){
    				call2 = 1;
    			}else if("yes".equalsIgnoreCase(this.getElement4()) ){
    				call2 = 0;
    			}
    			comIndex = call2 - call1;
    		}

    		/********************** compare index : Secured **********************************/
    		/* Priority Secured yes in upper position */
    		int sec1 = 0;
    		int sec2 = 0;
    		if(comIndex == 0){
    			if("no".equalsIgnoreCase(marketData.getElement4()) ){
    				sec1 = 0;
    			}else if("yes".equalsIgnoreCase(marketData.getElement4()) ){
    				sec1 = 1;
    			}
    			if("no".equalsIgnoreCase(this.getElement6()) ){
    				sec2 = 0;
    			}else if("yes".equalsIgnoreCase(this.getElement6()) ){
    				sec2 = 1;
    			}
    			comIndex = sec2 - sec1;

    		}

		}
        return comIndex;
		
		//return marketData.getIdMarketData().intValue() - this.getIdMarketData().intValue();
	}

	public static void main(String[] args) {
		/*Double ytm1 = Double.valueOf("4.5");
		Double ytm2 = Double.valueOf("1.3");
		Double diff = ytm1 - ytm2;
		int comIndex = diff.intValue();
		System.out.println("VV2".matches("^.*\\d$"));
		System.out.println("VV".matches("^.*\\d$"));
		//System.out.println(comIndex);*/
		String rating1 = "NR/CC";
		String arr[] = rating1.split("/");
		if(arr.length == 0 && !Utility.isNullOrEmpty(rating1)){
			rating1 += "/" + rating1.substring(0, 1);
			arr = rating1.split("/");
		}
		//String actualRating = arr[arr.length-1];
		String actualRating = arr[0];
		if(actualRating.contains("+"))
			actualRating =  actualRating.substring(0, actualRating.indexOf("+"));
		else if(actualRating.contains("-"))
			actualRating =  actualRating.substring(0, actualRating.indexOf("-"));
		/*else if(actualRating.matches("^.*\\d$"))
			actualRating =  actualRating.substring(0, actualRating.length()-1);*/
		else if(Utility.isNullOrEmpty(actualRating))
			actualRating = rating1.substring(0,1); 
		
		if(Character.isUpperCase(actualRating.charAt(0)) && (Character.isLowerCase(actualRating.charAt(1))
				|| Character.isDigit(actualRating.charAt(1)) ) ){
			actualRating = rating1.substring(0,1); 
		}else if(Character.isUpperCase(actualRating.charAt(0)) && Character.isUpperCase(actualRating.charAt(1))){
			
		}
		//System.out.println("actualRating = " + actualRating);
		
	}

}
