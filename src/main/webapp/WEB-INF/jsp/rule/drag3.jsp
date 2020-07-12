
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<title>Rule Engine</title>
<style type="text/css" media="Screen">




/*\*/
@import url("/rule/css/layout-1-master.css"); /**/
#tabContainer {
	padding: 25px 15px 0 15px;
	background: #67A897;
}


#myUL {
  margin: 0;
  padding: 0;
}

#myULComp{
  margin: 0;
  padding: 0;
}

.caret {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}

.caret::before {
  content: '\25B6';
  color: black;
  display: inline-block;
  margin-right: 6px;
  /*margin-left: 40px;*/
}

.caret-down::before {
  -ms-transform: rotate(90deg); /* IE 9 */
  -webkit-transform: rotate(90deg); /* Safari */'
  transform: rotate(90deg);  
}

.nested {
  display: none;
}

.active {
  display: block;
}
#fieldClass {
	border: 1px solid #ccc;
	color: #333;
	font-size: 90%;
	line-height: 1.4em;
	padding: 5px;
	margin: 0 0 15px 2px;
	width: 186px;
}

ul#topTab {
	list-style-type: none;
	width: 100%;
	position: relative;
	height: 27px;
	font-size: 13px;
	font-weight: bold;
	margin: 0;
	padding: 11px 0 0 0;
}

ul#topTab li {
	display: block;
	float: left;
	margin: 0 0 0 4px;
	height: 27px;
}

ul#topTab li.left {
	margin: 0;
}

ul#topTab li a {
	display: block;
	float: left;
	color: #fff;
	background: #4A6867;
	line-height: 27px;
	text-decoration: none;
	padding: 0 17px 0 18px;
	height: 27px;
}

ul#topTab li a.right {
	padding-right: 19px;
}

ul#topTab li a:hover {
	background: #2E4560;
}

ul#topTab li a.current {
	color: #2E4560;
	background: #fff;
}

ul#topTab li a.current:hover {
	color: #2E4560;
	background: #fff;
}

.column {
  float: left;
   /* Should be removed. Only for demonstration */
}
.inner {
    width:300px;
    border:1px solid white;
    position:relative; right:0
}
.outer {
    width:200px;
    height:100px;
    margin:0 auto;
    position:relative
}

table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: #dddddd;
}

</style>
 <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"> -->
<script language="JavaScript" type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.2.6/jquery.min.js"></script>
<script language="JavaScript" type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.5.2/jquery-ui.min.js"></script>
<script language="JavaScript" type="text/javascript"
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.5.1/chosen.min.css">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.5.1/chosen.jquery.min.js"></script> -->
 <!--<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">  --> 

<script language="JavaScript" type="text/javascript">

var benefits = [];
var compoundBenefit=[];
var evaluateBenefit=[];
var quotationBenefit=[];


	$(document).ready(function() {
	// $(".livesearch").chosen();
	findAllParams();
	findMainBenefit();
	findMainBenefitComp();
	findMainBenefitEvaluate();
	findMainBenefitQuotation();
	
	var radioCompound=$("input[name='ruleTypecomp']:checked").val();
	//alert(radioCompound);

		$(function () {
			$('input[name="ruleTypecomp"]:radio').change(function () {
				var radioCompound=$("input[name='ruleTypecomp']:checked").val();
				if(radioCompound=="riskPrenium"){
						$('#riskPremiumComDiv').show();
						$('#coverageComDiv').hide();
						$('#mainriskDiv').show();
				}else{
					$('#riskPremiumComDiv').hide();
						$('#coverageComDiv').show();
						$('#mainriskDiv').show();
	}
			});
		});
		
	$("#familySize").change(function() {
     var val = $(this).val(); 
     var tblLength = 0;
	 if(val=="M+1") tblLength = 2;
	 if(val=="M+2") tblLength = 3;
     
	 var tblHtml = "<table class='familyDetails'>";
	 tblHtml = tblHtml + "<thead> <tr> <th>Gender</th>  <th>Age</th>";
	 tblHtml = tblHtml + "</tr> </thead> <tbody>";  
     var k=0;                  	
	 for(k = 0; k < tblLength; k++) {
       // alert(k);
		tblHtml = tblHtml +"<tr>";
	    tblHtml = tblHtml +"<td><select class='inputValue'><option value='Male'>Male</option><option value='Female'>Female</option></select></td>";
		tblHtml = tblHtml +"<td><input class='inputValue' type='text' /></td>";
		tblHtml = tblHtml +"</tr>";
	 }
	 tblHtml = tblHtml + "</tbody></table>";
	 $("#tblDivQuot").html(tblHtml);  
  
	});

		
		
		$("ul[id*=tabUL] li").click(function () {
              //  alert($(this).html()); // gets innerHTML of clicked li
               // alert($(this).text()); // gets text contents of clicked li
				if($(this).text()=="Simple Rule"){
					$('#simpleRule').show();
					$('#compoundRule').hide();
					$('#evaluateRule').hide();
					$('#quotationRule').hide();
					
				}else if($(this).text()=="Compound Rule"){
					$('#simpleRule').hide();
					$('#compoundRule').show();
					$('#evaluateRule').hide();
					$('#quotationRule').hide();
					
			}else if($(this).text()=="Evaluate Claim"){
					$('#simpleRule').hide();
					$('#compoundRule').hide();
					$('#evaluateRule').show();
					$('#quotationRule').hide();
			}
			else{
					$('#simpleRule').hide();
					$('#compoundRule').hide();
					$('#evaluateRule').hide();
					$('#quotationRule').show();
		}
            });

/*
$("#ClickBenefit li").click(function() {
     var idParent = $(this).attr('id');
    // alert(idParent);
	findSubbenefitByID(idParent);
});

		/* For Simple Rule*/

		
		$('#ClickBenefit li').click(function() { 
		//alert($(this).text());
		createListDynamically($(this).text(), 'P' );
		var idParent = $(this).attr('id');
		findSubbenefitByID(idParent);
		//alert(idParent);
		benefits.push(idParent);
		return false
	});

	

		$('#parameterSimple li').click(function() {
			//alert($(this).text());
			$("#txtMessage").val("");
			$("#txtMessage").insertAtCaret($(this).text());
			return false
		});
		$('#operatorSimple li').click(function() {
			$("#txtMessage").insertAtCaret($(this).text());

			return false
		});

		$('#mainBenefit li').click(function() {
			$("#txtMessageBenefit").insertAtCaret($(this).text());
			return false
		});
		$('#subBenefit li').click(function() {
			$("#txtMessageBenefit").insertAtCaret($(this).text());

			return false
		});

		/* For Compound Rule*/
		
		$('#ClickBenefitComp li').click(function() { 
		//alert($(this).text());
		var idParent = $(this).text();
		compoundBenefit.push(idParent);
		findAllProductSimpleRule(idParent);
		//findSubbenefitByIDComp(idParent);
		createListDynamicallyComp($(this).text(), 'P' );
		return false
	});

		$('#ClickBenefitEvalute li').click(function() { 
		//alert($(this).text());
		var idParent = $(this).text();
		evaluateBenefit.push(idParent);
		createListDynamicallyEval($(this).text(), 'P' );
		return false
	});

		$('#ClickBenefitQuotation li').click(function() { 
		alert($(this).text());
		var benefitObj = new Object();
		benefitObj.benefitName="";
		var idParent = $(this).text();
		benefitObj.benefitName=idParent;	
		quotationBenefit.push(benefitObj);
		createListDynamicallyQuot($(this).text(), 'P' );
		return false
	});

/*	$('#ClickSubBenefitComp li').click(function() { 
		//alert($(this).text());
		createListDynamicallyComp($(this).text(), 'C');
		return false
	}); */
		 

		$('#operatorCom li').click(function() {
			$("#txtMessageCom").insertAtCaret($(this).text());

			return false
		});

		$('#mainBenefitCom li').click(function() {
			$("#txtMessageBenefitCom").insertAtCaret($(this).text());
			return false
		});
		$('#subBenefitCom li').click(function() {
			$("#txtMessageBenefitCom").insertAtCaret($(this).text());

			return false
		});

		/* $("#DragWordList li").draggable({helper: 'clone'});
		 $(".txtDropTarget").droppable({
		 accept: "#DragWordList li",
		 drop: function(ev, ui) {
		 $(this).insertAtCaret(ui.draggable.text());
		 }
		 }); */
	});


	

	$.fn.insertAtCaret = function(myValue) {
		return this.each(function() {
			//IE support
			if (document.selection) {
				this.focus();
				sel = document.selection.createRange();
				sel.text = myValue;
				this.focus();
			}
			//MOZILLA / NETSCAPE support
			else if (this.selectionStart || this.selectionStart == '0') {
				var startPos = this.selectionStart;
				var endPos = this.selectionEnd;
				var scrollTop = this.scrollTop;
				this.value = this.value.substring(0, startPos) + myValue
						+ this.value.substring(endPos, this.value.length);
				this.focus();
				this.selectionStart = startPos + myValue.length;
				this.selectionEnd = startPos + myValue.length;
				this.scrollTop = scrollTop;
			} else {
				this.value += myValue;
				this.focus();
			}
		});
	};

</script>
 <script type="text/javascript">
	


function findMainBenefitQuotation(){
	
	 jQuery.ajax({
	    	url: 'http://localhost:8088/findSimpleStructureRule',          //'http://localhost:8089/findAllProductSimpleRule',
	           type: "GET",
	           async:false,
	           cache: false,
	           data:"",
	           dataType: "json",
	           success: function(data) {
	        	  console.log("findMainBenefit"+data.benefitName)
	        	 //  var selectHtml = "<option value=''>--Fields--</option> ";
	        	 var selectHtml = "";
	            	 for(var x = 0; x < data.length ; x ++){
	            		
						
	            		 selectHtml = selectHtml + "<li class='caret' style='list-style-type:none;padding-left: 40px;'>"+data[x].benefitStr+"</li>";
	            	 }
	            	 
	            	 
					 	
	            	 $("#ClickBenefitQuotation").html(selectHtml);
						

	            	
	           },
	           error: function(e){				           
          	       // alert('Error: ' + e);		          
          	   }

      });


}
	

function findMainBenefitEvaluate(){
	
	 jQuery.ajax({
	    	url: 'http://localhost:8088/findSimpleStructureRule',          //'http://localhost:8089/findAllProductSimpleRule',
	           type: "GET",
	           async:false,
	           cache: false,
	           data:"",
	           dataType: "json",
	           success: function(data) {
	        	  console.log("findMainBenefit"+data.benefitName)
	        	 //  var selectHtml = "<option value=''>--Fields--</option> ";
	        	 var selectHtml = "";
	            	 for(var x = 0; x < data.length ; x ++){
	            		
						
	            		 selectHtml = selectHtml + "<li class='caret' style='list-style-type:none;padding-left: 40px;'>"+data[x].benefitStr+"</li>";
	            	 }
	            	 
	            	 
					 	
	            	 $("#ClickBenefitEvalute").html(selectHtml);
						

	            	
	           },
	           error: function(e){				           
          	       // alert('Error: ' + e);		          
          	   }

      });


}


function findMainBenefitComp(){
	
	 jQuery.ajax({
	    	url: 'http://localhost:8088/findSimpleStructureRule',          //'http://localhost:8089/findAllProductSimpleRule',
	           type: "GET",
	           async:false,
	           cache: false,
	           data:"",
	           dataType: "json",
	           success: function(data) {
	        	  console.log("findMainBenefit"+data.benefitName)
	        	 //  var selectHtml = "<option value=''>--Fields--</option> ";
	        	 var selectHtml = "";
	            	 for(var x = 0; x < data.length ; x ++){
	            		
						
	            		 selectHtml = selectHtml + "<li class='caret' style='list-style-type:none;padding-left: 40px;'>"+data[x].benefitStr+"</li>";
	            	 }
	            	 
	            	 
					 	
	            	 $("#ClickBenefitComp").html(selectHtml);
						

	            	
	           },
	           error: function(e){				           
          	       // alert('Error: ' + e);		          
          	   }

      });


}



function findSubbenefitByIDComp(idParent){
	// var idParent=idParent;  var param = "ruleText=" + ruleText
	//alert("findSubbenefitByID="+idParent);	

	
	 jQuery.ajax({
	    	url: 'http://localhost:8088/findSubbenefitByID',          //'http://localhost:8089/findAllProductSimpleRule',
	           type: "GET",
	           async:false,
	           cache: false,
	           data:"idParent="+idParent,
	           dataType: "json",
	           success: function(data) {
	        	  console.log("findMainBenefit"+data.benefitName)
	        	 //  var selectHtml = "<option value=''>--Fields--</option> ";
	        	 var selectHtml = "";
	            	 for(var x = 0; x < data.length ; x ++){
	            		
	            		 selectHtml = selectHtml + "<li style='list-style-type:none;padding-left: 40px;'id='"+data[x].id+"'>"+data[x].benefitName+"</li>";
				//	 selectHtml = selectHtml + "<li style='list-style-type:none;padding-left: 40px;'>"+data[x].benefitName+"</li>";

	            	 }
	            	 
					   $("#ClickSubBenefitComp").html(selectHtml);	
	            	//findSubbenefitByID();

					$('#ClickSubBenefitComp li').click(function() { 
							
							createListDynamicallyComp($(this).text(), 'C');
							var idChild = $(this).attr('id');
							//alert(idChild);
							benefits.push(idChild);
							return false
								
							
						});
						
						
	            	
	           },
	           error: function(e){				           
          	       // alert('Error: ' + e);		          
          	   }

      });
}

function resetQuotation(){

	$("#listDivQuotation").html("");
    $("#tblDivQuot").html("");
    $("#quotationResult").html("");
	$("#familySize").val("");
}

function searchRuleForQuotation(){
		
//var header = $td.closest('.familyDetails').find('th').eq($td.index());



	  var benefiStr = quotationBenefit;
		
	   var familySize=escape($("#familySize>option:selected").val());	
      
		var ruleObjArr = new Array();
      var rulejson = new Object();
     // alert(familySize);
    //  rulejson.name = "Simple Rule:";
      
	 // rulejson.benefit=	benefits;

        var data = $(".familyDetails tr").map(function (index, elem) {
     	var columnIndex = 0; 
		var valuearr = new Array();
		
        $('.inputValue', this).each(function () {

			var ruleObj = new Object();
      
			ruleObj.paramName = ""; 
			ruleObj.paramVal = "";
			

            var d = $(this).val() || $(this).text();
          
			var tmpRule = "";
			if(columnIndex == 0){
				if(d!=''){
					ruleObj.paramName="Gender";
					ruleObj.paramVal =d;					
					//alert("ruleObj="+ruleObj.paramVal);
				}
			}
			else if(columnIndex == 1){
				if(d!=''){
					ruleObj.paramName="Age";
					ruleObj.paramVal =d;
					//alert("ruleObj Age="+ruleObj.paramVal);
				}
				
			} 
			
            columnIndex++;
			//alert("Final="+valuearr.push(ruleObj));
			if(d!='') {
				valuearr.push(ruleObj);
				
			}
        });
		if(valuearr.length >0) ruleObjArr.push(valuearr);
    });

     	
			rulejson.values = ruleObjArr;
			rulejson.benefiStr=benefiStr;
			rulejson.familySize=familySize;
			var string = JSON.stringify(rulejson);
      var jsondata = JSON.parse(string);
	  console.log("string--"+string);

		jQuery.ajax({
			    	url: 'http://localhost:8088/searchRuleForQuotation',
			           type: "POST",
			           async:false,
			           cache: false,
			           data: JSON.stringify(rulejson),
					   contentType:"application/json",
			           dataType: "json",
			           success: function(data) {
			        	  // alert(data.msg);
							console.log("searchRuleForQuotation="+JSON.stringify(data));
							var htmlStr = "";
							var temp = "";
							var total=0;
							for(var i=0; i<data.length; i++){
								var innerList = data[i];
								var rpVal = 0;
								
								for(var j=0; j<innerList.length; j++){


									if(innerList[j].paramName == 'RiskPremium' && innerList[j].paramVal != "0.0"){
										
										rpVal = innerList[j].paramVal;
										total = +total + +rpVal;
										
										
									}
									if(innerList[j].paramName != 'RiskPremium' && rpVal != 0){
										//alert("if="+rpVal);
										if(j==(innerList.length-1))
											temp = temp +innerList[j].paramName+"="+innerList[j].paramVal +" Risk Premium = Rs."+rpVal+" For Benefit= "+innerList[j].benefit+" ";
										else
											temp = temp +innerList[j].paramName+"="+innerList[j].paramVal +" ";
									}
									if(j==(innerList.length-1)){
										temp=temp+"<br>";
										}
									
								//	htmlStr = htmlStr+temp+rpVal+"<br>";
									
								}
							}
		        			temp = temp + "<br> Total Quotation Value = Rs."+total;
							$("#quotationResult").html(temp);
						
			           },
			           error: function(e){				           
		           	        alert('Error : ' + e);		           	
		           	    }

		       });  
	  	
	
	
}


function resetEvaluate(){
	$("#age").val("");
	$("#claimAmount").val("");
	$("#listDivEvalute").html("");
	$('input[name="gender"]').attr('checked', false);	
}


function saveEvaluateRule() {
    //  var benefit = $("#benefit>option:selected").val();
    //  var subbenefit = $("#subbenefit>option:selected").val();
	var benefiStr = evaluateBenefit;
      var age = $("#age").val();
      //var gender=document.getElementsByName('gender');
      var gender = $("input:radio[name=gender]:checked").val()
      var coverType = $("coverType>option:selected").val();
	  var claimAmount=$("#claimAmount").val();	



      var param = "benefiStr=" + benefiStr + "&age=" + age + "&gender=" + gender+"&coverType="+coverType+"&claimAmount="+claimAmount;

      //alert("parrrram------>"+param);

		jQuery.ajax({
			  url: 'http://localhost:8088/searchRule',
	           type: "POST",
	           async:false,
	           cache: false,
	           data:param,

      dataType: "json",
      success: function (data) {
        if (data.claimResponse == 'Failed') {
			var html="Claim failed due to <br>";
          for (var i = 0; i < data.claimErrors.length; i++) {
            html=html+(data.claimErrors[i].name+" : "+data.claimErrors[i].value+" <br> ");
           // $('#myData').html(html);
          }
			
			$('#myData').html(html);
          //console.log(data.claimErrors);
        }
        else if (data.claimResponse == 'Passed') {
          console.log(data.allowedLimit);
			var html="";
			 if(data.allowedLimit!="-1") 
				html= data.allowedLimit;
			 else
             	html="Claim processed successfully";
			 $('#myData').html(html);
        }
        //alert("Successfully submit");


      },
      error: function (e) {
        alert('Error: ' + e);
      }

    });



    }


function findMainBenefit(){
	

	
	 jQuery.ajax({
	    	url: 'http://localhost:8088/findMainBenefit',          //'http://localhost:8089/findAllProductSimpleRule',
	           type: "GET",
	           async:false,
	           cache: false,
	           data:"",
	           dataType: "json",
	           success: function(data) {
	        	  console.log("findMainBenefit"+data.benefitName)
	        	 //  var selectHtml = "<option value=''>--Fields--</option> ";
	        	 var selectHtml = "";
	            	 for(var x = 0; x < data.length ; x ++){
	            		
	            		 selectHtml = selectHtml + "<li style='list-style-type:none;padding-left: 40px;'id='"+data[x].id+"'>"+data[x].benefitName+"</li>";
	            	 }
	            	 
	            	 $("#ClickBenefit").html(selectHtml);
					 	
	            	
	            	
	           },
	           error: function(e){				           
          	       // alert('Error: ' + e);		          
          	   }

      });


}


function findSubbenefitByID(idParent){
	// var idParent=idParent;  var param = "ruleText=" + ruleText
	//alert("findSubbenefitByID="+idParent);	

	
	 jQuery.ajax({
	    	url: 'http://localhost:8088/findSubbenefitByID',          //'http://localhost:8089/findAllProductSimpleRule',
	           type: "GET",
	           async:false,
	           cache: false,
	           data:"idParent="+idParent,
	           dataType: "json",
	           success: function(data) {
	        	  console.log("findMainBenefit"+data.benefitName)
	        	 //  var selectHtml = "<option value=''>--Fields--</option> ";
	        	 var selectHtml = "";
	            	 for(var x = 0; x < data.length ; x ++){
	            		
	            		 selectHtml = selectHtml + "<li style='list-style-type:none;padding-left: 40px;'id='"+data[x].id+"'>"+data[x].benefitName+"</li>";
				//	 selectHtml = selectHtml + "<li style='list-style-type:none;padding-left: 40px;'>"+data[x].benefitName+"</li>";

	            	 }
	            	 
	            	 $("#ClickSubBenefit").html(selectHtml);
	            	//findSubbenefitByID();

					$('#ClickSubBenefit li').click(function() { 
							
							createListDynamically($(this).text(), 'C');
							var idChild = $(this).attr('id');
							//alert(idChild);
							benefits.push(idChild);
							return false
								
							
						});
						
						
	            	
	           },
	           error: function(e){				           
          	       // alert('Error: ' + e);		          
          	   }

      });
}

function findAllParams(){
	
	
	 jQuery.ajax({
	    	url: 'http://localhost:8088/findAllParams',          //'http://localhost:8089/findAllProductSimpleRule',
	           type: "GET",
	           async:false,
	           cache: false,
	           data:"",
	           dataType: "json",
	           success: function(data) {
	        	  console.log("findAllParams"+data.typeName)
	        	 //  var selectHtml = "<option value=''>--Fields--</option> ";
	        	 var selectHtml = "";
	            	 for(var x = 0; x < data.length ; x ++){
	            		
	            		 selectHtml = selectHtml + "<li style='list-style-type:none;padding-left: 40px;'title='"+data[x].helpText+"'>"+data[x].typeName+"</li>";
	            	 }
	            	 
	            	 $("#parameterSimple").html(selectHtml);
	            	
	            	
	           },
	           error: function(e){				           
          	       // alert('Error: ' + e);		          
          	   }

      });
}

function findAllProductSimpleRule(idParent){
	
	
	
	 jQuery.ajax({
	    	url: 'http://localhost:8088/findAllProductSimpleRule',          //'http://localhost:8089/findAllProductSimpleRule',
	           type: "GET",
	           async:false,
	           cache: false,
	           data:"idParent="+idParent,
	           dataType: "json",
	           success: function(data) {
	        	  console.log("findAllProductSimpleRule"+data.benefitStr)
	        	 //  var selectHtml = "<option value=''>--Fields--</option> ";
	        	 var selectHtml = "";
	            	 for(var x = 0; x < data.length ; x ++){
	            		
	            		 selectHtml = selectHtml + "<li style='list-style-type:none;padding-left: 40px;'>"+data[x].benefitStr+"</li>";
	            	 }
	            	 
	            	 $("#parameterCom").html(selectHtml);
	            	
	            	$('#parameterCom li').click(function() {
				//	alert($(this).text());
					$("#txtMessageCom").val("");
					$("#txtMessageCom").insertAtCaret($(this).text());
					return false
		}); 

	           },
	           error: function(e){				           
          	       // alert('Error: ' + e);		          
          	   }

      });
}

    function simpleReset()
{
	$("#txtSimpleRule").val("");
	$("#listDiv").html("");
	$("#ruleName").val("");	
}
    function simpleDisplay() {
    //  var benefit = $("#txtMessageBenefit").val();
	   var simpleRule = $("#txtSimpleRule").val();
	   var ruleType = $("input:radio[name=ruleType]:checked").val()	
		
	var ruleName = $("#ruleName").val();
	// var coverage = $("#coverage").val();
	//var riskPremium = $("#riskPremium").val();
	
	//var id = $('ul#ClickBenefit > li.selected a').text();
    //alert(benefits);

      var ruleObj = new Object();

      ruleObj.ruleText = simpleRule;
	  ruleObj.ruleName = ruleName; 
	  ruleObj.ruleType=ruleType;		   
   //   ruleObj.mainBenefit = benefit;
   //   ruleObj.coverage = coverage;
	//  ruleObj.riskPremium = riskPremium;	
      
      


      var value = new Array();
      value.push(ruleObj);

      var rulejson = new Object();
      
      rulejson.name = "Simple Rule:";
      rulejson.values = value;
	  rulejson.benefit=	benefits;

      var string = JSON.stringify(rulejson);
      var jsondata = JSON.parse(string);
      console.log(jsondata);
	  console.log("string--"+string);
	  console.log("rulejson--"+rulejson);		
		
	 jQuery.ajax({
			    	url: 'http://localhost:8088/saveRuleEngine',
			           type: "POST",
			           async:false,
			           cache: false,
			           data: JSON.stringify(rulejson),
					   contentType:"application/json",
			           dataType: "json",
			           success: function(data) {
			        	   alert(data.msg);
		        	 
						
			           },
			           error: function(e){				           
		           	        alert('Error : ' + e);		           	
		           	    }

		       });  
	  	
      

    }


function compoundReset(){
	
	 $("#listDivComp").html("");
		$("#txtCompoundRule").val("");	
		$("#ruleNameCom").val("");	
		$("#riskPremiumCom").val("");
		$("#coverageCom").val("");
}

function compoundDisplay() {

	 	
     
	var ruleText = $("#txtCompoundRule").val();	
	var ruleName = $("#ruleNameCom").val();
	 var maxLimit = $("#coverageCom").val();
	var riskPremium = $("#riskPremiumCom").val();

	var ruleType = $("input:radio[name=ruleTypecomp]:checked").val()	
	//alert("ruleType->"+ruleType);
	if(ruleType===undefined || ruleType==''){
		
		alert("Please Select Rule Type");
		return true;
}

	

	var ruleObj = new Object();

      ruleObj.ruleText = ruleText;
	  ruleObj.ruleName = ruleName;    
      ruleObj.maxLimit = maxLimit;
      ruleObj.riskPremium = riskPremium;
	  ruleObj.ruleType=ruleType	
      
      
	//alert(compoundBenefit);	

      var value = new Array();
      value.push(ruleObj);

      var rulejson = new Object();
      
      rulejson.name = "Compound Rule:";
      rulejson.values = value;
	   rulejson.benefit=compoundBenefit;
	   		

      var string = JSON.stringify(rulejson);
      var jsondata = JSON.parse(string);
      console.log(jsondata);
	  console.log("string--"+string);
	  console.log("rulejson--"+rulejson);		
		
	jQuery.ajax({
			    	url: 'http://localhost:8088/saveRuleEngine',
			           type: "POST",
			           async:false,
			           cache: false,
			           data: JSON.stringify(rulejson),
					   contentType:"application/json",
			           dataType: "json",
			           success: function(data) {
			        	   alert(data.msg);
		        	 
						
			           },
			           error: function(e){				           
		           	        alert('Error : ' + e);		           	
		           	    }

		       }); 
	  	

     /*
      var param = "ruleText=" + ruleText + "&ruleName=" + ruleName + "&maxLimit=" + maxLimit + "&riskPremium=" + riskPremium;
      		alert("param="+param);
	 jQuery.ajax({
			    	url: 'http://localhost:8088/saveRuleEngineForCompound',
			           type: "POST",
			           async:false,
			           cache: false,
			           data:param,
					   contentType:"application/json",
			           dataType: "json",
			           success: function(data) {
			        	   alert(data.msg);
		        	 
						
			           },
			           error: function(e){				           
		           	        alert('Error : ' + e);		           	
		           	    }

		       });   */
	  	
      

    }

</script>
<style type="text/css" media="Screen">
#leftcolumn li {
	cursor: pointer;
}

#benefitSimp li {
	cursor: pointer;
}
</style>
</head>
<body>
	<div id="maincontainer">
		<!-- <div id="headline1">
    <div class="title"><em>SKFox.com</em> jQuery Examples</div>
    <span class="subtitle">Insert at caret</span> </div> -->
		<div id="navtoplist">
			<!-- <div class="title">Rule Engine Demo</div>
			<br> -->
			<br>

			<ul id="tabUL">
				<li><a href="#simpleRule">Simple Rule</a></li> &nbsp; &nbsp;
				<li><a href="#compoundRule">Compound Rule</a></li>
				<li><a href="#evaluateRule">Evaluate Claim</a></li>
				<li><a href="#quotationRule">Quotation</a></li>


			</ul>

		</div>
		<div id="navtoplistline">&nbsp;</div>
		<br>
		
			<div id="simpleRule">
				
				<h3>Simple Rule</h3><br>
					<input type="radio" id="ruleType1" name="ruleType" value="riskPrenium">Risk Prenium
			  <input type="radio" id="ruleType2" name="ruleType" checked value="coverage">Coverage
				<br>
<div id="benefitSimp" style="float: left;">
				<fieldset>
    <legend>Add Main Benefit:</legend>
    <ul id='ClickBenefit'>
    <!--  <li style="list-style-type:none;">IPD</li>
      <li style="list-style-type:none;">OPD</li>  -->
    </ul>
    </fieldset> 

	<fieldset>
    <legend>Add Sub Benefit:</legend>
    <ul id='ClickSubBenefit'>
	 <!--  <li style="list-style-type:none;">Maternity</li>
      <li style="list-style-type:none;">Dental</li>
      <li style="list-style-type:none;">Bed Charges</li>
	  <li style="list-style-type:none;">Hospital Cash</li>  -->
     			
    </ul>
    </fieldset>
</div>
<div class="outer" >
<h3>Benefit Structure</h3>
  <div id='listDiv' class="inner">  
  
</div> 
</div>
				
		<!--		<div id="contentwrapper">
					<div id="maincolumn">
						<div class="text">
							<h3>Benefit Structure</h3>
							<textarea name="txtMessage" id="txtMessageBenefit"
								class="txtDropTarget" cols="80" rows="10"></textarea>
							
						</div>
					</div>
				</div>
				<div id="leftcolumn">

					<fieldset id="fieldClass">
						<legend>Main Benefit</legend>
						<ul id="mainBenefit">
							<li>OPD</li>
							<li>IPD</li>

						</ul>
					</fieldset>

					<fieldset id="fieldClass">
						<legend>Sub Benefit</legend>
						<ul id="subBenefit">
							<li>Maternity</li>
							<li>Bed Charge</li>
							<li>Dental</li>

						</ul>
					</fieldset>
				</div>  -->
				<br>
				<br>

				<div id="contentwrapper">
					<div id="maincolumn">
						<div class="text">
						<div style="float:right">
							<a onclick="addRow();" data-added="0"><img title="Add New Row" src="/rule/images/plus_icon.png"></a>
							<a onclick="saveCriteria();" ><img style="width:22px;height:22px;" title="Save Criteria" src="/rule/images/save.png"></a>
						</div> 
							<table class="table table-bordered" id="sample_table">
								<thead>
									<tr>
										<th>Parameter</th>
										<th>Operator</th>
										<th>Value</th>
										<th>Connector</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody id="tbl_posts_body">
									<tr id="rec-1">
										<td><input class="inputValue" style="text-align:center;padding :6px;width:200px;" type="text" name="txtMessage" id="txtMessage"
										readonly></td>
										<td>
											<select class="inputValue" style="text-align:center;padding :6px;">
											    <option value="-1">--Select--</option>
												<option value="=">=</option>
												<option value="<">&lt;</option>
												<option value=">">&gt;</option>
												<option value="<=">&le;</option>
												<option value=">=">&ge;</option>
											</select>
										</td>
										<td><input class="inputValue" style="text-align:center;padding :6px;width:50px;" type="text" name="txtVal" id="txtVal"></td>
										<td>
											<select class="inputValue" style="text-align:center;padding :6px;">
												<option value="-1">--Select--</option>
												<option value="and">AND</option>
												<option value="or">OR</option>										
											</select>
										</td>
										<td>
											<a onclick="deleteRow(this)"> <img title="Delete" 
											style="padding-left:15px;width:16px;height:16px;" src='/rule/images/delete.png'/></a>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="text">
							<h3>Simple Rules</h3>
							<textarea name="txtSimpleRule" id="txtSimpleRule" class="txtDropTarget" readonly
								cols="80" rows="4"></textarea>
							
						</div>
					</div>
				</div>
				<div id="leftcolumn">

					<fieldset id="fieldClass">
						<legend>Parameter</legend>
						<ul id="parameterSimple" style="height: 100px;overflow:auto;display:block;width:170px;"> <!-- <li title="Any Numerical Value">Age</li>
							<li title="'Male' or 'Female'">Gender</li>
							<li title="'Family' or 'Individual'">CoverType</li>
							<li title="No of Days">Start After</li>
							<li title="In Currency">Per Day Limit</li>
							<li title="No of Days">No of Days per Event</li>
							<li title="In Currency">Policy Period Amount</li> -->
						</ul>
					</fieldset>

					<!-- <fieldset id="fieldClass">
						<legend>Operators</legend>
						<ul id="operatorSimple">
							<li> and </li>
							<li>></li>
							<li><</li>
							<li>=</li>
							<li>>=</li>
							<li><=</li>

						</ul>
					</fieldset> -->
				</div>
				<br><br><br>
				<div class="row"> <br><br> <br><br><br><br> <br><br><br>
					<div class="column" style="padding-left:210px;">
						Rule Name : <input style="padding:6px;" type="text" id="ruleName" name="ruleName">
					</div>
					<!-- <div class="column">
						Coverage : <input type="text" id="coverage" name="coverage">
					</div>
					<div class="column">
						Risk Premium : <input type="text" id="riskPremium"
							name="riskPremium">
					</div>  -->
					
						
						&nbsp;&nbsp;<button type="button" style="background-color:#9ef39c;padding:6px;" class="btn btn-info btn-sm" 
						onclick="simpleDisplay()">Submit</button>
						<button type="button" style="background-color:#9ef39c;padding:6px;" class="btn btn-info btn-sm" 
						onclick="simpleReset()">Reset</button>
						&nbsp;&nbsp;
						<!-- <button type="button" class="btn btn-danger btn-sm" style="background-color:#f39ca4;padding:6px;"
							onclick="remove(this)">Remove</button> -->
						<div>

					</div>
					</div>
					</div>
					

					<!--Compound Div Start  -->
					<div id="compoundRule" style="display: none">
						<h3>Compound Rule</h3>
						<br>
					
					Rule Type : <input type="radio" id="ruleTypecomp1" name="ruleTypecomp"  value="riskPrenium">Risk Prenium
					<input type="radio" id="ruleTypecomp2" name="ruleTypecomp"  value="coverage">Coverage  <br><br>
						<div id="benefitSimp" style="float: left;">
									<fieldset>
						<legend>Add Benefit Structure:</legend>
						<ul id="ClickBenefitComp">
						  <!-- <li style="list-style-type:none;">IPD</li>
						  <li style="list-style-type:none;">OPD</li>  -->
						</ul>
						</fieldset> 

						
					</div>
					<div class="outer">
					<h3>Benefit Structure</h3>
					  <div id='listDivComp' class="inner">
					  </div>
					</div>  <br><br>

				
						<br>
						<br>

							<div id="contentwrapper">
					<div id="maincolumn">
						<div class="text">
						<div style="float:right">
							<a onclick="addRowComp();" data-added="0"><img title="Add New Row" src="/rule/images/plus_icon.png"></a>
							<a onclick="saveCriteriaComp();" ><img style="width:22px;height:22px;" title="Save Criteria" src="/rule/images/save.png"></a>
						</div> 
							<table class="table table-bordered" id="comp_table">
								<thead>
									<tr>
										<th>Simple Rule</th>
										<!-- <th>Operator</th>
										<th>Value</th> -->
										<th>Connector</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody id="tbl_posts_bodyComp">
									<tr id="rec-11">
										<td><input class="inputValue" style="text-align:center;padding :6px;width:200px;" type="text" name="txtMessageCom" id="txtMessageCom"
										readonly></td>
																			
										<td>
											<select class="inputValue" style="text-align:center;padding :6px;">
												<option value="-1">--Select--</option>
												<option value="^">AND</option>																					
											</select>
										</td>
										<td>
											<a onclick="deleteRowComp(this)"> <img title="Delete" 
											style="padding-left:15px;width:16px;height:16px;" src='/rule/images/delete.png'/></a>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="text">
							<h3>Compound Rules</h3>
							<textarea name="txtCompoundRule" id="txtCompoundRule" class="txtDropTarget" readonly
								cols="80" rows="4"></textarea>
							
						</div>
					</div>
				</div>
				<div id="leftcolumn">

					<fieldset id="fieldClass">
						<legend>Parameter</legend>
						<ul id="parameterCom" style="height: 100px;overflow:auto;display:block;width:170px;"> <!-- <li title="Any Numerical Value">Age</li>
							<li title="'Male' or 'Female'">Gender</li>
							<li title="'Family' or 'Individual'">CoverType</li>
							<li title="No of Days">Start After</li>
							<li title="In Currency">Per Day Limit</li>
							<li title="No of Days">No of Days per Event</li>
							<li title="In Currency">Policy Period Amount</li> -->
						</ul>
					</fieldset>

				</div>

						<br><br><br>
				 <br><br> <br><br><br><br> <br> 
							<div id="mainriskDiv" style="display: none;">
								<div class="column" id="riskPremiumComDiv" style="padding-left:210px;">
									Risk Premium : <input type="text" style="text-align:center;padding :6px;width:200px;" id="riskPremiumCom"
										name="riskPremiumCom">
									
								</div>
								<div class="column" id="coverageComDiv">
									&nbsp;&nbsp;Coverage : <input type="text" style="text-align:center;padding :6px;width:200px;" id="coverageCom"
										name="coverageCom">
								</div> <br>
							</div>
							
							<div class="column" style="padding-left:210px;">
								<br>
								RuleName : <input type="text" style="text-align:center;padding :6px;width:200px;" id="ruleNameCom"
									name="ruleNameCom">
								&nbsp;&nbsp;<button type="button" style="background-color:#9ef39c;padding:6px;" class="btn btn-info btn-sm" 
									onclick="compoundDisplay()">Submit</button>
								<button type="button" style="background-color:#9ef39c;padding:6px;" class="btn btn-info btn-sm" 
						onclick="compoundReset()">Reset</button>
						&nbsp;&nbsp;
							</div>
							

								
								<!-- <button type="button"  class="btn btn-info btn-sm" onclick="compoundDisplay()">Submit</button>
								&nbsp;&nbsp;
								<button type="button" class="btn btn-danger btn-sm"
									onclick="remove(this)">Remove</button> -->
								



							</div>
						</div>
					</div>  <!-- End Of Compound -->

<div id="evaluateRule" style="display: none;padding-left:200px">
<h3>Evaluate Claim</h3>
		<br>
					 <!-- Rule Type : <input type="radio" id="ruleTypeEval" name="ruleTypeEval" value="riskPrenium">Risk Prenium
			  <input type="radio" id="ruleTypeEval" name="ruleTypeEval" checked value="coverage">Coverage<br><br> --> 
		 <div class="container formGroup" style="margin-top: 10px;">
			<div id="benefitEvalute" style="float: left;">
									<fieldset>
						<legend>Add Benefit Structure:</legend>
						<ul id="ClickBenefitEvalute">
						  <!-- <li style="list-style-type:none;">IPD</li>
						  <li style="list-style-type:none;">OPD</li>  -->
						</ul>
						</fieldset> 

						<!-- <fieldset>
						<legend>Add Sub Benefit:</legend>
						<ul id='ClickSubBenefitComp'>
						    
						</ul>
						</fieldset>   -->
					</div>
					<div class="outer">
					<h3>Benefit Structure</h3>
					  <div id='listDivEvalute' class="inner">
					  </div>
					</div>
          <br> <br>
          <!-- <div class="row">
            <div class="col-sm-12">
				 Benefit : 
              <select id="benefit">
                <option value="OPD">OPD</option>
                <option value="IPD">IPD</option>
                <option value="Maternity">Maternity</option>
              </select>  
            </div>
          </div>
          
          <div class="row">
            <div class="col-sm-12">
              Sub Benefit : <select id="subbenefit">
                <option value="OPD">OPD</option>
                <option value="IPD">IPD</option>
                <option value="Maternity">Maternity</option>
              </select>
            </div>
          </div> -->
          <br>
          <div class="row">
            
              <div class="col-sm-12">
                Age : <input type="text" style="text-align:center;padding :6px;width:200px;" id="age" name="age">
              </div>
          </div>
          <br>
			
              <div class="row">
            <div class="col-sm-12">
              Gender : <input type="radio" id="gender" name="gender" value="Male">Male
              <input type="radio" id="gender" name="gender" value="Female">Female
			  <input type="radio" id="gender" name="gender" value="Other">Other	  
            </div>
          </div>
          <br>
			 <div class="row">
            
              <div class="col-sm-12">
                Claim Amount : <input type="text" style="text-align:center;padding :6px;width:200px;" id="claimAmount" name="claimAmount">
              </div>
          </div>
          <br>
          <div class="row">
            <div class="col-sm-12">
              CoverType : <select id="coverType" style="text-align:center;padding :6px;width:200px;" >
                <option value="Family">Family</option>
                <option value="Individual">Individual</option>
              </select>
            </div>
          </div>
          <!-- </div> -->
          <br>
          <!-- <div class="col-sm-"></div> -->
          <div class="centered">
            <button type="button" style="background-color:#9ef39c;padding:6px;" class="btn btn-info btn-md " onclick="saveEvaluateRule()">Evaluate Claim</button>
			<button type="button" style="background-color:#9ef39c;padding:6px;" class="btn btn-info btn-md " onclick="resetEvaluate()">Reset</button>
          </div>
          </div>
          <br><br>
        <div id = "myData"></div>
        </div>



</div>


					
					</div>

<div id="quotationRule" style="display: none;padding-left:200px">
	<h3>Quotation</h3><br><br>
			 <div class="container formGroup" style="margin-top: 10px;">
			<div id="benefitQuotation" style="float: left;">
									<fieldset>
						<legend>Add Benefit Structure:</legend>
						<ul id="ClickBenefitQuotation">
						  <!-- <li style="list-style-type:none;">IPD</li>
						  <li style="list-style-type:none;">OPD</li>  -->
						</ul>
						</fieldset> 

						<!-- <fieldset>
						<legend>Add Sub Benefit:</legend>
						<ul id='ClickSubBenefitComp'>
						    
						</ul>
						</fieldset>   -->
					</div>
					<div class="outer">
					<h3>Benefit Structure</h3>
					  <div id='listDivQuotation' class="inner">
					  </div>
					</div>
          <br> <br>
			<br><br>
 			<div class="row">
            <div class="col-sm-12">
				 Family Size : <select id="familySize">
					<option value="">--Select Family Size--</option>
					<option value="M+1">M+1</option>
					<option value="M+2">M+2</option>
					<!-- <option value="M+3">M+3</option> -->
				  </select>
</div>

</div><br>

		<div id="tblDivQuot"></div>

          </div><br><br>
<div>
            <button type="button" style="background-color:#9ef39c;padding:6px;" class="btn btn-info btn-md " onclick="searchRuleForQuotation()">Get Quotation</button>
			<button type="button" style="background-color:#9ef39c;padding:6px;" class="btn btn-info btn-md " onclick="resetQuotation()">Reset</button>
          </div>

<div id="quotationResult">
</div>

</div>
					<script type="text/javascript">
						var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl."
								: "http://www.");
						document
								.write(unescape("%3Cscript src='"
										+ gaJsHost
										+ "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
					</script>
					<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-647750-1");
pageTracker._trackPageview();
} catch(err) {}
</script>
<script>
var main = "";
var subArr = [];
subArr = new Array();
var mainCom = "";
var subArrCom = [];
subArrCom = new Array();
//twodArr['IPD'] = new Array();

function createListDynamically(listText, relation){
	//alert('Text:'+listText+' relation='+relation);
	//var 2dArr = {};
	if("P"==relation)
	{
		main = listText;
	}
	else
	{
		subArr.push(listText);
	}
	console.log(subArr);
	console.log(subArr.length);
    var listDivHTML = "<ul id='myUL'>" +
					"  <li style='list-style-type:none;'><span class='caret'>" + main + "</span>" 
					"    <ul class='nested'>" ;

	for(var i=0; i<subArr.length;i++)
	{
			listDivHTML = listDivHTML + "<li style='list-style-type:none;' id='li"+i+"'>" + subArr[i] + "</li>";	
			/*if(i>0){
				$("#li0").addClass('caret');
				console.log(i + " caret class added");
					
			}*/

			//listDivHTML = listDivHTML + "<li><span class='caret'>" + subArr[i] + "</li>";	
	}
	listDivHTML = listDivHTML + "</ul>" ;
	$('#listDiv').html(listDivHTML);
	
	//$('#txtMessageBenefit').html(listDivHTML);

	for(var i=0; i<subArr.length;i++)
	{
			//listDivHTML = listDivHTML + "<li id='li"+i+"'>" + subArr[i] + "</li>";	
			if(i>0){
				$("#li"+(i-1)).addClass('caret');
				console.log(i + " caret class added");	
			}
			var marginLeft = 40*(i+1);
			$("#li"+i).css("margin-left", marginLeft+"px");
			//listDivHTML = listDivHTML + "<li><span class='caret'>" + subArr[i] + "</li>";	
	}
	console.log(listDivHTML);

	/*var listDivHTML = "<ul id='myUL'>" +
					"  <li><span class='caret'>" + main + "</span>" +
					"    <ul class='nested'>" +
					"      <li>Water</li>" +
					"      <li>Coffee</li>" +
					"      <li><span class='caret'>Tea</span>" +
					"        <ul class='nested'>" +
					"          <li>Black Tea</li>" +
					"          <li>White Tea</li>" +
					"          <li><span class='caret'>Green Tea</span>" +
					"            <ul class='nested'>" +
					"              <li>Sencha</li>" +
					"              <li>Gyokuro</li>" +
					"              <li>Matcha</li>" +
					"              <li>Pi Lo Chun</li>" +
					"            </ul>" +
					"          </li>" +
					"        </ul>" +
					"      </li>  " +
					"    </ul>" +
					"  </li>" +
					"</ul>";*/
	//alert(listDivHTML);
	
	var toggler = document.getElementsByClassName('caret');
	var i;

	/*for (i = 0; i < toggler.length; i++) {
	  toggler[i].addEventListener('click', function() {
		this.parentElement.querySelector('.nested').classList.toggle('active');
		this.classList.toggle('caret-down');
	  });
	}*/

}



function createListDynamicallyQuot(listText, relation){
	//alert('Text:'+listText+' relation='+relation);
	var html = $('#listDivQuotation').html();
    console.log("---"+html.trim()+"------");
	if(html.trim() != '')
		html = html + " || " + listText;
	else
		html = html + listText;
	$('#listDivQuotation').html(html);

}

function createListDynamicallyEval(listText, relation){
	//alert('Text:'+listText+' relation='+relation);
	
	if("P"==relation)
	{
		mainCom = listText;
	}
	else
	{
		subArrCom.push(listText);
	}
	console.log(subArrCom);
	console.log(subArrCom.length);
    var listDivHTML = "<ul id='myULComp'>" +
					"  <li style='list-style-type:none;'><span class='caret'>" + mainCom + "</span>" 
					"    <ul class='nested'>" ;

	for(var i=0; i<subArrCom.length;i++)
	{
			listDivHTML = listDivHTML + "<li style='list-style-type:none;' id='lii"+i+"'>" + subArrCom[i] + "</li>";	
			/*if(i>0){
				$("#li0").addClass('caret');
				console.log(i + " caret class added");
					
			}*/

			//listDivHTML = listDivHTML + "<li><span class='caret'>" + subArrCom[i] + "</li>";	
	}
	listDivHTML = listDivHTML + "</ul>" ;
	$('#listDivEvalute').html(listDivHTML);
	
	//$('#txtMessageBenefit').html(listDivHTML);

	for(var i=0; i<subArrCom.length;i++)
	{
			//listDivHTML = listDivHTML + "<li id='li"+i+"'>" + subArrCom[i] + "</li>";	
			if(i>0){
				$("#lii"+(i-1)).addClass('caret');
				console.log(i + " caret class added");	
			}
			var marginLeft = 40*(i+1);
			$("#lii"+i).css("margin-left", marginLeft+"px");
			//listDivHTML = listDivHTML + "<li><span class='caret'>" + subArrCom[i] + "</li>";	
	}
	console.log(listDivHTML);

	/*var listDivHTML = "<ul id='myUL'>" +
					"  <li><span class='caret'>" + mainCom + "</span>" +
					"    <ul class='nested'>" +
					"      <li>Water</li>" +
					"      <li>Coffee</li>" +
					"      <li><span class='caret'>Tea</span>" +
					"        <ul class='nested'>" +
					"          <li>Black Tea</li>" +
					"          <li>White Tea</li>" +
					"          <li><span class='caret'>Green Tea</span>" +
					"            <ul class='nested'>" +
					"              <li>Sencha</li>" +
					"              <li>Gyokuro</li>" +
					"              <li>Matcha</li>" +
					"              <li>Pi Lo Chun</li>" +
					"            </ul>" +
					"          </li>" +
					"        </ul>" +
					"      </li>  " +
					"    </ul>" +
					"  </li>" +
					"</ul>";*/
	//alert(listDivHTML);
	
	var toggler = document.getElementsByClassName('caret');
	var i;

	/*for (i = 0; i < toggler.length; i++) {
	  toggler[i].addEventListener('click', function() {
		this.parentElement.querySelector('.nested').classList.toggle('active');
		this.classList.toggle('caret-down');
	  });
	}*/

}


function createListDynamicallyComp(listText, relation){
	
	//alert('Text:'+listText+' relation='+relation);
	//var 2dArr = {};
	if("P"==relation)
	{
		mainCom = listText;
	}
	else
	{
		subArrCom.push(listText);
	}
	console.log(subArrCom);
	console.log(subArrCom.length);
    var listDivHTML = "<ul id='myULComp'>" +
					"  <li style='list-style-type:none;'><span class='caret'>" + mainCom + "</span>" 
					"    <ul class='nested'>" ;

	for(var i=0; i<subArrCom.length;i++)
	{
			listDivHTML = listDivHTML + "<li style='list-style-type:none;' id='lii"+i+"'>" + subArrCom[i] + "</li>";	
			/*if(i>0){
				$("#li0").addClass('caret');
				console.log(i + " caret class added");
					
			}*/

			//listDivHTML = listDivHTML + "<li><span class='caret'>" + subArrCom[i] + "</li>";	
	}
	listDivHTML = listDivHTML + "</ul>" ;
	$('#listDivComp').html(listDivHTML);
	
	//$('#txtMessageBenefit').html(listDivHTML);

	for(var i=0; i<subArrCom.length;i++)
	{
			//listDivHTML = listDivHTML + "<li id='li"+i+"'>" + subArrCom[i] + "</li>";	
			if(i>0){
				$("#lii"+(i-1)).addClass('caret');
				console.log(i + " caret class added");	
			}
			var marginLeft = 40*(i+1);
			$("#lii"+i).css("margin-left", marginLeft+"px");
			//listDivHTML = listDivHTML + "<li><span class='caret'>" + subArrCom[i] + "</li>";	
	}
	console.log(listDivHTML);

	/*var listDivHTML = "<ul id='myUL'>" +
					"  <li><span class='caret'>" + mainCom + "</span>" +
					"    <ul class='nested'>" +
					"      <li>Water</li>" +
					"      <li>Coffee</li>" +
					"      <li><span class='caret'>Tea</span>" +
					"        <ul class='nested'>" +
					"          <li>Black Tea</li>" +
					"          <li>White Tea</li>" +
					"          <li><span class='caret'>Green Tea</span>" +
					"            <ul class='nested'>" +
					"              <li>Sencha</li>" +
					"              <li>Gyokuro</li>" +
					"              <li>Matcha</li>" +
					"              <li>Pi Lo Chun</li>" +
					"            </ul>" +
					"          </li>" +
					"        </ul>" +
					"      </li>  " +
					"    </ul>" +
					"  </li>" +
					"</ul>";*/
	//alert(listDivHTML);
	
	var toggler = document.getElementsByClassName('caret');
	var i;

	/*for (i = 0; i < toggler.length; i++) {
	  toggler[i].addEventListener('click', function() {
		this.parentElement.querySelector('.nested').classList.toggle('active');
		this.classList.toggle('caret-down');
	  });
	}*/

}

function saveCriteria(){
	var simpleRule = "";
	var data = $("#sample_table tr").map(function (index, elem) {
        var ret = [];
		var columnIndex = 0; 
		
        $('.inputValue', this).each(function () {
            var d = $(this).val() || $(this).text();
            ret.push(d);
			var tmpRule = "";
			if(columnIndex == 0){
				tmpRule = "{"+d+"}"; 
			}
			else if(columnIndex == 3){
				tmpRule = " "+d+" "; 
			}else{
				tmpRule = d;
			}
			simpleRule = simpleRule + tmpRule;
			//alert(d);
            columnIndex++;
        });
        return ret;
    });
	simpleRule = simpleRule.replace("-1", ""); 
	$("#txtSimpleRule").text($.trim(simpleRule));
;
}

function addRow(){
 //jQuery(document).click('a.add-record', 'click', function(e) {
     //e.preventDefault();    
	 
     var content = jQuery('#rec-1');
	 
     size = jQuery('#tbl_posts >tbody >tr').length + 1;
     element = null;    
     element = content.clone();
	
     element.attr('id', 'rec-'+size);
     element.find('.delete-record').attr('data-id', size);
     element.appendTo('#tbl_posts_body');
     //element.find('.sn').html(size);
   }
   //);
    function deleteRow(row) {
     var rowCount = $('#sample_table tr').length;
	 if(rowCount == 2){
		 alert("Cannot remove this row");
		 return false;
	 }
     var didConfirm = confirm("Are you sure You want to delete");
     if (didConfirm == true) {
		 var toDelRow = $(row).parent().parent();
		 toDelRow.remove();
	 }
      /* var id = jQuery(row).attr('data-id');
      var targetDiv = jQuery(this).attr('targetDiv');
      jQuery('#rec-' + id).remove();
      
		return true;
	  } else {
		return false;
	  }*/
}


function saveCriteriaComp(){
	var simpleRule = "";
	var data = $("#comp_table tr").map(function (index, elem) {
        var ret = [];
		var columnIndex = 0; 
		
        $('.inputValue', this).each(function () {
            var d = $(this).val() || $(this).text();
            ret.push(d);
			var tmpRule = "";
			if(columnIndex == 0){
				tmpRule = "({"+d+"})"; 
			}
			/*else if(columnIndex == 1){
				tmpRule = " "+d+" "; 
			}*/else{
				tmpRule = " "+d+" ";
			}
			simpleRule = simpleRule + tmpRule;
			//alert(d);
            columnIndex++;
        });
        return ret;
    });
	simpleRule = simpleRule.replace("-1", ""); 
	$("#txtCompoundRule").text($.trim(simpleRule));
;
}

function addRowComp(){
 //jQuery(document).click('a.add-record', 'click', function(e) {
     //e.preventDefault();    
	 
     var content = jQuery('#rec-11');
	 
     size = jQuery('#tbl_posts >tbody >tr').length + 1;
     element = null;    
     element = content.clone();
	  
     element.attr('id', 'rec-'+size);
     element.find('.delete-record').attr('data-id', size);
     element.appendTo('#tbl_posts_bodyComp'); 
     //element.find('.sn').html(size);
   }
   //);
    function deleteRowComp(row) {
     var rowCount = $('#comp_table tr').length;
	 if(rowCount == 2){
		 alert("Cannot remove this row");
		 return false;
	 }
     var didConfirm = confirm("Are you sure You want to delete");
     if (didConfirm == true) {
		 var toDelRow = $(row).parent().parent();
		 toDelRow.remove();
	 }
      /* var id = jQuery(row).attr('data-id');
      var targetDiv = jQuery(this).attr('targetDiv');
      jQuery('#rec-' + id).remove();
      
		return true;
	  } else {
		return false;
	  }*/
}

</script>
</body>
</html>
