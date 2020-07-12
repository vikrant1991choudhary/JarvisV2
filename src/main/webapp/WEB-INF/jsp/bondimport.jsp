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
		<link rel="stylesheet" href="/css/googleapis.css">
		<link rel="stylesheet" href="/css/jquery-ui.css" type="text/css">
		<link rel="stylesheet" href="/css/jquery.dataTables.min.css" type="text/css">
		<link rel="stylesheet" href="/css/buttons.dataTables.min.css">
		<link rel="stylesheet" href="/css/style.css" type="text/css">
		<link rel="stylesheet" href="/themify-icons/themify-icons.css" type="text/css">
		<script src="https://use.fontawesome.com/f58371f8cd.js"></script>
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
				
			<!-- <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script> -->
		<script src="/js/bootstrap.min.js" type="text/javascript"></script>
		<script src="/js/popper.min.js" type="text/javascript"></script>
		<!-- <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" type="text/javascript"></script> -->
			
		
		
<!-- For charts -->		
<!-- <script src="https://code.highcharts.com/highcharts.js" type="text/javascript"></script>
<script src="https://code.highcharts.com/modules/exporting.js" type="text/javascript"></script> -->
		<script src="/js/highcharts.js" type="text/javascript"></script>
		<script src="/js/exporting.js" type="text/javascript"></script>
		<script src="/js/jspdf.debug.js" type="text/javascript"></script> 
		<script src="/js/custom.js" type="text/javascript"></script>	
		<script src="/js/export-data.js" type="text/javascript"></script>
		<script src="/js/accessibility.js" type="text/javascript"></script>	

<!-- live Choose dropdown -->
    <script src="/js/chosen.jquery.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/css/chosen.min.css" type="text/css">		
				
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
					
			$(document).ready(function() {
				
			    getColumns();
			    getAllTicker();
				console.log("Document Ready");
				uploadFileDiv();
			} );
	
</script>
      
      
      <script>
          $("#helpBtn").click(function(){
			  console.log("Help btn");
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
            	//var filterTicker="";
				console.log("Get Reset Start");
            	var dropDown = document.getElementById("filterTicker");
                dropDown.selectedIndex = 0;
            	getImportsData();
				console.log("Get Reset end");
            }
            
            function loadchartForBond(){
				console.log("loadchartForBond start");
          	   //CLose modal
          	   var year = $('#chart1FYBond').val();
          	   var year2= $('#chart2FYBond').val();
          	   $('#modalChartForBond').modal('hide');
          	  getChartForHistoryByBond(year,year2);
			  console.log("loadchartForBond end");
             }
            
 			function getAllTicker(){
				console.log("getAllTicker start");
 				var metadataName="Bondpricing_Master";
            	jQuery.ajax({
			    	url: '<%=request.getContextPath()%>/JarvisV2/getAllTicker',
			           type: "GET",
			           async:false,
			           cache: false,
			           data: "metadataName="+metadataName,
			           dataType: "json",
			           success: function(data) {
			        	 //  alert("getAllTicker"+data);
			        	   var html ="<option value=''>--Select Bond--</option> ";
			        	   for(var i=0; i<data.length; i++){
			        		   html = html + "<option value='" + data[i].element1 + "'>" + data[i].element1 + "</option>";
			        	   }
			        	   $("#filterTicker").html(html); 
			        	   $(".livesearch").chosen({ search_contains: true }); 
			           },
			           error: function(e){				           
		           	        alert('Error in getColumns: ' + e);		           	
		           	    }

		       });
			   console.log("getAllTicker End");
            }
 			
 			function getChartForHistoryByBond(year,year2){
				console.log("getChartForHistoryByBond start");
				var metadataName="Bondpricing_Master";
				var ticker=$('#filterBond').val();
			//	alert("getChartForHistoryByTicker-"+ticker);
				if(ticker==null || ticker=='' || ticker===undefined)
	            		{
	            		var ticker=escape($("#filterTicker>option:selected").val());
	            		
	            		}
				jQuery.ajax({
          			 url: '<%=request.getContextPath()%>/JarvisV2/getChartForHistoryByTicker',
   			           type: "GET",
   			           async:false,
   			           cache: false,
   			           data: "metadataName="+metadataName+"&ticker="+ticker+"&year="+year+"&year2="+year2,
   			           dataType: "json",
   			           success: function(data) {
          					 
          					  var bestFS = data;
          					 
          							
          							viewChartForHistoryByBond(bestFS);
          				   },
          				   error: function(e){				           
          					//alert('Error in getColumns: ' + e);		           	
          				    }

          			});  
           		
           		$('#historyByTickerChartDiv').show();
           		$('#exampleParent').hide();
        		$('#exampleParentChartDiv').hide();
        		$('#filter').modal('hide');
        		$("#headerRow").show();
        		$('#buttonDiv1').show();
        		$('#stockBondParent').hide();
        		$('#buttonDiv2').hide();
        		$('#comparedisplay').hide();
        		$('#bondRankingDiv').hide();
        		$('#buttonDiv3').hide();
			
			console.log("getChartForHistoryByBond start");
              
				
			}		
 			
		function viewChartForHistoryByBond(bestFS){
			console.log("viewChartForHistoryByBond start");
			var ticker=escape($("#filterTicker>option:selected").val());
			var chartYear1 = $('#chart1FYBond').val();
		  	var chartYear2 = $('#chart2FYBond').val();
				var YTW = new Array();
	        	var Price = new Array();
	        	var Date=new Array();
	        	//var Date1=new Array();
				
	        	var count=0;
	        	
	        	for(var i in bestFS){
	        		
	        			YTW.push(bestFS[i].element3);
	        			Price.push(bestFS[i].element9);
	        			
	        			Date.push((bestFS[i].lastUpdatedAt).substring(0, 10));
						//changeInValue.push(bestFS[i].changeInValue);
						
	        			
	        		/* if(count==20)
	        			break; */
	        		  }
	        	/*  console.log("Date--"+Date);
	        	console.log("Date1--"+Date1); */
	        	/*console.log("changeInValue--"+changeInValue);
	        	console.log("percentageChange--"+percentageChange);
	        	console.log("price--"+price); */
	        	
	        	
	        	Highcharts.chart('chart8', {
            	    chart: {
            	        type: 'column'
            	    },
            	    title: {
            	    	useHTML: true,
            			text: 'Year: ' + chartYear1+'-'+ chartYear2 + '<a href="#" data-toggle="modal" data-target="#modalChartForBond"><i class="fa_custom fa_custom_green fa fa-filter" aria-hidden="true"></i></a>'	
            			
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
            	            text: 'Price'
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
    	    	        name: 'YTW',
    	    	        data: JSON.parse("[" + YTW + "]")
    	    	    } , {
    	    	        name: 'Price for '+ticker,
    	    	        data: JSON.parse("[" + Price + "]")                    
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
	            console.log("viewChartForHistoryByBond End");	
	            } 
            
            function getHistoryByTicker(){
				console.log("getHistoryByTicker start");
            	var metadataName="Bondpricing_Master";
            	var ticker=escape($("#filterTicker>option:selected").val());
            	
            //	alert("filterTicker"+ticker);
            	if(ticker==null || ticker=='' || ticker===undefined)
            		{
            			alert("Please Enter Ticker");
            			return true;
            		}
            	//alert("ticker"+ticker);
            	escape($('#filterBond').val(ticker));
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
							{ "data": "element1" },
							{ "data": "element99" },
							{ "data": "lastUpdatedAt" }
							
        		  ],
        		  "columnDefs":[{
        	            "targets":9,//column index
        	            "data":"element1",
        	            "render":function(data,type,row){
        	            	var len = data.length;
        	            	var mdata=row['element2'];
        	            //	alert("mdata---"+mdata);
        	            	if(data.indexOf("(") != -1){
    	                		data = data.substring(data.indexOf("(")+1,len-1);
    	                		
    	                	}else
    	                		data="";
    	                //	alert("data--"+data);
    	                	//return '<a href="#">'+data+'</a>';  
    	                //console.log("Data--> "+data+"  "+"mdata--> "+mdata);
       	                 //return '<a href="/JarvisV2/getHistoricalDataByStockAndBond?ticker='+data+'&cusip='+mdata+'">'+data+'</a>';
       	                 return '<a href="#" onclick="getHistoricalDataByStockAndBond(\''+data+'\',\''+mdata+'\')">'+data+'</a>';
        	            //	alert("mdata"+mdata);
        	            
        	         }
        	        },{
	      	            "targets":11,//column index
	      	            "data":"element1",
	      	            "render":function(data,type,row){
	      	            	var res = data.substring(0, 10);	      	            	
				   			 return res;
	      	        	 }
	      	        }],
        	        
         	        "aoColumnDefs1": [
         	           {
         	                "aTargets": [10],
         	                "mData": null,
         	                "mRender": function (data, type, full) {
         	                	         	                
            	                    return data;
            	                   
            	                // return '<a href="/JarvisV2/getHistoricalDataByStockAndBond?ticker='+data+'&cusip=">'+mData+'</a>';
         	                }
         	            }
         	         ],
         	        
         	        "order": [[ 0, "asc" ]],
        		  "scrollX": true,
        		 // "dom": 'Bfrtip',
        		 // "buttons": ['copy', 'csv', 'excel', 'pdf', 'print'],
        		 /* "dom":'lBfrtip',    // 'Bfrtip',
        		 'lengthMenu' : [
							[ 5, 10, 25, 50, -1 ],
							[ 5, 10, 25, 50, "All" ] ], */
				"dom": 'lBfrtip', //'Bfrtip',
				"lengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]], 			
        		 "buttons": [ {
		                extend : 'pdfHtml5',
		                title : function() {
		                	const months = ["JAN", "FEB", "MAR","APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
		                	let current_datetime = new Date()
		                	let formatted_date = current_datetime.getDate() + "-" + months[current_datetime.getMonth()] + "-" + current_datetime.getFullYear()
		                	console.log(formatted_date)
		                    return "Jarvis Bond for ( "+formatted_date+" )";
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
        	                		
        		/*  jQuery.ajax({
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

        			});     */          		
        	                		
        		$('#exampleParent').show();
        		$('#historyByTickerChartDiv').hide();
        		$('#exampleParentChartDiv').hide();
        		$('#filter').modal('hide');
        		$("#headerRow").show();
        		$('#buttonDiv1').show();
        		$('#stockBondParent').hide();
        		$('#buttonDiv2').hide();
        		$('#comparedisplay').hide();
        		$('#bondRankingDiv').hide();
        		$('#buttonDiv3').hide();
				console.log("getHistoryByTicker end");
            }
            
            
            function getDataByWeek (date) {
                console.log("getDataByWeek start");
            	var metadataName="Bondpricing_Master";
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
							{ "data": "element1" },
							{ "data": "element99" },
							{ "data": "lastUpdatedAt" }
							
        		  ],
        		  "columnDefs":[{
        	            "targets":9,//column index
        	            "data":"element1",
        	            "render":function(data,type,row){
        	            	var len = data.length;
        	            	var mdata=row['element2'];
        	            //	alert("mdata---"+mdata);
        	            	if(data.indexOf("(") != -1){
    	                		data = data.substring(data.indexOf("(")+1,len-1);
    	                		
    	                	}else
    	                		data="";
    	                //	alert("data--"+data);
    	                	//return '<a href="#">'+data+'</a>';  
    	                //console.log("Data--> "+data+"  "+"mdata--> "+mdata);
       	                 //return '<a href="/JarvisV2/getHistoricalDataByStockAndBond?ticker='+data+'&cusip='+mdata+'">'+data+'</a>';
       	                 return '<a href="#" onclick="getHistoricalDataByStockAndBond(\''+data+'\',\''+mdata+'\')">'+data+'</a>';
        	            //	alert("mdata"+mdata);
        	            
        	         }
        	        },{
	      	            "targets":11,//column index
	      	            "data":"element1",
	      	            "render":function(data,type,row){
	      	            	var res = data.substring(0, 10);
	      	            	
				   			 return res;
	      	        	 }
	      	        }],
        	       
        	         
         	        "aoColumnDefs1": [
         	           {
         	                "aTargets": [10],
         	                "mData": null,
         	                "mRender": function (data, type, full) {
         	                	         	                
            	                    return data;
            	                   
            	                // return '<a href="/JarvisV2/getHistoricalDataByStockAndBond?ticker='+data+'&cusip=">'+mData+'</a>';
         	                }
         	            }
         	         ],
         	       
         	        "order": [[ 0, "asc" ]],
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
		                    return "Jarvis Bond for ( "+formatted_date+" )";
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
        	                		
        		$('#exampleParent').show();
        		$('#filter').modal('hide');
        		$("#headerRow").show();
        		$('#buttonDiv1').show();
        		$('#stockBondParent').hide();
        		$('#buttonDiv2').hide();
        		$('#comparedisplay').hide();
        		$('#bondRankingDiv').hide();
        		$('#buttonDiv3').hide();
        		console.log("getDataByWeek end");
            }
            
            
            
            function getBondRanking(){ 
				console.log("getBondRanking start");
                
           	 var metadataName="Bondpricing_Master";
           	var date1="1900-01-01";
        	var date2="1900-01-01";
           	 
          // 	var url = '<%=request.getContextPath()%>/JarvisV2/getStockRanking?metadataName='+metadataName;
    		var url = '<%=request.getContextPath()%>/JarvisV2/getImportHistorySheetCompare?metadataName='+metadataName+'&date1='+date1+'&date2='+date2;

    		var oTable =  $('#bondRankingRise').DataTable();
    		oTable.destroy();
    		var oTable =  $('#bondRankingRise').dataTable( {
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
						{ "data": "bestMovePrevValue" },
						{ "data": "currytm" },
						{ "data": "prevytm" },
						{ "data": "maturityDate" }
						
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
		                    return "Jarvis Bond for ( "+formatted_date+" )";
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
    		
    		var oTable =  $('#bondRankingDrop').DataTable();
    		oTable.destroy();
    		var oTable =  $('#bondRankingDrop').dataTable( {
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
						{ "data": "worstMovePrevValue" },
						{ "data": "currytm" },
						{ "data": "prevytm" },
						{ "data": "maturityDate" }
						
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
		                    return "Jarvis Bond for ( "+formatted_date+" )";
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
								bestHtml = bestHtml + "<td>" + data[i].currytm + "</td>";
								bestHtml = bestHtml + "<td>" + data[i].prevytm + "</td>";
								bestHtml = bestHtml + "<td>" + data[i].maturityDate + "</td>";
								bestHtml = bestHtml + "</tr>";
							}			        	   
							
							$("#bondRiseTable").html(bestHtml);
							
							for(var i in data){
								console.log("worstMovedStock: "+data[i].worstMovedStock);
								worstHtml = worstHtml + "<tr>";
								worstHtml = worstHtml + "<td>" + data[i].worstMovedStock + "</td>";
								worstHtml = worstHtml + "<td>" + data[i].worstMovedBy + "</td>";
								worstHtml = worstHtml + "<td>" + data[i].percentageChangeDrop + "</td>";
								worstHtml = worstHtml + "<td>" + data[i].worstMoveCurrValue + "</td>";
								worstHtml = worstHtml + "<td>" + data[i].worstMovePrevValue + "</td>";
								worstHtml = worstHtml + "<td>" + data[i].currytm + "</td>";
								worstHtml = worstHtml + "<td>" + data[i].prevytm + "</td>";
								worstHtml = worstHtml + "<td>" + data[i].maturityDate + "</td>";
								worstHtml = worstHtml + "</tr>";
								
							}		        	   
			        	     	
							$("#bondDropTable").html(worstHtml);
			           },
			           error: function(e){				           
		           	        alert('Error in getColumns: ' + e);		           	
		           	    }

		       });   */
           	
           
           	$('#filter').modal('hide');
           	$('#comparedisplay').hide();
           	$('#bondRankingDiv').show();
           	$('#exampleParent').hide();
			$("#headerRow").hide();
			$('#buttonDiv1').show();
			$('#stockBondParent').hide();
			$('#chartDiv').hide();
			$('#buttonDiv2').hide();
			$('#comparedisplay').hide();
			$('#filter').modal('hide');
			$('#buttonDiv3').hide();
			$('#exampleParentChartDiv').hide();
			$('#historyByTickerChartDiv').hide();
           	console.log("getBondRanking end");
			}
            
            
		function getImportHistorySheetCompare(){
            		console.log("getImportHistorySheetCompare start");
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
            	var metadataName="Bondpricing_Master";
            	
            	
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
							{ "data": "bestMovePrevValue" },
							{ "data": "currytm" },
							{ "data": "prevytm" },
							{ "data": "maturityDate" }
							
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
			                    return "Jarvis Bond for ( "+formatted_date+" )";
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
							{ "data": "worstMovePrevValue" },
							{ "data": "currytm" },
							{ "data": "prevytm" },
							{ "data": "maturityDate" }
							
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
			                    return "Jarvis Bond for ( "+formatted_date+" )";
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
								bestHtml = bestHtml + "<td>" + bestFS[i].currytm + "</td>";
								bestHtml = bestHtml + "<td>" + bestFS[i].prevytm + "</td>";
								bestHtml = bestHtml + "<td>" + bestFS[i].maturityDate + "</td>";
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
								worstHtml = worstHtml + "<td>" + worstFS[i].currytm + "</td>";
								worstHtml = worstHtml + "<td>" + worstFS[i].prevytm + "</td>";
								worstHtml = worstHtml + "<td>" + worstFS[i].maturityDate + "</td>";

								
								worstHtml = worstHtml + "</tr>";
								
							}		        	   
			        	     	
							$("#worstTable").html(worstHtml);  */
							 loadBestChart(bestFS, worstFS);
			           },
			           error: function(e){				           
		           	        alert('Error in getColumns: ' + e);		           	
		           	    }

		       }); 
            	
            	$('#exampleParent').hide();
				$("#headerRow").hide();
				$('#buttonDiv1').hide();
				$('#stockBondParent').hide();
				$('#chartDiv').hide();
				$('#buttonDiv2').hide();
				$('#comparedisplay').show();
				$('#bondRankingDiv').hide();
				$('#filter').modal('hide');
				$('#buttonDiv3').show();
				$('#exampleParentChartDiv').hide();
    			$('#historyByTickerChartDiv').hide();
				console.log("getImportHistorySheetCompare end");
            }
            
            
            
            
            function getColumns(){
				console.log("getColumns start");
            	jQuery.ajax({
			    	url: '<%=request.getContextPath()%>/JarvisV2/getColumns',
			           type: "GET",
			           async:false,
			           cache: false,
			           data: "metaDataName=Bondpricing_Master",
			           dataType: "json",
			           success: function(data) {
			        	   //alert(data);
			        	   var headerHTML = "";
			        	   for(var i=0;i<data.length;i++){
			        		   headerHTML = headerHTML + "<th>" + data[i].elementDisplayName + "</th>";
			        	   }
			        	   headerHTML = headerHTML + "<th>Stock</th>";
			        	   headerHTML = headerHTML + "<th>Jarvis Rank</th>";
			        	   headerHTML = headerHTML + "<th>Date</th>";
			        	   $("#headerRow").html(headerHTML);
			        	   getImportsData(); 
			        	 //  getCalculateBond();
			           },
			           error: function(e){				           
		           	        alert('Error in getColumns: ' + e);		           	
		           	    }

		       });
            	
            console.log("getColumns end");	
            }
            
            
   function loadchart1(){
	   console.log("loadchart1 start");
	   //CLose modal
	   var year = $('#chart1FY').val();
	   var year2= $('#chart2FY').val();
	   $('#modalChart').modal('hide');
	   getHistoricalDataByStockAndBondForChart(year,year2);
	   console.log("loadchart1 end");
   }
   
						   function getCalculateBond (){
							   console.log("getCalculateBond start");
							   $('#calculateModal').modal('hide');
						
								var couponMin="";
								var couponMax="";
								var rating = $("#rating>option:selected").val();
								var treasuryYield=$("#treasuryYield").val();
								var treasuryYr=escape($("#treasuryYr>option:selected").val());
								var ytwMin=$("#ytwMin>option:selected").val();
								var ytwMax=$("#ytwMax>option:selected").val();
								var maturityMin=$("#maturityMin>option:selected").val();
								var maturityMax=$("#maturityMax>option:selected").val();
								var callable=$("#callable>option:selected").val();
								var secured=$("#secured>option:selected").val();
								var metadataName="Bondpricing_Master";
								
								
								var url = '<%=request.getContextPath()%>/JarvisV2/getCalculateBond?';
								url = url + "couponMin="+couponMin+"&couponMax="+couponMax+"&rating="+rating+"&treasuryYield="+treasuryYield+"&treasuryYr="+treasuryYr+"&ytwMin="+ytwMin+
						           "&ytwMax="+ytwMax+"&maturityMin="+maturityMin+"&maturityMax="+maturityMax+"&callable="+callable+"&secured="+secured+"&metadataName="+metadataName;
				        		
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
											{ "data": "element1" },
											{ "data": "element99" },
											{ "data": "lastUpdatedAt" }
											
				        		  ],
				        		  "columnDefs":[{
				        	            "targets":9,//column index
				        	            "data":"element1",
				        	            "render":function(data,type,row){
				        	            	var len = data.length;
				        	            	var mdata=row['element2'];
				        	            //	alert("mdata---"+mdata);
				        	            	if(data.indexOf("(") != -1){
				    	                		data = data.substring(data.indexOf("(")+1,len-1);
				    	                		
				    	                	}else
				    	                		data="";
				    	                //	alert("data--"+data);
				    	                	//return '<a href="#">'+data+'</a>';  
				    	                //console.log("Data--> "+data+"  "+"mdata--> "+mdata);
				       	                 //return '<a href="/JarvisV2/getHistoricalDataByStockAndBond?ticker='+data+'&cusip='+mdata+'">'+data+'</a>';
				       	                 return '<a href="#" onclick="getHistoricalDataByStockAndBond(\''+data+'\',\''+mdata+'\')">'+data+'</a>';
				        	            //	alert("mdata"+mdata);
				        	            
				        	         }
				        	        }],
				        	        /* "aoColumnDefs": [
				        	           {
				        	                "aTargets": [9],
				        	                "mData": null,
				        	                "mRender": function (data, type, full) {
				        	                	var len = data.length;
				        	                	if(data.indexOf("(") != -1){
				        	                		data = data.substring(data.indexOf("(")+1,len-1);
				        	                		
				        	                	}else
				        	                		data="";
				        	                
				           	                    return '<a href="#">'+data+'</a>';
				           	                   
				           	                // return '<a href="/JarvisV2/getHistoricalDataByStockAndBond?ticker='+data+'&cusip=">'+mData+'</a>';
				        	                }
				        	            }
				        	         ], */
				        	         
				         	        "aoColumnDefs1": [
				         	           {
				         	                "aTargets": [10],
				         	                "mData": null,
				         	                "mRender": function (data, type, full) {
				         	                	         	                
				            	                    return data;
				            	                   
				            	                // return '<a href="/JarvisV2/getHistoricalDataByStockAndBond?ticker='+data+'&cusip=">'+mData+'</a>';
				         	                }
				         	            }
				         	         ],
				         	        "columnDefs2":[{
					      	            "targets":11,//column index
					      	            "data":"element1",
					      	            "render":function(data,type,row){
					      	            	var res = data.substring(0, 10);
					      	            //	alert("res--"+res);
					      	            	
								   			 return res;
					      	        	 }
					      	        }],
				         	        "order": [[ 0, "asc" ]],
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
						                    return "Jarvis Bond for ( "+formatted_date+" )";
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
						
						
							console.log("getCalculateBond end");
								}
            
	function getHistoricalDataByStockAndBondForChart(year,year2){
			console.log("getHistoricalDataByStockAndBondForChart start");
					$('#exampleParent').hide();
					$("#headerRow").hide();
					$('#buttonDiv1').hide();
					$('#stockBondParent').hide();
					$('#chartDiv').show();
					$('#buttonDiv2').show();
					$('#comparedisplay').hide();
					$('#buttonDiv3').hide();
					$('#exampleParentChartDiv').hide();
        			$('#historyByTickerChartDiv').hide();
				console.log(ticker + "--" + cusip);
				//var ticker="ADT";
				//var cusip="00101JAH9";
				var ticker=$('#ticker').val();
				var cusip=$('#cusip').val();
				var stockDate = new Array();
				var bondPrice = new Array();
				var stockPrice=new Array();
				
				jQuery.ajax({
					url:'<%=request.getContextPath()%>/JarvisV2/getHistoricalDataByStockAndBondForChart',
				
					 type: "GET",
			           async:false,
			           cache: false,
			           data:"ticker="+ticker+"&cusip="+cusip+"&year="+year+"&year2="+year2, 
			           dataType: "json",
			           success: function(data) {
			        	   for (i in data) {
			        		   stockDate.push(data[i].date);
			        		   bondPrice.push(data[i].bondPrice);
			        		   stockPrice.push(data[i].stockPrice);
			               }
			        	   
			        	  // console.log("getHistoricalDataByStockAndBondForChart------"+data);
			        	  
			        	   viewChart(stockDate, bondPrice,stockPrice);  
			           },
			           error: function(e){				           
		           	        alert('Error in getHistoricalDataByStockAndBondForChart ' + e);		           	
		           	    }

		       });
        		
			console.log("getHistoricalDataByStockAndBondForChart end");
			}
            
			function findImportDatesByMonth(){
        		console.log("findImportDatesByMonth start");
        		var url = '<%=request.getContextPath()%>/JarvisV2/findImportDatesByMonth?metaDataName=Bondpricing_Master';
        		
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
        		  "lengthMenu": [[25,50, 100, 150, -1], [25,50, 100, 150, "All"]],
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
				console.log("findImportDatesByMonth end");
            }
			
			 function loadBestChart(bestFS, worstFS){
					console.log("loadBestChart start");
	            	//console.log("loadBestChart--"+bestFS);
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
					console.log("best5Perc--"+best5Perc);
					console.log("worst5Perc--"+worst5Perc);
					 
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

	            	console.log("loadBestChart end");
	            }
			
			function getHistoricalDataByStockAndBond(ticker, cusip){
				console.log("getHistoricalDataByStockAndBond start");
				$('#ticker').val(ticker);
				$('#cusip').val(cusip);
				
				console.log(ticker + "--" + cusip);
				var date = [];
				var bondPrice = [];
				var row_count = 0;
				var totalRowCount = 0;
				
				
				
				var url = '<%=request.getContextPath()%>/JarvisV2/getHistoricalDataByStockAndBond?ticker='+ticker+'&cusip='+cusip;
        		
        		var oTable =  $('#tblStockBond').DataTable();
        	//	var table_length = oTable.fnGetData().length;
        	//	var length = oTable.fnGetData().length;
        	//	alert("table_length--"+table_length+ " "+"length--"+length);
        		oTable.destroy();
        		var oTable =  $('#tblStockBond').dataTable( {
        			 oLanguage: {
       			      sLoadingRecords: '<img src="/images/loading.gif">'
       			    },
        			aaSorting: [[1, 'desc']],
        		        "ajax": {
        		            "url": url,
        		            "dataSrc": ""
        		        },
        		        "columns": [
							{ "data": "bondName" },
							{ "data": "cusip" },
							{ "data": "bondPrice" },
							{ "data": "stockName" },
							{ "data": "stockPrice" },
							{ "data": "companyName" },
							{ "data": "date" }
							/* { "data": "bondToStock" } */
							
							
        		  ],"columnDefs":[{
      	            "targets":7,//column index
    	            "data":"bondToStock",
    	            "render":function(data,type,row){
    	            	var mdata=row['date'];
    	            	date.push(mdata);
    	            	var mdata1=row['bondPrice'];
    	            	bondPrice.push(mdata1);
    	            //	alert("Length--->"+oTable.fnGetData().length);
    	            	var row=oTable.fnGetData().length;
    	            	//if(row_count == max_count) // Last loop
    	            	
    	            	//
    	            	/* var len = $('#oTable tr').length;
						var first_row = $('#oTable tr').eq(0); 
						var last_row = $('#oTable tr').eq(len - 1);
						alert("len"+len);
						alert("first_row"+first_row);
						alert("last_row"+last_row); */
						
						
    	            	
    	            	/* if(row_count == 311)
    	            		viewChart(date, bondPrice);
    	            		//(date, bondPrice);
    	            		
    	            	row_count++; */
    	            	return data;
    	            }
    	            	
    	            }],
        		  "scrollX": true,
        		  "dom": 'frtip',
        		 // "buttons": ['copy', 'csv', 'excel', 'pdf', 'print'],
        		 
        		  "pagingType": "full",
        		  "language": {
        		      "paginate": {
        		        "previous": "<<",
        		        "next": ">>"
        		      }
        		    }
        		 } );
        		
        		 /*  var tabledata = oTable.rows().data();
        		 //var tabledata = $('#tblStockBond').DataTable();
        		
        	 tabledata.each(function (value, index) {
        			console.log( 'Data in index: '+index+' is: '+value );
        			date.push();
        			bondPrice.push();
        		 }); 
        		  */

        		 
        	 
        	 /* var tbl = $('#tblStockBond').DataTable();

        		 tbl.rows().every(function () {
        	   var data = this.data();
        	   var id = this.id();
        	   console.log('Data in id: ' + id + ' index: ' + index + ' is: ' + data);
        	 });  */
        		
        	/*  var table = $('#tblStockBond').DataTable();
        	 
        	 var plainArray = table
        	     .column( 0 )
        	     .data()
        	     .toArray();
        	 console.log('Data in id: ' + plainArray); */
        		
        		/* alert("Calling viewChart() "+date.length + " " + bondPrice.length); */
            	
            	
        		$('#exampleParent').hide();
        		$("#headerRow").hide();
        		$('#buttonDiv1').hide();
        		$('#stockBondParent').show();
        		$('#buttonDiv2').show();
        		//$('#filter').modal('show');
        		$('#comparedisplay').hide();
        		$('#bondRankingDiv').hide();
        		$('#buttonDiv3').hide();
        		$('#exampleParentChartDiv').hide();
    			$('#historyByTickerChartDiv').hide();
        		console.log("getHistoricalDataByStockAndBond end");
			}
			
			function bondPerFormance(){
				console.log("bondPerFormance start");
				$('#stockBondParent').hide();
        		$('#buttonDiv2').hide();
        		$('#exampleParent').show();
        		$("#headerRow").show();
        		$('#buttonDiv1').show();
        		$('#chartDiv').hide();
        		$('#comparedisplay').hide();
        		$('#bondRankingDiv').hide();
        		$('#buttonDiv3').hide();
				console.log("bondPerFormance end");
			}
			
			function backToBond(){
				console.log("backToBond start");
				$('#stockBondParent').hide();
        		$('#buttonDiv2').hide();
        		$('#exampleParent').show();
        		$("#headerRow").show();
        		$('#buttonDiv1').show();
        		$('#chartDiv').hide();
        		$('#comparedisplay').hide();
        		$('#bondRankingDiv').hide();
        		$('#buttonDiv3').hide();
				console.log("backToBond End");
			}
			
			function gridView(){
				console.log("gridView start");
				$('#exampleParent').hide();
				$("#headerRow").hide();
        		$('#buttonDiv1').hide();
        		$('#stockBondParent').show();
        		$('#chartDiv').hide();
        		$('#buttonDiv2').show();
        		$('#comparedisplay').hide();
        		$('#bondRankingDiv').hide();
        		$('#buttonDiv3').hide();
        		$('#exampleParentChartDiv').hide();
    			$('#historyByTickerChartDiv').hide();
				console.log("gridView end");
			}
			
			/* function chartView(){
				$('#exampleParent').hide();
				$("#headerRow").hide();
        		$('#buttonDiv1').hide();
        		$('#stockBondParent').hide();
        		$('#chartDiv').show();
        		$('#buttonDiv2').show();
			} */
            
			function chartViewBond(){
				console.log("chartViewBond start");
				var ticker=escape($("#filterTicker>option:selected").val());
				//alert("chartViewBond-"+ticker);
            	
	            //	alert("filterTicker"+ticker);
	            	if(ticker==null || ticker=='' || ticker===undefined)
	            		{
	            	//	alert("chart in if");
	            		$('#exampleParent').show();
	            	//	$('#exampleParentChartDiv').show();
	            		alert("Please Select Bond");
	            		}
	            	else{
	            		getChartForHistoryByBond('2020', '2020');
			}
			console.log("chartViewBond end");
			}
			
			function gridViewBond(){
				console.log("gridViewBond start");
			var ticker=escape($("#filterTicker>option:selected").val());
            	
	            //	alert("filterTicker"+ticker);
	            	if(ticker==null || ticker=='' || ticker===undefined)
	            		{
	            		$('#exampleParent').show();
	            		$('#exampleParentChartDiv').hide();
	            		}
				$('#exampleParent').show();
        	//	$('#exampleParentChartDiv').show();
        		$('#historyByTickerChartDiv').hide();
				console.log("gridViewBond end");
			}
            function getImportsData(){
				console.log("getImportsData start");
				var metaDataName="Bondpricing_Master";
        		
        		var url = '<%=request.getContextPath()%>/JarvisV2/getImportsData?metaDataName=Bondpricing_Master';
        		
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
        		        /* "iDisplayLength": 5,
        	             "aLengthMenu": [[5, 10, 25, 50, 100, -1], [5, 10, 25, 50, 100, "All"]], */
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
							{ "data": "element1" },
							{ "data": "element99" },
							{ "data": "lastUpdatedAt" }
							
        		  ],
        		 
        		  "columnDefs":[{
        	            "targets":9,//column index
        	            "data":"element1",
        	            "render":function(data,type,row){
        	            	var len = data.length;
        	            	var mdata=row['element2'];
        	            //	alert("mdata---"+mdata);
        	            	if(data.indexOf("(") != -1){
    	                		data = data.substring(data.indexOf("(")+1,len-1);
    	                		
    	                	}else
    	                		data="";
    	                //	alert("data--"+data);
    	                	//return '<a href="#">'+data+'</a>';  
    	                //console.log("Data--> "+data+"  "+"mdata--> "+mdata);
       	                 //return '<a href="/JarvisV2/getHistoricalDataByStockAndBond?ticker='+data+'&cusip='+mdata+'">'+data+'</a>';
       	                 return '<a href="#" onclick="getHistoricalDataByStockAndBond(\''+data+'\',\''+mdata+'\')">'+data+'</a>';
        	            //	alert("mdata"+mdata);
        	            
        	         }
        	        },{
	      	            "targets":2,//column index
	      	            "data":"element3",
	      	            "render":function(data,type,row){
	      	            	var res=row['element3'];
	      	            	var data = (Math.round(res * 100) / 100).toFixed(2);	      	            	
				   			 return data;
	      	        	 }
	      	        },{
	      	            "targets":11,//column index
	      	            "data":"element1",
	      	            "render":function(data,type,row){
	      	            	var res = data.substring(0, 10);	      	            	
				   			 return res;
	      	        	 }
	      	        }],
        	              	                	         
         	        "aoColumnDefs1": [
         	           {
         	                "aTargets": [10],
         	                "mData": null,
         	                "mRender": function (data, type, full) {
         	                	         	                
            	                    return data;
            	                   
            	               
         	                }
         	            }
         	         ],
         	      
         	        "order": [[ 0, "asc" ]],
        		  "scrollX": true,
        		 /*  "dom":'lBfrtip',    // 'Bfrtip',
        		 // "buttons": ['copy', 'csv', 'excel', 'pdf', 'print'],
        		  'lengthMenu' : [
							[ 5, 10, 25, 50, -1 ],
							[ 5, 10, 25, 50, "All" ] ], */
				"dom": 'lBfrtip', //'Bfrtip',
				"lengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]], 			
        		 "buttons": [ {
		                extend : 'pdfHtml5',
		                title : function() {
		                	const months = ["JAN", "FEB", "MAR","APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
		                	let current_datetime = new Date()
		                	let formatted_date = current_datetime.getDate() + "-" + months[current_datetime.getMonth()] + "-" + current_datetime.getFullYear()
		                	console.log(formatted_date)
		                    return "Jarvis Bond for ( "+formatted_date+" )";
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
    	                		
        		/*   Parent Chart Bond
        		
        		jQuery.ajax({
        			 url: '<%=request.getContextPath()%>/JarvisV2/getImportsData',
			           type: "GET",
			           async:false,
			           cache: false,
			           data: "metaDataName="+metaDataName,
			           dataType: "json",
			           success: function(data) {
        					 
        					  var bestFS = data;
        					 
        							
        							getChartForParentBond(bestFS);
        				   },
        				   error: function(e){				           
        					//alert('Error in getColumns: ' + e);		           	
        				    }

        			});       */ 		
        	                		
        		$('#exampleParent').show();
        		$('#exampleParentChartDiv').hide();
        		$('#historyByTickerChartDiv').hide();
        		$("#headerRow").show();
        		$('#buttonDiv1').show();
        		$('#stockBondParent').hide();
        		$('#buttonDiv2').hide();
        		$('#comparedisplay').hide();
        		$('#bondRankingDiv').hide();
        		$('#buttonDiv3').hide();
				console.log("getImportsData end");
            }
			
		
			function getChartForParentBond(bestFS){
				console.log("getChartForParentBond start");
				var YTW = new Array();
	        	var Price = new Array();
				
	        	var count=0;
	        	
	        	for(var i in bestFS){
	        		
	        			YTW.push(parseFloat(bestFS[i].element3).toFixed(2));
	        			//(myVal).tofixed(2);
	        			Price.push(bestFS[i].element9);
						//changeInValue.push(bestFS[i].changeInValue);
						
	        			
	        	 	/* if(count==20)
	        			break;  */
	        		  }
	        	// console.log("YTW--"+YTW);
	        //	console.log("Price--"+Price);
	        	/*console.log("changeInValue--"+changeInValue);
	        	console.log("percentageChange--"+percentageChange);
	        	console.log("price--"+price); */
	     
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

	        	});
	            console.log("getChartForParentBond end");
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
						<li class="nav-item active">
							<!-- <a class="nav-link" href="/JarvisV2/bondimport?isUploadAllowed=<%=isUploadAllowed%>">Bonds</a> -->
							<a class="nav-link" href="#" title="" onclick="$('#frmBond').submit();">Bonds<span class="sr-only">(current)</span></a>
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
					
					  <form method="post" action="/JarvisV2/uploadFileBondImport" id="importUploadForm1" enctype="multipart/form-data">
						<div class="" style="">	
						 <!--  <input type="hidden" name="metaDataName" value="Tickers_Watchlist" /> -->
						  <!-- Vikrant Change-->
						 <input type="hidden" name="metaDataName" value="Bondpricing_Master" />
						  
						  <div id="buttonDiv1" >
						   <select class="livesearch" id="filterTicker" style="width:150px;"></select>&nbsp;<input type="button" name="" class="modalBtnWeekly" value="go" onclick="getHistoryByTicker()" />&nbsp;&nbsp;
						  
						  <span id="fileuploadSpan">
						    <input type="file" name="myfile" style="width:200px;">
							<button class="modalBtn" onclick="$('#importUploadForm1').submit();">
							<i class="fa fa-upload" aria-hidden="true"></i> Upload</button>
							</span>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="modalBtn" onclick="findImportDatesByMonth()"><i class="ti-gallery"></i></button>&nbsp;&nbsp;&nbsp;&nbsp;
							 <img src="/images/performance1.png" style="cursor: pointer;" title="performance" onclick="bondPerFormance()" alt=""> 
							<!-- <button type="button" class="modalBtn" onclick="bondPerFormance()">PerFormance</button>&nbsp;&nbsp; -->
							<button type="button" class="modalBtn" onclick="getBondRanking()">Ranking</button>&nbsp;&nbsp;
							<!-- <button class="dt-button buttons-html5" onclick="$('#filter').modal('show');">Calculate</button> -->
							<button type="button" class="modalBtn" data-toggle="modal" data-target="#calculateModal" style="margin-top: 10px">Calculate</button>&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="modalBtn" onclick="getReset()" style="margin-top: 10px">Reset</button>
						  </div>
						   <div id="buttonDiv2" style="display:none">
						   	<button type="button" class="modalBtn" onclick="gridView()" >Grid View</button>
						   	<button type="button" class="modalBtn" onclick="getHistoricalDataByStockAndBondForChart('2019','2020')" >Chart View</button>  <!-- chartView -->
						   	<button type="button" class="modalBtn" onclick="backToBond()">Back</button>
						   	
						   </div>
						   <div id="buttonDiv3" style="display:none">						   	
						   	<button type="button" class="modalBtn" onclick="backToBond()">Back</button>
						   	
						   </div>
							</div>
							</form>
					</div>
				 
				  
			 
				
					<!-- <a href="demand" title="" class="float-right viewGraph hvr-push">VIEW ALL GRAPHS</a> -->
					<!--graph section-->
					
					<br><br>
					<div id="exampleParent">
					<input type="button" name="" class="modalBtnWeekly" value="Grid View" style="float: right; margin-bottom: 10px" onclick="gridViewBond()" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="" class="modalBtnWeekly" style="float: right;  margin-right: 10px; margin-bottom: 10px;" value="Chart View" onclick="chartViewBond()" /><br><br>
					
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
     
     <div id="exampleParentChartDiv" style="display:none">
						<input type="button" name="" class="modalBtnWeekly" value="Grid View" style="float: right;" onclick="gridViewBond()" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="" class="modalBtnWeekly" style="float: right; margin-right: 10px; " value="Chart View" onclick="chartViewBond()" /><br><br>
	
		CHART
		<div id="chart7">  
		   
		</div>
	</div>
	
	<div id="historyByTickerChartDiv" style="display:none">
	<input type="hidden" id="filterBond" name="filterBond" value=""/>
	<input type="button" name="" class="modalBtnWeekly" value="Grid View" style="float: right;" onclick="gridViewBond()" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="" class="modalBtnWeekly" style="float: right;  margin-right: 10px; " value="Chart View" onclick="chartViewBond()" /><br><br>
	
		CHART
		<div id="chart8">  
		   
		</div>
	</div>
    
    
    <div id="bondRankingDiv">
		<div>
			
					
					<table id="bondRankingRise" class="display" style="width:100%">
	<thead>
	    <tr>
				<th>Most Risen Stock</th>
				<th>Price Risen By</th>
				<th>% In Rise</th>
				<th>Current Price</th>
				<th>Previous Price</th>
				<th>Current YTM</th>
				<th>Previous YTM</th>
				<th>Maturity</th>
	    </tr>
	</thead>
	<tbody id="bondRiseTable">
	   
	</tbody>
	</table>

				</div>  <br><br><br>
				
				
				<div>
				<table id="bondRankingDrop" class="display" style="width:100%">
					<thead>
	    <tr>
				<th>Most Dropped Stock</th>
				<th>Price Dropped By</th>
				<th>% In Drop</th>
				<th>Current Price</th>
				<th>Previous Price</th>
				<th>Current YTM</th>
				<th>Previous YTM</th>
				<th>Maturity</th>
	    </tr>
	</thead>
	<tbody id="bondDropTable">
	   
	</tbody>

	</table>







				</div>
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
				<th>Current YTM</th>
				<th>Previous YTM</th>
				<th>Maturity</th>
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
				<th>Current YTM</th>
				<th>Previous YTM</th>
				<th>Maturity</th>
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
    
    <div id="stockBondParent">
    <table id="tblStockBond" class="display" style="width:100%" style="display:none">
    				<input type="hidden" id="ticker" name="ticker" value=""/>
					<input type="hidden" id="cusip" name="cusip" value=""/>
        <thead>
            <tr id="headerRow">
                <th>bondName</th>
				<th>cusip</th>
				<th>bondPrice</th>
				<th>stockName</th>
				<th>stockPrice</th>
				<th>companyName</th>
				<th>date</th>
				<th>bondToStock</th>
            </tr>
        </thead>
        <tbody>
           	
        </tbody>
    </table>
	</div>
	<div id="chartDiv" style="display:none">
		<div id="chart6">  
		   
		</div>
					
  <script type="text/javascript">
  
function viewChart(stockDate,bondPrice,stockPrice){
	var stockPriceStr=stockPrice.toString().split(",");
	
	  var chartYear1 = $('#chart1FY').val();
	  var chartYear2 = $('#chart2FY').val();
	  
	 // alert("chartYear--"+chartYear);
	 // $('#year').val(chartYear);
	//  alert("year"+year);
	// stockPriceStr=Object.values(stockPrice);                  //stockPrice.values();                     //stockPrice.constructor;
	console.log("Object"+Object.values(stockPrice));
	console.log("date---"+stockDate+" "+"bondPrice"+bondPrice+" "+"stockPrice"+stockPrice+" "+"stockPriceStr"+stockPriceStr);
	console.log("date---"+stockDate.length+" "+"bondPrice"+bondPrice.length+" "+"stockPrice"+stockPrice.length+" "+"stockPriceStr"+stockPriceStr.length);
	
	
	Highcharts.chart('chart6', {
	    chart: {
	        type: 'line'
	    },
	    title: {
	        //text: 'Loss Ratio'
			useHTML: true,
			text: 'Year: ' + chartYear1+'-'+ chartYear2 + '<a href="#" data-toggle="modal" data-target="#modalChart"><i class="fa_custom fa_custom_green fa fa-filter" aria-hidden="true"></i></a>'	
			
	    },
	    subtitle: {
	        text: ''
	    },
	    xAxis: {
	        categories: stockDate,
	        title: {
	            text: 'Date'
	        }
	    },
	    yAxis: {
	    	 categories: bondPrice,
	        title: {
	            text: 'Bond Price'
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
	        name: 'Bond Price',
	        data: JSON.parse("[" + bondPrice + "]")
	    } , {
	        name: 'Stock Price',
	        data: JSON.parse("[" + stockPrice + "]")                     //stockPriceStr
	    } ]
	});
	
	
	
	
	
	
/* Highcharts.chart('chart6', {
    chart: {
        type: 'line'
    },
    title: {
        //text: 'Loss Ratio'
		useHTML: true,
		text: 'Loss Ratio <span style="display:inline-block; text-align:right; margin-left:50px;"><a href="#" data-toggle="modal" data-target="#modal2"><i class="fa_custom fa_custom_green fa fa-filter" aria-hidden="true"></i></a></span>'		
    },
    subtitle: {
        text: ''
    },
    xAxis: {
    	categories: date,
        title: {
            text: 'Date'
        }
    },
    yAxis: {
    	/* categories: bondPrice,
        title: {
            text: 'Price'
        } */ /*
        
        title: {
            text: 'Price'
        },
        labels: {
            formatter: function () {
                return bondPrice;
            }
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
        name: 'Bond Price',
        data: bondPrice
    }, {
        name: 'Stock Price',
        data: bondPrice
    }]
});
 */
}
</script>		
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
						<h2>Import History - Bond</h2>
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
						<input type="submit" class="modalBtn" id="vali" onclick="getImportHistorySheetCompare()" name="submit" value="Compare"/>
					</div>
				</form>
				</div>
			</div>
		
		</div>
		<!-- end Modal -->


	<!-- The Modal -->
	<div class="modal" id="calculateModal">
			<div class="modal-dialog">
			<!--   <form name="bondCalcForm"> -->
				<div class="modal-content" style="width:100%;">
					<!-- Modal Header -->
					<div class="filter-header">
						<img src="/images/filter-violet.PNG" alt="">
						<h2>Analysis - Bond</h2>
						<a href="#" title="" class="close" data-dismiss="modal"><i class="fa fa-window-close" aria-hidden="true"></i></a>
					</div>
					<!-- Modal body -->
					<div class="modal-body">
			          <form action="" method="post">
							<div class="row">
							<div class="col-md-4">
							<div class="filterBlock">
							                      <div class="selectBox">
							                       <!-- <label>&nbsp;</label> -->
							       Rating<br>             
							       <select id="rating" >
							         <option value="Any">Any</option>
							         <option value="AAA">AAA</option>
										<option value="AA">AA</option>
										<option value="A">A</option>
										<option value="BBB">BBB</option>
										<option value="BB">BB</option>
										<option value="B">B</option>
										<option value="CCC">CCC</option>
										<option value="CC">CC</option>
										<option value="C">C</option>
							         </select><br><br>
							        </div>
							        </div>
							        </div>
							        <div class="col-md-4">
							<div class="filterBlock">
							                      <div class="selectBox">
							                       <!-- <label>&nbsp;</label> -->            
							       Treasury Yield<input type="text" name="" id="treasuryYield" class="form-control"><br><br>
							        </div>
							        </div>
							        </div>
							        <div class="col-md-4">
							<div class="filterBlock">
							                      <div class="selectBox">
							                       <!-- <label>&nbsp;</label> -->
							       Year<br>
							       <select id="treasuryYr">
							         <option value="Any">Any</option>
							         <option value="0-1">0-1</option>
									    <option value="1-3">1-3</option>
									    <option value="3-5">3-5</option>
									    <option value="5-7">5-7</option>
									    <option value="7-10">7-10</option>
									    <option value="10-20">10-20</option>
									    <option value="20+">20+</option>
							         </select><br><br>
							        </div>
							        </div>
							        </div>
							        </div>
							         <div class="row">
							<div class="col-md-4">
							<div class="filterBlock">
							                      <div class="selectBox">
							                       <!-- <label>&nbsp;</label> -->
							       Maturity Range(Min):<br>            
							       <select id="maturityMin">
							         <option value="Any">Any</option>
							         <option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
										<option value="15">15</option>
										<option value="20">20</option>
										<option value="30">30</option>
							         </select><br><br>
							        </div>
							        </div>
							        </div>
							        
							        <div class="col-md-4">
							<div class="filterBlock">
							                      <div class="selectBox">
							                       
							       Maturity Range(Max):<br>
							       <select  id="maturityMax">
							         <option value="Any">Any</option>
							          <option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
										<option value="15">15</option>
										<option value="20">20</option>
										<option value="30">30</option>
							         </select><br><br>
							        </div>
							        </div>
							        </div>
							        </div>
							        <div class="row">
							<div class="col-md-4">
							<div class="filterBlock">
							                      <div class="selectBox">
							                       
							       YTM Range(Min):<br>              
							       <select id="ytwMin" >
							         <option value="Any">Any</option>
							        <option value="1">1.0</option>
							         <option value="2">2.0</option>
							         <option value="3">3.0</option>
							         <option value="4">4.0</option>
							         <option value="5">5.0</option>
							         <option value="6">6.0</option>
							         <option value="7">7.0</option>
							         <option value="8">8.0</option>
							         <option value="9">9.0</option>
							         <option value="10">10.0</option>
							         <option value="11">11.0</option>
							         <option value="12">12.0</option>
							         </select><br><br>
							        </div>
							        </div>
							        </div>
							        
							        <div class="col-md-4">
							<div class="filterBlock">
							                      <div class="selectBox">
							                       <!-- <label>&nbsp;</label> -->
							       YTM Range(Max):<br>
							       <select id="ytwMax" >
							         <option value="Any">Any</option>
							        <option value="1">1.0</option>
							         <option value="2">2.0</option>
							         <option value="3">3.0</option>
							         <option value="4">4.0</option>
							         <option value="5">5.0</option>
							         <option value="6">6.0</option>
							         <option value="7">7.0</option>
							         <option value="8">8.0</option>
							         <option value="9">9.0</option>
							         <option value="10">10.0</option>
							         <option value="11">11.0</option>
							         <option value="12">12.0</option>
							         </select><br><br>
							        </div>
							        </div>
							        </div>
							        </div>
							        <div class="row">
							<div class="col-md-4">
							<div class="filterBlock">
							                      <div class="selectBox">
							                       <!-- <label>&nbsp;</label> -->
							       Callable:<br>             
							       <select id="callable" >
							         <option value="Any">Any</option>
							         <option value="Yes">Yes</option>
							         <option value="No">No</option> 
							         </select><br><br>
							        </div>
							        </div>
							        </div>
							        
							        <div class="col-md-4">
							<div class="filterBlock">
							                      <div class="selectBox">
							                       <!-- <label>&nbsp;</label> -->
							       Secured:<br>
							       <select id="secured">
							         <option value="Any">Any</option>
							        <option value="Yes">Yes</option>
							         <option value="No">No</option>
							         </select><br><br>
							        </div>
							        </div>
							        </div>
							        </div>
							<!-- </form> -->
							        </div>
					
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="modalBtn modalBtnCancel" data-dismiss="modal">Cancel</button>
						<input type="button" class="modalBtn" id="vali" name="submit" onclick="getCalculateBond()" value="Search"/>
					</div>
				</div>
				</form>
			</div>
		
		</div>
		<!-- end Modal -->
	
		
		<!-- Modal1 -->
<div class="modal fade" id="modalChart" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
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
    <select class="form-control" id="chart1FY" >
      <option value="2020" selected>2020</option>	
      <option value="2019">2019</option>
      <option value="2018">2018</option>
      <option value="2017">2017</option>
      <option value="2016">2016</option>
    </select>
  </div>
  <div class="form-group">
    <label for="exampleFormControlSelect2">End Date</label>
    <select class="form-control" id="chart2FY">
	  <option value="2020" selected>2020</option>	
      <option value="2019">2019</option>
      <option value="2018">2018</option>
      <option value="2017">2017</option>
      <option value="2016">2016</option>
    </select>
  </div> 
  <button type="button" class="btn btn-primary" onclick="loadchart1()">Apply</button>
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


<!-- Modal1 -->
<div class="modal fade" id="modalChartForBond" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
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
    <select class="form-control" id="chart1FYBond" >
      <option value="2020" selected>2020</option>	
      <option value="2019" >2019</option>
      <option value="2018">2018</option>
      <option value="2017">2017</option>
      <option value="2016">2016</option>
    </select>
  </div>
  <div class="form-group">
    <label for="exampleFormControlSelect2">End Date</label>
    <select class="form-control" id="chart2FYBond">
	  <option value="2020" selected>2020</option>	
      <option value="2019">2019</option>
      <option value="2018">2018</option>
      <option value="2017">2017</option>
      <option value="2016">2016</option>
    </select>
  </div> 
  <button type="button" class="btn btn-primary" onclick="loadchartForBond()">Apply</button>
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
	