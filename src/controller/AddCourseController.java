package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import libralies.CurrentUser;
import model.bean.Courses;
import model.bean.User;
import model.bo.CourseBo;
import model.bo.MajorBo;


public class AddCourseController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCourseController() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (CurrentUser.checkLogin(request, response)) {
			User user = CurrentUser.getUserCurrent(request, response);
			if (user.getRoleId() == 3) {
				response.sendRedirect(request.getContextPath() + "/course/index");
				return;
				
			}  else {
				response.sendRedirect(request.getContextPath() + "/badrequest");
				return;
			}
		} else {
			return;
		}
				
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			CourseBo courseBo = new CourseBo();
			String message = "";
			
			Courses course = new Courses(0, Integer.parseInt(request.getParameter("major").trim()), request.getParameter("name").trim(), Integer.parseInt(request.getParameter("duration")), 1, 
										Integer.parseInt(request.getParameter("kindOfCourse")) );
		
			if ( courseBo.checkValidateCourse(request.getParameter("name"), request.getParameter("major"), request.getParameter("duration"), request.getParameter("kindOfCourse")) == false) {

				response.sendRedirect(request.getContextPath() + "/course/index?msg=7");
				return;
				
			} else if (courseBo.checkCourseAlreadyExists(request.getParameter("name")) == true) {

				response.sendRedirect(request.getContextPath() + "/course/index?msg=6");
				return;
				
			} else {
				
				if ( courseBo.addCourse(course) > 0) {
					
					response.sendRedirect(request.getContextPath() + "/course/index?msg=1");
					return;
					
				} else {
					response.sendRedirect(request.getContextPath() + "/course/index?msg=0");
					return;
				}
			}
		
		} catch( Exception e) {
			System.out.println(e.getMessage());
			response.sendRedirect(request.getContextPath() + "/badrequest");
			return;
		}
	}
	
}
