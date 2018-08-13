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
<div class="<%= classNameContent%>" <%= styleContent%>>
  <div class="<%= classNameContainer%>">
    <div class="card mb-3">
        <div class=" alert alert-primary"style="font-size: larger;margin-bottom: 0px;"> 
             <i class="fa fa-fw fa-book" ></i>
          	<strong>Trainees</strong>
			  </div>
			  
			  <div>
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
        <div class="card-body">
          <div class="table-responsive">
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
                  <tbody>
                  <%
                
                  	ArrayList<User> listUser = (ArrayList<User>) request.getAttribute("listUser");
                  	int i=0;
                  	for (User trainee : listUser){
                  		i+=1;
                  %>
                  
                  <tr>
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