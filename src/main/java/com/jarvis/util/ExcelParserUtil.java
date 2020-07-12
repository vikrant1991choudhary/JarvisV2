/**
 * 
 */
package com.jarvis.util;

import java.io.FileInputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.RichTextString;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

/**
 * @author suchakraborty
 *
 */
public class ExcelParserUtil {
	
	private static Map<Integer, String> headerMap = new LinkedHashMap<Integer, String>();

	public static List<String> getHeadersOfExcelForMetadata(HSSFWorkbook wb) throws Exception{

		//InputStream inp = new FileInputStream(wb);
		//Workbook wb = WorkbookFactory.create(inp);
		Sheet sheet = wb.getSheetAt(0);

		Iterator<Row> rows = sheet.rowIterator();
		List<String> headerList = new ArrayList<String>();
		String header = "";
		RichTextString richTextString = null;
		while (rows.hasNext ())
		{ 
			Row row = rows.next ();
			System.out.println ("Row No.: " + row.getRowNum () + " no. of cell = " + row.getPhysicalNumberOfCells());

			if(row.getRowNum () == 0){ // Header
				if(row.getPhysicalNumberOfCells() > 60){
					throw new Exception("ExcelImport Exception : Please Contact Admin for number of fields configuration");
				}
			}	
			if(isRowEmpty(row))
				break;
			Iterator<Cell> cells = row.cellIterator();
			int c = 0;
			while (cells.hasNext ())
			{
				Cell cell = cells.next ();
				header = getCellValue(cell);
				System.out.println(header);
				if(header!=null)
					headerList.add(header);
				headerMap.put(c++, header);

			}
			break;		

			//}
	}
		return headerList;	
	}

	public static List<String> getHeadersOfExcelForMetadata(String fileLocation) throws Exception{
		
		InputStream inp = new FileInputStream(fileLocation);
		Workbook wb = WorkbookFactory.create(inp);
		Sheet sheet = wb.getSheetAt(0);

		Iterator<Row> rows = sheet.rowIterator();
		List<String> headerList = new ArrayList<String>();
		String header = "";
		RichTextString richTextString = null;
		while (rows.hasNext ())
		{
			Row row = rows.next ();
			System.out.println ("Row No.: " + row.getRowNum () + " no. of cell = " + row.getPhysicalNumberOfCells());

			if(row.getRowNum () == 0){ // Header
				if(row.getPhysicalNumberOfCells() > 60){
					throw new Exception("ExcelImport Exception : Please Contact Admin for number of fields configuration");
				}
			}	
				if(isRowEmpty(row))
					break;
				Iterator<Cell> cells = row.cellIterator();
				int c = 0;
				while (cells.hasNext ())
				{
					Cell cell = cells.next ();
					header = getCellValue(cell);
					System.out.println(header);
					if(header!=null)
						headerList.add(header);
					headerMap.put(c++, header);
			
				}
				break;		
		
			//}
		}
		return headerList;	
	}
	
	public static Map<Integer, String> getOrderedMapForHeader(){
		
		return headerMap;
	}
	static DataFormatter df = new DataFormatter();
	public static String getCellValue(Cell cell){
		
		String value = "";
		if(cell!=null){
			//System.out.println ("Cell (Rid, Cid).: " + cell.getRowIndex() + "," +cell.getColumnIndex());
			//System.out.println("cell.getCellType()= " + cell.getCellType() );
        	switch(cell.getCellType()) {
		      case Cell.CELL_TYPE_STRING:
		    	  if(cell.getRichStringCellValue ()!=null){
		    		  value = cell.getRichStringCellValue().toString();
		    		 // System.out.println ("String value: " + value);
		    	  }
		    	  break;
		      case Cell.CELL_TYPE_NUMERIC:
		    	  /*if(cell.getColumnIndex() == 1)
		    	  {
		    		  System.out.println("Date found");
		    		  String.valueOf(cell.getColumnIndex());
		    		  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
		    		  Date d = cell.getDateCellValue();
		    		  String dateVal = sdf.format(d);
		    	      System.out.println ("date String value: " + dateVal);
		    	  }
		    	  else*/
		    		  value = String.valueOf(cell.getNumericCellValue());
		    	  //System.out.println ("Numeric value: " + value);
		    	  break;
		      case Cell.CELL_TYPE_BLANK:
		    	  value = "";
		    	  //System.out.println (" value: " );
		    	  //cell.setCellValue("");
		    	  break;
		      case Cell.CELL_TYPE_BOOLEAN:
		    	  value = String.valueOf(cell.getBooleanCellValue());
		    	  //System.out.println (" Boolean value: " + cell.getBooleanCellValue());
		    	  break;
		      case Cell.CELL_TYPE_FORMULA:
		    	  value = cell.getCellFormula();
		    	  //System.out.println (" Formula value: " + cell.getCellFormula());
		    	  break;
		      case Cell.CELL_TYPE_ERROR:
		    	  value = "ERROR";
		    	  //System.out.println (" Error value: " + cell.getErrorCellValue());
		    	  break;	  
		      default :
		  	{
		  		
		  		// types other than String and Numeric.
		  		System.out.println ("Type not supported.");
		  		
		  		break;
		  	} 	  
        	}
	
		}
		else{
			value = null;
		}
		return value;
	}
	
    public static String getCellValueForBond(Cell cell){
		
		String value = "";
		if(cell!=null){
			//System.out.println ("Cell (Rid, Cid).: " + cell.getRowIndex() + "," +cell.getColumnIndex());
			//System.out.println("cell.getCellType()= " + cell.getCellType() );
        	switch(cell.getCellType()) {
		      case Cell.CELL_TYPE_STRING:
		    	  if(cell.getRichStringCellValue ()!=null){
		    		  value = cell.getRichStringCellValue().toString();
		    		 // System.out.println ("String value: " + value);
		    	  }
		    	  break;
		      case Cell.CELL_TYPE_NUMERIC:
		    	  if(cell.getColumnIndex() == 3 || cell.getColumnIndex() == 6)
		    	  {
		    		  //System.out.println("Date found in " + cell.getColumnIndex());
		    		  Date d = cell.getDateCellValue();
		    		  value = Utility.getDateString(d, "MM/dd/yyyy");
		    	  }
		    	  else
		    		  value = String.valueOf(cell.getNumericCellValue());
		    	  System.out.println ("Numeric/Date value in " + cell.getColumnIndex() +"  :  " + value);
		    	  break;
		      case Cell.CELL_TYPE_BLANK:
		    	  value = "";
		    	  //System.out.println (" value: " );
		    	  //cell.setCellValue("");
		    	  break;
		      case Cell.CELL_TYPE_BOOLEAN:
		    	  value = String.valueOf(cell.getBooleanCellValue());
		    	  //System.out.println (" Boolean value: " + cell.getBooleanCellValue());
		    	  break;
		      case Cell.CELL_TYPE_FORMULA:
		    	  value = cell.getCellFormula();
		    	  //System.out.println (" Formula value: " + cell.getCellFormula());
		    	  break;
		      case Cell.CELL_TYPE_ERROR:
		    	  value = "ERROR";
		    	  //System.out.println (" Error value: " + cell.getErrorCellValue());
		    	  break;	  
		      default :
		  	{
		  		
		  		// types other than String and Numeric.
		  		System.out.println ("Type not supported.");
		  		
		  		break;
		  	} 	  
        	}
	
		}
		else{
			value = null;
		}
		return value;
	}

	public static boolean isRowEmpty(Row row)  {
	    for (int c = row.getFirstCellNum(); c <= row.getLastCellNum(); c++) {
	        Cell cell = row.getCell(c);
	        if (cell != null && cell.getCellType() != Cell.CELL_TYPE_BLANK && 
	        		cell.getStringCellValue().length()!=0)
	            return false;
	    }
	    return true;
	}
	
	public static void main(String[] args) throws Exception {
		
		System.out.println("Hi");
		getHeadersOfExcelForMetadata("c:/xls/ConcurWireExtractWithAdditionalTemplateFields v2.xls");
	}
}
