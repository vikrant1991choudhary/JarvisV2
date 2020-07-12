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
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="/js/buttons.html5.min.js" type="text/javascript"></script>
<script src="/js/buttons.print.min.js" type="text/javascript"></script>		
				
		<script src="/js/bootstrap.min.js" type="text/javascript"></script>
		<script src="/js/popper.min.js" type="text/javascript"></script>
		
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
    getSectors();
    //$(".livesearch").chosen();
   
    
    /* $("#dropdown1").change(function() {
       var drop=($(this).find("option:selected").text());
       var stockDropDown=$("#stockDropDown").val();
		//	alert("dropdown2-"+stockDropDown);
		
       //alert("dropdown1--"+drop);
       if(drop=='All Stocks'){
    	   $('#allStocksDiv').show();
    	   $('#stocksPairDiv').hide();
    	   $('#stock').hide();
     	   $('#bond').hide();
     	  $('#allStockName').show();
     	 $('#stockGo').hide();
     	 $('#allStockGo').show();
     	$("#allStocksChartDiv").hide();
       }
       else if(drop=='Stocks Pair' && stockDropDown=='stock'){
    	   $('#allStocksDiv').hide();
    	   $('#stock').show();
    	   $('#bond').hide();
    	   $('#stocksPairDiv').show();
    	   $('#allStockName').hide();
    	   $('#stockGo').show();
       	 $('#allStockGo').hide();
       	$("#allStocksChartDiv").hide();
       }
       
       else if(drop=='Stocks Pair' && stockDropDown=='bond'){
    	   $('#allStocksDiv').hide();
    	   $('#stock').hide();
    	   $('#bond').show();
    	   $('#stocksPairDiv').show();
    	   $('#allStockName').hide();
    	   $('#stockGo').show();
       	 $('#allStockGo').hide();
       	$("#allStocksChartDiv").hide();
       }
    });
    
    $("#dropdown2").change(function() {
    	var drop=($(this).find("option:selected").text());
        //alert("dropdown2--"+drop);
        
        if(drop=='Stock'){
     	   $('#stock').show();
     	   $('#bond').hide();
     	  $('#allStockName').hide();
     	 $('#stockGo').show();
     	 $('#allStockGo').hide();
        }
        if(drop=='Bond'){
     	   $('#stock').hide();
     	   $('#bond').show();
     	  $('#allStockName').hide();
     	 $('#stockGo').show();
     	 $('#allStockGo').hide();
        }
     }); */
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
            
            function getHistoricalDataByStockAndDate(){
            	
           	 var tblHtml="";
            
            	var stockAarr = new Array();
				var stockBarr = new Array();
				var stockCarr = new Array();
				var stockDarr = new Array();
				var dateArr = new Array();
				var ratio1Arr = new Array();
				var ratio2Arr = new Array();
				
				//alert("Stock in-"+tblHtml);
				
				// $("#exampleStocksPair").html("");
					
            	var stockA = $("#sectorList1>option:selected").val();
            	var stockB = $("#sectorList2>option:selected").val();
            	var stockC = $("#sectorList3>option:selected").val();
            	var stockD = $("#sectorList4>option:selected").val();
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
        		
        		  tblHtml = tblHtml+"<th>Date</th>"; 
        		   tblHtml=tblHtml+"<th>"+stockA+"</th>";
        		   tblHtml=tblHtml+"<th>"+stockB+"</th>";
        		   tblHtml=tblHtml+"<th>Ratio</th>";
        		   tblHtml=tblHtml+"<th>"+stockC+"</th>";
        		   tblHtml=tblHtml+"<th>"+stockD+"</th>";
        		   tblHtml=tblHtml+"<th>Ratio</th>";
        		   $("#headerRow").html(tblHtml); 
        		 //  tblHtml = tblHtml + "</tr> </thead>";  
        	    
        		// $("#exampleStocksPair").html(tblHtml);  
        	  
        		// alert("stockB="+tblHtml);
            	var param = "stockA="+stockA+"&stockB="+stockB+"&stockC="+stockC+"&stockD="+stockD+"&startDate="+startDate+"&endDate="+endDate;
            	
            	var url = '<%=request.getContextPath()%>/JarvisV2/getHistoricalDataByStockAndDate?stockA='+stockA+'&stockB='+stockB+'&stockC='+stockC+'&stockD='+stockD+'&startDate='+startDate+'&endDate='+endDate;
            	var oTable =  $('#exampleStocksPair').DataTable();
        		oTable.destroy();
        		var oTable =  $('#exampleStocksPair').dataTable( {
        			     			
        			  oLanguage: {
       			      sLoadingRecords: '<img src="/images/loading.gif">'
       			    }, 
        			scrollY:        '50vh',
        	        scrollCollapse: true,
        	        paging:         false,
        			aaSorting: [[1, 'desc']],
        		        "ajax": {
        		            "url": url,
        		            "dataSrc": ""
        		        },
        		        "columns": [
							{ "data": "date" },
							{ "data": "firstParamVal" },
							{ "data": "secondParamVal" },
							{ "data": "ratio" },
							{ "data": "thirdParamVal" },
							 { "data": "fourthParamVal" },
							{ "data": "ratioThirdFourth" }
							/*{ "data": "maturityDate" } */
							
        		  ],
        		  "columnDefs":[{
	      	            "targets":3,//column index
	      	            "data":"ratio",
	      	            "render":function(data,type,row){
	      	            	var res=row['ratio'];
	      	            	var data = (Math.round(res * 100) / 100).toFixed(3);	      	            	
				   			 return data;
	      	        	 }
	      	        } ,{
	      	            "targets":6,//column index
	      	            "data":"ratioThirdFourth",
	      	            "render":function(data,type,row){
	      	            	var res=row['ratioThirdFourth'];
	      	            	var data = (Math.round(res * 100) / 100).toFixed(3);	      	            	
				   			 return data;
	      	        	 }
	      	        }  ],
			  "order": [[ 0, "desc" ]],	
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
			                    return '<img src="/images/logo_leftbraincm.jpg" alt="">'+"Jarvis Weekly for ( "+formatted_date+" )";
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
        		
            	jQuery.ajax({
			    	url: '<%=request.getContextPath()%>/JarvisV2/getHistoricalDataByStockAndDate',
			           type: "GET",
			           async:false,
			           cache: false,
			           data: param,
			           dataType: "json",
			           success: function(data) {
			        	   
			        	 // alert("Success");
			        	  var tabHTML = "";
			        	  for(var i=0;i<data.length;i++){
			        		  /* tabHTML = tabHTML + "<tr><td>" + data[i].date + "</td><td>" + data[i].firstParamVal + "</td><td>" + data[i].secondParamVal + "</td><td>"
			        		  			+ data[i].ratio + "</td><td>" + data[i].thirdParamVal + "</td><td>" + data[i].fourthParamVal + "</td><td>"
			        		  			+ data[i].ratioThirdFourth + "</td></tr>"; */
			        		  			
			        		  			
			        		  stockAarr.push(data[i].firstParamVal);
			        		  stockBarr.push(data[i].secondParamVal);
			        		  stockCarr.push(data[i].thirdParamVal);
			        		  stockDarr.push(data[i].fourthParamVal);
			        		  dateArr.push(data[i].date);
			        		 // ratio1Arr.push(data[i].ratio);
			        		  ratio1Arr.push((Math.round((data[i].ratio) * 100) / 100).toFixed(3));
			        	/*	 if(data[i].ratioThirdFourth !="")
			        			 ratio2Arr.push(Math.round((data[i].ratioThirdFourth) * 100) / 100).toFixed(3);	  */
			        		  ratio2Arr.push(data[i].ratioThirdFourth);
			        	  }
			        	  console.log("tabHTML="+tabHTML);
			        	//  $("#stockPairDropTable").html(tabHTML);
			        	  
			        	  getChartHistoricalDataByStockAndDate(stockAarr,stockBarr,stockCarr,stockDarr,dateArr,ratio1Arr,ratio2Arr,
			        			  stockA,stockB,stockC,stockD);
			           },
			           error: function(e){				           
		           	        alert('Error:' + e);		           	
		           	    }
		       });
            	
			
			
			/* if(stockDropDown=='bond'){
				var stockAarr = new Array();
				var stockBarr = new Array();
				var stockCarr = new Array();
				var stockDarr = new Array();
				var dateArr = new Array();
				var ratio1Arr = new Array();
				var ratio2Arr = new Array();
				
				
				
					
            	var stockA = $("#sectorList5>option:selected").val();
            	var stockB = $("#sectorList6>option:selected").val();
            	var stockC = "";
            	var stockD = "";
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
        		 tblHtml = "<th>Date</th>"; 
      		   tblHtml=tblHtml+"<th>"+stockA+"</th>";
      		   tblHtml=tblHtml+"<th>"+stockB+"</th>";
      		   tblHtml=tblHtml+"<th>Ratio</th>";
      		   tblHtml=tblHtml+"<th>"+stockC+"</th>";
      		   tblHtml=tblHtml+"<th>"+stockD+"</th>";
      		   tblHtml=tblHtml+"<th>Ratio</th>";
      		 	$("#headerRow").html(tblHtml);
      		
      	  
            	var param = "stockA="+stockA+"&stockB="+stockB+"&stockC="+stockC+"&stockD="+stockD+"&startDate="+startDate+"&endDate="+endDate;
            	
            	var url = '<%=request.getContextPath()%>/JarvisV2/getHistoricalDataByStockAndDate?stockA='+stockA+'&stockB='+stockB+'&stockC='+stockC+'&stockD='+stockD+'&startDate='+startDate+'&endDate='+endDate;
            	var oTable =  $('#exampleStocksPair').DataTable();
        		oTable.destroy();
        		var oTable =  $('#exampleStocksPair').dataTable( {
        			 oLanguage: {
       			      sLoadingRecords: '<img src="/images/loading.gif">'
       			    },
        			scrollY:        '50vh',
        	        scrollCollapse: true,
        	        paging:         false,
        			aaSorting: [[1, 'desc']],
        		        "ajax": {
        		            "url": url,
        		            "dataSrc": ""
        		        },
        		        "columns": [
							{ "data": "date" },
							{ "data": "firstParamVal" },
							{ "data": "secondParamVal" },
							{ "data": "ratio" },
							{ "data": "thirdParamVal" },
							 { "data": "fourthParamVal" },
							{ "data": "ratioThirdFourth" }
							
							
        		  ],
        		  "scrollX": true,
        		  "dom": 'Bfrtip',
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
        		 
            	jQuery.ajax({
			    	url: '<%=request.getContextPath()%>/JarvisV2/getHistoricalDataByStockAndDate',
			           type: "GET",
			           async:false,
			           cache: false,
			           data: param,
			           dataType: "json",
			           success: function(data) {
			        	   
			        	  var tabHTML = "";
			        	  for(var i=0;i<data.length;i++){
			        		 
			        		  			
			        		  stockAarr.push(data[i].firstParamVal);
			        		  stockBarr.push(data[i].secondParamVal);
			        		  stockCarr.push(data[i].thirdParamVal);
			        		  stockDarr.push(data[i].fourthParamVal);
			        		  dateArr.push(data[i].date);
			        		  ratio1Arr.push(data[i].ratio);
			        		  ratio2Arr.push(data[i].ratioThirdFourth);
			        	  }
			        	  console.log("tabHTML="+tabHTML);
			        	  
			        	  getChartHistoricalDataByStockAndDate(stockAarr,stockBarr,stockCarr,stockDarr,dateArr,ratio1Arr,ratio2Arr,
			        			  stockA,stockB,stockC,stockD);
			           },
			           error: function(e){				           
		           	        alert('Error:' + e);		           	
		           	    }
		       });
            	 
			} */
			
			
        	$("#stocksPairDiv").show();
        	$("#stocksPairChartDiv").hide();
        	
            	 
            }
            function showChart(){
            	$("#stocksPairDiv").hide();
            	$("#stocksPairChartDiv").show();
            }
            function showGrid(){
            	$("#stocksPairDiv").show();
            	$("#stocksPairChartDiv").hide();
            }
            function getChartHistoricalDataByStockAndDate(stockAarr,stockBarr,stockCarr,stockDarr,dateArr,ratio1Arr,ratio2Arr
            		,stockA,stockB,stockC,stockD){
            	
            	//alert("CHart");
            	$("#stocksPairDiv").hide();
            	$("#stocksPairChartDiv").show();            	
            	loadChart(stockAarr,stockBarr,stockCarr,stockDarr,dateArr,ratio1Arr,ratio2Arr,stockA,stockB,stockC,stockD);
            }
            
            
            function loadChart(stockAarr,stockBarr,stockCarr,stockDarr,dateArr,ratio1Arr,ratio2Arr,stockA,stockB,stockC,stockD){
            	//var stockDropDown=$("#stockDropDown").val();
				//alert("dropdown2-"+stockDropDown);
			 if(stockC !=''){
				console.log("stockCarr->"+stockCarr+"<-"+stockA+"--- >"+stockC+"<-");
            	Highcharts.chart('chart6', {

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
            	        categories: dateArr
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
            	        name:  stockA,
            	        data: JSON.parse("[" + stockAarr + "]")
            	    }, {
            	        name:  stockB,
            	        data: JSON.parse("[" + stockBarr + "]")
            	    }, {
            	        name:  stockC,
            	        data: JSON.parse("[" + stockCarr + "]")
            	    }, {
            	        name:  stockD,
            	        data: JSON.parse("[" + stockDarr + "]")
            	    },{
            	        name:  'Ratio First',
            	        data: JSON.parse("[" + ratio1Arr + "]")
            	    },{
            	        name:  'Ratio 2nd',
            	        data: JSON.parse("[" + ratio2Arr + "]")
            	    }]

            	});
            	
			 }
			 else{
				
            	Highcharts.chart('chart6', {

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
            	        categories: dateArr
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
            	        name:  stockA,
            	        data: JSON.parse("[" + stockAarr + "]")
            	    }, {
            	        name:  stockB,
            	        data: JSON.parse("[" + stockBarr + "]")
            	    },{
            	        name:  'Ratio',
            	        data: JSON.parse("[" + ratio1Arr + "]")
            	    }]

            	});
            	
				
			} 
            }
            
            
		
           
            
            
            
 		function getSectors(){
            	
            	jQuery.ajax({
			    	url: '<%=request.getContextPath()%>/JarvisV2/getAllStocks',
			           type: "GET",
			           async:false,
			           cache: false,
			           data: "",
			           dataType: "json",
			           success: function(data) {
			        	   
			        	   var html = "<option value=''>--Select Stock--</option> ";
			        	   for(var i=0; i<data.length; i++){
			        		   html = html + "<option value='" + data[i].stockName + "'>" + data[i].stockName + "</option>";
			        	   }
			        	   $("#sectorList1").html(html); 
			        	   $("#sectorList2").html(html); 
			        	   $("#sectorList3").html(html); 
			        	   $("#sectorList4").html(html); 
			        	   $("#sectorList5").html(html); 
			        	 $("#sectorList6").html(html); 
			        	   $(".livesearch").chosen(); 
			        	   $('#stock').show();
			        		$('#bond').hide();
			           },
			           error: function(e){				           
		           	        alert('Error in getColumns: ' + e);		           	
		           	    }

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
						<li class="nav-item active">
							<a class="nav-link" href="/JarvisV2/weekly">Stocks Pair<span class="sr-only">(current)</span></a>
						</li>
						<li class="nav-item">
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
		                    	    	<!-- First Stock &nbsp;&nbsp;&nbsp;&nbsp;: <select class="livesearch" id="sectorList1" style="width:350px;"></select>&nbsp;&nbsp;<button type="button" class="modalBtnWeekly" onclick="">Reset</button> <br><br>
    	Second Stock : <select class="livesearch" id="sectorList2" style="width:350px;"></select>&nbsp;&nbsp;<button type="button" class="modalBtnWeekly" onclick="">Reset</button><br><br> 
    	Third Stock &nbsp;&nbsp;&nbsp;&nbsp;: <select class="livesearch" id="sectorList3" style="width:350px;"></select>&nbsp;&nbsp;<button type="button" class="modalBtnWeekly" onclick="">Reset</button><br><br> 
    	Fourth Stock &nbsp;&nbsp;&nbsp;&nbsp;: <select class="livesearch" id="sectorList4" style="width:350px;"></select>&nbsp;&nbsp;<button type="button" class="modalBtnWeekly" onclick="">Reset</button><br><br> 
		                    	 -->
				                       <!--  <label>Industry</label> -->
				                      First Stock:  <select id="sectorList1" class="formDropdown livesearch" style="width:250px;">
				                    	
				                    </select>
		                          
                          		</div>
		                          <div class="col-sm-3">
		                           				                       
		                          Second Stock: <select id="sectorList2" class="formDropdown livesearch" style="width:250px;">
		                     		                    </select>
		                         
		                          </div>
		                          <div class="col-sm-3">
                					  Third Stock: <select  id="sectorList3" class="formDropdown livesearch"style="width:250px;">
		                     		                    </select>
                </div>
                <div class="col-sm-3">
                					  Fourth Stock: <select  id="sectorList4" class="formDropdown livesearch" style="width:250px;height:150px;">
		                     		                    </select>
                </div>
              		</div>
              		
					<!-- <div class="row">
    <div class="col-sm-1">
	    	<div id="dropdown2">
	    <select class="formDropdown" id="stockDropDown">
  <option value="stock">Stock</option>
  <option value="bond">Bond</option>
</select>
			</div>
	 </div>
	 <div class="col-sm-1">
	    	<div id="dropdown1">
	    <select class="formDropdown">
  			<option value="stockPair">Stocks Pair</option>
  			<option value="allStocks">All Stocks</option>
</select>
			</div>
	 </div> -->

    <!-- <div class="col-sm-5">
    	<div id="stock">
    	First Stock : <input type="text" name="" class="form-controlWeekly">&nbsp;&nbsp;<button type="button" class="modalBtnWeekly" onclick="">Reset</button><br><br>
    	Second Stock : <input type="text" name="" class="form-controlWeekly">&nbsp;&nbsp;<button type="button" class="modalBtnWeekly" onclick="">Reset</button><br><br>
    	Third Stock : <input type="text" name="" class="form-controlWeekly">&nbsp;&nbsp;<button type="button" class="modalBtnWeekly" onclick="">Reset</button><br><br>
    	Fourth Stock : <input type="text" name="" class="form-controlWeekly">&nbsp;&nbsp;<button type="button" class="modalBtnWeekly" onclick="">Reset</button>
    	</div>
    	<div id="bond" style="display:none">
    	First Stock : <input type="text" name="" class="form-controlWeekly">&nbsp;&nbsp;<button type="button" class="modalBtnWeekly" onclick="">Reset</button><br><br>
    	Second Stock : <input type="text" name="" class="form-controlWeekly">&nbsp;&nbsp;<button type="button" class="modalBtnWeekly" onclick="">Reset</button><br><br>
       	</div>
    </div> -->
    <!-- <div class="col-sm-4">
    	<div id="stock">
    	First Stock &nbsp;&nbsp;&nbsp;&nbsp;: <select class="livesearch" id="sectorList1" style="width:350px;"></select>&nbsp;&nbsp;<button type="button" class="modalBtnWeekly" onclick="">Reset</button> <br><br>
    	Second Stock : <select class="livesearch" id="sectorList2" style="width:350px;"></select>&nbsp;&nbsp;<button type="button" class="modalBtnWeekly" onclick="">Reset</button><br><br> 
    	Third Stock &nbsp;&nbsp;&nbsp;&nbsp;: <select class="livesearch" id="sectorList3" style="width:350px;"></select>&nbsp;&nbsp;<button type="button" class="modalBtnWeekly" onclick="">Reset</button><br><br> 
    	Fourth Stock &nbsp;&nbsp;&nbsp;&nbsp;: <select class="livesearch" id="sectorList4" style="width:350px;"></select>&nbsp;&nbsp;<button type="button" class="modalBtnWeekly" onclick="">Reset</button><br><br> 
    	</div>
    	<div id="bond">
    	First Stock : <select class="livesearch" id="sectorList5" style="width:350px;"></select>&nbsp;&nbsp;<button type="button" class="modalBtnWeekly" onclick="">Reset</button><br><br> 
    	Second Stock : <select class="livesearch" id="sectorList6" style="width:350px;"></select>&nbsp;&nbsp;<button type="button" class="modalBtnWeekly" onclick="">Reset</button><br><br> 
       	</div>
       	<div id="allStockName" style="display:none">
       	 <button type="button" class="modalBtn" onclick="getAllFavStocks()">AllStockName</button>
       	 <button type="button" class="modalBtn"  onclick="chartView()">Chart View</button>
       	 <button type="button" class="modalBtn"  onclick="gridView()">Grid View</button>
       	 
       	 
       	 
       	 </div>
    </div> -->
    <br><br>
    <div class="row">
    <div class="col-sm-3">
    	  
       Start Date: <input type="text" id="startdatepicker" class="formclass">
   
    </div>
    <div class="col-sm-3">
    	    
       End Date: <input type="text" id="enddatepicker" class="formclass"><br><br>
       <!-- <input type="button" name="" class="modalBtnWeekly" value="Chart View" onclick="getChartHistoricalDataByStockAndDate()" /> -->
   		
    </div>
     <div class="col-sm-3">     	
    	 <input type="button" name="" class="modalBtnWeekly" value="go" onclick="getHistoricalDataByStockAndDate()" />&nbsp;&nbsp; 
    	
    		
    </div>
    <div class="col-sm-3">     	
    	  
    	 <input type="button" name="" class="modalBtnWeekly" value="Grid View"  onclick="showGrid()" />&nbsp;&nbsp; 
    	 <input type="button" name="" class="modalBtnWeekly" value="Chart View" onclick="showChart()" />
    		
    </div>
    
  </div>

						<br>
						
			
			<br>

					
				
				<div id="stocksPairDiv">
				<table id="exampleStocksPair" class="display" style="width:100%">
					<thead>
            <tr id="headerRow">
                
            </tr>
        </thead>
	<tbody id="stockPairDropTable">
	   
	</tbody>

	</table>

				</div>
				
	<div id="stocksPairChartDiv" style="display:none">
	
		CHART
		<div id="chart6">  
		   
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
						<button type="button" class="modalBtn modalBtnCancel"  data-dismiss="modal">Done</button>
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
	