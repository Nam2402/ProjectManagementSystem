<%@page import="model.bean.ClassWaiting"%>
<%@page import="model.bean.Schedule"%>
<%@page import="model.bean.Roles"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/templates/inc/dashboard.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/templates/css/styleRegisterClass.css">
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
    <div class="card1 card mb-3" style="box-shadow: 0 2px 5px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12); margin-left: 0px;margin-right:7px;">
        	<div class="alert1"   style="padding-left: 10px;font-size: larger;margin-bottom: 20px;margin-top: 25px;"> 
             <i class="fa1 fa fa-hourglass-2" ></i>
		    <strong style="font-size: 25px;" class="lb_name">&nbsp;Pending Class</strong>
		 </div>
  <div style="background: white;">
			<%
			  ArrayList<ClassWaiting> listClassOpening = (ArrayList<ClassWaiting>)request.getAttribute("list");
			  int tong = listClassOpening.size();
			  if (tong==0){
					 %>
					 <div class="alert alert-danger" style="margin-top: 10px;">
			    	<strong> No Waiting Class </strong>
			  		</div>
					 <% 
				  }
			%>
			<script type="text/javascript">
            $(function () {
                var pageSize = 10; // Hiển thị 6 sản phẩm trên 1 trang
                showPage = function (page) {
                    $(".contentPage").hide();
                    $(".contentPage").each(function (n) {
                        if (n >= pageSize * (page - 1) && n < pageSize * page)
                            $(this).show();
                    });
                }
                showPage(1);
                ///** Cần truyền giá trị vào đây **///
                var totalRows = <%= tong%>; // Tổng số sản phẩm hiển thị
                var btnPage = 5; // Số nút bấm hiển thị di chuyển trang
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
			  
        <div class="card-body">
        <div style="float: right; width: 25%;margin-top: 20px;margin-bottom: 20px;margin-right: 13px;">
        		<%
		  		if(tong!=0){
		  		%> 
                	<input  class="box-search" style="width: 100%;" id="myInput" type="text" placeholder="Search..">
                	</div>
                	<script>
					$(document).ready(function(){
					  $("#myInput").on("keyup", function() {
					    var value = $(this).val().toLowerCase();
					    $("#tableshowclass tr").filter(function() {
					      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
					    });
					  });
					});
					</script>
				  <%
				  }
				  %> 
          <div class="table-responsive" style="padding-left: 13px;padding-right: 13px;padding-top: 18px;">        	<form  class="formTable" action=""  method="post">
        	
	        	<table style="" id="myTable"  class="myTable table table-bordered table-hover table-compact" width="100%">
		  		<%
		  		if(tong!=0){
		
		  		%> 
		  		  <thead>
				  <tr >
				    <th style="text-align: center; vertical-align: middle;">No.</th>
				    <th style="text-align: center; vertical-align: middle;" >Name</th>
				    <th style="text-align: center; vertical-align: middle;" >Time</th>
				    <th style="text-align: center; vertical-align: middle;">Day Of Week</th>
				    <th style="text-align: center; vertical-align: middle;">Duration (hours)</th>
				    <th style="text-align: center; vertical-align: middle;">Trainer</th>
				    <th style="text-align: center; vertical-align: middle;" >Action</th>
				  </tr>
                  <thead>
				  
				  <%
				  }
				  %> 
				  <tbody id ="tableshowclass">
				  
				  
				  <%
				  int count=0;
				  for (ClassWaiting classOpening : listClassOpening) {
					  count++;
				  
				  %>
				   <tr class="contentPage" >
				    <td class="no" style="text-align: center; vertical-align: middle;"><%= count %></td>
				    <td class="name"><%= classOpening.getClassName() %></td>
				    <td class="time"><%= classOpening.getTimeOfDate() %></td>
				    <td class="date"><%= classOpening.getDateOfWeek() %></td>
				    <td class="duration" style="text-align: center; vertical-align: middle;" ><%= classOpening.getDuration()%></td>
				    <td class="trainer"><%= classOpening.getTrainerName() %></td>
				    
				    
				    <%
				    
				    
				    %>
				    <td  style="text-align: center; vertical-align: middle;" class="btnRegister" >
						<button  type="button" name="cancel" class = "btn  cancel" style="border-color: #2e9ade; border-color: #e7c6c9;
background-color: #c82333; " id="<%= classOpening.getClassId() %>" >Cancel</button>		
					</td>
				    
				  </tr>
				  <%
					  
				  }
				  %>
				 </tbody>
				</table>
				<div id="pager">
					<ul id="pagination" class="pagination-sm"></ul>
				</div>
		  	</div>
   		</div> 
    
          
	</div>
</div>
</div>
     <script type="text/javascript">
     	$(document).ready(function(){
	   $(document).on('click','.cancel',function(){  
			 var classWaiting_id = $(this).attr("id");
			 cancelClass(classWaiting_id);
		});
		function cancelClass(classOpening_id)
		{	if (confirm('Are you sure you want to cancel this?')) {
			$.ajax({
				url: '/managementSystem/trainee/cancelClass?classOpening_id=' + classOpening_id,
				type : 'POST',
				success:function(result)
				{	
					document.getElementById("tableshowclass").innerHTML = "";
					$('#tableshowclass').html(result);					 
				}
			});
		}
			
		}
		
	});
</script>
<div id="post_modal_noti" class ="modal fade">
		<div class = "modal-dialog">
		<div style="margin:auto;margin-top:60%;" class="modal-content"  id = "post_detail_noti">
		</div>
		
	</div>
</div>
<%@include file="/templates/inc/footer.jsp" %>