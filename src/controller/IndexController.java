package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import libralies.CurrentUser;


public class IndexController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public IndexController() {
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(CurrentUser.checkLogin(request, response) == true) {
			
			if ( CurrentUser.getUserCurrent(request, response).getRoleId() == 3 ) {
				response.sendRedirect(request.getContextPath() + "/trainee/index");
				return;
			} else if ( CurrentUser.getUserCurrent(request, response).getRoleId() == 2 ) {

				response.sendRedirect(request.getContextPath() + "/trainee/edit?id=" + CurrentUser.getUserCurrent(request, response).getUserId());
				return;
			} else {

				response.sendRedirect(request.getContextPath() + "/trainer/edit?id=" + CurrentUser.getUserCurrent(request, response).getUserId());
				return;
			}
		}else {
			return;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
