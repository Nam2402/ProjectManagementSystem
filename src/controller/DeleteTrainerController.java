package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import libralies.CurrentUser;
import model.bean.Roles;
import model.bean.User;
import model.bo.RoleBo;
import model.bo.UserBo;


public class DeleteTrainerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (CurrentUser.checkLogin(request, response) ) {
			if (CurrentUser.getUserCurrent(request, response).getRoleId() == 3) {
				try {
					UserBo userBo = new UserBo();
					
					int trainerId = 0;
					if(request.getParameter("id") != null) {
						trainerId = Integer.parseInt(request.getParameter("id"));
					}
					User trainer = userBo.getTrainerById(trainerId);
					String fileName = trainer.getAvatar();
					if (userBo.deleteAvatarOfuser(fileName, request)) {
					
						if ( userBo.deleteTrainee(trainerId) > 0) {
							response.sendRedirect( request.getContextPath() + "/trainer/index?msg=3");
							return;
						} else {
							response.sendRedirect( request.getContextPath() + "/trainer/index?msg=0");
							return;
						}
					} else {
						response.sendRedirect( request.getContextPath() + "/trainer/index?msg=0");
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
			
			List<Roles> roles = roleBo.getRoles();
			int trainerRoleId = 0;
			for (Roles role: roles) {
				if("trainer".equalsIgnoreCase(role.getName())) {
					trainerRoleId = role.getRoleId();
				}
			}
			
			int result = 0;
			List<User> trainers = userBo.getUsersByRoleId(trainerRoleId);
			for (User user : trainers) {
				if ( request.getParameter("trainer" + user.getUserId()) != null) {   
					if (userBo.deleteAvatarOfuser(user.getAvatar(), request)) {
						if ( userBo.deleteTrainee(user.getUserId()) > 0) {
							result++;
						}
					}
				}
			}
			
			if (result > 0) {
				response.sendRedirect( request.getContextPath() + "/trainer/index?msg=4");
				return;
			} else {
				response.sendRedirect( request.getContextPath() + "/trainer/index?msg=0");
				return;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect(request.getContextPath() + "/badrequest");
			return;
		}
	}

}
