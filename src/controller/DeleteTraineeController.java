package controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import libralies.CurrentUser;
import model.bean.Roles;
import model.bean.User;
import model.bo.RoleBo;
import model.bo.UserBo;

public class DeleteTraineeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public DeleteTraineeController() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		if (CurrentUser.checkLogin(request, response) ) {
			if (CurrentUser.getUserCurrent(request, response).getRoleId() == 3) {

				try {
					UserBo userBo = new UserBo();
					
					int traineeId = 0;
					if(request.getParameter("id") != null) {
						traineeId = Integer.parseInt(request.getParameter("id"));
					}
					User trainee = userBo.getTraineeById(traineeId);
					String fileName = trainee.getAvatar();
					if (userBo.deleteAvatarOfuser(fileName, request)) {
					
						if ( userBo.deleteTrainee(traineeId) > 0) {
							response.sendRedirect( request.getContextPath() + "/trainee/index?msg=3");
							return;
						} else {
							response.sendRedirect( request.getContextPath() + "/trainee/index?msg=0");
							return;
						}
					} else {
						response.sendRedirect( request.getContextPath() + "/trainee/index?msg=0");
						return;
					}
				} catch (Exception e) {
					System.out.println(e.getMessage());
					response.sendRedirect(request.getContextPath() + "/badrequest");
					return;
				}
				
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
			UserBo userBo = new UserBo();
			RoleBo roleBo = new RoleBo();
			
			ArrayList<Roles> roles = roleBo.getRoles();
			int traineeRoleId = 0;
			for (Roles roles2 : roles) {
				if("trainee".equalsIgnoreCase(roles2.getName())) {
					traineeRoleId = roles2.getRoleId();
				}
			}
			
			int result = 0;
			ArrayList<User> trainees = userBo.getTrainees(traineeRoleId);
			for (User user : trainees) {
				if ( request.getParameter("trainee" + user.getUserId()) != null) {   
					if (userBo.deleteAvatarOfuser(user.getAvatar(), request)) {
						if ( userBo.deleteTrainee(user.getUserId()) > 0) {
							result++;
						}
					}
				}
			}
			
			if (result > 0) {
				response.sendRedirect( request.getContextPath() + "/trainee/index?msg=4");
				return;
			} else {
				response.sendRedirect( request.getContextPath() + "/trainee/index?msg=0");
				return;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect(request.getContextPath() + "/badrequest");
			return;
		}
	}

}
