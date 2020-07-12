<!doctype html>
<%
String isUploadAllowed = session.getAttribute("isUploadAllowed")!=null ? session.getAttribute("isUploadAllowed").toString() : "";
 System.out.println("isUploadAllowed -- " + isUploadAllowed);
%>
<html lang="en"><head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="X-UA-Compatible" content="IE=edge"> 
		<title>Jarvis</title>
		<link href="favicon.ico" rel="shortcut icon" type="image/x-icon">
		<link rel="stylesheet" href="/css/bootstrap.min.css" type="text/css">
		<link rel="stylesheet" href="/css/font-awesome.min.css" type="text/css">
		<link href="https://fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,500,700,700i,900" rel="stylesheet">
		<link rel="stylesheet" href="/css/jquery-ui.css" type="text/css">
		<link rel="stylesheet" href="/css/jquery.dataTables.min.css" type="text/css">
		<link rel="stylesheet" href="/css/buttons.dataTables.min.css">	
		<link rel="stylesheet" href="/css/style.css" type="text/css">
				<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
				<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
				<!--[if lt IE 9]>
					<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
					<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
				<![endif]-->
				<style>
					html, body {
					    max-width: 100%;
					    overflow-x: hidden;
					}
					#example_filter input {
					    height: 30px;
						width: 300px;
						border-radius: 5px;
						border: 1px solid #2a511eba;
					}
				</style>
				
				 <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
				    <!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>   -->
				
<script src="/js/jquery-3.3.1.js" type="text/javascript"></script>
<script src="/js/jquery.dataTables.min.js" type="text/javascript"></script>
<script src="/js/dataTables.buttons.min.js" type="text/javascript"></script>
<script src="/js/buttons.flash.min.js" type="text/javascript"></script>
<script src="/js/jszip.min.js" type="text/javascript"></script>
<!-- <script src="/js/pdfmake.min.js" type="text/javascript"></script>
<script src="/js/vfs_fonts.js" type="text/javascript"></script> -->
<script src="/js/buttons.html5.min.js" type="text/javascript"></script>
<script src="/js/buttons.print.min.js" type="text/javascript"></script>	
				
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>				
				
		<script src="/js/bootstrap.min.js" type="text/javascript"></script>
		<script src="/js/popper.min.js" type="text/javascript"></script>
		<script src="/js/custom.js" type="text/javascript"></script>	
		
	<!-- live Choose dropdown -->
    <script src="/js/chosen.jquery.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/css/chosen.min.css" type="text/css">			
		
<!-- For charts -->	
<script src="/js/highcharts.js" type="text/javascript"></script>
		<script src="/js/exporting.js" type="text/javascript"></script>
		<script src="/js/jspdf.debug.js" type="text/javascript"></script> 
		<script src="/js/custom.js" type="text/javascript"></script>	
		<script src="/js/export-data.js" type="text/javascript"></script>
		<script src="/js/accessibility.js" type="text/javascript"></script>					
				
		</head>
		<body>
		
			<!--header-->
			
					<header>
          <div class="container-fluid">
              <!--left-->
              <div class="float-left">
                <div class="logo">
                    <img src="/images/logo_leftbraincm.jpg" alt="">
                    <a href="#" title="">
                        
                        <h1 style="color:#247041">Jarvis</h1>
                    </a>
                </div>
              </div>
              <!--end left-->

              <!--right-->
              <div class="float-right">
                  <ul class="headLinks">
                    <li>
                        <a href="home" title="">
                          <i class="fa fa-home" style="font-size:24px"></i> Home
                        </a>
                    </li>
                    <li>
                        <a href="javascript:void(0)" title="" id="helpBtn">
                          <i class="fa fa-question-circle" style="font-size:24px"></i> Help
                        </a>
                    </li>
                    <li>
                        <a href="/JarvisV2/logout" title="">
                          <i class="fa fa-sign-out" style="font-size:24px"></i> Logout
                        </a>
                    </li>
                  </ul>
              </div>
              <!--end right-->
          </div>
</header>
          
      <div class="helpContent">
        <p class="text-center">Please download User manual
          <a href="/images/User Manual.pdf" title="" target="_blank"><i class="fa fa-file-pdf-o" aria-hidden="true"></i> </a>
        </p>
      </div>
      
      <script type="text/javascript">
			$(document).ready( function() {
				getColumns();
				
				getSectors();
				getIndustries();
				 getAllTicker();
				 uploadFileDiv();
	
			});
	
</script>
      
      
      <script>
          $("#helpBtn").click(function(){
            $(".helpContent").slideToggle();
            //});
            });
            
            
            function uploadFileDiv(){
            	var isUploadAllowed ='<%=isUploadAllowed%>'; 
            	//alert("-->"+isUploadAllowed+"<--");
            	
            	if(isUploadAllowed.trim()=='Y'){
            		//alert("if");
            		
            		$('#fileuploadSpan').show();
            	}
            	if(isUploadAllowed=="" || isUploadAllowed=='N'){
            	//	alert("elseif");
            	$('#fileuploadSpan').hide();
            	
            	}
            }
            
            function getReset(){
            	//var ticker="";
            	getImportsData();
            }
            
            function getAllTicker(){
 				var metadataName="Debt_Report_Matrices";
            	jQuery.ajax({
			    	url: '<%=request.getContextPath()%>/JarvisV2/getAllTicker',
			           type: "GET",
			           async:false,
			           cache: false,
			           data: "metadataName="+metadataName,
			           dataType: "json",
			           success: function(data) {
			        	 //  alert("getAllTicker"+data);
			        	   var html ="<option value=''>--Select Ticker--</option> ";
			        	   for(var i=0; i<data.length; i++){
			        		   html = html + "<option value='" + data[i].element1 + "'>" + data[i].element1 + "</option>";
			        	   }
			        	   $("#filterTicker").html(html); 
			        	   $(".livesearch").chosen(); 
			           },
			           error: function(e){				           
		           	        alert('Error in getColumns: ' + e);		           	
		           	    }

		       });
            }
            
            function getHistoryByTicker(){
            	var metadataName="Debt_Report_Matrices";
            	//var ticker=escape($("#filterTicker>option:selected").val());
            	var ticker=$("#filterTicker").val();
            //	alert("filterTicker"+ticker);
            	if(ticker==null || ticker=='' || ticker===undefined)
            		{
            			alert("Please Enter Ticker");
            			return true;
            		}
            	var url = '<%=request.getContextPath()%>/JarvisV2/getHistoryByTicker?';
				url = url + "metadataName="+metadataName+"&ticker="+ticker;
				

				var oTable =  $('#example').DataTable();
        		oTable.destroy();
        		var oTable =  $('#example').dataTable( {
        			 oLanguage: {
       			      sLoadingRecords: '<img src="/images/loading.gif">'
       			    },
        			
        		        "ajax": {
        		            "url": url,
        		            "dataSrc": ""
        		        },
        		        "columns": [
							{ "data": "element1" },
							{ "data": "element2" },
							{ "data": "element3" },
							{ "data": "element4" },
							{ "data": "element5" },
							{ "data": "element6" },
							{ "data": "element7" },
							{ "data": "element8" },
							{ "data": "element9" },
							{ "data": "element10" },
							{ "data": "element11" },
							{ "data": "element12" },
							{ "data": "element13" },
							{ "data": "element14" },
							{ "data": "element15" },
							{ "data": "element16" },
							{ "data": "element17" },
							{ "data": "element18" },
							{ "data": "element19" },
							{ "data": "element20" },
							{ "data": "element21" },
							{ "data": "element22" },
							{ "data": "element23" },
							{ "data": "element24" },
							{ "data": "element25" },
							{ "data": "element26" },
							{ "data": "element27" },
							{ "data": "element28" },
							{ "data": "element29" },
							{ "data": "element30" },
							{ "data": "element31" },
							{ "data": "element32" },
							{ "data": "element33" },
							{ "data": "element34" },
							{ "data": "element35" },
							{ "data": "element36" },
							{ "data": "element37" },
							{ "data": "element38" },
							{ "data": "element39" },
							{ "data": "element40" },
							{ "data": "lastUpdatedAt" }
							
			        		  ],
			        		  "columnDefs":[{
			      	            "targets":40,//column index
			      	            "data":"element1",
			      	            "render":function(data,type,row){
			      	            	var res = data.substring(0, 10);
			      	            	
						   			 return res;
			      	        	 }
			      	        }],
        		  
        		  "scrollX": true,
        		  "dom": 'lBfrtip', //'Bfrtip',
				"lengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]], 
        		 // "buttons": ['copy', 'csv', 'excel', 'pdf', 'print'],
        		 "buttons": [ {
		                extend : 'pdfHtml5',
		                title : function() {
		                	const months = ["JAN", "FEB", "MAR","APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
		                	let current_datetime = new Date()
		                	let formatted_date = current_datetime.getDate() + "-" + months[current_datetime.getMonth()] + "-" + current_datetime.getFullYear()
		                	console.log(formatted_date)
		                    return "Jarvis Debt_Report for ( "+formatted_date+" )";		
		                	},
		                orientation : 'landscape',
		                pageSize : 'A0',
		                text : '<i class="fa fa-file-pdf-o"> PDF</i>',
		                titleAttr : 'PDF'
		            },{
		            	extend: 'excelHtml5',
		            	text : '<i class="fa fa-file-excel-o"> EXCEL</i>',
		            }/* ,{
		            	extend: 'print',
		            	orientation : 'landscape',
		            	pageSize : 'A0',
		            	text : '<i class="fa fa-print"> PRINT</i>',
		            }  */],
        		  "pagingType": "full",
        		  "language": {
        		      "paginate": {
        		        "previous": "<<",
        		        "next": ">>"
        		      }
        		    }
        		 } );
        		$('#filter').modal('hide');
           
            }
            

            
            function getImportHistorySheetCompare(){
					var values = new Array();
            	
            	$('[name=dateChkBox]:checked').each(function () {
            	//	alert('selected val: ' + $(this).val());
            		values.push($(this).val());
                    //alert('selected: ' + $(this).closest("td").siblings("td"));
                });

            	console.log("val---" + values.join(", "));
            	
            	if(values.length!=2){
            		alert("Please select 2 Dates");
            		return;
            	}
            	
            	var date1=values[0];
            	var date2=values[1];
            	console.log("date1-"+date1+" "+"date2--"+date2);
            	var metadataName="Debt_Report_Matrices";
            	var url = '<%=request.getContextPath()%>/JarvisV2/getImportHistorySheetCompare?';
				url = url + "metadataName="+metadataName+"&date1="+date1+"&date2="+date2;
				
				var oTable =  $('#example').DataTable();
        		oTable.destroy();
        		var oTable =  $('#example').dataTable( {
        			 oLanguage: {
       			      sLoadingRecords: '<img src="/images/loading.gif">'
       			    },
        			aaSorting: [[1, 'desc']],
        		        "ajax": {
        		            "url": url,
        		            "dataSrc": ""
        		        },
        		        "columns": [
							{ "data": "element1" },
							{ "data": "element2" },
							{ "data": "element3" },
							{ "data": "element4" },
							{ "data": "element5" },
							{ "data": "element6" },
							{ "data": "element7" },
							{ "data": "element8" },
							{ "data": "element9" },
							{ "data": "element10" },
							{ "data": "element11" },
							{ "data": "element12" },
							{ "data": "element13" },
							{ "data": "element14" },
							{ "data": "element15" },
							{ "data": "element16" },
							{ "data": "element17" },
							{ "data": "element18" },
							{ "data": "element19" },
							{ "data": "element20" },
							{ "data": "element21" },
							{ "data": "element22" },
							{ "data": "element23" },
							{ "data": "element24" },
							{ "data": "element25" },
							{ "data": "element26" },
							{ "data": "element27" },
							{ "data": "element28" },
							{ "data": "element29" },
							{ "data": "element30" },
							{ "data": "element31" },
							{ "data": "element32" },
							{ "data": "element33" },
							{ "data": "element34" },
							{ "data": "element35" },
							{ "data": "element36" },
							{ "data": "element37" },
							{ "data": "element38" },
							{ "data": "element39" },
							{ "data": "element40" },
							{ "data": "lastUpdatedAt" }
							
			        		  ],
			        		  "columnDefs":[{
			      	            "targets":40,//column index
			      	            "data":"element1",
			      	            "render":function(data,type,row){
			      	            	var res = data.substring(0, 10);
			      	            	
						   			 return res;
			      	        	 }
			      	        }],
        		  
        		  "scrollX": true,
        		  "dom": 'lBfrtip', //'Bfrtip',
				"lengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]], 
        		 // "buttons": ['copy', 'csv', 'excel', 'pdf', 'print'],
        		 "buttons": [ {
		                extend : 'pdfHtml5',
		                title : function() {
		                	const months = ["JAN", "FEB", "MAR","APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
		                	let current_datetime = new Date()
		                	let formatted_date = current_datetime.getDate() + "-" + months[current_datetime.getMonth()] + "-" + current_datetime.getFullYear()
		                	console.log(formatted_date)
		                    return "Jarvis Debt_Report for ( "+formatted_date+" )";	
		                	},
		                orientation : 'landscape',
		                pageSize : 'A0',
		                text : '<i class="fa fa-file-pdf-o"> PDF</i>',
		                titleAttr : 'PDF'
		            },{
		            	extend: 'excelHtml5',
		            	text : '<i class="fa fa-file-excel-o"> EXCEL</i>',
		            }/* ,{
		            	extend: 'print',
		            	orientation : 'landscape',
		            	pageSize : 'A0',
		            	text : '<i class="fa fa-print"> PRINT</i>',
		            } */ ],
        		  "pagingType": "full",
        		  "language": {
        		      "paginate": {
        		        "previous": "<<",
        		        "next": ">>"
        		      }
        		    }
        		 } );
        		
        		
            	$('#filter').modal('hide');
            }
            
            function getDataByWeek (date) {
                
            	var metadataName="Debt_Report_Matrices";
            	var url = '<%=request.getContextPath()%>/JarvisV2/getDataByWeek?';
				url = url + "metadataName="+metadataName+"&date="+date;
				
				var oTable =  $('#example').DataTable();
        		oTable.destroy();
        		var oTable =  $('#example').dataTable( {
        			 oLanguage: {
       			      sLoadingRecords: '<img src="/images/loading.gif">'
       			    },
        			aaSorting: [[1, 'desc']],
        		        "ajax": {
        		            "url": url,
        		            "dataSrc": ""
        		        },
        		        "columns": [
							{ "data": "element1" },
							{ "data": "element2" },
							{ "data": "element3" },
							{ "data": "element4" },
							{ "data": "element5" },
							{ "data": "element6" },
							{ "data": "element7" },
							{ "data": "element8" },
							{ "data": "element9" },
							{ "data": "element10" },
							{ "data": "element11" },
							{ "data": "element12" },
							{ "data": "element13" },
							{ "data": "element14" },
							{ "data": "element15" },
							{ "data": "element16" },
							{ "data": "element17" },
							{ "data": "element18" },
							{ "data": "element19" },
							{ "data": "element20" },
							{ "data": "element21" },
							{ "data": "element22" },
							{ "data": "element23" },
							{ "data": "element24" },
							{ "data": "element25" },
							{ "data": "element26" },
							{ "data": "element27" },
							{ "data": "element28" },
							{ "data": "element29" },
							{ "data": "element30" },
							{ "data": "element31" },
							{ "data": "element32" },
							{ "data": "element33" },
							{ "data": "element34" },
							{ "data": "element35" },
							{ "data": "element36" },
							{ "data": "element37" },
							{ "data": "element38" },
							{ "data": "element39" },
							{ "data": "element40" },
							{ "data": "lastUpdatedAt" }
							
			        		  ],
			        		  "columnDefs":[{
			      	            "targets":40,//column index
			      	            "data":"element1",
			      	            "render":function(data,type,row){
			      	            	var res = data.substring(0, 10);
			      	            	
						   			 return res;
			      	        	 }
			      	        }],
        		  
        		  "scrollX": true,
        		//  "dom": 'Bfrtip',
        		  "dom": 'lBfrtip', //'Bfrtip',
  				"lengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]],
        		 // "buttons": ['copy', 'csv', 'excel', 'pdf', 'print'],
        		 "buttons": [ {
		                extend : 'pdfHtml5',
		                title : function() {
		                	const months = ["JAN", "FEB", "MAR","APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
		                	let current_datetime = new Date()
		                	let formatted_date = current_datetime.getDate() + "-" + months[current_datetime.getMonth()] + "-" + current_datetime.getFullYear()
		                	console.log(formatted_date)
		                    return "Jarvis Debt_Report for ( "+formatted_date+" )";	
		                	},
		                orientation : 'landscape',
		                pageSize : 'A0',
		                text : '<i class="fa fa-file-pdf-o"> PDF</i>',
		                titleAttr : 'PDF'
		            },{
		            	extend: 'excelHtml5',
		            	text : '<i class="fa fa-file-excel-o"> EXCEL</i>',
		            }/* ,{
		            	extend: 'print',
		            	orientation : 'landscape',
		            	pageSize : 'A0',
		            	text : '<i class="fa fa-print"> PRINT</i>',
		            }  */],
        		  "pagingType": "full",
        		  "language": {
        		      "paginate": {
        		        "previous": "<<",
        		        "next": ">>"
        		      }
        		    }
        		 } );
        		
        		
            	$('#filter').modal('hide');
              
            }
            
            function getSectors(){
            	
            	jQuery.ajax({
			    	url: '<%=request.getContextPath()%>/JarvisV2/getAllSectors',
			           type: "GET",
			           async:false,
			           cache: false,
			           data: "",
			           dataType: "json",
			           success: function(data) {
			        	   
			        	   var html = "";
			        	   for(var i=0; i<data.length; i++){
			        		   html = html + "<option value='" + data[i].sector + "'>" + data[i].sector + "</option>";
			        	   }
			        	   $("#sectorList").html(html);     	   
			           },
			           error: function(e){				           
		           	        alert('Error in getColumns: ' + e);		           	
		           	    }

		       });
            }
            
			function getIndustries(){
				
				jQuery.ajax({
			    	url: '<%=request.getContextPath()%>/JarvisV2/getAllIndustry',
			           type: "GET",
			           async:false,
			           cache: false,
			           data: "",
			           dataType: "json",
			           success: function(data) {
			        	   
			        	   var html = "";
			        	   for(var i=0; i<data.length; i++){
			        		   html = html + "<option value='" + data[i].industry + "'>" + data[i].industry + "</option>";
			        	   }
			        	   $("#industryList").html(html);     	   
			           },
			           error: function(e){				           
		           	        alert('Error in getColumns: ' + e);		           	
		           	    }

		       });
			}
            
            function getColumns(){
            	
            	jQuery.ajax({
			    	url: '<%=request.getContextPath()%>/JarvisV2/getColumns',
			           type: "GET",
			           async:false,
			           cache: false,
			           data: "metaDataName=Debt_Report_Matrices",
			           dataType: "json",
			           success: function(data) {
			        	   //alert(data);
			        	   var headerHTML = "";
			        	   for(var i=0;i<data.length;i++){
			        		   headerHTML = headerHTML + "<th>" + data[i].elementDisplayName + "</th>";
			        	   }
			        	   headerHTML = headerHTML + "<th>Date</th>";
			        	   $("#headerRow").html(headerHTML);
			        	   
			        	   var dataSrc = '${searchedRows}';
				           console.log("dataSrc:"+'${searchedRows}');
			        	   
			        	   if(dataSrc==null || dataSrc=='' || dataSrc===undefined){
			        		   getImportsData();  
			        	   }else{
			        	   		getImportsDataFromCalculate(dataSrc);
			        	   }
			        	   
			        	        	   
			           },
			           error: function(e){				           
		           	        alert('Error in getColumns: ' + e);		           	
		           	    }

		       });
            }
            
			function findImportDatesByMonth(){
        		
        		var url = '<%=request.getContextPath()%>/JarvisV2/findImportDatesByMonth?metaDataName=Debt_Report_Matrices';
        		
        		var oTable =  $('#exampleMonths').DataTable();
        		oTable.destroy();
        		var oTable =  $('#exampleMonths').dataTable( {
        			aaSorting: [[1, 'desc']],
        		        "ajax": {
        		            "url": url,
        		            "dataSrc": ""
        		        },
        		        "columns": [
							{ "data": "checkBoxHtml" },
							{ "data": "importDate" },
							{ "data": "month" }
							
        		  ],
        		  "columnDefs":[{
        	            "targets":1,//column index
        	            "data":"importDate",
        	            "render":function(data,type,row){
        	            	var len = data.length;
        	            	var date=row['importDate'];
        	            	//alert("date--"+date);
        	            	
        	          
       	                 return '<a href="#"  onclick="getDataByWeek(\''+date+'\')">'+date+'</a>';
        	            
        	         }
        	        }],
        		  "scrollX": true,
        		  "dom": 'frtip',
        		 // "buttons": ['copy', 'csv', 'excel', 'pdf', 'print'],
        		  "lengthMenu": [[25,50, 100, 150, -1], [25,50, 100, 150, "All"]],
        		  "pagingType": "full",
        		  "language": {
        		      "paginate": {
        		        "previous": "<<",
        		        "next": ">>"
        		      }
        		    }
        		 } );
        		$('#filter').modal('show');
            }
            
            function getImportsData(){
        		
        		var url = '<%=request.getContextPath()%>/JarvisV2/getImportsData?metaDataName=Debt_Report_Matrices';
        		
        		var oTable =  $('#example').DataTable();
        		oTable.destroy();
        		var oTable =  $('#example').dataTable( {
        			 oLanguage: {
       			      sLoadingRecords: '<img src="/images/loading.gif">'
       			    },
        			aaSorting: [[1, 'desc']],
        		        "ajax": {
        		            "url": url,
        		            "dataSrc": ""
        		        },
        		        "columns": [
							{ "data": "element1" },
							{ "data": "element2" },
							{ "data": "element3" },
							{ "data": "element4" },
							{ "data": "element5" },
							{ "data": "element6" },
							{ "data": "element7" },
							{ "data": "element8" },
							{ "data": "element9" },
							{ "data": "element10" },
							{ "data": "element11" },
							{ "data": "element12" },
							{ "data": "element13" },
							{ "data": "element14" },
							{ "data": "element15" },
							{ "data": "element16" },
							{ "data": "element17" },
							{ "data": "element18" },
							{ "data": "element19" },
							{ "data": "element20" },
							{ "data": "element21" },
							{ "data": "element22" },
							{ "data": "element23" },
							{ "data": "element24" },
							{ "data": "element25" },
							{ "data": "element26" },
							{ "data": "element27" },
							{ "data": "element28" },
							{ "data": "element29" },
							{ "data": "element30" },
							{ "data": "element31" },
							{ "data": "element32" },
							{ "data": "element33" },
							{ "data": "element34" },
							{ "data": "element35" },
							{ "data": "element36" },
							{ "data": "element37" },
							{ "data": "element38" },
							{ "data": "element39" },
							{ "data": "element40" },
							{ "data": "lastUpdatedAt" }
							
			        		  ],
			        		  "columnDefs":[{
			      	            "targets":40,//column index
			      	            "data":"element1",
			      	            "render":function(data,type,row){
			      	            	var res = data.substring(0, 10);
			      	            	
						   			 return res;
			      	        	 }
			      	        }],
        		  
        		  "scrollX": true,
        		  "dom": 'lBfrtip', //'Bfrtip',
				"lengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]], 
        		 // "buttons": ['copy', 'csv', 'excel', 'pdf', 'print'],
        		 "buttons": [ {
		                extend : 'pdfHtml5',
		                title : function() {
		                	const months = ["JAN", "FEB", "MAR","APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
		                	let current_datetime = new Date()
		                	let formatted_date = current_datetime.getDate() + "-" + months[current_datetime.getMonth()] + "-" + current_datetime.getFullYear()
		                	console.log(formatted_date)
		                    return "Jarvis Debt_Report for ( "+formatted_date+" )";	
		                	},
		                orientation : 'landscape',
		                pageSize : 'A0',
		                text : '<i class="fa fa-file-pdf-o"> PDF</i>',
		                titleAttr : 'PDF'
		            },{
		            	extend: 'excelHtml5',
		            	text : '<i class="fa fa-file-excel-o"> EXCEL</i>',
		            }/* ,{
		            	extend: 'print',
		            	orientation : 'landscape',
		            	pageSize : 'A0',
		            	text : '<i class="fa fa-print"> PRINT</i>',
		            }  */],
        		  "pagingType": "full",
        		  "language": {
        		      "paginate": {
        		        "previous": "<<",
        		        "next": ">>"
        		      }
        		    }
        		 } );
            }
            
            
	function getImportsDataFromCalculate(dataSrcJSON){
        		
        		//var url = '<%=request.getContextPath()%>/JarvisV2/getImportsData?metaDataName=Debt_Report_Matrices';
        		//var dataSrcJSON = '${searchedRows}';
        		//var dataSrcJSON = eval('('+'${searchedRows}'+')');
        		console.log("getImportsDataFromCalculate dataSrcJSON --" +dataSrcJSON);
        		var dataJsn = eval(dataSrcJSON);
        	    var oTable =  $('#example').DataTable();
        		oTable.destroy();
        		var oTable =  $('#example').dataTable( {
        			 oLanguage: {
       			      sLoadingRecords: '<img src="/images/loading.gif">'
       			    },
        			aaSorting: [[1, 'desc']],
        		        data : dataJsn,
        		        columns: [
							{ data: "element1" },
							{ data: "element2" },
							{ data: "element3" },
							{ data: "element4" },
							{ data: "element5" },
							{ data: "element6" },
							{ data: "element7" },
							{ data: "element8" },
							{ data: "element9" },
							{ data: "element10" },
							{ data: "element11" },
							{ data: "element12" },
							{ data: "element13" },
							{ data: "element14" },
							{ data: "element15" },
							{ data: "element16" },
							{ data: "element17" },
							{ data: "element18" },
							{ data: "element19" },
							{ data: "element20" },
							{ data: "element21" },
							{ data: "element22" },
							{ data: "element23" },
							{ data: "element24" },
							{ data: "element25" },
							{ data: "element26" },
							{ data: "element27" },
							{ data: "element28" },
							{ data: "element29" },
							{ data: "element30" },
							{ data: "element31" },
							{ data: "element32" },
							{ data: "element33" },
							{ data: "element34" },
							{ data: "element35" },
							{ data: "element36" },
							{ data: "element37" },
							{ data: "element38" },
							{ data: "element39" },
							{ data: "element40" },
							{ "data": "lastUpdatedAt" }
							
			        		  ],
			        		  "columnDefs":[{
			      	            "targets":40,//column index
			      	            "data":"element1",
			      	            "render":function(data,type,row){
			      	            	var res = data.substring(0, 10);
			      	            	
						   			 return res;
			      	        	 }
			      	        }],
        		 
        		  "scrollX": true,
        		  "dom": 'lBfrtip', //'Bfrtip',
				"lengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]], 
        		 "buttons": [ {
		                extend : 'pdfHtml5',
		                title : function() {
		                	const months = ["JAN", "FEB", "MAR","APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
		                	let current_datetime = new Date()
		                	let formatted_date = current_datetime.getDate() + "-" + months[current_datetime.getMonth()] + "-" + current_datetime.getFullYear()
		                	console.log(formatted_date)
		                    return "Jarvis Debt_Report for ( "+formatted_date+" )";	
		                	},
		                orientation : 'landscape',
		                pageSize : 'A0',
		                text : '<i class="fa fa-file-pdf-o"> PDF</i>',
		                titleAttr : 'PDF'
		            },{
		            	extend: 'excelHtml5',
		            	text : '<i class="fa fa-file-excel-o"> EXCEL</i>',
		            }/* ,{
		            	extend: 'print',
		            	orientation : 'landscape',
		            	pageSize : 'A0',
		            	text : '<i class="fa fa-print"> PRINT</i>',
		            } */ ],
        		  "pagingType": "full",
        		  "language": {
        		      "paginate": {
        		        "previous": "<<",
        		        "next": ">>"
        		      }
        		    }
        		 } );
            }
            
    </script>
			
			<!--end header-->

			<!--navigation-->
			<nav class="navbar navbar-expand-lg navbar-light bg-light">
				<div class="container-fluid">
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarNavDropdown">
					<ul class="navbar-nav">
						<li class="nav-item active">
							<!-- <a class="nav-link" href="/JarvisV2/imports?isUploadAllowed=<%=isUploadAllowed%>">Debt Reports<span class="sr-only">(current)</span></a> -->
							<a class="nav-link" href="#" title="" onclick="$('#frmImport').submit();">Debt Reports<span class="sr-only">(current)</span></a> 
						</li>
						<li class="nav-item">
							<!-- <a class="nav-link" href="/JarvisV2/tickersimport?isUploadAllowed=<%=isUploadAllowed%>">Tickers</a> -->
							<a class="nav-link" href="#" title="" onclick="$('#frmTicker').submit();">Tickers</a>
						</li>
						<li class="nav-item">
							<!-- <a class="nav-link" href="/JarvisV2/bondimport?isUploadAllowed=<%=isUploadAllowed%>">Bonds</a> -->
							<a class="nav-link" href="#" title="" onclick="$('#frmBond').submit();">Bonds</a>
						</li>
						<li class="nav-item">
							<!-- <a class="nav-link" href="/JarvisV2/everythingimport?isUploadAllowed=<%=isUploadAllowed%>">Everything List</a> -->
							<a class="nav-link" href="#" title="" onclick="$('#frmEveryThing').submit();">Everything List</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="#">Bonds with Stock</a>
						</li>
						
                     	 
					</ul>
						<form method="post" action="/JarvisV2/imports" id="frmImport">
                      	<input type="hidden" name="isUploadAllowed" id="isUploadAllowed" value="<%=isUploadAllowed%>" />
                      </form>
                      <form method="post" action="/JarvisV2/tickersimport" id="frmTicker">
                      	<input type="hidden" name="isUploadAllowed" id="isUploadAllowed" value="<%=isUploadAllowed%>" />
                      </form>
                      <form method="post" action="/JarvisV2/bondimport" id="frmBond">
                      	<input type="hidden" name="isUploadAllowed" id="isUploadAllowed" value="<%=isUploadAllowed%>" />
                      </form>
                      <form method="post" action="/JarvisV2/everythingimport" id="frmEveryThing">
                      	<input type="hidden" name="isUploadAllowed" id="isUploadAllowed" value="<%=isUploadAllowed%>" />
                      </form>
				</div>
			</div>
			</nav>
			<!--end navigation-->

			

			<!--main-->
			<main class="h100">
				<div class="container-fluid position-relative">
				<div style="text-align:right;">
				
				<div style="color:${color}">${successMsg}</div>
				  <form method="post" action="/JarvisV2/uploadFile" id="importUploadForm1" enctype="multipart/form-data">
					<div class="" style="">	
					 
					  <input type="hidden" name="metaDataName" value="Debt_Report_Matrices" />
					 	 <select class="livesearch" id="filterTicker" style="width:150px;"></select>&nbsp;<input type="button" name="" class="modalBtnWeekly" value="go" onclick="getHistoryByTicker()" />&nbsp;&nbsp;

						<span id="fileuploadSpan">
							<input type="file" name="myfile" style="width: 200px;">
							<button class="modalBtn"
								onclick="$('#importUploadForm1').submit();">
								<i class="fa fa-upload" aria-hidden="true"></i> Upload
							</button>
						</span>
						&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="modalBtn" onclick="findImportDatesByMonth();">History</button>&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="modalBtn" data-toggle="modal" data-target="#calculateModal">Calculate</button>&nbsp;&nbsp;&nbsp;&nbsp;
					 		<button type="button" class="modalBtn" onclick="getReset()" >Reset</button>
					 		
					 		
					 		<!-- <div id="main1Button" style="display:none">
					 			 <input type="hidden" name="metaDataName" value="Debt_Report_Matrices" />
					 			 Filter :<select class="livesearch" id="filterTicker" style="width:150px;"></select>&nbsp;<input type="button" name="" class="modalBtnWeekly" value="go" onclick="getHistoryByTicker()" />&nbsp;&nbsp;
					       
					 		 <input type="file" name="myfile" style="width:200px;">
							<button class="modalBtn" onclick="$('#importUploadForm1').submit();">
							<i class="fa fa-upload" aria-hidden="true"></i> Upload</button>
							
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="modalBtn" onclick="findImportDatesByMonth();">History</button>&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="modalBtn" data-toggle="modal" data-target="#calculateModal">Calculate</button>&nbsp;&nbsp;&nbsp;&nbsp;
					 		<button type="button" class="modalBtn" onclick="getReset()" >Reset</button>
					 		</div> -->
					 </div>
				  </form>
			    </div>
				
					<!-- <a href="demand" title="" class="float-right viewGraph hvr-push">VIEW ALL GRAPHS</a> -->
					<!--graph section-->
					
					<br><br>
					<table id="example" class="display" style="width:100%">
        <thead>
            <tr id="headerRow">
                
            </tr>
        </thead>
        <tbody>
           
        </tbody>
        <!-- <tfoot>
            <tr>
                <th>Name</th>
                <th>Position</th>
                <th>Office</th>
                <th>Age</th>
                <th>Start date</th>
                <th>Salary</th>
            </tr>
        </tfoot> -->
    </table>






				</div>	
			</main>
			<!--end main-->

			
		 
	<!-- The Modal -->
	<div class="modal" id="filter">
			<div class="modal-dialog">
				<div class="modal-content" style="width:100%">
				
					<!-- Modal Header -->
					<div class="filter-header">
						<img src="/images/filter-violet.PNG" alt="">
						<h2>Import History - Debt Report Matrices</h2>
						<a href="#" title="" class="close" data-dismiss="modal"><i class="fa fa-window-close" aria-hidden="true"></i></a>
					</div>
					
					<!-- Modal body -->
					<div class="filter-body">
					<br>
						<form action="" method="post">
							<div class="row">
								<div class="col-md-12 innerFilBlock">
												<div class="row">
													<div class="col-md-8">
														<div class="filterBlock">
														<table id="exampleMonths" class="display" style="width:100%">
															<thead>
																<tr>
																	<th>Select</th>
																	<th>Import Dates</th>
																	<th>Months</th>
																</tr>
															</thead>
															<tbody>
															   
															</tbody>
														 </table>
													</div>
													</div>
												</div>
												</div>
											</div>
						</form>
					</div>
					
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="modalBtn modalBtnCancel" data-dismiss="modal">Cancel</button>
						<!-- <input type="submit" class="modalBtn" id="vali"  name="submit" value="Compare"/> -->
					</div>
				</form>
				</div>
			</div>
		
		</div>
		<!-- end Modal -->


		  <!-- The Modal -->
	<div class="modal" id="calculateModal">
			<div class="modal-dialog">
			<form action="/JarvisV2/searchDebtReport" method="post">
				<div class="modal-content" style="width:100%;">
					<!-- Modal Header -->
					<div class="filter-header">
						<img src="/images/filter-violet.PNG" alt="">
						<h2>Analysis - Debt Reports</h2>
						<a href="#" title="" class="close" data-dismiss="modal"><i class="fa fa-window-close" aria-hidden="true"></i></a>
					</div>
					<!-- Modal body -->
					<div class="filter-body" style="padding: 10px;">
					<br>
						
							<div class="row" style="margin-bottom: 20px;">
                        	 <div class="col-sm-4">
		                    	<div class="filterBlock">
		                      		<div class="selectBox">
				                        <label>Industry</label>
				                        <select name="industryList" id="industryList">
				                    	 <!-- <option value="Software">Software</option>
						                 <option value="Oil & Gas Integrated">Oil & Gas Integrated</option> -->
				                      	<!--  <option value="Currency">Currency</option> -->
				                    </select>
		                          </div>
                         		 </div>
                          		</div>
		                          <div class="col-sm-4">
		                            <div class="filterBlock">
		                      		<div class="selectBox">
				                        <label>Sector</label>
		                          <select name="sectorList" id="sectorList">
		                      <!-- <option value="Technology">Technology</option>
		                       <option value="Energy">Energy</option> -->
		                     <!-- <option value="Currency">Currency</option> -->
		                    </select>
		                          </div>
		                          </div>
		                          </div>
              		</div>
              <div class="row">
                <div class="col-sm-4">
                	Debit/Equity:<input type="text" name="txtDebtEq" class="form-control" ><br>
                </div>
                <div class="col-sm-4">
                	 Debit/EBITTA (TTM):<input type="text" name="txtDebtEBTTM" class="form-control"><br>
                </div>
                <div class="col-sm-4">
                	Interest Coverage Ratio:<input type="text" name="txtIntCovRatio" class="form-control"><br>
                </div>
             </div>	
             <div class="row">
                <div class="col-sm-4">
                	EBITDA (TTM):<input type="text" name="txtEBT" class="form-control"><br>
                </div>
                <div class="col-sm-4">
                	Debit/EBITTA (forward):<input type="text" name="txtDebtEBTF" class="form-control"><br>
                </div>
                <div class="col-sm-4">
                	Interest Expense:<input type="text" name="txtIntExp" class="form-control"><br>
                </div>
             </div>	
             <div class="row">
                <div class="col-sm-4">
                	EBITDA (forward):<input type="text" name="txtEBTF" class="form-control"><br>
                </div>
                <div class="col-sm-4">
                	Market Cap:<input type="text" name="txtMktCap" class="form-control"><br>
                </div>
                <div class="col-sm-4">
                	Cash/Cash Eq:<input type="text" name="txtCashEq" class="form-control"><br>
                </div>
             </div>	
             <div class="row">
                <div class="col-sm-4">
                	Total Debt:<input type="text" name="txtTDebt" class="form-control"><br>
                </div>
                <div class="col-sm-4">
                	Enterprise Value:<input type="text" name="txtEntVal" class="form-control"><br>
                </div>
                <div class="col-sm-4">
                	Debit/EV Ratio:<input type="text" name="txtDebtEVRatio" class="form-control"><br>
                </div>
             </div>	
             <div class="row">
                <div class="col-sm-4">
                	Free Cash Flow:<input type="text" name="txtFCF" class="form-control"><br>
                </div>
                <div class="col-sm-4">
                	Asset Coverage:<input type="text" name="txtAstCov" class="form-control"><br>
                </div>
                <div class="col-sm-4">
                	Divided Yield:<input type="text" name="txtDivYield" class="form-control"><br>
                </div>
             </div>	
             <div class="row">
                <div class="col-sm-4">
                	RSI (Stock):<input type="text" name="txtRSI" class="form-control"><br>
                </div>
                <div class="col-sm-4">
                	200 Day Moving Average:<input type="text" name="txtMovAvg" class="form-control"><br>
                </div>
                <div class="col-sm-4">
                	Payout Ratio:<input type="text" name="txtPayRatio" class="form-control"><br>
                </div>
             </div>	
             <div class="row">
                <div class="col-sm-4">
                	OAS Spread:<input type="text" name="txtOAS" class="form-control"><br>
                </div>
                <div class="col-sm-4">
                	YTM:<input type="text" name="txtYTM" class="form-control"><br>
                </div>
                <div class="col-sm-4">
                	 Spread/Turn Leverage:<input type="text" name="txtSpread" class="form-control"><br>
                	 <input type="hidden" name="metaData" value="Debt_Report_Matrices" />
                </div>
             </div>		
              		
              		
              		
              		
             
						
					</div>
					
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="modalBtn modalBtnCancel" data-dismiss="modal">Cancel</button>
						<input type="submit" class="modalBtn" id="vali" name="submit" value="Compare"/>
					</div>
				</div>
				</form>
			</div>
		
		</div>
		<!-- end Modal -->
		
		</body>
		</html>
	