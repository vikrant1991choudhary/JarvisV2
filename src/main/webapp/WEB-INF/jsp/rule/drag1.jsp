
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<title>Rule</title>
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
</style>
<script language="JavaScript" type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.2.6/jquery.min.js"></script>
<script language="JavaScript" type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.5.2/jquery-ui.min.js"></script>
<script language="JavaScript" type="text/javascript"
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 <!--<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">  --> 

<script language="JavaScript" type="text/javascript">
	$(document).ready(function() {

	/*	$("ul.tabs a").click(function() {
			$(".pane div").hide();
			$($(this).attr("href")).show();
		}); */
		$("ul[id*=tabUL] li").click(function () {
              //  alert($(this).html()); // gets innerHTML of clicked li
               // alert($(this).text()); // gets text contents of clicked li
				if($(this).text()=="Simple Rule"){
					$('#simpleRule').show();
					$('#compoundRule').hide();
					
				}else{
					$('#simpleRule').hide();
					$('#compoundRule').show();
					
			}
            });

		/* For Simple Rule*/
		
		$('#ClickBenefit li').click(function() { 
		//alert($(this).text());
		createListDynamically($(this).text(), 'P' );
		return false
	});

	$('#ClickSubBenefit li').click(function() { 
		//alert($(this).text());
		createListDynamically($(this).text(), 'C');
		return false
	});

		$('#parameterSimple li').click(function() {
			//alert($(this).text());
			$("#txtMessage").insertAtCaret("{" + $(this).text() + "}");
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
		createListDynamicallyComp($(this).text(), 'P' );
		return false
	});

	$('#ClickSubBenefitComp li').click(function() { 
		//alert($(this).text());
		createListDynamicallyComp($(this).text(), 'C');
		return false
	});

		$('#parameterCom li').click(function() {
			$("#txtMessageCom").insertAtCaret("({" + $(this).text() + "})");
			return false
		});
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
		
    function simpleDisplay() {
      var benefit = $("#txtMessageBenefit").val();
	   var simpleRule = $("#txtMessage").val();
		
	var ruleName = $("#ruleName").val();
	 var coverage = $("#coverage").val();
	var riskPremium = $("#riskPremium").val();
	

      var ruleObj = new Object();

      ruleObj.ruleText = simpleRule;
	  ruleObj.ruleName = ruleName;    
      ruleObj.mainBenefit = benefit;
      ruleObj.coverage = coverage;
	  ruleObj.riskPremium = riskPremium;	
      
      


      var value = new Array();
      value.push(ruleObj);

      var rulejson = new Object();
      
      rulejson.name = "Simple Rule:";
      rulejson.values = value;

      var string = JSON.stringify(rulejson);
      var jsondata = JSON.parse(string);
      console.log(jsondata);
	  console.log("string--"+string);
	  console.log("rulejson--"+rulejson);		
		
	 /*jQuery.ajax({
			    	url: 'http://localhost:8080/ruleengine/saveRuleEngine',
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

		       });  */
	  	
      

    }

function compoundDisplay() {
      var benefit = $("#txtMessageBenefitCom").val();
	   var simpleRule = $("#txtMessageCom").val();
		
	var ruleName = $("#ruleNameCom").val();
	 var coverage = $("#coverageCom").val();
	var riskPremium = $("#riskPremiumCom").val();
	

      var ruleObj = new Object();

      ruleObj.ruleText = simpleRule;
	  ruleObj.ruleName = ruleName;    
      ruleObj.mainBenefit = benefit;
      ruleObj.coverage = coverage;
	  ruleObj.riskPremium = riskPremium;	
      
      


      var value = new Array();
      value.push(ruleObj);

      var rulejson = new Object();
      
      rulejson.name = "Compund Rule:";
      rulejson.values = value;

      var string = JSON.stringify(rulejson);
      var jsondata = JSON.parse(string);
      console.log(jsondata);
	  console.log("string--"+string);
	  console.log("rulejson--"+rulejson);		
		
	 /*jQuery.ajax({
			    	url: 'http://localhost:8080/ruleengine/saveRuleEngine',
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

		       });  */
	  	
      

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
			<div class="title">Rule Engine Demo</div>
			<br>
			<br>

			<ul id="tabUL">
				<li><a href="#simpleRule">Simple Rule</a></li> &nbsp; &nbsp;
				<li><a href="#compoundRule">Compound Rule</a></li>

			</ul>

		</div>
		<div id="navtoplistline">&nbsp;</div>
		<br>
		
			<div id="simpleRule">
				<br>
<div id="benefitSimp" style="float: left;">
				<fieldset>
    <legend>Add Main Benefit:</legend>
    <ul id='ClickBenefit'>
      <li style="list-style-type:none;">IPD</li>
      <li style="list-style-type:none;">OPD</li>
    </ul>
    </fieldset> 

	<fieldset>
    <legend>Add Sub Benefit:</legend>
    <ul id='ClickSubBenefit'>
	  <li style="list-style-type:none;">Maternity</li>
      <li style="list-style-type:none;">Dental</li>
      <li style="list-style-type:none;">Bed Charges</li>
	  <li style="list-style-type:none;">Hospital Cash</li>
     			
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
							<h3>Simple Rules</h3>
							<textarea name="txtMessage" id="txtMessage" class="txtDropTarget"
								cols="80" rows="14"></textarea>
							<!--    <h2>Compound Rules</h2>
        <textarea name="txtMessage2" id="txtMessage2" class="txtDropTarget" cols="80" rows="10"></textarea>	  -->
						</div>
					</div>
				</div>
				<div id="leftcolumn">

					<fieldset id="fieldClass">
						<legend>Parameter</legend>
						<ul id="parameterSimple"> <li title="Any Numerical Value">Age</li>
							<li title="'Male' or 'Female'">Gender</li>
							<li title="'Family' or 'Individual'">CoverType</li>
							<li title="'Daily' or 'Cumulative'">Frequency</li>
							<li title="No. in Digit">Seed</li>
						</ul>
					</fieldset>

					<fieldset id="fieldClass">
						<legend>Operators</legend>
						<ul id="operatorSimple">
							<li> and </li>
							<li>></li>
							<li><</li>
							<li>=</li>
							<li>>=</li>
							<li><=</li>

						</ul>
					</fieldset>
				</div>
				<br><br><br>
				<div class="row"> <br><br> <br><br><br><br> <br><br><br> <br><br> <br>
					<div class="column">
						RuleName : <input type="text" id="ruleName" name="ruleName">
					</div>
					<!-- <div class="column">
						Coverage : <input type="text" id="coverage" name="coverage">
					</div>
					<div class="column">
						Risk Premium : <input type="text" id="riskPremium"
							name="riskPremium">
					</div>  -->
					<div class="column">
						
						&nbsp;&nbsp;<button type="button" class="btn btn-info btn-sm" onclick="simpleDisplay()">Submit</button>
						&nbsp;&nbsp;
						<button type="button" class="btn btn-danger btn-sm"
							onclick="remove(this)">Remove</button>
						<div></div>

					</div>
					</div>
					</div>
					

					<!--Compound Div Start  -->
					<div id="compoundRule" style="display: none">

						<br>
						<div id="benefitSimp" style="float: left;">
									<fieldset>
						<legend>Add Main Benefit:</legend>
						<ul id='ClickBenefitComp'>
						  <li style="list-style-type:none;">IPD</li>
						  <li style="list-style-type:none;">OPD</li>
						</ul>
						</fieldset> 

						<fieldset>
						<legend>Add Sub Benefit:</legend>
						<ul id='ClickSubBenefitComp'>
						  <li style="list-style-type:none;">Maternity</li>
						  <li style="list-style-type:none;">Dental</li>
						  <li style="list-style-type:none;">Bed Charges</li>
						</ul>
						</fieldset>
					</div>
					<div class="outer">
					<h3>Benefit Structure</h3>
					  <div id='listDivComp' class="inner">
					  </div>
					</div>  <br><br>

				<!--		<div id="contentwrapper">
							<div id="maincolumn">
								<div class="text">
									<h3>Benefit Structure</h3>
									<textarea name="txtMessageBenefitCom" id="txtMessageBenefitCom"
										class="txtDropTarget" cols="80" rows="10"></textarea>
									
								</div>
							</div>
						</div>
						<div id="leftcolumn">

							<fieldset id="fieldClass">
								<legend>Main Benefit</legend>
								<ul id="mainBenefitCom">
									<li>OPD</li>
									<li>IPD</li>

								</ul>
							</fieldset>

							<fieldset id="fieldClass">
								<legend>Sub Benefit</legend>
								<ul id="subBenefitCom">
									<li>Maternity</li>
									<li>Bed Charge</li>
									<li>Dental</li>

								</ul>
							</fieldset>
						</div>  --->
						<br>
						<br>

						<div id="contentwrapper">
							<div id="maincolumn">
								<div class="text">
									<h3>Compound Rules</h3>
									<textarea name="txtMessageCom" id="txtMessageCom"
										class="txtDropTarget" cols="80" rows="14"></textarea>
									<!--    <h2>Compound Rules</h2>
        <textarea name="txtMessage2" id="txtMessage2" class="txtDropTarget" cols="80" rows="10"></textarea>	  -->
								</div>
							</div>
						</div>
						<div id="leftcolumn">

							<fieldset id="fieldClass">
								<legend>Parameter</legend>
								<ul id="parameterCom">
									<li>{Age}>=0 and {Age}<=60</li>
									<li>{Gender}='Male'</li>
									<li>{cibil_score} >= 650</li>
								</ul>
							</fieldset>

							<fieldset id="fieldClass">
								<legend>Operators</legend>
								<ul id="operatorCom">
									<li> ^ </li>
									<li>></li>
									<li><</li>
									<li>=</li>
									<li>>=</li>
									<li><=</li>

								</ul>
							</fieldset>
						</div>
						<br><br><br>
				<div class="row"> <br><br> <br><br><br><br> <br> 
							<div class="column">
								RuleName : <input type="text" id="ruleNameCom"
									name="ruleNameCom">
							</div>
							<div class="column">
								Coverage : <input type="text" id="coverageCom"
									name="coverageCom">
							</div>
							<div class="column">
								Risk Premium : <input type="text" id="riskPremiumCom"
									name="riskPremiumCom">
							</div>
							<div class="column">
								<br>
								<button type="button" class="btn btn-info btn-sm" onclick="compoundDisplay()">Submit</button>
								&nbsp;&nbsp;
								<button type="button" class="btn btn-danger btn-sm"
									onclick="remove(this)">Remove</button>
								<div></div>

							</div>
						</div>
					</div>  <!-- End Of Compound -->
					
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



</script>
</body>
</html>
