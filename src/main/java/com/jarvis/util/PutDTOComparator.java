package com.jarvis.util;

import java.util.Comparator;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.jarvis.dto.PutDTO;


public class PutDTOComparator  implements Comparator<PutDTO>{

private static final Log log = LogFactory.getLog(CallDTOComparator.class);
	
	private String propName;
	private Boolean sortColumnOrder;

	public String getPropName() {
		return propName;
	}

	public void setPropName(String propName) {
		this.propName = propName;
	}

	public Boolean getSortColumnOrder() {
		return sortColumnOrder;
	}

	public void setSortColumnOrder(Boolean sortColumnOrder) {
		this.sortColumnOrder = sortColumnOrder;
	}
	
	@Override
	public int compare(PutDTO c1, PutDTO c2) {
		log.error("this.getPropName() -- " +this.getPropName());
		//log.error("1 "+new Double(c1.getPutPrice()));
    	//log.error("2 "+new Double(c2.getPutPrice()));
    	int d = 0;
    	try {
			if(this.getPropName() == null){
				return d;
			}
			
			if(this.getPropName().equalsIgnoreCase("putPrice")){
				d = new Double(new Double(c1.getPutPrice()) - new Double(c2.getPutPrice())).intValue();
				if(this.getSortColumnOrder()){
					d = -d; 
				}
				log.error("4 "+d);
			}
			if(this.getPropName().equalsIgnoreCase("strikePrice")){
				d = new Double(new Double(c1.getStrikePrice()) - new Double(c2.getStrikePrice())).intValue();
				if(this.getSortColumnOrder()){
					d = -d; 
				}
				log.error("5 "+d);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace(); 
		}
    	
    	return d;
	}

}
