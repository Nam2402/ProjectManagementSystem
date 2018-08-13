package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.bean.User;


public class LogoutController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		if( user == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		} else {
			session.removeAttribute("user");
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
	}


}
