package com.jarvis.dto;

import java.io.Serializable;

public class BondImportDTO implements Serializable{

	    private String year;
	    private String month;
		private String importDate;
		private String checkBoxHtml;
		
		public String getYear() {
			return year;
		}
		public void setYear(String year) {
			this.year = year;
		}

		public String getMonth() {
			return month;
		}

		public void setMonth(String month) {
			this.month = month;
		}

		public String getImportDate() {
			return importDate;
		}

		public void setImportDate(String importDate) {
			this.importDate = importDate;
		}

		public String getCheckBoxHtml() {
			return checkBoxHtml;
		}
		public void setCheckBoxHtml(String checkBoxHtml) {
			this.checkBoxHtml = checkBoxHtml;
		}
		
				
}
