package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.User;
import model.bo.UserBo;


public class IndexTrainerController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		UserBo userBo= new UserBo();
		List<User> trainers= userBo.getUsersByRoleId(1);
		request.setAttribute("trainers", trainers);
		request.getRequestDispatcher("/admin/training_manager/list_trainer_account.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int trainerId = Integer.parseInt(request.getParameter("trainerId"));
			int status = 1 - Integer.parseInt(request.getParameter("status"));
			
			UserBo userBo = new UserBo();

			PrintWriter out = response.getWriter();
			if (userBo.changeStatusTrainee(trainerId, status) > 0 && status == 1) {
				out.println("<a href='javascript:void(0)' onclick='changeStatus(" + trainerId + ", 1);'><img alt='' src='" + request.getContextPath() + "/templates/images/active.gif'></a>");
			} else if  (userBo.changeStatusTrainee(trainerId, status) > 0 && status == 0) {
				out.println("<a href='javascript:void(0)' onclick='changeStatus(" + trainerId + ", 0);'><img alt='' src='" + request.getContextPath() + "/templates/images/deactive.gif'></a>");
			}
		} catch( Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect(request.getContextPath() + "/trainer/index?msg=0");
			return;
		}
	}

}