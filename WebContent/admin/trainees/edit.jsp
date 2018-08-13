
<%@page import="model.bean.User"%>
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
	User trainee = new User(0, "", "", "", null, "", null, 0, 0, "", "", "", "");
	if( request.getAttribute("trainee") != null){
		trainee = (User) request.getAttribute("trainee");
	}
%>
<%
String classNameContent = "" ;
String classNameContainer = "";
String styleContent = "style='padding:20px 20px;'";
if( user.getRoleId() == 3) {
	classNameContent = "content-wrapper py-3";
	classNameContainer = "container-fluid";
	styleContent = "";
}

%>
<div class="<%= classNameContent%>" <%= styleContent%> style="">
  <div class="<%= classNameContainer%>">
  
  <div class="alert1 alert alert-primary" style="margin-left: -14px; margin-bottom: -6px;"> 
             <i class="fa1 fa fa-fw fa-user " style="margin-left: 0px; font-size: 24px;"></i>
			    <strong class="lb_name" style="">Profile </strong>
			  </div>
			  
			  <div>
			  	<%
				if(request.getAttribute("error") != null){
				%>
				<div class="alert alert-danger">
				  <strong>Error!</strong><%= request.getAttribute("error")%>.
				</div>
				<%
				}
			  	%>
			  </div>
        <div class="card mb-3" style="padding-top: 10px; margin-top: 0px;box-shadow: 2px 2px #c8c5c5;">
             <form id="add-post" action="<%= request.getContextPath()%>/trainee/edit?id=<%= trainee.getUserId()%>" method="POST" enctype="multipart/form-data" style="margin-top: 20px;" >
              	<!-- <div style="height: 5%"></div> -->
              
              <div class="col-sm-6" style="float: left">
              	<div >
	              	<div class="form-group" class="col-sm-4" style="float: left; height:200px; ">
		              	<label ><strong>Avatar:</strong> <em style="color: red">(jpg, png, gif)</em> </label>
		              	<input class="form-control" id="txtname" type="file" name="avatar" value="" onchange="readURL(this);" />
	              		<img  id="blah" alt="" src="<%= request.getContextPath()%>/files/<%= trainee.getAvatar()%>"  height="125px">
	    				<script type="text/javascript">
	    				function readURL(input) {
	    			        if (input.files && input.files[0]) {
	    			            var reader = new FileReader();
	
	    			            reader.onload = function (e) {
	    			                $('#blah')
	    			                    .attr('src', e.target.result)
	    			                    .height(125);
	    			            };
	
	    			            reader.readAsDataURL(input.files[0]);
	    			        }
	    			    }
	    				</script> 
	              	</div>
	              	<div style="clear: both"></div>
              	</div>
              	
              	
              	<div class="form-group" style="margin-top: 26px;">
	              	<label class="required" ><strong>Email:</strong></label>&nbsp;
	              	<input class="form-control" id="txtEmail" type="text" name="email" value="<%= trainee.getEmail()%>" placeholder="Email"  disabled="disabled"/>
	              	<span id="spnEmailStatus"></span>
              	</div>
              
              	<div class="form-group">
	              	<label class="required" ><strong>UserName:</strong></label>&nbsp;
	              	<input class="form-control" id="txtName" type="text" name="username" value="<%= trainee.getUsername()%>" placeholder="Username"  />
	              	<span id="spnNameStatus"></span>
              	</div>
              	
              	<div class="form-group">
	              	<label class="required" ><strong>FullName:</strong></label>&nbsp;

	              	<input class="form-control" id="txtFullname" type="text" name="fullname" value="<%= trainee.getFullname()%>" placeholder="Fullname" />
	              	<span id="spnFullNameStatus"></span>
              	</div>
              	
              </div>
      
              <div class="col-sm-6" style="float: right">
              	
              	<div class="form-group" style="margin-top: 10px;">
	              	  <label class="required" ><strong>Gender:</strong></label> <br>
	              	  <%
	              	  String male = "", female = "", other = "";
	              	  
	              	  if ( trainee.getGender() == 0) { 
	              		  male = "checked";
	              	  } else if ( trainee.getGender() == 1) { 
	              		  female = "checked";
	              	  } else if ( trainee.getGender() == 2) {
	              		  other = "checked";
	              	  }
	              	 %>
					  <input type="radio" name="gender" value="0" <%= male%>> Male <br>
					  <input type="radio" name="gender" value="1" <%= female%>> Female <br>
					  <input type="radio" name="gender" value="2" <%= other%> > Other <br>
              	</div>
              	
              	<div class="form-group" style="margin-top: 20px;">
	              	<label class="required" ><strong>Address:</strong></label>&nbsp;
	              	<input class="form-control" id="txtAddress" type="text" name="address" value="<%= trainee.getAddress()%>" placeholder="Address" />
	              	<span id="spnAddressStatus"></span>
              	</div>
              	
              	<div class="form-group" style="margin-top: 30px;">
	              	<label class="required" ><strong>Phone:</strong></label>&nbsp;
	              	<input class="form-control" id="txtPhone" type="text" name="phone" value="<%= trainee.getPhone()%>" placeholder="Phone" />
	              	<span id="spnPhoneStatus"></span>
              	</div>
              	
              	<div class="form-group" style="margin-top: 20px;">
	              	<label class="required" ><strong>Day of Birth:</strong></label>
	              	<input class="form-control" id="txtname" type="date" name="dateOfBirth" value="<%=  trainee.getDateOfBirth()%>" placeholder="Birthday" />
              	</div>
              	
              	
              	<div class="form-group" style="margin-top: 30px;">
                    		
                   <label for="usr"><strong>Password:</strong></label>&nbsp;
                  <input type="button" value="Click here to change" onclick="changePass();"> <br>
                   <input style="display: none" type="password" class="form-control" id ="oldpass"  name="oldpass" placeholder="Current password" />
                   <span id="spnPassStatus"></span>

                   <br>
                   <input style="display: none" type="password" class="form-control" id ="newpass"  name="newpass" placeholder="New password" />
                   <span id="spnNewPassStatus"></span>
                   <br>
                   <input style="display: none" type="password" class="form-control" id ="confirmpass"  name="confirmpass" placeholder="Confirm new password" />
                   <span id="spnConPassStatus"></span>
                  </div>
              	</div>
              	<div style="clear: both"></div>
              	<div class="error" ></div>
        
	           	<div style="text-align:center;margin-top:15px;">
	           		<input id="btnSubmit" class="btn btn-primary" style="height: 40px; width:100px; font-size: 17px;" type="submit" name="submit" value="Update" />
	           		<input class="btn btn-secondary" style="height: 40px; width:100px; font-size: 17px; border:1px solid white;" type="reset" name="reset" value="Reset" />
	           		
	           	</div> 
	            <div style="clear: both"></div>
              </form> 
              	
                   <script type="text/javascript">
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
						}
					}
                   </script>
              
              <div style="clear: both"></div>
              <div class="error" ></div>
               
              
	          <div style="clear: both"></div>
              
              <div style="margin-bottom: 5%"></div>
             

           <script type="text/javascript">
      				$(document).ready(function() {
      					$("#add-post").validate({
      						//ignore: [],
      			            //debug: false,
      						rules: {
      							username:{
      								required: true,
      								minlength: 6,
      							},
                                password:{
                                	required: true,
                                	minlength: 6,
                                },
                                fullname:{
                                	required: true,
                                },
                                phone:{
                                	required: true,
                                	minlength: 10,
                                	maxlength: 11,
                                },
                                email:{
                                	required: true,
                                	minlength: 12,
                                },
                                address:{
                                	required: true,
                                },
                                dateOfBirth:{
                                	required: true,
                                },
      						},
      						messages: {
      							username:{
      								required: "Username is required",
      								minlength: "Username must be at least 6 characters",
      							},
                                password:{
                                	required: "Password is required",
                                	minlength: "Passwords must be at least 6 characters",
                                },
                                fullname:{
                                	required: "Fullname is required",
                                },
                                phone:{
                                	required: "Phone number is required",
                                	minlength: "phone number at least 10 numbers",
                                	maxlength: "phone number max is 11 numbers",
                                },
                                email:{
                                	required: "Email address is required",
                                	minlength: "Email address at least 12 charaters",
                                },
                                address:{
                                	required: "Address is required",
                                },
                                dateOfBirth:{
                                	required: "Date of birth is required",
                                },
      						}
      					});
      				});
      				
					function enableSubmit() {
						if (checkPhoneNumber() && validateName() && validateFullName() && validateAddress() && validatePassword() &&validateEmail() ) {
							document.getElementById("btnSubmit").disabled = true; 
	      	           } else {
							document.getElementById("btnSubmit").disabled = false; 
	      	           }
					}
      	           
      				
      				$(document).ready(function() {
      					$('#txtPhone').blur(function(e) {
          					if (checkPhoneNumber()) {
      							$('#spnPhoneStatus').html('');
      							 $('#spnPhoneStatus').css('color', 'green');
      							enableSubmit();
      						}
      						else {
      							$('#spnPhoneStatus').html('Phone number must be 10 digits.');
      							$('#spnPhoneStatus').css('color', 'red');
      							enableSubmit();
      						}
       					});
      				});

      				$(document).ready(function() {
      					$('#txtName').blur(function(e) {
          					if (validateName()) {
      							$('#spnNameStatus').html('');
      							$('#spnNameStatus').css('color', 'green');
      							enableSubmit();
      						}
      						else {
      							$('#spnNameStatus').html('Name must be character.');
      							$('#spnNameStatus').css('color', 'red');
      							enableSubmit(); 
      						}
       					});
      				});

      				$(document).ready(function() {
      					$('#txtFullname').blur(function(e) {
          					if (validateFullName()) {
      							$('#spnFullNameStatus').html('');
      							$('#spnFullNameStatus').css('color', 'green');
      							enableSubmit();
      						}
      						else {
      							$('#spnFullNameStatus').html('Fullname  must be character.');
      							$('#spnFullNameStatus').css('color', 'red');
      							enableSubmit();
      						}
       					});
      				});   
      				
      				$(document).ready(function() {
      					$('#txtAddress').blur(function(e) {
          					if (validateAddress()) {
      							$('#spnAddressStatus').html('');
      							$('#spnAddressStatus').css('color', 'green');
      							enableSubmit(); 
      						}
      						else {
      							$('#spnAddressStatus').html('Address just have number and charater.');
      							$('#spnAddressStatus').css('color', 'red');
      							enableSubmit();
      						}
       					});
      				}); 

      				$(document).ready(function() {
      					$('#oldpass').blur(function(e) {
          					if (validatePassword()) {
      							$('#spnPassStatus').html('');
      							$('#spnPassStatus').css('color', 'green');
      							enableSubmit();
      						}
      						else {
      							$('#spnPassStatus').html('Minimum eight characters, at least one letter, one number and one special character');
      							$('#spnPassStatus').css('color', 'red');
      							enableSubmit();
      						}
       					});
      				});

      				$(document).ready(function() {
      					$('#newpass').blur(function(e) {
          					if (validatePassword()) {
      							$('#spnNewPassStatus').html('');
      							$('#spnNewPassStatus').css('color', 'green');
      							enableSubmit();
      						}
      						else {
      							$('#spnNewPassStatus').html('minimum eight characters, at least one letter, one number and one special character');
      							$('#spnNewPassStatus').css('color', 'red');
      							enableSubmit();
      						}
       					});
      				});

      				$(document).ready(function() {
      					$('#confirmpass').blur(function(e) {
          					if (validatePassword()) {
      							$('#spnConPassStatus').html('');
      							$('#spnConPassStatus').css('color', 'green');
      							enableSubmit();
      						}
      						else {
      							$('#spnConPassStatus').html('minimum eight characters, at least one letter, one number and one special character');
      							$('#spnConPassStatus').css('color', 'red');
      							enableSubmit();
      						}
       					});
      				});
      				
      				$(document).ready(function(e) {
      				    $('#txtEmail').blur(function() {
      				        var sEmail = $('#txtEmail').val();
      				        if ($.trim(sEmail).length == 0) {
      							$('#spnEmailStatus').html('Please enter email address');
     							 $('#spnEmailStatus').css('color', 'red');
       							enableSubmit();
      				            e.preventDefault();
      				        }
      				        if (validateEmail()) {
      							$('#spnEmailStatus').html('');
    							$('#spnEmailStatus').css('color', 'green');
       							enableSubmit();
      				        }
      				        else {
      							$('#spnEmailStatus').html('Please enter valid email address');
    							 $('#spnEmailStatus').css('color', 'red');
       							enableSubmit();
      				            e.preventDefault();
      				        }
      				    });
      				});

      				function checkPhoneNumber() {
      				    var flag = false;
      				    var phone = $('#txtPhone').val().trim(); // ID của trường Số điện thoại
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

      				function validateEmail() {
  				        var sEmail = $('#txtEmail').val();
      				    var filter = /^([A-Za-z]+.[A-Za-z0-9]*)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
      				    if (filter.test(sEmail)) {
      				        return true;
      				    }
      				    else {
      				        return false;
      				    }
      				}
      				
      				function validateName() {
  						var name = $('#txtName').val();
      					var pattern = /^[a-zA-Z]+$/;
      					return $.trim(name).match(pattern) ? true : false;
      				}
      				
      				function validateFullName() {
  						var fullName = $('#txtFullname').val();
      					var pattern = /^[^0-9`~<>@#%&\*\$\{\}\[\]\(\)\+\=?\|\;_!]+$/;
      					return $.trim(fullName).match(pattern) ? true : false;
      				}

      				function validateAddress() {
  						var txtAddress = $('#txtAddress').val();
      					var pattern = /^[^`~<>@#%&\*\$\{\}\[\]\(\)\+\=?\|\;_!]+$/;
      					return $.trim(txtAddress).match(pattern) ? true : false;
      				}
      				
      				function validatePassword() {
  						var pass = $('#txtPassword').val();
      					var pattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;
      					return $.trim(pass).match(pattern) ? true : false;
      				}
      			</script>
          </div>
     </div>
</div>
<%@include file="/templates/inc/footer.jsp" %> 
