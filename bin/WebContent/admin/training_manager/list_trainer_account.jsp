
<%@page import="java.util.List"%>
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
<div class="<%= classNameContent%>" <%= styleContent%>>
  <div class="<%= classNameContainer%>">
    <div class="card mb-3">
        <div class="alert alert-primary" style="font-size: larger;margin-bottom: 5px;"> 
             <i class="fa fa-fw fa-users" ></i>
		    <strong>Trainers</strong>
		  </div>
		<div> 
	  <%
	  String msg = "";
	  if(request.getParameter("msg") != null){
		  boolean check = false;
		  int msgInt = Integer.parseInt((String)request.getParameter("msg"));
		  switch(msgInt) {
		  case 1: {
			  check = true;
			  msg = "You added the trainer successfully"; break;
		  }
		  case 2:{
			  check = true;
			  msg = "You edit the trainer successfully"; break;
		  }
		  case 3:{
			  check = true;
			  msg = "You deleted the trainer successfully"; break;
		  }
		  case 4:{
			  check = true;
			  msg  = "You deleted trainers successfully"; break;
		  }
		  case 0:{
			  check = false;
			  msg  = "Error! System have some problems. Please try again"; break;
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
		List<User> trainers = new ArrayList<User>();
		int total = 0;
		if (request.getAttribute("trainers") != null) {
		 trainers = (List<User>) request.getAttribute("trainers");
		 total = trainers.size();		 
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
        <div class="card-body">
          <div class="table-responsive">
            <form action="<%=request.getContextPath() %>/trainer/del"  method="post">
                <div style="margin-left: -15px; margin-bottom: 5px;">
	            	<div style="float: left" >
	            	<a style="width:auto; font-size:15px; height:auto; margin-bottom:10px; margin-left: 14px; " class="btn btn-primary" href="<%=request.getContextPath() %>/trainer/add" role="button">Add new trainer's account</a>
	        		</div>
	            	<div style="float: left; margin-left: 15px;">
	            	<input class="btn btn-danger" style="display: none; margin-left: 10px; margin-bottom: 5px;" onclick="return confirm('Do you want to delete these trainers?')" id="deleteall" type="submit" value="Delete trainers">
                	</div>
                	<div style="clear: both"></div>
	        	</div>
	        	<table  id="dataTable" class="table table-bordered table-hover table-compact" width="100%">
                  <thead>
                    <tr>
                      <th style="text-align: center; vertical-align: middle;">DeleteAll<input style="display: inline-block; margin-left: 15px;" type="checkbox" class="checkall"></th>
                      <th style="text-align: center; vertical-align: middle;">Avatar</th>
                      <th style="text-align: center; vertical-align: middle;">UserName</th>
                      <th style="text-align: center; vertical-align: middle;">FullName</th>
                      <th style="text-align: center; vertical-align: middle;">Email</th>
                      <th style="text-align: center; vertical-align: middle;">Phone</th>
                      <th style="text-align: center; vertical-align: middle;">Address</th>
                      <th style="text-align: center; vertical-align: middle;">Status</th>
                      <th style="text-align: center; vertical-align: middle;">Action</th>
                    </tr>
                  </thead>
                  <tbody >
                  <%
                  	for(User trainer : trainers){
                  %>	

                  	<tr class="contentPage">
                      	<td style="text-align: center; vertical-align: middle;"> <input type="checkbox" name="trainee<%= trainer.getUserId()%>" value="" class="checkitem" id="chkitem"> </td>
                      	<td style="text-align: center; vertical-align: middle;max-width:200px;max-height:100px;"><img alt="<%= trainer.getUsername()%>" src="<%=  request.getContextPath()%>/files/<%= trainer.getAvatar()%>"  class="img-circle" width="60%" height="100%"></td>
                     	<td style="text-align: center; vertical-align: middle;"> <a href="<%= request.getContextPath()%>/trainer/edit?id=<%= trainer.getUserId()%>"><%= trainer.getUsername()%></a> </td>
	                    <td style="text-align: center; vertical-align: middle;"><%= trainer.getFullname() %></td>
	                    <td style="text-align: center; vertical-align: middle;"><%= trainer.getEmail()%></td>
	                    <td style="text-align: center; vertical-align: middle;"><%= trainer.getPhone()%></td>
	                    <td style="text-align: center; vertical-align: middle;"><%= trainer.getAddress() %></td>
	                    <%
	                    if (trainer.getStatus() == 1){
	                    	%>	
		                    <td id="status<%= trainer.getUserId()%>"    style='text-align: center; vertical-align: middle;'><a href="javascript:void(0)" onclick="changeStatus(<%= trainer.getUserId()%>, 1);"><img alt="" src="<%= request.getContextPath()%>/templates/images/active.gif"></a></td>
		                    <%
	                    } else {
	                    	%>	
		                    <td  id="status<%= trainer.getUserId()%>"   style='text-align: center; vertical-align: middle;'><a href="javascript:void(0)" onclick="changeStatus(<%= trainer.getUserId()%>, 0);"><img alt="" src="<%= request.getContextPath()%>/templates/images/deactive.gif"></a></td>
		                    <%
	                    }
	                    %>
	                    <td   style="text-align: center; vertical-align: middle;">
                        <a href="<%= request.getContextPath()%>/trainer/edit?id=<%= trainer.getUserId()%>"><i class="fa fa-edit" style="font-size:20px"></i></a>
                        <a  class="iconDel" href="<%= request.getContextPath()%>/trainer/del?id=<%= trainer.getUserId()%>" onclick="return confirm('Do you want to delete trainer : <%= trainer.getUsername()%>?')"><i class="fa fa-trash" style="font-size:20px;color:rgb(220, 53, 69)"></i></a>
                     	</td>
                    </tr>
                  <%	
                  	}
                  %>
                  </tbody>
                </table>
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
				                var totalRows = 10;// Tổng số sản phẩm hiển thị
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
                    
              
                function changeStatus(id, status){
            		$.ajax({
            			url: '<%=request.getContextPath()%>/trainer/index',
            			type: 'POST',
            			cache: false,
            			data: {
            				//Dữ liệu gửi đi
            				trainerId: id,
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
  </div>
<%@include file="/templates/inc/footer.jsp" %> 
