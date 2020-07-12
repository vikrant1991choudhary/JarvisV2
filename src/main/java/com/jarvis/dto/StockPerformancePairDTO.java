package com.jarvis.dto;

import java.io.Externalizable;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectOutput;
import java.io.Serializable;
import java.util.List;

public class StockPerformancePairDTO implements Serializable,Externalizable {

	private List<StockPerformanceDTO> bestFiveStocks;
	private List<StockPerformanceDTO> worstFiveStocks;
	
	public List<StockPerformanceDTO> getBestFiveStocks() {
		return bestFiveStocks;
	}
	public void setBestFiveStocks(List<StockPerformanceDTO> bestFiveStocks) {
		this.bestFiveStocks = bestFiveStocks;
	}
	public List<StockPerformanceDTO> getWorstFiveStocks() {
		return worstFiveStocks;
	}
	public void setWorstFiveStocks(List<StockPerformanceDTO> worstFiveStocks) {
		this.worstFiveStocks = worstFiveStocks;
	}
	public void readExternal(ObjectInput in) throws IOException,
			ClassNotFoundException {

		bestFiveStocks = (List<StockPerformanceDTO>)in.readObject();
		worstFiveStocks = (List<StockPerformanceDTO>)in.readObject();
	}
	public void writeExternal(ObjectOutput out) throws IOException {

		out.writeObject(bestFiveStocks);
		out.writeObject(worstFiveStocks);
	}
	
	
	
}
