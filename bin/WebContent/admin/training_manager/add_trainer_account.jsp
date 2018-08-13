<%@page import="java.time.LocalDate"%>
<%@page import="model.bean.Skills"%>
<%@page import="model.bo.SkillBo"%>
<%@page import="model.bean.Roles"%>
<%@page import="java.util.List"%>
<%@page import="model.bo.RoleBo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/templates/inc/dashboard.jsp"%>

<%
String classNameContent = "" ;
String classNameContainer = "";
String styleContent = "style='margin-top:  5px;'";
if( user.getRoleId() == 3) {
	classNameContent = "content-wrapper py-3";
	classNameContainer = "container-fluid";
	styleContent = "";
}

LocalDate date= LocalDate.now().minusYears(18);
String dateMax= date.toString();
%>
<div class="<%= classNameContent%>" <%= styleContent%>>
  <div class="<%= classNameContainer%>">
		<div class="card mb-3">
			<div class="card-header alert alert-primary" style="font-size: larger;margin-bottom: 0px;"> 
             <i class="fa fa-fw fa-user" ></i>
			    <strong>&nbsp;Add trainer's account </strong>
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
			<form id="add-trainer-post" action="<%= request.getContextPath() %>/trainer/add" method="POST"  enctype="multipart/form-data">
				<div style="height: 2%"></div>

				<div class="container-fluid">
					<div class="row">
						<div class="col-md-6">
							<div>
								<div class="form-group" class="col-sm-2" style="float: left">
								<img id="blah"
									src="<%=request.getContextPath()%>/files/default.jpg"/>
							</div>
							<br><br><br>
								<div class="form-group" class="col-sm-4" style="float: left">
									<label class="required"><strong>Avatar:</strong><em style="color: red">(jpg,
											png, gif)</em> </label> <input class="form-control" id="image" type="file"
										name="avatar" onchange="readURL(this);" />
								</div>
								<script type="text/javascript">
									function readURL(input) {
										if (input.files && input.files[0]) {
											var reader = new FileReader();

											reader.onload = function(e) {
												$('#blah').attr('src',
														e.target.result).width(
														300);
											};
											reader.readAsDataURL(input.files[0]);
										}
									}
								</script>

								<div style="clear: both"></div>
							</div>
				
							<div class="form-group">
								<label class="required"><strong>Email:</strong><span
									style="color: red"> *</span> </label>
								<input class="form-control" id="txtemail" type="text"
									name="email" placeholder="Email" required="required"/>
									<span id="spnEmailStatus"></span>
							</div>
							<div class="form-group">
								<label class="required"><strong>Username:</strong><span
									style="color: red"> *</span></label>
								<input class="form-control" id="txtusername" type="text"
									name="username" placeholder="Username" required="required"/>
									<span id="spnUserNameStatus"></span>
							</div>

							<div class="form-group">
								<label class="required"><strong>Password:</strong>
								<span style="color: red"> *</span></label> 
								<input class="form-control" id="password" type="password" name="password" placeholder="Password" required="required"/>
								<span id="spnPasswordStatus"></span>
							</div>
							<div class="form-group">
								<label class="required"><strong>Confirm password:</strong>
								<span style="color: red"> *</span></label> 
								<input class="form-control"
									id="confirmpass" type="password" name="confirmpass"
									placeholder="Confirm Password" required="required"/><span id="spnPasswordStatus"></span>
							</div>

						</div>

						<div class="col-md-6">
							<div class="form-group">
								<label class="required"><strong>Full Name:</strong><span
									style="color: red"> *</span></label>
								<input class="form-control" id="txtfullname" type="text"
									name="fullname" placeholder="Fullname" required="required"/>
									<span id="spnFullNameStatus"></span>
							</div>

							<div class="form-group">
								<label class="required"><strong>Gender:</strong><span
									style="color: red"> *</span></label> <br> <input type="radio"
									name="gender" value="1" > Male <input type="radio"
									name="gender" value="2" >Female <input type="radio"
									name="gender" value="0" >Other
							</div>
							<div class="form-group">
								<label class="required"><strong>Address</strong><span
									style="color: red"> *</span></label>
								<input class="form-control" id="txtaddress" type="text"
									name="address" value="" placeholder="Address" required="required"/>
									<span id="spnAddressStatus"></span>
							</div>

							<div class="form-group">
								<label class="required"><strong>Phone Number:</strong><span
									style="color: red"> *</span> </label>
								<input class="form-control" id="txtphone" type="text"
									name="phone" placeholder="Phone" required="required"/>
									<span id="spnPhoneStatus"></span>
							</div>
							

							<div class="form-group">
								<label class="required"><strong>Day of Birth:</strong><span
									style="color: red"> *</span></label> <input class="form-control"
									id="txtname" type="date" name="dateOfBirth" value="<%=dateMax%>" max="<%=dateMax%>"
									placeholder="Birthday" required="required"/>
							</div>


							<div class="form-group">
								<label class="required"><strong>Ability:</strong><span
									style="color: red"> *</span></label><br> 
									<select
									class="form-inline" name="skillId" required="required">
									<%
							SkillBo skillBo= new SkillBo();
							List<Skills> skills= skillBo.getSkills();
							for(Skills skill: skills){
							%>
									<option value="<%=skill.getSkillId()%>"><%=skill.getName()%></option>
									<%}%>
								</select> <input class="form-group" id="txtname" type="number"
									name="experience" placeholder="Experience Year" min="0"
									max="50" required="required"/>
							</div>
							<div class="error"></div>
							<br> <br>
						</div>
					</div>
					<div class="row">
						<div class="col-md-5"></div>
						<input class="btn btn-primary btn-lg" type="submit" name="submit"
							id="btnSubmit" value="Add" style="width:100px; font-size:17px;height:40px; padding:5px; text-align:center;margin-right:10px;" /> <input
							class="btn btn-secondary btn-lg" type="reset" value="Reset" style="font-size:17px;border:1px solid white;width:100px; height:40px; padding:5px; text-align:center;" />
					</div>
					<div style="margin-bottom: 10%"></div>
				</div>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();

			reader.onload = function(e) {
				$('#blah').attr('src', e.target.result).width(300);
			};

			reader.readAsDataURL(input.files[0]);
		}
	}
	$(document).ready(function() {
		$("#add-trainer-post").validate({
			rules : {
				confirmpass : {
					equalTo : "#password"
				}
			},
			messages : {
				confirmpass : {
					equalTo : "Password does not matching!"
				}
			}
		});
	});

	$(document).ready(function() {
		$('#txtphone').blur(function(e) {
			if (checkPhoneNumber()) {
				$('#spnPhoneStatus').html('');
				$('#spnPhoneStatus').css('color', 'green');
				document.getElementById("btnSubmit").disabled = false;
			} else {
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
			if ((firstNumber == '09' || firstNumber == '08')
					&& phone.length == 10) {
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
			} else {
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
		} else {
			return false;
		}
	}

	$(document).ready(function() {
		$('#txtusername').blur(function(e) {
			var userName = $('#txtusername').val();
			if (validateStrings(userName)) {
				$('#spnUserNameStatus').html('');
				$('#spnUserNameStatus').css('color', 'green');
				document.getElementById("btnSubmit").disabled = false;
			} else {
				$('#spnUserNameStatus').html('Username is invalid!');
				$('#spnUserNameStatus').css('color', 'red');
				document.getElementById("btnSubmit").disabled = true;
			}
		});
	});

	$(document).ready(function() {
		$('#txtfullname').blur(function(e) {
			var fullName = $('#txtfullname').val();
			if (validateStrings(fullName)) {
				$('#spnFullNameStatus').html('');
				$('#spnFullNameStatus').css('color', 'green');
				document.getElementById("btnSubmit").disabled = false;
			} else {
				$('#spnFullNameStatus').html('Fullname is invalid!');
				$('#spnFullNameStatus').css('color', 'red');
				document.getElementById("btnSubmit").disabled = true;
			}
		});
	});

	$(document).ready(function() {
		$('#txtaddress').blur(function(e) {
			var addr = $('#txtaddress').val();
			if (validateAddress(addr)) {
				$('#spnAddressStatus').html('');
				$('#spnAddressStatus').css('color', 'green');
				document.getElementById("btnSubmit").disabled = false;
			} else {
				$('#spnAddressStatus').html('Address is invalid!');
				$('#spnAddressStatus').css('color', 'red');
				document.getElementById("btnSubmit").disabled = true;
			}
		});
	});

	$(document).ready(function() {
			$('#password').blur(function(e) {
				var pass= $('#password').val();
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
			var pattern = /^[^`~<>@#%&\*\$\{\}\[\]\(\)\+\=?\|\;_!0-9(\s)]+$/;
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
</script>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>

</body>
</html>

<%@include file="/templates/inc/footer.jsp"%>