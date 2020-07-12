package com.jarvis.service;

import java.util.List;

import com.jarvis.dto.BondDTO;
import com.jarvis.dto.PortfolioDTO;
import com.jarvis.dto.StockDTO;
import com.jarvis.entity.Bond;
import com.jarvis.entity.ResModel;

public interface AdminStockBondService {

	public List<StockDTO> findAllStocks();
	public List<Bond> findAllBonds();
	public List<StockDTO> findAllFavoriteStocks(Long userId);
	public List<Bond> findAllFavoriteBonds(Long userId); 
	public boolean saveFavoriteStock(List<StockDTO> stocks, String userId);
	public boolean saveFavoriteBond(List<BondDTO> bonds, String userId);
	public ResModel addTicker(String tickerName,String company,String sector,String industry,String country,String marketCap);
	public ResModel changePassword(String userEmail, String newPassword);
	public List<StockDTO> getAllStocksForPolio();
	public ResModel createPortfolio(List<String> stockNames, String name) throws Exception;
	public List<PortfolioDTO> getAllPortfolio();
	public List<StockDTO> getAllPortfolioByName(String name);
}
