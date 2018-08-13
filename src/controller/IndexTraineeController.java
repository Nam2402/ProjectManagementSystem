package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import libralies.CurrentUser;
import model.bean.Roles;
import model.bean.User;
import model.bo.RoleBo;
import model.bo.UserBo;

public class IndexTraineeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public IndexTraineeController() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if (CurrentUser.checkLogin(request, response) ) {
			if (CurrentUser.getUserCurrent(request, response).getRoleId() == 3) {

				UserBo userBo = new UserBo();
				RoleBo roleBo = new RoleBo();
				
				ArrayList<Roles> roles = roleBo.getRoles();
				int traineeRoleId = 0;
				for (Roles roles2 : roles) {
					if("trainee".equalsIgnoreCase(roles2.getName())) {
						traineeRoleId = roles2.getRoleId();
					}
				}

				request.setAttribute("trainees", userBo.getTrainees(traineeRoleId));
				RequestDispatcher rd = request.getRequestDispatcher("/admin/trainees/index.jsp");
				rd.forward(request, response);
				
			} else {
				response.sendRedirect(request.getContextPath() + "/badrequest");
				return;
			}
		} else {
			return;
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int traineeId = Integer.parseInt(request.getParameter("traineeId"));
			int status = 1 - Integer.parseInt(request.getParameter("status"));
			
			UserBo userBo = new UserBo();

			PrintWriter out = response.getWriter();
			if (userBo.changeStatusTrainee(traineeId, status) > 0 && status == 1) {
				out.println("<a href='javascript:void(0)' onclick='changeStatus(" + traineeId + ", 1);'><img alt='' src='" + request.getContextPath() + "/templates/images/active.gif'></a>");
			} else if  (userBo.changeStatusTrainee(traineeId, status) > 0 && status == 0) {
				out.println("<a href='javascript:void(0)' onclick='changeStatus(" + traineeId + ", 0);'><img alt='' src='" + request.getContextPath() + "/templates/images/deactive.gif'></a>");
			}
		} catch( Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect(request.getContextPath() + "/trainee/index?msg=0");
			return;
		}
	}

}
