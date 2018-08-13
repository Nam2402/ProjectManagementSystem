<%@page import="model.bean.Rooms"%>
<%@page import="model.bean.Schedule"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/templates/inc/dashboard.jsp" %>  

<%
String classNameContent = "" ;
String classNameContainer = "";
String styleContent = "";
if( user.getRoleId() == 3) {
	classNameContent = "content-wrapper py-3";
	classNameContainer = "container-fluid";
	styleContent = "";
}

%>
<div class="<%= classNameContent%>" <%= styleContent%> id="toggler_contentId" style="overflow-x:inherit;" >
  <div class="<%= classNameContainer%>" id="toggler_containerId">
  <div class="alert1" style="font-size: larger;background:none; border:none; color: #333333 !important;margin-top:12px;margin-bottom:-6px;"> 
             <i style="margin-left: 5px; font-size: 24px;" class="fa fa-fw fa-home" ></i>
             	<strong style="font-size: 26px;">Room</strong>
			  </div>	
    <div class="card mb-3" style="height:auto;border-radius: 5px;box-shadow: 2px 2px #c8c5c5;padding:0px;">
         
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
          <div class="table-responsive" style="background: white;padding: 10px;padding-bottom: 10px;margin-top: 10px;">
                <div style=" margin-bottom: 5px;">
	            	<div class="divBtnAdd" style="float: left; margin-bottom: 10px;">
	            		<button style="height:auto !important;" type="button" class="btnAdd btn btn-primary" data-toggle="modal" data-target="#addModal" role="button">Add Room</button>
	        		</div>
	            <form action="<%=request.getContextPath()%>/DeleteRoomController" method="POST">
	            	<div style="float: left; margin-left: 15px;">
	            	<input class="btn btn-danger" style="display: none; margin-left: 10px; margin-bottom: 5px;" onclick="return confirm('Do you want to delete these rooms?')" id="deleteall" type="submit" value="Delete rooms">
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
	        	<table id="myTable" class="myTable table table-bordered" cellspacing="0" style="margin-top: 5px;background:white;box-shadow: 2px 2px rgb(189, 189, 189);">
                  <thead>
                    <tr >
                      <th style="text-align: center;">Delete<input style="display: inline-block; margin-left: 15px;" type="checkbox" class="checkall"></th>
                      <th style="text-align: center;">Name</th>
                      <th style="text-align: center;">Capacity</th>
                      <th style="text-align: center;">Status</th>
                      <th style="text-align: center;">Action</th>
                   
                    </tr>
                  </thead>
                  <tbody  id="myTBody">
                  
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
                   <td style="text-align: center; vertical-align: middle;"><strong><%= rooms.getName() %></strong></td>
                   <td style="text-align: center; vertical-align: middle;" ><%= rooms.getCapacity()%></td>
                  <%if(rooms.getStatus()==0){
                	  %>
		                    <td  id="" style='text-align: center;vertical-align: middle; "'><a><img alt="" src="<%= request.getContextPath()%>/templates/images/deactive.gif"></a></td>
                	  <%
                  } else {
                	  %>
		                    <td id=""  style='text-align: center;vertical-align: middle;'><a  ><img alt="" src="<%= request.getContextPath()%>/templates/images/active.gif"></a></td>
                	  <%
                  }
                   %>  
                  <td style="text-align: center; vertical-align: middle;">
                   <button type="button" class="btn btn-link" name="editRoom" style="" data-toggle="modal"
                    data-target="#editModal<%=rooms.getRoomId()%>"><i class="fa fa-edit" style="font-size:20px; margin-top: 1px !important; "></i></button>
                   </td>
                  </tr>
<!-- Edit room -->
                  <div class="modal fade" id="editModal<%=rooms.getRoomId()%>" role="dialog">
						<div class="modal-dialog">
							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header alert alert-primary">
								<h5 class="modal-title " align="center"><i class="fa fa-fw fa-home"></i><strong>Edit Room</strong></h5>
								<button type='button' class='close' style='color: red; margin-left: 10px;' data-dismiss='modal'>&times;</button>
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
										<div style="text-align: center;vertical-align: middle;">
										<button type="submit" class="btn btn-primary" style="height:40px; width:80px; font-size:15px;" id="btnSubmit<%=rooms.getRoomId()%>">Edit</button>
										<button type="button" class="btn btn-default" data-dismiss="modal" style="height:40px; width:80px;">Close</button>
									</div>
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
								<h5 class="modal-title" align="center"><i class="fa fa-fw fa-home"></i><strong>Add Room</strong></h5>
								<button type='button' class='close' style='color: red; margin-left: 10px;' data-dismiss='modal'>&times;</button>
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
										 style="width:auto; font-size:15px; margin-left: 9em;">Add</button>
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