package controller;

import java.io.IOException;
import java.util.Date;

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
public class AddTraineeController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AddTraineeController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		if (CurrentUser.checkLogin(request, response) ) {
			if (CurrentUser.getUserCurrent(request, response).getRoleId() == 3) {

				RequestDispatcher rd = request.getRequestDispatcher("/admin/trainees/addTrainee.jsp");
				rd.forward(request, response);
			} else {
				response.sendRedirect(request.getContextPath() + "/badrequest");
				return;
			}
		} else {
			return;
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		try {

			System.out.println(request.getParameter("dateOfBirth"));
			User trainee = new User(0, request.getParameter("username").trim(), request.getParameter("password").trim(), request.getParameter("fullname").trim(),
								FormatDateLibrary.ConvertStringToDateSQL(request.getParameter("dateOfBirth").trim()), request.getParameter("email").trim(), 
								FormatDateLibrary.ConvertDateUntilToDateSQL(new Date()), 2, Integer.parseInt(request.getParameter("gender").trim()), 
								request.getParameter("address").trim(), request.getParameter("phone").trim(), "", "");

			UserBo userBo = new UserBo();

			if (userBo.checkUsernameAlreadyExists(request.getParameter("username"))) {

				request.setAttribute("trainee", trainee);
				request.setAttribute("error", " This username has already existed in the system");
				RequestDispatcher rd = request.getRequestDispatcher("/admin/trainees/addTrainee.jsp");
				rd.forward(request, response);

			} else if (userBo.checkEmailAlreadyExists(request.getParameter("email"))) {

				request.setAttribute("trainee", trainee);
				request.setAttribute("error", " This email has already existed in the system");
				RequestDispatcher rd = request.getRequestDispatcher("/admin/trainees/addTrainee.jsp");
				rd.forward(request, response);

			} else {
				if (userBo.checkTraineeInformation(request.getParameter("username"), request.getParameter("password"), request.getParameter("fullname"), 
						request.getParameter("dateOfBirth"), request.getParameter("email"), request.getParameter("address"), request.getParameter("phone")) == false) {

					request.setAttribute("error", " Please complete all information");
					request.setAttribute("trainee", trainee);
					RequestDispatcher rd = request.getRequestDispatcher("/admin/trainees/addTrainee.jsp");
					rd.forward(request, response);

				} else if (userBo.checkAddTraineeAvatar(request.getPart("avatar"), request) == 0) {

					trainee.setAvatar("default.jpg");

				} else if (userBo.checkAddTraineeAvatar(request.getPart("avatar"), request) == 1) {

					request.setAttribute("trainee", trainee);
					request.setAttribute("error", " Please add file jpg, png, gif");
					RequestDispatcher rd = request.getRequestDispatcher("/admin/trainees/addTrainee.jsp");
					rd.forward(request, response);

				} else if (userBo.checkAddTraineeAvatar(request.getPart("avatar"), request) == 2) {

					trainee.setAvatar(userBo.addTraineeAvatar(request.getPart("avatar"), request));
				}

				trainee.setPassword(MD5Library.md5(trainee.getPassword()));

				if (userBo.addTrainee(trainee) > 0) {
					response.sendRedirect(request.getContextPath() + "/trainee/index?msg=1");
				} else {
					request.setAttribute("trainee", trainee);
					request.setAttribute("error", " Can't add trainee. please try again");
					RequestDispatcher rd = request.getRequestDispatcher("/admin/trainees/addTrainee.jsp");
					rd.forward(request, response);
				}

			}
		} catch(Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect(request.getContextPath() + "/badrequest");
			return;
		}
	}

}