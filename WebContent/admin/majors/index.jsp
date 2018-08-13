<%@page import="model.bean.Majors"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/templates/inc/dashboard.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/templates/css/styleMajor.css">
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

<div class="<%= classNameContent%>" <%= styleContent%> id="toggler_contentId" style="">
  <div class="<%= classNameContainer%>" id="toggler_containerId">
    <div  class="card1 card mb-3" style="margin-top:0px;box-shadow: 2px 2px #c8c5c5;">
<!-- Nav -->
       	<div class="alert1 alert alert-primary" style="padding-left: 10px;"> 
        	<i class="fa1 fa fa-fw fa-briefcase" ></i>
			<strong class="lb_name">Major </strong>
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
							  msg = "You added the major successfully."; break;
						  }
						  case 2:{
							  check = true;
							  msg = "You edited the major successfully."; break;
						  }
						  case 3:{
							  check = true;
							  msg = "You deleted the major successfully."; break;
						  }
						  case 4:{
							  check = true;
							  msg  = "You deleted majors successfully."; break;
						  }
						  case 5:{
							  check = false;
							  msg  = "This major has existed in the system."; break;
						  }
						  case 6:{
							  check = false;
							  msg  = "Nothing is changed."; break;
						  }
						  case 0:{
							  check = false;
							  msg  = "Error! System have some problems. Please try again."; break;
						  }
				  	  }
					  
					  if( check == false){
						  %>
				        	<div class="alert alert-danger" style=" padding-left: 10px;">
						    	<strong> <%= msg%> </strong>
						  	</div>
						  <%
					  } else {
						  %>
				        	<div class="alert alert-success" style="padding-left: 10px;">
						    	<strong> <%= msg%> </strong>
						  	</div>
						  <%
					  }
				  }
			%>
			
	  
			<%
				ArrayList<Majors> majors = new ArrayList<Majors>();
				int total = 0;
				if (request.getAttribute("major") != null) {
					majors = (ArrayList<Majors>) request.getAttribute("major");
					total = majors.size();		 
				}
			%>
<!-- Checkbox -->		
	        <script type="text/javascript">
	            $(document).ready(function(){
	                $(document).on('change', '.checkall, .checkitem', function(){
	                    var $_this = $(this);
	                    document.getElementById("deleteall").style.display = "block";
	                    if($_this.hasClass('checkall')){
	                        $('.checkitem').prop('checked', $_this.prop('checked'));
	                    } else {
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
<!-- Pagination -->
	        <script type="text/javascript">
	            $(function () {
	                var pageSize = 5; 
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
	        </script>
	        
	        
	       
<!-- Content -->
		   <div class="card-body" style="margin-top: 0px;">
		         <div class="table-responsive" style="padding-bottom: 1px;background: white;padding-top:18px;padding-left: 10px; padding-right: 10px;">
           			<form class="formTable" action="<%= request.getContextPath()%>/major/del"  method="post" style="margin-top: 2px;">
          				<div style="">
            				<div class=""  style="float: left; margin-bottom: 15px;" >
			            		<button style="height: auto !important;" type="button" class=" btnAdd btn btn-primary" data-toggle="modal" data-target="#addModal" role="button">Add Major
	            				</button>
			        		</div>
			            	<div style="float: left; margin-left: 15px;">
			            		<input class="btn btn-danger" style="" 
			            			   onclick="return confirm('Do you want to delete these majors?')" id="deleteall" type="submit" value="Delete major">
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
		              		<div style="clear: both">
		              		</div>
	       				</div>
		                <table  id="myTable" class="myTable table table-bordered" width="100%" id="dataTable" cellspacing="0" style="background:white;box-shadow: 2px 2px rgb(189, 189, 189);">
							<thead>
		                    	<tr>
									<th style="text-align: center; font-size: medium;max-width: 100px;">Delete
			                      		<input 	style="display: inline-block; margin-left: 15px;vertical-align: middle; margin-top: -3px;" 
			                      				type="checkbox" class="checkall">
			                      	</th>
									<th style="text-align: center; font-size: medium;">Name</th>
									<th style="text-align: center; font-size: medium;">Action</th>
			                    </tr>
		                  	</thead>
                  			<tbody id="myTBody">
				                  <%
				                  	for (Majors list: majors){
				                  %>
							   <tr class="contentPage" style="vertical-align: middle;">
								   <td   style="text-align: center; vertical-align: middle;"> 
								   		<input 	style="vertical-align: middle;" type="checkbox" name="major<%= list.getMajorId()%>" 
								   				value="<%= list.getMajorId()%>" class="checkitem" id="chkitem"> 
							   	   </td>
				                   <td style="text-align: center; vertical-align: middle;width=20%"><strong><%=list.getName()%></strong></td>
								   <td style="text-align: center; vertical-align: middle;">
								   
										<a name="editMajor"  data-toggle="modal"
				                    			data-target="#editModal<%=list.getMajorId()%>" style="">
                                            <i class="fa fa-edit" style="font-size: 20px;color:#007bff;  margin-right: 8px;"></i>
                                        </a>
								   		<a 	class="" href="<%= request.getContextPath()%>/major/del?id=<%= list.getMajorId()%>" 
				                    		onclick="return confirm('Do you want to delete major : <%= list.getName()%>?')" name="deleteMajor"  style="">
					                    	<i class="fa fa-trash iconDel" style="font-size: 20px;color:rgb(220, 53, 69)"></i>
					                    	
				                    	</a>
								   
				                   </td>
				                            
			                   </tr>
<!-- Edit list -->
			                  <div class="modal fade" id="editModal<%=list.getMajorId()%>" role="dialog">
									<div class="modal-dialog">
										<!-- Modal content-->
										<div class="modal-content">
											<div class="modal-header alert alert-primary">
												<h5 class="modal-title " align="center">
													<i class="fa fa-fw fa-edit"></i>
													<strong>Edit Major</strong>
												</h5>
												<button type="button" class="close" style="color: red; float: right;" data-dismiss="modal">&times;</button>
											</div>
											<div class="modal-body">
												<form id="add-post2" action="/managementSystem/major/edit?id=<%=list.getMajorId()%>" method="POST">
													<div class="form-group">
														<label class="required"><strong>Major Name:</strong>
															<span style="color: red"> *</span>&nbsp;<span id="spnNameStatus"></span>
														</label>
														<input 	class="form-control" id="majorname" type="text" name="name" value="<%=list.getName()%>"
																placeholder="Major Name" required />
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
											<form id="add-post1" action="/managementSystem/major/add" method="POST">
												<div class="modal-header alert alert-primary">
													<h5 class="modal-title" align="center">
														<i style="size: 20px;" class="fa fa-fw fa-plus-square"></i>
														<strong>Add Major</strong>
													</h5>
													<button type="button" class="close" style="color: red; float: right;" data-dismiss="modal">&times;</button>
												</div>
												<div class="modal-body">
													<div class="form-group">
														<label class="required">
															<strong>Major Name:</strong>
															<span style="color: red"> *</span>&nbsp;
															<span id="spnNameStatus1"></span>
														</label>
														<input 	class="form-control" id="majorname1" type="text"
																name="name" placeholder="Major Name" required />
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
	                <div id="pager" style="">
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
