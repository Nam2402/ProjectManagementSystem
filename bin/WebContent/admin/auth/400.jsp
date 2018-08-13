<%@page import="model.bean.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Bootcamp management system</title>
		<link rel="stylesheet"  type="text/css" href="<%= request.getContextPath()%>/templates/css/bootstrap.min.css">
		<link href="<%= request.getContextPath()%>/templates/css/style.css" type="text/css" rel="stylesheet" />
<link rel="shortcut icon" href="<%= request.getContextPath()%>/templates/public/images/logo.png" type="image/x-icon" />
	</head>
	<body>
		<div class="container">
			<div class="wrapper">
				<form action="" method="post" name="Login_Form" id="add-post" class="form-signin">
				    <h2 class="form-signin-heading" style="color: blue;">BAD REQUEST</h2>
					<h4 style="display: inline-block">You can't visit that page. Please return to home page: 
					<%
					User user = (User) session.getAttribute("user");
					if (user.getRoleId() == 1) {
					%>
					<a href="<%= request.getContextPath()%>/trainer/edit?id=<%= user.getUserId()%>">Home Page</a>
					<%
					} else {
					%>
					<a href="<%= request.getContextPath()%>/trainee/edit?id=<%= user.getUserId()%>">Home Page</a>
					<%
					}
					%>
					</h4>
				</form>
			</div>
		</div>
		<div class="myslides" style="margin-left: 30%">
		<img alt="Enclave Logo" src="<%= request.getContextPath()%>/templates/images/enclave_logo.png" style="width: 50%">
		</div>
		
		<script type="text/javascript">
			var slideIndex = 0;
			showSlides();
			function showSlides() {
				var slides = document.getElementsByClassName("myslides");

				//cho cáº£ 3 áº£nh k hiá»ƒn thá»‹
				for (var i = 0; i < slides.length; i++) {
					slides[i].style.display = "none";
				}
				//trá» Ä‘áº¿n pt slide tiáº¿p theo
				slideIndex++;
				//nÃªu háº¿t rá»“i thÃ¬ quay láº¡i 1
				if (slideIndex > slides.length) {
					slideIndex = 1;
				}
				//cho slide táº¡i vá»‹ trÃ­ Ä‘ang set hiá»ƒn thá»‹
				slides[slideIndex - 1].style.display = "block";
				setTimeout(showSlides, 5000);
			}
			
			});
		</script>
	</body>
</html>
