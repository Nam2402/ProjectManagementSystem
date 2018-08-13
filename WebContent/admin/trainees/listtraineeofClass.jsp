<%@page import="model.bean.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import ="model.bean.Classes"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/templates/inc/dashboard.jsp" %>  

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

<%
ArrayList<User> listUser = (ArrayList<User>) request.getAttribute("listUser");
int tong = listUser.size();
%>
<div class="<%= classNameContent%>" <%= styleContent%>>
  <div class="<%= classNameContainer%>">
    <div class="card1 card mb-3" style="box-shadow: 0 2px 5px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12); margin-left: 0px;margin-right:7px;">
      
		<div class="alert1"   style="padding-left: 10px;font-size: larger;margin-bottom: 20px;margin-top: 25px;"> 
             <i class="fa1 fa fa-fw fa-book" ></i>
		    <strong  style="font-size: 21px;" class="lb_name">Trainee</strong>
		 </div>
			  
  <div style="background: white;">
        <script type="text/javascript">
            $(document).ready(function(){
                $(document).on('change', '.checkall, .checkitem', function(){
                    var $_this = $(this);
                    document.getElementById("deleteall").style.display = "block";
                    if($_this.hasClass('checkall')){
                        $('.checkitem').prop('checked', $_this.prop('checked'));
                    }else{
                        var $_checkedall = true;
                        $('.checkitem').each(function(){
                            if(!$(this).is(':checked')){
                                $_checkedall = false;
                            }
                            $('.checkall').prop('checked', $_checkedall);
                        });
                    }
                    var $_uncheckedall = true;
                    $('.checkitem').each(function(){
                        if($(this).is(':checked')){
                            $_uncheckedall = false;
                        }
                        if($_uncheckedall){
                            document.getElementById("deleteall").style.display = "none";
                        }else{
                            document.getElementById("deleteall").style.display = "block";
                        }
                    });
                });
            });
        </script>
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
                	<input  class="box-search" style="width: 100%;" id="myInput" type="text" placeholder="Search..">
                	</div>
                	<script>
					$(document).ready(function(){
					  $("#myInput").on("keyup", function() {
					    var value = $(this).val().toLowerCase();
					    $("#listtrainees tr").filter(function() {
					      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
					    });
					  });
					});
					</script>
			<div class="table-responsive" style="padding-left: 13px;padding-right: 13px;padding-top: 18px;">            <form action=""  method="post">
            <form action=""  method="post">
                <input style="display: none; margin-left: 10px; margin-bottom: 10px; color: red" id="deleteall" type="submit" value="Delete">
                <table class="table table-bordered" width="100%" id="dataTable" cellspacing="0">
                  <thead>
                    <tr>
                       <th style="text-align: center;" width="5%" >No.</th>
                       <th style="text-align: center;" width="20%">Username  </th>
                      <th style="text-align: center;" width="20%">Full name  </th>
                      <th style="text-align: center;" width="20%">Email </th>
                      <th style="text-align: center;" width="20%">Phone  </th>
                      
                      
                    </tr>
                  </thead>
                  <tbody id="listtrainees">
                  <%
                
                  	

                  	int i=0;
                  	for (User trainee : listUser){
                  		i+=1;
                  %>
                  
                  <tr class="contentPage"  >
                  <td style="text-align: center;" ><%= i %></td>
                  <td ><%= trainee.getUsername()%></td>
                  
                  <td  ><%= trainee.getFullname() %></td>
                  <td  ><%= trainee.getEmail() %></td>
            
                  <td ><%= trainee.getPhone() %></td>
                 </tr>
                  <%
                  	}
                  		
                  
                  %>
                  </tbody>
                  
                </table>
                <div id="pager">
					<ul id="pagination" class="pagination-sm"></ul>
				</div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
  </div>
<%@include file="/templates/inc/footer.jsp" %>