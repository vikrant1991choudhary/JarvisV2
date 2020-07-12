/**
 * 
 */
package com.jarvis.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;


/**
 * @author suchakraborty
 *
 */
public class XMLParserUtil{
	
	private static String repeatorNodeName = null;
	
	public static List<String> getChildTagsOfXMLForMetadata(Document dom) throws Exception{
		
		List<String> childTagList = new ArrayList<String>();  
		List<String> _interList = new ArrayList<String>(); 
		String _interRepeator = "";
		String childNodeName = null;
		boolean isFirst = true;
		boolean isFirstChild = true;
		
			
			Element docEle = dom.getDocumentElement();
			
			NodeList domNodeList = docEle.getChildNodes();
			//System.out.println(domNodeList.getLength());
			
			if(domNodeList != null && domNodeList.getLength() > 0) {
				for(int i = 0 ; i < domNodeList.getLength();i++) {
					
					Node repeatorNode = domNodeList.item(i);
					
					if(repeatorNode.getNodeType()!= Node.TEXT_NODE){
						
						repeatorNodeName = repeatorNode.getNodeName();
						System.out.println("@@@@@@@@@@@@@@@@ = " + repeatorNodeName + " **** _interRepeator = " + _interRepeator);
						
						/*if(isFirst){
							_interRepeator = repeatorNodeName;
							isFirst = false;
						}
						else{
							if(!_interRepeator.equals(repeatorNodeName))
								throw new EFTExtensionsException("XMLImport Exception : Repeator tag is different");
							else
								_interRepeator = repeatorNodeName;
						}*/
							
						//System.out.println("Repeator nodeName = " + repeatorNodeName + " type = " + repeatorNode.getNodeType());
						NodeList cnl = repeatorNode.getChildNodes();
						if(cnl != null && cnl.getLength() > 0) {
							
							System.out.println("no of child under rep " + i + " = " + cnl.getLength());
							/*if(cnl.getLength() > 60)
								throw new EFTExtensionsException("XMLImport Exception : Please Contact Admin for number of fields configuration");*/
							
							childTagList = new ArrayList<String>();
							
							for(int j = 0 ; j < cnl.getLength();j++) {
									
								Node childNode = cnl.item(j);
								if(childNode.getNodeType()!=3){
									childNodeName = childNode.getNodeName();
									//System.out.println("subnodeName = " + childNodeName + " under = " + childNode.getParentNode().getNodeName());
									childTagList.add(childNodeName);
								}
							}
							
							/*if(isFirstChild){
								_interList = childTagList;
								isFirstChild = false;
							}
							else{
								if(!_interList.containsAll(childTagList))
									throw new EFTExtensionsException("XMLImport Exception : Children tags in repeater are different");
								else{
									for (int j = 0; j < childTagList.size(); j++) {
										if(!_interList.get(j).equals(childTagList.get(j))){
											throw new EFTExtensionsException("XMLImport Exception : Children tags in repeater are not in same order");
										}
									}
									_interList = childTagList;
								}
									
							}*/
							System.out.println("No of tags under rep tag = " + childTagList.size());
							if(childTagList.size() > 60)
								throw new Exception("XMLImport Exception : Please Contact Admin for number of fields configuration");
							break;
						}
					}
				}	
					
			}
		
		
		return childTagList;
	}
	
	public static List<List<String>> getChildTagValuesOfXMLForBulkTxn(Document dom){
		
		List<String> childTagValueList = new ArrayList<String>();  
		String childNodeName = null;
		String childNodeValue = null;
		List<List<String>> listOfList = new ArrayList<List<String>>();
		
		try {
			
			Element docEle = dom.getDocumentElement();
			
			NodeList domNodeList = docEle.getChildNodes();
			System.out.println(domNodeList.getLength());
			
			if(domNodeList != null && domNodeList.getLength() > 0) {
				for(int i = 0 ; i < domNodeList.getLength();i++) {
					
					Node repeatorNode = domNodeList.item(i);
					
					/*if(i==0)
						System.out.println("root Node = " + repeatorNode.getParentNode().getNodeName());*/
					
					if(repeatorNode.getNodeType()!=3){
					
						repeatorNodeName = repeatorNode.getNodeName();
						//System.out.println("Repeator nodeName = " + repeatorNodeName + " type = " + repeatorNode.getNodeType());
						NodeList cnl = repeatorNode.getChildNodes();
						if(cnl != null && cnl.getLength() > 0) {
							for(int j = 0 ; j < cnl.getLength();j++) {
									
								Node childNode = cnl.item(j);
								if(childNode.getNodeType()!=3){
									childNodeName = childNode.getNodeName();
									childNodeValue = childNode.getNodeValue();
									//System.out.println("j = " + j + " subnodeName = " + childNodeName + " under " + childNode.getParentNode().getNodeName());
									//System.out.println("subnodeValue = " + childNodeValue);
									childTagValueList.add(childNodeValue);
								}
							}
							System.out.println(repeatorNode.getNodeName() + " finished .................");
							listOfList.add(childTagValueList);
							childTagValueList = new ArrayList<String>();
						}
					}
				}	
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return listOfList;
	}
	
	
	public static String getRepeatorNodeName(){
		return repeatorNodeName;
	}
	
	
}
