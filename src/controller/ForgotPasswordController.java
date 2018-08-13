package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import libralies.GmailSender;
import libralies.MD5Library;
import model.bean.User;
import model.bo.UserBo;

@WebServlet("/forgotpassword")
public class ForgotPasswordController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserBo userBo= new UserBo();
		
		String email = request.getParameter("id");
		
		 String hashCode= request.getParameter("hashcode");
		 
		 User user= userBo.getUserByEmail(email);
		 
		 if(hashCode.equals(MD5Library.md5(user.getPassword()))){
			 String tempPass= MD5Library.getRandomPwd();
			 user.setPassword(MD5Library.md5(tempPass));
			 if(user.getRoleId() == 1){
					userBo.editTrainee(user);
				}
				else if(user.getRoleId() == 2){
					userBo.editTrainer(user);
				}
			 
			 String subjectEmail = "FORGOT PASSWORD TO LOGIN INTO BOOTCAMP MANAGEMENT SYSTEM.";
				String bodyEmail="<h1> Dear " + user.getUsername() + ",<h1>"
		                + "<h2>Here are the temporary password to login to system: <u>"+tempPass+"</u></h2>"
		                + "<h2>You have to change your password right after login.</h2>";
				try {
					GmailSender.send(email, subjectEmail, bodyEmail, true);
				} catch (MessagingException e) {
					e.printStackTrace();
				}
		 }
		 response.sendRedirect(request.getContextPath()+"/login"); 
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserBo userBo= new UserBo();
		PrintWriter out = response.getWriter();
		String email= request.getParameter("emailForgot");
		User user= userBo.getUserByEmail(email);
		
		if(user.getUserId() != 0){
			String hassCode= MD5Library.md5(user.getPassword());
			
			String subjectEmail = "FORGOT PASSWORD TO LOGIN INTO BOOTCAMP MANAGEMENT SYSTEM.";
			String bodyEmail="<h1> Dear " + user.getUsername() + ",<h1>"
	                +"<h2>We recently have received your request.</h2>"
	                +"<h2>Click on the link below to get the temporary password.</h2>"
	                +"<h3><a href=\"http://localhost:8080/managementSystem/forgotpassword?id="+email+"&hashcode="+hassCode+"\">Link</a></h3>";
			try {
				GmailSender.send(email, subjectEmail, bodyEmail, true);
			} catch (MessagingException e) {
				e.printStackTrace();
			}
			out.println("System sent a link to your email.");
		}
		else{
			out.println("Your email is not exist.");
		}
		
	}

}
