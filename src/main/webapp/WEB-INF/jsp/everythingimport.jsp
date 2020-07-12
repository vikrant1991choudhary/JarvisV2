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
		
		
<!-- <script src="/js/jquery.dataTables.min.js"></script> -->
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
      <?php include 'footer.php';?>
      
      <script type="text/javascript">
			$(document).ready( function() {
				getColumns();
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
            	
            	if(isUploadAllowed.trim()=='Y'){            		
            		
            		$('#fileuploadSpan').show();
            	}
            	if(isUploadAllowed=="" || isUploadAllowed=='N'){
            	$('#fileuploadSpan').hide();
            	
            	}
            }
            
            function getReset(){
            	//var ticker="";
            	getImportsData();
            }
            
 			function getAllTicker(){
 				var metadataName="Everything_List_New";
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
            	var metadataName="Everything_List_New";
            	var ticker=$("#filterTicker").val();
            	//alert("filterTicker"+ticker);
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
							{ "data": "lastUpdatedAt" }
							
			        		  ],
			        		  "columnDefs":[{
			      	            "targets":28,//column index
			      	            "data":"element1",
			      	            "render":function(data,type,row){
			      	            	var res = data.substring(0, 10);
			      	            	
						   			 return res;
			      	        	 }
			      	        }],
			      	      "order": [[ 28, "desc" ]],
        		  "scrollX": true,
        		  "dom": 'Bfrtip',
        		 // "buttons": ['copy', 'csv', 'excel', 'pdf', 'print'],
        		 "buttons": [ {
		                extend : 'pdfHtml5',
		                title : function() {
		                	const months = ["JAN", "FEB", "MAR","APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
		                	let current_datetime = new Date()
		                	let formatted_date = current_datetime.getDate() + "-" + months[current_datetime.getMonth()] + "-" + current_datetime.getFullYear()
		                	console.log(formatted_date)
		                    return "Jarvis Everything : date ( "+formatted_date+" )";		                },
		                orientation : 'landscape',
		                pageSize : 'A4',
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
        		
        		$('#everyThing').show();
            	$('#comparedisplay').hide();
            	$('#stockRankingDiv').hide();
            	$('#filter').modal('hide');
           
            }
            
            function getDataByWeek (date) {
           
            	var metadataName="Everything_List_New";
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
							{ "data": "lastUpdatedAt" }
							
			        		  ],
			        		  "columnDefs":[{
			      	            "targets":28,//column index
			      	            "data":"element1",
			      	            "render":function(data,type,row){
			      	            	var res = data.substring(0, 10);
			      	            	
						   			 return res;
			      	        	 }
			      	        }],
			      	      "order": [[ 28, "desc" ]],
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
		                    return "Jarvis Everything : date ( "+formatted_date+" )";	
		                	},
		                orientation : 'landscape',
		                pageSize : 'A4',
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
        		
        		$('#everyThing').show();
            	$('#comparedisplay').hide();
            	$('#stockRankingDiv').hide();
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
            	var metadataName="Everything_List_New";
            	

				var url = '<%=request.getContextPath()%>/JarvisV2/getImportHistorySheetCompare?metadataName='+metadataName+'&date1='+date1+'&date2='+date2;
        		
        		var oTable =  $('#exampleRise').DataTable();
        		oTable.destroy();
        		var oTable =  $('#exampleRise').dataTable( {
        			scrollY:        '50vh',
        	        scrollCollapse: true,
        	        paging:         false,
        			aaSorting: [[1, 'desc']],
        		        "ajax": {
        		            "url": url,
        		            "dataSrc": function(data) {
        		            	console.log(data.bestFiveStocks);
        		            	var data = data.bestFiveStocks;
        		            	return data;
        		            }
        		        },
        		        "columns": [
							{ "data": "bestMovedStock" },
							{ "data": "bestMovedBy" },
							{ "data": "percentageChangeRise" },
							{ "data": "bestMoveCurrValue" },
							{ "data": "bestMovePrevValue" }
							/* { "data": "currytm" },
							{ "data": "prevytm" },
							{ "data": "maturityDate" } */
							
        		  ],
        		  "order": [[ 2, "desc" ]],
        		  "scrollX": true,
        		  "dom": 'Bfrtip',
	        		 // "buttons": ['copy', 'csv', 'excel', 'pdf', 'print'],
	        		 "buttons": [ {
			                extend : 'pdfHtml5',
			                title : function() {
			                	const months = ["JAN", "FEB", "MAR","APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
			                	let current_datetime = new Date()
			                	let formatted_date = current_datetime.getDate() + "-" + months[current_datetime.getMonth()] + "-" + current_datetime.getFullYear()
			                	console.log(formatted_date)
			                    return "Jarvis Everything : date ( "+formatted_date+" )";	
			                	},
			                orientation : 'landscape',
			                pageSize : 'A6',
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
        		
        		var oTable =  $('#exampleDrop').DataTable();
        		oTable.destroy();
        		var oTable =  $('#exampleDrop').dataTable( {
        			scrollY:        '50vh',
        	        scrollCollapse: true,
        	        paging:         false,
        			aaSorting: [[1, 'desc']],
        		        "ajax": {
        		            "url": url,
        		            "dataSrc": function(data) {
        		            	console.log(data.worstFiveStocks);
        		            	var data = data.worstFiveStocks;
        		            	return data;
        		            }
        		        },
        		        "columns": [
							{ "data": "worstMovedStock" },
							{ "data": "worstMovedBy" },
							{ "data": "percentageChangeDrop" },
							{ "data": "worstMoveCurrValue" },
							{ "data": "worstMovePrevValue" }
							/* { "data": "currytm" },
							{ "data": "prevytm" },
							{ "data": "maturityDate" } */
							
        		  ],
        		  "order": [ 2, "asc" ],
        		  "scrollX": true,
        		  "dom": 'Bfrtip',
	        		 // "buttons": ['copy', 'csv', 'excel', 'pdf', 'print'],
	        		 "buttons": [ {
			                extend : 'pdfHtml5',
			                title : function() {
			                	const months = ["JAN", "FEB", "MAR","APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
			                	let current_datetime = new Date()
			                	let formatted_date = current_datetime.getDate() + "-" + months[current_datetime.getMonth()] + "-" + current_datetime.getFullYear()
			                	console.log(formatted_date)
			                    return "Jarvis Everything : date ( "+formatted_date+" )";	
			                	},
			                orientation : 'landscape',
			                pageSize : 'A6',
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
            	
            	
            	jQuery.ajax({
			    	url: '<%=request.getContextPath()%>/JarvisV2/getImportHistorySheetCompare',
			           type: "GET",
			           async:false,
			           cache: false,
			           data: "metadataName="+metadataName+"&date1="+date1+"&date2="+date2,
			           dataType: "json",
			           success: function(data) {
			        	   var bestHtml = "";
			        	    var worstHtml = "";
			        	    var bestFS = data.bestFiveStocks;
			        	    var worstFS=data.worstFiveStocks;
							/* for(var i in bestFS){
								console.log("bestMovedStock: "+bestFS[i].bestMovedStock);
								bestHtml = bestHtml + "<tr>";
								bestHtml = bestHtml + "<td>" + bestFS[i].bestMovedStock + "</td>";
								bestHtml = bestHtml + "<td>" + bestFS[i].bestMovedBy + "</td>";
								bestHtml = bestHtml + "<td>" + bestFS[i].percentageChangeRise + "</td>";
								bestHtml = bestHtml + "<td>" + bestFS[i].bestMoveCurrValue + "</td>";
								bestHtml = bestHtml + "<td>" + bestFS[i].bestMovePrevValue + "</td>";
								bestHtml = bestHtml + "</tr>";
							}			        	   
							
							$("#bestTable").html(bestHtml);
							
							for(var i in worstFS){
								console.log("worstMovedStock: "+worstFS[i].worstMovedStock);
								worstHtml = worstHtml + "<tr>";
								worstHtml = worstHtml + "<td>" + worstFS[i].worstMovedStock + "</td>";
								worstHtml = worstHtml + "<td>" + worstFS[i].worstMovedBy + "</td>";
								worstHtml = worstHtml + "<td>" + worstFS[i].percentageChangeDrop + "</td>";
								worstHtml = worstHtml + "<td>" + worstFS[i].worstMoveCurrValue + "</td>";
								worstHtml = worstHtml + "<td>" + worstFS[i].worstMovePrevValue + "</td>";
								worstHtml = worstHtml + "</tr>";
								
							}		        	   
			        	     	
							$("#worstTable").html(worstHtml);  */
							 loadBestChart(bestFS, worstFS);
			           },
			           error: function(e){				           
		           	        alert('Error in getColumns: ' + e);		           	
		           	    }

		       });
            	
            	$('#everyThing').hide();
            	$('#filter').modal('hide');
            	$('#comparedisplay').show();
            	$('#stockRankingDiv').hide();
            }
            
            function getColumns(){
            	jQuery.ajax({
			    	url: '<%=request.getContextPath()%>/JarvisV2/getColumns',
			           type: "GET",
			           async:false,
			           cache: false,
			           data: "metaDataName=Everything_List_New",
			           dataType: "json",
			           success: function(data) {
			        	   //alert(data);
			        	   var headerHTML = "";
			        	   for(var i=0;i<data.length;i++){
			        		   headerHTML = headerHTML + "<th>" + data[i].elementDisplayName + "</th>";
			        	   }
			        	   headerHTML = headerHTML + "<th>Date</th>";
			        	   $("#headerRow").html(headerHTML);
			        	   getImportsData();        	   
			           },
			           error: function(e){				           
		           	        alert('Error in getColumns: ' + e);		           	
		           	    }

		       });
            	
            	$('#everyThing').show();
            	$('#comparedisplay').hide();
            	$('#stockRankingDiv').hide();
            }
            
            function stockPerformance(){
				
        		$('#everyThing').show();
        		$('#comparedisplay').hide();
        		$('#stockRankingDiv').hide();
			}
            
			function getStockRanking(){
           
            	 var metadataName="Everything_List_New";
            		var date1="1900-01-01";
                	var date2="1900-01-01";
            		var url = '<%=request.getContextPath()%>/JarvisV2/getImportHistorySheetCompare?metadataName='+metadataName+'&date1='+date1+'&date2='+date2;

            	 

 				//var url = '<%=request.getContextPath()%>/JarvisV2/getStockRanking?metadataName='+metadataName;
         		
         		var oTable =  $('#stockRankingRise').DataTable();
         		oTable.destroy();
         		var oTable =  $('#stockRankingRise').dataTable( {
         			scrollY:        '50vh',
         	        scrollCollapse: true,
         	        paging:         false,
         			aaSorting: [[1, 'desc']],
         		        "ajax": {
         		            "url": url,
         		           "dataSrc": function(data) {
       		            	console.log(data.bestFiveStocks);
       		            	var data = data.bestFiveStocks;
       		            	return data;
       		            }
         		            
         		        },
         		        "columns": [
 							{ "data": "bestMovedStock" },
 							{ "data": "bestMovedBy" },
 							{ "data": "percentageChangeRise" },
 							{ "data": "bestMoveCurrValue" },
 							{ "data": "bestMovePrevValue" }
 							
 							
         		  ],
         		 "order": [[ 2, "desc" ]],
         		  "scrollX": true,
         		  "dom": 'Bfrtip',
 	        		 // "buttons": ['copy', 'csv', 'excel', 'pdf', 'print'],
 	        		 "buttons": [ {
 			                extend : 'pdfHtml5',
 			                title : function() {
 			                	const months = ["JAN", "FEB", "MAR","APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
 			                	let current_datetime = new Date()
 			                	let formatted_date = current_datetime.getDate() + "-" + months[current_datetime.getMonth()] + "-" + current_datetime.getFullYear()
 			                	console.log(formatted_date)
 			                    return "Jarvis Everything : date ( "+formatted_date+" )";	
 			                	},
 			                orientation : 'landscape',
 			                pageSize : 'A6',
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
         		
         		var oTable =  $('#stockRankingDrop').DataTable();
         		oTable.destroy();
         		var oTable =  $('#stockRankingDrop').dataTable( {
         			scrollY:        '50vh',
         	        scrollCollapse: true,
         	        paging:         false,
         			aaSorting: [[1, 'desc']],
         		        "ajax": {
         		            "url": url,
         		           "dataSrc": function(data) {
       		            	console.log(data.worstFiveStocks);
       		            	var data = data.worstFiveStocks;
       		            	return data;
       		            }
         		            
         		        },
         		        "columns": [
 							{ "data": "worstMovedStock" },
 							{ "data": "worstMovedBy" },
 							{ "data": "percentageChangeDrop" },
 							{ "data": "worstMoveCurrValue" },
 							{ "data": "worstMovePrevValue" }
 							
 							
         		  ],
         		 "order": [ 2, "asc" ],
         		  "scrollX": true,
         		  "dom": 'Bfrtip',
 	        		 // "buttons": ['copy', 'csv', 'excel', 'pdf', 'print'],
 	        		 "buttons": [ {
 			                extend : 'pdfHtml5',
 			                title : function() {
 			                	const months = ["JAN", "FEB", "MAR","APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
 			                	let current_datetime = new Date()
 			                	let formatted_date = current_datetime.getDate() + "-" + months[current_datetime.getMonth()] + "-" + current_datetime.getFullYear()
 			                	console.log(formatted_date)
 			                    return "Jarvis Everything : date ( "+formatted_date+" )";	
 			                	},
 			                orientation : 'landscape',
 			                pageSize : 'A6',
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
         
         /*    	 
            	jQuery.ajax({
			    	url: '<%=request.getContextPath()%>/JarvisV2/getStockRanking',
			           type: "GET",
			           async:false,
			           cache: false,
			           data: "metadataName="+metadataName,
			           dataType: "json",
			           success: function(data) {
			        	   var bestHtml = "";
			        	    var worstHtml = "";
			        	 
							for(var i in data){
								console.log("bestMovedStock: "+data[i].bestMovedStock);
								bestHtml = bestHtml + "<tr>";
								bestHtml = bestHtml + "<td>" + data[i].bestMovedStock + "</td>";
								bestHtml = bestHtml + "<td>" + data[i].bestMovedBy + "</td>";
								bestHtml = bestHtml + "<td>" + data[i].percentageChangeRise + "</td>";
								bestHtml = bestHtml + "<td>" + data[i].bestMoveCurrValue + "</td>";
								bestHtml = bestHtml + "<td>" + data[i].bestMovePrevValue + "</td>";
								bestHtml = bestHtml + "</tr>";
							}			        	   
							
							$("#stockRiseTable").html(bestHtml);
							
							for(var i in data){
								console.log("worstMovedStock: "+data[i].worstMovedStock);
								worstHtml = worstHtml + "<tr>";
								worstHtml = worstHtml + "<td>" + data[i].worstMovedStock + "</td>";
								worstHtml = worstHtml + "<td>" + data[i].worstMovedBy + "</td>";
								worstHtml = worstHtml + "<td>" + data[i].percentageChangeDrop + "</td>";
								worstHtml = worstHtml + "<td>" + data[i].worstMoveCurrValue + "</td>";
								worstHtml = worstHtml + "<td>" + data[i].worstMovePrevValue + "</td>";
								worstHtml = worstHtml + "</tr>";
								
							}		        	   
			        	     	
							$("#stockDropTable").html(worstHtml);
			           },
			           error: function(e){				           
		           	        alert('Error in getColumns: ' + e);		           	
		           	    }

		       }); 
 */            	
            	$('#everyThing').hide();
            	$('#filter').modal('hide');
            	$('#comparedisplay').hide();
            	$('#stockRankingDiv').show();
			}
            
			function findImportDatesByMonth(){
        		
        		var url = '<%=request.getContextPath()%>/JarvisV2/findImportDatesByMonth?metaDataName=Everything_List_New';
        		
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
        		  "lengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]], 
        		 // "buttons": ['copy', 'csv', 'excel', 'pdf', 'print'],
        		 
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
        		
        		var url = '<%=request.getContextPath()%>/JarvisV2/getImportsData?metaDataName=Everything_List_New';
        		
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
							{ "data": "lastUpdatedAt" }
							
        		  ],
        		  "columnDefs":[{
      	            "targets":28,//column index
      	            "data":"element1",
      	            "render":function(data,type,row){
      	            	var res = data.substring(0, 10);
      	            	//alert("res"+res);
			   			 return res;
      	        	 }
      	        }],
      	      "order": [[ 28, "desc" ]],
        		  "scrollX": true,
        		  "dom": 'Bfrtip',
        		 // "buttons": ['copy', 'csv', 'excel', 'pdf', 'print'],
        		 "buttons": [ {
		                extend : 'pdfHtml5',
		                title : function() {
		                	const months = ["JAN", "FEB", "MAR","APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
		                	let current_datetime = new Date()
		                	let formatted_date = current_datetime.getDate() + "-" + months[current_datetime.getMonth()] + "-" + current_datetime.getFullYear()
		                	console.log(formatted_date)
		                    return "Jarvis Everything : date ( "+formatted_date+" )";	
		                	},
		                orientation : 'landscape',
		                pageSize : 'A4',
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
        		
        		$('#everyThing').show();
            	$('#comparedisplay').hide();
            	$('#stockRankingDiv').hide();
            }
            
            
            function loadBestChart(bestFS, worstFS){
            	
            	var count = 0;
            	var best5Perc = new Array();
            	var best5Name = new Array();
            	
            	var worst5Perc = new Array();
            	var worst5Name = new Array();
            	for(var i in bestFS){
            		if(bestFS[i].percentageChangeRise!='Infinity' && bestFS[i].percentageChangeRise!='NaN'){
            			best5Perc.push(bestFS[i].percentageChangeRise);
	            		best5Name.push(bestFS[i].bestMovedStock);
	            		count++;
            		}
            		if(count==20)
            			break;
            	}
            	
            	count = 0;
				for(var i in worstFS){
					if(worstFS[i].percentageChangeDrop!='Infinity' && worstFS[i].percentageChangeDrop!='NaN'){
						worst5Perc.push(worstFS[i].percentageChangeDrop);
						worst5Name.push(worstFS[i].worstMovedStock);
						count++;
					}
            		if(count==20)
            			break;
            	}
				
				Highcharts.chart('worstChartDiv', {
            	    chart: {
            	        type: 'column'
            	    },
            	    title: {
            	        text: 'Stock Performance'
            	    },
            	    subtitle: {
            	        text: 'Worst Twenty'
            	    },
            	    xAxis: {
            	        categories: worst5Name,
            	        crosshair: true
            	    },
            	    yAxis: {
            	        min: -15,
            	        title: {
            	            text: 'Drop In %'
            	        }
            	    },
            	    tooltip: {
            	        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            	        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
            	            '<td style="padding:0"><b>{point.y:.1f} %</b></td></tr>',
            	        footerFormat: '</table>',
            	        shared: true,
            	        useHTML: true
            	    },
            	    plotOptions: {
            	        column: {
            	            pointPadding: 0.2,
            	            borderWidth: 0
            	        }
            	    },
            	    series: [{
            	        name: 'Stock',
            	        data: JSON.parse("[" + worst5Perc + "]") 

            	    }]
            	});

            	
            
            	
            	Highcharts.chart('bestChartDiv', {
            	    chart: {
            	        type: 'column'
            	    },
            	    title: {
            	        text: 'Stock Performance'
            	    },
            	    subtitle: {
            	        text: 'Best Twenty'
            	    },
            	    xAxis: {
            	        categories: best5Name,
            	        crosshair: true
            	    },
            	    yAxis: {
            	        min: 0,
            	        title: {
            	            text: 'Rise In %'
            	        }
            	    },
            	    tooltip: {
            	        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            	        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
            	            '<td style="padding:0"><b>{point.y:.1f} %</b></td></tr>',
            	        footerFormat: '</table>',
            	        shared: true,
            	        useHTML: true
            	    },
            	    plotOptions: {
            	        column: {
            	            pointPadding: 0.2,
            	            borderWidth: 0
            	        }
            	    },
            	    series: [{
            	        name: 'Stock',
            	        data: JSON.parse("[" + best5Perc + "]") 

            	    }]
            	});

            	
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
						<li class="nav-item">
							<!-- <a class="nav-link" href="/JarvisV2/imports?isUploadAllowed=<%=isUploadAllowed%>">Debt Reports</a> -->
							<a class="nav-link" href="#" title="" onclick="$('#frmImport').submit();">Debt Reports</a> 
						</li>
						<li class="nav-item">
							<!-- <a class="nav-link" href="/JarvisV2/tickersimport?isUploadAllowed=<%=isUploadAllowed%>">Tickers</a> -->
							<a class="nav-link" href="#" title="" onclick="$('#frmTicker').submit();">Tickers</a>
							
						</li>
						<li class="nav-item">
							<!-- <a class="nav-link" href="/JarvisV2/bondimport?isUploadAllowed=<%=isUploadAllowed%>">Bonds</a> -->
							<a class="nav-link" href="#" title="" onclick="$('#frmBond').submit();">Bonds</a>
						</li>
						<li class="nav-item active">
							<!-- <a class="nav-link" href="/JarvisV2/everythingimport?isUploadAllowed=<%=isUploadAllowed%>">Everything List</a> -->
							<a class="nav-link" href="#" title="" onclick="$('#frmEveryThing').submit();">Everything List<span class="sr-only">(current)</span></a>
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
					
					  <form method="post" action="/JarvisV2/uploadFileEveryThing" id="importUploadForm1" enctype="multipart/form-data">
						<div class="" style="">	
						  <input type="hidden" name="metaDataName" value="Everything_List_New" />
						  <select class="livesearch" id="filterTicker" style="width:150px;"></select>&nbsp;<input type="button" name="" class="modalBtnWeekly" value="go" onclick="getHistoryByTicker()" />&nbsp;&nbsp;
						  <span id="fileuploadSpan">	
						  <input type="file" name="myfile" style="width:200px;">
						  
							<button class="modalBtn" onclick="$('#importUploadForm1').submit();">
							<i class="fa fa-upload" aria-hidden="true"></i> Upload</button>
							</span>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="modalBtn" onclick="findImportDatesByMonth()">History</button>&nbsp;&nbsp;&nbsp;&nbsp;
							<!-- <button class="dt-button buttons-html5" onclick="$('#filter').modal('show');">Calculate</button> -->
							<!-- <button type="button" class="modalBtn" data-toggle="modal" data-target="#calculateModal">Calculate</button>&nbsp;&nbsp;&nbsp;&nbsp; -->
								<button type="button" class="modalBtn" onclick="getReset()">Reset</button>
								<button type="button" class="modalBtn" onclick="stockPerformance()" >Performance</button>
						   		<button type="button" class="modalBtn" onclick="getStockRanking()" >Ranking</button>
							</div>
							</form>
					</div>
				 
				  
			 
				
					<!-- <a href="demand" title="" class="float-right viewGraph hvr-push">VIEW ALL GRAPHS</a> -->
					<!--graph section-->
					
					<br><br>
					<div  id="everyThing">
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
    <div id="comparedisplay">
    		<div class="row">
			<div class="col-sm-6">
				<!-- <div class="container position-relative"> -->
					
					<table id="exampleRise" class="display" style="width:100%">
        <thead>
            <tr>
				<th>Most Risen Stock</th>
				<th>Price Risen By</th>
				<th>% In Rise</th>
				<th>Current Price</th>
				<th>Previous Price</th>
            </tr>
        </thead>
        <tbody id="bestTable">
           
        </tbody>
    </table>
    <br><br>
    <div id="bestChartDiv">
    
    </div>
				
				</div>
				
				
				<div class="col-sm-6">
				<table id="exampleDrop" class="display" style="width:100%">
				        <thead>
            <tr>
				<th>Most Dropped Stock</th>
				<th>Price Dropped By</th>
				<th>% In Drop</th>
				<th>Current Price</th>
				<th>Previous Price</th>
            </tr>
        </thead>
        <tbody id="worstTable">
           
        </tbody>
        
    </table>
    <br><br>
    <div id="worstChartDiv">
    
    </div>






				</div>
				</div>
    </div>  

			<div id="stockRankingDiv">
		<div>
			
					
					<table id="stockRankingRise" class="display" style="width:100%">
	<thead>
	    <tr>
				<th>Most Risen Stock</th>
				<th>Price Risen By</th>
				<th>% In Rise</th>
				<th>Current Price</th>
				<th>Previous Price</th>
	    </tr>
	</thead>
	<tbody id="stockRiseTable">
	   
	</tbody>
	</table>

				</div>  <br><br><br>
				
				
				<div>
				<table id="stockRankingDrop" class="display" style="width:100%">
					<thead>
	    <tr>
				<th>Most Dropped Stock</th>
				<th>Price Dropped By</th>
				<th>% In Drop</th>
				<th>Current Price</th>
				<th>Previous Price</th>
	    </tr>
	</thead>
	<tbody id="stockDropTable">
	   
	</tbody>

	</table>







				</div>
	</div>
		



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
						<h2>Import History - Everything List</h2>
						<a href="#" title="" class="close" data-dismiss="modal"><i class="fa fa-window-close" aria-hidden="true"></i></a>
					</div>
					<!-- Modal body -->
					<div class="filter-body">
						<form action="" method="post">
						<br>
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
						<input type="submit" class="modalBtn" id="vali" name="submit" onclick="getImportHistorySheetCompare()" value="Compare"/>
					</div>
				</form>
				</div>
			</div>
		
		</div>
		<!-- end Modal -->


	<!-- The Modal -->
	<div class="modal" id="calculateModal">
			<div class="modal-dialog">
				<div class="modal-content" style="width:100%;">
					<!-- Modal Header -->
					<div class="filter-header">
						<img src="/images/filter-violet.PNG" alt="">
						<h2>Analysis - Everything List</h2>
						<a href="#" title="" class="close" data-dismiss="modal"><i class="fa fa-window-close" aria-hidden="true"></i></a>
					</div>
					<!-- Modal body -->
					<div class="filter-body" style="padding: 10px;margin-left:20px">
					<br>
						<form action="" method="post">
							<div class="row">
								<div class="col-md-4">
									<div class="filterBlock">
		                      		<div class="selectBox">
				                        <label>&nbsp;</label>
								        <select >
								          <option value="Best">Best Performing</option>
								          <!-- <option value=""></option>
								          <option value=""></option> -->
								          </select><br><br>
								         </div>
								         </div>
								         </div>
								         </div>
								          <div class="row">
							                <div class="col-sm-4">
							                	Rank Less Then<input type="text" name="" class="form-control"><br><br>
							                </div>
							                <div class="col-sm-4">
							                	<br>(for consecutive 3 weeks)<br><br>
							                </div>
							                </div>
							                 <div class="row">
							                <div class="col-sm-4">
							                	Relative Strength<input type="text" name="" class="form-control"><br><br>
							                </div>
							             </div>	
							              <div class="row">
							                <div class="col-sm-4">
							                	price Vs 20 day average<input type="text" name=""  class="form-control"><br><br>
							                </div>
							             </div>	
						</form>
					</div>
					
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="modalBtn modalBtnCancel" data-dismiss="modal">Cancel</button>
						<input type="submit" class="modalBtn" id="vali" name="submit" value="Compare"/>
					</div>
				</div>
			</div>
		
		</div>
		<!-- end Modal -->
	

		  
		
		</body>
		</html>
	