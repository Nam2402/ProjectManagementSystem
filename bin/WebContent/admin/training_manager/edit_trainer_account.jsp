
<%@page import="java.time.LocalDate"%>
<%@page import="model.bean.Skills"%>
<%@page import="model.bo.SkillBo"%>
<%@page import="model.bean.Ability"%>
<%@page import="java.util.List"%>
<%@page import="model.bean.User"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<style>
		#oldpass, #newpass{
			margin-top:5px;
			margin-bottom: 5px;
		}
		#abilityTable{
			width: 80%;
			text-align: center;
		}
	</style>
<%@include file="/templates/inc/dashboard.jsp"%>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>

<%
String classNameContent = "" ;
String classNameContainer = "";
String styleContent = "style='margin-top:  5px;'";
if( user.getRoleId() == 3) {
	classNameContent = "content-wrapper py-3";
	classNameContainer = "container-fluid";
	styleContent = "";
}
User trainer = new User();
Ability ability= new Ability();
SkillBo skillBo = new SkillBo();
if (request.getAttribute("trainer") != null) {
	trainer = (User) request.getAttribute("trainer");
}
if (request.getAttribute("ability") != null) {
	ability = (Ability) request.getAttribute("ability");
}
LocalDate date= LocalDate.now().minusYears(18);
String dateMax= date.toString();
%>
<div class="<%= classNameContent%>" <%= styleContent%>>
  <div class="<%= classNameContainer%>">
    <div  class="card mb-3">
             <div class="alert alert-primary" style="font-size: larger;margin-bottom: 0px;"> 
             <i class="fa fa-fw fa-user" ></i>
			    <strong>&nbsp;<%=trainer.getUsername() %> </strong>
			  </div>
			  
			  <div> 
			<%
				if(request.getAttribute("error") != null){
			%>
			<div class="alert alert-danger">
				  <strong>Error! </strong><%= request.getAttribute("error")%>
				</div>
				<%} %>
			<form action="<%= request.getContextPath() %>/trainer/edit" method="post" id="edit-trainer-post" enctype="multipart/form-data">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-6">
								<input
									type="hidden" class="form-control" id="usr"
									value="<%=trainer.getUserId() %>" name="user_id"/><br>
							<div class="form-group">
								<div>
									<div class="form-group" class="col-sm-2" style="float: left; padding-right:20px;">
										<img id="blah"
											src="<%=request.getContextPath()%>/files/<%=trainer.getAvatar()%>"
											alt="your image" width="120" height="150" />
									</div>					
									<div class="form-group" class="col-sm-4" style="float: left">
										<label class="required">Avatar:<em
											style="color: red">(jpg, png, gif)</em> </label>
											 <input
											class="form-control" id="image" type="file" name="avatar"
											value="" placeholder="Email" onchange="readURL(this);" />
									</div>
									<div style="clear: both"></div>
								</div>
								<script type="text/javascript">
									function readURL(input) {
										if (input.files && input.files[0]) {
											var reader = new FileReader();
											reader.onload = function(e) {
												$('#blah').attr('src',
														e.target.result).width(
														120);
											};
											reader
													.readAsDataURL(input.files[0]);
										}
									}
								</script>
							</div>
							<div class="form-group" style="margin-top:-10px;">
								<label for="usr">Email<span
									style="color: red"> *</span></label> <input
									type="email" class="form-control" id="txtemail"
									value="<%=trainer.getEmail()%>" name="email" disabled/>&nbsp;<span id="spnEmailStatus"></span>
							</div>

							<div class="form-group">
								<label for="usr">UserName<span
									style="color: red"> *</span></label> <input
									type="text" class="form-control" id="txtusername"
									value="<%=trainer.getUsername() %>" name="username" />
									&nbsp;<span id="spnUserNameStatus"></span>
							</div>
							<div class="form-group">
								<label for="usr">FullName<span
									style="color: red"> *</span></label> <input type="text"
									class="form-control" id="txtfullname" name="fullname"
									value="<%=trainer.getFullname() %>"/>
									&nbsp;<span id="spnFullNameStatus"></span>
							</div>
							
							<div class="form-group">
			              	  <label class="required" >Gender<span
									style="color: red"> *</span></label> <br>
			              	  <%
			              	  String male = "", female = "", other = "";
			              	  
			              	  if ( trainer.getGender() == 0) { 
			              		  male = "checked";
			              	  } else if ( trainer.getGender() == 1) { 
			              		  female = "checked";
			              	  } else if ( trainer.getGender() == 2) {
			              		  other = "checked";
			              	  }
			              	 %>
							  <input type="radio" name="gender" value="0" <%= male%>> Male 
							  <input type="radio" name="gender" value="1" <%= female%>> Female 
							  <input type="radio" name="gender" value="2" <%= other%> > Other 
			              	
				              	
		              	</div>
						</div>
						<div class="col-md-6">
						<br>
							<div class="form-group">
								<label for="usr">Birthday<span
									style="color: red"> *</span></label> <input type="date"
									class="form-control" id="usr" name="dateOfBirth" max="<%=dateMax%>"
									value="<%=trainer.getDateOfBirth() %>" />
							</div>
							<div class="form-group">
								<label for="usr">Address<span
									style="color: red"> *</span></label> <input type="text"
									class="form-control" id="address" name="address"
									value="<%=trainer.getAddress() %>"  />
									&nbsp;<span id="spnAddressStatus"></span>
							</div>
							
							<div class="form-group">
								<label for="usr">Phone<span
									style="color: red"> *</span></label> <input type="text"
									class="form-control" id="txtphone" name="phone"
									value="<%=trainer.getPhone() %>" />
									&nbsp;<span id="spnPhoneStatus"></span>
							</div>


							<div class="form-group" style="margin-top:-5px;">

								<label for="usr">Password:</label> <input type="button"
									value="Click here to change" onclick="changePass();"> <br>
								<input style="display: none;" type="password"
									class="form-control" id="oldpass" name="oldpass"
									placeholder="Current password" value=""/> <input
									style="display: none;" type="password" class="form-control"
									id="newpass" name="newpass" placeholder="New password" value=""/>
								<input style="display: none;" type="password"
									class="form-control" id="confirmpass" name="confirmpass"
									placeholder="Confirm new password" value="" onkeyup="checkConfirmPass();"/>&nbsp;<span
									id="spnPasswordStatus"></span>
							</div>

							<div class="form-group">

								<label for="usr"><strong>Ability:</strong></label>

								<table class="table table-bordered" id="abilityTable">
									<thead>
										<tr>
											<td style="text-align:center;">Skill:<br>
											<select class="form-group" name="skillId" id="ability" style="text-align:center;width: 12em;margin-top: 5px;">
												<%
													List<Skills> skills = skillBo.getSkills();
													for (Skills skill : skills) {
												%>
												<option value="<%=skill.getSkillId()%>"><%=skill.getName()%></option>
												<%
													}
												%>
											</select>
											</td>
											<td style="text-align:center;">Experience:<br>
											<input type="number" name="experience" value="0"
												placeholder="Experience Year" id="exp" style="text-align:center;width: 12em; margin-top: 5px;" min="0" max="50" />
											</td>
											
									</thead>
									<tbody>
										<tr>
											<td><%=skillBo.getSkillById(ability.getSkillId())%></td>
											<td><%=ability.getExperience()%></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<br>
					<br>
					<div class="" style="text-align:center; ">
						<input class="btn btn-primary btn-lg" type="submit"  name="submit" id="btnSubmit"  value="Update" style="height:40px; width:100px; text-align:center; vertical-align:middle;font-size:17px;padding:5px; "/>
						<input class="btn btn-secondary btn-lg" type="reset" value="Reset"  style="border:1px solid white;height:40px; width:100px; text-align:center; vertical-align:middle;font-size:17px;padding:5px; "/>
					</div>
					</div>
			</form>
			<script type="text/javascript">
      				/* $(document).ready(function() {
      					$("#edit-trainer-post").validate({
      						rules: {
      							email:{
      								required: true,
      								email:true
      							},
      							username:"required",
                                oldpass:{
                                	required: true,
                                },
                                newpass:{
                                	required: true,
                                },
                                confirmpass:{
                                	required: true,
                                	equalTo: "#newpass"
                                },
                                fullname:"required",
                                address:"required",
                                dateOfBirth:"required",
      						},
      						messages: {
      							username:"Username is required!",
                                oldpass:{
                                	required: "Password is required!",
                                	minlength: "Password must be at least 8 characters!",
                                },
                                newpass:{
                                	required: "Password is required!",
                                	minlength: "Password must be at least 8 characters!",
                                },
                                confirmpass:{
                                	required: "Password is required!",
                                	minlength: "Password must be at least 8 characters!",
                                	equalTo: "Password does not matching!"
                                },
                                fullname:"Fullname is required!",
                                address:"Address is required!",
                                dateOfBirth:"Day of Birth is required!",
      						}
      					});
      				}); */
      				
      				$(document).ready(function() {
      					$('#txtphone').blur(function(e) {
          					if (checkPhoneNumber()) {
      							$('#spnPhoneStatus').html('');
      							 $('#spnPhoneStatus').css('color', 'green');
         						document.getElementById("btnSubmit").disabled = false; 
      						}
      						else {
      							$('#spnPhoneStatus').html('Phone number must be 10 digits.');
      							$('#spnPhoneStatus').css('color', 'red');
       							document.getElementById("btnSubmit").disabled = true; 
      						}
       					});
      				});
      				
      				function checkPhoneNumber() {
      				    var flag = false;
      				    var phone = $('#txtphone').val().trim(); // ID của trường Số điện thoại
      				    if (phone != '') {
      				        var firstNumber = phone.substring(0, 2);
      				        if ((firstNumber == '09' || firstNumber == '08') && phone.length == 10) {
      				            if (phone.match(/^\d{10}/)) {
      				                flag = true;
      				            }
      				        } else if (firstNumber == '01' && phone.length == 11) {
      				            if (phone.match(/^\d{11}/)) {
      				                flag = true;
      				            }
      				        }
      				    }
      				    return flag;
      				}
      				$(document).ready(function(e) {
      				    $('#txtemail').blur(function() {
      				        var sEmail = $('#txtemail').val();
      				        if ($.trim(sEmail).length == 0) {
      							$('#spnEmailStatus').html('Please enter valid email address!');
     							 $('#spnEmailStatus').css('color', 'red');
        						document.getElementById("btnSubmit").disabled = true; 
      				        }
      				        if (validateEmail(sEmail)) {
      							$('#spnEmailStatus').html('');
    							 $('#spnEmailStatus').css('color', 'green');
         						document.getElementById("btnSubmit").disabled = false; 
      				        }
      				        else {
      							$('#spnEmailStatus').html('Please enter valid email address!');
    							 $('#spnEmailStatus').css('color', 'red');
        						document.getElementById("btnSubmit").disabled = true; 
      				        }
      				    });
      				});
      				function validateEmail(sEmail) {
      				    var filter = /^([A-Za-z]+.[A-Za-z0-9]*)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
      				    if (filter.test(sEmail)) {
      				        return true;
      				    }
      				    else {
      				        return false;
      				    }
      				}
      				
      				$(document).ready(function() {
      					$('#txtusername').blur(function(e) {
      						var userName= $('#txtusername').val();
          					if (validateStrings(userName)) {
          						$('#spnUserNameStatus').html('');
      							$('#spnUserNameStatus').css('color', 'green');
        						document.getElementById("btnSubmit").disabled = false; 
      						}
      						else {
      							$('#spnUserNameStatus').html('Username is invalid!');
      							$('#spnUserNameStatus').css('color', 'red');
        						document.getElementById("btnSubmit").disabled = true; 
      						}
       					});
      				});
      				
      				$(document).ready(function() {
      					$('#txtfullname').blur(function(e) {
      						var fullName= $('#txtfullname').val();
          					if (validateFullName(fullName)) {
          						$('#spnFullNameStatus').html('');
      							$('#spnFullNameStatus').css('color', 'green');
        						document.getElementById("btnSubmit").disabled = false; 
      						}
      						else {
      							$('#spnFullNameStatus').html('Fullname is invalid!');
      							$('#spnFullNameStatus').css('color', 'red');
        						document.getElementById("btnSubmit").disabled = true; 
      						}
       					});
      				});
      				
      				$(document).ready(function() {
      					$('#address').blur(function(e) {
      						var addr= $('#address').val();
          					if (validateAddress(addr)) {
          						$('#spnAddressStatus').html('');
      							$('#spnAddressStatus').css('color', 'green');
        						document.getElementById("btnSubmit").disabled = false; 
      						}
      						else {
      							$('#spnAddressStatus').html('Address is invalid!');
      							$('#spnAddressStatus').css('color', 'red');
        						document.getElementById("btnSubmit").disabled = true; 
      						}
       					});
      				});
      				
      				$(document).ready(function() {
      					$('#newpass').blur(function(e) {
      						var pass= $('#newpass').val();
          					if (validatePassword(pass)) {
          						$('#spnPasswordStatus').html('');
      							$('#spnPasswordStatus').css('color', 'green');
        						document.getElementById("btnSubmit").disabled = false; 
      						}
      						else {
      							$('#spnPasswordStatus').html('Password have minimum 8 characters, at least one letter, one number and one special character!');
      							$('#spnPasswordStatus').css('color', 'red');
        						document.getElementById("btnSubmit").disabled = true; 
      						}
       					});
      					$('#oldpass').blur(function(e) {
      						var pass= $('#oldpass').val();
          					if (validatePassword(pass)) {
          						$('#spnPasswordStatus').html('');
      							$('#spnPasswordStatus').css('color', 'green');
        						document.getElementById("btnSubmit").disabled = false; 
      						}
      						else {
      							$('#spnPasswordStatus').html('Password have minimum 8 characters, at least one letter, one number and one special character!');
      							$('#spnPasswordStatus').css('color', 'red');
        						document.getElementById("btnSubmit").disabled = true; 
      						}
       					});
      				});
      				
      				function validateStrings(string) {
      					//var pattern = /^[^`~<>@#%&\*\$\{\}\[\]\(\)\+\=?\|\;_!0-9]+$/;
      					var pattern = /^[a-zA-Z]+$/;
      					return $.trim(string).match(pattern) ? true : false;
      				}
      				
      				function validateFullName(string) {
      					var pattern = /^[^`~<>@#%&\*\$\{\}\[\]\(\)\+\=?\|\;_!0-9]+$/;
      					//var pattern = /^[a-zA-Z]+$/;
      					return $.trim(string).match(pattern) ? true : false;
      				}
      				
      				function validateAddress(string) {
      					var pattern = /^[^`~<>@#%&\*\$\{\}\[\]\(\)\+\=?\|\;_!]+$/;
      					return $.trim(string).match(pattern) ? true : false;
      				}
      				
      				function validatePassword(password){
      					var pattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;
      					return $.trim(password).match(pattern) ? true : false;
      				}
      				function changePass() {
						if(document.getElementById("oldpass").style.display == "none"){
							document.getElementById("oldpass").style.display = "block";
							document.getElementById("newpass").style.display = "block";
							document.getElementById("confirmpass").style.display = "block";
							
						}
						else{
							document.getElementById("oldpass").style.display = "none";
							document.getElementById("newpass").style.display = "none";
							document.getElementById("confirmpass").style.display = "none";
							document.getElementById("spnPasswordStatus").style.display = "none";
							
						}
					}
      				
      				function checkConfirmPass() {
      				  if (document.getElementById('newpass').value ==
      				    document.getElementById('confirmpass').value) {
      				    document.getElementById('spnPasswordStatus').style.color = 'green';
      				    document.getElementById('spnPasswordStatus').innerHTML = 'Matching';
      				  	document.getElementById("btnSubmit").disabled = false; 
      				  } else {
      				    document.getElementById('spnPasswordStatus').style.color = 'red';
      				    document.getElementById('spnPasswordStatus').innerHTML = ' Not matching';
      				  	document.getElementById("btnSubmit").disabled = true; 
      				  }
      				}
      			</script>
			
		</div>
	<div class="card-footer small text-muted">
          Updated yesterday at 11:59 PM
        </div>
	
</div>

<%@include file="/templates/inc/footer.jsp"%>

   
