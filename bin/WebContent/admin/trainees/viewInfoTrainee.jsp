<%@page import="model.bean.Roles"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/templates/inc/dashboard.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/templates/css/style1.css">
<style>
	#add-post .required:after {
	content:"*";color:red;
	}
</style>

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
       		<div class="alert alert-success" style="font-size:  larger; margin-bottom: 0px;"> 
             <i class="fa fa-fw fa-user" ></i>
             <strong>Account Information</strong>
			  </div>
		<div>
			  
		  	<div class="divAvt">
                <div class="co1" >
                   <img src="<%=request.getContextPath()%>/templates/images/avatar.png" alt="avatar" class="imgAvt"/>
                </div>
            	<div class="co2">
                	<label class="username">Username</label>
            	</div>
            	<div class="co3"></div>
		  	</div>
  
            <form id="" action="" method="GET" >
           		<div style="height: 15%"></div>
            	<div class="col-sm-6" style="float: left">
	              	<div class="form-group">
		            	<label class="" >Fullname</label>
		            	<label class="form-control" id="txtname">Fullname</label>
	              	</div>
	              	<div class="form-group">
		              	<label class="" >Gender</label>
		              	<label class="form-control" id="txtgender">Gender</label>
	              	</div>
	              	<div class="form-group">
		              	<label class="" >Role</label>
		              	<label class="form-control" id="txtrole">Role</label>
	              	</div>
	              	<div class="form-group">
		              	<label class="" >Address</label>
		              	<label class="form-control" id="txtaddress" >Address</label>
	              	</div>
          	  	</div>
              
              	<div class="col-sm-6" style="float: right">
	              	<div class="form-group">
		              	<label class="" >Phone</label>
		              	<label class="form-control" id="txtphone">Phone</label>
	              	</div>              	
	              	<div class="form-group">
		              	<label class="" >Birthday</label>
		              	<label class="form-control" id="txtbirthday">Birthday</label>
	              	</div>
	              	<div class="form-group">
		              	<label class="" >Email</label>
		              	<label class="form-control" id="txtemail">Email</label>
	              	</div>	                  
	                <div class="form-group">
		              	<label class="" >Skills:</label>
		              	<label class="form-control" id="txtskills" >Skills</label>
	              	</div>             	  
              	</div>
   			</form>
   		</div> 
     
              
        <div style="clear: both"></div>
        <div class="error" ></div>
        <div style="margin-bottom: 10%"></div>
	</div>
</div>
</div>
<%@include file="/templates/inc/footer.jsp" %> 