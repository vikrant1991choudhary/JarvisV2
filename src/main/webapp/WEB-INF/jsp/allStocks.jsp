<!doctype html>
<%
Integer userId = (Integer)session.getAttribute("userID");
/*out.println("userId="+userId);*/
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
					.formDropdown{display: block;
					    width: 50%;
					    height: 34px;
					    font-size: 14px;
					    line-height: 1.42857143;
					    color: #555;
					    background-color: #fff;
					    background-image: none;
					    border: 1px solid #ccc;
					    border-radius: 4px;
					} 
					.formclass{
							    width: 70%;
							    height: 34px;
							    padding: 6px 12px;
							    font-size: 14px;
							    line-height: 1.42857143;
							    color: #555;
							    background-color: #fff;
							    background-image: none;
							    border: 1px solid #ccc;
							    border-radius: 4px;
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
				
		<script src="/js/bootstrap.min.js" type="text/javascript"></script>
		<script src="/js/popper.min.js" type="text/javascript"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
		
	<script language="javascript" src="https://momentjs.com/downloads/moment.js"></script>
<!-- <script language="javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.43/js/bootstrap-datetimepicker.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.43/css/bootstrap-datetimepicker.min.css"> -->
<script language="javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
		
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

  <script>

  $(document).ready(function() {
	  
	
	  
    $("#startdatepicker").datepicker();
    $("#enddatepicker").datepicker();
    //$(".livesearch").chosen();
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
            
            
		function loadChartForAllStock(bestFS){
		//	console.log("loadChartForAllStock--"+bestFS);
			var week1Value = new Array();
        	var week2Value = new Array();
			var changeInValue = new Array();
			var percentageChange = new Array();
			var price=new Array();
        	var count=0;
        	
        	for(var i in bestFS){
        		if(bestFS[i].price!='CUMULATIVE CHANGE'){
        			week1Value.push(bestFS[i].week1Value);
            		week2Value.push(bestFS[i].week2Value);
					changeInValue.push(bestFS[i].changeInValue);
					if(bestFS[i].percentageChange.indexOf("%") != -1){
						percentageChange.push((bestFS[i].percentageChange).slice(0, -1));                		
                	}else
                		percentageChange.push(bestFS[i].percentageChange);;
					
					price.push(bestFS[i].price);
        		}	
        		if(count==20)
        			break;
        		  }
        	/* console.log("week1Value--"+week1Value);
        	console.log("week2Value--"+week2Value);
        	console.log("changeInValue--"+changeInValue);
        	console.log("percentageChange--"+percentageChange);
        	console.log("price--"+price); */
       /* 	Highcharts.chart('chart7', {
        	    chart: {
        	        type: 'line'
        	    },
        	    title: {
        	        text: 'Ratio Graph'
        		
        	    },
        	    subtitle: {
        	        text: ''
        	    },
        	    xAxis: {
        	        categories: week1Value,
        	        title: {
        	            text: 'week1Value'
        	        }
        	    },
        	    yAxis: {
        	    	 categories: week2Value,
        	        title: {
        	            text: 'week2Value'
        	        }
        	    },
        	    plotOptions: {
        	        line: {
        	            dataLabels: {
        	                enabled: false
        	            },
        	            enableMouseTracking: true
        	        }
        	    },
        		credits: {
        			enabled: false
        		},
        	    series: [{
        	        name: 'Change In Value',
        	        data: JSON.parse("[" + changeInValue + "]")
        	    } , {
        	        name: 'Price',
        	        data: JSON.parse("[" + price + "]")                     //stockPriceStr
        	    }, {
        	        name: 'Percentage Change',
        	        data: JSON.parse("[" + percentageChange + "]")                     //stockPriceStr
        	    } ]
        	});
        	*/
        	Highcharts.chart('chart7', {

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
        	        categories: week1Value
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
    	        name: 'Change In Value',
    	        data: JSON.parse("[" + changeInValue + "]")
    	    } , {
    	        name: 'Price',
    	        data: JSON.parse("[" + price + "]")                    
    	    }, {
    	        name: 'Percentage Change',
    	        data: JSON.parse("[" + percentageChange + "]")                    
    	    } ]

        	});
            	
            }
            
            function findHistoricalStockDataByDateWithPercentageChange(){
            	var stockList = new Array();
            	
            	/* $('[name=dateChkBox]:checked').each(function () {
                	//	alert('selected val: ' + $(this).val());
                		stockList.push($(this).val());
                     //   alert('selected: ' + $(this).val());
                    }); */ 
            	
            	var oTable =  $('#exampleAllStocks').DataTable();
        		  
        		  oTable.$('td > input:checkbox').each(function () {
        	           
        	            if (this.checked) {
        	             
        	               // alert($(this).val());
        	                stockList.push($(this).val());
        	            }
        	    }); 
            	
            		var startDate = $("#startdatepicker").val();
            		var endDate = $("#enddatepicker").val();
            		if(startDate==null ||  startDate=='' ||  startDate===undefined )
            		{
            			alert("Please Enter Start Date");
            			return true;
            		}
            		 if(endDate==null || endDate=='' ||endDate===undefined){
            			 alert("Please Enter End Date");
             			return true;
            		 }
            		/*  var myArray= encodeURIComponent(JSON.stringify(stockList));
            		 alert("myArray"+myArray); */
            		 
            		 var url = '<%=request.getContextPath()%>/JarvisV2/findHistoricalStockDataByDateWithPercentageChange?startDate='+startDate+'&endDate='+endDate;
             		
             		var oTable =  $('#exampleAllStocksDiv').DataTable();
             		oTable.destroy();
             		var oTable =  $('#exampleAllStocksDiv').dataTable( {
             			 oLanguage: {
           			      sLoadingRecords: '<img src="/images/loading.gif">'
           			    },
             			scrollY:        '50vh',
             	        scrollCollapse: true,
             	        paging:         false,
             		//	aaSorting: [ [1, 'desc']],
             			order : [],
             		        "ajax": {
             		            "url": url,
             		            "data": {
         			               myArray: stockList 
         		    },
             		            "dataSrc": ""
             		        },
             		        "columns": [
     							{ "data": "tickerName" },
     							{ "data": "week1Value" },
     							{ "data": "week2Value" },
     							{ "data": "price" },
     							{ "data": "changeInValue" },
     							{ "data": "percentageChange" },
     							
     							
             		  ],"columnDefs":[{
        	            "targets":3,//column index
          	            "data":"price",
          	            "render":function(data,type,row){
          	            	//var len = data.length;
          	            	var CUMULATIVE=row['price'];
          	            	
          	            	
          	            	if(CUMULATIVE=="CUMULATIVE CHANGE")   	            	
          	          		    //$(row).find('td:eq(3)').css('color', 'red');
          	            		return "<span style='color:blue'>"+CUMULATIVE+"</span>";
          	            	else
          	            			return CUMULATIVE;
          	            
          	         }
          	        },{
        	            "targets":4,//column index
          	            "data":"changeInValue",
          	            "render":function(data,type,row){
          	            	//var len = data.length;
          	            	var CUMULATIVE=row['price'];
          	            	var changeInValue=row['changeInValue'];
          	            	console.log("changeInValue="+changeInValue+" CUMULATIVE="+CUMULATIVE);
          	            	
          	            	if(CUMULATIVE=="CUMULATIVE CHANGE")   	            	
          	          		   
          	            		return "<span style='color:blue'>"+changeInValue+"</span>";
          	            	else
          	            			return changeInValue;
          	            
          	         }
          	        },{
        	            "targets":5,//column index
          	            "data":"percentageChange",
          	            "render":function(data,type,row){
          	            	//var len = data.length;
          	            	var percentageChange=row['percentageChange'];
       	            	
          	            	console.log(percentageChange.substr(0,1)); 
          	            	
          	            	
          	            	if(percentageChange.substr(0,1)=="-")   	            	
          	          		    //$(row).find('td:eq(3)').css('color', 'red');
          	            		return "<span style='color:red'>"+percentageChange+"</span>";
          	            	else
          	            		return "<span style='color:green'>"+percentageChange+"</span>";
          	            
          	         }
          	        }], /* 
             		       'rowCallback': function(row, data, index){
             		    	   console.log(data[3]);
             		    	    if(data[3]=="CUMULATIVE CHANGE"){
             		    	        $(row).find('td:eq(3)').css('color', 'red');
             		    	    }
             		    	   
             		    	  }, */
             		// "order": [[ 0, "desc" ]],
             		  "scrollX": true,
             		  "dom": 'Bfrtip',
     	        		 // "buttons": ['copy', 'csv', 'excel', 'pdf', 'print'],
     	        		 "buttons": [ {
     			                extend : 'pdfHtml5',
     			                title : function() {
     			                	const months = ["JAN", "FEB", "MAR","APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
     			                	let current_datetime = new Date()
     			                	let formatted_date = current_datetime.getDate() + "-" + months[current_datetime.getMonth()] + "-" + current_datetime.getFullYear()
									/* var url = "/images/logo_leftbraincm.jpg";
									var img = new Image();
									img.src = url;
									console.log(document.body.appendChild(img));
									var str = "<img src=\"" + url + "\" \/>";
     			                	return str+"Jarvis Weekly for ( "+formatted_date+" )";    */  	
     			                	return  "Jarvis Weekly for ( "+formatted_date+" )";
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
            		  				
    				
    				 jQuery.ajax({
     			    	url: '<%=request.getContextPath()%>/JarvisV2/findHistoricalStockDataByDateWithPercentageChange?startDate='+startDate+"&endDate="+endDate,
     			           type: "GET",
     			           async:false,
     			           cache: false,
     			           data: {
     			               myArray: stockList 
     		    },
     			           dataType: "json",
     			           success: function(data) {
     			        	  var bestHtml = "";
     			        	  var bestFS = data;
  			        	 
  							/* for(var i in bestFS){
  								console.log("tickerName: "+bestFS[i].tickerName);
  								bestHtml = bestHtml + "<tr>";
  								bestHtml = bestHtml + "<td>" + bestFS[i].tickerName + "</td>";
  								bestHtml = bestHtml + "<td>" + bestFS[i].week1Value + "</td>";
  								bestHtml = bestHtml + "<td>" + bestFS[i].week2Value + "</td>";
  								bestHtml = bestHtml + "<td>" + bestFS[i].price + "</td>";
  								bestHtml = bestHtml + "<td>" + bestFS[i].changeInValue + "</td>";
  								bestHtml = bestHtml + "<td>" + bestFS[i].percentageChange + "</td>";
  								bestHtml = bestHtml + "</tr>";
  							}			        	   
  							
  							$("#allStockDropTable").html(bestHtml); */
  							getChartForAllStock(bestFS); 
     			           },
     			           error: function(e){				           
     		           	        //alert('Error in getColumns: ' + e);		           	
     		           	    }

     		       });
    				 
    				 $('#allStocksDiv').show();    		    	  
    		     	  $('#allStockName').show();   	
    		     	 	$("#allStocksChartDiv").hide();
    				
            }
            
            function getChartForAllStock(bestFS){
           // 	console.log("getChartForAllStock--"+bestFS);
           // 	alert("CHart getChartForAllStock");
           		loadChartForAllStock(bestFS);
            	
            	$("#allStocksDiv").hide();            	
            	$("#allStocksChartDiv").show();
            	
            	
            	 
            }
            function gridView(){
            	$("#allStocksDiv").show();
            	$("#allStocksChartDiv").hide();
            	
            	
            }
            function chartView(){
            	$("#allStocksDiv").hide();
            	$("#allStocksChartDiv").show();
            	
            }
            
            function allStockDone(){
            	var values = new Array();
            	var i=0;
                    var oTable =  $('#exampleAllStocks').DataTable();
          		  
          		  oTable.$('td > input:checkbox').each(function () {
          	           
          	            if (this.checked) {
          	             
          	               // alert($(this).val());
          	                values.push($(this).val());
          	                i++;
          	            }
          	    }); 
          		  
          		 // alert("Count ="+i);
				 //You have selected 55 stocks. Please select date and click Go.
          		$("#msgStock").html("<h4 style='font-size:.8rem;color:#9a0606'>You have selected  "+i+" stocks. Please select date and click Go</h4>");
            	
            }
            
            function allStocks(){
            	var values = new Array();
            	/* 
            	$('[name=dateChkBox]:checked').each(function () {
                	//	alert('selected val: ' + $(this).val());
                		values.push($(this).val());
                       // alert('selected: ' + $(this).val());
                    });  */
                    
                    var oTable =  $('#exampleAllStocks').DataTable();
          		  
          		  oTable.$('td > input:checkbox').each(function () {
          	           
          	            if (this.checked) {
          	             
          	               // alert($(this).val());
          	                values.push($(this).val());
          	            }
          	    }); 
          	  	
                    
                    jQuery.ajax({
    			    	url: '<%=request.getContextPath()%>/JarvisV2/saveWeeklyStocks?userId='+<%=userId%>,
    			           type: "GET",
    			           async:false,
    			           cache: false,
    			           data: {
    			               myArray: values 
    		    },
    			           dataType: "json",
    			           success: function(data) {
    			        	   
    			        	  alert("SuccessFully Saved");
    			           },
    			           error: function(e){				           
    		           	        //alert('Error in getColumns: ' + e);		           	
    		           	    }

    		       });
            }
            
            
            
 		
            
	function getAllFavStocks(){
        		
        		var url = '<%=request.getContextPath()%>/JarvisV2/getAllFavStocks';
        		
        		var oTable =  $('#exampleAllStocks').DataTable();
        		oTable.destroy();
        		var oTable =  $('#exampleAllStocks').dataTable( {
        			aaSorting: [[1, 'desc']],
        		        "ajax": {
        		            "url": url,
        		            "dataSrc": ""
        		        },
        		        "columns": [
							{ "data": "checkBoxHtml" },
							{ "data": "stockName" }
							
							
        		  ],
        		  
        		  "scrollX": true,
        		  "dom": 'frtip',
        		 // "buttons": ['copy', 'csv', 'excel', 'pdf', 'print'],
        		// "dom": 'lBfrtip', //'Bfrtip',
				 "lengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]], 	
        		  "pagingType": "full",
        		  "language": {
        		      "paginate": {
        		        "previous": "<<",
        		        "next": ">>"
        		      }
        		    }
        		 } );
        		$('#allStockFilter').modal('show');
        		
        		/* console.log("delay for 5 sec...");
        		var delayInMilliseconds = 5000;
        		setTimeout(function() {
        			// delay
        			$('#letsSelect').click();
        		}, delayInMilliseconds); */
        		
        		
            }
            
	function getSelectedChecks(){
		//alert("getSelectedChecks");
		$('[name=dateChkBox]').each(function () {
			console.log("under loop");
    		var isSelected = $(this).attr('isselected');
    		console.log("isSelected="+isSelected);
    		if(isSelected)
    			$(this).prop('checked', true); 
            }); 
	}
            
            
    </script>
			
			<!--end header-->

			<!--navigation-->
			
			<!--navigation-->
			<nav class="navbar navbar-expand-lg navbar-light bg-light">
				<div class="container-fluid">
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarNavDropdown">
					<ul class="navbar-nav">
						<li class="nav-item">
							<a class="nav-link" href="/JarvisV2/weekly">Stocks Pair</a>
						</li>
						<li class="nav-item active">
							<a class="nav-link" href="/JarvisV2/allStocks">All Stocks</a>
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
					
					<!-- <a href="demand" title="" class="float-right viewGraph hvr-push">VIEW ALL GRAPHS</a> -->
					<!--graph section-->
					 <div class="row">
   

    
    <div class="col-sm-3">
    	
       	<div id="allStockName">  
       	 <button type="button" class="modalBtn" onclick=" getAllFavStocks()">All Stock</button>  <br>    	 
       	 <div id="msgStock"></div>
       	 
       	 </div>
    </div>
    <div class="col-sm-3">
    	  
       Start Date: <input type="text" id="startdatepicker" class="formclass">
   
    </div>
    <div class="col-sm-3">
    	    
       End Date: <input type="text" id="enddatepicker" class="formclass">
   		
    </div>
     <div class="col-sm-3">
    
    	 
    	 <input type="button" name="" class="modalBtnWeekly" value="go" onclick="findHistoricalStockDataByDateWithPercentageChange()" />&nbsp;&nbsp;
    	 <input type="button" name="" class="modalBtnWeekly" value="Grid View"  onclick="gridView()" />&nbsp;&nbsp;
    	 <input type="button" name="" class="modalBtnWeekly"  value="Chart View" onclick="chartView()" />
    	 
    	 
    </div>
  </div>
</div>
						<br>
						
			
			<br>

					<div id="allStocksDiv">
					
				<table id="exampleAllStocksDiv" class="display" style="width:100%">
					<thead>
	    <tr>
				<th>Symbol</th>
				<th>Week 1</th>
				<th>Week 2</th>
				<th>Price</th>
				<th>Change</th>
				<th>Change%</th>
	    </tr>
	</thead>
	
	 <tbody id="allStockDropTable">
	   
	</tbody>
	
	</table>







				</div>
				
	<div id="allStocksChartDiv" style="display:none">
	<input type="button" name="" class="modalBtnWeekly" value="Grid View" style="float: right;" onclick="gridView()" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="" class="modalBtnWeekly" style="float: right;" value="Chart View" onclick="chartView()" /><br><br>
	
		CHART
		<div id="chart7">  
		   
		</div>
	</div>

 



				</div>	
			</main>
			<!--end main-->
			
			
				 
	<!-- The Modal For AllStocks -->
	<div class="modal" id="allStockFilter">
			<div class="modal-dialog">
				<div class="modal-content" style="width:100%">
					<!-- Modal Header -->
					<div class="filter-header">
						<img src="/images/filter-violet.PNG" alt="">
						<h2>Choose From Favorite Stocks</h2>
						<a href="#" title="" class="close" data-dismiss="modal"><i class="fa fa-window-close" aria-hidden="true"></i></a>
					</div>
					<!-- Modal body -->
					<div class="filter-body">
						<!-- <button id="letsSelect" onclick="getSelectedChecks()">Get Selected</button> -->
						<form action="" method="post">
						<br>
							<div class="row">
								<div class="col-md-12 innerFilBlock">
												<div class="row">
													<div class="col-md-8">
														<div class="filterBlock">
														<table id="exampleAllStocks" class="display" style="width:100%">
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
						<button type="button" class="modalBtn modalBtnCancel"  data-dismiss="modal" onclick="allStockDone()">Done</button>
						<button type="button" class="modalBtn modalBtnCancel" onclick="allStocks()" data-dismiss="modal">Save n Done</button>
						
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
	