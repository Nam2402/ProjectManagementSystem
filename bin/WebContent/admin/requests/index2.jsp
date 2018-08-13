
<%@page import="model.bean.RequestTakDayOff"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/templates/inc/dashboard.jsp" %>  
<link rel="stylesheet" href="<%=request.getContextPath()%>/templates/css/styleIndexTrainee.css">
<style>
            #pagination {
                display: flex;
                display: -webkit-flex; 
                flex-wrap: wrap;
                -webkit-flex-wrap: wrap; 
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
<div class="<%= classNameContent%>" <%= styleContent%> id="toggler_contentId">
  <div class="<%= classNameContainer%>" id="toggler_containerId">
    <div  class="card mb-3" >
             <div class="alert alert-primary" style="font-size:  larger; margin-bottom: 5px;"> 
             <i class="fa fa-paper-plane" ></i>
			    <strong class="namePage">Requests List </strong>
			  </div>
        <div>
		<%
	
		 
		 ArrayList<RequestTakDayOff> listRequests = new ArrayList<RequestTakDayOff>();
			int total = 0;
			if (request.getAttribute("listRequests") != null) {
				listRequests = (ArrayList<RequestTakDayOff>) request.getAttribute("listRequests");
			 	total = listRequests.size();
					 
			}		 
			if (total ==0){
				 %>
				 <div class="alert alert-danger">
	    	<strong> No Request </strong>
		  		</div>
				 <% 
			  }
			%>
		
        
        <script type="text/javascript">
            $(function () {
                var pageSize = 5; // Hiển thị 10 sản phẩm trên 1 trang
                showPage = function (page) {
                    $(".contentPage").hide();
                    $(".contentPage").each(function (n) {
                        if (n >= pageSize * (page - 1) && n < pageSize * page)
                            $(this).show();
                    });
                }
                showPage(1);
                ///** Cần truyền giá trị vào đây **///
                var totalRows = <%= total%>; // Tổng số sản phẩm hiển thị
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
          <div class="table-responsive">
            <form action="<%= request.getContextPath()%>/trainee/del"  method="post">
            	<div class="wrapper" style="">
	            	
	            	<div style="float: left; margin-left: 15px;">
	            	<input class="btn btn-danger" style="display: none; margin-left: 10px; margin-bottom: 5px;" onclick="return confirm('Do you want to delete these trainees?')" id="deleteall" type="submit" value="Delete trainees">
                	</div>
                	<div style="clear: both"></div>
	        	</div>
               <table  id="myTable" class="table table-bordered" width="100%" id="dataTable" cellspacing="0">
                <%
               	if(listRequests.size()>0){
               %>
                  <thead>
                    <tr>           
                      <th style="text-align: center; font-size: medium; vertical-align:middle;">No.</th>
                      <th style="text-align: center; font-size: medium; vertical-align:middle;">ClassName</th>
                      <th style="text-align: center; font-size: medium; vertical-align:middle; word-break:normal;">Trainer Name</th>
                      <th style="text-align: center; font-size: medium; vertical-align:middle;">Date Off</th>
                      <th style="text-align: center; font-size: medium; vertical-align:middle;">Date Change</th>
                      <th style="text-align: center; font-size: medium; vertical-align:middle; word-break:normal;">Time Change</th>
                      <th style="text-align: center; font-size: medium; vertical-align:middle; word-break:normal;">Room Change</th>
                      <th style="text-align: center; font-size: medium; vertical-align:middle; word-break:normal;">Action</th>
                    </tr>
                  </thead>
                  <%
                  }
                  %>
                  <tbody >
                   <%
                  	int number=0;
                  	for(RequestTakDayOff requestTakDayOff : listRequests){
                  		number++;
                  		
                  		
                  %>	
                  		<tr class="contentPage">
                  		<td   style=" vertical-align: middle; text-align: center"><%= number %></td>
                      	 <td   style=" vertical-align: middle; "><%= requestTakDayOff.getClass_name() %></td>
	                    <td   style="vertical-align: middle;"><%= requestTakDayOff.getTrainer_name() %></td>
	                    <td   style="vertical-align: middle;"><%= requestTakDayOff.getDate_off()%></td>
	                    <td   style="vertical-align: middle;"><%= requestTakDayOff.getDate_change() %></td>
	                    <td   style=" vertical-align: middle;"><%= requestTakDayOff.getTime_change() %></td>
	                    <td   style="text-align: center; vertical-align: middle;"><%= requestTakDayOff.getRoom_name() %></td>
	                    <%
                    	  if(requestTakDayOff.getStatus()==1){
	                    	%>	
   							<td id="status<%= requestTakDayOff.getRequest_id()%>"    style='text-align: center; vertical-align: middle;'><a  ><i class="fa fa-check" style="font-size:20px; color: #106aef"></i></a></td>		                    <%
	                    } else {
	                    	%>	
 							<td id="status<%= requestTakDayOff.getRequest_id()%>"    style='text-align: center; vertical-align: middle;'><a href="javascript:void(0)" onclick="changeStatus(<%= requestTakDayOff.getRequest_id()%>, 0);" ><i class="fa fa-check" aria-hidden="true" style="font-size:20px; color: #999999"></i></a></td>		                    <%
	                    }
	                    %>
                    	
                    </tr>
                  <%	
                  	}
                  %>
                  </tbody>
                </table>
                
                 <script type="text/javascript">
                function changeStatus(id, status){
            		$.ajax({
            			url: '<%=request.getContextPath()%>/admin/requestTakeDateOff',
            			type: 'POST',
            			cache: false,
            			data: {
            				//Dữ liệu gửi đi
            				request_id: id,
            				status : status
            			},
            			success: function(data){
            				// Xử lý thành công
            				alert("You appored the request!");
            				$('#status' + id).html(data);
            			},
            			error: function (){
            			// Xử lý nếu có lỗi
            				alert('fail');
            			}
            		});
            	}
                </script>
                
                <div id="pager">
					<ul id="pagination" class="pagination-sm"></ul>
				</div>
            </form>
          </div>
        </div>
        <div class="card-footer small text-muted">
          Updated yesterday at 11:59 PM
        </div>
      </div>
    </div>
  </div>
  </div>
<%@include file="/templates/inc/footer.jsp" %> 
