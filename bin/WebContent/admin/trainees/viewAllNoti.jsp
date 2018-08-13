<%@page import="model.bean.MyMessages"%>
<%@page import="model.bean.Roles"%>
<%@page import="java.util.ArrayList"%>
<%@page import="libralies.FormatDateLibrary"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/templates/inc/dashboard.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/templates/css/styleAllNoti.css">
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
       		
		<div>
			<div class="box-all-noti" style="margin-left:auto; margin-right:auto;">
				<ul class="list-noti" style="width:50%; ">
				
					<li>
						<div class="alert alert-primary"  style="font-size:  larger; margin-bottom: 0px;"> 
				             <i class="fa fa-fw fa-user" ></i>
				             <strong>Notification</strong>
						</div>	
					</li>
					<%
					 ArrayList<MyMessages> list = (ArrayList<MyMessages>)request.getAttribute("list");
					%>
					
					<%
					for (MyMessages msg : list)  {
						String ngay =  FormatDateLibrary.FormatDateUntilToString(msg.getCreatedDate());
						if (msg.getStatus()==0){
						%>
						<li class="noti1 noti" style='background-color: rgb(212, 237, 218)' >
						<% 
						}
						else {
							%>
						<li class="noti1 noti" >
						
					<%		
						
							
						}
					%>
						
						<div class="r1 row">
				  			<div class="divTitle">
				  				<label class="title"><%= msg.getTitle() %></label>
				  			</div>
				  			<div class="divDate">
				  				<label class="date"><%= ngay %></label>
				  			</div>
			  			</div>

			  			<div class="r2">
			  				<label class="content">
			  					<%= msg.getNotiContent() %>
			  				</label>
		  				</div>
		
					</li>
					<%
					}
					%>
					
				</ul>
			
   		</div> </div>
     
              
        <div style="clear: both"></div>
        <div class="error" ></div>
        <div style="margin-bottom: 10%"></div>
	</div>
</div>
</div>
<%@include file="/templates/inc/footer.jsp" %> 