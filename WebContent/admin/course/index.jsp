
<%@page import="model.bean.Majors"%>
<%@page import="model.bean.Courses"%>
<%@page import="model.bean.User"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/templates/inc/dashboard.jsp" %>  
<link rel="stylesheet" href="<%=request.getContextPath()%>/templates/css/styleIndexTrainee.css"> 
 
 <style>
	#add-post .required:after {
	  content:"*";color:red;
	}
</style>

<%
Courses course = new Courses(0, 0, "", 1, 0, "", 0);
ArrayList<Majors> majors = new ArrayList<>();

if( request.getAttribute("course") != null){
	course = (Courses) request.getAttribute("course");
}

if (request.getAttribute("majors") != null) {
	majors = (ArrayList<Majors>)request.getAttribute("majors");
}
%>
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
<div class="<%= classNameContent%>" <%= styleContent%> id="toggler_contentId" style="">
  <div class="<%= classNameContainer%>" id="toggler_containerId">
    <div  class="card1 card mb-3" style="margin-top: 0px;">
<!-- Nav -->
       	<div class="alert1 alert alert-primary"  style="margin-bottom: 0px;padding-left: 10px;"> 
        	<i class="fa1 fa fa-fw fa-book" ></i>
			<strong class="lb_name">Course </strong>
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
			  msg = "You added the course successfully."; break;
		  }
		  case 2:{
			  check = true;
			  msg = "You edit the course successfully."; break;
		  }
		  case 3:{
			  check = true;
			  msg = "You deleted the course successfully."; break;
		  }
		  case 4:{
			  check = true;
			  msg  = "You deleted courses successfully."; break;
		  }
		  case 6:{
			  check = false;
			  msg  = "Error! This course has already existed in the system."; break;
		  }
		  case 7:{
			  check = false;
			  msg  = "Error! Please complate all information."; break;
		  }
		  case 0:{
			  check = false;
			  msg  = "Error! System have some problems. Please try again."; break;
		  }
		  case 5:{
			  check = false;
			  String name = request.getParameter("name");
			  msg  = "These courses: " + name + " have some classese. So you can't delete it. "; break;
			  
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
		ArrayList<Courses> courses = new ArrayList<Courses>();
		int total = 0;
		if (request.getAttribute("courses") != null) {
			courses = (ArrayList<Courses>) request.getAttribute("courses");
		 total = courses.size();
				 
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
        
        <script type="text/javascript">
            $(function () {
                var pageSize = 10; // Hiển thị 10 sản phẩm trên 1 trang
                showPage = function (page) {
                    $(".contentPage").hide();
                    $(".contentPage").each(function (n) {
                        if (n >= pageSize * (page - 1) && n < pageSize * page)
                            $(this).show();
                    });
                }
                showPage(1);
                ///** Cần truyền giá trị vào đây **///
                var totalRows = <%= total%>; // Tổng số sản phẩm hiển thị
                var btnPage = 5; // Số nút bấm hiển thị di chuyển trang
                var iTotalPages = Math.ceil(totalRows / pageSize);

                var obj = $('#pagination').twbsPagination({
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
         
   		<div class="card-body" style="margin-top: 0px;">
         <div class="table-responsive" style="background: white;padding: 20px 10px; margin-top: 0px;">
            <form action="<%= request.getContextPath()%>/course/del"  method="post">
	            <div style="margin-left: -15px; margin-bottom: 5px;">
	            	<div style="float: left">
	            	<a style="width:auto; font-size:15px; height:auto; margin-left: 14px; " class="btn btn-primary" href="#" data-toggle="modal" data-target="#addModal" role="button">Add Course</a>
	        		</div>
	            	<div style="float: left; margin-left: 15px;" >
	            	<input  class="btn btn-danger" style="display: none; margin-left: 10px; margin-bottom: 5px;" onclick="return confirm('Do you want to delete these courses?')" id="deleteall" type="submit" value="Delete courses">
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
                	<div style="clear: both"></div>
	        	</div>
                <table id="myTable" class="myTable table table-bordered table-hover table-compact" style=" width:100% ;margin-top: 16px;">
                  <thead>
                    <tr>
                      <th style="text-align: center; font-size: medium;">Delete<input style="display: inline-block; margin-left: 15px;" type="checkbox" class="checkall"></th>
                      <th style="text-align: center; font-size: medium;">Name</th>
                      <th style="text-align: center; font-size: medium;">Major</th>
                      <th style="text-align: center; font-size: medium;">Duration (hours)</th>
                      <th style="text-align: center; font-size: medium;">Default</th>
                      <th style="text-align: center; font-size: medium;">Status</th>
                      <th style="text-align: center; font-size: medium;">Action</th>
                    </tr>
                  </thead>
                  <tbody  id="myTBody">
                  <%
                  	for(Courses courseIndex : courses){
                  %>	
                  	<tr class="contentPage">
                      	<td  style="text-align: center; vertical-align: middle;"> <input type="checkbox" name="course<%= courseIndex.getCourseId()%>" value="<%= courseIndex.getCourseId()%>" class="checkitem" id="chkitem"> </td>
                     	<td  style="vertical-align: middle;"> <a style="color: #000000;" data-toggle="modal" data-target="#editModal<%=courseIndex.getCourseId()%>" ><b><%= courseIndex.getName() %></b></a> </td>
	                    <td  style="vertical-align: middle;"><%= courseIndex.getMajorName() %></td>
	                    <td  style="text-align: center; vertical-align: middle;"><%= courseIndex.getDuration()%></td>
	                    <%
	                    String kind = "";
	                    if (courseIndex.getKind_of_course() == 1) {
	                    	kind = "Yes";
	                    } else {
	                    	kind = "No";
	                    }
	                    %>
	                    <td  style="text-align: center; vertical-align: middle;"><%= kind %></td>
	                    <%
	                    if (courseIndex.getStatus() == 1){
	                    	%>	
		                    <td id="status<%= courseIndex.getCourseId()%>"  style='text-align: center;  vertical-align: middle;'><a href="javascript:void(0)" onclick="changeStatus(<%= courseIndex.getCourseId()%>, 1);"><img alt="" src="<%= request.getContextPath()%>/templates/images/active.gif"></a></td>
		                    <%
	                    } else {
	                    	%>	
		                    <td  id="status<%= courseIndex.getCourseId()%>" style='text-align: center;  vertical-align: middle;'><a href="javascript:void(0)" onclick="changeStatus(<%= courseIndex.getCourseId()%>, 0);"><img alt="" src="<%= request.getContextPath()%>/templates/images/deactive.gif"></a></td>
		                    <%
	                    }
	                    %>
                    	<td  style="text-align: center; vertical-align: middle;">
                       		<a href="#" data-toggle="modal" data-target="#editModal<%=courseIndex.getCourseId()%>" ><i class="fa fa-edit" style="font-size:20px"></i></a>
                        	<a style="margin-left: 10px" href="<%= request.getContextPath()%>/course/del?id=<%= courseIndex.getCourseId()%>" onclick="return confirm('Do you want to delete course: <%= courseIndex.getName()%>?')"><i class="fa fa-trash" style="font-size:20px;color:rgb(220, 53, 69)"></i></a>
                     	</td>
                    </tr>
                    
<!-- Edit list -->
                  <div class="modal fade" id="editModal<%=courseIndex.getCourseId()%>" role="dialog">
						<div class="modal-dialog">
							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header alert alert-primary">
         							 <h5 class="modal-title " align="center">
										<i class="fa fa-fw fa-book"></i>
										<strong><%= courseIndex.getName()%></strong>
									</h5>
									<button type="button" class="close" style="color: red;" data-dismiss="modal">&times;</button>
								</div>
								<div class="modal-body">
									<form id="add-post2" action="<%=request.getContextPath() %>/course/edit?id=<%=courseIndex.getCourseId()%>" method="POST">
										<div class="form-group">
							              	<label class="required" ><strong>Major:</strong> &nbsp;</label>
							              	<br>
							              	<select name="major" style="width: 100%">
							              	<%
							              		for (Majors major : majors) {
							              		%> 
							              		<option value="<%= major.getMajorId()%>">&nbsp;<%= major.getName()%></option>
							              		<%
							              		}
							              	%>
							              	</select>
						              	</div>
						              	
						              	<div class="form-group">
							              	<label class="required" ><strong>Name:</strong></label>&nbsp;
							              	<input class="form-control" id="txtName"  type="text" name="name" value="<%= courseIndex.getName()%>" placeholder="Coursesname" required/>
						              		<span id="spnNameStatus"></span>
						              		<input type="text" name="id" value="<%= courseIndex.getCourseId()%>" placeholder="Coursesname" style="display: none"/>
						              	</div>
						              	
						              	<div class="form-group">
							              	<label class="required" ><strong>Duration (hours):</strong></label>&nbsp;
							              	<input class="form-control" type="number" min="1" max="1000" id="txtDuration" name="duration" value="<%= courseIndex.getDuration()%>" placeholder="duration" required/>
						              		<span id="spnDurationStatus"></span>
						              	</div>
						              	
						              	<div class="form-group">
							              	  <label class="required"><strong>Is this course the default?</strong> &nbsp;</label> <br>
											  <input type="radio" name="kindOfCourse" value="1" > Yes <br>
											  <input type="radio" name="kindOfCourse" value="0" checked>  No <br>
						              	</div>
						              	
										<div style="text-align:center;">
											<button type="submit" class="btn btn-primary" style="width:80px; height:40px; font-size:15px;" id="btnSubmit">Save 
											</button>
											<button style="width:80px; height:40px;" type="button" class="btn btn-default" data-dismiss="modal">Close
											</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
			 
<!-- Add Modal -->
					<div class="modal fade" id="addModal" role="dialog">
						<div class="modal-dialog">
							<!-- Modal content-->
							<div class="modal-content">
								<form id="add-post1" action="<%= request.getContextPath()%>/course/add" method="POST">
									<div class="modal-header alert alert-primary">
          								<h5 class="modal-title" align="center">
											<i style="size: 20px;" class="fa fa-fw fa-book"></i>
											<strong>Add Course</strong>
										</h5>
										<button type="button" class="close" style="color: red;" data-dismiss="modal">&times;</button>
									</div>
									<div class="modal-body">
										<div class="form-group">
							              	<label class="required" ><strong>Major:</strong>&nbsp;</label>
							              	<br>
							              	<select name="major" style="width: 100%;">
							              	<%
							              		for (Majors major : majors) {
							              		%> 
							              		<option value="<%= major.getMajorId()%>"><%= major.getName()%></option>
							              		<%
							              		}
							              	%>
							              	</select>
						              	</div>
						              	
						              	<div class="form-group">
							              	<label class="required" ><strong>Name:</strong></label>&nbsp;
							              	<input class="form-control" id="txtName" type="text" name="name" value="<%= course.getName()%>" placeholder="Course name" />
						              		<span id="spnNameStatus"></span>
						              	</div>
						              	
						              	<div class="form-group">
							              	<label class="required" ><strong>Duration (hours):</strong></label>&nbsp;
							              	<input class="form-control" type="number" min="1" max="1000" id="txtDuration" name="duration" value="<%= course.getDuration()%>" placeholder="duration" />
						              		<span id="spnDurationStatus"></span>
						              	</div>
						              	
						              	<div class="form-group">
							              	  <label class="required"><strong>Is this course the default?</strong> &nbsp;</label> <br>
											  <input type="radio" name="kindOfCourse" value="1" > Yes <br>
											  <input type="radio" name="kindOfCourse" value="0" checked>  No <br>
						              	</div>
										<div style="text-align: center;" >
											<button type="submit" class="btn btn-primary" id="btnSubmit"
											 		style="width:80px;height:40px; font-size:15px;" >Add 
									 		</button>
											<button style="width:80px;height:40px;" type="button" class="btn btn-default" data-dismiss="modal">Close
											</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
                  <%	
                  	}
                  %>
                  </tbody>
                </table>
                
                <script type="text/javascript">
                function changeStatus(id, status){
            		$.ajax({
            			url: '<%=request.getContextPath()%>/course/index',
            			type: 'POST',
            			cache: false,
            			data: {
            				//Dữ liệu gửi đi
            				courseId: id,
            				status : status
            			},
            			success: function(data){
            				// Xử lý thành công
            				$('#status' + id).html(data);
            			},
            			error: function (){
            			// Xử lý nếu có lỗi
            				alert('fail');
            			}
            		});
            	}
                
                $(document).ready(function() {
  					$('#txtName').blur(function(e) {
  						var name = $('#txtName').val();
      					if (validateName(name)) {
  							$('#spnNameStatus').html('');
  							$('#spnNameStatus').css('color', 'green');
  						}
  						else {
  							$('#spnNameStatus').html('Name of course must be character.');
  							$('#spnNameStatus').css('color', 'red');
  							document.getElementById("btnSubmit").disabled = true; 
  						}
   					});
  				});
  				
  				function checkDuration() {
  					var intRegex = /^\d+$/;

  					var str = $('#txtDuration').val();
  					if(intRegex.test(str)) {
  					   return true;
  					} else{
  						return false;
  					}
  				}   
  				
  				function validateName(string) {
  					var pattern = /^[^`~<>@#%&\*\$\{\}\[\]\(\)\+\=?\|\;_!]+$/;

  					return $.trim(string).match(pattern) ? true : false;
  				}
                </script>
                
                <div id="pager">
					<ul id="pagination" class="pagination-sm"></ul>
				</div>
            </form>
          </div>
        </div>
      </div>
    </div>
<%@include file="/templates/inc/footer.jsp" %> 
