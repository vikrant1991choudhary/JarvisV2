<!doctype html>
<%
String isUploadAllowed = session.getAttribute("isUploadAllowed")!=null ? session.getAttribute("isUploadAllowed").toString() : "";
 System.out.println("isUploadAllowed -- " + isUploadAllowed);
%>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Jarvis</title>
<link href="favicon.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="/css/font-awesome.min.css" type="text/css">
<link rel="stylesheet" href="/css/googleapis.css">

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
.ex1{
  width:100px;
  height:50px;
  margin:auto
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


<script src="/js/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/popper.min.js" type="text/javascript"></script>

<script src="/js/custom.js" type="text/javascript"></script>

</head>
<body>

	<!--header-->

	<header>
		<div class="container-fluid">
			<!--left-->
			<div class="float-left">
				<div class="logo">
					<img src="/images/logo_leftbraincm.jpg" alt=""> <a href="#"
						title="">

						<h1 style="color: #247041">Jarvis</h1>
					</a>
				</div>
			</div>
			<!--end left-->

			<!--right-->
			<div class="float-right">
				<ul class="headLinks">
					<li><a href="home" title=""> <i class="fa fa-home"
							style="font-size: 24px"></i> Home
					</a></li>
					<li><a href="javascript:void(0)" title="" id="helpBtn"> <i
							class="fa fa-question-circle" style="font-size: 24px"></i> Help
					</a></li>
					<li><a href="/JarvisV2/logout" title=""> <i
							class="fa fa-sign-out" style="font-size: 24px"></i> Logout
					</a></li>
				</ul>
			</div>
			<!--end right-->
		</div>
	</header>

	<div class="helpContent">
		<p class="text-center">
			Please download User manual <a href="/images/User Manual.pdf"
				title="" target="_blank"><i class="fa fa-file-pdf-o"
				aria-hidden="true"></i> </a>
		</p>
	</div>
	<?php include 'footer.php';?>

	<script type="text/javascript">
			$(document).ready( function() {
				getColumns();
				getAllTicker();
				getAllPortFolioTicker();
				uploadFileDiv();
				
				$("#portfolioTicker").change(function(){
				      //alert($(this).val());
				     // alert($(this).text());
				     var idPortfolio=$(this).val();
				      
				     var url = '<%=request.getContextPath()%>/JarvisV2/getPortFolioStockSet?';
						url = url + "idPortfolio="+idPortfolio;
						
						var oTable =  $('#example').DataTable();
		        		oTable.destroy();
		        		var oTable =  $('#example').dataTable( {
		        			 oLanguage: {
		        			      sLoadingRecords: '<img src="/images/loading.gif">'
		        			    },
		        			aaSorting: [[30, 'desc']],
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
									{ "data": "element31" },
									{ "data": "element32" },
									{ "data": "element33" },
									{ "data": "element34" },
									{ "data": "element35" },
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
									{ "data": "lastUpdatedAt" }
									
					        		  ],
					        		  "columnDefs":[{
					      	            "targets":35,
					      	            "data":"element1",
					      	            "render":function(data,type,row){
					      	            	var res = data.substring(0, 10);
								   			 return res;
					      	        	 }
					      	        }],
					      	      "order": [[ 35, "desc" ]],	        
		        		  "scrollX": true,
		        		  "dom": 'lBfrtip',
						"lengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]], 
		        		 "buttons": [ {
				                extend : 'pdfHtml5',
				                title : function() {
				                	const months = ["JAN", "FEB", "MAR","APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
				                	let current_datetime = new Date()
				                	let formatted_date = current_datetime.getDate() + "-" + months[current_datetime.getMonth()] + "-" + current_datetime.getFullYear()
				                	console.log(formatted_date)
				                    return "Jarvis Ticker for ( "+formatted_date+" )";
				                },
				                orientation : 'landscape',
				                pageSize : 'A0',
				                text : '<i class="fa fa-file-pdf-o"> PDF</i>',
				                titleAttr : 'PDF'
				            },{
				            	extend: 'excelHtml5',
				            	text : '<i class="fa fa-file-excel-o"> EXCEL</i>',
				            } ],
		        		  "pagingType": "full",
		        		  "language": {
		        		      "paginate": {
		        		        "previous": "<<",
		        		        "next": ">>"
		        		      }
		        		    }
		        		 } );
		        		
		        		$('#everyThing').show();
		            	$('#filter').modal('hide');
		            	$('#comparedisplay').hide();
		            	$('#backButton').hide();
		            	$('#mainButton').show();
		            	$('#stockRankingDiv').hide();
				     });
				
				 $("#calculateDiv").change(function() {
				    	var drop=($(this).find("option:selected").text());
				      //  alert("dropdown2--"+drop);
				        
				        if(drop=='Best Performing'){
				     	   $('#bestPerDiv').show();
				     	   $('#worstPerDiv').hide();
				     	 
				        }
				        if(drop=='Worst Performing'){
				     	   $('#bestPerDiv').hide();
				     	   $('#worstPerDiv').show();
				        }
				     });
	
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
            	var dropDown = document.getElementById("filterTicker");
                dropDown.selectedIndex = 0;
            	getImportsData();
            }
            
            function loadchartForTicker(){
         	   //CLose modal
         	   var year = $('#chart1FYTicker').val();
         	   var year2= $('#chart2FYTicker').val();
         	   $('#modalChartForTicker').modal('hide');
         	  getChartForHistoryByTicker(year,year2);
            }
            
 			function getAllTicker(){
 				var metadataName="Tickers_Watchlist";
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
 			
 			function getAllPortFolioTicker(){
 				//var metadataName="Tickers_Watchlist";
            	jQuery.ajax({
			    	url: '<%=request.getContextPath()%>/JarvisV2/getAllPortFolioTicker',
			           type: "GET",
			           async:false,
			           cache: false,
			          // data: "metadataName="+metadataName,
			           dataType: "json",
			           success: function(data) {
			        	//  alert("getAllPortFolioTicker"+data);
			        	   var html ="<option value=''>--Select PortFolio--</option> ";
			        	   for(var i=0; i<data.length; i++){
			        		   html = html + "<option value='" + data[i].idPortfolio + "'>" + data[i].name + "</option>";
			        	   }
			        	   $("#portfolioTicker").html(html); 
			        	 //  $(".livesearch").chosen(); 
			           },
			           error: function(e){				           
		           	        alert('Error in getColumns: ' + e);		           	
		           	    }

		       });
            }
 			
 			function getChartForHistoryByTicker(year,year2){
				var metadataName="Tickers_Watchlist";
				var ticker=escape($("#filterTicker>option:selected").val());
				//alert("getChartForHistoryByTicker-"+ticker);
				
				jQuery.ajax({
          			 url: '<%=request.getContextPath()%>/JarvisV2/getChartForHistoryByTicker',
   			           type: "GET",
   			           async:false,
   			           cache: false,
   			           data: "metadataName="+metadataName+"&ticker="+ticker+"&year="+year+"&year2="+year2,
   			           dataType: "json",
   			           success: function(data) {
          					 
          					  var bestFS = data;
          					 
          							
          							viewChartForHistoryByTicker(bestFS);
          				   },
          				   error: function(e){				           
          					//alert('Error in getColumns: ' + e);		           	
          				    }

          			});  
           		
           		$('#historyByTickerChartDiv').show();
           		$('#exampleParentChartDiv').hide();
           		$('#everyThing').hide();
               	$('#filter').modal('hide');
               	$('#comparedisplay').hide();
               	$('#backButton').hide();
               	$('#mainButton').show();
               	$('#stockRankingDiv').hide();
              
				
			}			
 			
	function viewChartForHistoryByTicker(bestFS){
		var ticker=escape($("#filterTicker>option:selected").val());
			var chartYear1 = $('#chart1FYTicker').val();
		  	var chartYear2 = $('#chart2FYTicker').val();
				var RankWithInTable = new Array();
	        	var Price = new Array();
	        	var Date=new Array();
	        	//var Date1=new Array();
				
	        	var count=0;
	        	
	        	for(var i in bestFS){
	        		if(bestFS[i].element3!='-' && bestFS[i].element3!='- ' ){
	        			RankWithInTable.push(bestFS[i].element3);    			
	        			Date.push((bestFS[i].lastUpdatedAt).substring(0, 10));
	        		}
						//changeInValue.push(bestFS[i].changeInValue);
						
	        			
	        		/* if(count==20)
	        			break; */
	        		  }
	        	//  console.log("RankWithInTable--"+RankWithInTable);
	        	  console.log("Date--"+Date); 
	        	/*console.log("changeInValue--"+changeInValue);
	        	console.log("percentageChange--"+percentageChange);
	        	console.log("price--"+price); */
	        	
	        	
	        	Highcharts.chart('chart8', {
            	    chart: {
            	        type: 'column'
            	    },
            	    title: {
            	    	useHTML: true,
            			text: 'Year: ' + chartYear1+'-'+ chartYear2 + '<a href="#" data-toggle="modal" data-target="#modalChartForTicker"><i class="fa_custom fa_custom_green fa fa-filter" aria-hidden="true"></i></a>'	
            			
            	    },
            	    subtitle: {
            	        text: ''
            	    },
            	    xAxis: {
            	    	 categories: Date,
						title: {
							text: 'Date'
						}
            	    },
            	    yAxis: {
            	        min: 0,
            	        title: {
            	            text: ''
            	        }
            	    },
            	    tooltip: {
            	        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            	        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
            	            '<td style="padding:0"><b>{point.y:.1f} </b></td></tr>',
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
    	    	        name: 'Rank WithIn Table: '+ticker,
    	    	        data: JSON.parse("[" + RankWithInTable + "]")
    	    	    } ]
            	});
	     
	       /*  Highcharts.chart('chart8', {

	        	    title: {
	        	        text: 'Ratio Graph'
	        	    },

	        	    subtitle: {
	        	        text: ''
	        	    },

	        	    xAxis: {
	        	    	title: {
	        	            text: 'Date'
	        	        },
	        	       // categories: week1Value
	        	    },
	        	    yAxis: {
	        	        title: {
	        	            text: 'Price'
	        	        }
	        	    },

	        	    legend: {
	        	        layout: 'vertical',
	        	        align: 'right',
	        	        verticalAlign: 'middle'
	        	    },

	        	    plotOptions: {
	        	        line: {
	        	            dataLabels: {
	        	                enabled: true
	        	            },
	        	            enableMouseTracking: false
	        	        }
	        	    },

	        	    series: [{
	    	        name: 'YTW',
	    	        data: JSON.parse("[" + YTW + "]")
	    	    } , {
	    	        name: 'Price',
	    	        data: JSON.parse("[" + Price + "]")                    
	    	    } ]

	        	}); */
	            	
	            } 
            
            
            function getHistoryByTicker(){
            	var metadataName="Tickers_Watchlist";
            	var ticker=$("#filterTicker").val();
            	//alert("filterTicker"+ticker);
            	if(ticker==null || ticker=='' || ticker===undefined)
            		{
            			alert("Please Enter Ticker");
            			return true;
            		}
            	
            	$('#filterTicker').val(ticker);
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
							{ "data": "element31" },
							{ "data": "element32" },
							{ "data": "element33" },
							{ "data": "element34" },
							{ "data": "element35" },
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
							{ "data": "lastUpdatedAt" }
							
			        		  ],
			        		  "columnDefs":[{
			      	            "targets":35,//column index
			      	            "data":"element1",
			      	            "render":function(data,type,row){
			      	            	var res = data.substring(0, 10);
			      	            	//alert("Ticker"+res);
						   			 return res;
			      	        	 }
			      	        }],
			      "order": [[ 35, "desc" ]],
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
		                    return "Jarvis Ticker for ( "+formatted_date+" )";
		                    //return "Jarvis PDF";
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
        		
        		/* jQuery.ajax({
          			 url: '<%=request.getContextPath()%>/JarvisV2/getHistoryByTicker',
   			           type: "GET",
   			           async:false,
   			           cache: false,
   			           data: "metadataName="+metadataName+"&ticker="+ticker,
   			           dataType: "json",
   			           success: function(data) {
          					 
          					  var bestFS = data;
          					 
          							
          							getChartForHistoryByTicker(bestFS);
          				   },
          				   error: function(e){				           
          					//alert('Error in getColumns: ' + e);		           	
          				    }

          			}); */  
           		
           		$('#historyByTickerChartDiv').hide();
           		$('#exampleParentChartDiv').hide();
           		$('#everyThing').show();
               	$('#filter').modal('hide');
               	$('#comparedisplay').hide();
               	$('#backButton').hide();
               	$('#mainButton').show();
               	$('#stockRankingDiv').hide();
              
           
            }
            
            function getDataByWeek (date) {
                
            	var metadataName="Tickers_Watchlist";
            	var url = '<%=request.getContextPath()%>/JarvisV2/getDataByWeek?';
				url = url + "metadataName="+metadataName+"&date="+date;
				
				var oTable =  $('#example').DataTable();
        		oTable.destroy();
        		var oTable =  $('#example').dataTable( {
        			 oLanguage: {
        			      sLoadingRecords: '<img src="/images/loading.gif">'
        			    },
        			aaSorting: [[30, 'desc']],
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
							{ "data": "element31" },
							{ "data": "element32" },
							{ "data": "element33" },
							{ "data": "element34" },
							{ "data": "element35" },
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
							{ "data": "lastUpdatedAt" }
							
			        		  ],
			        		  "columnDefs":[{
			      	            "targets":35,//column index
			      	            "data":"element1",
			      	            "render":function(data,type,row){
			      	            	var res = data.substring(0, 10);
			      	            	//alert("Ticker"+res);
						   			 return res;
			      	        	 }
			      	        }],
			      	      "order": [[ 35, "desc" ]],	        
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
		                    return "Jarvis Ticker for ( "+formatted_date+" )";
		                },
		                orientation : 'landscape',
		                pageSize : 'A0',
		                text : '<i class="fa fa-file-pdf-o"> PDF</i>',
		                titleAttr : 'PDF'
		            },{
		            	extend: 'excelHtml5',
		            	text : '<i class="fa fa-file-excel-o"> EXCEL</i>',
		            } ],
        		  "pagingType": "full",
        		  "language": {
        		      "paginate": {
        		        "previous": "<<",
        		        "next": ">>"
        		      }
        		    }
        		 } );
        		
        		$('#everyThing').show();
            	$('#filter').modal('hide');
            	$('#comparedisplay').hide();
            	$('#backButton').hide();
            	$('#mainButton').show();
            	$('#stockRankingDiv').hide();
           
              
            }
            
            
            function getCalculateTicker (){
				   
				   $('#calculateModal').modal('hide');
				   var isHighPerforming = $("#isHighPerforming>option:selected").val();
				   var metadataName="Tickers_Watchlist";
				   var date=""; 
					if(isHighPerforming=="true"){   // change
						var rankWithinTable = $("#rankWithinTable").val();
						var priceVs20DAvg=$("#priceVs20DAvg").val();
						var relativeStrength=$("#relativeStrength").val();
					}else{
						var rankWithinTable = $("#rankWithinTableW").val();
						var priceVs20DAvg=$("#priceVs20DAvgW").val();
						var relativeStrength=$("#relativeStrengthW").val();
					}
					
					//var isHighPerforming="true";
					//var isHighPerforming = $("#isHighPerforming>option:selected").val();
					//alert("isHighPerforming="+isHighPerforming);
										
					
					
					
					var url = '<%=request.getContextPath()%>/JarvisV2/getCalculateTicker?';
					url = url + "metadataName="+metadataName+"&date="+date+"&rankWithinTable="+rankWithinTable+"&relativeStrength="+relativeStrength+"&priceVs20DAvg="+priceVs20DAvg+"&isHighPerforming="+isHighPerforming;
	        		
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
								{ "data": "element31" },
								{ "data": "element32" },
								{ "data": "element33" },
								{ "data": "element34" },
								{ "data": "element35" },
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
								{ "data": "lastUpdatedAt" }								
				        		  ],
				        		  "columnDefs":[{
				      	            "targets":35,//column index
				      	            "data":"element1",
				      	            "render":function(data,type,row){
				      	            	var res = data.substring(0, 10);
				      	            	
							   			 return res;
				      	        	 }
				      	        }],
				      	      "order": [[ 35, "desc" ]],
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
			                    return "Jarvis Ticker for ( "+formatted_date+" )";
			                },
			                orientation : 'landscape',
			                pageSize : 'A0',
			                text : '<i class="fa fa-file-pdf-o"> PDF</i>',
			                titleAttr : 'PDF'
			            },{
			            	extend: 'excelHtml5',
			            	text : '<i class="fa fa-file-excel-o"> EXCEL</i>',
			            }],
	        		  "pagingType": "full",
	        		  "language": {
	        		      "paginate": {
	        		        "previous": "<<",
	        		        "next": ">>"
	        		      }
	        		    }
	        		 } );
			
			
			
					}

            
            
            
            
            function getStockRanking(){
                
           //	 var metadataName="Tickers_Watchlist";
           	 
         //  	var url = '<%=request.getContextPath()%>/JarvisV2/getStockRanking?metadataName='+metadataName;
           	
           	var date1="1900-01-01";
        	var date2="1900-01-01";
        	console.log("date1-"+date1+" "+"date2--"+date2);
        	var metadataName="Tickers_Watchlist";
        	

			var url = '<%=request.getContextPath()%>/JarvisV2/getImportHistorySheetCompare?metadataName='+metadataName+'&date1='+date1+'&date2='+date2;
    		
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
						/* { "data": "percentageChangeRise" }, */
						{ "data": "bestMoveCurrValue" },
						{ "data": "bestMovePrevValue" }
						
						
    		  ],
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
		                    return "Jarvis Ticker for ( "+formatted_date+" )";
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
						/* { "data": "percentageChangeDrop" }, */
						{ "data": "worstMoveCurrValue" },
						{ "data": "worstMovePrevValue" }
						
						
    		  ],
    		  "scrollX": true,
    		  "dom": 'Bfrtip',
        		 // "buttons": ['copy', 'csv', 'excel', 'pdf', 'print'],
				 "lengthMenu": [[50, 100, 150, -1], [50, 100, 150, "All"]],
        		 "buttons": [ {
		                extend : 'pdfHtml5',
		                title : function() {
		                	const months = ["JAN", "FEB", "MAR","APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
		                	let current_datetime = new Date()
		                	let formatted_date = current_datetime.getDate() + "-" + months[current_datetime.getMonth()] + "-" + current_datetime.getFullYear()
		                	console.log(formatted_date)
		                    return "Jarvis Ticker for ( "+formatted_date+" )";
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
           	
        /*    	jQuery.ajax({
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
           	
 */           	$('#everyThing').hide();
           	$('#filter').modal('hide');
           	$('#comparedisplay').hide();
           	$('#stockRankingDiv').show();
           	$('#mainButton').show();
           	$('#backButton').hide();
           	$('#historyByTickerChartDiv').hide();
    		$('#exampleParentChartDiv').hide();
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
            	var metadataName="Tickers_Watchlist";
            	

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
			                    return "Jarvis Ticker for ( "+formatted_date+" )";
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
        		  "scrollX": true,
        		  "dom": 'Bfrtip',
	        		 // "buttons": ['copy', 'csv', 'excel', 'pdf', 'print'],
					 "lengthMenu": [[50, 100, 150, -1], [50, 100, 150, "All"]],
	        		 "buttons": [ {
			                extend : 'pdfHtml5',
			                title : function() {
			                	const months = ["JAN", "FEB", "MAR","APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
			                	let current_datetime = new Date()
			                	let formatted_date = current_datetime.getDate() + "-" + months[current_datetime.getMonth()] + "-" + current_datetime.getFullYear()
			                	console.log(formatted_date)
			                    return "Jarvis Ticker for ( "+formatted_date+" )";
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
            	$('#backButton').show();
            	$('#mainButton').hide();
            	$('#stockRankingDiv').hide();
            	$('#historyByTickerChartDiv').hide();
        		$('#exampleParentChartDiv').hide();
            	
            }
			
			function getTicker(){
				$('#everyThing').show();
            	$('#filter').modal('hide');
            	$('#comparedisplay').hide();
            	$('#backButton').hide();
            	$('#mainButton').show();
            	$('#stockRankingDiv').hide();
			}
            
            function getColumns(){
            	jQuery.ajax({
			    	url: '<%=request.getContextPath()%>/JarvisV2/getColumns',
			           type: "GET",
			           async:false,
			           cache: false,
			           data: "metaDataName=Tickers_Watchlist",
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
            }
            
			function findImportDatesByMonth(){
        		
        		var url = '<%=request.getContextPath()%>/JarvisV2/findImportDatesByMonth?metaDataName=Tickers_Watchlist';
        		
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
							
        		  ],"columnDefs":[{
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
        		 "lengthMenu": [[50, 100, 150, -1], [50, 100, 150, "All"]],
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
            	        text: 'Ticker Performance'
            	    },
            	    subtitle: {
            	        text: 'Worst Twenty'
            	    },
            	    xAxis: {
            	        categories: worst5Name,
            	        crosshair: true
            	    },
            	    yAxis: {
            	        
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
            	        name: 'Ticker',
            	        data: JSON.parse("[" + worst5Perc + "]") 

            	    }]
            	});

            	
            
            	
            	Highcharts.chart('bestChartDiv', {
            	    chart: {
            	        type: 'column'
            	    },
            	    title: {
            	        text: 'Ticker Performance'
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
            	        name: 'Ticker',
            	        data: JSON.parse("[" + best5Perc + "]") 

            	    }]
            	});

            	
            }
            
				
		function chartViewBond() {

			var ticker = escape($("#filterTicker>option:selected").val());
			//alert("chartViewBond-"+ticker);

			//	alert("filterTicker"+ticker);
			if (ticker == null || ticker == '' || ticker === undefined) {
				//	alert("chart in if");
				$('#everyThing').show();
				//	$('#exampleParentChartDiv').show();
				alert("Please Select Ticker");
			} else {
				getChartForHistoryByTicker('2020', '2020');

			}
		}

		function gridViewBond() {
			var ticker = escape($("#filterTicker>option:selected").val());

			//	alert("filterTicker"+ticker);
			if (ticker == null || ticker == '' || ticker === undefined) {
				$('#everyThing').show();
				$('#exampleParentChartDiv').hide();
			}
			$('#everyThing').show();
			//	$('#exampleParentChartDiv').show();
			$('#historyByTickerChartDiv').hide();

		}

		function getImportsData() {

			var url = '<%=request.getContextPath()%>/JarvisV2/getImportsData?metaDataName=Tickers_Watchlist';

			var oTable = $('#example').DataTable();
			oTable.destroy();
			var oTable = $('#example').dataTable({
				oLanguage : {
					sLoadingRecords : '<img src="/images/loading.gif">'
				},
				
				"ajax" : {
					"url" : url,
					"dataSrc" : ""
				},
				"columns" : [ {
					"data" : "element1"
				}, {
					"data" : "element2"
				}, {
					"data" : "element3"
				}, {
					"data" : "element4"
				}, {
					"data" : "element5"
				}, {
					"data" : "element31"
				}, {
					"data" : "element32"
				}, {
					"data" : "element33"
				}, {
					"data" : "element34"
				}, {
					"data" : "element35"
				}, {
					"data" : "element6"
				}, {
					"data" : "element7"
				}, {
					"data" : "element8"
				}, {
					"data" : "element9"
				}, {
					"data" : "element10"
				}, {
					"data" : "element11"
				}, {
					"data" : "element12"
				}, {
					"data" : "element13"
				}, {
					"data" : "element14"
				}, {
					"data" : "element15"
				}, {
					"data" : "element16"
				}, {
					"data" : "element17"
				}, {
					"data" : "element18"
				}, {
					"data" : "element19"
				}, {
					"data" : "element20"
				}, {
					"data" : "element21"
				}, {
					"data" : "element22"
				}, {
					"data" : "element23"
				}, {
					"data" : "element24"
				}, {
					"data" : "element25"
				}, {
					"data" : "element26"
				}, {
					"data" : "element27"
				}, {
					"data" : "element28"
				}, {
					"data" : "element29"
				}, {
					"data" : "element30"
				} ,{
					"data" : "lastUpdatedAt"
				}

				],
				"columnDefs" : [ {
					"targets" : 35,//column index
					"data" : "element1",
					"render" : function(data, type, row) {
						var res = data.substring(0, 10);
						//alert("Ticker"+res);
						return res;
					}
				} ,{
					"targets" : 5,//column index
					"data" : "element31",
					"render" : function(data, type, row) {
						
						var datas=(data*100);
						if(datas!='NaN'){
						 var res = (Math.round(datas * 100) / 100).toFixed(2);
						}
						if(res=='NaN') 
							res="- ";
						
						return res;
					
					}
				} ,{
					"targets" : 8,//column index
					"data" : "element34",
					"render" : function(data, type, row) {
						var datas=(data*100);
						if(datas!='NaN'){
						 var res = (Math.round(datas * 100) / 100).toFixed(2);
						}
						if(res=='NaN') 
							res="- ";
						
						return res;
							
					}
					}, {
					"targets" : 9,//column index
					"data" : "element35",
					"render" : function(data, type, row) {
						var datas=(data*100);
						if(datas!='NaN'){
						 var res = (Math.round(datas * 100) / 100).toFixed(2);
						}
						if(res=='NaN') 
							res="- ";
						
						return res;
					}
					},{
					"targets" : 11,//column index
					"data" : "element7",
					"render" : function(data, type, row) {
						var datas=(data*100);
						if(datas!='NaN'){
						 var res = (Math.round(datas * 100) / 100).toFixed(2);
						}
						if(res=='NaN') 
							res="- ";
						
						return res;
					}
					}
					,{
					"targets" : 13,//column index
					"data" : "element9",
					"render" : function(data, type, row) {
						var datas=(data*100);
						if(datas!='NaN'){
						 var res = (Math.round(datas * 100) / 100).toFixed(2);
						}
						if(res=='NaN') 
							res="- ";
						
						return res;
					}
					},{
					"targets" : 15,//column index
					"data" : "element11",
					"render" : function(data, type, row) {
						var datas=(data*100);
						if(datas!='NaN'){
						 var res = (Math.round(datas * 100) / 100).toFixed(2);
						}
						if(res=='NaN') 
							res="- ";
						
						return res;
					}
					},{
					"targets" : 16,//column index
					"data" : "element12",
					"render" : function(data, type, row) {
						var datas=(data*100);
						if(datas!='NaN'){
						 var res = (Math.round(datas * 100) / 100).toFixed(2);
						}
						if(res=='NaN') 
							res="- ";
						
						return res;
					}
					},{
					"targets" : 17,//column index
					"data" : "element13",
					"render" : function(data, type, row) {
						var datas=(data*100);
						if(datas!='NaN'){
						 var res = (Math.round(datas * 100) / 100).toFixed(2);
						}
						if(res=='NaN') 
							res="- ";
						
						return res;
					}
					},{
						"targets" : 23,//column index
						"data" : "element19",
						"render" : function(data, type, row) {
							
							 var res = data.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
								
							//console.log("Doller="+res);
							return res;
						}
						}],
				 "order": [[ 35, "desc" ]],
				"scrollX" : true,
				"dom": 'lBfrtip', //'Bfrtip',
				"lengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]], 
				"buttons" : [ {
					extend : 'pdfHtml5',
					title : function() {
						const months = ["JAN", "FEB", "MAR","APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
	                	let current_datetime = new Date()
	                	let formatted_date = current_datetime.getDate() + "-" + months[current_datetime.getMonth()] + "-" + current_datetime.getFullYear()
	                	console.log(formatted_date)
	                    return "Jarvis Ticker for ( "+formatted_date+" )";
	                	},
					orientation : 'landscape',
					pageSize : 'A0',
					text : '<i class="fa fa-file-pdf-o"> PDF</i>',
					titleAttr : 'PDF'
				}, {
					extend : 'excelHtml5',
					text : '<i class="fa fa-file-excel-o"> EXCEL</i>',
				}/* , {
					extend : 'print',
					orientation : 'landscape',
					pageSize : 'A0',
					text : '<i class="fa fa-print"> PRINT</i>',
				} */ ],
				"pagingType" : "full",
				"language" : {
					"paginate" : {
						"previous" : "<<",
        		        "next": ">>"
					}
				}
			});

			$('#everyThing').show();
			$('#filter').modal('hide');
			$('#comparedisplay').hide();
			$('#backButton').hide();
			$('#mainButton').show();
			$('#stockRankingDiv').hide();
			$('#exampleParentChartDiv').hide();
			$('#historyByTickerChartDiv').hide();
		}
	</script>

	<!--end header-->

	<!--navigation-->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNavDropdown">
				<ul class="navbar-nav">
					<li class="nav-item">
					<!-- <a class="nav-link"	href="/JarvisV2/imports?isUploadAllowed=<%=isUploadAllowed%>">Debt Reports</a> -->
					<a class="nav-link" href="#" title="" onclick="$('#frmImport').submit();">Debt Reports</a> 
						</li>
					<li class="nav-item active">
					<!-- <a class="nav-link"	href="/JarvisV2/tickersimport?isUploadAllowed=<%=isUploadAllowed%>">Tickers<span class="sr-only">(current)</span></a> -->
					<a class="nav-link" href="#" title="" onclick="$('#frmTicker').submit();">Tickers<span class="sr-only">(current)</span></a>
					</li>
					<li class="nav-item">
					<!-- <a class="nav-link"	href="/JarvisV2/bondimport?isUploadAllowed=<%=isUploadAllowed%>">Bonds</a> -->
					<a class="nav-link" href="#" title="" onclick="$('#frmBond').submit();">Bonds</a>
					
					</li>
					
					<li class="nav-item">
					<!-- <a class="nav-link"	href="/JarvisV2/everythingimport?isUploadAllowed=<%=isUploadAllowed%>">Everything List</a> -->
					<a class="nav-link" href="#" title="" onclick="$('#frmEveryThing').submit();">Everything List</a>
						</li>
					<li class="nav-item"><a class="nav-link" href="#">Bonds
							with Stock</a></li>

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
		<div style="text-align: right;">

			<div style="color:${color}">${successMsg}</div>

			<form method="post" action="/JarvisV2/uploadFileTickerImport"
				id="importUploadForm1" enctype="multipart/form-data">
				<div class="" style="">
					<input type="hidden" name="metaDataName" value="Tickers_Watchlist" />
					<div id="mainButton">
						<select id="portfolioTicker"
							style="border: 1px solid #b5b5b5;height: 28px;border-radius: 5px;"></select>&nbsp;&nbsp;
						<select class="livesearch" id="filterTicker"
							style="width: 150px;"></select>
							&nbsp;<input type="button" name=""
							class="modalBtnWeekly" value="go" onclick="getHistoryByTicker()" />&nbsp;&nbsp;
						<span id="fileuploadSpan">	 
						<input type="file" name="myfile" style="width: 200px;">

						<button class="modalBtn" onclick="$('#importUploadForm1').submit();">
							<i class="fa fa-upload" aria-hidden="true"></i> Upload
						</button>
						</span>

						&nbsp;&nbsp;&nbsp;&nbsp;

						<button type="button" class="modalBtn"
							onclick="findImportDatesByMonth()">History</button>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<!-- <button class="dt-button buttons-html5" onclick="$('#filter').modal('show');">Calculate</button> -->
						<button type="button" class="modalBtn" data-toggle="modal"
							data-target="#calculateModal">Calculate</button>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="modalBtn" onclick="getTicker()">Performance</button>
						<button type="button" class="modalBtn" onclick="getStockRanking()">Ranking</button>
						<button type="button" class="modalBtn" onclick="getReset()">Reset</button>
					</div>
					<div id="backButton">
						<button type="button" class="modalBtn"
							onclick="findImportDatesByMonth()">History</button>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="modalBtn" onclick="getTicker()">Performance</button>
						<button type="button" class="modalBtn" onclick="getStockRanking()">Ranking</button>
						<button type="button" class="modalBtn">Reset</button>
					</div>
				</div>
			</form>
		</div>




		<!-- <a href="demand" title="" class="float-right viewGraph hvr-push">VIEW ALL GRAPHS</a> -->
		<!--graph section-->

		<br>
		<br>
		<div id="everyThing">
			 <input type="button" name="" class="modalBtnWeekly" value="Grid View"
				style="float: right; margin-right: 10px; margin-bottom: 10px;" onclick="gridViewBond()" />&nbsp;&nbsp;&nbsp;&nbsp;<input
				type="button" name="" class="modalBtnWeekly" style="float: right; margin-right: 10px;"
				value="Chart View" onclick="chartViewBond()"/><br>
			<br>
			<table id="example" class="display" style="width: 100%">
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
		<div id="exampleParentChartDiv" style="display: none">
			<input type="button" name="" class="modalBtnWeekly" value="Grid View"
				style="float: right; margin-right: 10px; margin-bottom: 10px;" onclick="gridViewBond()" />&nbsp;&nbsp;&nbsp;&nbsp;<input
				type="button" name="" class="modalBtnWeekly" style="float: right; margin-right: 10px; margin-bottom: 10px;"
				value="Chart View" onclick="chartViewBond()" /><br>
			<br> Chart View
			<div id="chart7"></div>
		</div>

		<div id="historyByTickerChartDiv" style="display: none">
			<input type="hidden" id="filterTicker" name="filterTicker" value=""/>
			<input type="button" name="" class="modalBtnWeekly" value="Grid View"
				style="float: right; margin-right: 10px; margin-bottom: 10px;" onclick="gridViewBond()" />&nbsp;&nbsp;&nbsp;&nbsp;<input
				type="button" name="" class="modalBtnWeekly" style="float: right; margin-right: 10px; margin-bottom: 10px;"
				value="Chart View" onclick="chartViewBond()" /><br>
			<br> Chart for Rank Within Table
			<div id="chart8"></div>
		</div>
		<div id="stockRankingDiv">
			<div>


				<table id="stockRankingRise" class="display" style="width: 100%">
					<thead>
						<tr>
							<th>Most Risen Stock</th>
							<th>Rank Risen By</th>
							<th>Current Price</th>
							<th>Previous Price</th>

						</tr>
					</thead>
					<tbody id="stockRiseTable">

					</tbody>
				</table>

			</div>
			<br>
			<br>
			<br>


			<div>
				<table id="stockRankingDrop" class="display" style="width: 100%">
					<thead>
						<tr>
							<th>Most Dropped Stock</th>
							<th>Rank Dropped By</th>
							<th>Current Price</th>
							<th>Previous Price</th>
						</tr>
					</thead>
					<tbody id="stockDropTable">

					</tbody>

				</table>







			</div>
		</div>

		<div id="comparedisplay">
			<div class="row">
				<div class="col-sm-6">
					<!-- <div class="container position-relative"> -->

					<table id="exampleRise" class="display" style="width: 100%">
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
					<br>
					<br>
					<div id="bestChartDiv"></div>

				</div>


				<div class="col-sm-6">
					<table id="exampleDrop" class="display" style="width: 100%">
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
					<br>
					<br>
					<div id="worstChartDiv"></div>






				</div>
			</div>
		</div>






	</div>
	</main>
	<!--end main-->



	<!-- The Modal -->
	<div class="modal" id="filter">
		<div class="modal-dialog">
			<div class="modal-content" style="width: 100%">
				<!-- Modal Header -->
				<div class="filter-header">
					<img src="/images/filter-violet.PNG" alt="">
					<h2>Import History - Tickers Watchlist</h2>
					<a href="#" title="" class="close" data-dismiss="modal"><i
						class="fa fa-window-close" aria-hidden="true"></i></a>
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
											<table id="exampleMonths" class="display" style="width: 100%">
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
					<button type="button" class="modalBtn modalBtnCancel"
						data-dismiss="modal">Cancel</button>
					<input type="submit" class="modalBtn" id="vali" name="submit"
						onclick="getImportHistorySheetCompare()" value="Compare" />
				</div>
				</form>
			</div>
		</div>

	</div>
	<!-- end Modal -->


	<!-- The Modal -->
	<div class="modal" id="calculateModal">
		<div class="modal-dialog">
			<div class="modal-content" style="width: 100%;">
				<!-- Modal Header -->
				<div class="filter-header">
					<img src="/images/filter-violet.PNG" alt="">
					<h2>Analysis - Ticket Watchlist</h2>
					<a href="#" title="" class="close" data-dismiss="modal"><i
						class="fa fa-window-close" aria-hidden="true"></i></a>
				</div>
				<!-- Modal body -->
				<div class="filter-body" style="padding: 10px; margin-left: 20px">
					<br>
					<!-- <form action="" method="post"> -->
					<div class="row">
						<div class="col-md-4">
							<div class="filterBlock">
								<div class="selectBox" id="calculateDiv">
									<label>&nbsp;</label> <select id="isHighPerforming">
										<option value="true">Best Performing</option>
										<option value="false">Worst Performing</option>
									</select><br>
									<br>
								</div>
							</div>
						</div>
					</div>
					<div id="bestPerDiv">
					<div class="row">
						<div class="col-sm-4">
							Rank Less Than<input type="text" id="rankWithinTable" name=""
								class="form-control"><br>
							<br>
						</div>
						<div class="col-sm-4">
							<br>(for consecutive 3 weeks)<br>
							<br>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4">
							Relative Strength Greater Than<input type="text" id="relativeStrength" name=""
								class="form-control"><br>
							<br>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4">
							Price Vs 20 Day Average Greater Than<input type="text" id="priceVs20DAvg"
								name="" class="form-control"><br>
							<br>
						</div>
					</div>
					</div>
					
					<div id="worstPerDiv" style="display:none">
					<div class="row">
						<div class="col-sm-4">
							Rank Higher Than<input type="text" id="rankWithinTableW" name=""
								class="form-control"><br>
							<br>
						</div>
						<div class="col-sm-4">
							<br>(for consecutive 3 weeks)<br>
							<br>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4">
							Relative Strength Less Than <input type="text" id="relativeStrengthW" name=""
								class="form-control"><br>
							<br>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4">
							Price Vs 20 Day Average Less Than<input type="text" id="priceVs20DAvgW"
								name="" class="form-control"><br>
							<br>
						</div>
					</div>
					</div>
					<!-- </form> -->
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="modalBtn modalBtnCancel"
						data-dismiss="modal">Cancel</button>
					<input type="button" class="modalBtn" id="vali" name="submit"
						onclick="getCalculateTicker()" value="Compare" />
				</div>
			</div>
		</div>

	</div>
	<!-- end Modal -->
	
	<!-- Modal1 -->
<div class="modal fade" id="modalChartForTicker" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Filter Chart</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="container-fluid">
			<div class="row">
				<div class="col-sm-4">
				
			<div class="">
                
<form>
  <div class="form-group">
    <label for="exampleFormControlSelect1">Start Date</label>
    <select class="form-control" id="chart1FYTicker" >
      <option value="2020" selected>2020</option>	
      <option value="2019" >2019</option>
      <option value="2018">2018</option>
      <option value="2017">2017</option>
      <option value="2016">2016</option>
    </select>
  </div>
  <div class="form-group">
    <label for="exampleFormControlSelect2">End Date</label>
    <select class="form-control" id="chart2FYTicker">
	  <option value="2020" selected>2020</option>	
      <option value="2019">2019</option>
      <option value="2018">2018</option>
      <option value="2017">2017</option>
      <option value="2016">2016</option>
    </select>
  </div> 
  <button type="button" class="btn btn-primary" onclick="loadchartForTicker()">Apply</button>
</form>
			</div>				
				</div>
				<div class="col-sm-8">
				</div>
			</div>
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
      </div>
    </div>
  </div>
</div>
<!-- !Modal1 -->




</body>
</html>
