package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import libralies.CurrentUser;
import model.bean.ClassWaiting;
import model.bean.User;
import model.bo.UserBo;

@WebServlet("/trainee/list/classwaitstart")
public class ListClassWaitingStartOfTrainingController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (CurrentUser.checkLogin(request, response)) {
			User user = CurrentUser.getUserCurrent(request, response);
			if (user.getRoleId() == 2) {
				
				UserBo userBo = new UserBo();
				ArrayList<ClassWaiting> list = userBo.getClassWaitingStartOfTrainee(user.getUserId());
				request.setAttribute("list", list);				
				RequestDispatcher rd = request.getRequestDispatcher("/admin/trainees/classwaitstart.jsp");
				rd.forward(request, response);
				
			}  else {
				response.sendRedirect(request.getContextPath() + "/badrequest");
				return;
			}
		} else {
			return;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
