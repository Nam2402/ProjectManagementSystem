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
	#pagination {
                display: flex;
                display: -webkit-flex; /* Safari 8 */
                flex-wrap: wrap;
                -webkit-flex-wrap: wrap; /* Safari 8 */
                justify-content: center;
                -webkit-justify-content: center;
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
        <div class="card mb-3 divForm">
       		<div class="alert alert-primary" style="font-size:  larger; margin-bottom: 0px;"> 
             <i class="fa fa-fw fa-user" ></i>
             <strong>Waiting Class </strong>
			  </div>
			  <div>
			<%
			  ArrayList<ClassWaiting> listClassOpening = (ArrayList<ClassWaiting>)request.getAttribute("list");
			  int tong = listClassOpening.size();
			  if (tong==0){
					 %>
					 <div class="alert alert-danger">
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
			  
		  	<div class="form">
		  		<table >
		  		<%
		  		if(tong!=0){
		
		  		%>
				  <tr >
				    <th>No.</th>
				    <th>Name</th>
				    <th>Time</th>
				    <th>Day Of Week</th>
				    <th>Duration (hours)</th>
				    <th>Trainer</th>
				    <th>Action</th>
				  </tr>
				  
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
				    <td class="no"><%= count %></td>
				    <td class="name"><%= classOpening.getClassName() %></td>
				    <td class="time"><%= classOpening.getTimeOfDate() %></td>
				    <td class="date"><%= classOpening.getDateOfWeek() %></td>
				    <td class="duration"><%= classOpening.getDuration()%></td>
				    <td class="trainer"><%= classOpening.getTrainerName() %></td>
				    
				    
				    <%
				    
				    
				    %>
				    <td class="btnRegister" >
						<button  type="button" name="cancel" class = "btn btn-danger cancel" style="border-color: #2e9ade; border-color: #e7c6c9;
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
     
              
        <div style="clear: both"></div>
        <div class="error" ></div>
        <div style="margin-bottom: 10%"></div>
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