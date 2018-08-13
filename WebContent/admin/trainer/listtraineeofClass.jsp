<%@page import="model.bean.Accessment"%>
<%@page import="model.bean.Results"%>
<%@page import="model.bean.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import ="model.bean.Classes"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/templates/inc/dashboard.jsp" %> 
<style>
           
           
           /*  .card mb-3 {
            box-shadow: 0 2px 5px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12);
			margin-left: -12px; 
            } */
          
        </style>
  <script type="text/javascript">
  function abc(a) {
	  var val = $(a).val();
	  alert(val);
	    if (val === '1') {
	        $(a).prop("disabled", false);
	    }
	    else {
	        $(a).prop("disabled", true);
	    }
	}
  </script>
    	<%
    		String name= (String)request.getAttribute("name");
    		int id = Integer.parseInt((String)request.getAttribute("id"));
    	 	int  result = Integer.parseInt((String)request.getAttribute("assessment"));
    	 	int  check = Integer.parseInt((String)request.getAttribute("check"));
    	%>
    	<%
    		ArrayList<Accessment> listUser;
             if(check ==1){
            	 System.out.print("result");
            	  listUser = (ArrayList<Accessment>) request.getAttribute("listResult");
             } else {
            	 System.out.print("users");
            	  listUser = (ArrayList<Accessment>) request.getAttribute("listUser");
             }
    	int tong = listUser.size();
    		
    	%>
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
    <div class="card1 card mb-3" style="box-shadow: 0 2px 5px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12); margin-left: 0px;margin-right:7px;" >
         <div class="alert1 "  style="padding-left: 10px;font-size: larger;margin-bottom: 20px;margin-top: 25px;"> 
             <i class="fa1 fa fa-fw fa-users" ></i>
			    <strong style="font-size: 21px;">&nbsp;<%= name %></strong>
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
                var pageSize = 10; // Hiá»ƒn thá»‹ 6 sáº£n pháº©m trÃªn 1 trang
                showPage = function (page) {
                    $(".contentPage").hide();
                    $(".contentPage").each(function (n) {
                        if (n >= pageSize * (page - 1) && n < pageSize * page)
                            $(this).show();
                    });
                }
                showPage(1);
                var totalRows = <%=tong%>; // Tá»•ng sá»‘ sáº£n pháº©m hiá»ƒn thá»‹
                var btnPage = 5; // Sá»‘ nÃºt báº¥m hiá»ƒn thá»‹ di chuyá»ƒn trang
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

        <% 
                  if(result==1){
                	  if(check == 1){
                		  %>

                		  <div class="alert alert-success" style="padding-left: 13px; margin-top: 10px;">
                		  <Strong>You finished trainee evaluation.</Strong>
                		  </div>
                		  <% 
                  } 
                  }else{
                	  %>
                	  <div class="alert alert-danger" style="padding-left: 13px; margin-top: 10px;">

                	  <strong>This class has not finished yet, you can not evaluate.</strong>
                	  </div>
                 <% 
                 
                  }
                  %>
        <div class="card-body">
        <div style="float: right; width: 25%;margin-top: 10px;margin-bottom: 20px;margin-right: 13px;">
                	<input  class="box-search" style="width: 100%;" id="myInput" type="text" placeholder="Search..">
                	</div>
                	<script>
					$(document).ready(function(){
					  $("#myInput").on("keyup", function() {
					    var value = $(this).val().toLowerCase();
					    $("#myTBody tr").filter(function() {
					      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
					    });
					  });
					});
					</script>
        
          <div class="table-responsive" style="padding-left: 13px;padding-right: 13px;padding-top: 18px;">
            <form action="/managementSystem/trainer/list"  method="post">
                <input style="display: none; margin-left: 10px; margin-bottom: 10px; color: red" id="deleteall" type="submit" value="Delete">
               <input type="text" name="class_id" value="<%=id %>" style="display: none;" >
                <table style="border-collapse: collapse;" id="myTable" class="myTable table table-bordered table-hover table-compact" width="100%" id="dataTable" >
                  <thead>
                    <tr>
                       <th style="text-align: center; vertical-align: middle;">No.</th>
                       <th style="text-align: center; vertical-align: middle;">User Name </th>
                      <th  style="text-align: center; vertical-align: middle;">Full Name  </th>
                      <th style="text-align: center; vertical-align: middle;">Email</th>
                      <th style="text-align: center; vertical-align: middle;">Phone  </th>
                      <th style="text-align: center; vertical-align: middle;">Assessment  </th>
                    </tr>
                  </thead>
                  <tbody id="myTBody">
                  <%
                  	int i=0;
                  System.out.print(listUser.size());
                  	for (Accessment trainer : listUser){
                  		
                  		i+=1;
                  %>
                  
                  <tr class="contentPage">
                  <td style="text-align: center; vertical-align: middle;"><%= i %></td>
                  <td style=" vertical-align: middle;"><%= trainer.getUsername() %></td>
                  <td style=" vertical-align: middle;"><%= trainer.getFullname() %></td>
            	  <td style=" vertical-align: middle;"><%= trainer.getEmail() %></td>
                  <td style="text-align: center; vertical-align: middle;"><%= trainer.getPhone() %></td>
                  <input type="text" name="user_id" value="<%=trainer.getUserid() %>" style="display: none;" >
                  <% 
                  if(result==1){
                	 if(check == 1){ 
                		  String nameradio = "trainee" + String.valueOf(trainer.getUserid());
                		  					if(trainer.getStatus()==1){
                		  						%>
                		  						<td style="text-align: center;">
                		  						<input type="radio" id="a-<%=trainer.getUserid() %>" name="<%= nameradio %>" checked="checked"  value="<%=trainer.getStatus() %>"  disabled="disabled"> Pass
          											  <input type="radio" id="b-<%=trainer.getUserid() %>" name="<%= nameradio %>"   value="<%=trainer.getStatus()%>"  disabled="disabled"> Fail 
											 </td>
											 <% 
											 } else {
												 %>
												 <td style="text-align: center;">
	                		  						<input type="radio" id="a-<%=trainer.getUserid() %>" name="<%= nameradio %>"   value="<%=trainer.getStatus() %>"  disabled="disabled"> Pass
	          											  <input type="radio" id="b-<%=trainer.getUserid() %>" name="<%= nameradio %>" checked="checked"  value="<%=trainer.getStatus()%>"  disabled="disabled"> Fail 
												  </td>
												 <% 
											 }
                                    		%>	
						                	 <%
                                    		
                                    	
                                    %>
                	 <%
                	    } else {
                		  String nameradio = "trainee" + String.valueOf(trainer.getUserid()); 
                          
                          %>
       				  <td style="text-align: center;">
					  <input type="radio" id="a-<%=trainer.getUserid() %>" name="<%= nameradio %>" value="1" > Pass
					  <input type="radio" id="b-<%=trainer.getUserid() %>" name="<%= nameradio %>" value="0" checked="checked" > Fail
      	 				</td> 
      	 			 	<%
                	  }  
                  } else{
                	  %>
                	  <td style="text-align: center;">
					  <input type="radio" name="" value="1" disabled="disabled"> Pass
					  <input type="radio" name="" value="0" disabled="disabled"> Fail
				  </td>
                 <% 
                  }%>
                  
                  </tr>
                  <%
                  
                  	}
                  %>
                  
                  </tbody>
                  
                </table>
                <%
                	if(result==1){
                		if(check==1){
                			%>
                			
                			<% 
                		} else {
                			%>
                			 <button type="submit" class="btn btn-primary" style="float: right;"><strong>Save</strong></button>
                			<%
                		}
                	} else {
                		
                	}
                %>
                
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