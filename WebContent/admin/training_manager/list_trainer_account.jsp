<%@page import="java.util.List"%>
<%@page import="model.bean.User"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/templates/inc/dashboard.jsp" %> 
<%
String classNameContent = "" ;
String classNameContainer = "";
String styleContent = "style=''";
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
			<strong class="lb_name">Trainer</strong>
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
			  msg = "You added the trainer successfully."; break;
		  }
		  case 2:{
			  check = true;
			  msg = "You edit the trainer successfully."; break;
		  }
		  case 3:{
			  check = true;
			  msg = "You deleted the trainer successfully."; break;
		  }
		  case 4:{
			  check = true;
			  msg  = "You deleted trainers successfully."; break;
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
          <div class="table-responsive" style="background: white;padding: 10px;padding-bottom: 10px;">
            <form  class="formTable" action="<%=request.getContextPath() %>/trainer/del"  method="post">
                <div style="margin-bottom: 5px;margin-top: 10px;">
	            	<div class="divBtnAdd" style="float: left; margin-bottom: 10px;">
	            		<a style="height:auto !important;" class="btnAdd btn btn-primary" href="<%=request.getContextPath() %>/trainer/add" role="button">Add trainer's account</a>
	         		</div>
	            	<div style="float: left; margin-left: 15px;">
	            		<input class="btn btn-danger" style="" onclick="return confirm('Do you want to delete these trainers?')" id="deleteall" type="submit" value="Delete trainer">
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
	        	<table style="border-collapse: collapse;" id="dataTable" class="myTable table table-bordered table-hover table-compact" width="100%">
                  <thead>
                    <tr>
                      <th style="text-align: center; vertical-align: middle;">Delete
                      <input style="display: inline-block;" type="checkbox" class="checkall"></th>
                      <th style="text-align: center; vertical-align: middle;">Avatar</th>
                      <th style="text-align: center; vertical-align: middle;">User Name</th>
                      <th style="text-align: center; vertical-align: middle;">Email</th>
                      <th style="text-align: center; vertical-align: middle;">Phone</th>
                      <th style="text-align: center; vertical-align: middle;">Status</th>
                      <th style="text-align: center; font-size: medium; vertical-align:middle; word-break:normal;">Action</th>
                    </tr>
                  </thead>
                  <tbody id="myTBody" >
                  <%
                  	for(User trainer : trainers){
                  %>	
                  	<tr class="contentPage">
                      	<td style="text-align: center; vertical-align: middle;"> <input type="checkbox" name="trainee<%= trainer.getUserId()%>" value="" class="checkitem" id="chkitem"> </td>
                      	<td style="text-align: center; vertical-align: middle;"><img alt="<%= trainer.getUsername()%>" src="<%=  request.getContextPath()%>/files/<%= trainer.getAvatar()%>"  class="img-circle" width="100px;"></td>
                     	<td style="text-align: center; vertical-align: middle;"> <a href="<%= request.getContextPath()%>/trainer/edit?id=<%= trainer.getUserId()%>" style="color: black;" ><strong><%= trainer.getUsername()%></strong></a> </td>
	                    <td style="text-align: center; vertical-align: middle;"><%= trainer.getEmail()%></td>
	                    <td style="text-align: center; vertical-align: middle;"><%= trainer.getPhone()%></td>
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
	                    <td style="text-align: center; vertical-align: middle;">
                        	<a href="<%= request.getContextPath()%>/trainer/edit?id=<%= trainer.getUserId()%>">
                        		<i class="fa fa-edit" style="font-size: 20px;color:#007bff;margin-right:8px;"></i></a>
                        	<a  href="<%= request.getContextPath()%>/trainer/del?id=<%= trainer.getUserId()%>" onclick="return confirm('Do you want to delete trainer : <%= trainer.getUsername()%>?')">
                        		<i class="fa fa-trash iconDel" style="font-size: 20px;color:rgb(220, 53, 69);"></i></a>
                     	</td>
                    </tr>
                  <%	
                  	}
                  %>
                  </tbody>
                </table>
                <!-- Pagination -->
	        <script type="text/javascript">
	            $(function () {
	                var pageSize = 10; 
	                showPage = function (page) {
	                    $(".contentPage").hide();
	                    $(".contentPage").each(function (n) {
	                        if (n >= pageSize * (page - 1) && n < pageSize * page)
	                            $(this).show();
	                    });
	                }
	                showPage(1);
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
              
                function changeStatus(id, status){
            		$.ajax({
            			url: '<%=request.getContextPath()%>/trainer/index',
            			type: 'POST',
            			cache: false,
            			data: {
            				trainerId: id,
            				status : status
            			},
            			success: function(data){
            				$('#status' + id).html(data);
            			},
            			error: function (){
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
  </div>
  </div>
<%@include file="/templates/inc/footer.jsp" %> 