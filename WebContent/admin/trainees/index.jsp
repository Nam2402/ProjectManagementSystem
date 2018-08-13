<%@page import="model.bean.User"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/templates/inc/dashboard.jsp" %>  
<link rel="stylesheet" href="<%=request.getContextPath()%>/templates/css/styleIndexTrainee.css">

<style>
	#trainerName{
		color: black;
		text-decoration: none;
	}
	
	#trainerName:hover{
		color: blue;
	}
</style>
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
  <div class="<%= classNameContainer%>" id="toggler_containerId">
    <div  class="card1 card mb-3" style="margin-top: 0px;border-radius: 5px;box-shadow: 2px 2px #c8c5c5;">
<!-- Nav -->
       	<div class="alert1 alert alert-primary" style="margin-bottom: 0px;padding-left: 10px;"> 
        	<i class="fa1 fa fa-fw fa-users" ></i>
			<strong class="lb_name">Trainee </strong>
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
			  msg = "You added the trainee successfully."; break;
		  }
		  case 2:{
			  check = true;
			  msg = "You edit the trainee successfully."; break;
		  }
		  case 3:{
			  check = true;
			  msg = "You deleted the trainee successfully."; break;
		  }
		  case 4:{
			  check = true;
			  msg  = "You deleted trainees successfully."; break;
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
		ArrayList<User> trainees = new ArrayList<User>();
		int total = 0;
		if (request.getAttribute("trainees") != null) {
		 trainees = (ArrayList<User>) request.getAttribute("trainees");
		 total = trainees.size();
				 
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
         <div class="table-responsive" style="background: white;padding: 10px 10px; margin-top: 0px;">
            <form action="<%= request.getContextPath()%>/trainee/del"  method="post">
            	<div style="margin-left: -15px; margin-bottom: 5px;margin-top: 10px;">
	            	<div style="float: left" >
	            	<a style="font-size:medium;" class="btn btn-primary btnAdd" href="<%=request.getContextPath() %>/trainee/add" role="button">
	            		Add trainee's account
            		</a>
	        		</div>
	            	<div style="float: left; margin-left: 15px;">
	            		<input class="btn btn-danger" style="display: none; margin-left: 10px; margin-bottom: 5px;" onclick="return confirm('Do you want to delete these trainees?')" id="deleteall" type="submit" value="Delete trainees">
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
	        	<table style="margin-top: 13px;border-collapse: collapse;" id="myTable" class="myTable table table-bordered table-hover table-compact" width="100%">
                  <thead>
                    <tr>
                      <th style="text-align: center; font-size: medium; vertical-align:middle;">Delete
                      	<input style="display: inline-block; " type="checkbox" class="checkall">
                   	  </th>
                      <th style="text-align: center; font-size: medium; vertical-align:middle;">Avatar</th>
                      <th style="text-align: center; font-size: medium; vertical-align:middle;">UserName</th>
                      <th style="text-align: center; font-size: medium; vertical-align:middle;">Email</th>
                      <th style="text-align: center; font-size: medium; vertical-align:middle;">Phone</th>
                      <th style="text-align: center; font-size: medium; vertical-align:middle;">Status</th>
                      <th style="text-align: center; font-size: medium; vertical-align:middle; word-break:normal;">Action</th>
                    </tr>
                  </thead>
                  <tbody id="myTBody">
                  <%
                  	for(User trainee : trainees){
                  %>	
                  	<tr class="contentPage">
                      	<td style="text-align: center; vertical-align: middle;"> <input type="checkbox" name="trainee<%= trainee.getUserId()%>" value="<%= trainee.getUserId()%>" class="checkitem" id="chkitem"> </td>
                      	<td id="trainerName" style="text-align: center; vertical-align: middle;"><img alt="<%= trainee.getUsername()%>" src="<%=  request.getContextPath()%>/files/<%= trainee.getAvatar()%>" class="img-circle" width="100px"></td>
                     	<td style="text-align: center; vertical-align: middle;"> <a style="color: #000000;" href="<%= request.getContextPath()%>/trainee/edit?id=<%= trainee.getUserId()%>"><b><%= trainee.getUsername()%></b></a> </td>
	                    <td style="text-align: center; vertical-align: middle;"><%= trainee.getEmail()%></td>
	                    <td style="text-align: center; vertical-align: middle;"><%= trainee.getPhone()%></td>
	                    <%
	                    if (trainee.getStatus() == 1){
	                    	%>	
		                    <td id="status<%= trainee.getUserId()%>"    style='text-align: center; vertical-align: middle;'><a href="javascript:void(0);" onclick="changeStatus(<%= trainee.getUserId()%>, 1);"><img alt="" src="<%= request.getContextPath()%>/templates/images/active.gif"></a></td>
		                    <%
	                    } else {
	                    	%>	
		                    <td  id="status<%= trainee.getUserId()%>"   style='text-align: center; vertical-align: middle;'><a href="javascript:void(0);" onclick="changeStatus(<%= trainee.getUserId()%>, 0);"><img alt="" src="<%= request.getContextPath()%>/templates/images/deactive.gif"></a></td>
		                    <%
	                    }
	                    %>
                    	<td   style="text-align: center; vertical-align: middle;">
                        <a href="<%= request.getContextPath()%>/trainee/edit?id=<%= trainee.getUserId()%>">
                        	<i class="fa fa-edit" style="font-size:20px"></i>
                       	</a>
                        <a  style="" href="<%= request.getContextPath()%>/trainee/del?id=<%= trainee.getUserId()%>" onclick="return confirm('Do you want to delete trainee : <%= trainee.getUsername()%>?')">
                        	<i class="fa fa-trash iconDel" style="font-size:20px;color:rgb(220, 53, 69)"></i>
                       	</a>
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
            			url: '<%=request.getContextPath()%>/trainee/index',
            			type: 'POST',
            			cache: false,
            			data: {
            				//Dữ liệu gửi đi
            				traineeId: id,
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
      </div>
    </div>
<%@include file="/templates/inc/footer.jsp" %> 
