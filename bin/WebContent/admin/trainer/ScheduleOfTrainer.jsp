<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="model.bean.Rooms"%>
<%@page import="model.bean.User"%>
<%@page import="model.bean.Schedule"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/templates/inc/dashboard.jsp" %>  
<style>
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
  	
  	String  success = "";
	if((session.getAttribute("success"))!=null){
		success = (String)session.getAttribute("success") ;
	}else{
		
	}
   	ArrayList<Schedule> schedule = (ArrayList<Schedule>) request.getAttribute("schedule");
  	int user_id = Integer.parseInt((String)request.getAttribute("user_id"));
  	
   	int k=0;
   	String dayOfWeek2="";
   	int tong = schedule.size();
   	int classid_choose=0;
   	User ur = (User) request.getAttribute("ur");
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
    <div class="card mb-3">
         <div class="alert alert-primary"  style="font-size: larger;margin-bottom: 0px;"> 
             <i class="fa fa-fw fa-book" ></i>
			    <strong><%=ur.getUsername()%>'s schedule</strong>
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
        <script type="text/javascript">
        
        
     
   
        
        function open1234(classaction) {
        	var class_id = classaction.id;
        	var dayinstead= $('input[name="dayinstead"]:checked').val();
			$.ajax({
	              type : 'POST', 
	              url : '/managementSystem/trainer/RequestTakeDayOf?class_id='+class_id+"&dayinstead="+dayinstead, 
	              success : function(result)  
	                        { 
	            				$('.selectTime').html(result);
	                        }
	              });
		}
        	function handleClick() {
       		 	var dayinstead= $('input[name="dayinstead"]:checked').val();
			$.ajax({
		          type : 'POST', 
	              url : '/managementSystem/trainer/RequestTakeDayOf?dayinstead='+dayinstead, 
	              success : function(result)  
	                        { 
	            				$('.selectTime').html(result);
	                        }
	              });
		}
        function myCheckRoom(select) {
        	var selectId = select.id;
        	
			var x = document.getElementById(selectId).value;
			var dayinstead= $('input[name="dayinstead"]:checked').val();
			$.ajax({
	              type : 'GET', 
	              url : '/managementSystem/trainer/GetRoomFreeController?time='+x+"&dayinstead="+dayinstead, 
	              success : function(result)  
	                        { 
	            	  
	            				$('.selectRoom').html(result);
	                        }
	              });
		}
            $(function () {
                var pageSize = 10; // HiÃ¡Â»Æ’n thÃ¡Â»â€¹ 6 sÃ¡ÂºÂ£n phÃ¡ÂºÂ©m trÃƒÂªn 1 trang
                showPage = function (page) {
                    $(".contentPage").hide();
                    $(".contentPage").each(function (n) {
                        if (n >= pageSize * (page - 1) && n < pageSize * page)
                            $(this).show();
                    });
                }
                showPage(1);
                var totalRows = <%= tong %>; // TÃ¡Â»â€¢ng sÃ¡Â»â€˜ sÃ¡ÂºÂ£n phÃ¡ÂºÂ©m hiÃ¡Â»Æ’n thÃ¡Â»â€¹
                var btnPage = 5; // SÃ¡Â»â€˜ nÃƒÂºt bÃ¡ÂºÂ¥m hiÃ¡Â»Æ’n thÃ¡Â»â€¹ di chuyÃ¡Â»Æ’n trang
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
        	if(success.equals("1")){
        		%>
        		<div class="alert alert-success">
        		<strong>Send the request successfully!</strong>
        		</div>
        		<% 
        		request.getSession().removeAttribute("success"); 
        	}else{
        		
        	}
        %>   
        <div class="card-body">
        
          <div class="table-responsive">
          
                <input style="display: none; margin-left: 10px; margin-bottom: 10px; color: red" id="deleteall" type="submit" value="Delete">
                <table id="myTable" class="table table-bordered" width="100%"  cellspacing="0">
                  <thead>
                    <tr>
                      <th style="text-align: center;">No.</th>
                      <th style="text-align: center;">Class</th>
                       <th style="text-align: center;">Room</th>
                      <th style="text-align: center;">Course</th>
                      <th style="text-align: center;">Time</th>
                      <th style="text-align: center;">Date Of Week</th>
                      <th style="text-align: center;">Taught Hours</th>
                      <th style="text-align: center;">Duration (Hours)</th>
                      <th style="text-align: center;">Action</th>
                    </tr>
                  </thead>
                  <tbody>
                  
                  	<%
                  	String FORMAT = "EEE,d MMM yyyy";
		          	DateFormat formater = new SimpleDateFormat(FORMAT);
		          	Date date = new Date();
		        	String s1 = formater.format(date);
		        	String s2[] = s1.split(",");
		        	String s3 ="";
		        	String arr1[] = s2[1].split(" ");
		        	switch(s2[0]){
            		 
            		 case "Mon":
            		 {
            			 s3+="2";
            			 break;
            		 }
            		 case "Tue":
            		 {
            			 s3+="3";
            			break;
            		 }
            		 case "Wed":
            		 {
            			 s3+="4";
            			break;
            		 }
            		case "Thu":
            		 {
            			 s3+="5";
            			break;
            		 }
            		case "Fri":
            		 {
            			 s3+="6";
            			break;
            		 }
            		case "Sat":
            		 {
            			 s3+="7";
            			break;
            		 }
            		case "Sun":
            		 {
            			 s3+="8";
            			break;
            		 }
            	    default:
            	    {
            	        
            	    }
            		 }
                  	for (Schedule list : schedule){
                  		k+=1;
                  		String s="";
                  	 	String str=list.getDateOfWeek();
                  	 	String arr[]=str.split(",");
	                  	 for(int i=0; i<arr.length;i++){
	                  		if(i==(arr.length-1)){
	               			 s+=" and ";
	               		 }
	                 		 switch(arr[i]){
	                 		 
	                 		 case "2":
	                 		 {
	                 			 s+="Mon";
	                 			 break;
	                 		 }
	                 		 case "3":
	                 		 {
	                 			 s+="Tue";
	                 			break;
	                 		 }
	                 		 case "4":
	                 		 {
	                 			 s+="Wed";
	                 			break;
	                 		 }
	                 		case "5":
	                 		 {
	                 			 s+="Thu";
	                 			break;
	                 		 }
	                 		case "6":
	                 		 {
	                 			 s+="Fri";
	                 			break;
	                 		 }
	                 		case "7":
	                 		 {
	                 			 s+="Sat";
	                 			break;
	                 		 }
	                 		case "8":
	                 		 {
	                 			 s+="Sun";
	                 			break;
	                 		 }
	                 	    default:
	                 	    {
	                 	        
	                 	    }
	                 		 }
	                 		 if (i< (arr.length-2)) {
	                 			 s+=", ";
	                 		 }
	                 		if (i == (arr.length-1)) {
	                			 s+="";
	                		 }
                  	 	}
                  %>
				   <tr class="contentPage">
                  <td style="text-align: center; vertical-align: middle;"><%= k %></td>
                  <td  style="text-align: center; vertical-align: middle;"><%= list.getNameclass()%></td>
                   <td style="text-align: center; vertical-align: middle;"><%= list.getNameroom()%></td>
                   <td style=" vertical-align: middle;"><%= list.getCourse()%></td>
                   <td style="text-align: center; vertical-align: middle;"><%= list.getTimeOfDate()%></td>
                   <td style="text-align: center; vertical-align: middle;"><%= s%></td>
                   <td style="text-align: center; vertical-align: middle;"><%= list.getCountLession()%></td>
                   <td style="text-align: center; vertical-align: middle;"><%= list.getDuration() %></td>
                    <td style="text-align: center; vertical-align: middle;"> <a href="/managementSystem/trainer/list?class_id=<%= list.getClassid() %>&name=<%= list.getNameclass()%>" class="fa fa-list" style="text-align: center; vertical-align: middle;font-size:20px; text-decoration: none;"></a>
                   <button  type="button" class="btn btn-link"  style="text-align: center; vertical-align: middle; font-size: 20px" data-toggle="modal" data-target="#myModal<%=k%>"><i class="fa fa-paper-plane" aria-hidden="true"></i>
                   </button>
                   
                   <div class="modal fade" id="myModal<%=k %>" role="dialog" style="text-align: center;">
						    <div class="modal-dialog " style="text-align: center;">
						      <div class="modal-content">
						        <div class="modal-header; alert alert-primary">
						          <button type="button" class="close" data-dismiss="modal">&times;</button>
						          <h4 class="modal-title">Requesting a day off for <%= list.getNameclass()%></h4>
						        </div>
						        <form name="myForm" action="/managementSystem/trainer/SendNotiTakedayoffToAdminController" method="post">
						        <div class="modal-body">
						          <table  border="0px" style="width: 465px">

						          <tr>
						          <th>Day off</th>
						          <td >
						          			<%
						          		String []dayoff={"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
						          		for(int j=0; j<arr.length; j++){
						          		String b = arr[j];
						          		int b1 =Integer.parseInt((String)b);
						          		int s4 =Integer.parseInt((String)s3);
						          		if(b1==s4){
						          		%>
										  <input style="  float: left;" type="radio" name="dayoff" value="<%=s2[0]+", "+s2[1] %>"><span style="margin-right: 120px"><%=s2[0]+", "+s2[1] %></span> <br>
										  <% 
										 } else {
											 if(b1>s4){
												 int kq = b1-s4;
												 int day =Integer.parseInt((String)arr1[0]);
												 day = day + kq;
												 if(day>31){
													 day = day-31;
													 String dayOfWeek ="";
													 String day1 =  String.valueOf(day);
													
													 for(int c = 0; c<dayoff.length; c++){
														 if(s2[0].equals(dayoff[c])){
															  dayOfWeek = dayoff[c+kq];
														 }
													 }
													 day1=dayOfWeek +", "+ day1 +" Aug " +arr1[2];
													 %>
													  <input style="float: left;" type="radio" name="dayoff" value="<%=day1 %>"> <span style="margin-right: 120px"><%=day1 %></span><br>
													  <%
												 }else{
													 String dayOfWeek ="";
													 String day1 =  String.valueOf(day);
													
													 for(int c = 0; c<dayoff.length; c++){
														 if(s2[0].equals(dayoff[c])){
															  dayOfWeek = dayoff[c+kq];
														 }
													 }
													 day1=dayOfWeek +", "+ day1 +" " +arr1[1] +" " +arr1[2];
													 %>
													  <input style="float: left;" type="radio" name="dayoff" value="<%=day1 %>"> <span style="margin-right: 120px"><%=day1 %></span><br>
													  <%
												 }
												
												 
											 }else {
													 int kq = b1 - s4;
													 int kq1 = kq +7;
													 int day =Integer.parseInt((String)arr1[0]);
													 day = day + kq1;
													 if(day>31){
														 day = day-31;
														 String dayOfWeek ="";
														 String day1 =  String.valueOf(day);
														
														 for(int c = 0; c<dayoff.length; c++){
															 if(s2[0].equals(dayoff[c])){
																  dayOfWeek = dayoff[c+kq];
															 }
														 }
														 day1=dayOfWeek +", "+ day1 +" Aug " +arr1[2];
														 %>
													  <input style="float: left;" type="radio" name="dayoff" value="<%=day1 %>"><span style="margin-right: 120px"> <%=day1 %></span><br>
													  <%
													 }else{
														 String dayOfWeek ="";
														 String day1 =  String.valueOf(day);
														
														 for(int c = 0; c<dayoff.length; c++){
															 if(s2[0].equals(dayoff[c])){
																  dayOfWeek = dayoff[c+kq];
															 }
														 }
														 day1=dayOfWeek +", "+ day1 +" " +arr1[1] +" " +arr1[2];
														 %>
														  <input style="float: left;" type="radio" name="dayoff" value="<%=day1 %>"><span style="margin-right: 120px"> <%=day1 %></span><br>
														  <%
													 }
													 
													 
											 }
										 }
						          		%>
										
						          		<% 
						          	}
						          %>
						          </td>
						           <input type="hidden" class="class_id"  name="classId" value="<%=list.getClassid()%>" id="classId<%= list.getClassid()%>">
						            <input type="hidden" name="userId" value="<%=user_id%>" ">
						             <input type="hidden" name="classname" value="<%=list.getNameclass()%>" ">
						          
						          </tr>
						          
						          <tr>
						          <th>Day instead</th>
						          <td>
						         
						          	<%
						          	String []dayoff2={"2", "3", "4", "5", "6", "7", "8"};
						          	String []dayoff3={"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
						          	for(int t=0; t<dayoff2.length; t++){
						          		String c = dayoff2[t];
						          		int c1 =Integer.parseInt((String)c);
						          		int s5 =Integer.parseInt((String)s3);
						          		
						          		if(c1==s5){
						          			dayOfWeek2 = s2[0];
						          			%>
											  <input style="float: left;" type="radio" name="dayinstead"  onclick="handleClick(this);" value="<%=s2[0]+", "+s2[1] %>-<%=list.getClassid()%>"> <span style="margin-right: 120px"><%=s2[0]+", "+s2[1] %></span><br>
											  <% 
						          		}else {
											 if(c1>s5){
												 int kq = c1-s5;
												 int day2 =Integer.parseInt((String)arr1[0]);
												 day2 = day2 + kq;
												 if(day2>31){
													 day2 = day2 -31;
													 dayOfWeek2 ="";
													 String day3 =  String.valueOf(day2);
													
													 for(int d = 0; d<dayoff3.length; d++){
														 if(s2[0].equals(dayoff3[d])){
															  dayOfWeek2 = dayoff3[d+kq];
														 }
													 }
													 day3=dayOfWeek2 +", "+ day3 +" Aug " +arr1[2];
													 %>
													  <input style="float: left; " type="radio" name="dayinstead" onclick="handleClick(this);" value="<%=day3 %>-<%=list.getClassid()%>""><span style="margin-right: 120px"> <%=day3 %></span><br>
													  <%
												 }else {
													 dayOfWeek2 ="";
													 String day3 =  String.valueOf(day2);
													
													 for(int d = 0; d<dayoff3.length; d++){
														 if(s2[0].equals(dayoff3[d])){
															  dayOfWeek2 = dayoff3[d+kq];
														 }
													 }
													 day3=dayOfWeek2 +", "+ day3 +" " +arr1[1] +" " +arr1[2];
													 %>
													  <input style="float: left; " type="radio" name="dayinstead" onclick="handleClick(this);" value="<%=day3 %>-<%=list.getClassid()%>""><span style="margin-right: 120px"> <%=day3 %></span><br>
													  <%
												 }
												 
											 }else {
													 int kq = c1 -s5;
													 int kq1 = kq +7;
													 int day2 =Integer.parseInt((String)arr1[0]);
													 day2 = day2 + kq1;
													 if(day2 > 31){
														 day2 = day2 -31;
														 dayOfWeek2 ="";
														 String day3 =  String.valueOf(day2);
														
														 for(int d = 0; d<dayoff3.length; d++){
															 if(s2[0].equals(dayoff3[d])){
																  dayOfWeek2 = dayoff3[d+kq];
															 }
														 }
														 day3=dayOfWeek2 +", "+ day3 +" Aug " +arr1[2];
														 %>
														  <input style="float: left; " type="radio" name="dayinstead"  onclick="handleClick(this);" value="<%=day3 %>-<%=list.getClassid()%>""> <span style="margin-right: 120px"><%=day3 %></span><br>
														  <%
													 }else {
														 dayOfWeek2 ="";
														 String day3 =  String.valueOf(day2);
														
														 for(int d = 0; d<dayoff3.length; d++){
															 if(s2[0].equals(dayoff3[d])){
																  dayOfWeek2 = dayoff3[d+kq];
															 }
														 }
														 day3=dayOfWeek2 +", "+ day3 +" " +arr1[1] +" " +arr1[2];
														 %>
														  <input style="float: left; " type="radio" name="dayinstead"  onclick="handleClick(this);" value="<%=day3 %>-<%=list.getClassid()%>""> <span style="margin-right: 120px"><%=day3 %></span><br>
														  <%
													 }
													
											 }
						          		}
						          	%>
									  
								
									<%
									}
									%>
									</td>
						          </tr>
	 					         
	 					         <label id="choiceLabel"></label>
	 					         
						          <tr>
						          <th>Time</th>
						          <td>
						          <select  class="selectTime" name="time" id = "Select<%= list.getClassid() %>" onchange="myCheckRoom(this)" style="float: left;width:145px" >
									  
									</select>
						          </td>
						          </tr>
						          <tr>
						          <th>Room</th>
						          <td>
						          	 <select  class="selectRoom" name="room" style="float: left;width:145px ">
						          	  <%
						          	%>	
						          <%
						          %>
						          </select> 
						          </td>
						          </tr>
						          <tr>
						          <th>Content</th>
						          <td ><textarea name="content" style=" resize: none;" rows="3" cols="35"></textarea></td>
						          </tr>
						          </table>
						        </div>
						        <div class="modal-footer">
						         <button type="submit" class="btn btn-default; btn btn-primary" style="font-size: 16px; width:80px;" >Submit</button>
						          <button type="button" class="btn btn-default;" data-dismiss="modal" style="font-size: 16px; width:80px;margin-right: 30px" >Close</button>

						        </div>
						        </form>
						      </div>
						    </div>
						  </div>

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
        <div class="card-footer small text-muted">
          Updated yesterday at 11:59 PM
        </div>
      </div>
    </div>
  </div>
  </div>

<%@include file="/templates/inc/footer.jsp" %> 