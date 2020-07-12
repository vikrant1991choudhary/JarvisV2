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
	href="https://fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,500,700,700i,900"
	rel="stylesheet">
<!-- <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> -->
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
<link rel="stylesheet"
	href="https://cdn.datatables.net/buttons/1.5.6/css/buttons.dataTables.min.css">
<link rel="stylesheet" href="/css/style.css" type="text/css">
<link
	href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css"
	rel="stylesheet" type="text/css" />
<style>
html, body {
	max-width: 100%;
	overflow-x: hidden;
}
tr:hover{
	cursor:pointer;
}
</style>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	crossorigin="anonymous"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
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

<!-- Custom Script -->
<script>

  
	$(document).ready(function() {
	//	alert("userid"+userid);
		getAllStockData();
		var arr = [];
		$("#expirationDate").datepicker();
		var userid = $('#userid').val();
		var stocktable = $('#stocktable');
		var fabstocktable = $('#favstock');
		var bondtable = $('#bondtable');
		var fabbondtable = $('#favbond');
		
		stocktable.on('click', 'tbody tr', function() {
			 var $row = $(this);
			 var addRow = stocktable.DataTable().row($row);
			 fabstocktable.DataTable().row.add(addRow.data()).draw();
			 arr.push(addRow.data());
			 console.log(addRow.data());
			 //addRow.remove().draw();
		});

		/* fabstocktable.on('click', 'tbody tr', function() {
			 var $row = $(this);
			 var addRow = fabstocktable.DataTable().row($row);
			 addRow.remove().draw();
		}); */

		bondtable.on('click', 'tbody tr', function() {
			 var $row = $(this);
			 var addRow = bondtable.DataTable().row($row);
			 fabbondtable.DataTable().row.add(addRow.data()).draw();
			 //addRow.remove().draw();
		});

		/* fabbondtable.on('click', 'tbody tr', function() {
			 var $row = $(this);
			 var addRow = fabbondtable.DataTable().row($row);
			 addRow.remove().draw();
		}); */

		$('#updateBtn').click(function(){
			console.log(arr);
			$.ajax({
		   		url:"/JarvisV2/saveFavStock?userid="+userid,
		   		data: JSON.stringify(arr),
		   		contentType: "application/json; charset=utf-8",
			   	async:false,
		   		type : "POST",
		   		dataType: "json",
		   		success: function(data){
			   		console.log(data);				
			   	}
			});
		});
	});

	

	$("#helpBtn").click(function() {
		$(".helpContent").slideToggle();
	});
	
	
	 
	  function createPortfolio(){
		  var stockNames = new Array();
		  
		  var oTable =  $('#exampleCreatePortFolio').DataTable();
		  
		  oTable.$('td > input:checkbox').each(function () {
	           
	            if (this.checked) {
	             
	               // alert($(this).val());
	                stockNames.push($(this).val());
	            }
	    }); 
	  	
	  	
	  		var name = $("#portFolioName").val();
	  		
	  		 jQuery.ajax({
			    	url: '<%=request.getContextPath()%>/JarvisV2/createPortfolio?name='+name,
			           type: "POST",
			           async:false,
			           cache: false,
			           data: {
			               myArray: stockNames 
		    },
			           dataType: "json",
			           success: function(data) {
			        	   alert(data.msg);
		        	 
						
			           },
			           error: function(e){				           
		           	        alert('Error in PortFolio: ' + e);		           	
		           	    }

		       });
	  		 
	  		$('#createPortFilter').modal('hide');
	  }
	  
	  function getAllPortfolio(){
			
			var url = '<%=request.getContextPath()%>/JarvisV2/getAllPortfolio';
			
			var oTable =  $('#exampleSavePortFolio').DataTable();
			oTable.destroy();
			var oTable =  $('#exampleSavePortFolio').dataTable( {
				aaSorting: [[1, 'desc']],
			        "ajax": {
			            "url": url,
			            "dataSrc": ""
			        },
			        "columns": [
						{ "data": "name" },
						{ "data": "ticker" }
						
						
			  ],
			  
			  "scrollX": true,
			  "dom": 'frtip ', //"dom": 'frtip',
			//  "bFilter": false,
			 // "buttons": ['copy', 'csv', 'excel', 'pdf', 'print'],
			 
			  "pagingType": "full",
			  "language": {
			      "paginate": {
			        "previous": "<<",
			        "next": ">>"
			      }
			    }
			 } );
			$('#createPortFilter').modal('show');
			
		
			
			
	}
	  
	  function getAllStocksForPolio(){
			
			var url = '<%=request.getContextPath()%>/JarvisV2/getAllStocksForPolio';
			
			var oTable =  $('#exampleCreatePortFolio').DataTable();
			oTable.destroy();
			var oTable =  $('#exampleCreatePortFolio').dataTable( {
				aaSorting: [[1, 'desc']],
			        "ajax": {
			            "url": url,
			            "dataSrc": ""
			        },
			        "columns": [
						{ "data": "checkBoxHtml" },
						{ "data": "stockName" }
						
						
			  ],
			  "lengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]], 
			  "scrollX": true,
			  "dom": 'frtip', //'frtip',
			//  "bFilter": false,
			 // "buttons": ['copy', 'csv', 'excel', 'pdf', 'print'],
			 
			  "pagingType": "full",
			  "language": {
			      "paginate": {
			        "previous": "<<",
			        "next": ">>"
			      }
			    }
			 } );
			getAllPortfolio();
			$('#createPortFilter').modal('show');
			
			/* console.log("delay for 5 sec...");
			var delayInMilliseconds = 5000;
			setTimeout(function() {
				// delay
				$('#letsSelect').click();
			}, delayInMilliseconds); */
			
			
	  }
	  

	function changePassword() {
		var newPassword = $("#newPassword").val();
		var confirmPassword = $("#confirmPassword").val();
		var userEmail = $('#useremail').val();
		if (newPassword == null || newPassword == ''
				|| newPassword === undefined) {
			alert("Please Enter New Password");
			return true;
		}
		if (newPassword != confirmPassword) {
			alert("New Password and Confirm Password are not same.");
			return true;
		}

		jQuery.ajax({
			url : '/JarvisV2/changePassword',
			type : "POST",
			async : false,
			cache : false,
			data : {
				userEmail : userEmail,
				newPassword : newPassword
			},
			dataType : "json",
			success : function(data) {
				console.log(data.msg);
				if (data.msg == "Password Change successfully")
					alert(data.msg);
				else
					alert(data.msg);
			},
			error : function(e) {
				//alert('Error in getColumns: ' + e);		           	
			}

		});

		$('#changePasswordModal').modal('hide');
	}
	function addTicker() {
		var tickerName = $("#tickerName").val();
		var company = $("#company").val();
		var sector = $("#sector").val();
		var industry = $("#industry").val();
		var country = $("#country").val();
		var marketCap = $("#marketCap").val();

		if (tickerName == null || tickerName == '' || tickerName === undefined) {
			alert("Please Enter Ticker Name");
			return true;
		}

		jQuery.ajax({
			   url : '<%=request.getContextPath()%>/JarvisV2/addTicker',
	           type: "POST",
	           async:false,
	           cache: false,
	           data: "tickerName="+tickerName+"&company="+company+"&sector="+sector+"&industry="+industry+"&country="+country+"&marketCap="+marketCap,
	           dataType: "json",
	           success: function(data) {
	        	   console.log(data.msg);
	        	   if(data.msg == "Stock already exits.")
        	    	   alert(data.msg);
        	       else
        	    	   alert(data.msg); 
				   },
				   error: function(e){				           
					//alert('Error in getColumns: ' + e);		           	
				    }

			}); 
	  
	  $('#addTickerModal').modal('hide');
  }
	
	function getAllStockData(){
		var userid = $('#userid').val();
		//alert(userid);
		$.ajax({
	   		url:"/JarvisV2/findAllStocks",
		   	//async:false,
	   		type : "GET",
	   		dataType: "json",
	   		success: function(result){	
		   		console.log(result);				
	   			$('#stocktable').dataTable().fnDestroy();
	   			stocktable = $('#stocktable').DataTable({
	   				responsive: true,
	               	/* dom: 'Bfrtip',
	                   buttons: [
	                	   'print',

	                   	   {
	                   		extend: 'excelHtml5',
	                   		exportOptions: {
	                   			columns: [ 0, 1, 2, 3, 4, 5]
	                           }
	                       },
	                       {
	                   		extend: 'pdfHtml5',
	                   		exportOptions: {
	                               columns: [ 0, 1, 2, 3, 4, 5]
	                           }
	                       }
	                   ],
		   		    'processing': true,
		   	        'language': {
		   	            'loadingRecords': '&nbsp;',
		   	            'processing': '<img src="/images/loading.gif">'
		   	        }, */                
	   				data: result,
	   				columns: [
	   					{ data: "stockName" },
	   					{ data: "company" },
	   					{ data: "sector" },
	   					{ data: "industry" },
	   					{ data: "country" },
	   					{ data: "marketCapital" }
	   					
	   				]
	   			});
	   			
	   		},
	   		error: function(){
	   			alert("Error loading data");
	   		}
	   	});
		$.ajax({
	   		url:"/JarvisV2/findAllFavoriteStocks",
	   		data:{
	   			userid:userid
		   	},
		   	//async:false,
	   		type : "GET",
	   		dataType: "json",
	   		success: function(result){	
		   		console.log(result);				
	   			$('#favstock').dataTable().fnDestroy();
	   			$('#favstock').DataTable({
	   				responsive: true,
	               	/* dom: 'Bfrtip',
	                   buttons: [
	                	   'print',

	                   	   {
	                   		extend: 'excelHtml5',
	                   		exportOptions: {
	                   			columns: [ 0, 1, 2, 3, 4, 5]
	                           }
	                       },
	                       {
	                   		extend: 'pdfHtml5',
	                   		exportOptions: {
	                               columns: [ 0, 1, 2, 3, 4, 5]
	                           }
	                       }
	                   ],
		   		    'processing': true,
		   	        'language': {
		   	            'loadingRecords': '&nbsp;',
		   	            'processing': '<img src="/images/loading.gif">'
		   	        },  */               
	   				data: result,
	   				columns: [
	   					
	   					{ data: "stockName" },
	   					{ data: "company" },
	   					{ data: "country" },
	   					{ data: "marketCapital" },
	   					{ data: "avgAnnualPE",
		   					mRender: function(data,type,full){
   								//return '<button type="button" class="close" aria-label="Close" onclick=deleteTicker("'+full["idCall"]+'")><span aria-hidden="true">&times;</span></button>';
   								return '<input type="text" class="form-control" style="padding: 8px; font-size: small; height: 40%;" value="'+full["avgAnnualPE"]+'">';
   							}
   						}			
	   					
	   				]
	   			});
	   			
	   		},
	   		error: function(){
	   			alert("Error loading data");
	   		}
	   	});
		
		$('#stockdiv').show();
		$('#favstockdiv').show();
		$('#bonddiv').hide();
		$('#favbonddiv').hide();
	}
  
 function getDatas(sel){
	var selectedoption = sel.value;
	var userid = $('#userid').val();
	
	//alert("User iD: "+userid);
	if(userid!=null){
		if(selectedoption=="Stocks"){
			$('#stockdiv').show();
			$('#favstockdiv').show();
			$('#bonddiv').hide();
			$('#favbonddiv').hide();
			$.ajax({
		   		url:"/JarvisV2/findAllStocks",
			   	//async:false,
		   		type : "GET",
		   		dataType: "json",
		   		success: function(result){	
			   		console.log(result);				
		   			$('#stocktable').dataTable().fnDestroy();
		   			stocktable = $('#stocktable').DataTable({
		   				responsive: true,
		               	/* dom: 'Bfrtip',
		                   buttons: [
		                	   'print',

		                   	   {
		                   		extend: 'excelHtml5',
		                   		exportOptions: {
		                   			columns: [ 0, 1, 2, 3, 4, 5]
		                           }
		                       },
		                       {
		                   		extend: 'pdfHtml5',
		                   		exportOptions: {
		                               columns: [ 0, 1, 2, 3, 4, 5]
		                           }
		                       }
		                   ],
			   		    'processing': true,
			   	        'language': {
			   	            'loadingRecords': '&nbsp;',
			   	            'processing': '<img src="/images/loading.gif">'
			   	        }, */                
		   				data: result,
		   				columns: [
		   					{ data: "stockName" },
		   					{ data: "company" },
		   					{ data: "sector" },
		   					{ data: "industry" },
		   					{ data: "country" },
		   					{ data: "marketCapital" }
		   					
		   				]
		   			});
		   			
		   		},
		   		error: function(){
		   			alert("Error loading data");
		   		}
		   	});
			$.ajax({
		   		url:"/JarvisV2/findAllFavoriteStocks",
		   		data:{
		   			userid:userid
			   	},
			   	//async:false,
		   		type : "GET",
		   		dataType: "json",
		   		success: function(result){	
			   		console.log(result);				
		   			$('#favstock').dataTable().fnDestroy();
		   			$('#favstock').DataTable({
		   				responsive: true,
		               	/* dom: 'Bfrtip',
		                   buttons: [
		                	   'print',

		                   	   {
		                   		extend: 'excelHtml5',
		                   		exportOptions: {
		                   			columns: [ 0, 1, 2, 3, 4, 5]
		                           }
		                       },
		                       {
		                   		extend: 'pdfHtml5',
		                   		exportOptions: {
		                               columns: [ 0, 1, 2, 3, 4, 5]
		                           }
		                       }
		                   ],
			   		    'processing': true,
			   	        'language': {
			   	            'loadingRecords': '&nbsp;',
			   	            'processing': '<img src="/images/loading.gif">'
			   	        },  */               
		   				data: result,
		   				columns: [
		   					
		   					{ data: "stockName" },
		   					{ data: "company" },
		   					{ data: "country" },
		   					{ data: "marketCapital" },
		   					{ data: "avgAnnualPE",
			   					mRender: function(data,type,full){
	   								//return '<button type="button" class="close" aria-label="Close" onclick=deleteTicker("'+full["idCall"]+'")><span aria-hidden="true">&times;</span></button>';
	   								return '<input type="text" class="form-control" style="padding: 8px; font-size: small; height: 40%;" value="'+full["avgAnnualPE"]+'">';
	   							}
	   						}			
		   					
		   				]
		   			});
		   			
		   		},
		   		error: function(){
		   			alert("Error loading data");
		   		}
		   	});
		}
		else if(selectedoption=="Bonds"){
			$('#stockdiv').hide();
			$('#favstockdiv').hide();
			$('#bonddiv').show();
			$('#favbonddiv').show();
			$.ajax({
		   		url:"/JarvisV2/findAllBonds",
			   	//async:false,
		   		type : "GET",
		   		dataType: "json",
		   		success: function(result){	
			   		console.log(result);				
		   			$('#bondtable').dataTable().fnDestroy();
		   			$('#bondtable').DataTable({
		   				responsive: true,
		               	/* dom: 'Bfrtip',
		                   buttons: [
		                	   'print',

		                   	   {
		                   		extend: 'excelHtml5',
		                   		exportOptions: {
		                   			columns: [ 0, 1, 2, 3, 4]
		                           }
		                       },
		                       {
		                   		extend: 'pdfHtml5',
		                   		exportOptions: {
		                               columns: [ 0, 1, 2, 3, 4]
		                           }
		                       }
		                   ],
			   		    'processing': true,
			   	        'language': {
			   	            'loadingRecords': '&nbsp;',
			   	            'processing': '<img src="/images/loading.gif">'
			   	        },  */               
		   				data: result,
		   				columns: [
		   					{ data: "issuerName" },
		   					{ data: "type" },
		   					{ data: "ytm" },
		   					{ data: "coupon" },
		   					{ data: "maturity" }
		   					
		   				]
		   			});
		   			
		   		},
		   		error: function(){
		   			alert("Error loading data");
		   		}
		   	});
			$.ajax({
		   		url:"/JarvisV2/findAllFavoriteBonds",
		   		data:{
		   			userid:userid
				},
			   	//async:false,
		   		type : "GET",
		   		dataType: "json",
		   		success: function(result){	
			   		console.log(result);				
		   			$('#favbond').dataTable().fnDestroy();
		   			$('#favbond').DataTable({
		   				responsive: true,
		               	/* dom: 'Bfrtip',
		                   buttons: [
		                	   'print',

		                   	   {
		                   		extend: 'excelHtml5',
		                   		exportOptions: {
		                   			columns: [ 0, 1, 2, 3, 4]
		                           }
		                       },
		                       {
		                   		extend: 'pdfHtml5',
		                   		exportOptions: {
		                               columns: [ 0, 1, 2, 3, 4]
		                           }
		                       }
		                   ],
			   		    'processing': true,
			   	        'language': {
			   	            'loadingRecords': '&nbsp;',
			   	            'processing': '<img src="/images/loading.gif">'
			   	        },  */               
		   				data: result,
		   				columns: [
		   					{ data: "issuerName" },
		   					{ data: "type" },
		   					{ data: "ytm" },
		   					{ data: "coupon" },
		   					{ data: "maturity" },
		   					{ data: "cusip", 
		   						mRender: function(data,type,full){
	   								//return '<button type="button" class="close" aria-label="Close" onclick=deleteTicker("'+full["idCall"]+'")><span aria-hidden="true">&times;</span></button>';
	   								return '<input type="text" class="form-control" style="padding: 8px; font-size: small; height: 40%;" value="'+full["cusip"]+'">';
	   							}
							}
		   					
		   				]
		   			});
		   			
		   		},
		   		error: function(){
		   			alert("Error loading data");
		   		}
		   	});
		}
	}
	
 }

 
</script>

</head>
<body>
	<input id="userid" type="hidden" value="<%= session.getAttribute("userID")%>">
	<input type="hidden" id="useremail" value="<%=session.getAttribute("userEmail")%>">
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
	<!-- <nav class="navbar navbar-expand-lg navbar-light bg-light">
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
	</nav> -->
	<!--navigation-->
			<nav class="navbar navbar-expand-lg navbar-light bg-light">
				<div class="container-fluid">
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarNavDropdown">
					<ul class="navbar-nav">
						<li class="nav-item active">
							<a class="nav-link" href="/JarvisV2/admin">Saved Securities</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/JarvisV2/addTicker">Add Ticker</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/JarvisV2/createPortFolio">Create Portfolio</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/JarvisV2/changePassword">Change Password</a>
						</li>
						
						
					</ul>
				</div>
			</div>
			</nav>
			<!--end navigation-->
	<!--end navigation-->

	<!--main-->
	<main class="h100">
		<div class="container-fluid position-relative">
			<div class="row">
				<div class="col-lg-6 col-md-6 col-sm-6">
					<div class="row">
						<div class="col-lg-3 col-md-3 col-sm-3">
							<label>Market Data Type</label><br> <select
								id="marketDataType" name="marketDataType"
								style="padding: 0px; font-size: small; height: 70%;"
								class="form-control" onchange="getDatas(this)">
								<option value="">--Please select--</option>
								<option value="Stocks">Stocks</option>
								<option value="Bonds">Bonds</option>
							</select>
						</div>
						<div class="col-md-4 col-sm-4 col-lg-4">
							<!-- <div class="row">
								<div class="col-lg-8 col-md-8 col-sm-8">
									<label>Search By Symbol</label> <input type="text" name="name"
										value="" class="form-control"
										style="padding: 8px; font-size: small; height: 40%;" />
								</div>
								<div class="col-lg-4 col-md-4 col-sm-4">
									<br>
									<button type="button" class="modalBtn">Reset</button>
								</div>
							</div> -->
						</div>

					</div><br>
					<div class="row" style="display: none" id="stockdiv">
						<div class="col-md-12 col-lg-12 col-sm-12">
							<table id="stocktable" class="display" style="width: 100%" >
								<thead>
									<tr>
										<h5>All Stocks</h5>
										<th>Symbol</th>
										<th>Company Name</th>
										<th>Sector</th>
										<th>Industry</th>
										<th>Country</th>
										<th>Market Capital</th>
										<!-- <th>Action</th> -->
									</tr>
								</thead>
								<tbody>

								</tbody>
							</table>
						</div>
					</div><br>
					<div class="row" style="display: none" id="bonddiv">
						<div class="col-md-12 col-lg-12 col-sm-12">
							<table id="bondtable" class="display" style="width: 100%">
								<thead>
									<tr>
										<h5>All Bonds</h5>
										<th>Issuer Name</th>
										<th>Bond Type</th>
										<th>YTM</th>
										<th>Coupon</th>
										<th>Maturity</th>
									</tr>
								</thead>
								<tbody>

								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-sm-6">
					<div class="row">
						<!-- <div class="col-lg-3 col-md-3 col-sm-3">
							<br>
							<button type="button" class="modalBtn" style="padding: 2px 5px; font-size: small;">Change Password</button>
							<button type="button" class="modalBtn" data-toggle="modal" data-target="#changePasswordModal" style="padding: 10px 10px; font-size: small;">Change Password</button>
						</div>
						<div class="col-lg-3 col-md-3 col-sm-3">
							<br>
							<button type="button" class="modalBtn" onclick="getAllStocksForPolio()" style="padding: 10px 10px; font-size: small;">Create Portfolio</button>
						</div> 
						<div class="col-lg-3 col-md-3 col-sm-3">
							<br>
							<button type="button" class="modalBtn" data-toggle="modal" data-target="#addTickerModal" style="padding: 10px 10px; font-size: small;">Add Tickers</button>
						</div> -->
						<div class="col-lg-3 col-md-3 col-sm-3">
							<br>
							<button type="button" id="updateBtn" class="modalBtn" style="padding: 10px 10px; font-size: small;">Update</button>
							<button type="button" class="modalBtn" style="padding: 10px 10px; font-size: small;">Cancel</button>
						</div>
					</div>
					<div class="row" style="display: none" id="favstockdiv">
						<div class="col-md-12 col-lg-12 col-sm-12">
							<br>
							<table id="favstock" class="display" style="width: 100%">
								<thead>
									<tr>
										<h5>Favourite Stocks(Stocks that you will be follow)</h5>
										<!-- <th>Action</th> -->
										<th>Symbol</th>
										<th>Company Name</th>
										<th>Country</th>
										<th>Market Capital</th>
										<th>Avg Annual P/E</th>
									</tr>
								</thead>
								<tbody>

								</tbody>

							</table>
						</div>
					</div>
					<div class="row" style="display: none" id="favbonddiv">
						<div class="col-md-12 col-lg-12 col-sm-12">
							<br>
							<table id="favbond" class="display" style="width: 100%">
								<thead>
									<tr>
										<h5>Favourite Bonds(Bonds that you will be follow)</h5>
										<th>Issuer Name</th>
										<th>Bond Type</th>
										<th>YTM</th>
										<th>Coupon</th>
										<th>Maturity</th>
										<th>Cusip No</th>


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
	</main>
	<!--end main-->

	<div class="modal" id="addTickerModal">
			<div class="modal-dialog">
			<!--   <form name="bondCalcForm"> -->
				<div class="modal-content" style="width:100%;">
					<!-- Modal Header -->
					<div class="filter-header">
						<img src="/images/filter-violet.PNG" alt="">
						<h2>Add Ticker</h2>
						<a href="#" title="" class="close" data-dismiss="modal"><i class="fa fa-window-close" aria-hidden="true"></i></a>
					</div>
					<!-- Modal body -->
					<div class="modal-body">
			          <form action="" method="post">
							<div class="row">
							  <div class="col-md-6">
							<div class="filterBlock">
							                      <div class="selectBox">
							                       <!-- <label>&nbsp;</label> -->            
							       Ticker Name<input type="text" name="" id="tickerName" class="form-control"><br><br>
							        </div>
							        </div>
							        </div>
							       <div class="col-md-6">
							<div class="filterBlock">
							                      <div class="selectBox">
							                       <!-- <label>&nbsp;</label> -->            
							       Company<input type="text" name="" id="company" class="form-control"><br><br>
							        </div>
							        </div>
							        </div>
							        </div>
							         <div class="row">
									 <div class="col-md-6">
							<div class="filterBlock">
							                      <div class="selectBox">
							                       <!-- <label>&nbsp;</label> -->            
							       Sector<input type="text" name="" id="sector" class="form-control"><br><br>
							        </div>
							        </div>
							        </div>
							       <div class="col-md-6">
							<div class="filterBlock">
							                      <div class="selectBox">
							                       <!-- <label>&nbsp;</label> -->            
							       Industry<input type="text" name="" id="industry" class="form-control"><br><br>
							        </div>
							        </div>
							        </div>
							        </div>
							        
							        <div class="row">
								<div class="col-md-6">
							<div class="filterBlock">
							                      <div class="selectBox">
							                       <!-- <label>&nbsp;</label> -->            
							       Country<input type="text" name="" id="country" class="form-control"><br><br>
							        </div>
							        </div>
							        </div>
							       <div class="col-md-6">
							<div class="filterBlock">
							                      <div class="selectBox">
							                       <!-- <label>&nbsp;</label> -->            
							       Market Cap<input type="text" name="" id="marketCap" class="form-control"><br><br>
							        </div>
							        </div>
							        </div>
							
							        </div>
							<!-- </form> -->
							        </div>
					
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="modalBtn" onclick="addTicker()" >Add</button>
						<button type="button" class="modalBtn modalBtnCancel" data-dismiss="modal">Cancel</button>
						<!-- <input type="button" class="modalBtn" id="vali" name="submit" onclick="addTicker()" value="Search"/> -->
						
						
					</div>
				</div>
				</form>
			</div>
		
		</div>
		<!-- end Modal -->
		
		<!-- The Modal -->
	<div class="modal" id="changePasswordModal">
		<div class="modal-dialog">
			<div class="modal-content" style="width: 100%;">
				<!-- Modal Header -->
				<div class="filter-header">
					<img src="/images/filter-violet.PNG" alt="">
					<h2>Change Password</h2>
					<a href="#" title="" class="close" data-dismiss="modal"><i
						class="fa fa-window-close" aria-hidden="true"></i></a>
				</div>
				<!-- Modal body -->
				<div class="filter-body" style="padding: 10px; margin-left: 20px">
					<br>
					<!-- <form action="" method="post"> -->

					<div class="row">
						<div class="col-sm-4">
							New Password<input type="text" id="newPassword" name=""
								class="form-control"><br>
							<br>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4">
							Confirm Password<input type="password" id="confirmPassword" name=""
								class="form-control"><br>
							<br>
						</div>
					</div>

					<!-- </form> -->
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="modalBtn" onclick="changePassword()">Save
						Password</button>
					<button type="button" class="modalBtn modalBtnCancel"
						data-dismiss="modal">Cancel</button>
				</div>
			</div>
		</div>

	</div>
	
	
			
			<!-- The Modal For PortFolio -->
	<div class="modal" id="createPortFilter">
			<div class="modal-dialog">
				<div class="modal-content" style="width:100%">
					<!-- Modal Header -->
					<div class="filter-header">
						<img src="/images/filter-violet.PNG" alt="">
						<h2>Create PortFolio</h2>
						<a href="#" title="" class="close" data-dismiss="modal"><i class="fa fa-window-close" aria-hidden="true"></i></a>
					</div>
					<!-- Modal body -->
					<div class="filter-body">
						<!-- <button id="letsSelect" onclick="getSelectedChecks()">Get Selected</button> -->
						<form action="" method="post">
						<br>
							<div class="row">
							<div class="col-md-5">
								 PortFolio Name<input type="text" name="" id="portFolioName" class="form-control"><br><br>
							</div>	
							</div>
							<div class="row">
								<div class="col-md-12 innerFilBlock">
												<div class="row">
													<div class="col-md-8">
														<div class="filterBlock">
														<table id="exampleCreatePortFolio" class="display" style="width:100%">
															<thead>
																<tr>
																	<th>Select</th>
																	<th>Symbol</th>
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
						
						<button type="button" class="modalBtn modalBtnCancel" onclick="createPortfolio()" data-dismiss="modal">Create Portfolio</button>
<!-- 						<button type="button" class="modalBtn modalBtnCancel" data-dismiss="modal">Cancel</button>
 -->						
					</div>
					<br><br>
					<div class="row">
					
								<div class="col-md-12 innerFilBlock">
									<h4 align="center">Saved PortFolio</h4>
												<div class="row">
													<div class="col-md-8">
														<div class="filterBlock">
														<table id="exampleSavePortFolio" class="display" style="width:100%">
															<thead>
																<tr>
																	<th>PortFolio Name</th>
																	<th>Symbol</th>
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
				
				</div>
			</div>
		
		</div>
		<!-- end Modal -->

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
		<!-- end Modal -->
</body>
</html>
