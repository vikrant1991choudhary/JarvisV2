<header>
          <div class="container">
              <!--left-->
              <div class="float-left">
                <div class="logo">
                    <img src="images/bangladesh_govt_logo_0.gif" alt="" class="banglaLogo">
                    <a href="#" title="">
                        <img src="images/bbc.png" alt="">
                        <h1>Skill Gap Analysis</h1>
                    </a>
                </div>
              </div>
              <!--end left-->

              <!--right-->
              <div class="float-right">
                  <ul class="headLinks">
                    <li>
                        <a href="index" title="">
                          <img src="images/Icon_Home.svg" alt=""><span>Home</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:void(0)" title="" id="helpBtn">
                          <img src="images/Icon_Help.svg" alt=""><span>Help</span>
                        </a>
                    </li>
                    <li>
                        <a href="logout.php" title="">
                          <img src="images/Icon_Logout.svg" alt=""><span>logout</span>
                        </a>
                    </li>
                  </ul>
              </div>
              <!--end right-->
          </div>
</header>
          
      <div class="helpContent">
        <p class="text-center">Please download User manual
          <a href="images/User Manual.pdf" title="" target="_blank"><i class="fa fa-file-pdf-o" aria-hidden="true"></i> </a>
        </p>
      </div>
      <?php include 'footer.php';?>
      <script>
          $("#helpBtn").click(function(){
            $(".helpContent").slideToggle();
            //});
            });
    </script>