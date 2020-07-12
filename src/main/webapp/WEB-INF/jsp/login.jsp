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
   <link rel="stylesheet" href="/css/style.css" type="text/css">
    </head>
    <body>
    

    <!--login-->
    <section class="login h100">
        <div class="container w-60">
            <div class="row justify-content-sm-center">
              <div class="col-sm-6">
                <div class="loginLeftImg">
                  <img src="/images/logo_leftbraincm.jpg" alt="">
				  <h3 style="text-transform: uppercase;">Jarvis 2.0 </h3>
                  <h5>Investment Management Portal</h1>
                  
                </div>
              </div>
              <div class="col-sm-6">
                <div class="card border-info text-center">
                  <h3 style="color:#247041">
                    Sign in
                  </h3>
                  <div class="card-body">
                    <form class="form-signin" action="/JarvisV2/home" method="post">
                      <span>
                        <input type="text" class="form-control mb-2 user" placeholder="User Name" name="userName" required>
                        <a href="forgotUser" title="">Forget username?</a>
                      </span>
                      <span>
                        <input type="password" class="form-control mb-2 pwd" placeholder="Password" name="password" required>
                        <a href="forgotPassword" title="">Forget Password?</a>
                      </span>
                      <button class="btn btn-lg btn-block" type="submit">sign in</button>
                   	  <h6 style="color:red">${message}</h6>
                    </form>
                  </div>
                </div>
                
              </div>
            </div>
          </div>
         
    </section>
    <!--end login-->
    
    <!-- The Modal -->

<div class="modal error blackBgModl" id="myModalB">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <a href="#" title="" class="close" data-dismiss="modal">
              <img src="/images/cross_icon.png" alt="">
            </a>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
         <h3 class="text-center"></h3>
         <div class="btn-set text-center mt-4">
            <!--<button type="button" class="btn btn-success mr-2" id="btnProceed">Proceed</button>
            <button type="button" class="btn btn-danger" id="btnCancel">Cancel</button>-->
         </div>
      </div>
    </div>
  </div>
</div>

    <!--end Modal-->

    <script
    src="https://code.jquery.com/jquery-3.3.1.min.js"
    integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
    crossorigin="anonymous"></script>
    <script src="/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="/js/popper.min.js" type="text/javascript"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.5/jspdf.debug.js" type="text/javascript"></script> 
    <script src="/js/custom.js" type="text/javascript"></script>  
    
     <script>
    $( document ).ready(function() {
          
        });
  </script>
    
    </body>
    </html>