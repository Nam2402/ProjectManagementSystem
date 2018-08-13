<%@page import="libralies.FormatDateLibrary"%>
<%@page import="model.bean.MyMessages"%>
<%@page import="model.bean.Roles"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/templates/inc/dashboard.jsp" %>  

<link rel="stylesheet" href="<%=request.getContextPath()%>/templates/css/styleNoti.css">
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
        <div class="card mb-3 divNoti">
       		<div class="alert alert-success" style="font-size:  larger; margin-bottom: 0px;"> 
       		<%
       		MyMessages messages = (MyMessages) request.getAttribute("messages");
       		String ngay = FormatDateLibrary.FormatDateUntilToString(messages.getCreatedDate());
       		%>
             <i class="fa fa-fw fa-user" ></i>
             <strong>Account Information</strong>
			  </div>
		<div>
		  	<div class="box-noti">
		  		<div class="labelNoti">
		  			<div class="divTitle row">
		  				<label class="title"><%= messages.getTitle() %></label>
		  			</div>
		  		</div>
		  		
		  		<div class="space"></div>
		  		<div class="divContentNoti">
		  			<label class="contentNoti">
		  				<%= messages.getNotiContent() %>
		  			</label>
		  			<label class="date"> <%= ngay %></label>
		  				
		  		</div>
		  	</div>
   		</div> 
     
              
        <div style="clear: both"></div>
        <div class="error" ></div>
        <div style="margin-bottom: 10%"></div>
	</div>
</div>
</div>
<%@include file="/templates/inc/footer.jsp" %> 