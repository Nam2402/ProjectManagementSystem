
<%@page import="model.bean.Majors"%>
<%@page import="model.bean.Courses"%>
<%@page import="model.bean.Roles"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/templates/inc/dashboard.jsp" %>
<style>
	#add-post .required:after {
	  content:"*";color:red;
	}
</style>

<%
	Courses course = new Courses(0, 0, "", 0, 0, "", 0);
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
<div class="<%= classNameContent%>" <%= styleContent%>>
  <div class="<%= classNameContainer%>">
        <div class="card mb-3">
             <div class="alert alert-primary" style="font-size: larger;margin-bottom: 0px;"> 
             <i class="fa fa-fw fa-book" ></i>
			    <strong>Add new course</strong>
			  </div>
			  
			  <div>
			  	<%
				if(request.getAttribute("error") != null){
				%>
				<div class="alert alert-danger">
				  <strong>Error!</strong><%= request.getAttribute("error")%>
				</div>
				<%
				}
			  	%>
			  </div>
  
             <form id="add-post" action="<%= request.getContextPath()%>/course/add" method="POST" >
              	<div style="height: 5%"></div>
              	<div class="col-sm-1" style="float: left"></div>
              	
              	<div class="col-sm-10"  style="float: left">
              		<div class="form-group">
	              	<label class="required" >Major&nbsp;</label>
	              	<br>
	              	<select name="major">
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
		              	<label class="required" >Name</label>&nbsp;
		              	<input class="form-control" id="txtName" pattern="^[A-Za-z_-][A-Za-z0-9_-]*$" type="text" name="name" value="<%= course.getName()%>" placeholder="Course name" />
	              		<span id="spnNameStatus"></span>
	              	</div>
	              	
	              	<div class="form-group">
		              	<label class="required" >Duration (hours)</label>&nbsp;
		              	<input class="form-control" type="number" min="1" max="1000" id="txtDuration" name="duration" value="<%= course.getDuration()%>" placeholder="duration" />
	              		<span id="spnDurationStatus"></span>
	              	</div>
	              	
	              	<div class="form-group">
		              	  <label class="required">Is this course the default? &nbsp;</label> <br>
						  <input type="radio" name="kindOfCourse" value="1" > Yes <br>
						  <input type="radio" name="kindOfCourse" value="0" checked>  No <br>
	              	</div>
	              
	              <div class="error" ></div>
	               
	              <div>
		               <div class="col-sm-4" style="float: left"></div>
		               
		             	<div class="col-sm-4" style="float: left">
		             		<div style="float: left"><input style="width:auto; font-size:20px; height:auto; margin-bottom:10px;" id="btnSubmit"  class="btn btn-primary" type="submit" name="submit" value="Add" /></div>
		             		<div style="float: left; margin-left: 20px;"><input style="width:auto; font-size:18px; height:auto; margin-bottom:10px;" class="btn btn-secondary" type="reset" name="reset" value="Reset" /></div>
		             		<div style="clear: both"></div>	
		             	</div> 
		             	
		               <div class="col-sm-4" style="float: right"></div>
		               <div style="clear: both"></div>
	              </div>
	              
	              <div style="margin-bottom: 5%"></div>
              	</div>
              	
              	<div class="col-sm-1"  style="float: left"></div>
              	<div  style="clear: both"></div>
              	
              </form> 

            <script type="text/javascript">
      				$(document).ready(function() {
      					$("#add-post").validate({
      						rules: {
      							name:{
      								required: true,
      							},
                                kindOfCourse:{
                                	required: true,
                                },
                                duration:{
                                	required: true,
                                },
                                
      						},
      						messages: {
      							name:{
      								required: "Name of course is required",
      							},
                                kindOfCourse:{
                                	required: "Kind of course is required",
                                },
                                duration:{
                                	required: "Duration of course is required",
                                }
      						}
      					});
      				});
      				
      				$(document).ready(function() {
      					$('#txtDuration').blur(function(e) {
          					if (checkDuration()) {
      							$('#spnDurationStatus').html('');
      							 $('#spnDurationStatus').css('color', 'green');
       							document.getElementById("btnSubmit").disabled = false; 
      						}
      						else {
      							$('#spnDurationStatus').html('The duration must be a positive number.');
      							$('#spnDurationStatus').css('color', 'red');
      							document.getElementById("btnSubmit").disabled = true; 
      						}
       					});
      				}); 
      				
      				
      				$(document).ready(function() {
      					$('#txtName').blur(function(e) {
      						var name = $('#txtName').val();
          					if (validateName(name)) {
      							$('#spnNameStatus').html('');
      							$('#spnNameStatus').css('color', 'green');
      							document.getElementById("btnSubmit").disabled = false; 
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
        <div class="card-footer small text-muted">
          Updated yesterday at 11:59 PM
        </div>
          </div>
        </div>
      </div>
<%@include file="/templates/inc/footer.jsp" %> 