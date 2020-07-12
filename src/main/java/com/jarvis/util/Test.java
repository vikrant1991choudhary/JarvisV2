/**
 * 
 */
package com.jarvis.util;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;


/**
 * @author suchakraborty
 *
 */
public class Test {

	public static void main(String[] args) {
		
		/*Map<String, Boolean> map1 = new HashMap<String, Boolean>();
		map1.put("a", true);
		map1.put("c", false);
		map1.put("e", true);
		map1.put("d", true);
		map1.put("b", false);
		
		display(map1);
		
		Map<String, Boolean> map2 = new LinkedHashMap<String, Boolean>();
		map2.put("a", true);
		map2.put("c", false);
		map2.put("e", true);
		map2.put("d", true);
		map2.put("b", false);
		
		display(map2);
		System.out.println(compare(map1, map2));*/
		
		/*try {
			PaginationDTO paginationDTO = new FileImportIntegrator().getAllFiles(0L, 5L, true, "", "");
			System.out.println("paginationDTO :  total result = " + paginationDTO.getTotalResultSize());
			List<FileImportDTO> list = paginationDTO.getPagedResults();
			System.out.println("paginationDTO : pagination sz = " + list.size());
			for(FileImportDTO file : list){
				System.out.println(file.getIdBulkTxnFile() + " : " + file.getCreatedOn());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}*/
		
	}
	
	
	public static void display(Map m){
		
		Set<String> set = m.keySet();
		for(String s : set)
			System.out.println(s);
		
	}
	
	public static boolean compare(Map<String, Boolean> m1, Map<String, Boolean> m2){
	
		boolean flag = true;
		Iterator<String> it = m2.keySet().iterator();
		for(String s : m1.keySet())
		{
			System.out.println("m1 = " + s);
			String v = it.next();
			System.out.println("m2 = " + v);
			if(!s.equals(v)){
				flag = false;
				break;
			}
		}
			return flag;
	}
}
