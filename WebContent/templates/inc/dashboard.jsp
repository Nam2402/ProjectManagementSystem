
<%@page import="model.bean.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>BOOTCAMP MANAGEMENT SYSTEM</title>
    <!-- Bootstrap core CSS -->
    <link href="<%= request.getContextPath()%>/templates/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom fonts for this template -->
    <link href="<%= request.getContextPath()%>/templates/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <!-- Plugin CSS -->
    <link href="<%= request.getContextPath()%>/templates/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="<%= request.getContextPath()%>/templates/css/sb-admin.css" rel="stylesheet">
	<link rel="shortcut icon" href="<%= request.getContextPath()%>/templates/public/images/logo.png" type="image/x-icon" />	
	<link href='https://fonts.googleapis.com/css?family=Poppins' rel='stylesheet'>
  	<link rel="stylesheet prefetch" href="https://cdn.jsdelivr.net/bootstrap.tagsinput/0.8.0/bootstrap-tagsinput.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-iconic-font/2.2.0/css/material-design-iconic-font.min.css">
  	<link rel="stylesheet" href="<%=request.getContextPath()%>/templates/css/styleDashboard1.css">
  	<link rel="stylesheet" href="<%=request.getContextPath()%>/templates/css/styleCommon.css">
  	
  	<!-- <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
<!-- 	<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.js" ></script>
 --> <script type="text/javascript" src="<%= request.getContextPath()%>/templates/vendor/jquery/jquery.min.js"></script> 
  	<!-- <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> --> 
  	<script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
 	<script type="text/javascript" src="jquery.twbsPagination.min.js"></script>
 	<script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.1/jquery.twbsPagination.js" type="text/javascript"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> 
    
    <style type="text/css">
		.hiden{display:none}
		.error{color:red}
		.label-info {background-color: #5bc0de;}
		.col-15 {
		float: left;
		width: 15%;
		margin-top: 6px;
		margin-left: 15px
	}
	.col-50 {
	    float: left;
	    width: 50%;
	    margin-top: 6px;
	}
    </style>
    
 </head>

<body class="fixed-nav" id="page-top"> 
    <%
    String styleTogglerBar = "";
    User user = (User)session.getAttribute("user");
    if(user == null){
    	%>
    	<script>
    	$(document).ready(function(){
    		window.location.href = 'http://localhost:8080/managementSystem/login';
    	});
    	</script>
    	<%
    }
    else if (user.getRoleId() == 3) {
    	%>
    	<!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top" id="mainNav" style="box-shadow: 2px 2px #c8c5c5;border-bottom: 1px solid #D9DEE4;background: rgb(237, 237, 237); height:74px;">
          <a class="navbar-brand" href="<%= request.getContextPath()%>/" style="margin-top:0px; margin-left:0px;">
          	<img src="<%=request.getContextPath()%>/templates/images/enclave_logo.png" width="100%" class="imglogo"/>
          </a>
          <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul id="slide_item" class="navbar-nav navbar-sidenav" style="min-height: 100%; max-width:250px;box-shadow: 2px 2px #c8c5c5;margin-top: 76px;background:white;">
          
          
              <li class="nav-item" data-toggle="tooltip"  data-placement="right" title="" style="width: 250px;">
                <a class="nav-link nav-link-collapse collapsed" href="<%= request.getContextPath()%>/trainee/index" style="font-size:  17px;">
                  <i class="fa fa-fw fa-users" style="margin-right: 11px; "></i>&nbsp;
                  <span class="nav-link-text">
                    Trainee</span>
                </a>
              </li>

              <li class="nav-item" data-toggle="tooltip" data-placement="right" title="" style="width: 250px;">
                <a class="nav-link nav-link-collapse collapsed"  href="<%= request.getContextPath()%>/trainer/index" style="font-size:  17px; ">
                  <i class="fa fa-fw fa-users" style="margin-right: 11px; "></i>&nbsp;
                  <span class="nav-link-text">
                    Trainer</span>
                </a>
              </li>
              
              <li class="nav-item" data-toggle="tooltip" data-placement="right" title="" style="width: 250px;">
                <a class="nav-link nav-link-collapse collapsed" href="<%= request.getContextPath()%>/major" style="font-size:  17px;">
                  <i class="fa fa-briefcase"   style="margin-left:3px; margin-right: 11px;"></i>&nbsp;
                  <span class="nav-link-text" style="margin-left: 2px;">
                    Major</span>
              	</a>
            </li>
              
              <li class="nav-item" data-toggle="tooltip" data-placement="right" title="" style="width: 250px;">
                <a class="nav-link nav-link-collapse collapsed"  href="<%= request.getContextPath()%>/classes/index" style="font-size:  17px;">
                  <i class="fa fa-university" style="margin-left:2px; font-size:15px;margin-right: 11px;"></i>&nbsp;
                  <span class="nav-link-text">
                    Class</span>
                </a>
            </li>
            
              <li class="nav-item" data-toggle="tooltip" data-placement="right" title="" style="width: 250px;">
                <a class="nav-link nav-link-collapse collapsed" href="<%= request.getContextPath()%>/course/index" style="font-size:  17px;">
                  <i class="fa fa-fw fa-book" style="margin-left:0px;margin-right: 11px; "></i>&nbsp;
                  <span class="nav-link-text">
                    Course</span>
                </a>
            </li>
            <li class="nav-item" data-toggle="tooltip" data-placement="right" title="" style="width: 250px;">
                <a class="nav-link nav-link-collapse collapsed" href="<%= request.getContextPath()%>/room" style="font-size:  17px;">
                  <i class="fa fa-home" style="margin-left:1px; font-size:21px;margin-right: 11px; "></i>&nbsp;
                  <span class="nav-link-text">
                    Room</span>
              </a>
            </li>
            <li class="nav-item" data-toggle="tooltip" data-placement="right" title="" style="width: 250px;">
                <a class="nav-link nav-link-collapse collapsed" href="<%= request.getContextPath()%>/Skills" style="font-size:  17px;">
                  <i class="fa fa-fw fa-graduation-cap" style="margin-left:0px;margin-right: 11px; "></i>&nbsp;
                  <span class="nav-link-text">
                    Skill</span>
              </a>
            </li>
             <li class="nav-item" data-toggle="tooltip" data-placement="right" title="" style="width: 250px;">
                <a class="nav-link nav-link-collapse collapsed" href="<%= request.getContextPath()%>/admin/requestTakeDateOff" style="font-size: 17px; font-family: Poppins;">
                  <i class="fa fa-paper-plane" style="margin-left:2px;margin-right: 11px;"></i>&nbsp;
                  <span class="nav-link-text" style="margin-left:4px;">
                    Request</span>
              </a>
		</li>
        </ul>
     <%
    } else {
    	styleTogglerBar = "style='display: none'";
    %>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top" id="mainNav" style="background:white; height:74px; box-shadow:2px 2px #c8c5c5">
      <a href="<%= request.getContextPath()%>/"><img alt="Enlave" src="<%= request.getContextPath()%>/templates/images/enclave_logo.png" width="150px" height="50px" style="margin-left: 10px; margin-bottom: -13px; margin-top: -12px;"></a>
    <!--  <a style="display: inline-block; margin-left: 10px;" class="navbar-brand" href=""></a> -->
       <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>  
      
      <nav id="mainNav1" class="navbar navbar-default" style="font-size:16px;margin-left: 27px;">
		  <div class="container-fluid">
		    <ul class="nav navbar-nav">
		    <%
				    if(user.getRoleId() == 1) {
				    %>
				      <li  class="li1 nav-item" data-toggle="tooltip" data-placement="right"  ><a class="a1 nav-link nav-link-collapse collapsed" style="color: #555;" href="<%= request.getContextPath()%>/trainer/schedule?user_id=<%= user.getUserId()%>">Schedule</a></li>
				    <%
				    } else if (user.getRoleId() == 2) {
			    	%>
				      <li class="li1 nav-item" data-toggle="tooltip" data-placement="right" style="padding-left: 10px; padding-right: 10px;"><a class="a1 nav-link nav-link-collapse collapsed"  style="" href="<%= request.getContextPath()%>/trainee/schedule?user_id=<%= user.getUserId()%>">Schedule</a></li>
				      <li class="li1 nav-item" data-toggle="tooltip" data-placement="right" style="padding-left: 10px; padding-right: 10px;"><a class="a1 nav-link nav-link-collapse collapsed"  style="" href="<%= request.getContextPath()%>/trainee/list/classcanregister?user_id=<%= user.getUserId()%>">Class Registration</a></li>
				      <li class="li1 nav-item" data-toggle="tooltip" data-placement="right" style="padding-left: 10px; padding-right: 10px;"><a class="a1 nav-link nav-link-collapse collapsed" style="" href="<%= request.getContextPath()%>/trainee/list/classwaitstart">Pending Class</a></li>
				      <li class="li1 nav-item" data-toggle="tooltip" data-placement="right" style="padding-left: 10px; padding-right: 10px;"><a class="a1 nav-link nav-link-collapse collapsed"  style="" href="<%= request.getContextPath()%>/trainee/results?user_id=<%= user.getUserId()%>">Result</a></li>
					 <%
				    } 
				    %>
		    </ul>
		  </div>
		</nav>
	
    <%
    }
    %>
    
        <script type="text/javascript">
      jQuery(document).ready(function($){
        var url = window.location.href;
          $(".nav-item a").each(function() {
              if(url == (this.href)) {
                  $(this).closest("li").addClass("active");
              }
          });
      });
     </script>
     <script type="text/javascript">
     
	   $(document).ready(function()
	   { 
	      //khi nÃºt submit Ä‘Æ°á»£c click
	    $('#btt').click(function(){
	    	
	        //Sá»­ dá»¥ng phÆ°Æ¡ng thá»©c Ajax.
	        $.ajax({
	              type : 'POST', //Sá»­ dá»¥ng kiá»ƒu gá»­i dá»¯ liá»‡u POST
	              url : '/managementSystem/ListNotificationAjax', //gá»­i dá»¯ liá»‡u sang trang data.php
	              success : function(result)  // HÃ m thá»±c thi khi nháº­n dá»¯ liá»‡u Ä‘Æ°á»£c tá»« server
	                        { 
	            				$('#result1').html(result);
	                        }
	              });
	        });
	    });
	</script>
     

        <script type="text/javascript">
			jQuery(document).ready(function ($) {
        	
        	function updateNumberNoti()
    			{        		
        		$.ajax({
                    type: "GET",
                    url: "/managementSystem/CountNotificationController",
                    timeout:1000,
                    success: function (data) {
                       if(data === ""){
                    	   
                       }
                       else{
                    	   var string= "<span id ='countNoti' class='badge bg-green'>" + data + "</span>";
                    	   $("#countNoti").replaceWith(string);
                       }
                    }
                });
        		setTimeout(updateNumberNoti, 10000);
    		}
        	updateNumberNoti();
        });
        $(document).ready(function() { 
	        $( "#sidenavToggler" ).click(function() {
	        	  $( "#slide_item" ).toggle( "slow", function() {
	        	  });
	        });
        });
        </script>
        
        <ul class="navbar-nav ml-auto">
		
		  <li role="presentation" class="dropdown">
		  	<a class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
              <i id="btt" class="iconMail fa fa-envelope-o" style=" width: 25px;font-size: 20px;"></i>
              <span  id ="countNoti" class="badge bg-green">0</span>
            </a>
             <ul id="result1" class="dropdown-menu msg_list pull-right" role="menu"></ul>
           </li>
                
          <li class="nav-item nav-item1">
          	<a href="javascript:void(0);" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false" style="margin-right: 10px; width: 25px;">
                <img src="<%=request.getContextPath()%>/files/<%= user.getAvatar()%>" ><%= user.getUsername()%>
            </a>
            <ul class="dropdown-menu menu_user pull-right" style="margin-top:-7px;">
				    <%
				    if(user.getRoleId() == 1) {
				    %>
				      <li><a href="<%= request.getContextPath()%>/trainer/edit?id=<%= user.getUserId()%>">My Profile</a></li>
				    <%
				    }  else{
			    	%>
				      <li><a href="<%= request.getContextPath()%>/trainee/edit?id=<%= user.getUserId()%>">My Profile</a></li>
				    <%
				    }
				    %>
                    <li><a  href="<%= request.getContextPath()%>/logout"><i style="margin-top:10px;" class="fa fa-sign-out pull-right"></i> Log Out</a></li>

            </ul>
          </li>
          <div id="maincontent">
  			
		 </div>
        </ul>
       </div>
       </nav>

     <script type="text/javascript">
   $(document).ready(function(){ 
    $('#btt').click(function(){
        $.ajax({
              type : 'POST', //Sá»­ dá»¥ng kiá»ƒu gá»­i dá»¯ liá»‡u POST
              url : '/managementSystem/ListNotificationAjax', //gá»­i dá»¯ liá»‡u sang trang data.php
              success : function(result)  // HÃ m thá»±c thi khi nháº­n dá»¯ liá»‡u Ä‘Æ°á»£c tá»« server
                        { 
            				$('#result1').html(result);
                        }
              });
        });
	   $(document).on('click','.view',function(){
			 var post_id = $(this).attr("id");
			 fetch_post_data(post_id);
		});
	   $(document).on('click','.aprove',function(){
		   			 var request_id= $("#request_id").text();
		   					$.ajax({
		   						type : 'POST',
		   						url : '/managementSystem/ApproveRequestOffTrainerAjax?request_id=' + request_id,
		   						success : function(data) {
		   
		   				        	   if(data == 1){
		   									alert('You have just approved this request!');
		   									$('#post_modal').modal('hide');
		   								}
		   								else if(data == 0){
		   									alert('Some error. Please approve it again!');
		   								}
		   							
		   						}
		   					});
		   		});
		function fetch_post_data(post_id)
		{	
			
			$.ajax({
				url: '/managementSystem/ShowDetailNotiAjax?post_id=' + post_id,
				type : 'POST',
				//data:{post_id:post_id},
				success:function(data)
				{
					$('#post_modal').modal('show');
					$('#post_detail').html(data);					 
				}
			});
		}
		function approveRequest() {
						alert("Yes");
						var request_id= $("#request_id").text();
						alert(request_id);
							$.ajax({
								type : 'POST',
								url : '/managementSystem/forgotpassword?emailForgot=' + request_id,
								success : function(data) {
									alert(data);
								}
							});
						
					}
		
		
	});
</script>
<div id="post_modal" class ="modal fade">
		<div class = "modal-dialog">
		<div style="margin:auto;margin-top:60%;" class="modal-content"  id = "post_detail">
		</div>
<%
	if(user.getRoleId() == 3){
%> 
		<div id="post_modal" class ="modal fade">
			<div class = "modal-dialog">
				<div style="margin:auto;margin-top:60%;" class="modal-content"  id = "post_detail">
				<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="btnForgot" onclick="sendEmail();">Send</button>
				
				<button type="button" style=" background:#2e9ade; color: white; " class="btn btn-infor" data-dismiss="modal">Close</button> \
				</div>	
				</div>	
					
			</div>
		</div> 
<%
	} else{
%>	
		<div id="post_modal" class ="modal fade">
	 		<div class = "modal-dialog">
	 			<div style="margin:auto;margin-top:60%;" class="modal-content"  id = "post_detail"> </div>
	 		</div>
		</div>
<%
	}
%>	
	</div>
</div>

