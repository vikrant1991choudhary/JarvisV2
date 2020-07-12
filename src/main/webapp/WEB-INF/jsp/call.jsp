<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Jarvis</title>
<link href="favicon.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="/css/font-awesome.min.css" type="text/css">
<link
	ref="https://fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,500,700,700i,900"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
<link rel="stylesheet"
	href="https://cdn.datatables.net/buttons/1.5.6/css/buttons.dataTables.min.css">
<link rel="stylesheet" href="/css/style.css" type="text/css">
<link
	href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.5.1/chosen.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script
	src="https://cdn.datatables.net/buttons/1.5.6/js/dataTables.buttons.min.js"></script>
<script
	src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.flash.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script
	src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.html5.min.js"></script>
<script
	src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.print.min.js"></script>
<script src="/js/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/popper.min.js" type="text/javascript"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.5/jspdf.debug.js"
	type="text/javascript"></script>
<script src="/js/custom.js" type="text/javascript"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.5.1/chosen.jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(document).ready(function(){
		var arr = [];
		$("#expirationDate").datepicker();
		$("#historybtn").click(function(){
			var tickerName=$("#tickerName").val();
			$.ajax({
		   		url:"/JarvisV2/findAllCallsByTickerName",
		   		data: {
		   			tickername:tickerName
			   	},
			   	async:false,
		   		type : "GET",
		   		dataType: "json",
		   		success: function(result){	
			   		console.log(result);				
		   			$("#example").dataTable().fnDestroy();
		   			$('#example').DataTable( {
		   				responsive: true,
		               	dom: 'Bfrtip',
		                   buttons: [
		                	   'print',

		                   	   {
		                   		extend: 'excelHtml5',
		                   		exportOptions: {
		                   			columns: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ]
		                           }
		                       },
		                       {
		                   		extend: 'pdfHtml5',
		                   		exportOptions: {
		                               columns: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ]
		                           }
		                       }
		                   ],
			   		    'processing': true,
			   	        'language': {
			   	            'loadingRecords': '&nbsp;',
			   	            'processing': '<img src="/images/loading.gif">'
			   	        },                
		   				data: result,
		   				columns: [
		   					{ data: "stockNameTicker" },
		   					{ data: "stockPrice" },
		   					{ data: "strikePrice" },
		   					{ data: "callPrice" },
		   					{ data: "expirationDate" },
		   					{ data: "daysExpiration" },
		   					{ data: "reqIncrease" },
		   					{ data: "breakEven" },
		   					{ data: "percentage" },
		   					{ data: "leverageRatio" },
		   					{ data: "costofTenCalls"},
		   					{ data: "rank"},
		   					{ data: "lastUpdatedAt" },
		   					{ data: "idCall",
		   						mRender: function(data,type,full){
		   							return '<button type="button" class="close" aria-label="Close" onclick=deleteTicker("'+full["idCall"]+'")><span aria-hidden="true">&times;</span></button>';
		   						}
	   						}
		   					
		   					
		   				]
		   				,"columnDefs":[{
		   	                 "targets":12,//column index
		   	                 "data":"",
		   	                 "render":function(data,type,row){
		   	                  var res = data.substring(0, 10);
		   	                 
		   	  				  return res;
		   	              }
		   	             }]
		   			} );
		   			
		   		},
		   		error: function(){
		   			alert("Error loading data");
		   		}
		   	});
			
			 $('#examplediv').show();
			 	$('#exampledate').hide();
			 	$('#exampleTickerChartDiv').hide();
			 	$('#exampleDateChartDiv').hide();
			 	$('#examplebtn').hide();
		});
		$("#gobtn").click(function(){
			var date=$("#dateschooser").val();
			$.ajax({
		   		url:"/JarvisV2/findCallDataByDate",
		   		data: {
		   			date:date
			   	},
			   	async:false,
		   		type : "GET",
		   		dataType: "json",
		   		success: function(result){	
			   		console.log(result);				
		   			$("#example1").dataTable().fnDestroy();
		   			$('#example1').DataTable( {
		   				responsive: true,
		               	dom: 'Bfrtip',
		                   buttons: [
		                	   'print',

		                   	   {
		                   		extend: 'excelHtml5',
		                   		exportOptions: {
		                   			columns: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ]
		                           }
		                       },
		                       {
		                   		extend: 'pdfHtml5',
		                   		exportOptions: {
		                               columns: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ]
		                           }
		                       }
		                   ],
		                   'processing': true,
				   	        'language': {
				   	            'loadingRecords': '&nbsp;',
				   	            'processing': '<img src="/images/loading.gif">'
				   	        },
		   				data: result,
		   				columns: [
		   					{ data: "stockNameTicker" },
		   					{ data: "stockPrice" },
		   					{ data: "strikePrice" },
		   					{ data: "callPrice" },
		   					{ data: "expirationDate" },
		   					{ data: "daysExpiration" },
		   					{ data: "reqIncrease" },
		   					{ data: "breakEven" },
		   					{ data: "percentage" },
		   					{ data: "leverageRatio" },
		   					{ data: "costofTenCalls"},
		   					{ data: "rank"},
		   					{ data: "lastUpdatedAt" },
		   					{ data: "idCall",
		   						mRender: function(data,type,full){
		   							return '<button type="button" class="close" aria-label="Close" onclick=deleteTicker("'+full["idCall"]+'")><span aria-hidden="true">&times;</span></button>';
		   						}
	   						}
		   					
		   					
		   				]
			   			,"columnDefs":[{
		   	                 "targets":12,//column index
		   	                 "data":"",
		   	                 "render":function(data,type,row){
		   	                  var res = data.substring(0, 10);
		   	                 
		   	  				  return res;
		   	              }
		   	             }]
		   			} );
		   			
		   		},
		   		error: function(){
		   			alert("Error loading data");
		   		}
		   	});
			
				$('#examplediv').hide();
			 	$('#exampledate').show();
			 	$('#exampleTickerChartDiv').hide();
			 	$('#exampleDateChartDiv').hide();
			 	$('#examplebtn').hide();
		});
		$("#resetBtn").click(function(){
			$('#equictntbl').dataTable().fnClearTable();
		    $('#equictntbl').dataTable().fnDestroy();
		});
		
		$("#addBtn").click(function(){
			var tickername = $("#tickerName").val();
			var strikeprice = $("#callstrikeprice").val();
			var callprice = $("#callprice").val();
			var expdate = $("#expirationDate").val();
			var tabledata = "";
			
			//alert(tickername+" "+strikeprice+" "+callprice+" "+expdate);
			$.ajax({
		   		url:"/JarvisV2/getCalculatedData",
		   		data: {
		   			tickername: tickername,
		   			strikeprice: strikeprice,
		   			callprice: callprice,
		   			expdate: expdate
			   	},
			   	async:false,
		   		type : "POST",
		   		dataType: "json",
		   		success: function(data){
			   		arr.push(data);
					console.log(arr);
					var res=data.stockPrice;
					var stockPrice=(Math.round(res * 100) / 100).toFixed(2);
					var res1=data.reqIncrease;
					var reqIncrease=(Math.round(res1 * 100) / 100).toFixed(2);
					var res2=data.percentage;
					var percentage=(Math.round(res2 * 100) / 100).toFixed(2);	
					var res3=data.leverageRatio;
					var leverageRatio=(Math.round(res3 * 100) / 100).toFixed(2);	
					var res4=data.costofTenCalls;
					var costofTenCalls=(Math.round(res4 * 100) / 100).toFixed(2);
					var res5=data.lastUpdatedAt;
					//console.log("res5"+res5);
					var lastUpdatedAt= res5.substring(0,10);
					tabledata = tabledata + "<tr>";
					tabledata = tabledata + "<td>" + data.stockNameTicker + "</td>";
					tabledata = tabledata + "<td>" + stockPrice + "</td>";
					tabledata = tabledata + "<td>" + data.strikePrice + "</td>";
					tabledata = tabledata + "<td>" + data.callPrice + "</td>";
					tabledata = tabledata + "<td>" + data.expirationDate + "</td>";
					tabledata = tabledata + "<td>" + data.daysExpiration + "</td>";
					tabledata = tabledata + "<td>" + reqIncrease + "</td>";
					tabledata = tabledata + "<td>" + data.breakEven + "</td>";
					tabledata = tabledata + "<td>" + percentage + "</td>";
					tabledata = tabledata + "<td>" + leverageRatio + "</td>";
					/* tabledata = tabledata + "<td>" + data.lastUpdatedAt + "</td>"; */
					tabledata = tabledata + "<td>" + costofTenCalls + "</td>";
					tabledata = tabledata + "<td>" + data.rank+ "</td>";
					tabledata = tabledata + "<td>" + lastUpdatedAt + "</td>";
					tabledata = tabledata + "</tr>";

					$("#callTablebody").append(tabledata);				
			   	}
		});
			$('#examplediv').hide();
		 	$('#exampledate').hide();
		 	$('#exampleTickerChartDiv').hide();
			$('#exampleDateChartDiv').hide();
		 	$('#examplebtn').show();

	});

	$("#savebtn").click(function(){
		console.log(arr);
		$.ajax({
	   		url:"/JarvisV2/saveCalls",
	   		data: JSON.stringify( arr ),
	   		contentType: "application/json; charset=utf-8",
		   	async:false,
	   		type : "POST",
	   		dataType: "json",
	   		success: function(data){
		   		console.log(data);				
		   	}
		});
	});
		getAllTicker();
		getAllDates()
	});

	function getAllTicker(){
		var metadataName="Tickers_Watchlist";
    	$.ajax({
	    	url: "/JarvisV2/getAllTicker",
			type : "GET",
			async : false,
			cache : false,
			data : {
				metadataName:metadataName
			},
			dataType : "json",
			success : function(data) {
				//  alert("getAllTicker"+data);
				var html = "<option value=''>--Select Ticker--</option> ";
				for (var i = 0; i < data.length; i++) {
					html = html + "<option value='" + data[i].element1 + "'>"
							+ data[i].element1 + "</option>";
				}
				$("#tickerName").html(html);
				$(".livesearch").chosen();
			},
			error : function(e) {
				alert('Error in getColumns: ' + e);
			}

		});
	}

	function getAllDates(){
    	$.ajax({
	    	url: "/JarvisV2/findAllDates",
			type : "GET",
			async : false,
			cache : false,
			dataType : "json",
			success : function(data) {
				console.log(data[0]);
				var html = "<option value=''>--Select Date--</option> ";
				for (var i = 0; i < data.length; i++) {
					html = html + "<option value='"+data[i]+"'>"
							+ data[i] + "</option>";
				}
				$("#dateschooser").html(html);
				//$(".livesearch").chosen();
			},
			error : function(e) {
				alert('Error in getColumns: ' + e);
			}

		});
	}
	
	<!--Vikrant Start -->
	
	function chartViewBond() {

		var ticker = escape($("#tickerName>option:selected").val());
		//var date = $("#dateschooser").val();
		

		if (ticker == null || ticker == '' || ticker === undefined) {
			//alert("ticker"+ticker);
			$('#examplediv').show();
			$('#exampledate').hide();
    		
			alert("Please Select Ticker");
	
		}else{
			loadChart();
			
			$('#exampleTickerChartDiv').show();
			$('#examplediv').hide();
			$('#exampledate').hide();
		}
		
	}
	 function chartViewDate(){
		 var date = $("#dateschooser").val();

			if (date == null || date == '' || date === undefined) {
				alert("date"+date);
				$('#examplediv').hide();
				$('#exampledate').show();
	    		
				alert("Please Select Date");
			
			}else{
				loadChartDate();
				
				$('#exampleDateChartDiv').show();
				$('#examplediv').hide();
				$('#exampledate').hide();
			}
		 
	 }
	function gridViewDate(){
		var date = $("#dateschooser").val();

		if (date == null || date == '' || date === undefined) {
			$('#examplediv').hide();
			$('#exampleTickerChartDiv').hide();
			$('#exampleDateChartDiv').hide();
			$('#exampledate').show();
		}else{
			$('#exampledate').show();
			$('#exampleTickerChartDiv').hide();
			$('#exampleDateChartDiv').hide();
			$('#examplediv').hide();
		}
		 
	 }
	
	function loadChartDate(){
		var Price = new Array();
		var Date = new Array();
		
		var date = $("#dateschooser").val();
		
		console.log("date"+date);
		jQuery.ajax({
	    	url: '<%=request.getContextPath()%>/JarvisV2/findCallDataByDate',
	           type: "GET",
	           async:false,
	           cache: false,
	           data: "date="+date,
	           dataType: "json",
	           success: function(data) {

				// alert("Success");
				var tabHTML = "";
				for (var i = 0; i < data.length; i++) {
					var res5=data[i].lastUpdatedAt;
					var lastUpdatedAt= res5.substring(0,10);

					Price.push(data[i].callPrice);
					Date.push(lastUpdatedAt);

				}
				console.log("Price="+Price);
				console.log("Date="+Date);
			},
			error : function(e) {
				alert('Error:' + e);
			}
		});

		 
		Highcharts.chart('chart8', {

			title : {
				text : ''
			},

			subtitle : {
				text : ''
			},

			xAxis : {
				title : {
					text : 'Date'
				},
				categories : Date,
			},
			yAxis : {
				title : {
					text : ''
				}
			},

			legend : {
				layout : 'vertical',
				align : 'right',
				verticalAlign : 'middle'
			},

			plotOptions : {
				line : {
					dataLabels : {
						enabled : true
					},
					enableMouseTracking : false
				}
			},
			tooltip : {
				formatter : function() {
					return '<b>' + this.x + '</b><br/>' + this.series.name
							+ ': ' + this.y + '<br/>' + 'Total: '
							+ this.point.stackTotal;
				}
			},
			series : [ {
				name : 'Price',
				data : JSON.parse("[" + Price + "]")
			} ]

		});
		
	}
	
	function loadChart() {

		var Price = new Array();
		var date = new Array();
		
		var tickername = $("#tickerName>option:selected").val();
		
		console.log("tickername"+tickername);
		jQuery.ajax({
	    	url: '<%=request.getContextPath()%>/JarvisV2/findAllCallsByTickerName',
	           type: "GET",
	           async:false,
	           cache: false,
	           data: "tickername="+tickername,
	           dataType: "json",
	           success: function(data) {

				// alert("Success");
				var tabHTML = "";
				for (var i = 0; i < data.length; i++) {
					var res5=data[i].lastUpdatedAt;
					var lastUpdatedAt= res5.substring(0,10);

					Price.push(data[i].callPrice);
					date.push(lastUpdatedAt);

				}
				console.log("Price="+Price);
				console.log("Date="+date);
			},
			error : function(e) {
				alert('Error:' + e);
			}
		});

		 Highcharts.chart('chart7', {

			chart : {
				type : 'column'
			},
			title : {
				text : ''
			},

			subtitle : {
				text : ''
			},

			xAxis : {
				title : {
					text : 'Date'
				},
				categories : date,
			},
			yAxis : {
				title : {
					text : 'Price'
				}
			},

			legend : {
				layout : 'vertical',
				align : 'right',
				verticalAlign : 'middle'
			},

			plotOptions : {
				line : {
					dataLabels : {
						enabled : true
					},
					enableMouseTracking : false
				}
			},

			series : [ {
				name : 'Price',
				data : JSON.parse("[" + Price + "]")
			} ]

		});
 
	}

	function gridViewBond() {
		var ticker = escape($("#tickerName>option:selected").val());
		//var date = $("#dateschooser").val();

		if (ticker == null || ticker == '' || ticker === undefined) {
			$('#examplediv').show();
			$('#exampleTickerChartDiv').hide();
			$('#exampleDateChartDiv').hide();
		}else{
			$('#examplediv').show();
			$('#exampleTickerChartDiv').hide();
			$('#exampleDateChartDiv').hide();
		}
		
	}
	
	<!--- Vikrant End -->
	
	
	
	
	
	

	function deleteTicker(tickerid){
		$("#confirmModal").show();
		$("#btnNo").click(function(){
			$("#confirmModal").hide();
		});
		$("#btnYes").click(function(){
			alert("Delete");
			$("#confirmModal").hide();
		});
	}
</script>
<style>
html, body {
	max-width: 100%;
	overflow-x: hidden;
}
</style>

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
					<li>&nbsp;</li>
				</ul>
			</div>
		</div>
	</nav>
	<!--end navigation-->


	<!--main-->
	<main class="h100">
		<div class="container-fluid position-relative">

			<!-- <a href="demand" title="" class="float-right viewGraph hvr-push">VIEW ALL GRAPHS</a> -->
			<!--graph section-->
			<div class="row">
				<div class="col-sm-3">
					Ticker <br><select class="livesearch form-control" id="tickerName"
						style="width: 200px;font-size:12px"></select>
					&nbsp;&nbsp;&nbsp;	
					<button type="button" class="modalBtn" id="historybtn">History</button>
				</div>
				<div class="col-sm-2">
					Call Strike Price <input type="text" name="name" value=""
						class="form-control" id="callstrikeprice" style="height: 26px; font-size:12px"/>
				</div>
				<div class="col-sm-2">
					Call Price <input type="text" name="name" value=""
						class="form-control" id="callprice" style="height: 26px; font-size:12px"/>
				</div>
				<div class="col-sm-2">
					Expiration Date <input type="text" name="expirationDate"
						id="expirationDate" class="form-control" style="height: 26px; font-size:12px"/>
				</div>
				<div class="col-sm-3">
					<br>
					<button type="button" class="modalBtn" id="addBtn">Add</button>
					&nbsp;&nbsp;&nbsp;
					<button type="button" class="modalBtn" id="savebtn">Save</button>
					&nbsp;&nbsp;&nbsp;
					<button type="button" class="modalBtn" id="resetBtn">Reset</button>
				</div>
			</div>
			<br>
			<!-- <div class="row">
				<div class="col-sm-12">
					<button type="button" class="modalBtn" id="addBtn">Add</button>
					&nbsp;&nbsp;&nbsp;
					<button type="button" class="modalBtn" id="historybtn">History</button>
					&nbsp;&nbsp;&nbsp;
					<button type="button" class="modalBtn" id="resetBtn">Reset</button>
				</div>
			</div> -->
			<br>
			<div class="row">
				<div class="col-sm-2">
					<select id="dateschooser" class="form-control"
						style="width: 200px; height: calc(1.75rem + 2px); font-size:12px"></select>
				</div>
				
				<div class="col-sm-2">
					<button type="button" class="modalBtn" id="gobtn">Go</button>
				</div>
			</div>
			<br>
			<div id="examplediv" style="overflow-x: auto;">
				<input type="button" name="" class="modalBtnWeekly" value="Grid View"
				style="float: right; margin-right: 10px; margin-bottom: 10px;" onclick="gridViewBond()" />&nbsp;&nbsp;&nbsp;&nbsp;<input
				type="button" name="" class="modalBtnWeekly" style="float: right; margin-right: 10px;"
				value="Chart View" onclick="chartViewBond()"/><br>
			<br>
				<table id="example" class="display" style="width: 100%">
					<thead>
						<tr>
							<th>StockName Ticker</th>
							<th>CurrentStock Price</th>
							<th>CallStrike Price</th>
							<th>Call Price</th>
							<th>Expiration Date</th>
							<th>Days To Expire</th>
							<th>Required Increase(%)</th>
							<th>Break Even</th>
							<th>Percentage(%)</th>
							<th>Leverage Ratio</th>
							<th>Cost Of 10 Calls</th>
							<th>Rank</th>
							<th>Date</th>
							<th>Action</th>

						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
			</div>
			<div id="exampledate" style="overflow-x: auto;display: none;" >
				<input type="button" name="" class="modalBtnWeekly" value="Grid View"
				style="float: right; margin-right: 10px; margin-bottom: 10px;" onclick="gridViewDate()" />&nbsp;&nbsp;&nbsp;&nbsp;<input
				type="button" name="" class="modalBtnWeekly" style="float: right; margin-right: 10px;"
				value="Chart View" onclick="chartViewDate()"/><br>
			<br>
				<table id="example1" class="display" style="width: 100%">
					<thead>
						<tr>
							<th>StockName Ticker</th>
							<th>CurrentStock Price</th>
							<th>CallStrike Price</th>
							<th>Call Price</th>
							<th>Expiration Date</th>
							<th>Days To Expire</th>
							<th>Required Increase(%)</th>
							<th>Break Even</th>
							<th>Percentage(%)</th>
							<th>Leverage Ratio</th>
							<th>Cost Of 10 Calls</th>
							<th>Rank</th>
							<th>Date</th>
							<th>Action</th>

						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
			</div>
			<div id="examplebtn" style="overflow-x: auto;display: none;" >
				
				<table id="example2" class="display" style="width: 100%">
					<thead>
						<tr>
							<th>StockName Ticker</th>
							<th>CurrentStock Price</th>
							<th>CallStrike Price</th>
							<th>Call Price</th>
							<th>Expiration Date</th>
							<th>Days To Expire</th>
							<th>Required Increase(%)</th>
							<th>Break Even</th>
							<th>Percentage(%)</th>
							<th>Leverage Ratio</th>
							<th>Cost Of 10 Calls</th>
							<th>Rank</th>
							<th>Date</th>
							<th>Action</th>

						</tr>
					</thead>
					<tbody id="callTablebody">

					</tbody>
				</table>
			</div>
			<div id="exampleTickerChartDiv" style="display: none">
			<input type="button" name="" class="modalBtnWeekly" value="Grid View"
				style="float: right; margin-right: 10px; margin-bottom: 10px;" onclick="gridViewBond()" />&nbsp;&nbsp;&nbsp;&nbsp;<input
				type="button" name="" class="modalBtnWeekly" style="float: right; margin-right: 10px; margin-bottom: 10px;"
				value="Chart View" onclick="chartViewBond()" /><br>
			<br> Chart View For History Wise Ticker
			<div id="chart7"></div>
		</div>

		<div id="exampleDateChartDiv" style="display: none">
			
			<input type="button" name="" class="modalBtnWeekly" value="Grid View"
				style="float: right; margin-right: 10px; margin-bottom: 10px;" onclick="gridViewDate()" />&nbsp;&nbsp;&nbsp;&nbsp;<input
				type="button" name="" class="modalBtnWeekly" style="float: right; margin-right: 10px; margin-bottom: 10px;"
				value="Chart View" onclick="chartViewDate()" /><br>
			<br> Chart View For Date Wise Ticker
			<div id="chart8"></div>
		</div>
			
			
			
		</div>
	</main>
	<!--end main-->



	<!-- The Modal -->
	<div class="modal" id="filter">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="filter-header">
					<img src="/images/filter-violet.PNG" alt="">
					<h2>Filter</h2>
					<a href="#" title="" class="close" data-dismiss="modal"><i
						class="fa fa-window-close" aria-hidden="true"></i></a>
				</div>

				<!-- Modal body -->
				<div class="filter-body">
					<form action="" method="post">
						<div class="row">
							<div class="col-md-12 innerFilBlock">

								<div class="row">
									<div class="col-md-4">
										<div class="filterBlock singleselect">
											<label>Location</label> <select name="location">

												<option value="India">India</option>
												<option value="Europe">Europe</option>
												<option value="USA">USA</option>
												<option value="Malaysia">Malaysia</option>
												<option value="Middle East">Middle East</option>
												<option value="Singapore">Singapore</option>
											</select>
										</div>
									</div>
									<div class="col-md-4">
										<div class="filterBlock">
											<div class="dateCalender">
												<label>Start Date</label> <input type="date"
													name="startdate">
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="filterBlock">
											<div class="dateCalender">
												<label>End Date</label><input type="date" name="enddate">
											</div>
										</div>
									</div>

								</div>

							</div>
						</div>

						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="button" class="modalBtn modalBtnCancel"
								data-dismiss="modal">Cancel</button>
							<input type="submit" class="modalBtn" id="vali" name="submit"
								value="submit" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- end Modal -->


	<!-- Confirm Modal -->
	<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<!-- <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div> -->
				<div class="modal-body">Do you want to delete?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal" id="btnNo">No</button>
					<button type="button" class="btn btn-primary" id="btnYes">Yes</button>
				</div>
			</div>
		</div>
	</div>
	<!-- End Confirm modal -->
</body>

</html>
