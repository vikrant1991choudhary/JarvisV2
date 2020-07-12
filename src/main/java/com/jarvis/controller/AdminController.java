package com.jarvis.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jarvis.dto.BondDTO;
import com.jarvis.dto.PortfolioDTO;
import com.jarvis.dto.StockDTO;
import com.jarvis.entity.Bond;
import com.jarvis.entity.Call;
import com.jarvis.entity.ResModel;
import com.jarvis.entity.Stock;
import com.jarvis.service.AdminStockBondService;

@Controller
@RequestMapping("/JarvisV2")
public class AdminController {
	
	@Autowired
	AdminStockBondService stockbondservice;

	@GetMapping(value = "/findAllStocks")
	public ResponseEntity<List<StockDTO>> findAllStocks() {
		System.out.println("findAllStocks Controller start");
		try {
			List<StockDTO> stocks = stockbondservice.findAllStocks();
			System.out.println("findAllStocks Controller end");
			return new ResponseEntity<List<StockDTO>>(stocks,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("findAllStocks Controller end");
		return new ResponseEntity<List<StockDTO>>( new ArrayList<>(),HttpStatus.OK);
	}
	
	@GetMapping(value = "/findAllFavoriteStocks")
	public ResponseEntity<List<StockDTO>> findAllFavoriteStocks(@RequestParam("userid") String userid) {
		System.out.println("findAllFavoriteStocks Controller start");
		try {
			List<StockDTO> stocks = stockbondservice.findAllFavoriteStocks(Long.parseLong(userid));
			System.out.println("findAllFavoriteStocks Controller end");
			return new ResponseEntity<List<StockDTO>>(stocks,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("findAllFavoriteStocks Controller end");
		return new ResponseEntity<List<StockDTO>>( new ArrayList<>(),HttpStatus.OK);
	}
	
	@GetMapping(value = "/findAllBonds")
	public ResponseEntity<List<Bond>> findAllBonds() {
		System.out.println("findAllBonds Controller start");
		try {
			List<Bond> bonds = stockbondservice.findAllBonds();
			System.out.println("findAllBonds Controller End");
			return new ResponseEntity<List<Bond>>(bonds,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("findAllBonds Controller End");
		return new ResponseEntity<List<Bond>>(HttpStatus.OK);
	}
	
	@GetMapping(value = "/findAllFavoriteBonds")
	public ResponseEntity<List<Bond>> findAllFavoriteBonds(@RequestParam("userid") String userid) {
		System.out.println("findAllFavoriteBonds Controller start");
		try {
			List<Bond> bonds = stockbondservice.findAllFavoriteBonds(Long.parseLong(userid));
			System.out.println("findAllFavoriteBonds Controller End");
			return new ResponseEntity<List<Bond>>(bonds,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("findAllFavoriteBonds Controller End");
		return new ResponseEntity<List<Bond>>(HttpStatus.OK);
	}
	
	@PostMapping(value="/addTicker")
	public ResponseEntity<ResModel> addTicker(String tickerName,String company,String sector,String industry,String country,String marketCap){
		
		System.out.println("Create Ticker tickerName="+tickerName+"company="+company);
		ResModel addTicker=stockbondservice.addTicker(tickerName,company,sector,industry,country,marketCap);
		
		return new ResponseEntity<ResModel>(addTicker,HttpStatus.OK);
		
	}
	
	@PostMapping(value="/changePassword")
	public ResponseEntity<ResModel> changePassword(@RequestParam(value="userEmail") String userEmail,@RequestParam(value="newPassword")   String newPassword){
		System.out.println("Change PAssword userEmail="+userEmail+"newPassword="+newPassword);
		ResModel addTicker=stockbondservice.changePassword(userEmail,newPassword);
		
		return new ResponseEntity<ResModel>(addTicker,HttpStatus.OK);
		
	}
	
	@PostMapping(value = "/saveFavStock")
	public ResponseEntity<Void> saveFavStock(@RequestBody List<StockDTO> stocks,
			@RequestParam("userid") String userid) {
		System.out.println("saveFavStock Controller start");
		System.out.println(stocks.get(0).getStockName()+"-----------");
		boolean status = false;

		try {
			status = stockbondservice.saveFavoriteStock(stocks, userid);
			return new ResponseEntity<Void>(HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println("saveFavStock Controller end");
		return new ResponseEntity<Void>(HttpStatus.OK);
	}
	
	@PostMapping(value = "/saveFavBond")
	public ResponseEntity<Void> saveFavBond(@RequestBody List<BondDTO> bonds,
			@RequestParam("userid") String userid) {
		System.out.println("saveFavBond Controller start");
		boolean status = false;

		try {
			status = stockbondservice.saveFavoriteBond(bonds, userid);
			return new ResponseEntity<Void>(HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println("saveFavBond Controller end");
		return new ResponseEntity<Void>(HttpStatus.OK);
	}
	
	@GetMapping(value="/getAllStocksForPolio")
	public ResponseEntity<List<StockDTO>> getAllStocksForPolio() {
		System.out.println("getAllStocksForPolio");
		try {
			List<StockDTO> dtos = stockbondservice.getAllStocksForPolio();
			return new ResponseEntity<List<StockDTO>>(dtos, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<List<StockDTO>>(new ArrayList<StockDTO>(), HttpStatus.OK);
	}
	
	
	@PostMapping(value="/createPortfolio")
	public ResponseEntity<ResModel> createPortfolio(@RequestParam(value="name") String name,@RequestParam(value="myArray[]") List<String> stockNames){

		System.out.println("---- createPortfolio"+stockNames.toString() + " -- name -- " + name);
			
			ResModel list;
			try {
				list = stockbondservice.createPortfolio(stockNames,name);
				return new ResponseEntity<ResModel>(list, HttpStatus.OK);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return new ResponseEntity<ResModel>( HttpStatus.NOT_FOUND); 
	}
	
	@GetMapping(value="/getAllPortfolio")
	public ResponseEntity<List<PortfolioDTO>> getAllPortfolio(){

		System.out.println("---- getAllPortfolio");
			
				List<PortfolioDTO> list = new ArrayList();
				list = stockbondservice.getAllPortfolio();
				return new ResponseEntity<List<PortfolioDTO>>(list, HttpStatus.OK);
			
	}
	
	@GetMapping(value="/getAllPortfolioByName")
	public ResponseEntity<List<StockDTO>> getAllPortfolioByName(@RequestParam(value="name") String name){

		System.out.println("---- getAllPortfolioByName");
			
				List<StockDTO> list = new ArrayList();
				list = stockbondservice.getAllPortfolioByName(name);
				return new ResponseEntity<List<StockDTO>>(list, HttpStatus.OK);
			
	}
}
