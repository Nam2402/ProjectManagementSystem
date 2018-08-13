package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import libralies.CurrentUser;
import libralies.FormatDateLibrary;
import libralies.MD5Library;
import model.bean.User;
import model.bo.UserBo;

@MultipartConfig
public class EditTraineeController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	public EditTraineeController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		try {
			if (CurrentUser.checkLogin(request, response) ) {
				UserBo userBo = new UserBo();
				int traineeId = Integer.parseInt(request.getParameter("id"));
				
				if (CurrentUser.getUserCurrent(request, response).getRoleId() == 3 || CurrentUser.getUserCurrent(request, response).getUserId() == traineeId) {

					request.setAttribute("trainee", userBo.getTraineeById(traineeId));
					RequestDispatcher rd = request.getRequestDispatcher("/admin/trainees/edit.jsp");
					rd.forward(request, response);
					
				} else {
					response.sendRedirect(request.getContextPath() + "/badrequest");
					return;
				}
			} else {
				return;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect(request.getContextPath() + "/badrequest");
			return;
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		try {
			UserBo userBo = new UserBo();
			User trainee = userBo.getTraineeById(Integer.parseInt(request.getParameter("id")));
			trainee.setUsername(request.getParameter("username").trim());
			trainee.setFullname(request.getParameter("fullname").trim());
			trainee.setAddress(request.getParameter("address").trim());
			trainee.setGender(Integer.parseInt(request.getParameter("gender")));
			trainee.setPhone(request.getParameter("phone").trim());
			trainee.setDateOfBirth(FormatDateLibrary.ConvertStringToDateSQL(request.getParameter("dateOfBirth")));

			if (!"".equals(request.getParameter("oldpass"))) {
				if (trainee.getPassword().equals(MD5Library.md5(request.getParameter("oldpass")))) {

					String newpass = request.getParameter("newpass");
					String confimpass = request.getParameter("confirmpass");
					if (newpass.equals(confimpass)) {
						trainee.setPassword(MD5Library.md5(request.getParameter("oldpass")));
					} else {

						request.setAttribute("trainee", trainee);
						request.setAttribute("error", " Two new password not the same");
						RequestDispatcher rd = request.getRequestDispatcher("/admin/trainees/edit.jsp");
						rd.forward(request, response);
					}
				} else {

					request.setAttribute("trainee", trainee);
					request.setAttribute("error", " Your password is not correct");
					RequestDispatcher rd = request.getRequestDispatcher("/admin/trainees/edit.jsp");
					rd.forward(request, response);
				}
			}

			if (userBo.checkUsernameAlreadyExistsEdit(request.getParameter("username"), trainee.getUserId())) {

				request.setAttribute("trainee", trainee);
				request.setAttribute("error", " This username is already exists in system");
				RequestDispatcher rd = request.getRequestDispatcher("/admin/trainees/edit.jsp");
				rd.forward(request, response);

			} else if (userBo.checkTraineeInformation(request.getParameter("username"), trainee.getPassword(), request.getParameter("fullname"), request.getParameter("dateOfBirth"),
						trainee.getEmail(), request.getParameter("address"), request.getParameter("phone")) == false) {

				request.setAttribute("error", " Please complete all information");
				request.setAttribute("trainee", trainee);
				RequestDispatcher rd = request.getRequestDispatcher("/admin/trainees/edit.jsp");
				rd.forward(request, response);

			} else if (userBo.checkAddTraineeAvatar(request.getPart("avatar"), request) == 0) {

			} else if (userBo.checkAddTraineeAvatar(request.getPart("avatar"), request) == 1) {

				request.setAttribute("trainee", trainee);
				request.setAttribute("error", " Please add file jpg, png, gif");
				RequestDispatcher rd = request.getRequestDispatcher("/admin/trainees/edit.jsp");
				rd.forward(request, response);

			} else if (userBo.checkAddTraineeAvatar(request.getPart("avatar"), request) == 2) {
				if(userBo.deleteAvatarOfuser(trainee.getAvatar(), request)) {
					
				}

				trainee.setAvatar(userBo.addTraineeAvatar(request.getPart("avatar"), request));
			}

			if (userBo.editTrainee(trainee) > 0) {
				if (CurrentUser.getUserCurrent(request, response).getUserId() == trainee.getUserId()) {
					response.sendRedirect(request.getContextPath() + "/trainee/edit?id=" + trainee.getUserId());
					return;
				} else {

					response.sendRedirect(request.getContextPath() + "/trainee/index?msg=2");
					return;
				}
			} else {
				request.setAttribute("trainee", trainee);
				request.setAttribute("error", " Can't edit trainee. please try again later");
				RequestDispatcher rd = request.getRequestDispatcher("/admin/trainees/edit.jsp");
				rd.forward(request, response);
			}
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect(request.getContextPath()  + "/badrequest");
			return;
		}
	}

}