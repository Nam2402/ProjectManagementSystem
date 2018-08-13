<%@page import="model.bean.Rooms"%>
<%@page import="model.bean.Schedule"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style>
            #pagination {
                display: flex;
                display: -webkit-flex; /* Safari 8 */
                flex-wrap: wrap;
                -webkit-flex-wrap: wrap; /* Safari 8 */
                justify-content: center;
                -webkit-justify-content: center;
            }
        </style>
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
        <div class="alert alert-primary" style="font-size: larger;margin-bottom: 0px;"> 
             <i class="fa fa-fw fa-home" ></i>
             	<strong>Room List</strong>
			  </div>	
         
         <%			int check=0;
                  	ArrayList<Rooms> roomlist = (ArrayList<Rooms>) request.getAttribute("roomList");
         		
         			int k=0;
         			int tong = roomlist.size();
        	
        	String msg = "";
	  if(request.getParameter("msg") != null){
		  boolean check1 = false;
		  int msgInt = Integer.parseInt((String)request.getParameter("msg"));
		  switch(msgInt) {
		  case 1: {
			  check1 = false;
			  msg = "This room name has already existed in the system!"; break;
		  }
		  case 2:{
			  check1 = true;
			  msg = "You added the room successfully!"; break;
		  }
		  case 3:{
			  check1 = true;
			  msg = "You edited the room successfully!"; break;
		  }
		  case 4:{
			  check1 = true;
			  msg  = "You deleted room successfully!"; break;
		  }
		  case 0:{
			  check1 = false;
			  msg  = "Error! System have some problems. Please try again!"; break;
		  }
		  }
		   if( check1 == false){
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
<!-- Show room -->			  	
        <div class="card-body" >
          <div class="table-responsive">
                <div style="margin-left: -15px; margin-bottom: 5px;">
	            	<div style="float: left" >
	            	<button style="width:auto; font-size:15px; height:auto; margin-bottom:10px; margin-left: 10px;"
	            	type="button" class="btn btn-primary" data-toggle="modal" data-target="#addModal" role="button">Add new room</button>
	        		</div>
	            <form action="<%=request.getContextPath()%>/DeleteRoomController" method="POST">
	            	<div style="float: left; margin-left: 15px;">
	            	<input class="btn btn-danger" style="display: none; margin-left: 10px; margin-bottom: 5px;" onclick="return confirm('Do you want to delete these rooms?')" id="deleteall" type="submit" value="Delete rooms">
                	</div>
                	<div style="clear: both"></div>
	        	<table id="myTable" class="table-bordered" style="width: 100%;">
                  <thead>
                    <tr style="height:50px;">
                      <th style="text-align: center;">Delete All<input style="display: inline-block; margin-left: 15px;" type="checkbox" class="checkall"></th>
                      <th style="text-align: center;">Name</th>
                      <th style="text-align: center;">Capacity</th>
                      <th style="text-align: center;">Status</th>
                      <th style="text-align: center;">Action</th>
                   
                    </tr>
                  </thead>
                  <tbody>
                  
                  	<%
                  	for (Rooms rooms: roomlist){
                  		k++;
                  		%>
				   <tr class="contentPage" style="">
				   <%
				   if  (rooms.getStatus()==0){
				   %>
				   <td style="text-align: center; vertical-align: middle;"> <input type="checkbox" name="room<%=rooms.getRoomId() %>" value="<%=rooms.getRoomId()%>" disabled> </td>
				   <%
				   }
				   else {
				   %>
				   <td style="text-align: center; vertical-align: middle;"> <input type="checkbox" name="room<%=rooms.getRoomId() %>" value="<%=rooms.getRoomId()%>" class="checkitem" id="chkitem"> </td>
				   <%} %>
                   <td style="text-align: center; vertical-align: middle;"><%= rooms.getName() %></td>
                   <td style="text-align: center; vertical-align: middle;" ><%= rooms.getCapacity()%></td>
                  <%if(rooms.getStatus()==0){
                	  %>
		                    <td  id="" style='text-align: center;"'><a><img alt="" src="<%= request.getContextPath()%>/templates/images/deactive.gif"></a></td>
                	  <%
                  } else {
                	  %>
		                    <td id=""  style='text-align: center;'><a  ><img alt="" src="<%= request.getContextPath()%>/templates/images/active.gif"></a></td>
                	  <%
                  }
                   %>  
                  <td style="text-align: center; vertical-align: middle;">
                   <button type="button" class="btn btn-link" name="editRoom" style="" data-toggle="modal"
                    data-target="#editModal<%=rooms.getRoomId()%>"><i class="fa fa-edit" style="font-size:16px; margin-top: 1px !important; "></i></button>
                   </td>
                  </tr>
<!-- Edit room -->
                  <div class="modal fade" id="editModal<%=rooms.getRoomId()%>" role="dialog">
						<div class="modal-dialog">
							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header alert alert-primary">
								<h4 class="modal-title " align="center"><i class="fa fa-fw fa-home"></i><strong>Edit room</strong></h4>
								</div>
								<div class="modal-body">
									<form id="add-post2" action="/managementSystem/EditRoomController?id=<%=rooms.getRoomId()%>" method="POST">
										<div class="form-group">
											<label class="required"><strong>Room Name:</strong><span
												style="color: red"> *</span>&nbsp;</label>
											<input class="form-control" id="roomname<%=rooms.getRoomId()%>" type="text"
												name="name" value="<%=rooms.getName()%>"
												placeholder="Room Name" required /> <span id="spnNameStatus<%=rooms.getRoomId()%>"></span>
										</div>
										<div class="form-group">
											<label class="required"><strong>Capacity:</strong><span
												style="color: red"> *</span></label> <input class="form-control"
												type="number" name="capacity"
												value="<%=rooms.getCapacity()%>" placeholder="Capacity"
												min="1" required />
										</div>
										<div class="form-group">
											<label class="required"><strong>Status:</strong></label> <br>
											<%
												String available = "", occupied = "";

												if (rooms.getStatus() == 0) {
											%>
											<input type="radio" name="status" value="1">
											Available <br> <input type="radio" name="status"
												value="0" checked="checked"> Occupied <br>
											<%
												} else if (rooms.getStatus() == 1) {
											%>
											<input type="radio" name="status" value="1" checked="checked">
											Available <br> <input type="radio" name="status"
												value="0"> Occupied <br>
											<%
												}
											%>
										</div>
										<button type="submit" class="btn btn-primary" style="width:auto; font-size:15px; margin-left: 9.5em;" id="btnSubmit<%=rooms.getRoomId()%>">Save Room</button>
										<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									</form>
	<script type="text/javascript">
							$(document).ready(function() {
		      					$('#roomname<%=rooms.getRoomId()%>').blur(function(e) {
		      						var name = $('#roomname<%=rooms.getRoomId()%>').val();
		          					if (validateStrings(name)) {
		      							$('#spnNameStatus<%=rooms.getRoomId()%>').html('');
		      							$('#spnNameStatus<%=rooms.getRoomId()%>').css('color', 'green');
		      							document.getElementById("btnSubmit<%=rooms.getRoomId()%>").disabled = false; 
		      						}
		      						else {
		      							$('#spnNameStatus<%=rooms.getRoomId()%>').html('Room Name just allow upper, lower letter and number');
		      							$('#spnNameStatus<%=rooms.getRoomId()%>').css('color', 'red');
		      							document.getElementById("btnSubmit<%=rooms.getRoomId()%>").disabled = true; 
		      						}
		       					});
		      				});

							function validateStrings(string) {
		      					var pattern = /^[^`~<>@#%&\*\$\{\}\[\]\(\)\+\=?\|\;_^!]+$/;

		      					return $.trim(string).match(pattern) ? true : false;
		      				}
							</script>
								</div>
							</div>
						</div>
					</div>
                  <%
                  	}
                  %>
                  </tbody>
                </table>
                </form>
                <div id="pager" style="float:left;">
					<ul id="pagination" class="pagination-sm pagination"></ul>
				</div>

  <!-- Add Modal -->
					<div class="modal fade" id="addModal" role="dialog">
						<div class="modal-dialog">
							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header alert alert-primary">
								<h4 class="modal-title" align="center"><i class="fa fa-fw fa-home"></i><strong>Add new room</strong></h4>
								</div>
								<div class="modal-body">
									<form id="add-post1" action="/managementSystem/AddNewRoom"
										method="POST">
										<div class="form-group">
											<label class="required"><strong>Room Name:</strong><span
												style="color: red"> *</span>&nbsp;</label>
											<input class="form-control" id="roomname" type="text"
												name="name" placeholder="Room Name" required /> <span id="spnNameStatus"></span>
										</div>
										<div class="form-group">
											<label class="required"><strong>Capacity:</strong><span
												style="color: red"> *</span></label> 
												<input class="form-control"
												id="txtname" type="number" name="capacity"
												placeholder="Capacity" min="1" required />
										</div>
										<div class="form-group">
											<input type="radio" name="status" value="1" checked
												style="display: none;"> 
											<input type="radio" name="status" value="0" style="display: none;">
										</div>
										<button type="submit" class="btn btn-primary" id="btnSubmit"
										 style="width:auto; font-size:15px; margin-left: 9em;">Add Room</button>
											<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									</form>
								</div>
							</div>
						</div>
					</div>
			</div>
			<script type="text/javascript">
							
							$(document).ready(function() {
		      					$('#roomname').blur(function(e) {
		      						var name = $('#roomname').val();
		          					if (validateStrings(name)) {
		      							$('#spnNameStatus').html('');
		      							$('#spnNameStatus').css('color', 'green');
		      							document.getElementById("btnSubmit").disabled = false; 
		      						}
		      						else {
		      							$('#spnNameStatus').html('Room Name just allow upper, lower letter and number');
		      							$('#spnNameStatus').css('color', 'red');
		      							document.getElementById("btnSubmit").disabled = true; 
		      						}
		       					});
		      				});

							function validateStrings(string) {
		      					var pattern = /^[^`~<>@#%&\*\$\{\}\[\]\(\)\+\=?\|\;_^!]+$/;

		      					return $.trim(string).match(pattern) ? true : false;
		      				}
							</script>
							
					<div class="card-footer small text-muted">
          
        </div>
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
                var pageSize = 10; 
                showPage = function (page) {
                    $(".contentPage").hide();
                    $(".contentPage").each(function (n) {
                        if (n >= pageSize * (page - 1) && n < pageSize * page)
                            $(this).show();
                    });
                }
                showPage(1);
                var totalRows = <%= tong%>;
                var btnPage = 5; 
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
        </div>
        
       </div>  
      </div>
      </div>
      </div>

<%@include file="/templates/inc/footer.jsp" %> 