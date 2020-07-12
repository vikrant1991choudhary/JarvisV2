<!doctype html>
<%
String isUploadAllowed = session.getAttribute("isUploadAllowed")!=null ? session.getAttribute("isUploadAllowed").toString() : "";
 System.out.println("home isUploadAllowed -- " + isUploadAllowed);
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
   <link rel="stylesheet" href="/css/style.css" type="text/css">
        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
    
      <!--header-->
      <header>
          <div class="container">
              <!--left-->
              <div class="float-left">
                <div class="logo">
                    <img src="/images/logo_leftbraincm.jpg" alt="" > <!-- class="banglaLogo" -->
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
                  ${welcome}
              </div>
              <!--end right-->
          </div>
      </header>
      <!--end header-->
		<div class="helpContent">
		<p class="text-center">Please download User manual
		  <a href="/images/User Manual.pdf" title="" target="_blank"><i class="fa fa-file-pdf-o" aria-hidden="true"></i> </a>
		</p>
		</div>

      <!--main-->
      <main>
        <div class="container">
            <div class="row">
              <div class="col-md-4">
                <div class="analysisBlock text-center">
                    <img src="/images/Icon_DescriptiveAnalysis.svg" alt="">
                    <h2 class="orangeText">Realtime</h2>
                    <a href="/JarvisV2/realTimeStock" title="">
                      <i class="fa fa-angle-right" aria-hidden="true"></i>
                    </a>
                </div>
                <div class="analysisBlockText">
                  <p>Where stocks and bonds can be evaluated in real time</p>
                </div>
              </div>

              <div class="col-md-4">
                  <div class="analysisBlock text-center">
                      <img src="/images/Icon_PredictiveAnalytics.svg" alt="">
                      <h2 class="violetText">Weekly</h2>
                      <a href="/JarvisV2/weekly" title="">
                        <i class="fa fa-angle-right" aria-hidden="true"></i>
                      </a>
                  </div>
                  <div class="analysisBlockText">
                    <p>Where tickers and ETFs can be compared</p>&nbsp;&nbsp;&nbsp;&nbsp;
                  </div>
              </div>

              <div class="col-md-4">
                  <div class="analysisBlock text-center">
                      <img src="/images/Icon_PrescriptiveAnalysis.svg" alt="">
                      <h2 class="greenText">Imports</h2>
                      <!-- <a href="/JarvisV2/imports?isUploadAllowed=<%=isUploadAllowed%>" title="">
                        <i class="fa fa-angle-right" aria-hidden="true"></i>
                      </a> -->
                      <a href="#" title="" onclick="$('#frmImport').submit();" >
                        <i class="fa fa-angle-right" aria-hidden="true"></i>
                      </a>
                      <form method="post" action="/JarvisV2/imports" id="frmImport">
                      	<input type="hidden" name="isUploadAllowed" id="isUploadAllowed" value="<%=isUploadAllowed%>" />
                      </form>
                  </div>
                  <div class="analysisBlockText">
                    <p>Where portfolios and watchlists are displayed</p>&nbsp;&nbsp;&nbsp;&nbsp;
                  </div>
              </div>
            </div>

			<!-- 2nd row -->
<br><br>
			<div class="row">
              <div class="col-md-4">
                <div class="analysisBlock text-center">
                    <img src="/images/admin.png" alt="">
                    <h2 class="orangeText">Admin</h2>
                    <a href="/JarvisV2/admin" title="">
                      <i class="fa fa-angle-right" aria-hidden="true"></i>
                    </a>
                </div>
                <div class="analysisBlockText">
                  <p>Used to select company tickers and names to be added to portfolios for tracking</p>
                </div>
              </div>

              <div class="col-md-4">
                  <div class="analysisBlock text-center">
                      <img src="/images/call.png" alt="">
                      <h2 class="violetText">Call</h2>
                      <a href="/JarvisV2/calls" title="">
                        <i class="fa fa-angle-right" aria-hidden="true"></i>
                      </a>
                  </div>
                  <div class="analysisBlockText">
                    <p> Historic call pricing on individual stocks and ETFs</p>&nbsp;&nbsp;&nbsp;&nbsp;
                  </div>
              </div>

              <div class="col-md-4">
                  <div class="analysisBlock text-center">
                      <img src="/images/put.png" alt="">
                      <h2 class="greenText">Put</h2>
                      <a href="/JarvisV2/puts" title="">
                        <i class="fa fa-angle-right" aria-hidden="true"></i>
                      </a>
                  </div>
                  <div class="analysisBlockText">
                    <p>Historic put pricing on individual stocks and ETFs</p>&nbsp;&nbsp;&nbsp;&nbsp;
                  </div>
              </div>
            </div>

        </div>

		 <!-- <div class="upArrow">
              <a href="data-upload.html" title="" class="hvr-push">
                  <img src="/images/Icon_Upload.svg" alt="">
              </a>
            </div> -->
      </main>
      <!--end main-->


    <script src="/js/jquery-1.11.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery-migrate-1.3.0.js" type="text/javascript"></script>
     <script src="/js/custom.js" type="text/javascript"></script>  

</body>
<script>
$("#helpBtn").click(function(){
    $(".helpContent").slideToggle();
    //});
    });
</script>

</html>