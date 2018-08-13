

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
    
    <link href="<%= request.getContextPath()%>/templates/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath()%>/templates/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

	  <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> -->
	  <script  type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	  <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- Plugin CSS -->
    <link href="<%= request.getContextPath()%>/templates/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
    <link href="<%= request.getContextPath()%>/templates/css/sb-admin.css" rel="stylesheet">
	<link rel="shortcut icon" href="<%= request.getContextPath()%>/templates/public/images/logo.png" type="image/x-icon" />

 	 <script type="text/javascript" src="<%= request.getContextPath()%>/templates/vendor/jquery/jquery.min.js"></script>
  	<script type="text/javascript" src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
  	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

  	<link rel="stylesheet" href="<%=request.getContextPath()%>/templates/css/styleDashboard1.css">
  	<link rel="stylesheet prefetch" href="https://cdn.jsdelivr.net/bootstrap.tagsinput/0.8.0/bootstrap-tagsinput.css">
  	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    
    
	<script type="text/javascript" src="jquery.twbsPagination.min.js"></script>
	<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.4/css/bootstrap.min.css" /> -->
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.js" ></script>
	        <!-- JS tạo nút bấm di chuyển trang start -->
  	<link rel="stylesheet prefetch" href="https://cdn.jsdelivr.net/bootstrap.tagsinput/0.8.0/bootstrap-tagsinput.css">	
	<script src="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css"></script>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/templates/css/styleDashboard1.css">
  	
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.js" ></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	
	<script type="text/javascript" src="jquery.twbsPagination.min.js"></script>
	<script src="http://1892.yn.lt/blogger/JQuery/Pagging/js/jquery.twbsPagination.js" type="text/javascript"></script>
	
	<script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
	
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

<body class="fixed-nav" id="page-top"  onload="disableSubmit();">

    <%
    String styleTogglerBar = "";
    User user = (User)session.getAttribute("user");
    if (user.getRoleId() == 3) {
    	%>
    	<!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
          <a class="navbar-brand" href="">BOOTCAMP MANAGEMENT SYSTEM</a>
          <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul id="slide_item" class="navbar-nav navbar-sidenav" style="margin-top: 41px; min-width:250px; max-width:250px;">
              <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Dashboard">
                <a class="nav-link" href="<%= request.getContextPath()%>/">
                  <img alt="Enlave" src="<%= request.getContextPath()%>/templates/images/enclave.jpg" class="img-thumbnail" alt="Cinque Terre" width="220">
                </a>
              </li>

              <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Components">
                <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#trainee" style="font-size:  larger;">
                  <i class="fa fa-fw fa-users"></i>&nbsp;
                  <span class="nav-link-text">
                    Trainee</span>
                </a>
                <ul class="sidenav-second-level collapse" id="trainee">
                  <li>
                    <a href="<%= request.getContextPath()%>/trainee/index"><i class="fa fa-fw fa-list"></i> List Trainees</a>
                  </li>
                  <li>
                    <a href="<%= request.getContextPath()%>/trainee/add"><i class="fa fa-fw fa-plus"></i> Add New Trainee</a>
                  </li>
                </ul>
              </li>

              <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Components">
                <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#trainer" style="font-size:  larger;">
                  <i class="fa fa-fw fa-users" ></i>&nbsp;
                  <span class="nav-link-text">
                    Trainer</span>
                </a>
                <ul class="sidenav-second-level collapse" id="trainer">
                  <li>
                    <a href="<%= request.getContextPath()%>/trainer/index"><i class="fa fa-fw fa-list"></i> List Trainers</a>
                  </li>
                  <li>
                    <a href="<%= request.getContextPath()%>/trainer/add"><i class="fa fa-fw fa-plus"></i> Add New Trainer</a>
                  </li>
                </ul>
              </li>
              
              <li class="nav-item" data-toggle="tooltip" data-placement="right" title="major">
                <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#major" style="font-size:  larger;">
                  <i class="fa fa-briefcase" ></i>&nbsp;
                  <span class="nav-link-text">
                    Major</span>
              	</a>
              <ul class="sidenav-second-level collapse" id="major">
                <li>
                  <a href="<%= request.getContextPath()%>/major"><i class="fa fa-fw fa-list"></i> List majors</a>
                </li>
               
              </ul>
            </li>
              
              <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Components">
                <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#class" style="font-size:  larger;">
                  <i class="fa fa-fw fa-object-group"></i>&nbsp;
                  <span class="nav-link-text">
                    Class</span>
                </a>
                <ul class="sidenav-second-level collapse" id="class">
                  <li>
                    <a href="<%= request.getContextPath()%>/classes/index"><i class="fa fa-fw fa-list"></i> List Classes</a>
                  </li>
                  <li>
                    <a href="<%= request.getContextPath()%>/classes/add"><i class="fa fa-fw fa-plus"></i> Add New Class</a>
                  </li>
                </ul>
            </li>
            
              <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Components">
                <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#course" style="font-size:  larger;">
                  <i class="fa fa-fw fa-book"></i>&nbsp;
                  <span class="nav-link-text">
                    Course</span>
                </a>
                <ul class="sidenav-second-level collapse" id="course">
                  <li>
                    <a href="<%= request.getContextPath()%>/course/index"><i class="fa fa-fw fa-list"></i> List Courses</a>
                  </li>
                  <li>
                    <a href="<%= request.getContextPath()%>/course/add"><i class="fa fa-fw fa-plus"></i> Add New Course</a>
                  </li>
                </ul>
            </li>
            <li class="nav-item" data-toggle="tooltip" data-placement="right" title="contact">
                <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#room" style="font-size:  larger;">
                  <i class="fa fa-home" ></i>&nbsp;
                  <span class="nav-link-text">
                    Room</span>
              </a>
              <ul class="sidenav-second-level collapse" id="room">
                <li>
                  <a href="<%= request.getContextPath()%>/room"><i class="fa fa-fw fa-list"></i> List rooms</a>
                </li>
               
              </ul>
            </li>
            <li class="nav-item" data-toggle="tooltip" data-placement="right" title="contact">
                <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#skill" style="font-size:  larger;">
                  <i class="fa fa-fw fa-graduation-cap" ></i>&nbsp;
                  <span class="nav-link-text">
                    Skill</span>
              </a>
              <ul class="sidenav-second-level collapse" id="skill">
                <li>
                  <a href="<%= request.getContextPath()%>/Skills"><i class="fa fa-fw fa-list"></i> List skills</a>
                </li>
               
              </ul>
            </li>
             <li class="nav-item" data-toggle="tooltip" data-placement="right" title="contact">
                <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#request" style="font-size:  larger;">
                  <i class="fa fa-paper-plane" ></i>&nbsp;
                  <span class="nav-link-text">
                    Requestions</span>
              </a>
              <ul class="sidenav-second-level collapse" id="request">
                <li>
                  <a href="<%= request.getContextPath()%>/admin/requestTakeDateOff"><i class="fa fa-fw fa-list"></i> List Requestions</a>
                </li>
               
              </ul>
		</li>
            <li class="nav-item" data-toggle="tooltip" data-placement="right" title="contact">
                <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#statistical" style="font-size:  larger;">
                  <i class="fa fa-calculator" ></i>&nbsp;
                  <span class="nav-link-text">
                    Statistic</span>
              </a>
              <ul class="sidenav-second-level collapse" id="statistical">
                <li>
                  <a href="<%= request.getContextPath()%>/statistical/trainee"><i class="fa fa-fw fa-calculator"></i> Trainees</a>
                </li>
                <li>
                  <a href="<%= request.getContextPath()%>/statistical/result"><i class="fa fa-fw fa-calculator"></i> Class's Quality</a>
                </li>
              </ul>
            </li>
            </ul>
     <%
    } else {
    	styleTogglerBar = "style='display: none'";
    %>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
      <a href="<%= request.getContextPath()%>/"><img alt="Enlave" src="<%= request.getContextPath()%>/templates/images/enclave.jpg" width="95px" style="margin-left: -16px; margin-bottom: -13px; margin-top: -8px;"></a>
    <!--  <a style="display: inline-block; margin-left: 10px;" class="navbar-brand" href=""></a> -->
       <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>  
      
      <nav class="navbar navbar-default">
		  <div class="container-fluid">
		    <ul class="nav navbar-nav">
		    <%
				    if(user.getRoleId() == 1) {
				    %>
				      <li ><a style="color: white;" href="<%= request.getContextPath()%>/trainer/schedule?user_id=<%= user.getUserId()%>">Schedule</a></li>
				    <%
				    } else if (user.getRoleId() == 2) {
			    	%>
				        <li style="display: block;"><a style="color: white;" href="<%= request.getContextPath()%>/trainee/schedule?user_id=<%= user.getUserId()%>">Schedule</a></li>
				      <li style="display: block; margin-left: 20px;"><a style="color: white;" href="<%= request.getContextPath()%>/trainee/list/classcanregister?user_id=<%= user.getUserId()%>">Register Class</a></li>
				      <li style="display: block; margin-left: 20px;"><a style="color: white;" href="<%= request.getContextPath()%>/trainee/list/classwaitstart">Waiting Start</a></li>
				      <li style="display: block; margin-left: 20px;"><a style="color: white;" href="<%= request.getContextPath()%>/trainee/results?user_id=<%= user.getUserId()%>">Result</a></li>
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
	      //khi nút submit được click
	    $('#btt').click(function(){
	    	
	        //Sử dụng phương thức Ajax.
	        $.ajax({
	              type : 'POST', //Sử dụng kiểu gửi dữ liệu POST
	              url : '/managementSystem/ListNotificationAjax', //gửi dữ liệu sang trang data.php
	              success : function(result)  // Hàm thực thi khi nhận dữ liệu được từ server
	                        { 
	            				$('#result1').html(result);
	                        }
	              });
	        });
	    });
	</script>
     
        <ul class="navbar-nav sidenav-toggler" <%= styleTogglerBar%> >
          <li class="nav-item">
            <a class="nav-link text-center" id="sidenavToggler">
              <i class="fa fa-fw fa-angle-left"></i>
            </a>
          </li>
        </ul>
        <script type="text/javascript">
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
              <i id="btt" class="iconMail fa fa-envelope-o" style=" width: 25px;"></i>
              <span class="badge bg-green">?</span>
            </a>
             <ul id="result1" class="dropdown-menu msg_list pull-right" role="menu"></ul>
           </li>
                
          <li class="nav-item nav-item1">
          	<a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false" style="margin-right: 10px; width: 25px;">
                <img src="<%=request.getContextPath()%>/files/<%= user.getAvatar()%>" ><%= user.getUsername()%>
            </a>
            <ul class="dropdown-menu menu_user pull-right">
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
      //khi nút submit được click
    $('#btt').click(function(){
    	
        //Sử dụng phương thức Ajax.
        $.ajax({
              type : 'POST', //Sử dụng kiểu gửi dữ liệu POST
              url : '/managementSystem/ListNotificationAjax', //gửi dữ liệu sang trang data.php
              success : function(result)  // Hàm thực thi khi nhận dữ liệu được từ server
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
 		<div style="margin:auto;margin-top:60%;" class="modal-content"  id = "post_detail">
 		</div>
 		
 	</div>
</div>
	</div>
<%
	}
%>		


</html>
