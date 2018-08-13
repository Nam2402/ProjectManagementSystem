<%@page import="model.bean.Classes"%>
<%@page import="model.bean.User"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/templates/inc/dashboard.jsp" %>  
<link rel="stylesheet" href="<%=request.getContextPath()%>/templates/css/styleMajor.css">

<%
String classNameContent = "" ;
String classNameContainer = "";
String styleContent = "style='margin-top:  5px;'";
if( user.getRoleId() == 3) {
	classNameContent = "content-wrapper py-3";
	classNameContainer = "container-fluid";
	styleContent = "";
}

%>

<div class="<%= classNameContent%>" <%= styleContent%> id="toggler_contentId" style="overflow-x: inherit;">
  <div class="<%= classNameContainer%>" id="toggler_containerId" >
    <div  class="card1 card mb-3" style="margin-top:0px;box-shadow: 2px 2px #c8c5c5;">
<!-- Nav -->
       	<div class="alert1 alert alert-primary"  style="padding-left: 10px; margin-bottom: 0px;"> 
        	<i class="fa fa-university" style="font-size: 23px;" ></i>
			<strong  class="lb_name">Class</strong>
		</div>
		
<!-- Div Page Content -->
        <div>
	  <%
	  String msg = "";
	  if(request.getParameter("msg") != null){
		  boolean check = false;
		  int msgInt = Integer.parseInt((String)request.getParameter("msg"));
		  switch(msgInt) {
		  case 1: {
			  check = true;
			  msg = "You added class successfully."; break;
		  }
		  case 2:{
			  check = true;
			  msg = "You edit class successfully."; break;
		  }
		  case 3:{
			  check = true;
			  msg = "You deleted class successfully."; break;
		  }
		  case 4:{
			  check = true;
			  msg  = "You deleted classes successfully."; break;
		  }
		  case 0:{
			  check = false;
			  msg  = "Error! System have some problems. Please try again."; break;
		  }
		  }
		   if( check == false){
		  %>
        	<div class="alert alert-danger">
		    	<strong> <%= msg%> </strong>
		  	</div>
		  <%
		  } else {
			  %>
	        	<div class="alert alert-success">
			    	<strong> <%= msg%> </strong>
			  	</div>
			  <%
		  }
	  }
	  %>
	  
		<%
		ArrayList<Classes> classesWait = new ArrayList<Classes>();
		ArrayList<Classes> classesOpen = new ArrayList<Classes>();
		ArrayList<Classes> classesFinish = new ArrayList<Classes>();
		String[] day = {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
		int totalWait = 0, totalOpen = 0, totalFinish = 0;
		if (request.getAttribute("classesWait") != null) {
			classesWait = (ArrayList<Classes>) request.getAttribute("classesWait");
			totalWait = classesWait.size();
		}
		if (request.getAttribute("classesOpen") != null) {
			classesOpen = (ArrayList<Classes>) request.getAttribute("classesOpen");
			totalOpen = classesOpen.size();
		}
		if (request.getAttribute("classesFinish") != null) {
			classesFinish = (ArrayList<Classes>) request.getAttribute("classesFinish");
			totalFinish = classesFinish.size();
		}
		%>
        <script type="text/javascript">
            $(document).ready(function(){
                $(document).on('change', '.checkall, .checkitem', function(){
                    var $_this = $(this);
                    document.getElementById("deleteall").style.display = "block";
                    if($_this.hasClass('checkall')){
                        $('.checkitem').prop('checked', $_this.prop('checked'));
                    }else{
                        var $_checkedall = true;
                        $('.checkitem').each(function(){
                            if(!$(this).is(':checked')){
                                $_checkedall = false;
                            }
                            $('.checkall').prop('checked', $_checkedall);
                        });
                    }
                    var $_uncheckedall = true;
                    $('.checkitem').each(function(){
                        if($(this).is(':checked')){
                            $_uncheckedall = false;
                        }
                        if($_uncheckedall){
                            document.getElementById("deleteall").style.display = "none";
                        }else{
                            document.getElementById("deleteall").style.display = "block";
                        }
                    });
                });
            });
        </script>
   <div class="card-body" style="margin-top: 0px;">
         <div class="table-responsive" style="background: white;padding: 10px 10px; margin-top: 0px;">
            <form action="#"  method="post" style="margin-top: 10px;">
	            <div style="margin-left: -15px; margin-bottom: 5px;">
	            
	            	<div style="float: left">
	            		<a style="width:auto; font-size:15px; height:auto; margin-bottom:10px; margin-left: 14px;" class="btn btn-primary" href="<%=request.getContextPath() %>/classes/add" role="button">Add Class</a>
	        		</div>
	        		
	            	<div style="float: left; margin-left: 15px;" >
	            		<input  class="btn btn-danger" style="display: none; margin-left: 10px; margin-bottom: 5px;" onclick="return confirm('Do you want to delete these Classes?')" id="deleteall" type="submit" value="Delete Classes">
                	</div>
                	
                	<div style="float: right; width: 25%;">
                				<input class="box-search" style="width: 100%;" id="myInput" type="text" placeholder="Search..">
                			</div>
		               		<script>
								$(document).ready(function(){
								  $("#myInput").on("keyup", function() {
								    var value = $(this).val().toLowerCase();
								    $("#myTBody tr").filter(function() {
								      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
								    });
								  });
								});
							</script>
                	<div style="float: right; margin-right: 15px;">
					  <ul class="nav nav-tabs" style='border-bottom: 0px solid #ddd;'>
					    <li class="btn btn-light" id="waitingStyle" style="margin-right: 15px;"><a  data-toggle="tab" href="#waiting" style="color: #333333; text-decoration: none;">Waiting</a></li>
					    <li class="btn btn-light" style="margin-right: 15px;"><a  data-toggle="tab" href="#openning" style="color: #333333; text-decoration: none;">Opening</a></li>
					    <li class="btn btn-light" style="margin-right: 15px;"><a  data-toggle="tab" href="#finished" style="color: #333333; text-decoration: none;">Finished</a></li>
					  </ul>
                	</div>
					<script>
					$(document).ready(function(){
						 //document.getElementById("first").add;
					    $(".nav-tabs a").click(function(){
					        $(this).tab('show');
					        $(this).css("color", "#000000");
					    });
					});
					</script>

                	<div style="clear: both"></div>
	        	</div>
	        	<div class="tab-content">
		        	<div  id="waiting" class="tab-pane active in">
		        	<script type="text/javascript">
			            $(function () {
			                var pageSize = 10; // Hiển thị 10 sản phẩm trên 1 trang
			                showPage = function (page) {
			                    $(".contentPageWait").hide();
			                    $(".contentPageWait").each(function (n) {
			                        if (n >= pageSize * (page - 1) && n < pageSize * page)
			                            $(this).show();
			                    });
			                }
			                showPage(1);
			                ///** Cần truyền giá trị vào đây **///
			                var totalRows = <%= totalWait%>; // Tổng số sản phẩm hiển thị
			                var btnPage = 5; // Số nút bấm hiển thị di chuyển trang
			                var iTotalPages = Math.ceil(totalRows / pageSize);
			
			                var obj = $('#paginationWait').twbsPagination({
			                    totalPages: iTotalPages,
			                    visiblePages: btnPage,
			                    onPageClick: function (event, page) {
			                        console.info(page);
			                        showPage(page);
			                    }
			                });
			                console.info(obj.data());
			            });
			        </script>
		        		<table style="border-collapse: collapse;" id="myTable" class="myTable table table-bordered table-hover table-compact" width="100%">
                  			<thead>
		                    <tr>
		                      <th style="text-align: center; font-size: medium; vertical-align: middle;">Delete<input style="display: inline-block; " type="checkbox" class="checkall"></th>
		                      <th style="text-align: center; font-size: medium;vertical-align: middle;">Name</th>
		                      <th style="text-align: center; font-size: medium;vertical-align: middle;">Trainer</th>
		                      <th style="text-align: center; font-size: medium;vertical-align: middle;">Course</th>
		                      <th style="text-align: center; font-size: medium;vertical-align: middle;">Time Of Date</th>
		                      <th style="text-align: center; font-size: medium;vertical-align: middle;">Day Of Week</th>
		                      <th style="text-align: center; font-size: medium;vertical-align: middle;">Duration (hours)</th>
		                      <th style="text-align: center; font-size: medium;vertical-align: middle;">Trainees (Waiting)</th>
		                      <th width="20%" style="text-align: center; font-size: medium;vertical-align: middle;">Action</th>
		                    </tr>
		                  </thead>
		                  <tbody id="myTBody" >
		                  <%
		                  	for(Classes classIndex : classesWait){
		                  %>	
		                  	<tr class="contentPageWait" id='class<%= classIndex.getClassId()%>'>
		                      	<td  style="text-align: center; vertical-align: middle;"> <input onclick="changeColor();" type="checkbox" name="class<%= classIndex.getClassId()%>" value="<%= classIndex.getClassId()%>" class="checkitem" id="chkitem"> </td>
		                     	<td  style="vertical-align: middle;"> <a style="color: #000000;" href="#"><b><%= classIndex.getName() %></b></a> </td>
			                    <%
			                    if( classIndex.getNameTrainer() == null) {
			                    %>
			                    <td  style="text-align: center; vertical-align: middle;"> No Trainer</td>
			                    <%
			                    } else {
		                    	%>
			                    <td  style="text-align: center; vertical-align: middle;"> <%= classIndex.getNameTrainer()%></td>
			                    <%	
			                    }
			                    %>
			                    <td  style="vertical-align: middle;"><%= classIndex.getNameCourse()%></td>
			                    <td  style="vertical-align: middle;"><%= classIndex.getTimeOfDate()%></td>
			                    <%
			                    String openClass = "";
			                    String colorStatus = "color: #999999";
			                    if ( classIndex.getStudents() >= 5) {
			                    	openClass = "changeStatusClass( " + classIndex.getClassId() + ", 0);";
			                    	colorStatus = "";
			                    }
			                    String[] date = classIndex.getDateOfWeek().split(",");
			                    String dateStr = "";
			                    for (int j = 0; j < date.length; j++) {
			                    	for (int i = 0; i < day.length; i++) {
				                    	if (Integer.parseInt(date[j]) == (i+2) && j == date.length - 1) {
				                    		dateStr += day[i];
				                    	} else if (Integer.parseInt(date[j]) == (i+2) && j != date.length - 1) {
				                    		dateStr += day[i] + ", ";
				                    	}
			                    	}
			                    }
			                    %>
			                    <td  style='vertical-align: middle;'> <%= dateStr%></td>
			                    <td  style="text-align: center; vertical-align: middle;"><%= classIndex.getDuration()%></td>
			                    <td  style="text-align: center; vertical-align: middle;"><%= classIndex.getStudents()%></td>
		                    	<td  style="text-align: center; vertical-align: middle;">
		                    		<a href="javascript:void(0)" onclick="<%= openClass%>" ><i class="fa fa-check" aria-hidden="true" style="font-size:20px; <%= colorStatus%>"></i></a>
		                        	<a style="margin-left: 10px"  href="#"><i class="fa fa-edit" style="font-size:20px"></i></a>
		                        	<a style="margin-left: 10px" href="#" onclick="return confirm('Do you want to delete class: <%= classIndex.getName()%>?')"><i class="fa fa-trash" style="font-size:20px;color: red"></i></a>
		                     	</td>
		                    </tr>
		                  <%	
		                  	}
		                  %>
		                </tbody>
                	</table>
	                	
	                <div id="pager">
						<ul id="paginationWait" class="pagination-sm"></ul>
					</div>
		       		</div>
		       		 
		       		 <div  id="openning" class="tab-pane fade">
		       		 	<script type="text/javascript">
				            $(function () {
				                var pageSize = 10; // Hiển thị 10 sản phẩm trên 1 trang
				                showPage = function (page) {
				                    $(".contentPageOpen").hide();
				                    $(".contentPageOpen").each(function (n) {
				                        if (n >= pageSize * (page - 1) && n < pageSize * page)
				                            $(this).show();
				                    });
				                }
				                showPage(1);
				                ///** Cần truyền giá trị vào đây **///
				                var totalRows = <%= totalOpen%>; // Tổng số sản phẩm hiển thị
				                var btnPage = 5; // Số nút bấm hiển thị di chuyển trang
				                var iTotalPages = Math.ceil(totalRows / pageSize);
				
				                var obj = $('#paginationOpen').twbsPagination({
				                    totalPages: iTotalPages,
				                    visiblePages: btnPage,
				                    onPageClick: function (event, page) {
				                        console.info(page);
				                        showPage(page);
				                    }
				                });
				                console.info(obj.data());
				            });
				        </script>
				        <table style="border-collapse: collapse;" id="myTable" class="myTable table table-bordered table-hover table-compact" width="100%">
		                  <thead>
		                    <tr>
		                      <th style="text-align: center; font-size: medium;">No.</th>
		                      <th style="text-align: center; font-size: medium;">Name</th>
		                      <th style="text-align: center; font-size: medium;">Trainer</th>
		                      <th style="text-align: center; font-size: medium;">Course</th>
		                      <th style="text-align: center; font-size: medium;">Time Of Date</th>
		                      <th style="text-align: center; font-size: medium;">Day Of Week</th>
		                      <th style="text-align: center; font-size: medium;">Duration (hours)</th>
		                      <th style="text-align: center; font-size: medium;">Taught Hours</th>
		                      <th style="text-align: center; font-size: medium;">Trainees (Learning)</th>
		                      <!-- <th style="text-align: center; font-size: medium;">Action</th> -->
		                    </tr>
		                  </thead>
		                  <tbody id="myTBody" >
		                  <%
		                  	int indexO = 0;
		                  	for(Classes classIndex : classesOpen){
		                  		indexO++;
		                  %>	
		                  	<tr class="contentPageOpen" id='class<%= classIndex.getClassId()%>'>
		                      	<td  style="text-align: center; vertical-align: middle;"><%= indexO%></td>
		                     	<td  style="vertical-align: middle;"><b style="color: #000000"><%= classIndex.getName()%></b></td>
			                    <%
			                    if( classIndex.getNameTrainer() == null) {
			                    %>
			                    <td  style="text-align: center; vertical-align: middle;"> No Trainer</td>
			                    <%
			                    } else {
		                    	%>
			                    <td  style="text-align: center; vertical-align: middle;"> <%= classIndex.getNameTrainer()%></td>
			                    <%	
			                    }
			                    %>
			                    <td  style="vertical-align: middle;"><%= classIndex.getNameCourse()%></td>
			                    <td  style="vertical-align: middle;"><%= classIndex.getTimeOfDate()%></td>
			                    <%
			                    String openClass = "";
			                    String colorStatus = "color: #999999";
			                    if ( classIndex.getStudents() >= 5) {
			                    	openClass = "changeStatusClass( " + classIndex.getClassId() + ", 0);";
			                    	colorStatus = "";
			                    }
			                    String[] date = classIndex.getDateOfWeek().split(",");
			                    String dateStr = "";
			                    for (int j = 0; j < date.length; j++) {
			                    	for (int i = 0; i < day.length; i++) {
				                    	if (Integer.parseInt(date[j]) == (i+2) && j == date.length - 1) {
				                    		dateStr += day[i];
				                    	} else if (Integer.parseInt(date[j]) == (i+2) && j != date.length - 1) {
				                    		dateStr += day[i] + ", ";
				                    	}
			                    	}
			                    }
			                    %>
			                    <td  style='vertical-align: middle;'> <%= dateStr%></td>
			                    <td  style="text-align: center; vertical-align: middle;"><%= classIndex.getDuration()%></td>
			                    <td  style="text-align: center; vertical-align: middle;"><%= classIndex.getCountLession()%></td>
			                    <td  style="text-align: center; vertical-align: middle;"><%= classIndex.getStudents()%></td>
		                    </tr>
		                  <%	
		                  	}
		                  %>
		                </tbody>
               		 </table>
               		 
	                <div id="pager">
						<ul id="paginationOpen" class="pagination-sm"></ul>
					</div>
		       		</div>
		       		 
		       		 <div  id="finished" class="tab-pane fade">
		       		 <script type="text/javascript">
				            $(function () {
				                var pageSize = 10; // Hiển thị 10 sản phẩm trên 1 trang
				                showPage = function (page) {
				                    $(".contentPageFinish").hide();
				                    $(".contentPageFinish").each(function (n) {
				                        if (n >= pageSize * (page - 1) && n < pageSize * page)
				                            $(this).show();
				                    });
				                }
				                showPage(1);
				                ///** Cần truyền giá trị vào đây **///
				                var totalRows = <%= totalFinish%>; // Tổng số sản phẩm hiển thị
				                var btnPage = 5; // Số nút bấm hiển thị di chuyển trang
				                var iTotalPages = Math.ceil(totalRows / pageSize);
				
				                var obj = $('#paginationFinish').twbsPagination({
				                    totalPages: iTotalPages,
				                    visiblePages: btnPage,
				                    onPageClick: function (event, page) {
				                        console.info(page);
				                        showPage(page);
				                    }
				                });
				                console.info(obj.data());
				            });
				        </script>
				        <table style="border-collapse: collapse;" id="myTable" class="myTable table table-bordered table-hover table-compact" width="100%">
		                  <thead>
		                    <tr>
		                      <th style="text-align: center; font-size: medium;">No.</th>
		                      <th style="text-align: center; font-size: medium;">Name</th>
		                      <th style="text-align: center; font-size: medium;">Trainer</th>
		                      <th style="text-align: center; font-size: medium;">Course</th>
		                      <th style="text-align: center; font-size: medium;">Time Of Date</th>
		                      <th style="text-align: center; font-size: medium;">Day Of Week</th>
		                      <th style="text-align: center; font-size: medium;">Duration (hours)</th>
		                      <th style="text-align: center; font-size: medium;">Trainees</th>
		                      <th style="text-align: center; font-size: medium;">Trainees (Failed)</th>
		                      <th style="text-align: center; font-size: medium;">Action</th>
		                    </tr>
		                  </thead>
		                  <tbody id="myTBody" >
		                  <%
		                  	int index = 0;
		                  	for(Classes classIndex : classesFinish){
		                  		index++;
		                  %>	
		                  	<tr class="contentPageFinish" id='class<%= classIndex.getClassId()%>'>
		                      	<td  style="text-align: center; vertical-align: middle;"> <%= index%> </td>
		                     	<td  style="vertical-align: middle;"><b style="color: #000000"><%= classIndex.getName()%></b></td>
			                    <%
			                    if( classIndex.getNameTrainer() == null) {
			                    %>
			                    <td  style="text-align: center; vertical-align: middle;"> No Trainer</td>
			                    <%
			                    } else {
		                    	%>
			                    <td  style="text-align: center; vertical-align: middle;"> <%= classIndex.getNameTrainer()%></td>
			                    <%	
			                    }
			                    %>
			                    <td  style="vertical-align: middle;"><%= classIndex.getNameCourse()%></td>
			                    <td  style="vertical-align: middle;"><%= classIndex.getTimeOfDate()%></td>
			                    <%
			                    String openClass = "";
			                    String colorStatus = "color: #999999";
			                    if ( classIndex.getStudents() >= 5) {
			                    	openClass = "changeStatusClass( " + classIndex.getClassId() + ", 0);";
			                    	colorStatus = "";
			                    }
			                    String[] date = classIndex.getDateOfWeek().split(",");
			                    String dateStr = "";
			                    for (int j = 0; j < date.length; j++) {
			                    	for (int i = 0; i < day.length; i++) {
				                    	if (Integer.parseInt(date[j]) == (i+2) && j == date.length - 1) {
				                    		dateStr += day[i];
				                    	} else if (Integer.parseInt(date[j]) == (i+2) && j != date.length - 1) {
				                    		dateStr += day[i] + ", ";
				                    	}
			                    	}
			                    }
			                    %>
			                    <td  style='vertical-align: middle;'> <%= dateStr%></td>
			                    <td  style="text-align: center; vertical-align: middle;"><%= classIndex.getDuration()%></td>
			                    <td  style="text-align: center; vertical-align: middle;"><%= classIndex.getTotalStudents()%></td>
			                    <td  style="text-align: center; vertical-align: middle;"><%= classIndex.getStudents()%></td>
		                    	<td  style="text-align: center; vertical-align: middle;">
		                    		<a href="javascript:void(0)" onclick="<%= openClass%>" ><i class="fa fa-check" aria-hidden="true" style="font-size:20px; <%= colorStatus%>"></i></a>
		                     	</td>
		                    </tr>
		                  <%	
		                  	}
		                  %>
		                </tbody>
                	</table>
                	
                <div id="pager">
					<ul id="paginationFinish" class="pagination-sm"></ul>
				</div>
		       	</div>
	        	</div>
                
                <script type="text/javascript">
                
                $( "#page-top" ).load(function() {
              		$('#waitingStyle').css("background-color", "blue");
              	});
                
                function changeStatusClass(id, status){
            		$.ajax({
            			url: '<%=request.getContextPath()%>/classes/index',
            			type: 'POST',
            			cache: false,
            			data: {
            				classId: id,
            				status : status
            			},
            			success: function(data){
            				// Xử lý thành công
            				$('#class' + id).html(data);
            			},
            			error: function (){
            			// Xử lý nếu có lỗi
            				alert('fail');
            			}
            		});
            	}
                </script>
            </form>
          </div>
        </div>
      </div>
    </div>
<%@include file="/templates/inc/footer.jsp" %> 