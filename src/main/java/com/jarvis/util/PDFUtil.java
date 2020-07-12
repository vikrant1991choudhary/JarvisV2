package com.jarvis.util;

import java.io.File;

import com.itextpdf.html2pdf.HtmlConverter;

public class PDFUtil {
	
	private final static String HTML_PATH = "D:\\jarvis_pdf\\";
	private final static String PDF_PATH = "D:\\jarvis_pdf\\";    

	public static void main(String[] args) {
		File htmlSource = new File(HTML_PATH + "test.html");
		File pdfDest = new File(PDF_PATH+"test.pdf");

		//ConverterProperties converterProperties = new ConverterProperties();
		//HtmlConverter.convertToPdf(new FileInputStream(htmlSource), new FileOutputStream(pdfDest), converterProperties);
		try {
			HtmlConverter.convertToPdf(htmlSource, pdfDest);
		} catch (Exception e) {			
			e.printStackTrace();
		}

	}

}
