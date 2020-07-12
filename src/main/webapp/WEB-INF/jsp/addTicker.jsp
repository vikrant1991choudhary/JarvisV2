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

	$("#helpBtn").click(function() {
		$(".helpContent").slideToggle();
	});
	
	
	 
	 	 	
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
		
		 $("#tickerName").val("");
		$("#company").val("");
		$("#sector").val("");
		$("#industry").val("");
		$("#country").val("");
		$("#marketCap").val("");

	  
	 // $('#addTickerModal').modal('hide');
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
						<li class="nav-item active">
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
                <div class="col-sm-4">
                	Ticker Name:<input type="text" name="tickerName" id="tickerName" class="form-control"><br>
                </div>
                <div class="col-sm-4">
                	Company:<input type="text" name="company" id="company" class="form-control"><br>
                </div>
                <div class="col-sm-4">
                	Sector:<input type="text" name="sector" id="sector" class="form-control"><br>
                </div>
             </div>	
             <div class="row">
                <div class="col-sm-4">
                	Industry:<input type="text" name="industry" id="industry" class="form-control"><br>
                </div>
                <div class="col-sm-4">
                	Country:<input type="text" name="country" id="country" class="form-control"><br>
                </div>
                <div class="col-sm-4">
                	Market Cap:<input type="text" name="marketCap" id="marketCap" class="form-control"><br>
                </div>
             </div>	
             <div class="row">
             <div class="col-12" style="text-align:right;">
             <button type="button" class="modalBtn" onclick="addTicker()" >Add Ticker</button>
             </div>
             </div>
			
		</div>
	</main>
	<!--end main-->

	
		
	
	

	
</body>
</html>
