<!doctype html>
<html lang="en"><head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="X-UA-Compatible" content="IE=edge"> 
		<title>Jarvis</title>
		<link href="favicon.ico" rel="shortcut icon" type="image/x-icon">
		<link rel="stylesheet" href="/css/bootstrap.min.css" type="text/css">
		<link rel="stylesheet" href="/css/font-awesome.min.css" type="text/css">
		<link href="https://fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,500,700,700i,900" rel="stylesheet">
		<!-- <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> -->
		<link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
		<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.5.6/css/buttons.dataTables.min.css">
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
				</style>
				
				<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/buttons/1.5.6/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.flash.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.print.min.js"></script>
				
				
				
			<!-- <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script> -->
		<script src="/js/bootstrap.min.js" type="text/javascript"></script>
		<script src="/js/popper.min.js" type="text/javascript"></script>
		<!-- <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->
		<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.5/jspdf.debug.js" type="text/javascript"></script> 
<!-- <script src="/js/jquery.dataTables.min.js"></script> -->
		<script src="/js/custom.js" type="text/javascript"></script>	
		
		
  <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
  <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>

  <script>

  $(document).ready(function() {
    $("#expirationDate").datepicker();
  });

  </script>			
				
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
      
     <!--  <script type="text/javascript">
			$(document).ready( function() {
			//	getImportsData();
				getCallData();
				
				
			});
	
</script> -->
      
      
      <script>
          $("#helpBtn").click(function(){
            $(".helpContent").slideToggle();
            //});
            });
            
            
            function getPutData(){
        		
        		var url = '<%=request.getContextPath()%>/JarvisV2/getRealTimeStock';
        		
        		var oTable =  $('#example').DataTable();
        		oTable.destroy();
        		var oTable =  $('#example').dataTable( {
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
							{ "data": "element7" }
							
							
        		  ],
        		  "scrollX": true,
        		  "dom": 'Bfrtip',
        		 // "buttons": ['copy', 'csv', 'excel', 'pdf', 'print'],
        		 "buttons": [ {
		                extend : 'pdfHtml5',
		                title : function() {
		                    return "Jarvis PDF";
		                },
		                orientation : 'landscape',
		                pageSize : 'A0',
		                text : '<i class="fa fa-file-pdf-o"> PDF</i>',
		                titleAttr : 'PDF'
		            },{
		            	extend: 'excelHtml5',
		            	text : '<i class="fa fa-file-excel-o"> EXCEL</i>',
		            },{
		            	extend: 'print',
		            	orientation : 'landscape',
		            	pageSize : 'A0',
		            	text : '<i class="fa fa-print"> PRINT</i>',
		            } ],
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
							<a class="nav-link" href="/JarvisV2/realTimeStock">Stock<span class="sr-only">(current)</span></a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/JarvisV2/realTimeBond">Bond</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/JarvisV2/realTimeCurrencies">Currencies</a>
						</li>
						
						
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
							Stock LookUp <input type="text" name="stockLookUp" value="" class="form-control"/>
						</div>
						<div class="col-sm-5"> <br>&nbsp;&nbsp;&nbsp;
							<button type="button" class="modalBtn">Go</button>&nbsp;&nbsp;&nbsp;
							<button type="button" class="modalBtn">Reset</button>
						</div>
						
						</div>
						<br>
						<!-- <div class="row">
						<div class="col-sm-12">
							<button type="button" class="modalBtn">Add</button>&nbsp;&nbsp;&nbsp;
							<button type="button" class="modalBtn">History</button>
						</div>
					</div> -->
			
			<br>

					<table id="example" class="display" style="width:100%">
        <thead>
            <tr>
                <th>Symbol</th>
				<th>Date</th>
				<th>Open</th>
				<th>High</th>
				<th>Low</th>
				<th>Close</th>
				<th>Volume</th>
				
				
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
				<div class="modal-content">
				
					<!-- Modal Header -->
					<div class="filter-header">
						<img src="/images/filter-violet.PNG" alt="">
						<h2>Filter</h2>
						<a href="#" title="" class="close" data-dismiss="modal"><i class="fa fa-window-close" aria-hidden="true"></i></a>
					</div>
					
					<!-- Modal body -->
					<div class="filter-body">
						<form action="" method="post">
							<div class="row">
								<div class="col-md-12 innerFilBlock">
									
												<div class="row">
													<div class="col-md-4">
														<div class="filterBlock singleselect">
														<label>Location</label>
														<select name="location">

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
																	<label>Start Date</label> <input type = "date" name="startdate">
															</div>
														</div>
													</div>
													<div class="col-md-4">
														<div class="filterBlock">
															<div class="dateCalender">
																	<label>End Date</label><input type = "date" name="enddate">
															</div>
														</div>
												</div>
												
												</div>
													
											</div>

									
							
					</div>
					
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="modalBtn modalBtnCancel" data-dismiss="modal">Cancel</button>
						<input type="submit" class="modalBtn" id="vali" name="submit" value="submit"/>
					</div>
				</form>
				</div>
			</div>
		
		</div>
		<!-- end Modal -->


		  
		
		</body>
		</html>
	