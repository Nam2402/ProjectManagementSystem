
<%@page import="model.bean.Courses"%>
<%@page import="model.bean.User"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/templates/inc/dashboard.jsp" %>  

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
<div class="<%= classNameContent%>" <%= styleContent%>  id="toggler_contentId">
  <div class="<%= classNameContainer%>" id="toggler_containerId">
    <div class="card mb-3">
        <div class="alert alert-primary" style="font-size: larger; margin-bottom: -5px;"> 
             <i class="fa fa-fw fa-book" ></i>
	    	<strong>Courses</strong>
	  	</div>
	  	</div>
	  <%
	  String msg = "";
	  if(request.getParameter("msg") != null){
		  boolean check = false;
		  int msgInt = Integer.parseInt((String)request.getParameter("msg"));
		  switch(msgInt) {
		  case 1: {
			  check = true;
			  msg = "You added the course successfully"; break;
		  }
		  case 2:{
			  check = true;
			  msg = "You edit the course successfully"; break;
		  }
		  case 3:{
			  check = true;
			  msg = "You deleted the course successfully"; break;
		  }
		  case 4:{
			  check = true;
			  msg  = "You deleted courses successfully"; break;
		  }
		  case 0:{
			  check = false;
			  msg  = "Error! System have some problems. Please try again"; break;
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
         
        <div class="card-body">
          <div class="table-responsive">
            <form action="<%= request.getContextPath()%>/course/del"  method="post">
	            <div style="margin-left: -15px; margin-bottom: 5px;">
	            	<div style="float: left">
	            	<a style="width:auto; font-size:15px; height:auto; margin-left: 14px; " class="btn btn-primary" href="<%=request.getContextPath() %>/course/add" role="button">Add new course</a>
	        		</div>
	            	<div style="float: left; margin-left: 15px;" >
	            	<input  class="btn btn-danger" style="display: none; margin-left: 10px; margin-bottom: 5px;" onclick="return confirm('Do you want to delete these courses?')" id="deleteall" type="submit" value="Delete courses">
                	</div>
                	<div style="float: right; width: 25%;">
                	<input style=" width: 100%;" id="myInput" type="text" placeholder="Search..">
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
                <table  id="myTable" class="table table-bordered" width="100%" id="dataTable" cellspacing="0">
                  <thead>
                    <tr>
                      <th style="text-align: center; font-size: medium;">Delete All<input style="display: inline-block; margin-left: 15px;" type="checkbox" class="checkall"></th>
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
                  	for(Courses course : courses){
                  %>	
                  	<tr class="contentPage">
                      	<td  style="text-align: center; vertical-align: middle;"> <input type="checkbox" name="course<%= course.getCourseId()%>" value="<%= course.getCourseId()%>" class="checkitem" id="chkitem"> </td>
                     	<td  style="vertical-align: middle;"> <a style="color: #000000;" href="<%= request.getContextPath()%>/course/edit?id=<%= course.getCourseId()%>"><b><%= course.getName() %></b></a> </td>
	                    <td  style="vertical-align: middle;"><%= course.getMajorName() %></td>
	                    <td  style="text-align: center; vertical-align: middle;"><%= course.getDuration()%></td>
	                    <%
	                    String kind = "";
	                    if (course.getKind_of_course() == 1) {
	                    	kind = "Yes";
	                    } else {
	                    	kind = "No";
	                    }
	                    %>
	                    <td  style="text-align: center; vertical-align: middle;"><%= kind %></td>
	                    <%
	                    if (course.getStatus() == 1){
	                    	%>	
		                    <td id="status<%= course.getCourseId()%>"  style='text-align: center;  vertical-align: middle;'><a href="javascript:void(0)" onclick="changeStatus(<%= course.getCourseId()%>, 1);"><i class="fa fa-check" aria-hidden="true" style="font-size:20px;"></i></a></td>
		                    <%
	                    } else {
	                    	%>	
		                    <td  id="status<%= course.getCourseId()%>" style='text-align: center;  vertical-align: middle;'><a href="javascript:void(0)" onclick="changeStatus(<%= course.getCourseId()%>, 0);"><i class="fa fa-check" aria-hidden="true" style="font-size:20px; color: #999999;"></i></a></td>
		                    <%
	                    }
	                    %>
                    	<td  style="text-align: center; vertical-align: middle;">
                        <a  href="<%= request.getContextPath()%>/course/edit?id=<%= course.getCourseId()%>"><i class="fa fa-edit" style="font-size:20px"></i></a>
                        <a style="margin-left: 10px" href="<%= request.getContextPath()%>/course/del?id=<%= course.getCourseId()%>" onclick="return confirm('Do you want to delete course: <%= course.getName()%>?')"><i class="fa fa-trash" style="font-size:20px;color:rgb(220, 53, 69)"></i></a>
                     	</td>
                    </tr>
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
                </script>
                
                <div id="pager">
					<ul id="pagination" class="pagination-sm"></ul>
				</div>
            </form>
          </div>
        </div>
        <div class="card-footer small text-muted">
          Updated yesterday at 11:59 PM
        </div>
      </div>
    </div>
  </div>
<%@include file="/templates/inc/footer.jsp" %> 
