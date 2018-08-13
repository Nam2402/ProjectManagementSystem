package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import libralies.MD5Library;
import model.bean.User;
import model.bo.UserBo;

public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			HttpSession session = request.getSession();
			User user= (User) session.getAttribute("user");
			
			if (user == null) {
					RequestDispatcher rd = request.getRequestDispatcher("/admin/auth/login1.jsp");
					rd.forward(request, response);
			}
			else{
				if(user.getRoleId()==1){
					response.sendRedirect(request.getContextPath()+"/trainer/edit?id="+user.getUserId());	
				}
				if(user.getRoleId()==2){
					response.sendRedirect(request.getContextPath()+"/trainee/edit?id="+user.getUserId());	
				}
				if(user.getRoleId()==3){
					response.sendRedirect(request.getContextPath()+"/trainee/index");
				}
			}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserBo userBo= new UserBo();
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();

		String email =  request.getParameter("email").trim();
		User user= userBo.getUserByEmail(email);
		if(user.getUserId() ==  0){
			out.println("1");
		}
		else if(user.getStatus() == 0){
			out.println("2");
		}
		else{
			String pass =  MD5Library.md5(request.getParameter("password"));	
			
			if(pass.equals(user.getPassword())) {	
				session.setAttribute("user", user);
				if(user.getRoleId()==1){
					out.println(request.getContextPath()+"/trainer/edit?id="+user.getUserId());
				}
				if(user.getRoleId()==2){
					out.println(request.getContextPath()+"/trainee/edit?id="+user.getUserId());
				}
				if(user.getRoleId()==3){
					out.println(request.getContextPath()+"/trainee/index");
				}
				
			}
			else{
				out.println("3");
				
			}
			
		}
		
		
	}

}
