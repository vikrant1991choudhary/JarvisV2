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
		getAllPortfolio();
		
		//getAllStocksForPolio();
		var arr = [];
	//	$("#expirationDate").datepicker();
		var userid = $('#userid').val();
		//var stocktable = $('#stocktable');
	//	var fabstocktable = $('#favstock');
		//var bondtable = $('#bondtable');
	//	var fabbondtable = $('#favbond');
		
		
		

		
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
	  		
	  		if (name == null || name == '' || name === undefined) {
				alert("Please Enter Portfolio Name");
				return true;
			}
	  		
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
	  		getAllPortfolio();
	  		$('#createPortFilter').modal('hide');
	  		$("#savePortFolio").show();
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
						{ "data": "ticker" },
						{"data":"name",
							mRender:function(data,type,full){
								return "<button class='btn btn-primary' onclick=\"editPortfolio('"+full['name']+"','"+full['ticker']+"')\">Edit</button>";
							}}
						
						
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
			$('#createPortFilter').modal('hide');
			$("#savePortFolio").show();
			
		
			
			
	}
	  
	  function editPort(){
		  var stockNames = new Array();
		  
		  var oTable =  $('#exampleeditPortFolio').DataTable();
		  
		  oTable.$('td > input:checkbox').each(function () {
	           
	            if (this.checked) {
	             
	               // alert($(this).val());
	                stockNames.push($(this).val());
	            }
	    }); 
	  	
	  	
	  		var name = $("#editportFolioName").val();
	  		
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
	  		getAllPortfolio();
	  		$('#createPortFilter').modal('hide');
	  		$("#savePortFolio").show();
	  }
	  
	  function editPortfolio(value,ticker){ 
		  
		  $("#editportFolioName").val(value);
		  $('#editPortFilter').modal('show');
		 
		  var url = '<%=request.getContextPath()%>/JarvisV2/getAllPortfolioByName?name='+value;
			
			var oTable =  $('#exampleeditPortFolio').DataTable();
			oTable.destroy();
			var oTable =  $('#exampleeditPortFolio').dataTable( {
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
			  responsive: true,
			//  "dom": 'lBfrtip', //'frtip',
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
			  responsive: true,
			  "lengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]], 
			//  "scrollX": true,
			//  "dom": 'frtip', //'frtip',
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
			//getAllPortfolio();
			$('#createPortFilter').modal('show');
			//$("#savePortFolio").hide();
			
			
			
			
	  }
	  

</script>

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
						<li class="nav-item ">
							<a class="nav-link" href="/JarvisV2/admin">Saved Securities</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/JarvisV2/addTicker">Add Ticker</a>
						</li>
						<li class="nav-item active">
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
		<div class="row" style="margin-left: 0;">
		<button type="button" class="modalBtn" onclick="getAllStocksForPolio()" style="padding: 10px 10px; font-size: small;">Create Portfolio</button>
		
		</div>
		<div id="savePortFolio">
				<table id="exampleSavePortFolio" class="display" style="width:100%">
															<thead>
																<tr>
																	<th>PortFolio Name</th>
																	<th>Symbol</th>
																	<th>Action</th>
																</tr>
															</thead>
															<tbody>
															   
															</tbody>
														 </table>
														 
														 </div>	
			
		</div>
	</main>
	<!--end main-->


			
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
							<div class="col-md-7" style="margin-top: 10px;">
								<button type="button" class="btn modalBtn" onclick="createPortfolio()" data-dismiss="modal">Create Portfolio</button>
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
					
									
				
				</div>
			</div>
		
		</div>
		<!-- end Modal -->
		
		
			<!-- The Modal For PortFolio -->
	<div class="modal" id="editPortFilter">
			<div class="modal-dialog">
				<div class="modal-content" style="width:100%">
					<!-- Modal Header -->
					<div class="filter-header">
						<img src="/images/filter-violet.PNG" alt="">
						<h2>Edit PortFolio</h2>
						<a href="#" title="" class="close" data-dismiss="modal"><i class="fa fa-window-close" aria-hidden="true"></i></a>
					</div>
					<!-- Modal body -->
					<div class="filter-body">
						<!-- <button id="letsSelect" onclick="getSelectedChecks()">Get Selected</button> -->
						<form action="" method="post">
						<br>
							<div class="row">
							<div class="col-md-5">
								 PortFolio Name<input type="text" name="" id="editportFolioName" readonly class="form-control"><br><br>
							</div>	
							<div class="col-md-7" style="margin-top: 10px;">
								<button type="button" class="btn modalBtn" onclick="editPort()" data-dismiss="modal">Edit Portfolio</button>
							</div>	
							
							</div>
							<div class="row">
								<div class="col-md-12 innerFilBlock">
												<div class="row">
													<div class="col-md-8">
														<div class="filterBlock">
														<table id="exampleeditPortFolio" class="display" style="width:100%">
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
					
									
				
				</div>
			</div>
		
		</div>
		<!-- end Modal -->
		

	
</body>
</html>
