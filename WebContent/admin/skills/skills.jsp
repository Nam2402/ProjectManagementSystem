<%@page import="model.bean.Skills"%>
<%@page import="model.bean.Majors"%>
<%@page import="model.bean.Courses"%>
<%@page import="model.bo.MajorBo"%>
<%@page import="java.util.List"%>
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
<%
int check = 0;
List<Skills> skill = (List<Skills>) request.getAttribute("skill");
/* if(request.getAttribute("check") != null){
	check = Integer.parseInt((String)request.getAttribute("check"));
} */
int k = 0;
int tong = skill.size();
%>


<div class="<%= classNameContent%>" <%= styleContent%> id="toggler_contentId" style="">
  <div class="<%= classNameContainer%>" id="toggler_containerId">
    <div  class="card1 card mb-3" style="margin-top: 0px;">
<!-- Nav -->
       	<div class="alert1 alert alert-primary" style="font-size: larger;margin-bottom: -6px;padding-left: 10px;"> 
             <i class="fa fa-fw fa-graduation-cap" style="font-size:24px;" ></i>
             	<strong class="lb_name" style="font-size:26px;">Skill</strong>
			  </div>	
		
<!-- Div Page Content -->
        <div>	
	
			  <%       	
String msg = "";
if(request.getParameter("msg") != null){
	boolean check1 = false;
	int msgInt = Integer.parseInt((String)request.getParameter("msg"));
	switch(msgInt){
	case 0:{
		  check1 = false;
		  msg  = "Error! System have some problems. Please try again."; break;
	  }
	case 1: {
		check1 = false;
		msg = "This skill has already existed in the system."; break;
	}
	case 2: {
		check1 = true;
		msg = "You added the skill successfully."; break;
	}
	case 3:{
		check1 = true;
		msg = "You edited the skill successfully."; break;
	}
	case 4:{
		  check1 = true;
		  msg  = "You deleted skills successfully."; break;
	  }
	}
	if (check1 == false){
		%>
		<div class="alert alert-danger"><strong><%=msg%></strong></div>
		<% 
	} else {
		%>
		<div class="alert alert-success"><strong><%=msg%></strong></div>
		<%
		}
	}
%>  
   <div class="card-body" style="margin-top: 0px;">
         <div class="table-responsive" style="background: white;padding: 20px 10px; margin-top: 0px;">
                <div style="margin-left: -15px; margin-bottom: 5px;">
	            	<div style="float: left" >
	            	<button style="width:auto; font-size:15px; height:auto; margin-bottom:10px; margin-left: 13px;"
	            	type="button" class="btn btn-primary" data-toggle="modal" data-target="#addModal" role="button">Add Skill</button>
	        		</div>
	        		<form action="<%=request.getContextPath()%>/DeleteSkills" method="POST">
	            	<div style="float: left; margin-left: 15px;">
	            	<input class="btn btn-danger" style="display: none; margin-left: 10px; margin-bottom: 5px;" onclick="return confirm('Do you want to delete these skills?')" id="deleteall" type="submit" value="Delete skill">
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
	
	        	<table id="myTable" class="myTable table table-bordered table-hover table-compact" width="100%"  style="margin-top: -24px;">
                  <thead>
                    <tr style="height:50px;">
                      <th style="text-align: center;">Delete<input style="display: inline-block; margin-left: 15px;" type="checkbox" class="checkall"></th>
                      <th style="text-align: center;">Name</th>
                      <th style="text-align: center;"> Status</th>
                      <th style="text-align: center;">Action</th>
                   </tr>
                  </thead>
                  <tbody>
                  <%
                  for (Skills list: skill){
                	  k++;
                  %>
				   <tr class="contentPage" style="">
				   <%
				   if (list.getStatus() == 1)
				   {
				   %>
				   <td  style="text-align: center; vertical-align: middle;"> <input type="checkbox" name="skill<%=list.getSkillId()%>" value="<%=list.getSkillId()%>" disabled> </td>
				   <%
				   } else { %>
					<td  style="text-align: center; vertical-align: middle;"> <input type="checkbox" name="skill<%=list.getSkillId()%>" value="<%=list.getSkillId()%>" class="checkitem" id="chkitem"> </td>
					   
				   <% }
				   %>
				   
				   <%-- <td style="text-align: center; vertical-align: middle;width=20%" ><%=k %></td> --%>
              	  <td style="text-align: center; vertical-align: middle;width=20%"><strong><%=list.getName()%></strong></td>
              	  <%if(list.getStatus()==0){
                	  %>
		                    <td  id="" style='text-align: center;"'><a><img alt="" src="<%= request.getContextPath()%>/templates/images/deactive.gif"></a></td>
                	  <%
                  } else {
                	  %>
		                    <td id=""  style='text-align: center;'><a><img alt="" src="<%= request.getContextPath()%>/templates/images/active.gif"></a></td>
                	  <%
                  }
                   %>  
              	  
				  <td style="text-align: center; vertical-align: middle;">
                   <button type="button" class="btn btn-link" name="editSkill" style="" data-toggle="modal"
                   data-target="#editModal<%=list.getSkillId()%>"><i class="fa fa-edit" style="font-size:20px; !important; "></i></button>
                    </td>
                   </tr>
                   </form>
				<!-- Delete skill -->
				<div class="deleteModal<%=list.getSkillId() %>" role="dialog">
				<div class="modal-dialog">
				</div>
				</div>
				<!-- Edit list -->
                  <div class="modal fade" id="editModal<%=list.getSkillId()%>" role="dialog">
						<div class="modal-dialog">
							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header alert alert-primary">
         							 <h5 class="modal-title " align="center">
										<i class="fa fa-fw fa-graduation-cap"></i>
										<strong>Edit Skill</strong>
									</h5>
									<button type="button" class="close" style="color: red;" data-dismiss="modal">&times;</button>
								</div>
								<div class="modal-body">
									<form id="add-post2" action="/managementSystem/EditSkillController?id=<%=list.getSkillId()%>" method="POST">
									<div class="container" style="padding-left:0;padding-right:0; ">
										 <div><strong>Major:</strong>
										  <select class="form-group" name="majorId" id="major" style="width: 12em;margin-top: 5px;" disabled>
												<%
												List<Majors> checkMajor = (List<Majors>) request.getAttribute("listMajors");
												   for(Majors checkId: checkMajor){
													  if(checkId.getMajorId()== list.getMajorId()){
												%>
												
												<option  value="<%=list.getMajorId()%>" selected="selected"><%=checkId.getName()%></option>
												<%
													}
													  else {
												%>
												<option  value="<%=list.getMajorId()%>" ><%=checkId.getName()%></option>
												<% 
												}
										  }%>
											</select>
										</div>
										<br>
										<div class="form-group">
											<label class="required"><strong>Skill Name:</strong><span
												style="color: red"> *</span></label>
											<input class="form-control" id="roomname<%=list.getSkillId()%>" type="text"
												name="name" maxlength="20" value="<%=list.getName()%>"
												placeholder="Skill Name" required />
												<span id="spnNameStatus<%=list.getSkillId()%>"></span>
										</div>
										<div class="form-group">
											<label class="required"><strong>Status:</strong></label> <br>
											<%
												String available = "", occupied = "";

												if (list.getStatus() == 0) {
											%>
											<input type="radio" name="status" value="1"> Enable <br> 
											<input type="radio" name="status" value="0" checked="checked"> Disable <br>
											<%
												} else if (list.getStatus() == 1) {
											%>
											<input type="radio" name="status" value="1" checked="checked"> Enable <br> 
											<input type="radio" name="status" value="0"> Disable <br>
											<%
												}
											%>
										</div>
																							<div style="text-align:center;">
														<button type="submit" class="btn btn-primary" style="width:80px; height:40px; font-size:15px;" id="btnSubmit">Edit 
														</button>
														<button style="width:80px; height:40px;" type="button" class="btn btn-default" data-dismiss="modal">Close
														</button>
													</div></form>
									</div>
								</div>
							</div>
						</div> 
						<script type="text/javascript">
							$(document).ready(function() {
		      					$('#roomname<%=list.getSkillId()%>').blur(function(e) {
		      						var name = $('#roomname<%=list.getSkillId()%>').val();
		          					if (validateStrings(name)) {
		      							$('#spnNameStatus<%=list.getSkillId()%>').html('');
		      							$('#spnNameStatus<%=list.getSkillId()%>').css('color', 'green');
		      							document.getElementById("btnSubmit<%=list.getSkillId()%>").disabled = false; 
		      						}
		      						else {
		      							$('#spnNameStatus<%=list.getSkillId()%>').html('Skill Name just contains letters and " + . # "');
		      							$('#spnNameStatus<%=list.getSkillId()%>').css('color', 'red');
		      							document.getElementById("btnSubmit<%=list.getSkillId()%>").disabled = true; 
		      						}
		       					});
		      				});

							function validateStrings(string) {
		      					var pattern = /^[^0-9`~<>@%&\*\$\{\}\[\]\(\)\=?\|\;_^!]+$/;

		      					return $.trim(string).match(pattern) ? true : false;
		      				}
				</script>
					<%
                  	}
                  %>
                  </tbody>
                </table>
                <div id="pager">
					<ul id="pagination" class="pagination-sm"></ul>
				</div>
<!-- Add Modal -->
					<div class="modal fade" id="addModal" role="dialog">
						<div class="modal-dialog">
							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header alert alert-primary">
         							 <h5 class="modal-title " align="center">
										<i class="fa fa-fw fa-graduation-cap"></i>
										<strong>Add skill</strong>
									</h5>
									<button type="button" class="close" style="color: red;" data-dismiss="modal">&times;</button>
								</div>
								<div class="modal-body" >
									<form id="add-post1" action="/managementSystem/AddNewSkillController" method="POST">
										<div class="container" style="padding-left:0; padding-right:0" >
										 <div><strong>Major:<span style="color: red"> *</span></strong>
										 <select class="form-group" name="majorId" id="major" style="width: 12em;margin-top: 5px;" required>
												<%
												MajorBo majorBo = new MajorBo();	
												List<Majors> listMajor1 = majorBo.getMajors();%>
												<% 	
												for (Majors listmajor : listMajor1) {
												%>
												
												<option value="<%=listmajor.getMajorId()%>"><%=listmajor.getName()%></option>
												<%
													}
												%>
											</select>
										</div>
										  
										<br>
										<div class="form-group">
											<label class="required"><strong>Skill Name:</strong><span
												style="color: red"> *</span></label>
											<input class="form-control" id="roomname" type="text"
												name="name" placeholder="Skill Name" maxlength="25" required />
												&nbsp;<span id="spnNameStatus"></span>
										</div>
										<div class="form-group">
											<input type="radio" name="status" value="1" checked style="display: none;"> 
											<input type="radio" name="status" value="0" style="display: none;">
										</div>
																							<div style="text-align:center;">
														<button type="submit" class="btn btn-primary" style="width:80px; height:40px; font-size:15px;" id="btnSubmit">Add 
														</button>
														<button style="width:80px; height:40px;" type="button" class="btn btn-default" data-dismiss="modal">Close
														</button>
													</div>
									</div>
									</form>

								</div>
							</div>
						</div>
					</div>
					<script type="text/javascript">
	/* Validation for add */					
							$(document).ready(function() {
		      					$('#roomname').blur(function(e) {
		      						var name = $('#roomname').val();
		          					if (validateStrings(name)) {
		      							$('#spnNameStatus').html('');
		      							$('#spnNameStatus').css('color', 'green');
		      							document.getElementById("btnSubmit").disabled = false; 
		      						}
		      						else {
		      							$('#spnNameStatus').html('Skill Name just contains letters and " + . # "');
		      							$('#spnNameStatus').css('color', 'red');
		      							document.getElementById("btnSubmit").disabled = true; 
		      						}
		       					});
		      				});

							function validateStrings(string) {
		      					var pattern1 = /^[^0-9`~<>@%&\*\$\{\}\[\]\(\)\=?\|\;_^!]+$/;

		      					return $.trim(string).match(pattern1) ? true : false;
		      				}
				</script>
<!-- Pagination -->				
	<script type="text/javascript">
            $(function () {
                var pageSize = 10; // // Hiển thị 10 sản phẩm trên 1 trang
                showPage = function (page) {
                    $(".contentPage").hide();
                    $(".contentPage").each(function (n) {
                        if (n >= pageSize * (page - 1) && n < pageSize * page)
                            $(this).show();
                    });
                }
                showPage(1);
              /** Cần truyền giá trị vào đây **/
                var totalRows = <%=tong%>;  // Tổng số sản phẩm hiển thị
                var btnPage = 2; // Số nút bấm hiển thị di chuyển trang
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
<!-- Delete all -->
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
        </div>
        </div>
       </div>  
      </div>
      </div>
<%@include file="/templates/inc/footer.jsp" %> 