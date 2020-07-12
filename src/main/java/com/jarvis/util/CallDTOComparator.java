package com.jarvis.util;

import java.util.Comparator;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.jarvis.dto.CallDTO;

public class CallDTOComparator implements Comparator<CallDTO>{
	
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
	public int compare(CallDTO c1, CallDTO c2) {
		log.error("this.getPropName() -- " +this.getPropName());
		log.error("1 "+new Double(c1.getCallPrice()));
    	log.error("2 "+new Double(c2.getCallPrice()));
    	int d = 0;
    	if(this.getPropName().equalsIgnoreCase("callPrice")){
    		d = new Double(new Double(c1.getCallPrice()) - new Double(c2.getCallPrice())).intValue();
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
    	
    	if(this.getPropName().equalsIgnoreCase("reqIncrease")){
    		d = new Double(new Double(c1.getStrikePrice()) - new Double(c2.getStrikePrice())).intValue();
    		if(this.getSortColumnOrder()){
    			d = -d; 
    		}
        	log.error("5 "+d);
    	}
    	
    	if(this.getPropName().equalsIgnoreCase("breakEven")){
    		d = new Double(new Double(c1.getStrikePrice()) - new Double(c2.getStrikePrice())).intValue();
    		if(this.getSortColumnOrder()){
    			d = -d; 
    		}
        	log.error("5 "+d);
    	}
    	
    	if(this.getPropName().equalsIgnoreCase("percentage")){
    		d = new Double(new Double(c1.getStrikePrice()) - new Double(c2.getStrikePrice())).intValue();
    		if(this.getSortColumnOrder()){
    			d = -d; 
    		}
        	log.error("5 "+d);
    	}
    	if(this.getPropName().equalsIgnoreCase("leverageRatio")){
    		d = new Double(new Double(c1.getStrikePrice()) - new Double(c2.getStrikePrice())).intValue();
    		if(this.getSortColumnOrder()){
    			d = -d; 
    		}
        	log.error("5 "+d);
    	}
    	
    	return d;
	}

}
